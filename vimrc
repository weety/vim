set nocompatible               " be iMproved
filetype off                   " required!       /**  从这行开始，vimrc配置 **/

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" My priv plugin
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/tagbar'
Plug 'vim-scripts/OmniCppComplete'
Plug 'vim-scripts/autoload_cscope.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/winmanager'
Plug 'vim-scripts/bufexplorer.zip'

" Initialize plugin system
call plug#end()


" ******************************************************
" my vim configure
" ******************************************************
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=gb18030,ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" 设置TAB属性
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

set incsearch
set number
" ctags
set tags=tags;
set autochdir
nmap <c-]> g<c-]>       " 当有多条匹配时，自动弹出多条选项选择，而不是直接跳转到地一个符号处
"符号高亮
syntax enable
syntax on
" 配色
colorscheme torte
if has("gui_running")
  colorscheme torte
  set lines=30
  set columns=100
  highlight CursorLine term=underline cterm=underline guibg=Grey10 "在文件末尾添加才有效
endif
set guifont=Monospace\ 11 "在字体名后的反斜杠下加个空格，再加字体大小
"set lines=30
"set columns=100
"highlight CursorLine term=underline cterm=underline guibg=Grey10 "在文件末尾添加才有效
set cursorline
":autocmd  BufEnter  *  call  DoWordComplete()	"word_complete

" airline配置
" 总是显示状态栏 
let laststatus = 2
let g:airline_powerline_fonts = 1   " 使用powerline打过补丁的字体
let g:airline_theme="dark"      " 设置主题
" 开启tabline
let g:airline#extensions#tabline#enabled = 1      "tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ' '   "tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '|'      "tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1

" Winmanager配置
let g:NERDTree_title="[NERDTree]"
let g:winManagerWindowLayout="FileExplorer,BufExplorer|TagList"
function! NERDTree_Start()
	exec 'NERDTree'
endfunction

function! NERDTree_IsValid()
	return 1
endfunction

"设置winmanager的宽度，默认为25
let g:winManagerWidth = 30
"定义打开关闭winmanager按键
nmap <silent> <F8> :WMToggle<cr>

" Taglist设置
" 不同是显示多个文件的tag,只显示当前文件的
let Tlist_Show_One_File=1
" 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Exit_OnlyWindow=1
" 让当前不被编辑的文件的方法列表自动折叠起来
let Tlist_File_Fold_Auto_Close=1

"mniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
filetype plugin indent on	"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=menuone,menu,longest,preview


" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
if has("gui_running")
  colorscheme torte
  set lines=30
  set columns=100
  highlight CursorLine term=underline cterm=underline guibg=Grey10 "在文件末尾添加才有效
endif
