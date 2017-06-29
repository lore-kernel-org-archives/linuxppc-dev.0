Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyrV75XDczDr4s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:13:19 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id z6so11985096pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 00:13:19 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 3/4] powerpc/smp: Add cpu_l2_cache_map
Date: Thu, 29 Jun 2017 17:12:55 +1000
Message-Id: <20170629071256.8159-4-oohall@gmail.com>
In-Reply-To: <20170629071256.8159-1-oohall@gmail.com>
References: <20170629071256.8159-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want to add an extra level to the CPU scheduler topology to account
for cores which share a cache. To do this we need to build a cpumask
for each CPU that indicates which CPUs share this cache to use as an
input to the scheduler.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/smp.h |  6 ++++++
 arch/powerpc/kernel/smp.c      | 23 +++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 8ea98504f900..fac963e10d39 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -97,6 +97,7 @@ static inline void set_hard_smp_processor_id(int cpu, int phys)
 #endif
 
 DECLARE_PER_CPU(cpumask_var_t, cpu_sibling_map);
+DECLARE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
 DECLARE_PER_CPU(cpumask_var_t, cpu_core_map);
 
 static inline struct cpumask *cpu_sibling_mask(int cpu)
@@ -109,6 +110,11 @@ static inline struct cpumask *cpu_core_mask(int cpu)
 	return per_cpu(cpu_core_map, cpu);
 }
 
+static inline struct cpumask *cpu_l2_cache_mask(int cpu)
+{
+	return per_cpu(cpu_l2_cache_map, cpu);
+}
+
 extern int cpu_to_core_id(int cpu);
 
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 4c50f5fe5366..46f071cedf31 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -74,9 +74,11 @@ static DEFINE_PER_CPU(int, cpu_state) = { 0 };
 struct thread_info *secondary_ti;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
+DEFINE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_core_map);
 
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
+EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 
 /* SMP operations for this machine */
@@ -606,6 +608,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for_each_possible_cpu(cpu) {
 		zalloc_cpumask_var_node(&per_cpu(cpu_sibling_map, cpu),
 					GFP_KERNEL, cpu_to_node(cpu));
+		zalloc_cpumask_var_node(&per_cpu(cpu_l2_cache_map, cpu),
+					GFP_KERNEL, cpu_to_node(cpu));
 		zalloc_cpumask_var_node(&per_cpu(cpu_core_map, cpu),
 					GFP_KERNEL, cpu_to_node(cpu));
 		/*
@@ -620,6 +624,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 	/* Init the cpumasks so the boot CPU is related to itself */
 	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
+	cpumask_set_cpu(boot_cpuid, cpu_l2_cache_mask(boot_cpuid));
 	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
 
 	if (smp_ops && smp_ops->probe)
@@ -903,6 +908,7 @@ static void remove_cpu_from_masks(int cpu)
 	/* NB: cpu_core_mask is a superset of the others */
 	for_each_cpu(i, cpu_core_mask(cpu)) {
 		set_cpus_unrelated(cpu, i, cpu_core_mask);
+		set_cpus_unrelated(cpu, i, cpu_l2_cache_mask);
 		set_cpus_unrelated(cpu, i, cpu_sibling_mask);
 	}
 }
@@ -924,17 +930,22 @@ static void add_cpu_to_masks(int cpu)
 			set_cpus_related(i, cpu, cpu_sibling_mask);
 
 	/*
-	 * Copy the thread sibling into core sibling mask, and
-	 * add CPUs that share a chip or an L2 to the core sibling
-	 * mask.
+	 * Copy the thread sibling mask into the cache sibling mask
+	 * and mark any CPUs that share an L2 with this CPU.
 	 */
 	for_each_cpu(i, cpu_sibling_mask(cpu))
+		set_cpus_related(cpu, i, cpu_l2_cache_mask);
+	update_mask_by_l2(cpu, cpu_l2_cache_mask);
+
+	/*
+	 * Copy the cache sibling mask into core sibling mask and mark
+	 * any CPUs on the same chip as this CPU.
+	 */
+	for_each_cpu(i, cpu_l2_cache_mask(cpu))
 		set_cpus_related(cpu, i, cpu_core_mask);
 
-	if (chipid == -1) {
-		update_mask_by_l2(cpu, cpu_core_mask);
+	if (chipid == -1)
 		return;
-	}
 
 	for_each_cpu(i, cpu_online_mask)
 		if (cpu_to_chip_id(i) == chipid)
-- 
2.9.4
