Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C14F91F.F382ABE3@labs.mot.com>
Date: Mon, 10 Dec 2001 12:04:16 -0600
From: Steve Rossi <srossi@labs.mot.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: high priority interrupts disabled
References: <3C112297.6DE37608@labs.mot.com> <3C114C63.3050102@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Steve Rossi wrote:
>
> > .....IRQ2 gets asserted and remains asserted (without
> > being serviced) in excess of 10ms during which IRQ6 (hard disk) is
> > asserted and quickly serviced over 120 times, and IRQ1 is also asserted
> > and quickly serviced several times in that 10ms. IRQ2 doesn't get
> > serviced until the disk activity completes

>
> ...I wonder if IRQ2 is being masked.  It is possible
> to mask an irq, service others, then unmask the irq again, so ensure your
> driver isn't doing this.  Of course, we are also doing a mask_and_ack in
> the 8xx interrupt handler, which may not be the right thing either.

I verified that IRQ2 is not getting masked in the SIMASK register during the
disk I/O which is when it can get held off. I've also tried doing ack only
instead of mask_and_ack - I couldn't boot past the enabling of the FEC
ethernet when I did this, so I didn't spend much more time on it.

> > .... IRQ1 is requested with the SA_INTERRUPT flag,
> > while IRQ2 is not - should this matter?
>
> I didn't think this flag had any effect anymore.

SA_INTERRUPT definitely has an effect: in irq.c in handle_irq_event() :
if (!(action->flags & SA_INTERRUPT))
                __sti();

apparently, interrupts installed with SA_INTERRUPT flag will run with external
interrupts disabled (EE bit cleared in MSR). right? or am I missing something.

I've also found that if I install my IRQ2 using the SA_INTERRUPT flag, I do
not see the problem. But when IRQ2 is installed with SA_INTERRUPT, IRQ1 cannot
preempt it (which is not the behavior that I want) presumably because it it
running with external interrupt disabled.  Apparently the IDE interrupt is
installed with the SA_INTERRUPT flag set as well (documented in ide-probe.c).
Next I will experiment with installing the IDE interrupt without the
SA_INTERRUPT flag.

Another observation that I've made is that the problem doesn't occur all the
time, but it seems to be triggered when IRQ2 is asserted during IRQ6
processing (or while IRQ6 is asserted). If IRQ6 really is being installed with
SA_INTERRUPT, it would make sense that IRQ2 wouldn't get serviced until IRQ6
completes, but IRQ6 completes over 120 times before IRQ2 is serviced - that
doesn't make sense.

If anyone has any more information regarding how the SA_INTERRUPT flag works
that will be helpful. I suspect the problem that I am having is rooted in
something that is going on in the IDE driver code as opposed to the kernel
interrrupt processing - but I'm not ruling that out either. If anyone is more
familar with the IDE driver who can offer a suggestion as to why this is
happening I would appreciate that. If there are any other suggestions, I'd
love to hear them too.

Thanks!
Steve

--
-------------------------------------------------------
Steven K. Rossi                     srossi@labs.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
