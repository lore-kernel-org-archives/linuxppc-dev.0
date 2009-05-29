Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DD742DDF7E
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 14:20:04 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4T4JHGf010974
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 14:19:17 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4T4K3QD725186
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 14:20:03 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4T4K2bH016931
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 14:20:03 +1000
Date: Fri, 29 May 2009 14:18:49 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 2/6] Introduce PPC64 specific Hardware Breakpoint
	interfaces
Message-ID: <20090529041849.GD8621@yookeroo.seuss>
References: <20090525004730.944465878@prasadkr_t60p.in.ibm.com>
	<20090525011522.GC11078@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090525011522.GC11078@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, Alan Stern <stern@rowland.harvard.edu>,
	paulus@samba.org, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 06:45:22AM +0530, K.Prasad wrote:
> Introduce PPC64 implementation for the generic hardware breakpoint interfaces
> defined in kernel/hw_breakpoint.c. Enable the HAVE_HW_BREAKPOINT flag and the
> Makefile.

[snip]
> +/* Store the kernel-space breakpoint address value */
> +static unsigned long kdabr;
> +
> +/*
> + * Temporarily stores address for DABR before it is written by the
> + * single-step handler routine
> + */
> +static DEFINE_PER_CPU(unsigned long, dabr_data);
> +
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
> + * Install the debug register values for just the kernel, no thread.
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
> +	/*
> +	 * User-space requests will always have the address field populated
> +	* Symbol names from user-space are rejected
> +	*/
> +	if (tsk && bp->info.name)
> +		return -EINVAL;
> +	/*
> +	 * User-space requests will always have the address field populated
> +	 * For kernel-addresses, either the address or symbol name can be
> +	 * specified.
> +	 */
> +	if (bp->info.name)
> +		bp->info.address = (unsigned long)
> +					kallsyms_lookup_name(bp->info.name);
> +	if (bp->info.address)
> +		return 0;
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
> +	int cpu, stepped = 1;
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
> +	if (dar == bp->info.address)
> +		per_cpu(dabr_data, cpu) = (hbp_kernel_pos == HBP_NUM) ?
> +						current->thread.dabr : kdabr;
> +	else {
> +		/*
> +		 * This exception is triggered not because of a memory access on
> +		 * the monitored variable but in the double-word address range
> +		 * in which it is contained. We will consume this exception,
> +		 * considering it as 'noise'.
> +		 */
> +		rc = NOTIFY_STOP;
> +		goto out;
> +	}
> +	(bp->triggered)(bp, regs);

This will fire the handler function before the instruction has
executed.  I remember seeing a comment in the other patchset saying
the function would be triggered after execution, but I'm not sure if
that was in generic of x86-specific code.

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
> +	per_cpu(dabr_data, cpu) = 0;

This curly arrangement of put_cpu() / get_cpu() could probably do with
some more comments...

> +out:
> +	/* Enable pre-emption only if single-stepping is finished */
> +	if (stepped)
> +		put_cpu_no_resched();
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

Ok, this is a behaviour change - the old do_dabr() code fired the
SIGTRAP before the instruction completed, but this will fire it
after.  It seems simpler and safer to move this into ptrace's
triggered function.

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
-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
