function toggle_quotes()
    local line = vim.fn.getline(".")
    local col = vim.fn.col(".")
    local first = nil;
    local quotes = "\"'`"

    local found,_ = string.find(quotes,string.sub(line,col,col),1,true)
    if found then
        return
    end

    for i = col-1,1,-1
    do
        found,_ = string.find(quotes,string.sub(line,i,i),1,true) 
        if found then
            first = i
            break
        end
    end

    if first == nil or found == nil then 
        return
    end

    local second = nil

    for i = col+1,string.len(line)-1,1
    do
        if string.find(quotes:sub(found,found),string.sub(line,i,i),1,true) then
            second = i
            break
        end
    end 

    if second == nil then
        return
    end
    
    local index = (found+1)%3+1
    local txt = line:sub(1,first-1)..quotes:sub(index,index)..line:sub(first+1,second-1)..quotes:sub(index,index)..line:sub(second+1,line:len())
    vim.api.nvim_set_current_line(txt)

end

vim.api.nvim_set_keymap('n', "<leader>q", [[:lua toggle_quotes()<CR>]], {silent=true})
