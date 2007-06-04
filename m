Return-Path: <hch@lst.de>
Date: Mon, 4 Jun 2007 09:06:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 14/21] powerpc: Make syscall restart code more common
Message-ID: <20070604070606.GA18024@lst.de>
References: <1180934134.603289.870346178920.qpush@grosgo>
	<20070604051554.2508FDDF58@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070604051554.2508FDDF58@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Christoph Hellwig <hch@lst.de>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 04, 2007 at 03:15:49PM +1000, Benjamin Herrenschmidt wrote:
> This patch moves the code in signal_32.c and signal_64.c for handling
> syscall restart into a common signal.c file and converge around a single
> implementation that is based on the 32 bits one, using trap, ccr
> and r3 rather than the special "result" field for deciding what to do.
> 
> The "result" field is now pretty much deprecated. We still set it for
> the sake of whatever might rely on it in userland but we no longer use
> it's content.
> 
> This, along with a previous patch that enables ptracers to write to
> "trap" and "orig_r3" should allow gdb to properly handle syscall
> restarting.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> This is basically my initial patch as modified by Christoph Hellwig
> (hch, care to send a SOB ? :-)


Signed-off-by: Christoph Hellwig <hch@lst.de>

> 
> 
>  arch/powerpc/kernel/Makefile    |    3 +
>  arch/powerpc/kernel/signal.c    |   64 ++++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/signal.h    |   16 ++++++++++
>  arch/powerpc/kernel/signal_32.c |   28 ++---------------
>  arch/powerpc/kernel/signal_64.c |   59 ++++--------------------------------
>  5 files changed, 93 insertions(+), 77 deletions(-)
> 
> Index: linux-cell/arch/powerpc/kernel/signal_32.c
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/signal_32.c	2007-05-30 16:45:57.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/signal_32.c	2007-06-04 11:45:43.000000000 +1000
> @@ -51,6 +51,8 @@
>  #include <asm/pgtable.h>
>  #endif
>  
> +#include "signal.h"
> +
>  #undef DEBUG_SIG
>  
>  #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
> @@ -1156,30 +1158,8 @@ int do_signal(sigset_t *oldset, struct p
>  #ifdef CONFIG_PPC32
>  no_signal:
>  #endif
> -	if (TRAP(regs) == 0x0C00		/* System Call! */
> -	    && regs->ccr & 0x10000000		/* error signalled */
> -	    && ((ret = regs->gpr[3]) == ERESTARTSYS
> -		|| ret == ERESTARTNOHAND || ret == ERESTARTNOINTR
> -		|| ret == ERESTART_RESTARTBLOCK)) {
> -
> -		if (signr > 0
> -		    && (ret == ERESTARTNOHAND || ret == ERESTART_RESTARTBLOCK
> -			|| (ret == ERESTARTSYS
> -			    && !(ka.sa.sa_flags & SA_RESTART)))) {
> -			/* make the system call return an EINTR error */
> -			regs->result = -EINTR;
> -			regs->gpr[3] = EINTR;
> -			/* note that the cr0.SO bit is already set */
> -		} else {
> -			regs->nip -= 4;	/* Back up & retry system call */
> -			regs->result = 0;
> -			regs->trap = 0;
> -			if (ret == ERESTART_RESTARTBLOCK)
> -				regs->gpr[0] = __NR_restart_syscall;
> -			else
> -				regs->gpr[3] = regs->orig_gpr3;
> -		}
> -	}
> +	/* Is there any syscall restart business here ? */
> +	check_syscall_restart(regs, &ka, signr > 0);
>  
>  	if (signr == 0) {
>  		/* No signal to deliver -- put the saved sigmask back */
> Index: linux-cell/arch/powerpc/kernel/signal_64.c
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/signal_64.c	2007-05-30 16:45:57.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/signal_64.c	2007-06-04 11:45:43.000000000 +1000
> @@ -34,6 +34,8 @@
>  #include <asm/syscalls.h>
>  #include <asm/vdso.h>
>  
> +#include "signal.h"
> +
>  #define DEBUG_SIG 0
>  
>  #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
> @@ -463,41 +465,6 @@ static int handle_signal(unsigned long s
>  	return ret;
>  }
>  
> -static inline void syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
> -{
> -	switch ((int)regs->result) {
> -	case -ERESTART_RESTARTBLOCK:
> -	case -ERESTARTNOHAND:
> -		/* ERESTARTNOHAND means that the syscall should only be
> -		 * restarted if there was no handler for the signal, and since
> -		 * we only get here if there is a handler, we dont restart.
> -		 */
> -		regs->result = -EINTR;
> -		regs->gpr[3] = EINTR;
> -		regs->ccr |= 0x10000000;
> -		break;
> -	case -ERESTARTSYS:
> -		/* ERESTARTSYS means to restart the syscall if there is no
> -		 * handler or the handler was registered with SA_RESTART
> -		 */
> -		if (!(ka->sa.sa_flags & SA_RESTART)) {
> -			regs->result = -EINTR;
> -			regs->gpr[3] = EINTR;
> -			regs->ccr |= 0x10000000;
> -			break;
> -		}
> -		/* fallthrough */
> -	case -ERESTARTNOINTR:
> -		/* ERESTARTNOINTR means that the syscall should be
> -		 * called again after the signal handler returns.
> -		 */
> -		regs->gpr[3] = regs->orig_gpr3;
> -		regs->nip -= 4;
> -		regs->result = 0;
> -		break;
> -	}
> -}
> -
>  /*
>   * Note that 'init' is a special process: it doesn't get signals it doesn't
>   * want to handle. Thus you cannot kill init even with a SIGKILL even by
> @@ -522,13 +489,13 @@ int do_signal(sigset_t *oldset, struct p
>  		oldset = &current->blocked;
>  
>  	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
> +
> +	/* Is there any syscall restart business here ? */
> +	check_syscall_restart(regs, &ka, signr > 0);
> +
>  	if (signr > 0) {
>  		int ret;
>  
> -		/* Whee!  Actually deliver the signal.  */
> -		if (TRAP(regs) == 0x0C00)
> -			syscall_restart(regs, &ka);
> -
>  		/*
>  		 * Reenable the DABR before delivering the signal to
>  		 * user space. The DABR will have been cleared if it
> @@ -537,6 +504,7 @@ int do_signal(sigset_t *oldset, struct p
>  		if (current->thread.dabr)
>  			set_dabr(current->thread.dabr);
>  
> +		/* Whee!  Actually deliver the signal.  */
>  		ret = handle_signal(signr, &ka, &info, oldset, regs);
>  
>  		/* If a signal was successfully delivered, the saved sigmask is in
> @@ -547,19 +515,6 @@ int do_signal(sigset_t *oldset, struct p
>  		return ret;
>  	}
>  
> -	if (TRAP(regs) == 0x0C00) {	/* System Call! */
> -		if ((int)regs->result == -ERESTARTNOHAND ||
> -		    (int)regs->result == -ERESTARTSYS ||
> -		    (int)regs->result == -ERESTARTNOINTR) {
> -			regs->gpr[3] = regs->orig_gpr3;
> -			regs->nip -= 4; /* Back up & retry system call */
> -			regs->result = 0;
> -		} else if ((int)regs->result == -ERESTART_RESTARTBLOCK) {
> -			regs->gpr[0] = __NR_restart_syscall;
> -			regs->nip -= 4;
> -			regs->result = 0;
> -		}
> -	}
>  	/* No signal to deliver -- put the saved sigmask back */
>  	if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
>  		clear_thread_flag(TIF_RESTORE_SIGMASK);
> Index: linux-cell/arch/powerpc/kernel/Makefile
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/Makefile	2007-06-04 11:16:01.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/Makefile	2007-06-04 11:16:16.000000000 +1000
> @@ -12,7 +12,8 @@ endif
>  
>  obj-y				:= semaphore.o cputable.o ptrace.o syscalls.o \
>  				   irq.o align.o signal_32.o pmc.o vdso.o \
> -				   init_task.o process.o systbl.o idle.o
> +				   init_task.o process.o systbl.o idle.o \
> +				   signal.o
>  obj-y				+= vdso32/
>  obj-$(CONFIG_PPC64)		+= setup_64.o binfmt_elf32.o sys_ppc32.o \
>  				   signal_64.o ptrace32.o \
> Index: linux-cell/arch/powerpc/kernel/signal.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-cell/arch/powerpc/kernel/signal.c	2007-06-04 11:45:50.000000000 +1000
> @@ -0,0 +1,64 @@
> +/*
> + * Common signal handling code for both 32 and 64 bits
> + *
> + *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Coproration
> + *    Extracted from signal_32.c and signal_64.c
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License.  See the file README.legal in the main directory of
> + * this archive for more details.
> + */
> +
> +#include <linux/ptrace.h>
> +#include <linux/signal.h>
> +
> +void check_syscall_restart(struct pt_regs *regs, struct k_sigaction *ka,
> +			   int has_handler)
> +{
> +	unsigned long ret = regs->gpr[3];
> +	int restart = 1;
> +
> +	/* syscall ? */
> +	if (TRAP(regs) != 0x0C00)
> +		return;
> +
> +	/* error signalled ? */
> +	if (!(regs->ccr & 0x10000000))
> +		return;
> +
> +	switch (ret) {
> +	case ERESTART_RESTARTBLOCK:
> +	case ERESTARTNOHAND:
> +		/* ERESTARTNOHAND means that the syscall should only be
> +		 * restarted if there was no handler for the signal, and since
> +		 * we only get here if there is a handler, we dont restart.
> +		 */
> +		restart = !has_handler;
> +		break;
> +	case ERESTARTSYS:
> +		/* ERESTARTSYS means to restart the syscall if there is no
> +		 * handler or the handler was registered with SA_RESTART
> +		 */
> +		restart = !has_handler || (ka->sa.sa_flags & SA_RESTART) != 0;
> +		break;
> +	case ERESTARTNOINTR:
> +		/* ERESTARTNOINTR means that the syscall should be
> +		 * called again after the signal handler returns.
> +		 */
> +		break;
> +	default:
> +		return;
> +	}
> +	if (restart) {
> +		if (ret == ERESTART_RESTARTBLOCK)
> +			regs->gpr[0] = __NR_restart_syscall;
> +		else
> +			regs->gpr[3] = regs->orig_gpr3;
> +		regs->nip -= 4;
> +		regs->result = 0;
> +	} else {
> +		regs->result = -EINTR;
> +		regs->gpr[3] = EINTR;
> +		regs->ccr |= 0x10000000;
> +	}
> +}
> Index: linux-cell/arch/powerpc/kernel/signal.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-cell/arch/powerpc/kernel/signal.h	2007-06-04 11:45:41.000000000 +1000
> @@ -0,0 +1,16 @@
> +/*
> + *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Coproration
> + *    Extracted from signal_32.c and signal_64.c
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License.  See the file README.legal in the main directory of
> + * this archive for more details.
> + */
> +
> +#ifndef _POWERPC_ARCH_SIGNAL_H
> +#define _POWERPC_ARCH_SIGNAL_H
> +
> +extern void check_syscall_restart(struct pt_regs *regs, struct k_sigaction *ka,
> +				  int has_handler);
> +
> +#endif  /* _POWERPC_ARCH_SIGNAL_H */
---end quoted text---
