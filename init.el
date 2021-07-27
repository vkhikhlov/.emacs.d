(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(tool-bar-mode -1)
(menu-bar-mode -1)

(desktop-save-mode 1)
(display-time-mode 1)
(blink-cursor-mode 0)
(column-number-mode t)
(load-theme 'tsdh-light)
(global-display-line-numbers-mode)

(setq display-time-24hr-format t)
(setq tab-always-indent 'complete)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

(use-package move-text
  :ensure t
  :init
  (move-text-default-bindings))

(use-package treemacs
  :ensure t
  :config
  (add-hook 'window-setup-hook #'treemacs 'append))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode +1)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode))

(use-package reverse-im
  :ensure t
  :custom
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode t))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package haskell-mode
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook (
         (haskell-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-haskell
  :ensure t
  :config
  (setq lsp-haskell-server-path "haskell-language-server-wrapper")
  (setq lsp-haskell-server-args ())
  (setq lsp-log-io t))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.5)
  (setq company-show-numbers t)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

