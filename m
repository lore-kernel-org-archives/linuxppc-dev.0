Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYYcZ5qbgzDqN2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 11:49:50 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id j5so4985665pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 16:49:50 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 5/5] powerpc/smp: Add Power9 scheduler topology
Date: Thu,  2 Mar 2017 11:49:20 +1100
Message-Id: <20170302004920.21948-5-oohall@gmail.com>
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

In previous generations of Power processors each core had a private L2
cache. The Power9 processor has a slightly different architecture where
the L2 cache is shared among pairs of cores rather than being completely
private.

Making the scheduler aware of this cache sharing allows the scheduler to
make more intelligent migration decisions. When one core in the pair is
overloaded tasks can be migrated to its paired core to improve throughput
without cache-refilling penality typically associated with task
migration.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/smp.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5571f30ff72d..5e1811b24415 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -673,7 +673,7 @@ static struct device_node *cpu_to_l2cache(int cpu)
 	return cache;
 }
 
-static bool update_core_mask_by_l2(int cpu, bool onlining)
+static bool update_mask_by_l2(int cpu, bool onlining, struct cpumask *(*mask_fn)(int))
 {
 	const struct cpumask *mask = onlining ? cpu_online_mask : cpu_present_mask;
 	struct device_node *l2_cache, *np;
@@ -689,7 +689,7 @@ static bool update_core_mask_by_l2(int cpu, bool onlining)
 			continue;
 
 		if (np == l2_cache)
-			set_cpus_related(cpu, i, onlining, cpu_core_mask);
+			set_cpus_related(cpu, i, onlining, mask_fn);
 
 		of_node_put(np);
 	}
@@ -724,10 +724,17 @@ static void update_cpu_masks(int cpu, bool onlining)
 
 	update_thread_mask(cpu, onlining);
 
+	/* we need the l2 cache mask for the power9 scheduler topology */
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		update_mask_by_l2(cpu, onlining, cpu_cache_mask);
+
+	/* now build the core mask */
+	set_cpus_related(cpu, cpu, onlining, cpu_core_mask);
+
 	if (update_core_mask_by_chip_id(cpu, onlining))
 		return;
 
-	if (update_core_mask_by_l2(cpu, onlining))
+	if (update_mask_by_l2(cpu, onlining, cpu_core_mask))
 		return;
 
 	/* if all else fails duplicate the sibling mask */
@@ -805,6 +812,32 @@ static struct sched_domain_topology_level powerpc_topology[] = {
 	{ NULL, },
 };
 
+
+/* P9 has a slightly odd architecture where two, four thread cores share an L2
+ * cache. For highly threaded workloads it makes sense to try and keep tasks
+ * inside the pair for better cache utilisation so the scheduler needs to be
+ * aware of this. */
+static int powerpc_shared_cache_flags(void)
+{
+	return SD_SHARE_PKG_RESOURCES | SD_PREFER_SIBLING;
+}
+
+/* this is kind of gross, but passing cpu_cache_mask directly
+ * causes the build to fail due to incompatible pointer types */
+static inline const struct cpumask *cpu_cache_mask_c(int cpu)
+{
+	return cpu_cache_mask(cpu);
+}
+
+static struct sched_domain_topology_level power9_topology[] = {
+#ifdef CONFIG_SCHED_SMT
+	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
+#endif
+	{ cpu_cache_mask_c, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ NULL, },
+};
+
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	cpumask_var_t old_mask;
@@ -829,7 +862,10 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 	dump_numa_cpu_topology();
 
-	set_sched_topology(powerpc_topology);
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		set_sched_topology(power9_topology);
+	else
+		set_sched_topology(powerpc_topology);
 
 }
 
-- 
2.9.3
