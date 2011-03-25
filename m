Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F768B7052
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:05 +1100 (EST)
Message-Id: <20110325164141.329389997@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:18 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 07/14] powerpc: ipic: Cleanup flow type handling
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
 arch/powerpc/sysdev/ipic.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

Index: linux-2.6-tip/arch/powerpc/sysdev/ipic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/ipic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/ipic.c
@@ -605,7 +605,6 @@ static int ipic_set_irq_type(struct irq_
 {
 	struct ipic *ipic = ipic_from_irq(d->irq);
 	unsigned int src = ipic_irq_to_hw(d->irq);
-	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned int vold, vnew, edibit;
 
 	if (flow_type == IRQ_TYPE_NONE)
@@ -623,17 +622,16 @@ static int ipic_set_irq_type(struct irq_
 		printk(KERN_ERR "ipic: edge sense not supported on internal "
 				"interrupts\n");
 		return -EINVAL;
+
 	}
 
-	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
-	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
+	irqd_set_trigger_type(d, flow_type);
 	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
-		desc->status |= IRQ_LEVEL;
-		desc->handle_irq = handle_level_irq;
-		desc->irq_data.chip = &ipic_level_irq_chip;
+		__irq_set_handler_unlocked(d->irq, handle_level_irq);
+		d->chip = &ipic_level_irq_chip;
 	} else {
-		desc->handle_irq = handle_edge_irq;
-		desc->irq_data.chip = &ipic_edge_irq_chip;
+		__irq_set_handler_unlocked(d->irq, handle_edge_irq);
+		d->chip = &ipic_edge_irq_chip;
 	}
 
 	/* only EXT IRQ senses are programmable on ipic
@@ -655,7 +653,7 @@ static int ipic_set_irq_type(struct irq_
 	}
 	if (vold != vnew)
 		ipic_write(ipic->regs, IPIC_SECNR, vnew);
-	return 0;
+	return IRQ_SET_MASK_OK_NOCOPY;
 }
 
 /* level interrupts and edge interrupts have different ack operations */
