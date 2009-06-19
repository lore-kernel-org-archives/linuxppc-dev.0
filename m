Return-Path: <dwg@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0C1B5B72B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 15:04:32 +1000 (EST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5537DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 15:04:31 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp09.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5JEw1Xf018112
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 00:58:01 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5J54TGA475434
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 15:04:29 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5J54T92005267
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 15:04:29 +1000
Date: Fri, 19 Jun 2009 15:04:09 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 2/6] Introduce PPC64 specific Hardware Breakpoint
	interfaces
Message-ID: <20090619050409.GC17986@yookeroo.seuss>
References: <20090610090316.898961359@prasadkr_t60p.in.ibm.com>
	<20090610090806.GC14478@in.ibm.com>
	<20090617043224.GL486@yookeroo.seuss>
	<20090618182045.GC4590@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090618182045.GC4590@in.ibm.com>
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

On Thu, Jun 18, 2009 at 11:50:45PM +0530, K.Prasad wrote:
> On Wed, Jun 17, 2009 at 02:32:24PM +1000, David Gibson wrote:
> > On Wed, Jun 10, 2009 at 02:38:06PM +0530, K.Prasad wrote:
[snip]
> > > +int arch_validate_hwbkpt_settings(struct hw_breakpoint *bp,
> > > +						struct task_struct *tsk)
> > > +{
> > > +	int is_kernel, ret = -EINVAL;
> > > +
> > > +	if (!bp)
> > > +		return ret;
> > > +
> > > +	switch (bp->info.type) {
> > > +	case HW_BREAKPOINT_READ:
> > > +	case HW_BREAKPOINT_WRITE:
> > > +	case HW_BREAKPOINT_RW:
> > > +		break;
> > > +	default:
> > > +		return ret;
> > > +	}
> > > +
> > > +	if (bp->triggered)
> > > +		ret = arch_store_info(bp, tsk);
> > 
> > Under what circumstances would triggered be NULL?  It's not clear to
> > me that you wouldn't still need arch_store_info() in this case.
> > 
> 
> Simple, triggered would be NULL when a user fails to specify it!
> This function would return EINVAL if that's the case.

Ah, right, yes.  This seems a really non obvious control flow for a
NULL triggered value to lead to EINVAL.  I'd prefer:

	if (!bp->triggered)
		return -EINVAL

	/* Then the kernel address test */

	return arch_store_info(bp, tsk);

[snip]
> > > +	/* Verify if dar lies within the address range occupied by the symbol
> > > +	 * being watched. Since we cannot get the symbol size for
> > > +	 * user-space requests we skip this check in that case
> > > +	 */
> > > +	if ((hbp_kernel_pos == 0) &&
> > > +	    !((bp->info.address <= dar) &&
> > > +	     (dar <= (bp->info.address + bp->info.symbolsize))))
> > > +		/*
> > > +		 * This exception is triggered not because of a memory access on
> > > +		 * the monitored variable but in the double-word address range
> > > +		 * in which it is contained. We will consume this exception,
> > > +		 * considering it as 'noise'.
> > > +		 */
> > > +		goto out;
> > > +
> > > +	(bp->triggered)(bp, regs);
> > 
> > So this confuses me.  You go to great efforts to step over the
> > instruction to generate a SIGTRAP after the instruction, for
> > consistency with x86.  But that SIGTRAP is *never* used, since the
> > only way to set userspace breakpoints is through ptrace at the moment.
> > At the same time, the triggered function is called here before the
> > instruction is executed, so not consistent with x86 anyway.
> > 
> > It just seems strange to me that sending a SIGTRAP is a special case
> > anyway.  Why can't sending a SIGTRAP be just a particular triggered
> > function.
> 
> The consistency in the interface across architectures that I referred to
> in my previous mail was w.r.t. continuous triggering of breakpoints and
> not to implement a trigger-before or trigger-after behaviour across
> architectures. In fact, this behaviour differs even on the same
> processor depending upon the breakpoint type (trigger-before for
> instructions and trigger-after for data in x86), and introducing
> uniformity might be a) at the cost of loss of some unique & innovative
> uses for each of them b) may not be always possible e.g. trigger-after
> to trigger-before.

Hrm.  Well (a) is why I was suggesting an option to allow trigger
before on powerpc.  Plus, I don't see why you think (a) is important
for the triggered function, but not for the timing of a SIGTRAP to
userspace.

As for (b), well there are already a bunch of things which can only be
done on certain archs/processors, so I don't see that's anything
really new.

How do you handle continuous breakpoints in the trigger-before case
(instruction breakpoints) on x86?  Do you need to step over an
instruction is the same manner as you do for powerpc?  In this case
where does x86 send the SIGTRAP?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
