Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYYcT4QWGzDqN8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 11:49:45 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id s67so7400192pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 16:49:45 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 3/5] powerpc/smp: Add update_cpu_masks()
Date: Thu,  2 Mar 2017 11:49:18 +1100
Message-Id: <20170302004920.21948-3-oohall@gmail.com>
In-Reply-To: <20170302004920.21948-1-oohall@gmail.com>
References: <20170302004920.21948-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When adding and removing a CPU from the system the per-cpu masks that
are used by the scheduler to construct scheduler domains need to be updated
to account for the cpu entering or exiting the system. Currently logic this
is open-coded for the thread sibling mask and shared for the core mask.
This patch moves all the logic for rebuilding these masks into a single
function and simplifies the logic which determines which CPUs are within
a "core".

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/smp.c | 90 ++++++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 1c531887ca51..3922cace927e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -630,14 +630,20 @@ int cpu_first_thread_of_core(int core)
 }
 EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
 
-static void traverse_siblings_chip_id(int cpu, bool add, int chipid)
+static bool update_core_mask_by_chip_id(int cpu, bool add)
 {
 	const struct cpumask *mask = add ? cpu_online_mask : cpu_present_mask;
+	int chipid = cpu_to_chip_id(cpu);
 	int i;
 
+	if (chipid == -1)
+		return false;
+
 	for_each_cpu(i, mask)
 		if (cpu_to_chip_id(i) == chipid)
 			set_cpus_related(cpu, i, add, cpu_core_mask);
+
+	return true;
 }
 
 /* Must be called when no change can occur to cpu_present_mask,
@@ -662,42 +668,72 @@ static struct device_node *cpu_to_l2cache(int cpu)
 	return cache;
 }
 
-static void traverse_core_siblings(int cpu, bool add)
+static bool update_core_mask_by_l2(int cpu, bool onlining)
 {
+	const struct cpumask *mask = onlining ? cpu_online_mask : cpu_present_mask;
 	struct device_node *l2_cache, *np;
-	const struct cpumask *mask;
-	int chip_id;
 	int i;
 
-	/* threads that share a chip-id are considered siblings (same die) */
-	chip_id = cpu_to_chip_id(cpu);
-
-	if (chip_id >= 0) {
-		traverse_siblings_chip_id(cpu, add, chip_id);
-		return;
-	}
-
-	/* if the chip-id fails then group siblings by the L2 cache */
 	l2_cache = cpu_to_l2cache(cpu);
-	mask = add ? cpu_online_mask : cpu_present_mask;
+	if (l2_cache == NULL)
+		return false;
+
 	for_each_cpu(i, mask) {
 		np = cpu_to_l2cache(i);
 		if (!np)
 			continue;
 
 		if (np == l2_cache)
-			set_cpus_related(cpu, i, add, cpu_core_mask);
+			set_cpus_related(cpu, i, onlining, cpu_core_mask);
 
 		of_node_put(np);
 	}
 	of_node_put(l2_cache);
+
+	return true;
+}
+
+static void update_thread_mask(int cpu, bool onlining)
+{
+	int base = cpu_first_thread_sibling(cpu);
+	int i;
+
+	pr_info("CPUDEBUG: onlining cpu %d, base %d, thread_per_core %d",
+		cpu, base, threads_per_core);
+
+	for (i = 0; i < threads_per_core; i++) {
+		/* Threads are onlined one by one. By the final time this
+		 * function is called for the core the sibling mask for each
+		 * thread will be complete, but we need to ensure that offline
+		 * threads aren't touched before they run start_secondary() */
+		if (onlining && cpu_is_offline(base + i) && (cpu != base + i))
+			continue;
+
+		set_cpus_related(cpu, base + i, onlining, cpu_sibling_mask);
+	}
+}
+
+static void update_cpu_masks(int cpu, bool onlining)
+{
+	int i;
+
+	update_thread_mask(cpu, onlining);
+
+	if (update_core_mask_by_chip_id(cpu, onlining))
+		return;
+
+	if (update_core_mask_by_l2(cpu, onlining))
+		return;
+
+	/* if all else fails duplicate the sibling mask */
+	for_each_cpu(i, cpu_sibling_mask(cpu))
+		set_cpus_related(cpu, i, onlining, cpu_core_mask);
 }
 
 /* Activate a secondary processor. */
 void start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
-	int i, base;
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
@@ -721,19 +757,7 @@ void start_secondary(void *unused)
 	vdso_getcpu_init();
 #endif
 	/* Update sibling maps */
-	base = cpu_first_thread_sibling(cpu);
-	for (i = 0; i < threads_per_core; i++) {
-		if (cpu_is_offline(base + i) && (cpu != base + i))
-			continue;
-		set_cpus_related(cpu, base + i, true, cpu_sibling_mask);
-
-		/* cpu_core_map should be a superset of
-		 * cpu_sibling_map even if we don't have cache
-		 * information, so update the former here, too.
-		 */
-		set_cpus_related(cpu, base + i, true, cpu_core_mask);
-	}
-	traverse_core_siblings(cpu, true);
+	update_cpu_masks(cpu, true);
 
 	set_numa_node(numa_cpu_lookup_table[cpu]);
 	set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]));
@@ -808,7 +832,6 @@ void __init smp_cpus_done(unsigned int max_cpus)
 int __cpu_disable(void)
 {
 	int cpu = smp_processor_id();
-	int base, i;
 	int err;
 
 	if (!smp_ops->cpu_disable)
@@ -819,12 +842,7 @@ int __cpu_disable(void)
 		return err;
 
 	/* Update sibling maps */
-	base = cpu_first_thread_sibling(cpu);
-	for (i = 0; i < threads_per_core && base + i < nr_cpu_ids; i++) {
-		set_cpus_related(cpu, base + i, false, cpu_sibling_mask);
-		set_cpus_related(cpu, base + i, false, cpu_core_mask);
-	}
-	traverse_core_siblings(cpu, false);
+	update_cpu_masks(cpu, false);
 
 	return 0;
 }
-- 
2.9.3
