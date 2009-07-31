Return-Path: <dwg@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B053CB7BE1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 16:20:16 +1000 (EST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 875C0DDDB6
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 16:20:16 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id n71C4Mfw007142
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Aug 2009 22:04:22 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6V6KEAd1277992
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 16:20:14 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6V6KDdU024752
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 16:20:14 +1000
Date: Fri, 31 Jul 2009 16:16:46 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 2/6] Introduce PPC64 specific Hardware Breakpoint
	interfaces
Message-ID: <20090731061646.GH3950@yookeroo.seuss>
References: <20090726235854.574539012@prasadkr_t60p.in.ibm.com>
	<20090727001317.GC13562@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090727001317.GC13562@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 27, 2009 at 05:43:17AM +0530, K.Prasad wrote:
> Introduce PPC64 implementation for the generic hardware breakpoint interfaces
> defined in kernel/hw_breakpoint.c. Enable the HAVE_HW_BREAKPOINT flag and the
> Makefile.

[snip]
> +/*
> + * Handle debug exception notifications.
> + */
> +int __kprobes hw_breakpoint_handler(struct die_args *args)
> +{
> +	int rc = NOTIFY_STOP;
> +	struct hw_breakpoint *bp;
> +	struct pt_regs *regs = args->regs;
> +	unsigned long dar = regs->dar;
> +	int cpu, is_kernel, stepped = 1;
> +
> +	is_kernel = (hbp_kernel_pos == HBP_NUM) ? 0 : 1;
> +
> +	/* Disable breakpoints during exception handling */
> +	set_dabr(0);
> +
> +	cpu = get_cpu();
> +	/* Determine whether kernel- or user-space address is the trigger */
> +	bp = is_kernel ?
> +		per_cpu(this_hbp_kernel[0], cpu) : current->thread.hbp[0];
> +	/*
> +	 * bp can be NULL due to lazy debug register switching
> +	 * or due to the delay between updates of hbp_kernel_pos
> +	 * and this_hbp_kernel.
> +	 */
> +	if (!bp)
> +		goto out;
> +
> +	per_cpu(dabr_data, cpu) = is_kernel ? kdabr : current->thread.dabr;
> +
> +	/* Verify if dar lies within the address range occupied by the symbol
> +	 * being watched. Since we cannot get the symbol size for
> +	 * user-space requests we skip this check in that case
> +	 */
> +	if (is_kernel &&
> +	    !((bp->info.address <= dar) &&
> +	     (dar <= (bp->info.address + bp->info.symbolsize))))
> +		/*
> +		 * This exception is triggered not because of a memory access on
> +		 * the monitored variable but in the double-word address range
> +		 * in which it is contained. We will consume this exception,
> +		 * considering it as 'noise'.
> +		 */
> +		goto out;
> +
> +	(bp->triggered)(bp, regs);

It bothers me that the trigger function is executed before the
trapping instruction, but the SIGTRAP occurs afterwards.  Since
they're both responses to the trap, it seems logical to me that they
should occur at the same time (from the trapping program's point of
view, at least).

> +	/*
> +	 * Return early without restoring DABR if the breakpoint is from
> +	 * user-space which always operates in one-shot mode
> +	 */
> +	if (!is_kernel) {
> +		rc = NOTIFY_DONE;
> +		goto out;
> +	}
> +
> +	stepped = emulate_step(regs, regs->nip);
> +	/*
> +	 * Single-step the causative instruction manually if
> +	 * emulate_step() could not execute it
> +	 */
> +	if (stepped == 0) {
> +		regs->msr |= MSR_SE;
> +		goto out;
> +	}
> +	set_dabr(per_cpu(dabr_data, cpu));
> +
> +out:
> +	/* Enable pre-emption only if single-stepping is finished */
> +	if (stepped) {
> +		per_cpu(dabr_data, cpu) = 0;
> +		put_cpu();
> +	}
> +	return rc;
> +}
> +
> +/*
> + * Handle single-step exceptions following a DABR hit.
> + */
> +int __kprobes single_step_dabr_instruction(struct die_args *args)
> +{
> +	struct pt_regs *regs = args->regs;
> +	int cpu = get_cpu();
> +	int ret = NOTIFY_DONE;
> +	siginfo_t info;
> +	unsigned long this_dabr_data = per_cpu(dabr_data, cpu);
> +
> +	/*
> +	 * Check if we are single-stepping as a result of a
> +	 * previous HW Breakpoint exception
> +	 */
> +	if (this_dabr_data == 0)
> +		goto out;
> +
> +	regs->msr &= ~MSR_SE;
> +	/* Deliver signal to user-space */
> +	if (this_dabr_data < TASK_SIZE) {
> +		info.si_signo = SIGTRAP;
> +		info.si_errno = 0;
> +		info.si_code = TRAP_HWBKPT;
> +		info.si_addr = (void __user *)(per_cpu(dabr_data, cpu));
> +		force_sig_info(SIGTRAP, &info, current);
> +	}
> +
> +	set_dabr(this_dabr_data);
> +	per_cpu(dabr_data, cpu) = 0;
> +	ret = NOTIFY_STOP;
> +	/*
> +	 * If single-stepped after hw_breakpoint_handler(), pre-emption is
> +	 * already disabled.
> +	 */
> +	put_cpu();
> +
> +out:
> +	/*
> +	 * A put_cpu() call is required to complement the get_cpu()
> +	 * call used initially
> +	 */
> +	put_cpu();
> +	return ret;
> +}
> +
> +/*
> + * Handle debug exception notifications.
> + */
> +int __kprobes hw_breakpoint_exceptions_notify(

Um.. there seems to be a pretty glaring problem here, in that AFAICT
in this revision of the series, this function is never invoked, and so
your breakpoint handling code will never be executed.  i.e. the
changes to do_dabr to connect your code seem to be missing.

> +		struct notifier_block *unused, unsigned long val, void *data)
> +{
> +	int ret = NOTIFY_DONE;
> +
> +	switch (val) {
> +	case DIE_DABR_MATCH:
> +		ret = hw_breakpoint_handler(data);
> +		break;
> +	case DIE_SSTEP:
> +		ret = single_step_dabr_instruction(data);
> +		break;
> +	}
> +
> +	return ret;
> +}
> Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
> ===================================================================
> --- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/ptrace.c
> +++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
> @@ -755,6 +755,10 @@ void user_disable_single_step(struct tas
>  	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
>  }
>  
> +void ptrace_triggered(struct hw_breakpoint *bp, struct pt_regs *regs)
> +{
> +}

This is never used, so does not belong in this patch.

>  int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
>  			       unsigned long data)
>  {
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
