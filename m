Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419mDq0V6PzF0l6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 23:40:41 +1000 (AEST)
Subject: Re: [PATCH v2 3/3] powerpc: Remove -Wattribute-alias pragmas
To: Paul Burton <paul.burton@mips.com>, linux-kbuild@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-mips@linux-mips.org,
 Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Matthew Wilcox <matthew@wil.cx>, Thomas Gleixner <tglx@linutronix.de>,
 Douglas Anderson <dianders@chromium.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthias Kaehlcke <mka@chromium.org>, He Zhe <zhe.he@windriver.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michal Marek <michal.lkml@markovi.net>, Khem Raj <raj.khem@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Gideon Israel Dsouza <gidisrael@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Kees Cook <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180619190225.7eguhiw3ixaiwpgl@pburton-laptop>
 <20180619201458.4559-1-paul.burton@mips.com>
 <20180619201458.4559-4-paul.burton@mips.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <ba484232-7b59-05b2-34a9-2d66d43ff382@c-s.fr>
Date: Wed, 20 Jun 2018 15:40:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180619201458.4559-4-paul.burton@mips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/06/2018 à 22:14, Paul Burton a écrit :
> With SYSCALL_DEFINEx() disabling -Wattribute-alias generically, there's
> no need to duplicate that for PowerPC syscalls.
> 
> This reverts commit 415520373975 ("powerpc: fix build failure by
> disabling attribute-alias warning in pci_32") and commit 2479bfc9bc60
> ("powerpc: Fix build by disabling attribute-alias warning for
> SYSCALL_DEFINEx").
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Matthew Wilcox <matthew@wil.cx>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Gideon Israel Dsouza <gidisrael@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Khem Raj <raj.khem@gmail.com>
> Cc: He Zhe <zhe.he@windriver.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> 
> ---
> Michael & Christophe, I didn't add your acks here yet since it changed
> to include the second revert that Christophe pointed out I'd missed & I
> didn't want to presume your acks extended to that.

Looks ok to me

Acked-by: Christophe Leroy <christophe.leroy@c-s.fr>

> 
> Changes in v2:
> - Also revert 2479bfc9bc60 ("powerpc: Fix build by disabling
>    attribute-alias warning for SYSCALL_DEFINEx").
> - Change subject now that it's not just a simple one-commit revert.
> 
>   arch/powerpc/kernel/pci_32.c    | 4 ----
>   arch/powerpc/kernel/pci_64.c    | 4 ----
>   arch/powerpc/kernel/rtas.c      | 4 ----
>   arch/powerpc/kernel/signal_32.c | 8 --------
>   arch/powerpc/kernel/signal_64.c | 4 ----
>   arch/powerpc/kernel/syscalls.c  | 4 ----
>   arch/powerpc/mm/subpage-prot.c  | 4 ----
>   7 files changed, 32 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> index 4f861055a852..d63b488d34d7 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -285,9 +285,6 @@ pci_bus_to_hose(int bus)
>    * Note that the returned IO or memory base is a physical address
>    */
>   
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wpragmas"
> -#pragma GCC diagnostic ignored "-Wattribute-alias"
>   SYSCALL_DEFINE3(pciconfig_iobase, long, which,
>   		unsigned long, bus, unsigned long, devfn)
>   {
> @@ -313,4 +310,3 @@ SYSCALL_DEFINE3(pciconfig_iobase, long, which,
>   
>   	return result;
>   }
> -#pragma GCC diagnostic pop
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 812171c09f42..dff28f903512 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -203,9 +203,6 @@ void pcibios_setup_phb_io_space(struct pci_controller *hose)
>   #define IOBASE_ISA_IO		3
>   #define IOBASE_ISA_MEM		4
>   
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wpragmas"
> -#pragma GCC diagnostic ignored "-Wattribute-alias"
>   SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, in_bus,
>   			  unsigned long, in_devfn)
>   {
> @@ -259,7 +256,6 @@ SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, in_bus,
>   
>   	return -EOPNOTSUPP;
>   }
> -#pragma GCC diagnostic pop
>   
>   #ifdef CONFIG_NUMA
>   int pcibus_to_node(struct pci_bus *bus)
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 7fb9f83dcde8..8afd146bc9c7 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -1051,9 +1051,6 @@ struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
>   }
>   
>   /* We assume to be passed big endian arguments */
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wpragmas"
> -#pragma GCC diagnostic ignored "-Wattribute-alias"
>   SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
>   {
>   	struct rtas_args args;
> @@ -1140,7 +1137,6 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
>   
>   	return 0;
>   }
> -#pragma GCC diagnostic pop
>   
>   /*
>    * Call early during boot, before mem init, to retrieve the RTAS
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> index 5eedbb282d42..e6474a45cef5 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -1038,9 +1038,6 @@ static int do_setcontext_tm(struct ucontext __user *ucp,
>   }
>   #endif
>   
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wpragmas"
> -#pragma GCC diagnostic ignored "-Wattribute-alias"
>   #ifdef CONFIG_PPC64
>   COMPAT_SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>   		       struct ucontext __user *, new_ctx, int, ctx_size)
> @@ -1134,7 +1131,6 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>   	set_thread_flag(TIF_RESTOREALL);
>   	return 0;
>   }
> -#pragma GCC diagnostic pop
>   
>   #ifdef CONFIG_PPC64
>   COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
> @@ -1231,9 +1227,6 @@ SYSCALL_DEFINE0(rt_sigreturn)
>   	return 0;
>   }
>   
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wpragmas"
> -#pragma GCC diagnostic ignored "-Wattribute-alias"
>   #ifdef CONFIG_PPC32
>   SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
>   			 int, ndbg, struct sig_dbg_op __user *, dbg)
> @@ -1337,7 +1330,6 @@ SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
>   	return 0;
>   }
>   #endif
> -#pragma GCC diagnostic pop
>   
>   /*
>    * OK, we're invoking a handler
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index d42b60020389..83d51bf586c7 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -625,9 +625,6 @@ static long setup_trampoline(unsigned int syscall, unsigned int __user *tramp)
>   /*
>    * Handle {get,set,swap}_context operations
>    */
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wpragmas"
> -#pragma GCC diagnostic ignored "-Wattribute-alias"
>   SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>   		struct ucontext __user *, new_ctx, long, ctx_size)
>   {
> @@ -693,7 +690,6 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
>   	set_thread_flag(TIF_RESTOREALL);
>   	return 0;
>   }
> -#pragma GCC diagnostic pop
>   
>   
>   /*
> diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
> index 083fa06962fd..466216506eb2 100644
> --- a/arch/powerpc/kernel/syscalls.c
> +++ b/arch/powerpc/kernel/syscalls.c
> @@ -62,9 +62,6 @@ static inline long do_mmap2(unsigned long addr, size_t len,
>   	return ret;
>   }
>   
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wpragmas"
> -#pragma GCC diagnostic ignored "-Wattribute-alias"
>   SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
>   		unsigned long, prot, unsigned long, flags,
>   		unsigned long, fd, unsigned long, pgoff)
> @@ -78,7 +75,6 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
>   {
>   	return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT);
>   }
> -#pragma GCC diagnostic pop
>   
>   #ifdef CONFIG_PPC32
>   /*
> diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
> index 75cb646a79c3..9d16ee251fc0 100644
> --- a/arch/powerpc/mm/subpage-prot.c
> +++ b/arch/powerpc/mm/subpage-prot.c
> @@ -186,9 +186,6 @@ static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
>    * in a 2-bit field won't allow writes to a page that is otherwise
>    * write-protected.
>    */
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wpragmas"
> -#pragma GCC diagnostic ignored "-Wattribute-alias"
>   SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
>   		unsigned long, len, u32 __user *, map)
>   {
> @@ -272,4 +269,3 @@ SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
>   	up_write(&mm->mmap_sem);
>   	return err;
>   }
> -#pragma GCC diagnostic pop
> 
