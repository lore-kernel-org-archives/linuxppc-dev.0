Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8461DB7D67
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:32:15 +1100 (EST)
Message-Id: <20100218122000.712228169@linutronix.de>
Date: Thu, 18 Feb 2010 12:23:18 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 15/15] powerpc: Convert mpic locks to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpic_lock, irq_rover_lock and fixup_lock need to be real spinlocks in
RT. Convert them to raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/include/asm/mpic.h |    2 +-
 arch/powerpc/sysdev/mpic.c      |   38 +++++++++++++++++++-------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

Index: linux-2.6-tip/arch/powerpc/include/asm/mpic.h
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/include/asm/mpic.h
+++ linux-2.6-tip/arch/powerpc/include/asm/mpic.h
@@ -289,7 +289,7 @@ struct mpic
 #ifdef CONFIG_MPIC_U3_HT_IRQS
 	/* The fixup table */
 	struct mpic_irq_fixup	*fixups;
-	spinlock_t		fixup_lock;
+	raw_spinlock_t	fixup_lock;
 #endif
 
 	/* Register access method */
Index: linux-2.6-tip/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/mpic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/mpic.c
@@ -46,7 +46,7 @@
 
 static struct mpic *mpics;
 static struct mpic *mpic_primary;
-static DEFINE_SPINLOCK(mpic_lock);
+static DEFINE_RAW_SPINLOCK(mpic_lock);
 
 #ifdef CONFIG_PPC32	/* XXX for now */
 #ifdef CONFIG_IRQ_ALL_CPUS
@@ -347,10 +347,10 @@ static inline void mpic_ht_end_irq(struc
 		unsigned int mask = 1U << (fixup->index & 0x1f);
 		writel(mask, fixup->applebase + soff);
 	} else {
-		spin_lock(&mpic->fixup_lock);
+		raw_spin_lock(&mpic->fixup_lock);
 		writeb(0x11 + 2 * fixup->index, fixup->base + 2);
 		writel(fixup->data, fixup->base + 4);
-		spin_unlock(&mpic->fixup_lock);
+		raw_spin_unlock(&mpic->fixup_lock);
 	}
 }
 
@@ -366,7 +366,7 @@ static void mpic_startup_ht_interrupt(st
 
 	DBG("startup_ht_interrupt(0x%x, 0x%x) index: %d\n",
 	    source, irqflags, fixup->index);
-	spin_lock_irqsave(&mpic->fixup_lock, flags);
+	raw_spin_lock_irqsave(&mpic->fixup_lock, flags);
 	/* Enable and configure */
 	writeb(0x10 + 2 * fixup->index, fixup->base + 2);
 	tmp = readl(fixup->base + 4);
@@ -374,7 +374,7 @@ static void mpic_startup_ht_interrupt(st
 	if (irqflags & IRQ_LEVEL)
 		tmp |= 0x22;
 	writel(tmp, fixup->base + 4);
-	spin_unlock_irqrestore(&mpic->fixup_lock, flags);
+	raw_spin_unlock_irqrestore(&mpic->fixup_lock, flags);
 
 #ifdef CONFIG_PM
 	/* use the lowest bit inverted to the actual HW,
@@ -396,12 +396,12 @@ static void mpic_shutdown_ht_interrupt(s
 	DBG("shutdown_ht_interrupt(0x%x, 0x%x)\n", source, irqflags);
 
 	/* Disable */
-	spin_lock_irqsave(&mpic->fixup_lock, flags);
+	raw_spin_lock_irqsave(&mpic->fixup_lock, flags);
 	writeb(0x10 + 2 * fixup->index, fixup->base + 2);
 	tmp = readl(fixup->base + 4);
 	tmp |= 1;
 	writel(tmp, fixup->base + 4);
-	spin_unlock_irqrestore(&mpic->fixup_lock, flags);
+	raw_spin_unlock_irqrestore(&mpic->fixup_lock, flags);
 
 #ifdef CONFIG_PM
 	/* use the lowest bit inverted to the actual HW,
@@ -515,7 +515,7 @@ static void __init mpic_scan_ht_pics(str
 	BUG_ON(mpic->fixups == NULL);
 
 	/* Init spinlock */
-	spin_lock_init(&mpic->fixup_lock);
+	raw_spin_lock_init(&mpic->fixup_lock);
 
 	/* Map U3 config space. We assume all IO-APICs are on the primary bus
 	 * so we only need to map 64kB.
@@ -573,12 +573,12 @@ static int irq_choose_cpu(const cpumask_
 
 	if (cpumask_equal(mask, cpu_all_mask)) {
 		static int irq_rover;
-		static DEFINE_SPINLOCK(irq_rover_lock);
+		static DEFINE_RAW_SPINLOCK(irq_rover_lock);
 		unsigned long flags;
 
 		/* Round-robin distribution... */
 	do_round_robin:
-		spin_lock_irqsave(&irq_rover_lock, flags);
+		raw_spin_lock_irqsave(&irq_rover_lock, flags);
 
 		while (!cpu_online(irq_rover)) {
 			if (++irq_rover >= NR_CPUS)
@@ -590,7 +590,7 @@ static int irq_choose_cpu(const cpumask_
 				irq_rover = 0;
 		} while (!cpu_online(irq_rover));
 
-		spin_unlock_irqrestore(&irq_rover_lock, flags);
+		raw_spin_unlock_irqrestore(&irq_rover_lock, flags);
 	} else {
 		cpuid = cpumask_first_and(mask, cpu_online_mask);
 		if (cpuid >= nr_cpu_ids)
@@ -1368,14 +1368,14 @@ void __init mpic_set_serial_int(struct m
 	unsigned long flags;
 	u32 v;
 
-	spin_lock_irqsave(&mpic_lock, flags);
+	raw_spin_lock_irqsave(&mpic_lock, flags);
 	v = mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1);
 	if (enable)
 		v |= MPIC_GREG_GLOBAL_CONF_1_SIE;
 	else
 		v &= ~MPIC_GREG_GLOBAL_CONF_1_SIE;
 	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1, v);
-	spin_unlock_irqrestore(&mpic_lock, flags);
+	raw_spin_unlock_irqrestore(&mpic_lock, flags);
 }
 
 void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
@@ -1388,7 +1388,7 @@ void mpic_irq_set_priority(unsigned int 
 	if (!mpic)
 		return;
 
-	spin_lock_irqsave(&mpic_lock, flags);
+	raw_spin_lock_irqsave(&mpic_lock, flags);
 	if (mpic_is_ipi(mpic, irq)) {
 		reg = mpic_ipi_read(src - mpic->ipi_vecs[0]) &
 			~MPIC_VECPRI_PRIORITY_MASK;
@@ -1400,7 +1400,7 @@ void mpic_irq_set_priority(unsigned int 
 		mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
 	}
-	spin_unlock_irqrestore(&mpic_lock, flags);
+	raw_spin_unlock_irqrestore(&mpic_lock, flags);
 }
 
 void mpic_setup_this_cpu(void)
@@ -1415,7 +1415,7 @@ void mpic_setup_this_cpu(void)
 
 	DBG("%s: setup_this_cpu(%d)\n", mpic->name, hard_smp_processor_id());
 
-	spin_lock_irqsave(&mpic_lock, flags);
+	raw_spin_lock_irqsave(&mpic_lock, flags);
 
  	/* let the mpic know we want intrs. default affinity is 0xffffffff
 	 * until changed via /proc. That's how it's done on x86. If we want
@@ -1431,7 +1431,7 @@ void mpic_setup_this_cpu(void)
 	/* Set current processor priority to 0 */
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0);
 
-	spin_unlock_irqrestore(&mpic_lock, flags);
+	raw_spin_unlock_irqrestore(&mpic_lock, flags);
 #endif /* CONFIG_SMP */
 }
 
@@ -1460,7 +1460,7 @@ void mpic_teardown_this_cpu(int secondar
 	BUG_ON(mpic == NULL);
 
 	DBG("%s: teardown_this_cpu(%d)\n", mpic->name, hard_smp_processor_id());
-	spin_lock_irqsave(&mpic_lock, flags);
+	raw_spin_lock_irqsave(&mpic_lock, flags);
 
 	/* let the mpic know we don't want intrs.  */
 	for (i = 0; i < mpic->num_sources ; i++)
@@ -1474,7 +1474,7 @@ void mpic_teardown_this_cpu(int secondar
 	 */
 	mpic_eoi(mpic);
 
-	spin_unlock_irqrestore(&mpic_lock, flags);
+	raw_spin_unlock_irqrestore(&mpic_lock, flags);
 }
 
 
