Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17BAA1007EF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:36 +1100 (EST)
Message-Id: <20110325164141.138179365@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:17 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 05/14] powerpc: cpm2_pic: Cleanup flow type handling
References: <20110325164049.138289403@linutronix.de>
Cc: Lennert Buytenhek <buytenh@secretlab.ca>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The core irq_set_type() function updates the flow type when the chip
callback returns 0. So setting the type is bogus.

The new core code allows to update the type in irq_data and return
IRQ_SET_MASK_OK_NOCOPY, so the core code will not touch it, except for
setting the IRQ_LEVEL flag.

Use the proper accessors for setting the irq handlers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/sysdev/cpm2_pic.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

Index: linux-2.6-tip/arch/powerpc/sysdev/cpm2_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/cpm2_pic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/cpm2_pic.c
@@ -140,7 +140,6 @@ static void cpm2_end_irq(struct irq_data
 static int cpm2_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
 	unsigned int src = virq_to_hw(d->irq);
-	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned int vold, vnew, edibit;
 
 	/* Port C interrupts are either IRQ_TYPE_EDGE_FALLING or
@@ -162,13 +161,11 @@ static int cpm2_set_irq_type(struct irq_
 			goto err_sense;
 	}
 
-	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
-	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
-	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
-		desc->status |= IRQ_LEVEL;
-		desc->handle_irq = handle_level_irq;
-	} else
-		desc->handle_irq = handle_edge_irq;
+	irqd_set_trigger_type(d, flow_type);
+	if (flow_type & IRQ_TYPE_LEVEL_LOW)
+		__set_irq_handler_unlocked(d->irq, handle_level_irq);
+	else
+		__set_irq_handler_unlocked(d->irq, handle_edge_irq);
 
 	/* internal IRQ senses are LEVEL_LOW
 	 * EXT IRQ and Port C IRQ senses are programmable
@@ -179,7 +176,8 @@ static int cpm2_set_irq_type(struct irq_
 		if (src >= CPM2_IRQ_PORTC15 && src <= CPM2_IRQ_PORTC0)
 			edibit = (31 - (CPM2_IRQ_PORTC0 - src));
 		else
-			return (flow_type & IRQ_TYPE_LEVEL_LOW) ? 0 : -EINVAL;
+			return (flow_type & IRQ_TYPE_LEVEL_LOW) ?
+				IRQ_SET_MASK_OK_NOCOPY : -EINVAL;
 
 	vold = in_be32(&cpm2_intctl->ic_siexr);
 
@@ -190,7 +188,7 @@ static int cpm2_set_irq_type(struct irq_
 
 	if (vold != vnew)
 		out_be32(&cpm2_intctl->ic_siexr, vnew);
-	return 0;
+	return IRQ_SET_MASK_OK_NOCOPY;
 
 err_sense:
 	pr_err("CPM2 PIC: sense type 0x%x not supported\n", flow_type);
