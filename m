Return-Path: <paulus@ozlabs.org>
Date: Thu, 27 May 2010 16:32:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 4/4] PPC64-HWBKPT: Enable hw-breakpoints while handling
	intervening signals
Message-ID: <20100527063223.GC4105@drongo>
References: <20100525083055.342788418@linux.vnet.ibm.com>
	<20100525091505.GE29003@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100525091505.GE29003@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 25, 2010 at 02:45:05PM +0530, K.Prasad wrote:

> A signal delivered between a hw_breakpoint_handler() and the
> single_step_dabr_instruction() will not have the breakpoint active during
> signal handling (since breakpoint will not be restored through single-stepping
> due to absence of MSR_SE bit on the signal frame). Enable breakpoints before
> signal delivery.
> 
> Restore hw-breakpoints if the user-context is altered in the signal handler.

...

>  /*
> + * Restores the breakpoint on the debug registers.
> + * Invoke this function if it is known that the execution context is about to
> + * change to cause loss of MSR_SE settings.
> + */
> +void thread_change_pc(struct task_struct *tsk)
> +{
> +	struct arch_hw_breakpoint *info;
> +
> +	if (likely(!tsk->thread.last_hit_ubp))
> +		return;
> +
> +	info = counter_arch_bp(tsk->thread.last_hit_ubp);
> +	set_dabr(info->address | info->type | DABR_TRANSLATION);
> +}

I think this function needs to clear current->thread.last_hit_ubp.
You also need to pass the regs to it so it can clear MSR_SE from
regs->msr.

> Index: linux-2.6.ppc64_test/arch/powerpc/kernel/signal_64.c
> ===================================================================
> --- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/signal_64.c
> +++ linux-2.6.ppc64_test/arch/powerpc/kernel/signal_64.c
> @@ -33,6 +33,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/syscalls.h>
>  #include <asm/vdso.h>
> +#include <asm/hw_breakpoint.h>
>  
>  #include "signal.h"
>  
> @@ -312,6 +313,7 @@ int sys_swapcontext(struct ucontext __us
>  		    || __copy_to_user(&old_ctx->uc_sigmask,
>  				      &current->blocked, sizeof(sigset_t)))
>  			return -EFAULT;
> +		thread_change_pc(current);

This is in the part of the code that is saving the old context, after
the old context has been saved.  We need to do it before saving the
old context so that the saved context doesn't have the MSR_SE bit set
in its MSR image.  And similarly in the 32-bit version.

In fact, we probably don't need to do anything here.  We should never
get into a system call (such as sys_swapcontext or sys_sigreturn) when
single-stepping a load or store that caused a DABR match.  If we do,
something very strange is happening.  So I would leave out the
swapcontext changes for this version.

Paul.
