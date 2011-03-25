Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC85BB7014
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:27 +1100 (EST)
Message-Id: <20110325164141.042264908@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:16 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 04/14] powerpc: cell: Fix the irq_desc access
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
callback returns 0. It also updates irq_data, so this can be used in
irq_ack() to check for the level bit. That avoids a redundant sparse
irq lookup.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/cell/spider-pic.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Index: linux-2.6-tip/arch/powerpc/platforms/cell/spider-pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/cell/spider-pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/cell/spider-pic.c
@@ -102,7 +102,7 @@ static void spider_ack_irq(struct irq_da
 
 	/* Reset edge detection logic if necessary
 	 */
-	if (irq_to_desc(d->irq)->status & IRQ_LEVEL)
+	if (irqd_is_level_type(d))
 		return;
 
 	/* Only interrupts 47 to 50 can be set to edge */
@@ -119,7 +119,6 @@ static int spider_set_irq_type(struct ir
 	struct spider_pic *pic = spider_virq_to_pic(d->irq);
 	unsigned int hw = irq_map[d->irq].hwirq;
 	void __iomem *cfg = spider_get_irq_config(pic, hw);
-	struct irq_desc *desc = irq_to_desc(d->irq);
 	u32 old_mask;
 	u32 ic;
 
@@ -147,12 +146,6 @@ static int spider_set_irq_type(struct ir
 		return -EINVAL;
 	}
 
-	/* Update irq_desc */
-	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
-	desc->status |= type & IRQ_TYPE_SENSE_MASK;
-	if (type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
-		desc->status |= IRQ_LEVEL;
-
 	/* Configure the source. One gross hack that was there before and
 	 * that I've kept around is the priority to the BE which I set to
 	 * be the same as the interrupt source number. I don't know wether
