"                                _           
"        _ __ ___  _   _  __   _(_)_ __ ___  
"       | '_ ` _ \| | | | \ \ / / | '_ ` _ \ 
"       | | | | | | |_| |  \ V /| | | | | | |
"       |_| |_| |_|\__, |   \_/ |_|_| |_| |_|
"                   |___/                     


"===
"=== auto back to last cursorline
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


"===
"=== common set
set nocompatible

let mapleader=","

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

syntax enable
syntax on

set t_Co=256

"set cmdheight=2

set showcmd

set wrap

set number

set relativenumber

set cursorline

set virtualedit=block,onemore

set ruler

set autoindent

set cindent

"set cinoptions=g0,:0,N-s,(0

set smartindent

set expandtab

set tabstop=4

set shiftwidth=4

set softtabstop=4

set smarttab

set backspace=2

set wildmenu

set completeopt-=preview

set foldmethod=syntax

set autoread

set autowrite

set foldmethod=indent
set foldlevel=99

set scrolloff=5

set ignorecase
set smartcase

" set colorcolumn=90


"=== 
"=== key map
inoremap jj <esc>

nnoremap <leader>e :e ~/.vim/vimrc<cr>

nnoremap <leader>r :source $MYVIMRC<cr>

nnoremap Q :q<cr>

nnoremap W :w<cr>

nnoremap S :x<cr>

nnoremap H 5h<cr>
nnoremap J 5j<cr>
nnoremap K 5k<cr>
nnoremap L 5l<cr>

nnoremap < <<
nnoremap > >>

nnoremap <slient> <leader>] za

nnoremap <leader>w <C-w>w
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>c <C-w>o

nnoremap su :set nosplitbelow<cr>:split<cr>:set splitbelow<cr>
nnoremap sd :set splitbelow<cr>:split<cr>
nnoremap sr :set nosplitright<cr>:vsplit<cr>:set splitright<cr>
nnoremap sl :set splitright<cr>:vsplit<cr>

noremap <up> :res +5<cr>
noremap <down> :res -5<cr>
noremap <left> :vertical resize-5<cr>
noremap <right> :vertical resize+5<cr>

noremap tu :tabe<cr>
noremap tU :tab split<cr>

noremap tn :-tabnext<cr>
noremap tN :+tabnext<cr>

noremap tmn :-tabmove<cr>
noremap tmN :+tabmove<cr>


"===
"===
"=== vim-plug

"===
"=== Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

"===
"===
"===  Install  plug
call plug#begin('~/.vim/plugged')
"===
"=== lanuageless plug
" snazzy color scheme
Plug 'connorholyday/vim-snazzy'
" vim-airline
Plug 'vim-airline/vim-airline'

" vim-airline themes
Plug 'vim-airline/vim-airline-themes'

" nerdtree
Plug 'preservim/nerdtree'

" nerdtree git plug
Plug 'Xuyuanp/nerdtree-git-plugin'

" vim auto pair
Plug 'jiangmiao/auto-pairs'

" rainbow
Plug 'luochen1990/rainbow'

" syntastic
Plug 'vim-syntastic/syntastic'

" coc.vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"===
"=== language plug

"===
"=== markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

call plug#end()


"===
"===
"=== plug settings

"===
"=== set color theme
let g:SnazzyTransparent = 1
colorscheme snazzy

"===
"=== airline
let g:airline_theme='base16_spacemacs'

"===
"=== nerdtree
map <leader>n :NERDTreeToggle<cr>

"===
"=== rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

"===
"=== syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"===
"===  coc.vim
" TextEdit might fail if hidden is not set.
let g:coc_global_extensions = [
    \'coc-json',
    \'coc-pyright',
    \'coc-yaml']

set hidden
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-o> coc#refresh()
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Use K to show documentation in preview window.
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"===
"=== markdown preview
let g:mkdp_browser = 'chromium'
