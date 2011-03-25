Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6621B100CFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:45 +1100 (EST)
Message-Id: <20110325164141.231901449@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:18 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 06/14] powerpc: cpm2_pic: Use IRQCHIP_EOI_IF_HANDLED
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

The core code provides the same functionality when the
IRQCHIP_EOI_IF_HANDLED flag is set for the irq chip.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/sysdev/cpm2_pic.c |   29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

Index: linux-2.6-tip/arch/powerpc/sysdev/cpm2_pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/cpm2_pic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/cpm2_pic.c
@@ -115,26 +115,20 @@ static void cpm2_ack(struct irq_data *d)
 
 static void cpm2_end_irq(struct irq_data *d)
 {
-	struct irq_desc *desc;
 	int	bit, word;
 	unsigned int irq_nr = virq_to_hw(d->irq);
 
-	desc = irq_to_desc(irq_nr);
-	if (!(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS))
-			&& desc->action) {
-
-		bit = irq_to_siubit[irq_nr];
-		word = irq_to_siureg[irq_nr];
-
-		ppc_cached_irq_mask[word] |= 1 << bit;
-		out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
-
-		/*
-		 * Work around large numbers of spurious IRQs on PowerPC 82xx
-		 * systems.
-		 */
-		mb();
-	}
+	bit = irq_to_siubit[irq_nr];
+	word = irq_to_siureg[irq_nr];
+
+	ppc_cached_irq_mask[word] |= 1 << bit;
+	out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
+
+	/*
+	 * Work around large numbers of spurious IRQs on PowerPC 82xx
+	 * systems.
+	 */
+	mb();
 }
 
 static int cpm2_set_irq_type(struct irq_data *d, unsigned int flow_type)
@@ -202,6 +196,7 @@ static struct irq_chip cpm2_pic = {
 	.irq_ack = cpm2_ack,
 	.irq_eoi = cpm2_end_irq,
 	.irq_set_type = cpm2_set_irq_type,
+	.flags = IRQCHIP_EOI_IF_HANDLED,
 };
 
 unsigned int cpm2_get_irq(void)
