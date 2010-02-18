Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E59C7B7D50
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:32:09 +1100 (EST)
Message-Id: <20100218122000.155547081@linutronix.de>
Date: Thu, 18 Feb 2010 12:22:24 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 01/15] powerpc: Convert big_irq_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

big_irq_lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/kernel/irq.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

Index: linux-2.6-tip/arch/powerpc/kernel/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/irq.c
+++ linux-2.6-tip/arch/powerpc/kernel/irq.c
@@ -474,7 +474,7 @@ void do_softirq(void)
  */
 
 static LIST_HEAD(irq_hosts);
-static DEFINE_SPINLOCK(irq_big_lock);
+static DEFINE_RAW_SPINLOCK(irq_big_lock);
 static unsigned int revmap_trees_allocated;
 static DEFINE_MUTEX(revmap_trees_mutex);
 struct irq_map_entry irq_map[NR_IRQS];
@@ -520,14 +520,14 @@ struct irq_host *irq_alloc_host(struct d
 	if (host->ops->match == NULL)
 		host->ops->match = default_irq_host_match;
 
-	spin_lock_irqsave(&irq_big_lock, flags);
+	raw_spin_lock_irqsave(&irq_big_lock, flags);
 
 	/* If it's a legacy controller, check for duplicates and
 	 * mark it as allocated (we use irq 0 host pointer for that
 	 */
 	if (revmap_type == IRQ_HOST_MAP_LEGACY) {
 		if (irq_map[0].host != NULL) {
-			spin_unlock_irqrestore(&irq_big_lock, flags);
+			raw_spin_unlock_irqrestore(&irq_big_lock, flags);
 			/* If we are early boot, we can't free the structure,
 			 * too bad...
 			 * this will be fixed once slab is made available early
@@ -541,7 +541,7 @@ struct irq_host *irq_alloc_host(struct d
 	}
 
 	list_add(&host->link, &irq_hosts);
-	spin_unlock_irqrestore(&irq_big_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_big_lock, flags);
 
 	/* Additional setups per revmap type */
 	switch(revmap_type) {
@@ -592,13 +592,13 @@ struct irq_host *irq_find_host(struct de
 	 * the absence of a device node. This isn't a problem so far
 	 * yet though...
 	 */
-	spin_lock_irqsave(&irq_big_lock, flags);
+	raw_spin_lock_irqsave(&irq_big_lock, flags);
 	list_for_each_entry(h, &irq_hosts, link)
 		if (h->ops->match(h, node)) {
 			found = h;
 			break;
 		}
-	spin_unlock_irqrestore(&irq_big_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_big_lock, flags);
 	return found;
 }
 EXPORT_SYMBOL_GPL(irq_find_host);
@@ -967,7 +967,7 @@ unsigned int irq_alloc_virt(struct irq_h
 	if (count == 0 || count > (irq_virq_count - NUM_ISA_INTERRUPTS))
 		return NO_IRQ;
 
-	spin_lock_irqsave(&irq_big_lock, flags);
+	raw_spin_lock_irqsave(&irq_big_lock, flags);
 
 	/* Use hint for 1 interrupt if any */
 	if (count == 1 && hint >= NUM_ISA_INTERRUPTS &&
@@ -991,7 +991,7 @@ unsigned int irq_alloc_virt(struct irq_h
 		}
 	}
 	if (found == NO_IRQ) {
-		spin_unlock_irqrestore(&irq_big_lock, flags);
+		raw_spin_unlock_irqrestore(&irq_big_lock, flags);
 		return NO_IRQ;
 	}
  hint_found:
@@ -1000,7 +1000,7 @@ unsigned int irq_alloc_virt(struct irq_h
 		smp_wmb();
 		irq_map[i].host = host;
 	}
-	spin_unlock_irqrestore(&irq_big_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_big_lock, flags);
 	return found;
 }
 
@@ -1012,7 +1012,7 @@ void irq_free_virt(unsigned int virq, un
 	WARN_ON (virq < NUM_ISA_INTERRUPTS);
 	WARN_ON (count == 0 || (virq + count) > irq_virq_count);
 
-	spin_lock_irqsave(&irq_big_lock, flags);
+	raw_spin_lock_irqsave(&irq_big_lock, flags);
 	for (i = virq; i < (virq + count); i++) {
 		struct irq_host *host;
 
@@ -1025,7 +1025,7 @@ void irq_free_virt(unsigned int virq, un
 		smp_wmb();
 		irq_map[i].host = NULL;
 	}
-	spin_unlock_irqrestore(&irq_big_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_big_lock, flags);
 }
 
 int arch_early_irq_init(void)
