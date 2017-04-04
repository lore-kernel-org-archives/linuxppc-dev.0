Return-Path: <srs0=vfdj=3m=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy9sh3GL7zDqRk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 00:12:40 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vy9sg6lDHz8syf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 00:12:39 +1000 (AEST)
Message-ID: <1491315150.4166.49.camel@kernel.crashing.org>
Subject: Re: [PATCH 06/12] powerpc/xive: Native exploitation of the XIVE
 interrupt controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 kvm-ppc@vger.kernel.org
Date: Wed, 05 Apr 2017 00:12:30 +1000
In-Reply-To: <87y3vgtjd2.fsf@concordia.ellerman.id.au>
References: <20170320064914.4437-1-benh@kernel.crashing.org>
 <20170320064914.4437-6-benh@kernel.crashing.org>
 <87y3vgtjd2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-04 at 23:03 +1000, Michael Ellerman wrote:
> 
> >  14 files changed, 2186 insertions(+), 12 deletions(-)
> 
> I'm not going to review this in one go, given it's 10:30pm already.

Well, good, I was about to send (well tomorrow morning actually) v2
hoping it was going to be final since nobody else hard reviewed it :-)

> +extern void __iomem *xive_tm_area;
> 
> I think Paul already commented on "tm" being an overly used acronym.

He asked me to spell it out in a comment which I did in v2. I haven't
changed the name of the variable though which percolates through the
KVM bits etc... I could rename it (painfully) to use "tma" instead
(Thread Management Area).

> > +extern u32 xive_tm_offset;
> > +
> > +/*
> > + * Per-irq data (irq_get_handler_data for normal IRQs), IPIs
> > + * have it stored in the xive_cpu structure. We also cache
> > + * for normal interrupts the current target CPU.
> > + */
> > +struct xive_irq_data {
> > +	/* Setup by backend */
> > +	u64 flags;
> > +#define XIVE_IRQ_FLAG_STORE_EOI	0x01
> > +#define XIVE_IRQ_FLAG_LSI	0x02
> > +#define XIVE_IRQ_FLAG_SHIFT_BUG	0x04
> > +#define XIVE_IRQ_FLAG_MASK_FW	0x08
> > +#define XIVE_IRQ_FLAG_EOI_FW	0x10
> 
> I don't love that style, prefer them just prior to the struct.

I much prefer having the definitions next to the variable they apply
to but if you feel strongly about it, I will move them.
 
> > +	u64 eoi_page;
> > +	void __iomem *eoi_mmio;
> > +	u64 trig_page;
> > +	void __iomem *trig_mmio;
> > +	u32 esb_shift;
> > +	int src_chip;
> 
> Why not space out the members like you do in xive_q below, I think
> that looks better given you have the long __iomem lines.

Ok.

> > +
> > +	/* Setup/used by frontend */
> > +	int target;
> > +	bool saved_p;
> > +};
> > +#define XIVE_INVALID_CHIP_ID	-1
> > +
> > +/* A queue tracking structure in a CPU */
> > +struct xive_q {
> > +	__be32 			*qpage;
> > +	u32			msk;
> > +	u32			idx;
> > +	u32			toggle;
> > +	u64			eoi_phys;
> > +	void __iomem		*eoi_mmio;
> > +	u32			esc_irq;
> > +	atomic_t		count;
> > +	atomic_t		pending_count;
> > +};
> > +
> > +/*
> > + * "magic" ESB MMIO offsets
> 
> What's an ESB?

Well, the problem here is that if I start answering that one along with
a chunk of the rest of your questions, I basically end up writing a
summary of the XIVE specification in comments, which would probably
take 2 or 3 pages ;-)

I don't know where to start there or rather how far to go. I could
spell out the acronyms but it's not necessarily that useful.

Another problem with XIVE is that everything has 2 names ! The original
design came with (rather sane) names but the "architects" later on
renamed everything into weird stuff. For example, the HW name of an
event queue descriptor is "EQD". The "architecture" name is "END"
(Event Notification Descriptor I *think*).

Sadly bcs we have docs mix & matching both, I ended up accidentally
making a bit of a mess myself though I've generally favored the HW
names (EQ vs. END, VP (Virtual Processor) vs. NVT (Notification Virtual
Target), etc... 

> If here you put:
> 
> #define pr_fmt(fmt) "xive: " fmt
> 
> Then you can drop the prefix from every pr_xxx() in the whole file.

Yup. I live in the past obviously :-)

> > +/*
> > + * A "disabled" interrupt should never fire, to catch problems
> > + * we set its logical number to this
> > + */
> > +#define XIVE_BAD_IRQ		0x7fffffff
> 
> Can it be anything? How about 0x7fbadbad ?

It can be anything as long as we never assign that number to an
interrupt. So we have to limit the IRQ numbers to that value. Talking
of which I need to make sure I enforce the limitation on the numbers
today.

> > +#define XIVE_MAX_IRQ		(XIVE_BAD_IRQ - 1)
> > +
> > +/* An invalid CPU target */
> > +#define XIVE_INVALID_TARGET	(-1)
> > +
> > +static u32 xive_read_eq(struct xive_q *q, u8 prio, bool just_peek)
> 
> Can it have a doc comment? And tell me what an EQ is?

I added a description in v2.

> > +{
> > +	u32 cur;
> > +
> > +	if (!q->qpage)
> > +		return 0;
> 
> A newline or ..
> 
> > +	cur = be32_to_cpup(q->qpage + q->idx);
> > +	if ((cur >> 31) == q->toggle)
> > +		return 0;
> 
> .. two wouldn't hurt here.
> 
> > +	if (!just_peek) {
> > +		q->idx = (q->idx + 1) & q->msk;
> > +		if (q->idx == 0)
> > +			q->toggle ^= 1;
> > +	}
> > +	return cur & 0x7fffffff;
> 
> Is that XIVE_BAD_IRQ ?

No. This is a mask. The top bit is the toggle valid bit, we mask it out
on the way back. Will add a comment.

> > +}
> > +
> > +static u32 xive_scan_interrupts(struct xive_cpu *xc, bool
> > just_peek)
> > +{
> > +	u32 hirq = 0;
> 
> Is that a hwirq or something different?

not sure why I called it hirq ... it's what comes out of the queue
which is a linux irq number since we reconfigure the hw to give those
to us directly.

> > +	u8 prio;
> > +
> > +	/* Find highest pending priority */
> > +	while (xc->pending_prio != 0) {
> > +		struct xive_q *q;
> > +
> > +		prio = ffs(xc->pending_prio) - 1;
> > +		DBG_VERBOSE("scan_irq: trying prio %d\n", prio);
> > +
> > +		/* Try to fetch */
> > +		hirq = xive_read_eq(&xc->queue[prio], prio,
> > just_peek);
> > +
> > +		/* Found something ? That's it */
> > +		if (hirq)
> > +			break;
> > +
> > +		/* Clear pending bits */
> > +		xc->pending_prio &= ~(1 << prio);
> > +
> > +		/*
> > +		 * Check if the queue count needs adjusting due to
> > +		 * interrupts being moved away.
> > +		 */
> > +		q = &xc->queue[prio];
> > +		if (atomic_read(&q->pending_count)) {
> > +			int p = atomic_xchg(&q->pending_count, 0);
> > +			if (p) {
> > +				WARN_ON(p > atomic_read(&q-
> > >count));
> > +				atomic_sub(p, &q->count);
> 
> I am not sure what's going on there.

Black magic :-) It's documented in a comment elsewhere iirc. I could
try to add a reference to it in the comment above.

> > +			}
> > +		}
> > +	}
> > +
> > +	/* If nothing was found, set CPPR to 0xff */
> 
> Would be nice to spell out CPPR somewhere.

We never did on XICS :-) Means the same thing. But yeah I can spell it
out in the first use.

> > +	if (hirq == 0)
> > +		prio = 0xff;
> > +
> > +	/* Update HW CPPR to match if necessary */
> > +	if (prio != xc->cppr) {
> > +		DBG_VERBOSE("scan_irq: adjusting CPPR to %d\n",
> > prio);
> > +		xc->cppr = prio;
> > +		out_8(xive_tm_area + xive_tm_offset + TM_CPPR,
> > prio);
> 
> What's the out_8() doing? I was expecting it to use xc, or something
> per-cpu.

The HW makes it magically per-cpu :-) That's the whole point of the
TMA. The powerbus knows where the accesses come from and will route you
to the right "instance" magically.

It's especially important in guests because it means that you don't
have to create some kind of mapping that has to change as the guest
gets reschedule on a different HW CPU.

The guest just accesses the TMA at its fixed address and the HW sorts
it out (it knows what guest is running on what physical CPU as KVM
tells it when the guest gets context switched in).

> > +	}
> > +
> > +	return hirq;
> > +}
> > +
> > +#ifdef CONFIG_XMON
> > +static void xive_dump_eq(const char *name, struct xive_q *q)
> > +{
> > +	u32 i0, i1, idx;
> > +
> > +	if (!q->qpage)
> > +		return;
> > +	idx = q->idx;
> > +	i0 = be32_to_cpup(q->qpage + idx);
> > +	idx = (idx + 1) & q->msk;
> > +	i1 = be32_to_cpup(q->qpage + idx);
> > +	xmon_printf("  %s Q T=%d %08x %08x ...\n", name,
> > +		    q->toggle, i0, i1);
> > +}
> > +
> > +void xmon_xive_do_dump(int cpu)
> > +{
> > +	struct xive_cpu *xc = per_cpu(xive_cpu, cpu);
> > +	struct xive_irq_data *xd;
> > +	uint64_t val, offset;
> 
> u64 ?

Yeah yeah ... :)

> > +static void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data
> > *xd)
> > +{
> > +	/* If the XIVE supports the new "store EOI facility, use
> > it */
> > +	if (xd->flags & XIVE_IRQ_FLAG_STORE_EOI)
> > +		out_be64(xd->eoi_mmio, 0);
> > +	else if (hw_irq && xd->flags & XIVE_IRQ_FLAG_EOI_FW) {
> > +		if (WARN_ON_ONCE(!xive_ops->eoi))
> > +			return;
> > +		xive_ops->eoi(hw_irq);
> > +	} else {
> > +		uint8_t eoi_val;
> 
> u8?

Do we actually care ? :-)

> > +/* Enable this for using queue MMIO page for EOI. We don't
> > currently
> > + * use it as we always notify
> > + */
> > +#undef USE_QUEUE_MMIO
> 
> Dead code? Or we want to keep it?

We might want to run some tests with it at some point, though I haven't
tested the code so it probably doesn't work... I'll probably remove it
for now.

> > +/* This can be called multiple time to change a queue
> > configuration */
> > +int xive_native_configure_queue(u32 vp_id, struct xive_q *q, u8
> > prio,
> > +				__be32 *qpage, u32 order, bool
> > can_escalate)
> > +{
> > +	s64 rc = 0;
> > +	__be64 qeoi_page_be;
> > +	__be32 esc_irq_be;
> > +	u64 flags, qpage_phys;
> > +
> > +	/* If there's an actual queue page, clean it */
> > +	if (order) {
> > +		BUG_ON(!qpage);
> 
> Can't we just return an error?

Maybe but this should really really never happen, and if it does a
backtrace is welcome. Maybe I can use a WARN_ON instead and return an
error.

> > +
> > +	xive_provision_chips = kzalloc(4 *
> > xive_provision_chip_count,
> > +				       GFP_KERNEL);
> > +	BUG_ON(!xive_provision_chips);
> 
> return false?

We are pretty stuffed if that happens. Well, ok, KVM is pretty stuffed,
the host can probably survive, but hell, if we can't allocate a few
bytes at boot time I think we have bigger worries :-)

> > +
> > +	rc = of_property_read_u32_array(np, "ibm,xive-provision-
> > chips",
> > +					xive_provision_chips,
> > +					xive_provision_chip_count)
> > ;
> 
> ...
> > diff --git a/arch/powerpc/sysdev/xive/xive-internal.h
> > b/arch/powerpc/sysdev/xive/xive-internal.h
> > new file mode 100644
> > index 0000000..e736fc5
> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/xive/xive-internal.h
> > @@ -0,0 +1,51 @@
> 
> Copyright missing.
> 
> > +#ifndef __XIVE_INTERNAL_H
> > +#define __XIVE_INTERNAL_H
> 
> ...
> > diff --git a/arch/powerpc/sysdev/xive/xive-regs.h
> > b/arch/powerpc/sysdev/xive/xive-regs.h
> > new file mode 100644
> > index 0000000..f1edb23
> > --- /dev/null
> > +++ b/arch/powerpc/sysdev/xive/xive-regs.h
> > @@ -0,0 +1,88 @@
> 
> Copyright missing.
> 
> > +#ifndef __XIVE_REGS_H__
> > +#define __XIVE_REGS_H__
> 
> ...
> > diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> > index 16321ad..c71e919 100644
> > --- a/arch/powerpc/xmon/xmon.c
> > +++ b/arch/powerpc/xmon/xmon.c
> 
> ...
> > +
> > +static void dump_one_xive_irq(uint32_t num)
> 
> u32?
> 
> > +{
> > +	int64_t rc;
> > +	__be64 vp;
> > +	uint8_t prio;
> 
> u8?
> 
> 
> zzzzz ...

rrrrzzzz...

Ben.
