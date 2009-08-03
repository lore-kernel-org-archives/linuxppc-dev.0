Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B1C42B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 06:59:49 +1000 (EST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [59.145.155.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6454DDDDA0
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 06:59:47 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id n73KxfYk014881
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Aug 2009 02:29:41 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73KxeBa1478842
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Aug 2009 02:29:40 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n73Kxe4F014058
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Aug 2009 06:59:40 +1000
Date: Tue, 4 Aug 2009 02:29:38 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [Patch 2/6] Introduce PPC64 specific Hardware Breakpoint
	interfaces
Message-ID: <20090803205938.GB3914@in.ibm.com>
References: <20090726235854.574539012@prasadkr_t60p.in.ibm.com>
	<20090727001317.GC13562@in.ibm.com>
	<20090731061646.GH3950@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090731061646.GH3950@yookeroo.seuss>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 31, 2009 at 04:16:46PM +1000, David Gibson wrote:
> On Mon, Jul 27, 2009 at 05:43:17AM +0530, K.Prasad wrote:
> > Introduce PPC64 implementation for the generic hardware breakpoint interfaces
> > defined in kernel/hw_breakpoint.c. Enable the HAVE_HW_BREAKPOINT flag and the
> > Makefile.
> 
> [snip]
> > +/*
> > + * Handle debug exception notifications.
> > + */
> > +int __kprobes hw_breakpoint_handler(struct die_args *args)
> > +{
> > +	int rc = NOTIFY_STOP;
> > +	struct hw_breakpoint *bp;
> > +	struct pt_regs *regs = args->regs;
> > +	unsigned long dar = regs->dar;
> > +	int cpu, is_kernel, stepped = 1;
> > +
> > +	is_kernel = (hbp_kernel_pos == HBP_NUM) ? 0 : 1;
> > +
> > +	/* Disable breakpoints during exception handling */
> > +	set_dabr(0);
> > +
> > +	cpu = get_cpu();
> > +	/* Determine whether kernel- or user-space address is the trigger */
> > +	bp = is_kernel ?
> > +		per_cpu(this_hbp_kernel[0], cpu) : current->thread.hbp[0];
> > +	/*
> > +	 * bp can be NULL due to lazy debug register switching
> > +	 * or due to the delay between updates of hbp_kernel_pos
> > +	 * and this_hbp_kernel.
> > +	 */
> > +	if (!bp)
> > +		goto out;
> > +
> > +	per_cpu(dabr_data, cpu) = is_kernel ? kdabr : current->thread.dabr;
> > +
> > +	/* Verify if dar lies within the address range occupied by the symbol
> > +	 * being watched. Since we cannot get the symbol size for
> > +	 * user-space requests we skip this check in that case
> > +	 */
> > +	if (is_kernel &&
> > +	    !((bp->info.address <= dar) &&
> > +	     (dar <= (bp->info.address + bp->info.symbolsize))))
> > +		/*
> > +		 * This exception is triggered not because of a memory access on
> > +		 * the monitored variable but in the double-word address range
> > +		 * in which it is contained. We will consume this exception,
> > +		 * considering it as 'noise'.
> > +		 */
> > +		goto out;
> > +
> > +	(bp->triggered)(bp, regs);
> 
> It bothers me that the trigger function is executed before the
> trapping instruction, but the SIGTRAP occurs afterwards.  Since
> they're both responses to the trap, it seems logical to me that they
> should occur at the same time (from the trapping program's point of
> view, at least).
> 

How about moving the triggered function to the single-step handler code
for both kernel- and user-space?

That would make it behave like a trigger-after-execute (and synchronised
with the signal-delivery timing).

> > +	/*
> > +	 * Return early without restoring DABR if the breakpoint is from
> > +	 * user-space which always operates in one-shot mode
> > +	 */
> > +	if (!is_kernel) {
> > +		rc = NOTIFY_DONE;
> > +		goto out;
> > +	}
> > +
> > +	stepped = emulate_step(regs, regs->nip);
> > +	/*
> > +	 * Single-step the causative instruction manually if
> > +	 * emulate_step() could not execute it
> > +	 */
> > +	if (stepped == 0) {
> > +		regs->msr |= MSR_SE;
> > +		goto out;
> > +	}
> > +	set_dabr(per_cpu(dabr_data, cpu));
> > +
> > +out:
> > +	/* Enable pre-emption only if single-stepping is finished */
> > +	if (stepped) {
> > +		per_cpu(dabr_data, cpu) = 0;
> > +		put_cpu();
> > +	}
> > +	return rc;
> > +}
> > +
> > +/*
> > + * Handle single-step exceptions following a DABR hit.
> > + */
> > +int __kprobes single_step_dabr_instruction(struct die_args *args)
> > +{
> > +	struct pt_regs *regs = args->regs;
> > +	int cpu = get_cpu();
> > +	int ret = NOTIFY_DONE;
> > +	siginfo_t info;
> > +	unsigned long this_dabr_data = per_cpu(dabr_data, cpu);
> > +
> > +	/*
> > +	 * Check if we are single-stepping as a result of a
> > +	 * previous HW Breakpoint exception
> > +	 */
> > +	if (this_dabr_data == 0)
> > +		goto out;
> > +
> > +	regs->msr &= ~MSR_SE;
> > +	/* Deliver signal to user-space */
> > +	if (this_dabr_data < TASK_SIZE) {
> > +		info.si_signo = SIGTRAP;
> > +		info.si_errno = 0;
> > +		info.si_code = TRAP_HWBKPT;
> > +		info.si_addr = (void __user *)(per_cpu(dabr_data, cpu));
> > +		force_sig_info(SIGTRAP, &info, current);
> > +	}
> > +
> > +	set_dabr(this_dabr_data);
> > +	per_cpu(dabr_data, cpu) = 0;
> > +	ret = NOTIFY_STOP;
> > +	/*
> > +	 * If single-stepped after hw_breakpoint_handler(), pre-emption is
> > +	 * already disabled.
> > +	 */
> > +	put_cpu();
> > +
> > +out:
> > +	/*
> > +	 * A put_cpu() call is required to complement the get_cpu()
> > +	 * call used initially
> > +	 */
> > +	put_cpu();
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Handle debug exception notifications.
> > + */
> > +int __kprobes hw_breakpoint_exceptions_notify(
> 
> Um.. there seems to be a pretty glaring problem here, in that AFAICT
> in this revision of the series, this function is never invoked, and so
> your breakpoint handling code will never be executed.  i.e. the
> changes to do_dabr to connect your code seem to be missing.
>

I realised it only after you pointed out...some remnants from the
previous version have caused it. While the patch should have treated
only ptrace in a special manner (one-shot), it erroneously does it for all
user-space. I will change it in the next version of the patchset.

Thanks,
K.Prasad
