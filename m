Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013432.857489682@samba.org>
Date: Tue, 27 Apr 2010 11:32:45 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 14/15] powerpc: cpumask: Convert mpic driver to new cpumask API
References: <20100427013231.510168034@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert to the new cpumask API.

irq_choose_cpu can be simplified by using cpumask_next and cpumask_first.

smp_mpic_message_pass was doing open coded cpumask manipulation and passing an
int for a cpumask into mpic_send_ipi. Since mpic_send_ipi is only used
locally, make it static and convert it to take a cpumask. This allows us
to clean up the mess in smp_mpic_message_pass.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/sysdev/mpic.c	2010-04-22 14:52:08.876696006 +1000
+++ linux-cpumask/arch/powerpc/sysdev/mpic.c	2010-04-22 14:58:13.495445579 +1000
@@ -568,12 +568,12 @@ static void __init mpic_scan_ht_pics(str
 #endif /* CONFIG_MPIC_U3_HT_IRQS */
 
 #ifdef CONFIG_SMP
-static int irq_choose_cpu(const cpumask_t *mask)
+static int irq_choose_cpu(const struct cpumask *mask)
 {
 	int cpuid;
 
 	if (cpumask_equal(mask, cpu_all_mask)) {
-		static int irq_rover;
+		static int irq_rover = 0;
 		static DEFINE_RAW_SPINLOCK(irq_rover_lock);
 		unsigned long flags;
 
@@ -581,15 +581,11 @@ static int irq_choose_cpu(const cpumask_
 	do_round_robin:
 		raw_spin_lock_irqsave(&irq_rover_lock, flags);
 
-		while (!cpu_online(irq_rover)) {
-			if (++irq_rover >= NR_CPUS)
-				irq_rover = 0;
-		}
+		irq_rover = cpumask_next(irq_rover, cpu_online_mask);
+		if (irq_rover >= nr_cpu_ids)
+			irq_rover = cpumask_first(cpu_online_mask);
+
 		cpuid = irq_rover;
-		do {
-			if (++irq_rover >= NR_CPUS)
-				irq_rover = 0;
-		} while (!cpu_online(irq_rover));
 
 		raw_spin_unlock_irqrestore(&irq_rover_lock, flags);
 	} else {
@@ -601,7 +597,7 @@ static int irq_choose_cpu(const cpumask_
 	return get_hard_smp_processor_id(cpuid);
 }
 #else
-static int irq_choose_cpu(const cpumask_t *mask)
+static int irq_choose_cpu(const struct cpumask *mask)
 {
 	return hard_smp_processor_id();
 }
@@ -814,12 +810,16 @@ int mpic_set_affinity(unsigned int irq, 
 
 		mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION), 1 << cpuid);
 	} else {
-		cpumask_t tmp;
+		cpumask_var_t tmp;
+
+		alloc_cpumask_var(&tmp, GFP_KERNEL);
 
-		cpumask_and(&tmp, cpumask, cpu_online_mask);
+		cpumask_and(tmp, cpumask, cpu_online_mask);
 
 		mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION),
-			       mpic_physmask(cpus_addr(tmp)[0]));
+			       mpic_physmask(cpumask_bits(tmp)[0]));
+
+		free_cpumask_var(tmp);
 	}
 
 	return 0;
@@ -1479,7 +1479,7 @@ void mpic_teardown_this_cpu(int secondar
 }
 
 
-void mpic_send_ipi(unsigned int ipi_no, unsigned int cpu_mask)
+static void mpic_send_ipi(unsigned int ipi_no, const struct cpumask *cpu_mask)
 {
 	struct mpic *mpic = mpic_primary;
 
@@ -1491,7 +1491,7 @@ void mpic_send_ipi(unsigned int ipi_no, 
 
 	mpic_cpu_write(MPIC_INFO(CPU_IPI_DISPATCH_0) +
 		       ipi_no * MPIC_INFO(CPU_IPI_DISPATCH_STRIDE),
-		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
+		       mpic_physmask(cpumask_bits(cpu_mask)[0]));
 }
 
 static unsigned int _mpic_get_one_irq(struct mpic *mpic, int reg)
@@ -1591,6 +1591,8 @@ void mpic_request_ipis(void)
 
 void smp_mpic_message_pass(int target, int msg)
 {
+	cpumask_var_t tmp;
+
 	/* make sure we're sending something that translates to an IPI */
 	if ((unsigned int)msg > 3) {
 		printk("SMP %d: smp_message_pass: unknown msg %d\n",
@@ -1599,13 +1601,17 @@ void smp_mpic_message_pass(int target, i
 	}
 	switch (target) {
 	case MSG_ALL:
-		mpic_send_ipi(msg, 0xffffffff);
+		mpic_send_ipi(msg, cpu_online_mask);
 		break;
 	case MSG_ALL_BUT_SELF:
-		mpic_send_ipi(msg, 0xffffffff & ~(1 << smp_processor_id()));
+		alloc_cpumask_var(&tmp, GFP_NOWAIT);
+		cpumask_andnot(tmp, cpu_online_mask,
+			       cpumask_of(smp_processor_id()));
+		mpic_send_ipi(msg, tmp);
+		free_cpumask_var(tmp);
 		break;
 	default:
-		mpic_send_ipi(msg, 1 << target);
+		mpic_send_ipi(msg, cpumask_of(target));
 		break;
 	}
 }
@@ -1616,7 +1622,7 @@ int __init smp_mpic_probe(void)
 
 	DBG("smp_mpic_probe()...\n");
 
-	nr_cpus = cpus_weight(cpu_possible_map);
+	nr_cpus = cpumask_weight(cpu_possible_mask);
 
 	DBG("nr_cpus: %d\n", nr_cpus);
 
Index: linux-cpumask/arch/powerpc/include/asm/mpic.h
===================================================================
--- linux-cpumask.orig/arch/powerpc/include/asm/mpic.h	2010-04-22 14:52:08.896696998 +1000
+++ linux-cpumask/arch/powerpc/include/asm/mpic.h	2010-04-22 14:52:19.915447374 +1000
@@ -463,9 +463,6 @@ extern void mpic_cpu_set_priority(int pr
 /* Request IPIs on primary mpic */
 extern void mpic_request_ipis(void);
 
-/* Send an IPI (non offseted number 0..3) */
-extern void mpic_send_ipi(unsigned int ipi_no, unsigned int cpu_mask);
-
 /* Send a message (IPI) to a given target (cpu number or MSG_*) */
 void smp_mpic_message_pass(int target, int msg);
 
