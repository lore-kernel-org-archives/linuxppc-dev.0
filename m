Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9BCD7DDDB6
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jun 2009 15:15:57 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n55FFgZf019410
	for <linuxppc-dev@ozlabs.org>; Sat, 6 Jun 2009 01:15:42 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n555FqOu385292
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Jun 2009 15:15:52 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n555Fp2Z002183
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Jun 2009 15:15:52 +1000
Date: Fri, 5 Jun 2009 15:11:58 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 2/6] Introduce PPC64 specific Hardware Breakpoint
	interfaces
Message-ID: <20090605051158.GJ2054@yookeroo.seuss>
References: <20090603162741.197115376@prasadkr_t60p.in.ibm.com>
	<20090603163511.GC5197@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090603163511.GC5197@in.ibm.com>
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

On Wed, Jun 03, 2009 at 10:05:11PM +0530, K.Prasad wrote:
> Introduce PPC64 implementation for the generic hardware breakpoint interfaces
> defined in kernel/hw_breakpoint.c. Enable the HAVE_HW_BREAKPOINT flag and the
> Makefile.


[snip]
> +/*
> + * Install the debug register values for just the kernel, no thread.

This comment does seem to quite match the function below.

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

Archs don't have to implement this name lookup stuff, but it looks
like most of them would - so it looks like there ought to be a helper
function in generic code that will do the check / name lookup stuff.


> +	if (bp->info.address)
> +		return 0;

Hrm.. you realise there's no theoretical reason a userspace program
couldn't put a breakpoint at address 0...?

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
> +	is_one_shot = (bp->triggered == ptrace_triggered) ? 1 : 0;

Ouch, explicitly special-casing ptrace_triggered is pretty nasty.
Since the bp_info is already arch specific, maybe it should include a
flag to indicate whether the breakpoint is one-shot or not.

> +	(bp->triggered)(bp, regs);
> +	/*
> +	 * Ptrace expects the HW Breakpoints to be one-shot. We will return
> +	 * NOTIFY_DONE without restoring DABR with the breakpoint address. The
> +	 * downstream code will generate SIGTRAP to the process
> +	 */
> +	if (is_one_shot) {
> +		rc = NOTIFY_DONE;
> +		goto out;

Don't you need to clear dabr_data?  Otherwise if we enter single step
for some other reason (e.g. gdb turns it on), won't we incorrectly hit
the code-path to step over a dabr breakpoint?

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
> +	per_cpu(dabr_data, cpu) = 0;
> +
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

Uh.. I recall mentioning in my previous review that in order to match
previous behaviour we need to deliver the userspace signal *before*
stepping over the breakpointed instruction, rather than after (which
I guess is why breakpoints are one-shot in the old scheme).

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
