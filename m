Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0F5EB84BE
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:32:13 +1100 (EST)
Message-Id: <20100218122000.546387696@linutronix.de>
Date: Thu, 18 Feb 2010 12:23:03 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 11/15] powerpc: Convert pmac_pic_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pmac_pic_lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/powermac/pic.c |   38 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

Index: linux-2.6-tip/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/powermac/pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/powermac/pic.c
@@ -57,7 +57,7 @@ static int max_irqs;
 static int max_real_irqs;
 static u32 level_mask[4];
 
-static DEFINE_SPINLOCK(pmac_pic_lock);
+static DEFINE_RAW_SPINLOCK(pmac_pic_lock);
 
 #define NR_MASK_WORDS	((NR_IRQS + 31) / 32)
 static unsigned long ppc_lost_interrupts[NR_MASK_WORDS];
@@ -85,7 +85,7 @@ static void pmac_mask_and_ack_irq(unsign
         int i = src >> 5;
         unsigned long flags;
 
-	spin_lock_irqsave(&pmac_pic_lock, flags);
+	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
         __clear_bit(src, ppc_cached_irq_mask);
         if (__test_and_clear_bit(src, ppc_lost_interrupts))
                 atomic_dec(&ppc_n_lost_interrupts);
@@ -97,7 +97,7 @@ static void pmac_mask_and_ack_irq(unsign
                 mb();
         } while((in_le32(&pmac_irq_hw[i]->enable) & bit)
                 != (ppc_cached_irq_mask[i] & bit));
-	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
 static void pmac_ack_irq(unsigned int virq)
@@ -107,12 +107,12 @@ static void pmac_ack_irq(unsigned int vi
         int i = src >> 5;
         unsigned long flags;
 
-  	spin_lock_irqsave(&pmac_pic_lock, flags);
+	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
 	if (__test_and_clear_bit(src, ppc_lost_interrupts))
                 atomic_dec(&ppc_n_lost_interrupts);
         out_le32(&pmac_irq_hw[i]->ack, bit);
         (void)in_le32(&pmac_irq_hw[i]->ack);
-	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
 static void __pmac_set_irq_mask(unsigned int irq_nr, int nokicklost)
@@ -152,12 +152,12 @@ static unsigned int pmac_startup_irq(uns
         unsigned long bit = 1UL << (src & 0x1f);
         int i = src >> 5;
 
-	spin_lock_irqsave(&pmac_pic_lock, flags);
+	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
 	if ((irq_to_desc(virq)->status & IRQ_LEVEL) == 0)
 		out_le32(&pmac_irq_hw[i]->ack, bit);
         __set_bit(src, ppc_cached_irq_mask);
         __pmac_set_irq_mask(src, 0);
-	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 
 	return 0;
 }
@@ -167,10 +167,10 @@ static void pmac_mask_irq(unsigned int v
 	unsigned long flags;
 	unsigned int src = irq_map[virq].hwirq;
 
-  	spin_lock_irqsave(&pmac_pic_lock, flags);
+	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
         __clear_bit(src, ppc_cached_irq_mask);
         __pmac_set_irq_mask(src, 1);
-  	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
 static void pmac_unmask_irq(unsigned int virq)
@@ -178,19 +178,19 @@ static void pmac_unmask_irq(unsigned int
 	unsigned long flags;
 	unsigned int src = irq_map[virq].hwirq;
 
-	spin_lock_irqsave(&pmac_pic_lock, flags);
+	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
 	__set_bit(src, ppc_cached_irq_mask);
         __pmac_set_irq_mask(src, 0);
-  	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
 static int pmac_retrigger(unsigned int virq)
 {
 	unsigned long flags;
 
-  	spin_lock_irqsave(&pmac_pic_lock, flags);
+	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
 	__pmac_retrigger(irq_map[virq].hwirq);
-  	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 	return 1;
 }
 
@@ -210,7 +210,7 @@ static irqreturn_t gatwick_action(int cp
 	int irq, bits;
 	int rc = IRQ_NONE;
 
-  	spin_lock_irqsave(&pmac_pic_lock, flags);
+	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
 	for (irq = max_irqs; (irq -= 32) >= max_real_irqs; ) {
 		int i = irq >> 5;
 		bits = in_le32(&pmac_irq_hw[i]->event) | ppc_lost_interrupts[i];
@@ -220,12 +220,12 @@ static irqreturn_t gatwick_action(int cp
 		if (bits == 0)
 			continue;
 		irq += __ilog2(bits);
-		spin_unlock_irqrestore(&pmac_pic_lock, flags);
+		raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 		generic_handle_irq(irq);
-		spin_lock_irqsave(&pmac_pic_lock, flags);
+		raw_spin_lock_irqsave(&pmac_pic_lock, flags);
 		rc = IRQ_HANDLED;
 	}
-  	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 	return rc;
 }
 
@@ -244,7 +244,7 @@ static unsigned int pmac_pic_get_irq(voi
 		return NO_IRQ_IGNORE;	/* ignore, already handled */
         }
 #endif /* CONFIG_SMP */
-  	spin_lock_irqsave(&pmac_pic_lock, flags);
+	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
 	for (irq = max_real_irqs; (irq -= 32) >= 0; ) {
 		int i = irq >> 5;
 		bits = in_le32(&pmac_irq_hw[i]->event) | ppc_lost_interrupts[i];
@@ -256,7 +256,7 @@ static unsigned int pmac_pic_get_irq(voi
 		irq += __ilog2(bits);
 		break;
 	}
-  	spin_unlock_irqrestore(&pmac_pic_lock, flags);
+	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 	if (unlikely(irq < 0))
 		return NO_IRQ;
 	return irq_linear_revmap(pmac_pic_host, irq);
