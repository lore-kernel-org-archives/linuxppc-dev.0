Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013432.472370907@samba.org>
Date: Tue, 27 Apr 2010 11:32:41 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 10/15] powerpc: cpumask: Dynamically allocate cpu_sibling_map
	and cpu_core_map cpumasks
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

Dynamically allocate cpu_sibling_map and cpu_core_map cpumasks.

We don't need to set_cpu_online() the boot cpu in smp_prepare_boot_cpu,
init/main.c does it for us.

We also postpone setting of the boot cpu in cpu_sibling_map and cpu_core_map
until when the memory allocator is available (smp_prepare_cpus), similar
to x86.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/include/asm/smp.h
===================================================================
--- linux-cpumask.orig/arch/powerpc/include/asm/smp.h	2010-04-22 13:03:14.635445670 +1000
+++ linux-cpumask/arch/powerpc/include/asm/smp.h	2010-04-22 13:03:22.525445945 +1000
@@ -68,8 +68,19 @@ static inline void set_hard_smp_processo
 }
 #endif
 
-DECLARE_PER_CPU(cpumask_t, cpu_sibling_map);
-DECLARE_PER_CPU(cpumask_t, cpu_core_map);
+DECLARE_PER_CPU(cpumask_var_t, cpu_sibling_map);
+DECLARE_PER_CPU(cpumask_var_t, cpu_core_map);
+
+static inline struct cpumask *cpu_sibling_mask(int cpu)
+{
+	return per_cpu(cpu_sibling_map, cpu);
+}
+
+static inline struct cpumask *cpu_core_mask(int cpu)
+{
+	return per_cpu(cpu_core_map, cpu);
+}
+
 extern int cpu_to_core_id(int cpu);
 
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
@@ -93,7 +104,6 @@ void smp_init_pSeries(void);
 void smp_init_cell(void);
 void smp_init_celleb(void);
 void smp_setup_cpu_maps(void);
-void smp_setup_cpu_sibling_map(void);
 
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
Index: linux-cpumask/arch/powerpc/include/asm/topology.h
===================================================================
--- linux-cpumask.orig/arch/powerpc/include/asm/topology.h	2010-04-12 09:17:47.827945841 +1000
+++ linux-cpumask/arch/powerpc/include/asm/topology.h	2010-04-22 13:03:22.535446350 +1000
@@ -102,8 +102,8 @@ static inline void sysfs_remove_device_f
 #ifdef CONFIG_PPC64
 #include <asm/smp.h>
 
-#define topology_thread_cpumask(cpu)	(&per_cpu(cpu_sibling_map, cpu))
-#define topology_core_cpumask(cpu)	(&per_cpu(cpu_core_map, cpu))
+#define topology_thread_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
+#define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
 #endif
 #endif
Index: linux-cpumask/arch/powerpc/kernel/smp.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/smp.c	2010-04-22 13:03:14.615446106 +1000
+++ linux-cpumask/arch/powerpc/kernel/smp.c	2010-04-22 13:03:22.545446024 +1000
@@ -59,8 +59,8 @@
 
 struct thread_info *secondary_ti;
 
-DEFINE_PER_CPU(cpumask_t, cpu_sibling_map) = CPU_MASK_NONE;
-DEFINE_PER_CPU(cpumask_t, cpu_core_map) = CPU_MASK_NONE;
+DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
+DEFINE_PER_CPU(cpumask_var_t, cpu_core_map);
 
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
@@ -271,6 +271,16 @@ void __init smp_prepare_cpus(unsigned in
 	smp_store_cpu_info(boot_cpuid);
 	cpu_callin_map[boot_cpuid] = 1;
 
+	for_each_possible_cpu(cpu) {
+		zalloc_cpumask_var_node(&per_cpu(cpu_sibling_map, cpu),
+					GFP_KERNEL, cpu_to_node(cpu));
+		zalloc_cpumask_var_node(&per_cpu(cpu_core_map, cpu),
+					GFP_KERNEL, cpu_to_node(cpu));
+	}
+
+	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
+	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
+
 	if (smp_ops)
 		if (smp_ops->probe)
 			max_cpus = smp_ops->probe();
@@ -289,10 +299,6 @@ void __init smp_prepare_cpus(unsigned in
 void __devinit smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != boot_cpuid);
-
-	set_cpu_online(boot_cpuid, true);
-	cpu_set(boot_cpuid, per_cpu(cpu_sibling_map, boot_cpuid));
-	cpu_set(boot_cpuid, per_cpu(cpu_core_map, boot_cpuid));
 #ifdef CONFIG_PPC64
 	paca[boot_cpuid].__current = current;
 #endif
@@ -517,15 +523,15 @@ int __devinit start_secondary(void *unus
 	for (i = 0; i < threads_per_core; i++) {
 		if (cpu_is_offline(base + i))
 			continue;
-		cpu_set(cpu, per_cpu(cpu_sibling_map, base + i));
-		cpu_set(base + i, per_cpu(cpu_sibling_map, cpu));
+		cpumask_set_cpu(cpu, cpu_sibling_mask(base + i));
+		cpumask_set_cpu(base + i, cpu_sibling_mask(cpu));
 
 		/* cpu_core_map should be a superset of
 		 * cpu_sibling_map even if we don't have cache
 		 * information, so update the former here, too.
 		 */
-		cpu_set(cpu, per_cpu(cpu_core_map, base +i));
-		cpu_set(base + i, per_cpu(cpu_core_map, cpu));
+		cpumask_set_cpu(cpu, cpu_core_mask(base + i));
+		cpumask_set_cpu(base + i, cpu_core_mask(cpu));
 	}
 	l2_cache = cpu_to_l2cache(cpu);
 	for_each_online_cpu(i) {
@@ -533,8 +539,8 @@ int __devinit start_secondary(void *unus
 		if (!np)
 			continue;
 		if (np == l2_cache) {
-			cpu_set(cpu, per_cpu(cpu_core_map, i));
-			cpu_set(i, per_cpu(cpu_core_map, cpu));
+			cpumask_set_cpu(cpu, cpu_core_mask(i));
+			cpumask_set_cpu(i, cpu_core_mask(cpu));
 		}
 		of_node_put(np);
 	}
@@ -594,10 +600,10 @@ int __cpu_disable(void)
 	/* Update sibling maps */
 	base = cpu_first_thread_in_core(cpu);
 	for (i = 0; i < threads_per_core; i++) {
-		cpu_clear(cpu, per_cpu(cpu_sibling_map, base + i));
-		cpu_clear(base + i, per_cpu(cpu_sibling_map, cpu));
-		cpu_clear(cpu, per_cpu(cpu_core_map, base +i));
-		cpu_clear(base + i, per_cpu(cpu_core_map, cpu));
+		cpumask_clear_cpu(cpu, cpu_sibling_mask(base + i));
+		cpumask_clear_cpu(base + i, cpu_sibling_mask(cpu));
+		cpumask_clear_cpu(cpu, cpu_core_mask(base + i));
+		cpumask_clear_cpu(base + i, cpu_core_mask(cpu));
 	}
 
 	l2_cache = cpu_to_l2cache(cpu);
@@ -606,8 +612,8 @@ int __cpu_disable(void)
 		if (!np)
 			continue;
 		if (np == l2_cache) {
-			cpu_clear(cpu, per_cpu(cpu_core_map, i));
-			cpu_clear(i, per_cpu(cpu_core_map, cpu));
+			cpumask_clear_cpu(cpu, cpu_core_mask(i));
+			cpumask_clear_cpu(i, cpu_core_mask(cpu));
 		}
 		of_node_put(np);
 	}
Index: linux-cpumask/arch/powerpc/platforms/cell/cbe_cpufreq.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c	2010-04-08 19:46:03.749196323 +1000
+++ linux-cpumask/arch/powerpc/platforms/cell/cbe_cpufreq.c	2010-04-22 13:03:22.545446024 +1000
@@ -118,7 +118,7 @@ static int cbe_cpufreq_cpu_init(struct c
 	policy->cur = cbe_freqs[cur_pmode].frequency;
 
 #ifdef CONFIG_SMP
-	cpumask_copy(policy->cpus, &per_cpu(cpu_sibling_map, policy->cpu));
+	cpumask_copy(policy->cpus, cpu_sibling_mask(policy->cpu));
 #endif
 
 	cpufreq_frequency_table_get_attr(cbe_freqs, policy->cpu);
