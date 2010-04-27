Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013431.893354454@samba.org>
Date: Tue, 27 Apr 2010 11:32:35 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 04/15] powerpc: cpumask: Convert fixup_irqs to new cpumask API
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

Use new cpumask_* functions, and dynamically allocate cpumask in fixup_irqs.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/kernel/irq.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/irq.c	2010-04-08 19:46:04.269196650 +1000
+++ linux-cpumask/arch/powerpc/kernel/irq.c	2010-04-22 13:03:14.615446106 +1000
@@ -290,30 +290,33 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-void fixup_irqs(cpumask_t map)
+void fixup_irqs(const struct cpumask *map)
 {
 	struct irq_desc *desc;
 	unsigned int irq;
 	static int warned;
+	cpumask_var_t mask;
 
-	for_each_irq(irq) {
-		cpumask_t mask;
+	alloc_cpumask_var(&mask, GFP_KERNEL);
 
+	for_each_irq(irq) {
 		desc = irq_to_desc(irq);
 		if (desc && desc->status & IRQ_PER_CPU)
 			continue;
 
-		cpumask_and(&mask, desc->affinity, &map);
-		if (any_online_cpu(mask) == NR_CPUS) {
+		cpumask_and(mask, desc->affinity, map);
+		if (cpumask_any(mask) >= nr_cpu_ids) {
 			printk("Breaking affinity for irq %i\n", irq);
-			mask = map;
+			cpumask_copy(mask, map);
 		}
 		if (desc->chip->set_affinity)
-			desc->chip->set_affinity(irq, &mask);
+			desc->chip->set_affinity(irq, mask);
 		else if (desc->action && !(warned++))
 			printk("Cannot set affinity for irq %i\n", irq);
 	}
 
+	free_cpumask_var(mask);
+
 	local_irq_enable();
 	mdelay(1);
 	local_irq_disable();
Index: linux-cpumask/arch/powerpc/kernel/smp.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/smp.c	2010-04-22 13:03:13.025446124 +1000
+++ linux-cpumask/arch/powerpc/kernel/smp.c	2010-04-22 13:03:14.615446106 +1000
@@ -313,7 +313,7 @@ int generic_cpu_disable(void)
 	set_cpu_online(cpu, false);
 #ifdef CONFIG_PPC64
 	vdso_data->processorCount--;
-	fixup_irqs(cpu_online_map);
+	fixup_irqs(cpu_online_mask);
 #endif
 	return 0;
 }
@@ -333,7 +333,7 @@ int generic_cpu_enable(unsigned int cpu)
 		cpu_relax();
 
 #ifdef CONFIG_PPC64
-	fixup_irqs(cpu_online_map);
+	fixup_irqs(cpu_online_mask);
 	/* counter the irq disable in fixup_irqs */
 	local_irq_enable();
 #endif
Index: linux-cpumask/arch/powerpc/include/asm/smp.h
===================================================================
--- linux-cpumask.orig/arch/powerpc/include/asm/smp.h	2010-04-08 19:46:04.299203515 +1000
+++ linux-cpumask/arch/powerpc/include/asm/smp.h	2010-04-22 13:03:14.635445670 +1000
@@ -40,7 +40,7 @@ extern void smp_message_recv(int);
 DECLARE_PER_CPU(unsigned int, cpu_pvr);
 
 #ifdef CONFIG_HOTPLUG_CPU
-extern void fixup_irqs(cpumask_t map);
+extern void fixup_irqs(const struct cpumask *map);
 int generic_cpu_disable(void);
 int generic_cpu_enable(unsigned int cpu);
 void generic_cpu_die(unsigned int cpu);
