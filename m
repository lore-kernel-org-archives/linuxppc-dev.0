Return-Path: <paubert@iram.es>
Received: from ltgp.iram.es (ltgp.iram.es [150.214.224.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EC352BDEB
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Nov 2004 00:06:28 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 4 Nov 2004 13:57:33 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041104125733.GA22676@iram.es>
References: <41816863.9020000@vision.caltech.edu>
	<1099006771.29690.83.camel@gaston>
	<4181878C.20605@vision.caltech.edu>
	<1099011090.29689.96.camel@gaston> <20041029101017.GA28149@iram.es>
	<1099090806.29689.140.camel@gaston> <20041103123050.GA5057@iram.es>
	<1099519901.900.49.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099519901.900.49.camel@gaston>
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

On Thu, Nov 04, 2004 at 09:11:41AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2004-11-03 at 13:30 +0100, Gabriel Paubert wrote:
> 
> > Well, actually I no more have a fix, sorry for that. I believed so but I 
> > was mistaken, unless you consider correct a fix which would say that 
> > all interrupts have the SA_INTERRUPT flag set.
> 
> Gack... that would be bad.

Well, not that bad if the interrupt handlers are _really_ short and just
postpone the job to a tasklet/bottom-half or however it is called these
days. A series of short interrupts that are serialized and reuse
the same part of the stack, avoiding stack overflows and thrashing
less cache.

Now there are interrupt handlers that can't be as lightweight as I would
like, for example the one I wrote for VME busses. Essentially they are 
another level of dispatch through a cascaded interrupt controller, and 
that's pretty much impossible to avoid.

> 
> > > Looks like between clearing the irq source and exiting the handler, the
> > > IRQ line stays asserted a bit longer or so ...
> > 
> > Not quite, what happens is that we have "shadow interrupts" from the
> > OpenPIC. The sequence should be:
> > 1) read the interrupt vector
> > 2) the interrupt request is released at the hardware interrupt
> >    pin of the processor
> > 3) we can now enable interrupts if we want...
> > 
> > Actually 2) is a bit slow, I suspect that the signal from the chipset
> > is an open-drain with a passive pull-up (there might even be a bit
> > in the chipset to control whether the decativation of the interrupt
> > output pin is active or not, I've seen in in other cases) and this
> > results in a spurious interrupt taken at step 3.
> 
> Ah... so that would explain why newer machines don't show it ? the
> openpic is faster or such ? I'll test you theory by adding a small delay
> after reading the ack (just to test)...

Actually, as you see on the patch, the delay is only useful
on non SA_INTERRUPT handlers. I don't see them on my PM 466,
but it has a UniNorth 1.5 and it does not really actively use 
the same interrupts.

> 
> > I have also seen a few spurious interrupts of the type you
> > suspect, from the serial and adb drivers, but they  were 
> > very few in comparison (0.01% or so, let's tackle the bulk
> > of them first).
> 
> Right, that's what I would expect.

I forgot the PMU in the list.


> Well, we may want to play with priority later, and there are the DEC
> interrupts that I want to still take while processing HW ones. But this
> serialisation is a "good thing", I think, to avoid possible kernel stack
> overflows. We have very few edge interrupts so I suppose that
> serialisation is s almost what happens today already

Indeed the DEC interrupts are the problem, BTW I have to clean up
some timekeeping patch because there are other problems in this
area right now.

> 
> > I'm speaking only for UP, I don't have any SMP machine (and my laptop
> > which shows the problem obviously is not) and I don't know if priorities
> > are used for IPI. I believe that OpenPIC timers are never used, but I
> > might be wrong...
> 
> We don't use the timers (and Apple removed them in latest chipsets) but
> I think we raise the IPI priority above normal IRQs yes.

This makes sense, besides this some OpenPIC documentations claim that 
every IPI (and timer) should have a different priority level.

> 
> > Actually I never understood very well the goal of the SA_INTERRUPT flag,
> > since on shared interrupts it will depend on whoever is first on the
> > list, which is more or less equivalent to determine it from the phase
> > of the moon. The only way it could make sense would be to insert 
> > SA_INTERRUPT handlers at the head of the queue, and non SA_INTERRUPT 
> > ones at the tail, dividing the handlers into 2 categories (or alternatively 
> > to have two handler lists per vector). But most of these issues do not 
> > affect PPC machines to my knowledge. 
> 
> It's for legacy ISA cruft I'd say :)
> 
> > In short I believe that this is a historical artifact from when 
> > interrupts could not be shared (edge-triggered only on ISA bus);  
> > at that time it did make sense to perform this kind of distinction 
> > between slow and fast interrupts.
> 
> Yes.

But with shared interrupts as seen on PCI on i386 (especially 
notebooks where you often see almost all interrupts sharing the
same PIC input), the fact that an interrupt is classified as fast 
or slow depends on who is first in the list of handlers. This 
does not make _any_ sense.

> 
> > I have appended the patch that I'm currently running that shows the
> > behaviour and adds a timebase tick delay to a wait loop every time
> > the spurious interrupt on reenabling interrupt in interrupt dispatcher 
> > is taken. On my G3/400, the delay converges to 4 ticks rapidly during
> > boot and increases to 5 when I start the modem, that's about 200ns.
> > The patch is horrible, unsafe and disgusting, but still usable as a 
> > tool to locate the source of spurious interrupts.
> 
> Ah cool, a patch...  :)
> 
> It's strange tho... the interrupt ACK beeing a read, I would have
> expected it to be rather synchronous with the bus, unless the MPIC
> itself completes the read transaction before actually getting rid of the
> IRQ signal (or mayb the CPU itself is latching it a bit too long because
> of a crappy pull up as you mentioned).

Well, it takes about 2-3 bus cycles for the signal to reach the 
core from the pin due to resynchronization/metastability avoidance 
flip-flops (I read it somewhere in a PPC doc), so it's more or
less guaranted that:
	
	read the vector (lwz or lwbrx)
	ensure that the read is performed (tw+isync, or sync)
	mtmsr with EE set
	
will result in a "shadow" interrupt, whatever processor in the G3/G4
series you use, but the internal hardware delay is less than a timebase 
tick and I need 5 (that's at least 16 bus clocks) to be safe.

Now I don't know the exact reason, it may be an open-drain output 
because some version was designed to share the processor interrupt 
request signal with another chip. Maybe there is a bit to control 
this (open-drain or not) but you'd need the docs, or maybe the 
internal logic is slow and takes time to react and remove the 
interrupt request to the processor.  

But all of this is speculation, the fact is that I get these "shadow" 
interrupts and my scary patch proves this.

	Regards,
	Gabriel
