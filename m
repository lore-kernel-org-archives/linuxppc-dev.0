Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYYcN5NtYzDqLh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 11:49:40 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 25so7400911pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 16:49:40 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 2/5] powerpc/smp: add set_cpus_related()
Date: Thu,  2 Mar 2017 11:49:17 +1100
Message-Id: <20170302004920.21948-2-oohall@gmail.com>
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

Add a helper function for updating the per-cpu core and sibling thread
cpumasks. This helper just sets (or clears) the relevant bit in the
cpumasks each CPU. This is open-coded in several places inside the
mask setup code so moving it into a seperate function is a sensible
cleanup.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/smp.c | 61 ++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index dfe0e1d9cd06..1c531887ca51 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -377,6 +377,25 @@ static void smp_store_cpu_info(int id)
 #endif
 }
 
+/*
+ * Relationships between CPUs are maintained in a set of per-cpu cpumasks. We
+ * need to ensure that they are kept consistant between CPUs when they are
+ * changed.
+ *
+ * This is slightly tricky since the core mask must be a strict superset of
+ * the sibling mask.
+ */
+static void set_cpus_related(int i, int j, bool related, struct cpumask *(*relation_fn)(int))
+{
+	if (related) {
+		cpumask_set_cpu(i, relation_fn(j));
+		cpumask_set_cpu(j, relation_fn(i));
+	} else {
+		cpumask_clear_cpu(i, relation_fn(j));
+		cpumask_clear_cpu(j, relation_fn(i));
+	}
+}
+
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned int cpu;
@@ -616,17 +635,9 @@ static void traverse_siblings_chip_id(int cpu, bool add, int chipid)
 	const struct cpumask *mask = add ? cpu_online_mask : cpu_present_mask;
 	int i;
 
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
+	for_each_cpu(i, mask)
+		if (cpu_to_chip_id(i) == chipid)
+			set_cpus_related(cpu, i, add, cpu_core_mask);
 }
 
 /* Must be called when no change can occur to cpu_present_mask,
@@ -666,23 +677,17 @@ static void traverse_core_siblings(int cpu, bool add)
 		return;
 	}
 
-	/* if the chip-id fails then threads which share L2 cache are */
-
+	/* if the chip-id fails then group siblings by the L2 cache */
 	l2_cache = cpu_to_l2cache(cpu);
 	mask = add ? cpu_online_mask : cpu_present_mask;
 	for_each_cpu(i, mask) {
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
+			set_cpus_related(cpu, i, add, cpu_core_mask);
+
 		of_node_put(np);
 	}
 	of_node_put(l2_cache);
@@ -720,15 +725,13 @@ void start_secondary(void *unused)
 	for (i = 0; i < threads_per_core; i++) {
 		if (cpu_is_offline(base + i) && (cpu != base + i))
 			continue;
-		cpumask_set_cpu(cpu, cpu_sibling_mask(base + i));
-		cpumask_set_cpu(base + i, cpu_sibling_mask(cpu));
+		set_cpus_related(cpu, base + i, true, cpu_sibling_mask);
 
 		/* cpu_core_map should be a superset of
 		 * cpu_sibling_map even if we don't have cache
 		 * information, so update the former here, too.
 		 */
-		cpumask_set_cpu(cpu, cpu_core_mask(base + i));
-		cpumask_set_cpu(base + i, cpu_core_mask(cpu));
+		set_cpus_related(cpu, base + i, true, cpu_core_mask);
 	}
 	traverse_core_siblings(cpu, true);
 
@@ -818,10 +821,8 @@ int __cpu_disable(void)
 	/* Update sibling maps */
 	base = cpu_first_thread_sibling(cpu);
 	for (i = 0; i < threads_per_core && base + i < nr_cpu_ids; i++) {
-		cpumask_clear_cpu(cpu, cpu_sibling_mask(base + i));
-		cpumask_clear_cpu(base + i, cpu_sibling_mask(cpu));
-		cpumask_clear_cpu(cpu, cpu_core_mask(base + i));
-		cpumask_clear_cpu(base + i, cpu_core_mask(cpu));
+		set_cpus_related(cpu, base + i, false, cpu_sibling_mask);
+		set_cpus_related(cpu, base + i, false, cpu_core_mask);
 	}
 	traverse_core_siblings(cpu, false);
 
-- 
2.9.3
