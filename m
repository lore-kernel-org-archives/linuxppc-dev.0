Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9BC46DDDB2
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jun 2009 15:15:57 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp09.au.ibm.com (8.13.1/8.13.1) with ESMTP id n55FCV5w029715
	for <linuxppc-dev@ozlabs.org>; Sat, 6 Jun 2009 01:12:31 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n555FqNY868354
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Jun 2009 15:15:52 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n555FpCn002182
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Jun 2009 15:15:52 +1000
Date: Fri, 5 Jun 2009 15:13:45 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 3/6] Modify ptrace code to use Hardware Breakpoint
	interfaces
Message-ID: <20090605051345.GK2054@yookeroo.seuss>
References: <20090603162741.197115376@prasadkr_t60p.in.ibm.com>
	<20090603163524.GD5197@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090603163524.GD5197@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 03, 2009 at 10:05:24PM +0530, K.Prasad wrote:
> Modify the ptrace code to use the hardware breakpoint interfaces for user-space.
> 
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/ptrace.c |   47 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
> ===================================================================
> --- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/ptrace.c
> +++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
> @@ -37,6 +37,7 @@
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
>  #include <asm/system.h>
> +#include <asm/hw_breakpoint.h>
>  
>  /*
>   * does not yet catch signals sent when the child dies.
> @@ -735,9 +736,26 @@ void user_disable_single_step(struct tas
>  	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
>  }
>  
> +void ptrace_triggered(struct hw_breakpoint *bp, struct pt_regs *regs)
> +{
> +	/*
> +	 * Unregister the breakpoint request here since ptrace has defined a
> +	 * one-shot behaviour for breakpoint exceptions in PPC64.
> +	 * The SIGTRAP signal is generated automatically for us in do_dabr().
> +	 * We don't have to do anything here
> +	 */
> +	unregister_user_hw_breakpoint(current, bp);
> +	kfree(bp);

Couldn't you also clear the saved dabr info here, to avoid having to
special case this in the actual breakpoint handler.

Also, I think you should be delivering the signal here - for gdb
compatibility I think we'll need to match the old behaviour which has
the TRAP delivered before executing the breakpointed instruction.

> +}
> +
>  int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
>  			       unsigned long data)
>  {
> +#ifdef CONFIG_PPC64
> +	struct thread_struct *thread = &(task->thread);
> +	struct hw_breakpoint *bp;
> +	int ret;
> +#endif
>  	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
>  	 *  For embedded processors we support one DAC and no IAC's at the
>  	 *  moment.
> @@ -767,6 +785,35 @@ int ptrace_set_debugreg(struct task_stru
>  	if (data && !(data & DABR_TRANSLATION))
>  		return -EIO;
>  
> +#ifdef CONFIG_PPC64
> +	bp = thread->hbp[0];
> +	if (data == 0) {
> +		if (bp) {
> +			unregister_user_hw_breakpoint(task, bp);
> +			kfree(bp);
> +		}
> +		return 0;
> +	}
> +
> +	if (bp) {
> +		bp->info.type = data & HW_BREAKPOINT_RW;
> +		task->thread.dabr = bp->info.address = data;
> +		return modify_user_hw_breakpoint(task, bp);
> +	}
> +	bp = kzalloc(sizeof(struct hw_breakpoint), GFP_KERNEL);
> +	if (!bp)
> +		return -ENOMEM;
> +
> +	/* Store the type of breakpoint */
> +	bp->info.type = data & HW_BREAKPOINT_RW;
> +	bp->triggered = ptrace_triggered;
> +	task->thread.dabr = bp->info.address = data;
> +
> +	ret = register_user_hw_breakpoint(task, bp);
> +	if (ret)
> +		return ret;
> +#endif /* CONFIG_PPC64 */
> +
>  	/* Move contents to the DABR register */
>  	task->thread.dabr = data;
>  
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
