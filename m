Return-Path: <paubert@iram.es>
Received: from ltgp.iram.es (ltgp.iram.es [150.214.224.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7AE462BDEB
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Nov 2004 23:43:31 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 3 Nov 2004 13:30:51 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041103123050.GA5057@iram.es>
References: <41816863.9020000@vision.caltech.edu>
	<1099006771.29690.83.camel@gaston>
	<4181878C.20605@vision.caltech.edu>
	<1099011090.29689.96.camel@gaston> <20041029101017.GA28149@iram.es>
	<1099090806.29689.140.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099090806.29689.140.camel@gaston>
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

On Sat, Oct 30, 2004 at 09:00:06AM +1000, Benjamin Herrenschmidt wrote:
> 
> > I alway wondered why the decrementer interrupts are not listed, 
> > actually. Perhaps even with a count of the decrementer interrupts
> > which result in multiple updates of jiffies, because they indicate
> > that something has avery high latency.
> > 
> > BTW, on my Pismo, the number of bad interrupts is amazing:
> >
> > .../...
> >
> > BAD:   21458276
> > 
> > in about one week uptime, but over half the time sleeping.
> > 
> > I have a fix for that, but it's not yet ready for submission. 
> > I might find time over the week-end.
> 
> Ah ok, what is it ? Those seem to be "short" interrupts, they don't
> happen on my tipb but they do happen on paul's older one (same mobo as
> Pismo).

Well, actually I no more have a fix, sorry for that. I believed so but I 
was mistaken, unless you consider correct a fix which would say that 
all interrupts have the SA_INTERRUPT flag set.

> 
> Looks like between clearing the irq source and exiting the handler, the
> IRQ line stays asserted a bit longer or so ...

Not quite, what happens is that we have "shadow interrupts" from the
OpenPIC. The sequence should be:
1) read the interrupt vector
2) the interrupt request is released at the hardware interrupt
   pin of the processor
3) we can now enable interrupts if we want...

Actually 2) is a bit slow, I suspect that the signal from the chipset
is an open-drain with a passive pull-up (there might even be a bit
in the chipset to control whether the decativation of the interrupt
output pin is active or not, I've seen in in other cases) and this
results in a spurious interrupt taken at step 3.

I have also seen a few spurious interrupts of the type you
suspect, from the serial and adb drivers, but they  were 
very few in comparison (0.01% or so, let's tackle the bulk
of them first).

> 
> BTW, We should remove the cruft of early/late eoi too while we are at
> it. A single "late" EOI is all we need. The MPIC will latch an edge irq
> coming in between the ACK and the EOI and we don't want the CPU priority
> to drop too early.

Ok, this changes everything, this means that since all hardware interrupts 
are set at the same priority, they are effectively serialized in hardware, 
so why reenable interrupts in the case the SA_INTERRUPT flag is not set?

I'm speaking only for UP, I don't have any SMP machine (and my laptop
which shows the problem obviously is not) and I don't know if priorities
are used for IPI. I believe that OpenPIC timers are never used, but I
might be wrong...

Actually I never understood very well the goal of the SA_INTERRUPT flag,
since on shared interrupts it will depend on whoever is first on the
list, which is more or less equivalent to determine it from the phase
of the moon. The only way it could make sense would be to insert 
SA_INTERRUPT handlers at the head of the queue, and non SA_INTERRUPT 
ones at the tail, dividing the handlers into 2 categories (or alternatively 
to have two handler lists per vector). But most of these issues do not 
affect PPC machines to my knowledge. 

In short I believe that this is a historical artifact from when 
interrupts could not be shared (edge-triggered only on ISA bus);  
at that time it did make sense to perform this kind of distinction 
between slow and fast interrupts.

I have appended the patch that I'm currently running that shows the
behaviour and adds a timebase tick delay to a wait loop every time
the spurious interrupt on reenabling interrupt in interrupt dispatcher 
is taken. On my G3/400, the delay converges to 4 ticks rapidly during
boot and increases to 5 when I start the modem, that's about 200ns.
The patch is horrible, unsafe and disgusting, but still usable as a 
tool to locate the source of spurious interrupts.

	Regards,
	Gabriel

===== arch/ppc/kernel/irq.c 1.44 vs edited =====
--- 1.44/arch/ppc/kernel/irq.c	2004-08-31 17:27:26 +02:00
+++ edited/arch/ppc/kernel/irq.c	2004-10-16 20:07:19 +02:00
@@ -411,18 +411,35 @@
 	return 0;
 }
 
+
+static int hardirq_shadow_ticks=0;
+extern unsigned long __hardirq_shadow_nip;
 static inline void
 handle_irq_event(int irq, struct pt_regs *regs, struct irqaction *action)
 {
 	int status = 0;
 	int ret;
 
-	if (!(action->flags & SA_INTERRUPT))
+	if (!(action->flags & SA_INTERRUPT)) {
+		int start, now;
+		asm volatile(	"	isync\n"
+				"	mftb %0\n"
+				"1:	mftb %1\n"
+				"	sub %1,%1,%0\n"
+				"	cmplw %1,%2\n"
+				"	blt 1b\n"
+				"	isync\n"
+				: "=&r" (start), "=&r" (now)
+				: "r" (hardirq_shadow_ticks)
+				: "cr0");
 		local_irq_enable();
+		/* FIXME: happens to work */
+		asm volatile("\n__hardirq_shadow_nip: isync\n");
+	}
 
 	do {
 		ret = action->handler(irq, action->dev_id, regs);
-		if (ret == IRQ_HANDLED)
+		if (likely(ret == IRQ_HANDLED))
 			status |= action->flags;
 		action = action->next;
 	} while (action);
@@ -523,6 +540,9 @@
 void do_IRQ(struct pt_regs *regs)
 {
 	int irq, first = 1;
+	static int prev_irq=-3, prev_prev_irq=-4;
+	static unsigned spurious_jiffies;
+	static int prev_spurious;
         irq_enter();
 
 	/*
@@ -536,10 +556,28 @@
 	while ((irq = ppc_md.get_irq(regs)) >= 0) {
 		ppc_irq_dispatch_handler(regs, irq);
 		first = 0;
+		prev_prev_irq = prev_irq;
+		prev_irq = irq;
 	}
-	if (irq != -2 && first)
+	if (irq != -2 && first) {
 		/* That's not SMP safe ... but who cares ? */
 		ppc_spurious_interrupts++;
+		if (jiffies-spurious_jiffies>HZ) {
+		  	if ((ppc_spurious_interrupts-prev_spurious) > 2 &&
+			    (regs->nip - (unsigned long)&__hardirq_shadow_nip)
+			    <=4) {
+				printk("Interrupt hardirq_shadow_ticks " 
+				       "set to %d.\n",
+				       ++hardirq_shadow_ticks);
+			}
+			prev_spurious = ppc_spurious_interrupts;
+			spurious_jiffies=jiffies;
+			printk(KERN_NOTICE
+			       "Spurious interrupt, last vectors %d:%d, "
+			       "NIP=0x%lx\n",
+			       prev_prev_irq, prev_irq, regs->nip);
+		}
+	}
         irq_exit();
 }
 
