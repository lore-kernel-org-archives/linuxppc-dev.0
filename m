Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyrVB0YQNzDr51
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 17:13:22 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u62so10887771pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 00:13:21 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 4/4] powerpc/smp: Add Power9 scheduler topology
Date: Thu, 29 Jun 2017 17:12:56 +1000
Message-Id: <20170629071256.8159-5-oohall@gmail.com>
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

In previous generations of Power processors each core had a private L2
cache. The Power 9 processor has a slightly different design where the
L2 cache is shared among pairs of cores rather than being completely
private.

Making the scheduler aware of this cache sharing allows the scheduler to
make better migration decisions. For example, if two CPU heavy tasks
share a core then one task can be migrated to the paired core to improve
throughput. Under the existing three level topology the task could be
migrated to any core on the same chip, while with the new topology it
would be preferentially migrated to the paired core so it remains
cache-hot.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/smp.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 46f071cedf31..7b2ed0d6fc96 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -952,6 +952,8 @@ static void add_cpu_to_masks(int cpu)
 			set_cpus_related(cpu, i, cpu_core_mask);
 }
 
+static bool shared_caches;
+
 /* Activate a secondary processor. */
 void start_secondary(void *unused)
 {
@@ -981,6 +983,13 @@ void start_secondary(void *unused)
 	/* Update topology CPU masks */
 	add_cpu_to_masks(cpu);
 
+	/*
+	 * Check for any shared caches. Note that this must be done on a
+	 * per-core basis because one core in the pair might be disabled.
+	 */
+	if (!cpumask_equal(cpu_l2_cache_mask(cpu), cpu_sibling_mask(cpu)))
+		shared_caches = true;
+
 	set_numa_node(numa_cpu_lookup_table[cpu]);
 	set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]));
 
@@ -1022,6 +1031,35 @@ static struct sched_domain_topology_level powerpc_topology[] = {
 	{ NULL, },
 };
 
+/*
+ * P9 has a slightly odd architecture where pairs of cores share an L2 cache.
+ * This topology makes it *much* cheaper to migrate tasks between adjacent cores
+ * since the migrated task remains cache hot. We want to take advantage of this
+ * at the scheduler level so an extra topology level is required.
+ */
+static int powerpc_shared_cache_flags(void)
+{
+	return SD_SHARE_PKG_RESOURCES;
+}
+
+/*
+ * We can't just pass cpu_l2_cache_mask() directly because
+ * returns a non-const pointer and the compiler barfs on that.
+ */
+static const struct cpumask *shared_cache_mask(int cpu)
+{
+	return cpu_l2_cache_mask(cpu);
+}
+
+static struct sched_domain_topology_level power9_topology[] = {
+#ifdef CONFIG_SCHED_SMT
+	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
+#endif
+	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ NULL, },
+};
+
 static __init long smp_setup_cpu_workfn(void *data __always_unused)
 {
 	smp_ops->setup_cpu(boot_cpuid);
@@ -1043,7 +1081,19 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 	dump_numa_cpu_topology();
 
-	set_sched_topology(powerpc_topology);
+	/*
+	 * If any CPU detects that it's sharing a cache with another CPU then
+	 * use the deeper topology that is aware of this sharing.
+	 */
+	if (shared_caches) {
+		pr_info("Using shared cache scheduler topology\n");
+		set_sched_topology(power9_topology);
+		/* HACK: warn if we're using this on anything by P9 */
+		WARN_ON((mfspr(SPRN_PVR) & 0xffffff00) != 0x004e0100);
+	} else {
+		pr_info("Using standard scheduler topology\n");
+		set_sched_topology(powerpc_topology);
+	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.9.4
