Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFF942BDF2
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Nov 2004 09:19:54 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20041103123050.GA5057@iram.es>
References: <41816863.9020000@vision.caltech.edu>
	<1099006771.29690.83.camel@gaston> <4181878C.20605@vision.caltech.edu>
	<1099011090.29689.96.camel@gaston> <20041029101017.GA28149@iram.es>
	<1099090806.29689.140.camel@gaston>  <20041103123050.GA5057@iram.es>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 09:11:41 +1100
Message-Id: <1099519901.900.49.camel@gaston>
Mime-Version: 1.0
Cc: Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Disabling interrupts on a SMP system
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2004-11-03 at 13:30 +0100, Gabriel Paubert wrote:

> Well, actually I no more have a fix, sorry for that. I believed so but I 
> was mistaken, unless you consider correct a fix which would say that 
> all interrupts have the SA_INTERRUPT flag set.

Gack... that would be bad.

> > Looks like between clearing the irq source and exiting the handler, the
> > IRQ line stays asserted a bit longer or so ...
> 
> Not quite, what happens is that we have "shadow interrupts" from the
> OpenPIC. The sequence should be:
> 1) read the interrupt vector
> 2) the interrupt request is released at the hardware interrupt
>    pin of the processor
> 3) we can now enable interrupts if we want...
> 
> Actually 2) is a bit slow, I suspect that the signal from the chipset
> is an open-drain with a passive pull-up (there might even be a bit
> in the chipset to control whether the decativation of the interrupt
> output pin is active or not, I've seen in in other cases) and this
> results in a spurious interrupt taken at step 3.

Ah... so that would explain why newer machines don't show it ? the
openpic is faster or such ? I'll test you theory by adding a small delay
after reading the ack (just to test)...

> I have also seen a few spurious interrupts of the type you
> suspect, from the serial and adb drivers, but they  were 
> very few in comparison (0.01% or so, let's tackle the bulk
> of them first).

Right, that's what I would expect.
> >
> Ok, this changes everything, this means that since all hardware interrupts 
> are set at the same priority, they are effectively serialized in hardware, 
> so why reenable interrupts in the case the SA_INTERRUPT flag is not set?

Well, we may want to play with priority later, and there are the DEC
interrupts that I want to still take while processing HW ones. But this
serialisation is a "good thing", I think, to avoid possible kernel stack
overflows. We have very few edge interrupts so I suppose that
serialisation is s almost what happens today already

> I'm speaking only for UP, I don't have any SMP machine (and my laptop
> which shows the problem obviously is not) and I don't know if priorities
> are used for IPI. I believe that OpenPIC timers are never used, but I
> might be wrong...

We don't use the timers (and Apple removed them in latest chipsets) but
I think we raise the IPI priority above normal IRQs yes.

> Actually I never understood very well the goal of the SA_INTERRUPT flag,
> since on shared interrupts it will depend on whoever is first on the
> list, which is more or less equivalent to determine it from the phase
> of the moon. The only way it could make sense would be to insert 
> SA_INTERRUPT handlers at the head of the queue, and non SA_INTERRUPT 
> ones at the tail, dividing the handlers into 2 categories (or alternatively 
> to have two handler lists per vector). But most of these issues do not 
> affect PPC machines to my knowledge. 

It's for legacy ISA cruft I'd say :)

> In short I believe that this is a historical artifact from when 
> interrupts could not be shared (edge-triggered only on ISA bus);  
> at that time it did make sense to perform this kind of distinction 
> between slow and fast interrupts.

Yes.

> I have appended the patch that I'm currently running that shows the
> behaviour and adds a timebase tick delay to a wait loop every time
> the spurious interrupt on reenabling interrupt in interrupt dispatcher 
> is taken. On my G3/400, the delay converges to 4 ticks rapidly during
> boot and increases to 5 when I start the modem, that's about 200ns.
> The patch is horrible, unsafe and disgusting, but still usable as a 
> tool to locate the source of spurious interrupts.

Ah cool, a patch...  :)

It's strange tho... the interrupt ACK beeing a read, I would have
expected it to be rather synchronous with the bus, unless the MPIC
itself completes the read transaction before actually getting rid of the
IRQ signal (or mayb the CPU itself is latching it a bit too long because
of a crappy pull up as you mentioned).
