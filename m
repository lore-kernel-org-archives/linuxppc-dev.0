Return-Path: <dgibson@ozlabs.org>
Date: Fri, 3 Aug 2007 16:23:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [ PATCH ] PowerPC cascade UIC IRQ handler fix.
Message-ID: <20070803062346.GA14456@localhost.localdomain>
References: <20070730163517.GA10087@ru.mvista.com>
	<20070802034848.GA837@localhost.localdomain>
	<1186103889.5495.650.camel@localhost.localdomain>
	<20070803045705.GA2392@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070803045705.GA2392@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 03, 2007 at 02:57:05PM +1000, David Gibson wrote:
> On Fri, Aug 03, 2007 at 11:18:09AM +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2007-08-02 at 13:48 +1000, David Gibson wrote:
> > > On Mon, Jul 30, 2007 at 08:35:17PM +0400, Valentine Barshak wrote:
> > > > PPC44x cascade UIC irq handler fix.
> > > > 
> > > > According to PPC44x UM, if an interrupt is configured as level-sensitive,
> > > > and a clear is attempted on the UIC_SR, the UIC_SR field is not
> > > > cleared if the incoming interrupt signal is at the asserted polarity.
> > > > This causes us to enter a cascade handler twice, since we first ack
> > > > parent UIC interrupt and ack child UIC one after that.
> > > > The patch checks child UIC msr value and returns IRQ_HANDLED
> > > > if there're no pending interrupts. Otherwise we get a kernel panic
> > > > with a "Fatal exception in interrupt" (illegal vector).
> > > > The patch also fixes status flags.
> > > > 
> > > > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> > > 
> > > Hrm... This doesn't seem like the right fix to me.  Instead, I think
> > > the cascaded IRQ handler should ack the interrupt on the child first.
> > > I'm a little surprised it doesn't at the moment.
> > 
> > Well, we certainly do also need to make the code more solid vs.
> > spurrious interrupts.
> 
> Actually that's true.  The suggested patch is a good improvement for
> general robustness, but doesn't actually address the real problem.
> 
> > The main thing is, if the cascade is a level interrupt, it should
> > probably use a smarter cascade handler that masks it, handle the child
> > interrupts, then unmasks it.
> 
> We already have that, since I just use setup_irq() to set up a cascade
> handler, rather than a custom flow handler.
> 
> The problem is that the standard handle_level_irq() flow handler acks
> before the ISR is called, whereas because of this UIC behaviour, we
> need to ack after the ISR has cleared the interrupt in the source.
> This is not specific to cascades, but is a problem for all
> level-triggered interrupts (i.e. basically everything).
> 
> I think it means we must currently be getting a whole lot of spurious
> interrupts - will do some investigation in a moment.
> 
> To fix this either we'll need a custom flow handler for UIC, or we can
> use the standard one, but clear the UIC_SR bits from the ->unmask()
> callback for level interrupts.  I'm not entirely sure if the latter
> approach is safe - I *think* it is, but I could do with more
> convincing.

Ok, here's a patch which fixes up the flow handling on the UIC.  It
needs some polish yet, but should be ok to test.  Valentine, can you
test this on your setup, *without* your original proposed patch.
Eventually, for robustness, we'll want something like your original
patch as well for robustness, but in the meantime leaving it out
should tell us if my patch is actually having the intended effect.

Index: working-2.6/arch/powerpc/sysdev/uic.c
===================================================================
--- working-2.6.orig/arch/powerpc/sysdev/uic.c	2007-08-03 16:09:48.000000000 +1000
+++ working-2.6/arch/powerpc/sysdev/uic.c	2007-08-03 16:09:49.000000000 +1000
@@ -24,6 +24,7 @@
 #include <linux/spinlock.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -159,6 +160,56 @@ static struct irq_chip uic_irq_chip = {
 	.set_type	= uic_set_irq_type,
 };
 
+/**
+ *	handle_uic_irq - Level type irq handler
+ *	@irq:	the interrupt number
+ *	@desc:	the interrupt description structure for this irq
+ *
+ *	Level type interrupts are active as long as the hardware line has
+ *	the active level. This may require to mask the interrupt and unmask
+ *	it after the associated handler has acknowledged the device, so the
+ *	interrupt line is back to inactive.
+ */
+void fastcall
+handle_uic_irq(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int cpu = smp_processor_id();
+	struct irqaction *action;
+	irqreturn_t action_ret;
+
+	spin_lock(&desc->lock);
+	desc->chip->mask(irq);
+
+	if (unlikely(desc->status & IRQ_INPROGRESS))
+		goto out_unlock;
+	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
+	kstat_cpu(cpu).irqs[irq]++;
+
+	/*
+	 * If its disabled or no action available
+	 * keep it masked and get out of here
+	 */
+	action = desc->action;
+	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {
+		desc->status |= IRQ_PENDING;
+		goto out_unlock;
+	}
+
+	desc->status |= IRQ_INPROGRESS;
+	desc->status &= ~IRQ_PENDING;
+	spin_unlock(&desc->lock);
+
+	action_ret = handle_IRQ_event(irq, action);
+
+	spin_lock(&desc->lock);
+	desc->status &= ~IRQ_INPROGRESS;
+	desc->chip->ack(irq);
+	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
+		desc->chip->unmask(irq);
+out_unlock:
+	spin_unlock(&desc->lock);
+}
+
 static int uic_host_match(struct irq_host *h, struct device_node *node)
 {
 	struct uic *uic = h->host_data;
@@ -173,7 +224,7 @@ static int uic_host_map(struct irq_host 
 	set_irq_chip_data(virq, uic);
 	/* Despite the name, handle_level_irq() works for both level
 	 * and edge irqs on UIC.  FIXME: check this is correct */
-	set_irq_chip_and_handler(virq, &uic_irq_chip, handle_level_irq);
+	set_irq_chip_and_handler(virq, &uic_irq_chip, handle_uic_irq);
 
 	/* Set default irq type */
 	set_irq_type(virq, IRQ_TYPE_NONE);


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
