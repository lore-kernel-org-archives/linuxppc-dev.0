Return-Path: <dwg@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C4D37B71A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 15:08:09 +1000 (EST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2D6DDDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 15:08:08 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5HF5XMh010892
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 01:05:33 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5H587gj966890
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 15:08:07 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5H586Bo004765
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 15:08:07 +1000
Date: Wed, 17 Jun 2009 14:32:24 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 2/6] Introduce PPC64 specific Hardware Breakpoint
	interfaces
Message-ID: <20090617043224.GL486@yookeroo.seuss>
References: <20090610090316.898961359@prasadkr_t60p.in.ibm.com>
	<20090610090806.GC14478@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090610090806.GC14478@in.ibm.com>
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

On Wed, Jun 10, 2009 at 02:38:06PM +0530, K.Prasad wrote:
> Introduce PPC64 implementation for the generic hardware breakpoint interfaces
> defined in kernel/hw_breakpoint.c. Enable the HAVE_HW_BREAKPOINT flag and the
> Makefile.

[snip]
> +void arch_update_kernel_hw_breakpoint(void *unused)
> +{
> +	struct hw_breakpoint *bp;
> +
> +	/* Check if there is nothing to update */
> +	if (hbp_kernel_pos == HBP_NUM)
> +		return;
> +
> +	per_cpu(this_hbp_kernel[hbp_kernel_pos], get_cpu()) = bp =
> +						hbp_kernel[hbp_kernel_pos];
> +	if (bp == NULL)
> +		kdabr = 0;
> +	else
> +		kdabr = (bp->info.address & ~HW_BREAKPOINT_ALIGN) |
> +			bp->info.type | DABR_TRANSLATION;
> +	set_dabr(kdabr);
> +	put_cpu_no_resched();
> +}
> +
> +/*
> + * Install the thread breakpoints in their debug registers.
> + */
> +void arch_install_thread_hw_breakpoint(struct task_struct *tsk)
> +{
> +	set_dabr(tsk->thread.dabr);
> +}
> +
> +/*
> + * Clear the DABR which contains the thread-specific breakpoint address
> + */
> +void arch_uninstall_thread_hw_breakpoint()
> +{
> +	set_dabr(0);
> +}
> +
> +/*
> + * Store a breakpoint's encoded address, length, and type.
> + */
> +int arch_store_info(struct hw_breakpoint *bp, struct task_struct *tsk)
> +{
> +	/* Symbol names from user-space are rejected */
> +	if (tsk) {
> +		if (bp->info.name)
> +			return -EINVAL;
> +		else
> +			return 0;
> +	}
> +	/*
> +	 * User-space requests will always have the address field populated
> +	 * For kernel-addresses, either the address or symbol name can be
> +	 * specified.
> +	 */
> +	if (bp->info.name)
> +		bp->info.address = (unsigned long)
> +					kallsyms_lookup_name(bp->info.name);
> +	if (bp->info.address)
> +		if (kallsyms_lookup_size_offset(bp->info.address,
> +						&(bp->info.symbolsize), NULL))
> +			return 0;
> +	return -EINVAL;
> +}
> +
> +/*
> + * Validate the arch-specific HW Breakpoint register settings
> + */
> +int arch_validate_hwbkpt_settings(struct hw_breakpoint *bp,
> +						struct task_struct *tsk)
> +{
> +	int is_kernel, ret = -EINVAL;
> +
> +	if (!bp)
> +		return ret;
> +
> +	switch (bp->info.type) {
> +	case HW_BREAKPOINT_READ:
> +	case HW_BREAKPOINT_WRITE:
> +	case HW_BREAKPOINT_RW:
> +		break;
> +	default:
> +		return ret;
> +	}
> +
> +	if (bp->triggered)
> +		ret = arch_store_info(bp, tsk);

Under what circumstances would triggered be NULL?  It's not clear to
me that you wouldn't still need arch_store_info() in this case.

> +
> +	is_kernel = is_kernel_addr(bp->info.address);
> +	if ((tsk && is_kernel) || (!tsk && !is_kernel))
> +		return -EINVAL;
> +
> +	return ret;
> +}
> +
> +void arch_update_user_hw_breakpoint(int pos, struct task_struct *tsk)
> +{
> +	struct thread_struct *thread = &(tsk->thread);
> +	struct hw_breakpoint *bp = thread->hbp[0];
> +
> +	if (bp)
> +		thread->dabr = (bp->info.address & ~HW_BREAKPOINT_ALIGN) |
> +				bp->info.type | DABR_TRANSLATION;
> +	else
> +		thread->dabr = 0;
> +}
> +
> +void arch_flush_thread_hw_breakpoint(struct task_struct *tsk)
> +{
> +	struct thread_struct *thread = &(tsk->thread);
> +
> +	thread->dabr = 0;
> +}
> +
> +/*
> + * Handle debug exception notifications.
> + */
> +int __kprobes hw_breakpoint_handler(struct die_args *args)
> +{
> +	int rc = NOTIFY_STOP;
> +	struct hw_breakpoint *bp;
> +	struct pt_regs *regs = args->regs;
> +	unsigned long dar = regs->dar;
> +	int cpu, is_one_shot, stepped = 1;
> +
> +	/* Disable breakpoints during exception handling */
> +	set_dabr(0);
> +
> +	cpu = get_cpu();
> +	/* Determine whether kernel- or user-space address is the trigger */
> +	bp = (hbp_kernel_pos == HBP_NUM) ? current->thread.hbp[0] :
> +					per_cpu(this_hbp_kernel[0], cpu);
> +	/*
> +	 * bp can be NULL due to lazy debug register switching
> +	 * or due to the delay between updates of hbp_kernel_pos
> +	 * and this_hbp_kernel.
> +	 */
> +	if (!bp)
> +		goto out;
> +
> +	is_one_shot = (bp->triggered == ptrace_triggered) ? 1 : 0;
> +	per_cpu(dabr_data, cpu) = (hbp_kernel_pos == HBP_NUM) ?
> +						current->thread.dabr : kdabr;
> +
> +	/* Verify if dar lies within the address range occupied by the symbol
> +	 * being watched. Since we cannot get the symbol size for
> +	 * user-space requests we skip this check in that case
> +	 */
> +	if ((hbp_kernel_pos == 0) &&
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

So this confuses me.  You go to great efforts to step over the
instruction to generate a SIGTRAP after the instruction, for
consistency with x86.  But that SIGTRAP is *never* used, since the
only way to set userspace breakpoints is through ptrace at the moment.
At the same time, the triggered function is called here before the
instruction is executed, so not consistent with x86 anyway.

It just seems strange to me that sending a SIGTRAP is a special case
anyway.  Why can't sending a SIGTRAP be just a particular triggered
function.

> +	/*
> +	 * Ptrace expects the HW Breakpoints to be one-shot. We will return
> +	 * NOTIFY_DONE without restoring DABR with the breakpoint address. The
> +	 * downstream code will generate SIGTRAP to the process
> +	 */
> +	if (is_one_shot) {
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
> +		put_cpu_no_resched();
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
> +	put_cpu_no_resched();
> +
> +out:
> +	/*
> +	 * A put_cpu_no_resched() call is required to complement the get_cpu()
> +	 * call used initially
> +	 */
> +	put_cpu_no_resched();
> +	return ret;
> +}
> +
> +/*
> + * Handle debug exception notifications.
> + */
> +int __kprobes hw_breakpoint_exceptions_notify(
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
> @@ -735,6 +735,10 @@ void user_disable_single_step(struct tas
>  	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
>  }
>  
> +void ptrace_triggered(struct hw_breakpoint *bp, struct pt_regs *regs)
> +{
> +}
> +
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
