Return-Path: <vbarshak@ru.mvista.com>
Date: Thu, 6 Dec 2007 16:48:26 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC 4xx: rework UIC cascade irq handling
Message-ID: <20071206134826.GA8077@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a UIC cascade handler rework to use set_irq_chained_handler() for cascade,
just like othe ppc platforms do. With current implementation we have additional
redirection for irq handler and we call generic_handle_irq twice 
(once for the primary uic and the other time for handling cascade interrupt).
This causes Ingo's realtime support patch to stop working on 4xx.
Not sure of any other possible problems though, but with set_irq_chained_handler()
we can abolish "struct irqaction cascade" from the chip descriptor and call
generic_handle_irq() once, directly for cascade irq.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/sysdev/uic.c |   36 +++++++++++++++++++-----------------
 1 files changed, 19 insertions(+), 17 deletions(-)

diff -pruN linux-2.6.orig/arch/powerpc/sysdev/uic.c linux-2.6/arch/powerpc/sysdev/uic.c
--- linux-2.6.orig/arch/powerpc/sysdev/uic.c	2007-12-05 20:07:22.000000000 +0300
+++ linux-2.6/arch/powerpc/sysdev/uic.c	2007-12-05 21:34:56.000000000 +0300
@@ -53,9 +53,6 @@ struct uic {
 
 	/* The remapper for this UIC */
 	struct irq_host	*irqhost;
-
-	/* For secondary UICs, the cascade interrupt's irqaction */
-	struct irqaction cascade;
 };
 
 static void uic_unmask_irq(unsigned int virq)
@@ -264,23 +261,36 @@ static struct irq_host_ops uic_host_ops 
 	.xlate	= uic_host_xlate,
 };
 
-irqreturn_t uic_cascade(int virq, void *data)
+void uic_irq_cascade(unsigned int virq, struct irq_desc *desc)
 {
-	struct uic *uic = data;
+	struct uic *uic = get_irq_data(virq);
 	u32 msr;
 	int src;
 	int subvirq;
 
+	spin_lock(&desc->lock);
+	if (desc->status & IRQ_LEVEL)
+		desc->chip->mask(virq);
+	else
+		desc->chip->mask_ack(virq);
+	spin_unlock(&desc->lock);
+
 	msr = mfdcr(uic->dcrbase + UIC_MSR);
 	if (!msr) /* spurious interrupt */
-		return IRQ_HANDLED;
+		goto uic_irq_ret;
 
 	src = 32 - ffs(msr);
 
 	subvirq = irq_linear_revmap(uic->irqhost, src);
 	generic_handle_irq(subvirq);
 
-	return IRQ_HANDLED;
+uic_irq_ret:
+	spin_lock(&desc->lock);
+	if (desc->status & IRQ_LEVEL)
+		desc->chip->ack(virq);
+	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
+		desc->chip->unmask(virq);
+	spin_unlock(&desc->lock);
 }
 
 static struct uic * __init uic_init_one(struct device_node *node)
@@ -368,7 +378,6 @@ void __init uic_init_tree(void)
 		if (interrupts) {
 			/* Secondary UIC */
 			int cascade_virq;
-			int ret;
 
 			uic = uic_init_one(np);
 			if (! uic)
@@ -377,15 +386,8 @@ void __init uic_init_tree(void)
 
 			cascade_virq = irq_of_parse_and_map(np, 0);
 
-			uic->cascade.handler = uic_cascade;
-			uic->cascade.name = "UIC cascade";
-			uic->cascade.dev_id = uic;
-
-			ret = setup_irq(cascade_virq, &uic->cascade);
-			if (ret)
-				printk(KERN_ERR "Failed to setup_irq(%d) for "
-				       "UIC%d cascade\n", cascade_virq,
-				       uic->index);
+			set_irq_data(cascade_virq, uic);
+			set_irq_chained_handler(cascade_virq, uic_irq_cascade);
 
 			/* FIXME: setup critical cascade?? */
 		}
