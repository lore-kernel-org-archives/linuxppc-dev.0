Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1724100810
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:31 +1100 (EST)
Message-Id: <20110325164141.428286153@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:19 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 08/14] powerpc: mpc8xx_pic: Cleanup flow type handling
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
callback returns 0. So setting the type is bogus. The level flag is
updated in the core as well.

Use the proper accessors for setting the irq handlers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/sysdev/mpc8xx_pic.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Index: linux-2.6-tip/arch/powerpc/sysdev/mpc8xx_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/mpc8xx_pic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -72,13 +72,6 @@ static void mpc8xx_end_irq(struct irq_da
 
 static int mpc8xx_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct irq_desc *desc = irq_to_desc(d->irq);
-
-	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
-	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
-	if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
-		desc->status |= IRQ_LEVEL;
-
 	if (flow_type & IRQ_TYPE_EDGE_FALLING) {
 		irq_hw_number_t hw = (unsigned int)irq_map[d->irq].hwirq;
 		unsigned int siel = in_be32(&siu_reg->sc_siel);
@@ -87,7 +80,7 @@ static int mpc8xx_set_irq_type(struct ir
 		if ((hw & 1) == 0) {
 			siel |= (0x80000000 >> hw);
 			out_be32(&siu_reg->sc_siel, siel);
-			desc->handle_irq = handle_edge_irq;
+			__set_irq_handler_unlocked(irq, handle_edge_irq);
 		}
 	}
 	return 0;
