Return-Path: <fweisbec@gmail.com>
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by ozlabs.org (Postfix) with ESMTP id BF7A5B7CB6
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 12:58:18 +1100 (EST)
Received: by wwc33 with SMTP id 33so1045820wwc.15
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 17:58:16 -0800 (PST)
Date: Fri, 26 Feb 2010 02:58:12 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100226015807.GF5592@nowhere>
References: <20100215055605.GB3670@in.ibm.com>
	<20100215055914.GA6017@in.ibm.com> <20100221010130.GA5187@nowhere>
	<20100222131746.GA3228@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100222131746.GA3228@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Will Deacon <will.deacon@arm.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 22, 2010 at 06:47:46PM +0530, K.Prasad wrote:
> The 'name' field here is actually a legacy inherited from x86 code. It
> is part of x86's arch-specific hw-breakpoint structure since:
> - inspired by the kprobe implementation which accepts symbol name as
>   input.
> - kallsyms_lookup_name() was 'unexported' and a module could not resolve
>   symbol names externally, so the core-infrastructure had to provide
>   such facilities.
> - I wasn't sure about the discussions behind 'unexporting' of
>   kallsyms_lookup_name(), so did not venture to export them again (which
>   you rightfully did :-)
> 
> Having said that, I'll be glad to remove this field (along with that in
> x86),



Cool, I'll integrate the x86 name field removal to the .24 series



> provided we know that there's a way for the user to resolve symbol
> names on its own i.e. routines like kallsyms_lookup_name() will remain
> exported.


Yeah, I guess it's fine to keep kallsyms_lookup_name() exported.


 
> > Also, do you think addr/len/type is enough to abstract out
> > any ppc breakpoints?
> > 
> > This looks enough to me to express range breakpoints and
> > simple breakpoints. But what about value comparison?
> > (And still, there may be other trickier implementations
> > I don't know in ppc).
> > 
> 
> The above implementation is for PPC64 architecture that supports only
> 'simple' breakpoints of fixed length (no range breakpoints, no value
> comparison). More on that below.


Ok. I was just a bit confused in the middle of the several PPC breakpoint
implementations :)



> > > +	/*
> > > +	 * As a policy, the callback is invoked in a 'trigger-after-execute'
> > > +	 * fashion
> > > +	 */
> > > +	(bp->overflow_handler)(bp, 0, NULL, regs);
> > 
> > 
> > Why are you calling this explicitly instead of using the perf_bp_event()
> > thing? This looks like it won't work with perf as the event won't
> > be recorded by perf.
> > 
> 
> Yes, should have invoked perf_bp_event() for perf to work well (on a
> side note, it makes me wonder at the amount of 'extra' code that each
> breakpoint exception would execute if it were not called through perf
> sys-call...well, the costs of integrating with a generic infrastructure!)


It has the benefit of not adding extra checks in the breakpoint handler,
like checking the callback. Every breakpoint is treated the same way, which
makes the code more simple.


 
> > > +void ptrace_triggered(struct perf_event *bp, int nmi,
> > > +		      struct perf_sample_data *data, struct pt_regs *regs)
> > > +{
> > > +	struct perf_event_attr attr;
> > > +
> > > +	/*
> > > +	 * Disable the breakpoint request here since ptrace has defined a
> > > +	 * one-shot behaviour for breakpoint exceptions in PPC64.
> > > +	 * The SIGTRAP signal is generated automatically for us in do_dabr().
> > > +	 * We don't have to do anything about that here
> > > +	 */
> > 
> > 
> > Oh, why does ptrace use a one-shot behaviour in ppc? Breakpoints
> > only trigger once?
> > 
> 
> Yes, ptrace breakpoints on PPC64 are designed to trigger once and this
> patch retains that behaviour. It is very convenient to use one-shot
> behaviour on archs where exceptions are triggered-before-execute.


Ah, Why?



> > This looks fine for basic breakpoints. And this can probably be
> > improved to integrate ranges.
> > 
> > But I think we did something wrong with the generic breakpoint
> > interface. We are translating the arch values to generic
> > attributes. Then this all will be translated back to arch
> > values.
> > 
> > Having generic attributes is necessary for any perf event
> > use from userspace. But it looks like a waste for ptrace
> > that already gives us arch values. And the problem
> > is the same for x86.
> > 
> > So I think we should implement a register_ptrace_breakpoint()
> > that doesn't take perf_event_attr but specific arch informations,
> > so that we don't need to pass through a generic conversion, which:
> > 
> 
> I agree that the layers of conversion from generic to arch-specific
> breakpoint constants is wasteful.
> Can't the arch_bp_generic_fields() function be moved to
> arch/x86/kernel/ptrace.c instead of a new interface?


I'll answer in your subsequent mail :)


 
> > - is wasteful
> > - won't be able to express 100% of any arch capabilities. We
> >   can certainly express most arch breakpoints features through
> >   the generic interface, but not all of them (given how tricky
> >   the data value comparison features can be)
> > 
> > I will rework that during the next cycle.
> > 
> > Thanks.
> >
> 
> Thank you for the comments. I will re-send a new version of the patch
> with the perf_bp_event() substitution.


Thanks.
