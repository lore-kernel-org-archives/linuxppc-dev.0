Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69B9C100E38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:49 +1100 (EST)
Message-Id: <20110325164141.524783616@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:20 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 09/14] powerpc: mpic: Cleanup flow type handling
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

Retrieve the IRQ_LEVEL information from irq_data which avoids a
redundant sparse irq lookup as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/sysdev/mpic.c |   29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

Index: linux-2.6-tip/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/mpic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/mpic.c
@@ -361,7 +361,7 @@ static inline void mpic_ht_end_irq(struc
 }
 
 static void mpic_startup_ht_interrupt(struct mpic *mpic, unsigned int source,
-				      unsigned int irqflags)
+				      bool level)
 {
 	struct mpic_irq_fixup *fixup = &mpic->fixups[source];
 	unsigned long flags;
@@ -370,14 +370,14 @@ static void mpic_startup_ht_interrupt(st
 	if (fixup->base == NULL)
 		return;
 
-	DBG("startup_ht_interrupt(0x%x, 0x%x) index: %d\n",
-	    source, irqflags, fixup->index);
+	DBG("startup_ht_interrupt(0x%x) index: %d\n",
+	    source, fixup->index);
 	raw_spin_lock_irqsave(&mpic->fixup_lock, flags);
 	/* Enable and configure */
 	writeb(0x10 + 2 * fixup->index, fixup->base + 2);
 	tmp = readl(fixup->base + 4);
 	tmp &= ~(0x23U);
-	if (irqflags & IRQ_LEVEL)
+	if (level)
 		tmp |= 0x22;
 	writel(tmp, fixup->base + 4);
 	raw_spin_unlock_irqrestore(&mpic->fixup_lock, flags);
@@ -389,8 +389,7 @@ static void mpic_startup_ht_interrupt(st
 #endif
 }
 
-static void mpic_shutdown_ht_interrupt(struct mpic *mpic, unsigned int source,
-				       unsigned int irqflags)
+static void mpic_shutdown_ht_interrupt(struct mpic *mpic, unsigned int source)
 {
 	struct mpic_irq_fixup *fixup = &mpic->fixups[source];
 	unsigned long flags;
@@ -399,7 +398,7 @@ static void mpic_shutdown_ht_interrupt(s
 	if (fixup->base == NULL)
 		return;
 
-	DBG("shutdown_ht_interrupt(0x%x, 0x%x)\n", source, irqflags);
+	DBG("shutdown_ht_interrupt(0x%x)\n", source);
 
 	/* Disable */
 	raw_spin_lock_irqsave(&mpic->fixup_lock, flags);
@@ -738,7 +737,7 @@ static void mpic_unmask_ht_irq(struct ir
 
 	mpic_unmask_irq(d);
 
-	if (irq_to_desc(d->irq)->status & IRQ_LEVEL)
+	if (irqd_is_level(d))
 		mpic_ht_end_irq(mpic, src);
 }
 
@@ -748,7 +747,7 @@ static unsigned int mpic_startup_ht_irq(
 	unsigned int src = mpic_irq_to_hw(d->irq);
 
 	mpic_unmask_irq(d);
-	mpic_startup_ht_interrupt(mpic, src, irq_to_desc(d->irq)->status);
+	mpic_startup_ht_interrupt(mpic, src, irqd_is_level_type(d));
 
 	return 0;
 }
@@ -758,7 +757,7 @@ static void mpic_shutdown_ht_irq(struct 
 	struct mpic *mpic = mpic_from_irq_data(d);
 	unsigned int src = mpic_irq_to_hw(d->irq);
 
-	mpic_shutdown_ht_interrupt(mpic, src, irq_to_desc(d->irq)->status);
+	mpic_shutdown_ht_interrupt(mpic, src);
 	mpic_mask_irq(d);
 }
 
@@ -775,7 +774,7 @@ static void mpic_end_ht_irq(struct irq_d
 	 * latched another edge interrupt coming in anyway
 	 */
 
-	if (irq_to_desc(d->irq)->status & IRQ_LEVEL)
+	if (irqd_is_level_type(d))
 		mpic_ht_end_irq(mpic, src);
 	mpic_eoi(mpic);
 }
@@ -864,7 +863,6 @@ int mpic_set_irq_type(struct irq_data *d
 {
 	struct mpic *mpic = mpic_from_irq_data(d);
 	unsigned int src = mpic_irq_to_hw(d->irq);
-	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned int vecpri, vold, vnew;
 
 	DBG("mpic: set_irq_type(mpic:@%p,virq:%d,src:0x%x,type:0x%x)\n",
@@ -879,10 +877,7 @@ int mpic_set_irq_type(struct irq_data *d
 	if (flow_type == IRQ_TYPE_NONE)
 		flow_type = IRQ_TYPE_LEVEL_LOW;
 
-	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
-	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
-	if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
-		desc->status |= IRQ_LEVEL;
+	irqd_set_trigger_type(d, flow_type);
 
 	if (mpic_is_ht_interrupt(mpic, src))
 		vecpri = MPIC_VECPRI_POLARITY_POSITIVE |
@@ -897,7 +892,7 @@ int mpic_set_irq_type(struct irq_data *d
 	if (vold != vnew)
 		mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI), vnew);
 
-	return 0;
+	return IRQ_SET_MASK_OK_NOCOPY;;
 }
 
 void mpic_set_vector(unsigned int virq, unsigned int vector)
