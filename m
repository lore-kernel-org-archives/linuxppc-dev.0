Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DFB43B70C3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 08:13:07 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4984ADDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 08:13:06 +1000 (EST)
Subject: Re: Missing some interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: wael showair <showair2003@yahoo.com>
In-Reply-To: <23927820.post@talk.nabble.com>
References: <23901807.post@talk.nabble.com>
	<1244328442.31984.45.camel@pasglop> <23906859.post@talk.nabble.com>
	<23927820.post@talk.nabble.com>
Content-Type: text/plain
Date: Tue, 09 Jun 2009 08:13:00 +1000
Message-Id: <1244499180.8971.7.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-08 at 09:45 -0700, wael showair wrote:
> 
> wael showair wrote:
> > 
> >> > You cannot really rely on getting the exact same number of edge
> >> > interrupts that were emitted. At least not unless you have a hard RT
> >> > system and can guarantee that you'll always dequeue them fast enough.
> >> 
> >> Yes, my system is a hard RT & i want to receive all the interrupts that
> >> have been generated exactly
> > 
> > No. Linux is not hard RT. You cannot rely on this in a reliable way,
> > if for any reason the kernel masks interrupt for too long, which can
> > happen, you'll see that sort of coalescing happening.
> 
> what about using the RT-Preempt Patch? i can see that it will convert Linux
> ti an RTOS.

Not only I don't think it's going to guarantee RT response (just improve
it), that's a pretty big hammer to work around what is a design bug in
your system in the first place :-)

> i have check the function of do_IRQ: there is no ack called b 4 calling the
> handler but actually it does the following:

You haven't read properly :-)

> 1. it gets the irq number using :
>        irq = ppc_md.get_irq();
> 
> 2. then it calls the handler : 
> 	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE) {
> 			generic_handle_irq(irq);
> 	} else if (irq != NO_IRQ_IGNORE)
> 		/* That's not SMP safe ... but who cares ? */
> 		ppc_spurious_interrupts++;
> 
> i have checked the function of  generic_handle_irq  where it is defined
> linux/irq.h & it calls the handler

No. It call the -flow- handler, which is a different thing (yes, the
terminology can be a bit confusing). The flow handler is configured
by the interrupt controller itself and will do whatever necessary
ack'ing, masking, EOI'ing etc... for a given PIC around the call to the
actual driver handler.

> so from the previous code the processor or the pic does not ack but they
> call my ISR handler.

They do. You missed it.

> i have also read the specs of my OpenPIC & found that:
> 
> "the interrupt handler executing on the processor should then acknowledge
> the interrupt by explicitly reading the IACK register.

Reading the IACK is what get_irq() does on OpenPIC.

> The PIC unit
> interprets this read as an interrupt acknowledge (IACK) cycle; in response,
> the PIC unit returns the vector associated with the
> interrupt source to the interrupt handler routine."
> 
> "At the end of the interrupt  the End Of Interrupt (EOI) register must be
> set"

Which is done by the flow handler.

> So the processor neither reads this iack register nor the handler set the
> EOI register.
 
You obviously missed both :-)

Ben.
