HOME = os.getenv("HOME")

vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
]])

vim.o.encoding = "utf-8" -- self-explanatory
vim.o.textwidth = 80     -- where to wrap
vim.o.shortmess = "at"   -- abbreviate and truncate file messages
vim.o.showmatch = true   -- briefly flash to the matching element

vim.o.visualbell = true  -- disable the beep
vim.o.autoread = true    -- if a file changes externally, update buffer

-- address the tabs-vs-spaces debate ...
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true

-- interface configuration
vim.o.cmdheight = 2   -- command line two lines high
vim.o.laststatus = 2
vim.o.ruler = true    -- show line # info, etc.
vim.o.showmode = true -- show the mode in the status line
vim.o.showcmd = true  -- show selection info

vim.o.termguicolors = true
vim.o.background = "dark" 
vim.g.solarized_italics = 0 

-- vim.o.comments = b:#,:%,n:>,fb:[-],fb:- -- see, help: comments
-- folding settings
-- vim.o.foldmethod = syntax      " fold on syntax, always
vim.o.foldcolumn = "0"      -- 2 lines of column for fold showing, always
vim.o.foldlevelstart = 3    -- expand folds at start

vim.o.wildmode = "longest:full"
vim.o.wildignore = "*.o,*~,.lo" -- ignore object files
vim.o.wildmenu = true  -- menu has tab completion

-- make the copy/paste operation seamless w/the OS
vim.o.clipboard = "unnamed"

-- delay before swap is written to the disk (100ms)
vim.o.updatetime = 100
vim.o.ttimeout = true 
vim.o.ttimeoutlen = 100

-- split preferences
vim.o.splitbelow = true 
vim.o.splitright = true 

-- search settings
-- ---------------------------------------------------------------------------
vim.o.incsearch = true --  incremental search
vim.o.ignorecase = true --  search ignoring case
vim.o.smartcase = true --  search w/a capital is case-sensitive
vim.o.hlsearch = true --  highlight the search

-- misc. vim support files and settings. swap, backup, etc.
vim.o.swapfile = true
vim.o.directory = HOME .. "/.vim/swap//"
vim.o.writebackup = false                 --  set for coc integration
vim.o.backup = false                      --  but do not persist backup after successful write
vim.o.backupcopy = "auto"                  --  use rename-and-write-new method whenever safe
vim.o.backupdir = HOME .. "/.vim/backup//"
vim.o.undofile = true                      --  persist the undo tree for each file
vim.o.undodir = HOME .. "/.vim/undo//"

-- mode specific settings below
-- ---------------------------------------------------------------------------

-- filetype: json 
-- disable quote concealing in json files
vim.g.vim_json_conceal=0

-- filetype: markdown 
vim.g.markdown_folding = 1
vim.g.markdown_enable_folding = 1
vim.g.markdown_fenced_languages = {'html', 'python', 'bash=sh', 'shell=sh'}

-- vim-markdown-toc elements
vim.g.vmt_dont_insert_fence = 1
vim.g.vmt_list_item_char = "-"

-- plugin settings below
-- --------------------------------------------------------------------------

-- editorconfig
vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'}

vim.g.UltiSnipsSnippetDirectories = {"UltiSnips", "custom-snippets"}


-- fancy status line.
vim.g.airline_enable_branch = 1
vim.g.airline_powerline_fonts = 1            --  requires powerline fonts
vim.g['airline#extensions#ale#enabled'] = 1  --  show ale errors on statusline
vim.g.airline_extensions = {"ale", "branch", "netrw", "virtualenv"}
vim.g.airline_theme='solarized'

-- spell check configuration
vim.o.spelllang = "en_us"
-- personal word list
-- vim.opt.spellfile = HOME .. "/iCloud/src/configs/aspell/aspell.en.pws"
vim.o.spellcapcheck = ""       -- ignore capitalization

-- diff settings
vim.o.diffopt = "filler,iwhite"     -- ignore all whitespace and sync

vim.cmd("colorscheme solarized8")
vim.o.colorcolumn = "80"
-- start: imported vimrc
vim.cmd([[

" escape alternative - insert-mode
imap kj <Esc>
" set the leader to space. this seems to have better behaviors than ','
nnoremap <SPACE> <Nop>
let mapleader=" "

" the following 2 lines are needed to make solarized happy in tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" personal abbreviations
ab x70- ----------------------------------------------------------------------
ab x70= ======================================================================

" misc. additional mappings/functions
" remove all trailing whitespace 
nnoremap <leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" send stuff to pb - internal pb destination
command! -range=% Pb :<line1>,<line2>w !curl -F c=@- pb

" this seems to cause problems when moved to lua native config
set spellfile = "~/iCloud/src/configs/aspell/aspell.en.pws"
" spell check mappings.
" note: use 'zg' to add the current word to the dictionary
" use z= to get a list of the possible spelling suggestions.
"---------------------------------------------------------------------
" spell check the buffer
noremap <silent><leader>s :set spell!<cr>
nnoremap <silent><leader>S ea<C-X><C-S>
" replace the current word with the 1st suggestion.
" this works - most of the time
nnoremap <silent><leader>r 1z=

" clear search highlights
nnoremap <leader><space> :nohlsearch<cr>


" mode specific settings below
" ---------------------------------------------------------------------------

"open markdown files in marked2
nnoremap <leader>m :silent !open -a Marked\ 2.app '%:p'<cr>

" plugin config/remappings below
" --------------------------------------------------------------------------

" editorconfig
autocmd FileType gitcommit let b:EditorConfig_disable = 1

" dash documentation - search for what the cursor is over
nmap <silent><leader>d <Plug>DashSearch


" ALE configuration
" ----------------------------------------------------------------------
" https://github.com/dense-analysis/ale - see the FAQ
" note, for the mac, i need to match on the expanded iCloud path.  this is
" what's going on in the first dict entry here. 
let g:ale_pattern_options = {
\  '.*CloudDocs/notes/.*\.md$': {'ale_enabled': 0},
\  '.*\.notes/.*\.md$': {'ale_enabled': 0},
\}

" move thru ALE errors
nmap <silent> <C-k> :ALEPrevious<cr>
nmap <silent> <C-j> :ALENext<cr>

" misc. handy remappings
nnoremap <silent><leader>l :Buffers<CR>

" import any relevant API keys, etc. 
source ~/.credentials/vim-api-keys

set runtimepath+=~/.vim/pack/default/start/vim-ultisnips
set runtimepath+=/usr/local/opt/fzf  " mac os brew installed path
set runtimepath+=~/.fzf              " we installed from git

]])

-- for vim-table-mode use markdown stule corners
vim.g.table_mode_corner='|'
vim.g.fugitive_gitlab_domains = {'https://gitlab.aristanetworks.com'}

-- end: imported vimrc

-- vim-ghost setup
vim.cmd([[
function! s:SetupGhostBuffer()
if match(expand("%:a"), '\v/ghost-(partnerissue|gitlab|github|reddit).*-')
  set ft=markdown
endif
endfunction

augroup vim-ghost
  au!
  au User vim-ghost#connected call s:SetupGhostBuffer()
augroup END
]])

if vim.fn.has("gui_running") == 1 then
  -- only turn on ghost by default in a gui
  vim.g.ghost_autostart = 1
  vim.g.ghost_darwin_app = 'VimR'
else
  vim.g.loaded_ghost = 0
end

-- workaround broken column edit behavior. specific to neovim
vim.cmd([[
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

]])
require('plugins')
