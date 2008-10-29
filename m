Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 30DA2DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 15:02:13 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Subject: [PATCH v2][for 2.6.28] powerpc/mpic: Add support for MPICs that only
	support a single CPU destination
Date: Tue, 28 Oct 2008 23:01:39 -0500
Message-Id: <1225252899-20752-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	Paul Mackerras <paulus@samba.org>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Freescale implementation of MPIC only allows a single CPU destination
for non-IPI interrupts.  We add a flag to the mpic_init to distinquish
these variants of MPIC.  We pull in the irq_choose_cpu from sparc64 to
select a single CPU as the destination of the interrupt.

This is to deal with the fact that the default smp affinity was
changed by commit 18404756765c713a0be4eb1082920c04822ce588.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Changed requested by Ben to use irq_choose_cpu from sparc64 land.

- k

 arch/powerpc/include/asm/mpic.h          |    2 +
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |    3 +-
 arch/powerpc/platforms/86xx/pic.c        |    3 +-
 arch/powerpc/sysdev/mpic.c               |   59 ++++++++++++++++++++++++++++--
 4 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index 34d9ac4..c2ccca5 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -355,6 +355,8 @@ struct mpic
 #define MPIC_NO_BIAS			0x00000400
 /* Ignore NIRQS as reported by FRR */
 #define MPIC_BROKEN_FRR_NIRQS		0x00000800
+/* Destination only supports a single CPU at a time */
+#define MPIC_SINGLE_DEST_CPU		0x00001000
 
 /* MPIC HW modification ID */
 #define MPIC_REGSET_MASK		0xf0000000
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 483b65c..613bf8c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -78,7 +78,8 @@ void __init mpc85xx_ds_pic_init(void)
 
 	mpic = mpic_alloc(np, r.start,
 			  MPIC_PRIMARY | MPIC_WANTS_RESET |
-			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
+			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
+			  MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 	of_node_put(np);
diff --git a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
index 8881c5d..668275d 100644
--- a/arch/powerpc/platforms/86xx/pic.c
+++ b/arch/powerpc/platforms/86xx/pic.c
@@ -44,7 +44,8 @@ void __init mpc86xx_init_irq(void)
 
 	mpic = mpic_alloc(np, res.start,
 			MPIC_PRIMARY | MPIC_WANTS_RESET |
-			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
+			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS |
+			MPIC_SINGLE_DEST_CPU,
 			0, 256, " MPIC     ");
 	of_node_put(np);
 	BUG_ON(mpic == NULL);
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 8e3478c..f6299cc 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -563,6 +563,51 @@ static void __init mpic_scan_ht_pics(struct mpic *mpic)
 
 #endif /* CONFIG_MPIC_U3_HT_IRQS */
 
+#ifdef CONFIG_SMP
+static int irq_choose_cpu(unsigned int virt_irq)
+{
+	cpumask_t mask = irq_desc[virt_irq].affinity;
+	int cpuid;
+
+	if (cpus_equal(mask, CPU_MASK_ALL)) {
+		static int irq_rover;
+		static DEFINE_SPINLOCK(irq_rover_lock);
+		unsigned long flags;
+
+		/* Round-robin distribution... */
+	do_round_robin:
+		spin_lock_irqsave(&irq_rover_lock, flags);
+
+		while (!cpu_online(irq_rover)) {
+			if (++irq_rover >= NR_CPUS)
+				irq_rover = 0;
+		}
+		cpuid = irq_rover;
+		do {
+			if (++irq_rover >= NR_CPUS)
+				irq_rover = 0;
+		} while (!cpu_online(irq_rover));
+
+		spin_unlock_irqrestore(&irq_rover_lock, flags);
+	} else {
+		cpumask_t tmp;
+
+		cpus_and(tmp, cpu_online_map, mask);
+
+		if (cpus_empty(tmp))
+			goto do_round_robin;
+
+		cpuid = first_cpu(tmp);
+	}
+
+	return cpuid;
+}
+#else
+static int irq_choose_cpu(unsigned int virt_irq)
+{
+	return hard_smp_processor_id();
+}
+#endif
 
 #define mpic_irq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
 
@@ -777,12 +822,18 @@ void mpic_set_affinity(unsigned int irq, cpumask_t cpumask)
 	struct mpic *mpic = mpic_from_irq(irq);
 	unsigned int src = mpic_irq_to_hw(irq);
 
-	cpumask_t tmp;
+	if (mpic->flags & MPIC_SINGLE_DEST_CPU) {
+		int cpuid = irq_choose_cpu(irq);
 
-	cpus_and(tmp, cpumask, cpu_online_map);
+		mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION), 1 << cpuid);
+	} else {
+		cpumask_t tmp;
 
-	mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION),
-		       mpic_physmask(cpus_addr(tmp)[0]));	
+		cpus_and(tmp, cpumask, cpu_online_map);
+
+		mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION),
+			       mpic_physmask(cpus_addr(tmp)[0]));
+	}
 }
 
 static unsigned int mpic_type_to_vecpri(struct mpic *mpic, unsigned int type)
-- 
1.5.5.1
