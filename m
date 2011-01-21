Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34636B713E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Jan 2011 03:12:38 +1100 (EST)
Message-Id: <20110121142944.625823219@linutronix.de>
Date: Fri, 21 Jan 2011 16:12:30 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [patch 2/2] powerpc: Use new irq allocator
References: <20110121142848.050196552@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the new functions and free the descriptor when the virq is
destroyed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/kernel/irq.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

Index: linux-2.6-tip/arch/powerpc/kernel/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/irq.c
+++ linux-2.6-tip/arch/powerpc/kernel/irq.c
@@ -678,16 +678,15 @@ void irq_set_virq_count(unsigned int cou
 static int irq_setup_virq(struct irq_host *host, unsigned int virq,
 			    irq_hw_number_t hwirq)
 {
-	struct irq_desc *desc;
+	int res;
 
-	desc = irq_to_desc_alloc_node(virq, 0);
-	if (!desc) {
+	res = irq_alloc_desc_at(virq, 0);
+	if (res != virq) {
 		pr_debug("irq: -> allocating desc failed\n");
 		goto error;
 	}
 
-	/* Clear IRQ_NOREQUEST flag */
-	desc->status &= ~IRQ_NOREQUEST;
+	irq_clear_status_flags(virq, IRQ_NOREQUEST);
 
 	/* map it */
 	smp_wmb();
@@ -696,11 +695,13 @@ static int irq_setup_virq(struct irq_hos
 
 	if (host->ops->map(host, virq, hwirq)) {
 		pr_debug("irq: -> mapping failed, freeing\n");
-		goto error;
+		goto errdesc;
 	}
 
 	return 0;
 
+errdesc:
+	irq_free_descs(virq, 1);
 error:
 	irq_free_virt(virq, 1);
 	return -1;
@@ -879,9 +880,9 @@ void irq_dispose_mapping(unsigned int vi
 	smp_mb();
 	irq_map[virq].hwirq = host->inval_irq;
 
-	/* Set some flags */
-	irq_to_desc(virq)->status |= IRQ_NOREQUEST;
+	irq_set_status_flags(virq, IRQ_NOREQUEST);
 
+	irq_free_descs(virq, 1);
 	/* Free it */
 	irq_free_virt(virq, 1);
 }
