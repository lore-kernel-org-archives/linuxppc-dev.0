Return-Path: <srs0=i+vg=25=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmmlw4GCYzDqZl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:50:04 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vmmlw36slz8xW3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:50:04 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vmmlv0V9kz9s2s
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2017 17:50:02 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 05/12] powerpc/smp: Remove migrate_irq() custom implementation
Date: Mon, 20 Mar 2017 17:49:07 +1100
Message-Id: <20170320064914.4437-5-benh@kernel.crashing.org>
In-Reply-To: <20170320064914.4437-1-benh@kernel.crashing.org>
References: <20170320064914.4437-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some powerpc platforms use this to move IRQs away from a CPU
being unplugged. This function has several bugs such as not
taking the right locks or failing to NULL check pointers.

There's a new generic function doing exactly the same thing
without all the bugs, so let's use it instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig           |  1 +
 arch/powerpc/include/asm/smp.h |  1 -
 arch/powerpc/kernel/irq.c      | 40 ----------------------------------------
 arch/powerpc/kernel/smp.c      |  9 ++++++++-
 4 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 97a8bc8..29fb0e6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -431,6 +431,7 @@ config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
 	depends on SMP && (PPC_PSERIES || \
 	PPC_PMAC || PPC_POWERNV || FSL_SOC_BOOKE)
+	select GENERIC_IRQ_MIGRATION
 	---help---
 	  Say Y here to be able to disable and re-enable individual
 	  CPUs at runtime on SMP machines.
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 2f8e36f..63fa780 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -62,7 +62,6 @@ extern void smp_generic_take_timebase(void);
 DECLARE_PER_CPU(unsigned int, cpu_pvr);
 
 #ifdef CONFIG_HOTPLUG_CPU
-extern void migrate_irqs(void);
 int generic_cpu_disable(void);
 void generic_cpu_die(unsigned int cpu);
 void generic_set_cpu_dead(unsigned int cpu);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a018f5c..8ee7b44 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -442,46 +442,6 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 	return sum;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
-void migrate_irqs(void)
-{
-	struct irq_desc *desc;
-	unsigned int irq;
-	static int warned;
-	cpumask_var_t mask;
-	const struct cpumask *map = cpu_online_mask;
-
-	alloc_cpumask_var(&mask, GFP_KERNEL);
-
-	for_each_irq_desc(irq, desc) {
-		struct irq_data *data;
-		struct irq_chip *chip;
-
-		data = irq_desc_get_irq_data(desc);
-		if (irqd_is_per_cpu(data))
-			continue;
-
-		chip = irq_data_get_irq_chip(data);
-
-		cpumask_and(mask, irq_data_get_affinity_mask(data), map);
-		if (cpumask_any(mask) >= nr_cpu_ids) {
-			pr_warn("Breaking affinity for irq %i\n", irq);
-			cpumask_copy(mask, map);
-		}
-		if (chip->irq_set_affinity)
-			chip->irq_set_affinity(data, mask, true);
-		else if (desc->action && !(warned++))
-			pr_err("Cannot set affinity for irq %i\n", irq);
-	}
-
-	free_cpumask_var(mask);
-
-	local_irq_enable();
-	mdelay(1);
-	local_irq_disable();
-}
-#endif
-
 static inline void check_stack_overflow(void)
 {
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index b12f5f0..6e61cdb 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -439,7 +439,14 @@ int generic_cpu_disable(void)
 #ifdef CONFIG_PPC64
 	vdso_data->processorCount--;
 #endif
-	migrate_irqs();
+	/* Update affinity of all IRQs previously aimed at this CPU */
+	irq_migrate_all_off_this_cpu();
+
+	/* Give the CPU time to drain in-flight ones */
+	local_irq_enable();
+	mdelay(1);
+	local_irq_disable();
+
 	return 0;
 }
 
-- 
2.9.3
