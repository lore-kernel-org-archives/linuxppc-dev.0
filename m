Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/3] Fix irq flow handler for 4xx UIC
In-Reply-To: <20070814034811.GA8791@localhost.localdomain>
Message-Id: <20070814035242.9674EDDEF0@ozlabs.org>
Date: Tue, 14 Aug 2007 13:52:42 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At present the driver for the UIC (the embedded interrupt controller
in 4xx chips) uses the handle_level_irq() flow handler.  It turns out
this does not correctly handle level triggered interrupts on the UIC.

Specifically, acknowledging an irq on the UIC (i.e. clearing the
relevant bit in UIC_SR) will have no effect for a level interrupt
which is still asserted by the external device, even if the irq is
already masked.  Therefore, unlike handle_level_irq() we must ack the
interrupt after invoking the ISR (which should cause the device to
stop asserting the irq) instead of acking it when we mask it, before
the ISR.

This patch implements this change, in a new handle_uic_irq(), a
customised irq flow handler for the UIC.  For edge triggered
interrupts, handle_uic_irq() still uses the old flow - we must ack
edge triggered interrupt before the ISR not after, or we could miss a
second event which occurred between invoking the ISR and acking the
irq.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 arch/powerpc/sysdev/uic.c |   61 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

Index: working-2.6/arch/powerpc/sysdev/uic.c
===================================================================
--- working-2.6.orig/arch/powerpc/sysdev/uic.c	2007-08-14 13:17:52.000000000 +1000
+++ working-2.6/arch/powerpc/sysdev/uic.c	2007-08-14 13:17:57.000000000 +1000
@@ -24,6 +24,7 @@
 #include <linux/spinlock.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -159,6 +160,64 @@ static struct irq_chip uic_irq_chip = {
 	.set_type	= uic_set_irq_type,
 };
 
+/**
+ *	handle_uic_irq - irq flow handler for UIC
+ *	@irq:	the interrupt number
+ *	@desc:	the interrupt description structure for this irq
+ *
+ * This is modified version of the generic handle_level_irq() suitable
+ * for the UIC.  On the UIC, acking (i.e. clearing the SR bit) a level
+ * irq will have no effect if the interrupt is still asserted by the
+ * device, even if the interrupt is already masked.  Therefore, unlike
+ * the standard handle_level_irq(), we must ack the interrupt *after*
+ * invoking the ISR (which should have de-asserted the interrupt in
+ * the external source).  For edge interrupts we ack at the beginning
+ * instead of the end, to keep the window in which we can miss an
+ * interrupt as small as possible.
+ */
+void fastcall handle_uic_irq(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int cpu = smp_processor_id();
+	struct irqaction *action;
+	irqreturn_t action_ret;
+
+	spin_lock(&desc->lock);
+	if (desc->status & IRQ_LEVEL)
+		desc->chip->mask(irq);
+	else
+		desc->chip->mask_ack(irq);
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
+	if (desc->status & IRQ_LEVEL)
+		desc->chip->ack(irq);
+	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
+		desc->chip->unmask(irq);
+out_unlock:
+	spin_unlock(&desc->lock);
+}
+
 static int uic_host_match(struct irq_host *h, struct device_node *node)
 {
 	struct uic *uic = h->host_data;
@@ -173,7 +232,7 @@ static int uic_host_map(struct irq_host 
 	set_irq_chip_data(virq, uic);
 	/* Despite the name, handle_level_irq() works for both level
 	 * and edge irqs on UIC.  FIXME: check this is correct */
-	set_irq_chip_and_handler(virq, &uic_irq_chip, handle_level_irq);
+	set_irq_chip_and_handler(virq, &uic_irq_chip, handle_uic_irq);
 
 	/* Set default irq type */
 	set_irq_type(virq, IRQ_TYPE_NONE);
