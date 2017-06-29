Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyrV54kCszDr4k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:13:17 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id d5so11994832pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 00:13:17 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 2/4] powerpc/smp: Rework CPU topology construction
Date: Thu, 29 Jun 2017 17:12:54 +1000
Message-Id: <20170629071256.8159-3-oohall@gmail.com>
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

The CPU scheduler topology is constructed from a number of per-cpu
cpumasks which describe which sets of logical CPUs are related in some
fashion. Current code that handles constructing these masks when CPUs
are hot(un)plugged can be simplified a bit by exploiting the fact that
the scheduler requires higher levels of the toplogy (e.g package level
groupings) to be supersets of the lower levels (e.g.  threas in a core).
This patch reworks the cpumask construction to be simpler and easier to
extend with extra topology levels.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/smp.c | 148 +++++++++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 66 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 40f1f268be83..4c50f5fe5366 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -569,6 +569,24 @@ static void smp_store_cpu_info(int id)
 #endif
 }
 
+/*
+ * Relationships between CPUs are maintained in a set of per-cpu cpumasks so
+ * rather than just passing around the cpumask we pass around a function that
+ * returns the that cpumask for the given CPU.
+ */
+static void set_cpus_related(int i, int j, struct cpumask *(*get_cpumask)(int))
+{
+	cpumask_set_cpu(i, get_cpumask(j));
+	cpumask_set_cpu(j, get_cpumask(i));
+}
+
+static void set_cpus_unrelated(int i, int j,
+		struct cpumask *(*get_cpumask)(int))
+{
+	cpumask_clear_cpu(i, get_cpumask(j));
+	cpumask_clear_cpu(j, get_cpumask(i));
+}
+
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned int cpu;
@@ -600,6 +618,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		}
 	}
 
+	/* Init the cpumasks so the boot CPU is related to itself */
 	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
 	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
 
@@ -827,24 +846,6 @@ int cpu_first_thread_of_core(int core)
 }
 EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
 
-static void traverse_siblings_chip_id(int cpu, bool add, int chipid)
-{
-	const struct cpumask *mask = add ? cpu_online_mask : cpu_present_mask;
-	int i;
-
-	for_each_cpu(i, mask) {
-		if (cpu_to_chip_id(i) == chipid) {
-			if (add) {
-				cpumask_set_cpu(cpu, cpu_core_mask(i));
-				cpumask_set_cpu(i, cpu_core_mask(cpu));
-			} else {
-				cpumask_clear_cpu(cpu, cpu_core_mask(i));
-				cpumask_clear_cpu(i, cpu_core_mask(cpu));
-			}
-		}
-	}
-}
-
 /* Must be called when no change can occur to cpu_present_mask,
  * i.e. during cpu online or offline.
  */
@@ -867,46 +868,83 @@ static struct device_node *cpu_to_l2cache(int cpu)
 	return cache;
 }
 
-static void traverse_core_siblings(int cpu, bool add)
+static bool update_mask_by_l2(int cpu, struct cpumask *(*mask_fn)(int))
 {
 	struct device_node *l2_cache, *np;
-	const struct cpumask *mask;
-	int chip_id;
 	int i;
 
-	/* threads that share a chip-id are considered siblings */
-	chip_id = cpu_to_chip_id(cpu);
-
-	if (chip_id >= 0) {
-		traverse_siblings_chip_id(cpu, add, chip_id);
-		return;
-	}
-
 	l2_cache = cpu_to_l2cache(cpu);
-	mask = add ? cpu_online_mask : cpu_present_mask;
-	for_each_cpu(i, mask) {
+	if (!l2_cache)
+		return false;
+
+	for_each_cpu(i, cpu_online_mask) {
+		/*
+		 * when updating the marks the current CPU has not been marked
+		 * online, but we need to update the cache masks
+		 */
 		np = cpu_to_l2cache(i);
 		if (!np)
 			continue;
-		if (np == l2_cache) {
-			if (add) {
-				cpumask_set_cpu(cpu, cpu_core_mask(i));
-				cpumask_set_cpu(i, cpu_core_mask(cpu));
-			} else {
-				cpumask_clear_cpu(cpu, cpu_core_mask(i));
-				cpumask_clear_cpu(i, cpu_core_mask(cpu));
-			}
-		}
+
+		if (np == l2_cache)
+			set_cpus_related(cpu, i, mask_fn);
+
 		of_node_put(np);
 	}
 	of_node_put(l2_cache);
+
+	return true;
+}
+
+static void remove_cpu_from_masks(int cpu)
+{
+	int i;
+
+	/* NB: cpu_core_mask is a superset of the others */
+	for_each_cpu(i, cpu_core_mask(cpu)) {
+		set_cpus_unrelated(cpu, i, cpu_core_mask);
+		set_cpus_unrelated(cpu, i, cpu_sibling_mask);
+	}
+}
+
+static void add_cpu_to_masks(int cpu)
+{
+	int first_thread = cpu_first_thread_sibling(cpu);
+	int chipid = cpu_to_chip_id(cpu);
+	int i;
+
+	/*
+	 * This CPU will not be in the online mask yet so we need to manually
+	 * add it to it's own thread sibling mask.
+	 */
+	cpumask_set_cpu(cpu, cpu_sibling_mask(cpu));
+
+	for (i = first_thread; i < first_thread + threads_per_core; i++)
+		if (cpu_online(i))
+			set_cpus_related(i, cpu, cpu_sibling_mask);
+
+	/*
+	 * Copy the thread sibling into core sibling mask, and
+	 * add CPUs that share a chip or an L2 to the core sibling
+	 * mask.
+	 */
+	for_each_cpu(i, cpu_sibling_mask(cpu))
+		set_cpus_related(cpu, i, cpu_core_mask);
+
+	if (chipid == -1) {
+		update_mask_by_l2(cpu, cpu_core_mask);
+		return;
+	}
+
+	for_each_cpu(i, cpu_online_mask)
+		if (cpu_to_chip_id(i) == chipid)
+			set_cpus_related(cpu, i, cpu_core_mask);
 }
 
 /* Activate a secondary processor. */
 void start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
-	int i, base;
 
 	mmgrab(&init_mm);
 	current->active_mm = &init_mm;
@@ -929,22 +967,8 @@ void start_secondary(void *unused)
 
 	vdso_getcpu_init();
 #endif
-	/* Update sibling maps */
-	base = cpu_first_thread_sibling(cpu);
-	for (i = 0; i < threads_per_core; i++) {
-		if (cpu_is_offline(base + i) && (cpu != base + i))
-			continue;
-		cpumask_set_cpu(cpu, cpu_sibling_mask(base + i));
-		cpumask_set_cpu(base + i, cpu_sibling_mask(cpu));
-
-		/* cpu_core_map should be a superset of
-		 * cpu_sibling_map even if we don't have cache
-		 * information, so update the former here, too.
-		 */
-		cpumask_set_cpu(cpu, cpu_core_mask(base + i));
-		cpumask_set_cpu(base + i, cpu_core_mask(cpu));
-	}
-	traverse_core_siblings(cpu, true);
+	/* Update topology CPU masks */
+	add_cpu_to_masks(cpu);
 
 	set_numa_node(numa_cpu_lookup_table[cpu]);
 	set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]));
@@ -1015,7 +1039,6 @@ void __init smp_cpus_done(unsigned int max_cpus)
 int __cpu_disable(void)
 {
 	int cpu = smp_processor_id();
-	int base, i;
 	int err;
 
 	if (!smp_ops->cpu_disable)
@@ -1026,14 +1049,7 @@ int __cpu_disable(void)
 		return err;
 
 	/* Update sibling maps */
-	base = cpu_first_thread_sibling(cpu);
-	for (i = 0; i < threads_per_core && base + i < nr_cpu_ids; i++) {
-		cpumask_clear_cpu(cpu, cpu_sibling_mask(base + i));
-		cpumask_clear_cpu(base + i, cpu_sibling_mask(cpu));
-		cpumask_clear_cpu(cpu, cpu_core_mask(base + i));
-		cpumask_clear_cpu(base + i, cpu_core_mask(cpu));
-	}
-	traverse_core_siblings(cpu, false);
+	remove_cpu_from_masks(cpu);
 
 	return 0;
 }
-- 
2.9.4
