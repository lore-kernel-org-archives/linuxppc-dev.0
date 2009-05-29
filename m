Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 554C5DDF8F
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 23:54:34 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4TDsYLd019322
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 23:54:34 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4TDsYMr741536
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 23:54:34 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4TDsYTm005807
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 23:54:34 +1000
Date: Fri, 29 May 2009 19:24:26 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [Patch 2/6] Introduce PPC64 specific Hardware Breakpoint
	interfaces
Message-ID: <20090529135426.GA12307@in.ibm.com>
References: <20090525004730.944465878@prasadkr_t60p.in.ibm.com>
	<20090525011522.GC11078@in.ibm.com>
	<20090529041849.GD8621@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090529041849.GD8621@yookeroo.seuss>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, Alan Stern <stern@rowland.harvard.edu>,
	paulus@samba.org, Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 29, 2009 at 02:18:49PM +1000, David Gibson wrote:
> On Mon, May 25, 2009 at 06:45:22AM +0530, K.Prasad wrote:
> > +/*
> > + * Handle debug exception notifications.
> > + */
> > +int __kprobes hw_breakpoint_handler(struct die_args *args)
> > +{
> > +	int rc = NOTIFY_STOP;
> > +	struct hw_breakpoint *bp;
> > +	struct pt_regs *regs = args->regs;
> > +	unsigned long dar = regs->dar;
> > +	int cpu, stepped = 1;
> > +
> > +	/* Disable breakpoints during exception handling */
> > +	set_dabr(0);
> > +
> > +	cpu = get_cpu();
> > +	/* Determine whether kernel- or user-space address is the trigger */
> > +	bp = (hbp_kernel_pos == HBP_NUM) ? current->thread.hbp[0] :
> > +					per_cpu(this_hbp_kernel[0], cpu);
> > +	/*
> > +	 * bp can be NULL due to lazy debug register switching
> > +	 * or due to the delay between updates of hbp_kernel_pos
> > +	 * and this_hbp_kernel.
> > +	 */
> > +	if (!bp)
> > +		goto out;
> > +
> > +	if (dar == bp->info.address)
> > +		per_cpu(dabr_data, cpu) = (hbp_kernel_pos == HBP_NUM) ?
> > +						current->thread.dabr : kdabr;
> > +	else {
> > +		/*
> > +		 * This exception is triggered not because of a memory access on
> > +		 * the monitored variable but in the double-word address range
> > +		 * in which it is contained. We will consume this exception,
> > +		 * considering it as 'noise'.
> > +		 */
> > +		rc = NOTIFY_STOP;
> > +		goto out;
> > +	}
> > +	(bp->triggered)(bp, regs);
> 
> This will fire the handler function before the instruction has
> executed.  I remember seeing a comment in the other patchset saying
> the function would be triggered after execution, but I'm not sure if
> that was in generic of x86-specific code.
> 

Yes, I see that the comment

" * @triggered: callback invoked after target address access"

in include/asm-generic/hw_breakpoint.h which has to be changed. I will
do the same in a follow-on patch to the generic interface after its
integration.

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
> > +	per_cpu(dabr_data, cpu) = 0;
> 
> This curly arrangement of put_cpu() / get_cpu() could probably do with
> some more comments...
> 

The put_cpu() usage in hw_breakpoint_handler() and
single_step_dabr_instruction() is actually wrapped with comments.

Do you want a comment about the usage of the per_cpu data variable used
above, or a more descriptive comment in places where put_cpu() is use?

> > +out:
> > +	/* Enable pre-emption only if single-stepping is finished */
> > +	if (stepped)
> > +		put_cpu_no_resched();
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
> 
> Ok, this is a behaviour change - the old do_dabr() code fired the
> SIGTRAP before the instruction completed, but this will fire it
> after.  It seems simpler and safer to move this into ptrace's
> triggered function.
> 

Thanks, I realise that this changes the user-space behaviour.
The one-shot hardware breakpoint exception behaviour and also
single-stepping the instruction have changed.

I will modify the hw_breakpoint_handler() to overcome this problem.

Thanks,
K.Prasad
