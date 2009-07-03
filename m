Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1DD44B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 18:16:25 +1000 (EST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05C49DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 18:16:24 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id n63891Gx013714
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Jul 2009 18:09:01 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n638BTri422168
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Jul 2009 18:11:29 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n638BTix006738
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Jul 2009 18:11:29 +1000
Date: Fri, 3 Jul 2009 13:41:14 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [Patch 2/6] Introduce PPC64 specific Hardware Breakpoint
	interfaces
Message-ID: <20090703081114.GA4369@in.ibm.com>
References: <20090610090316.898961359@prasadkr_t60p.in.ibm.com>
	<20090610090806.GC14478@in.ibm.com>
	<20090617043224.GL486@yookeroo.seuss>
	<20090618182045.GC4590@in.ibm.com>
	<20090619050409.GC17986@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090619050409.GC17986@yookeroo.seuss>
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

On Fri, Jun 19, 2009 at 03:04:09PM +1000, David Gibson wrote:
> On Thu, Jun 18, 2009 at 11:50:45PM +0530, K.Prasad wrote:
> > On Wed, Jun 17, 2009 at 02:32:24PM +1000, David Gibson wrote:
> > > On Wed, Jun 10, 2009 at 02:38:06PM +0530, K.Prasad wrote:
> [snip]

With apologies for the long delay here's my response. Some work that was
required to push the generic breakpoint patches into mainline (which is
now pushed to 2.6.32 merge window) and the preparation of a paper kept me
away from responding. Also to add that I will be on a week long vacation
starting next week followed by travel to Linux Symposium and I will not
be able to actively respond to mails till the week beginning 20th of
this month.

But kindly drop in your comments as I would like to have the PPC64
patches ready well before the next merge window opens!

> 
> Ah, right, yes.  This seems a really non obvious control flow for a
> NULL triggered value to lead to EINVAL.  I'd prefer:
> 
> 	if (!bp->triggered)
> 		return -EINVAL
> 
> 	/* Then the kernel address test */
> 
> 	return arch_store_info(bp, tsk);
> 

Ok. It is a minor change and I will do it.

> [snip]
> > > > +	/* Verify if dar lies within the address range occupied by the symbol
> > > > +	 * being watched. Since we cannot get the symbol size for
> > > > +	 * user-space requests we skip this check in that case
> > > > +	 */
> > > > +	if ((hbp_kernel_pos == 0) &&
> > > > +	    !((bp->info.address <= dar) &&
> > > > +	     (dar <= (bp->info.address + bp->info.symbolsize))))
> > > > +		/*
> > > > +		 * This exception is triggered not because of a memory access on
> > > > +		 * the monitored variable but in the double-word address range
> > > > +		 * in which it is contained. We will consume this exception,
> > > > +		 * considering it as 'noise'.
> > > > +		 */
> > > > +		goto out;
> > > > +
> > > > +	(bp->triggered)(bp, regs);
> > > 
> > > So this confuses me.  You go to great efforts to step over the
> > > instruction to generate a SIGTRAP after the instruction, for
> > > consistency with x86.  But that SIGTRAP is *never* used, since the
> > > only way to set userspace breakpoints is through ptrace at the moment.
> > > At the same time, the triggered function is called here before the
> > > instruction is executed, so not consistent with x86 anyway.

If the SIGTRAP generation code is in ptrace_triggered() then it would
benefit only ptrace (although it is the lone user of HW-breakpoints at
the moment). Given that SIGTRAP is the only means for the user-space to
detect a breakpoint 'hit' on one of its monitored addresses, we will
generate it for all cases by keeping the code in hw_breakpoint.c (and
not in ptrace_triggered()).

However I believe that your concern here is about the timing of the
SIGTRAP signal generation and I agree with it...please find further
comments about it below.

> > > 
> > > It just seems strange to me that sending a SIGTRAP is a special case
> > > anyway.  Why can't sending a SIGTRAP be just a particular triggered
> > > function.
> > 
> > The consistency in the interface across architectures that I referred to
> > in my previous mail was w.r.t. continuous triggering of breakpoints and
> > not to implement a trigger-before or trigger-after behaviour across
> > architectures. In fact, this behaviour differs even on the same
> > processor depending upon the breakpoint type (trigger-before for
> > instructions and trigger-after for data in x86), and introducing
> > uniformity might be a) at the cost of loss of some unique & innovative
> > uses for each of them b) may not be always possible e.g. trigger-after
> > to trigger-before.
> 
> Hrm.  Well (a) is why I was suggesting an option to allow trigger
> before on powerpc.  Plus, I don't see why you think (a) is important
> for the triggered function, but not for the timing of a SIGTRAP to
> userspace.
> 

True that the timing of signal generation is inconsistent for user-space
when requested through ptrace vs requested through the interface. The
requirement for having a continuous breakpoint (as opposed to the
one-shot behaviour of ptrace) doesn't allow the signal to be delivered
in the time-window between the exception and the instruction execution.

I'm contemplating a few ways to work-arounds to ensure consistent signal
delivery timing. One such work-around would be like this:

hbp_handler(1)-->SIGTRAP-->signal_handler-->hbp_handler(2)-->
disable_hbp+enable_ss-->single_step_handler(3)-->enable_hbp+disable_ss

This method would take three exceptions for every breakpoint-hit (as
enumerated above) and will be expensive. Any alternative suggestions
with lower run-time overhead would greatly benefit the patch.

> As for (b), well there are already a bunch of things which can only be
> done on certain archs/processors, so I don't see that's anything
> really new.

Yes, the timing of SIGTRAP generation will remain dependant on the host
processor but the user should be allowed to receive breakpoints
continuously irrespective of the architecture. A one-shot behaviour only
on PPC64 (and only in user-space) doesn't seem nice.

> 
> How do you handle continuous breakpoints in the trigger-before case
> (instruction breakpoints) on x86?  Do you need to step over an
> instruction is the same manner as you do for powerpc?  In this case
> where does x86 send the SIGTRAP?
> 

Instructions breakpoints are trigger-before in x86 but the hardware
eases the task by providing RF flag (in EFLAGS register) that would
temporarily disable the instruction breakpoint while the causative
instruction is executed.

> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

Thanks,
K.Prasad
