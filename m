Return-Path: <dwg@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4BC3CB70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 16:50:22 +1000 (EST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 22E70DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 16:50:20 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5F6o87j030536
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 16:50:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5F6oEEd1003640
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 16:50:14 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5F6oE90008295
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 16:50:14 +1000
Date: Mon, 15 Jun 2009 16:40:45 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 2/6] Introduce PPC64 specific Hardware Breakpoint
	interfaces
Message-ID: <20090615064045.GB26817@yookeroo.seuss>
References: <20090603162741.197115376@prasadkr_t60p.in.ibm.com>
	<20090603163511.GC5197@in.ibm.com>
	<20090605051158.GJ2054@yookeroo.seuss>
	<20090610064349.GA6912@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090610064349.GA6912@in.ibm.com>
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

On Wed, Jun 10, 2009 at 12:13:49PM +0530, K.Prasad wrote:
> On Fri, Jun 05, 2009 at 03:11:58PM +1000, David Gibson wrote:
> > On Wed, Jun 03, 2009 at 10:05:11PM +0530, K.Prasad wrote:
> 
> Hi David,
> 	Sorry for the delay in response below. In the meanwhile, I
> discovered an issue in detecting stray exceptions that affected
> user-space handling of breakpoints. I've made some changes to correct
> that behaviour which will be included in version VI of the patchset.

[snip]
> > > +	/*
> > > +	 * User-space requests will always have the address field populated
> > > +	 * For kernel-addresses, either the address or symbol name can be
> > > +	 * specified.
> > > +	 */
> > > +	if (bp->info.name)
> > > +		bp->info.address = (unsigned long)
> > > +					kallsyms_lookup_name(bp->info.name);
> > 
> > Archs don't have to implement this name lookup stuff, but it looks
> > like most of them would - so it looks like there ought to be a helper
> > function in generic code that will do the check / name lookup stuff.
> 
> It doesn't turn out to be very generic. The IO breakpoints in x86, the
> address-range (only) breakpoints in S390 and perhaps 4xx powerpc
> processors were what made me think that this should remain in
> arch-specific code. In these cases, we might have to deal only with
> breakpoint addresses and not names.

Hrm, ok.  I was suggesting a helper function that those archs which
can use it call at need, not moving the address lookup to generic code
in the sense of being used everywhere.  Whatever, it's not that
important at this stage.

> > > +	if (bp->info.address)
> > > +		return 0;
> > 
> > Hrm.. you realise there's no theoretical reason a userspace program
> > couldn't put a breakpoint at address 0...?
> 
> I agree. I think there must be parts of code that works based on this
> assumption. Will check and remove them.

Ok, good.

[snip]
> > > +	else {
> > > +		/*
> > > +		 * This exception is triggered not because of a memory access on
> > > +		 * the monitored variable but in the double-word address range
> > > +		 * in which it is contained. We will consume this exception,
> > > +		 * considering it as 'noise'.
> > > +		 */
> > > +		rc = NOTIFY_STOP;
> > > +		goto out;
> > > +	}
> > > +	is_one_shot = (bp->triggered == ptrace_triggered) ? 1 : 0;
> > 
> > Ouch, explicitly special-casing ptrace_triggered is pretty nasty.
> > Since the bp_info is already arch specific, maybe it should include a
> > flag to indicate whether the breakpoint is one-shot or not.
> > 
> 
> The reason to check for ptrace_triggered is to contain the one-shot
> behaviour only to ptrace (thus retaining the semantics) and not to extend
> them to all user-space requests through
> register_user_hw_breakpoint().

Right, but couldn't you implement that withing ptrace_triggered
itself, without a special test here, by having it cancel the
breakpoint.

> A one-shot behaviour for all user-space requests would create more work
> for the user-space programs (such as re-registration) and will leave open
> a small window of opportunity for debug register grabbing by kernel-space
> requests.
> 
> So, in effect a request through register_user_hw_breakpoint() interface
> will behave as under:
> - Single-step over the causative instruction that triggered the
>   breakpoint exception handler.
> - Deliver the SIGTRAP signal to user-space after executing the causative
>   instruction.
> 
> This behaviour is in consonance with that of kernel-space requests and
> those on x86 processors, and helps define a consistent behaviour across
> architectures for user-space.
> 
> Let me know what you think on the same.

I certainly see the value in consistent semantics across archs.
However, I can also see uses for the powerpc trap-before-execute
behaviour.  That's why I'm suggesting it might be worth having an
arch-specific flag.

[snip]
> > > +int __kprobes single_step_dabr_instruction(struct die_args *args)
> > > +{
> > > +	struct pt_regs *regs = args->regs;
> > > +	int cpu = get_cpu();
> > > +	int ret = NOTIFY_DONE;
> > > +	siginfo_t info;
> > > +	unsigned long this_dabr_data = per_cpu(dabr_data, cpu);
> > > +
> > > +	/*
> > > +	 * Check if we are single-stepping as a result of a
> > > +	 * previous HW Breakpoint exception
> > > +	 */
> > > +	if (this_dabr_data == 0)
> > > +		goto out;
> > > +
> > > +	regs->msr &= ~MSR_SE;
> > > +	/* Deliver signal to user-space */
> > > +	if (this_dabr_data < TASK_SIZE) {
> > > +		info.si_signo = SIGTRAP;
> > > +		info.si_errno = 0;
> > > +		info.si_code = TRAP_HWBKPT;
> > > +		info.si_addr = (void __user *)(per_cpu(dabr_data, cpu));
> > > +		force_sig_info(SIGTRAP, &info, current);
> > 
> > Uh.. I recall mentioning in my previous review that in order to match
> > previous behaviour we need to deliver the userspace signal *before*
> > stepping over the breakpointed instruction, rather than after (which
> > I guess is why breakpoints are one-shot in the old scheme).
> 
> This code would implement the behaviour as stated in the comment for
> user-space requests above.

And you're relying on the old trap-sending code in do_dabr for ptrace
requests?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
