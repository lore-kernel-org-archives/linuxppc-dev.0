Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C188D100974
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:23 +1100 (EST)
Message-Id: <20110325164140.836638345@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:15 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 02/14] powerpc: media5200: Remove pointless set_irq_type()
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

The irq chip has no irq_set_type() callback. So calling the call is
pointless. Set IRQ_LEVEL via the proper accessor.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/52xx/media5200.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Index: linux-2.6-tip/arch/powerpc/platforms/52xx/media5200.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/52xx/media5200.c
+++ linux-2.6-tip/arch/powerpc/platforms/52xx/media5200.c
@@ -115,15 +115,10 @@ void media5200_irq_cascade(unsigned int 
 static int media5200_irq_map(struct irq_host *h, unsigned int virq,
 			     irq_hw_number_t hw)
 {
-	struct irq_desc *desc = irq_to_desc(virq);
-
 	pr_debug("%s: h=%p, virq=%i, hwirq=%i\n", __func__, h, virq, (int)hw);
 	set_irq_chip_data(virq, &media5200_irq);
 	set_irq_chip_and_handler(virq, &media5200_irq_chip, handle_level_irq);
-	set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
-	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
-	desc->status |= IRQ_TYPE_LEVEL_LOW | IRQ_LEVEL;
-
+	irq_set_status_flags(virq, IRQ_LEVEL);
 	return 0;
 }
 
