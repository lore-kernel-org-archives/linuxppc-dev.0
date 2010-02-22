Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78AECB7CC1
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 00:17:56 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id o1MDHtIc002546
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 00:17:55 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1MDHtSl1327336
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 00:17:55 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1MDHsc6031871
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 00:17:55 +1100
Date: Mon, 22 Feb 2010 18:47:46 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100222131746.GA3228@in.ibm.com>
References: <20100215055605.GB3670@in.ibm.com>
	<20100215055914.GA6017@in.ibm.com> <20100221010130.GA5187@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100221010130.GA5187@nowhere>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Will Deacon <will.deacon@arm.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 21, 2010 at 02:01:37AM +0100, Frederic Weisbecker wrote:
> On Mon, Feb 15, 2010 at 11:29:14AM +0530, K.Prasad wrote:
> > +struct arch_hw_breakpoint {
> > +	u8		len; /* length of the target symbol */
> > +	int		type;
> > +	char		*name; /* Contains name of the symbol to set bkpt */
> > +	unsigned long	address;
> > +};
> 
> 
> 
> 
> I don't think it's a good idea to integrate the name of
> the target. This is something that should be done in a higher
> level, not in an arch backend.
> We don't even need to store it anywhere as we can resolve
> back an address easily. Symbol awareness is not something
> the hardware breakpoint should care about, neither in the
> arch nor the generic level.
> 

The 'name' field here is actually a legacy inherited from x86 code. It
is part of x86's arch-specific hw-breakpoint structure since:
- inspired by the kprobe implementation which accepts symbol name as
  input.
- kallsyms_lookup_name() was 'unexported' and a module could not resolve
  symbol names externally, so the core-infrastructure had to provide
  such facilities.
- I wasn't sure about the discussions behind 'unexporting' of
  kallsyms_lookup_name(), so did not venture to export them again (which
  you rightfully did :-)

Having said that, I'll be glad to remove this field (along with that in
x86), provided we know that there's a way for the user to resolve symbol
names on its own i.e. routines like kallsyms_lookup_name() will remain
exported.

> Also, do you think addr/len/type is enough to abstract out
> any ppc breakpoints?
> 
> This looks enough to me to express range breakpoints and
> simple breakpoints. But what about value comparison?
> (And still, there may be other trickier implementations
> I don't know in ppc).
> 

The above implementation is for PPC64 architecture that supports only
'simple' breakpoints of fixed length (no range breakpoints, no value
comparison). More on that below.
 
> > +
> > +#include <linux/kdebug.h>
> > +#include <asm/reg.h>
> > +#include <asm/system.h>
> > +
> > +/* Total number of available HW breakpoint registers */
> > +#define HBP_NUM 1
> 
> 
> Looking at the G2 PowerPc implementation, DABR and DABR2 can either
> express two different watchpoints or one range watchpoint.
> 
> There are also IABR and IABR2 for instruction breakpoints that
> follow the same above scheme. I'm not sure we can abstract that
> using a constant max linear number of resources.
> 
> 

As stated above, the patch implements breakpoints for PPC64 processors
only (http://www.power.org/resources/downloads/PowerISA_V2.06_PUBLIC.pdf),
which does not support advanced breakpoint features (which its ppc
Book-E counterpart has).
 
> > +static inline void hw_breakpoint_disable(void)
> > +{
> > +	set_dabr(0);
> > +}
> 
> 
> So, this is only about data breakpoints?
> 
> 

Yes, newer PPC64 processors do not support IABR.

> > +	/*
> > +	 * As a policy, the callback is invoked in a 'trigger-after-execute'
> > +	 * fashion
> > +	 */
> > +	(bp->overflow_handler)(bp, 0, NULL, regs);
> 
> 
> Why are you calling this explicitly instead of using the perf_bp_event()
> thing? This looks like it won't work with perf as the event won't
> be recorded by perf.
> 

Yes, should have invoked perf_bp_event() for perf to work well (on a
side note, it makes me wonder at the amount of 'extra' code that each
breakpoint exception would execute if it were not called through perf
sys-call...well, the costs of integrating with a generic infrastructure!)

> > +void ptrace_triggered(struct perf_event *bp, int nmi,
> > +		      struct perf_sample_data *data, struct pt_regs *regs)
> > +{
> > +	struct perf_event_attr attr;
> > +
> > +	/*
> > +	 * Disable the breakpoint request here since ptrace has defined a
> > +	 * one-shot behaviour for breakpoint exceptions in PPC64.
> > +	 * The SIGTRAP signal is generated automatically for us in do_dabr().
> > +	 * We don't have to do anything about that here
> > +	 */
> 
> 
> Oh, why does ptrace use a one-shot behaviour in ppc? Breakpoints
> only trigger once?
> 

Yes, ptrace breakpoints on PPC64 are designed to trigger once and this
patch retains that behaviour. It is very convenient to use one-shot
behaviour on archs where exceptions are triggered-before-execute.

> > +	if (bp) {
> > +		attr = bp->attr;
> > +		attr.bp_addr = data & ~HW_BREAKPOINT_ALIGN;
> > +
> > +		switch (data & (DABR_DATA_WRITE | DABR_DATA_READ)) {
> > +		case DABR_DATA_READ:
> > +			attr.bp_type = HW_BREAKPOINT_R;
> > +			break;
> > +		case DABR_DATA_WRITE:
> > +			attr.bp_type = HW_BREAKPOINT_W;
> > +			break;
> > +		case (DABR_DATA_WRITE | DABR_DATA_READ):
> > +			attr.bp_type = HW_BREAKPOINT_R | HW_BREAKPOINT_W;
> > +			break;
> > +		}
> > +		ret =  modify_user_hw_breakpoint(bp, &attr);
> > +		if (ret)
> > +			return ret;
> > +		thread->ptrace_bps[0] = bp;
> > +		thread->dabr = data;
> > +		return 0;
> > +	}
> > +
> > +	/* Create a new breakpoint request if one doesn't exist already */
> > +	hw_breakpoint_init(&attr);
> > +	attr.bp_addr = data & ~HW_BREAKPOINT_ALIGN;
> > +	switch (data & (DABR_DATA_WRITE | DABR_DATA_READ)) {
> > +	case DABR_DATA_READ:
> > +		attr.bp_type = HW_BREAKPOINT_R;
> > +		break;
> > +	case DABR_DATA_WRITE:
> > +		attr.bp_type = HW_BREAKPOINT_W;
> > +		break;
> > +	case (DABR_DATA_WRITE | DABR_DATA_READ):
> > +		attr.bp_type = HW_BREAKPOINT_R | HW_BREAKPOINT_W;
> > +		break;
> > +	}
> > +	thread->ptrace_bps[0] = bp = register_user_hw_breakpoint(&attr,
> > +							ptrace_triggered, task);
> > +	if (IS_ERR(bp)) {
> > +		thread->ptrace_bps[0] = NULL;
> > +		return PTR_ERR(bp);
> > +	}
> > +
> > +#endif /* CONFIG_PPC64 */
> 
> 
> 
> This looks fine for basic breakpoints. And this can probably be
> improved to integrate ranges.
> 
> But I think we did something wrong with the generic breakpoint
> interface. We are translating the arch values to generic
> attributes. Then this all will be translated back to arch
> values.
> 
> Having generic attributes is necessary for any perf event
> use from userspace. But it looks like a waste for ptrace
> that already gives us arch values. And the problem
> is the same for x86.
> 
> So I think we should implement a register_ptrace_breakpoint()
> that doesn't take perf_event_attr but specific arch informations,
> so that we don't need to pass through a generic conversion, which:
> 

I agree that the layers of conversion from generic to arch-specific
breakpoint constants is wasteful.
Can't the arch_bp_generic_fields() function be moved to
arch/x86/kernel/ptrace.c instead of a new interface?

> - is wasteful
> - won't be able to express 100% of any arch capabilities. We
>   can certainly express most arch breakpoints features through
>   the generic interface, but not all of them (given how tricky
>   the data value comparison features can be)
> 
> I will rework that during the next cycle.
> 
> Thanks.
>

Thank you for the comments. I will re-send a new version of the patch
with the perf_bp_event() substitution.

-- K.Prasad
