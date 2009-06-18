Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 433A0B725A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 04:20:58 +1000 (EST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 54E90DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 04:20:56 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5IIKnWL021151
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 23:50:49 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5IIKmEW2334974
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 23:50:48 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5IIKmt1017794
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 23:50:48 +0530
Date: Thu, 18 Jun 2009 23:50:45 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [Patch 2/6] Introduce PPC64 specific Hardware Breakpoint
	interfaces
Message-ID: <20090618182045.GC4590@in.ibm.com>
References: <20090610090316.898961359@prasadkr_t60p.in.ibm.com>
	<20090610090806.GC14478@in.ibm.com>
	<20090617043224.GL486@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090617043224.GL486@yookeroo.seuss>
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

On Wed, Jun 17, 2009 at 02:32:24PM +1000, David Gibson wrote:
> On Wed, Jun 10, 2009 at 02:38:06PM +0530, K.Prasad wrote:
> > Introduce PPC64 implementation for the generic hardware breakpoint interfaces
> > defined in kernel/hw_breakpoint.c. Enable the HAVE_HW_BREAKPOINT flag and the
> > Makefile.
> 
> [snip]
> > +int arch_store_info(struct hw_breakpoint *bp, struct task_struct *tsk)
> > +{
> > +	/* Symbol names from user-space are rejected */
> > +	if (tsk) {
> > +		if (bp->info.name)
> > +			return -EINVAL;
> > +		else
> > +			return 0;
> > +	}
> > +	/*
> > +	 * User-space requests will always have the address field populated
> > +	 * For kernel-addresses, either the address or symbol name can be
> > +	 * specified.
> > +	 */
> > +	if (bp->info.name)
> > +		bp->info.address = (unsigned long)
> > +					kallsyms_lookup_name(bp->info.name);
> > +	if (bp->info.address)
> > +		if (kallsyms_lookup_size_offset(bp->info.address,
> > +						&(bp->info.symbolsize), NULL))
> > +			return 0;
> > +	return -EINVAL;
> > +}
> > +
> > +/*
> > + * Validate the arch-specific HW Breakpoint register settings
> > + */
> > +int arch_validate_hwbkpt_settings(struct hw_breakpoint *bp,
> > +						struct task_struct *tsk)
> > +{
> > +	int is_kernel, ret = -EINVAL;
> > +
> > +	if (!bp)
> > +		return ret;
> > +
> > +	switch (bp->info.type) {
> > +	case HW_BREAKPOINT_READ:
> > +	case HW_BREAKPOINT_WRITE:
> > +	case HW_BREAKPOINT_RW:
> > +		break;
> > +	default:
> > +		return ret;
> > +	}
> > +
> > +	if (bp->triggered)
> > +		ret = arch_store_info(bp, tsk);
> 
> Under what circumstances would triggered be NULL?  It's not clear to
> me that you wouldn't still need arch_store_info() in this case.
> 

Simple, triggered would be NULL when a user fails to specify it!
This function would return EINVAL if that's the case.

> > +
> > +	is_kernel = is_kernel_addr(bp->info.address);
> > +	if ((tsk && is_kernel) || (!tsk && !is_kernel))
> > +		return -EINVAL;
> > +
> > +	return ret;
> > +}
> > +

<snipped>

> > +/*
> > + * Handle debug exception notifications.
> > + */
> > +int __kprobes hw_breakpoint_handler(struct die_args *args)
> > +{
> > +	int rc = NOTIFY_STOP;
> > +	struct hw_breakpoint *bp;
> > +	struct pt_regs *regs = args->regs;
> > +	unsigned long dar = regs->dar;
> > +	int cpu, is_one_shot, stepped = 1;
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
> > +	is_one_shot = (bp->triggered == ptrace_triggered) ? 1 : 0;
> > +	per_cpu(dabr_data, cpu) = (hbp_kernel_pos == HBP_NUM) ?
> > +						current->thread.dabr : kdabr;
> > +
> > +	/* Verify if dar lies within the address range occupied by the symbol
> > +	 * being watched. Since we cannot get the symbol size for
> > +	 * user-space requests we skip this check in that case
> > +	 */
> > +	if ((hbp_kernel_pos == 0) &&
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
> So this confuses me.  You go to great efforts to step over the
> instruction to generate a SIGTRAP after the instruction, for
> consistency with x86.  But that SIGTRAP is *never* used, since the
> only way to set userspace breakpoints is through ptrace at the moment.
> At the same time, the triggered function is called here before the
> instruction is executed, so not consistent with x86 anyway.
> 
> It just seems strange to me that sending a SIGTRAP is a special case
> anyway.  Why can't sending a SIGTRAP be just a particular triggered
> function.
>

The consistency in the interface across architectures that I referred to
in my previous mail was w.r.t. continuous triggering of breakpoints and
not to implement a trigger-before or trigger-after behaviour across
architectures. In fact, this behaviour differs even on the same
processor depending upon the breakpoint type (trigger-before for
instructions and trigger-after for data in x86), and introducing
uniformity might be a) at the cost of loss of some unique & innovative
uses for each of them b) may not be always possible e.g. trigger-after
to trigger-before.

Hope this resolves the confusion (that I might have inadvertently caused
in my previous mail)!

Thanks,
K.Prasad
 
