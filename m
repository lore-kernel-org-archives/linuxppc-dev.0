Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v2kH6s0SzF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 15:41:59 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7K5caSV031643
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 01:41:58 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kymp1n28y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 01:41:57 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Sun, 19 Aug 2018 23:41:57 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v7 2/2] powerpc: Use cpu_smallcore_sibling_mask at SMT level
 on bigcores
Date: Mon, 20 Aug 2018 11:11:44 +0530
In-Reply-To: <1534743704-4760-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1534743704-4760-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1534743704-4760-3-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Each of the SMT4 cores forming a big-core are more or less independent
units. Thus when multiple tasks are scheduled to run on the fused
core, we get the best performance when the tasks are spread across the
pair of SMT4 cores.

This patch achieves this by setting the SMT level mask to correspond
to the smallcore sibling mask on big-core systems. This patch also
ensures that while checked for shared-caches on big-core system, we
use the smallcore_sibling_mask to compare with the l2_cache_mask.
This ensure that the CACHE level sched-domain is created, whose groups
correspond to the threads of the big-core.

With this patch, the SMT sched-domain with SMT=8,4,2 on big-core
systems are as follows:

1) ppc64_cpu --smt=8

 CPU0 attaching sched-domain(s):
  domain-0: span=0,2,4,6 level=SMT
   groups: 0:{ span=0 cap=294 }, 2:{ span=2 cap=294 },
           4:{ span=4 cap=294 }, 6:{ span=6 cap=294 }
 CPU1 attaching sched-domain(s):
  domain-0: span=1,3,5,7 level=SMT
   groups: 1:{ span=1 cap=294 }, 3:{ span=3 cap=294 },
           5:{ span=5 cap=294 }, 7:{ span=7 cap=294 }

2) ppc64_cpu --smt=4

 CPU0 attaching sched-domain(s):
  domain-0: span=0,2 level=SMT
   groups: 0:{ span=0 cap=589 }, 2:{ span=2 cap=589 }
 CPU1 attaching sched-domain(s):
  domain-0: span=1,3 level=SMT
   groups: 1:{ span=1 cap=589 }, 3:{ span=3 cap=589 }

3) ppc64_cpu --smt=2
   SMT domain is a trivial domain consisting of just
   1 CPU. Hence this domain gets collapsed leaving only CACHE, DIE and
   NUMA domains.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 136 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 4794d6b..00f60a8 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -76,6 +76,7 @@
 struct thread_info *secondary_ti;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
+DEFINE_PER_CPU(cpumask_var_t, cpu_smallcore_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_core_map);
 
@@ -83,6 +84,23 @@
 EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 
+/*
+ * On big-cores system, cpu_l1_cache_map for each CPU corresponds to
+ * the set its siblings that share the l1-cache. This map is
+ * initialized the first time the CPU comes online, and subsequently
+ * remains unchanged.
+ *
+ * parse_success records if there has been an error in parsing the
+ * "ibm,thread-groups" property which tells us which set of siblings
+ * share the l1-cache with the CPU.
+ */
+struct small_core_sibling {
+	cpumask_var_t cpu_l1_cache_map;
+	bool parse_success;
+};
+
+DEFINE_PER_CPU(struct small_core_sibling, small_core);
+
 /* SMP operations for this machine */
 struct smp_ops_t *smp_ops;
 
@@ -91,6 +109,11 @@
 
 int smt_enabled_at_boot = 1;
 
+static inline struct cpumask *cpu_smallcore_mask(int cpu)
+{
+	return per_cpu(cpu_smallcore_map, cpu);
+}
+
 /*
  * Returns 1 if the specified cpu should be brought up during boot.
  * Used to inhibit booting threads if they've been disabled or
@@ -670,6 +693,18 @@ static void set_cpus_unrelated(int i, int j,
 }
 #endif
 
+static inline void alloc_small_core_data(int cpu)
+{
+	struct small_core_sibling *this_small_core;
+
+	zalloc_cpumask_var_node(&per_cpu(cpu_smallcore_map, cpu),
+				GFP_KERNEL, cpu_to_node(cpu));
+
+	this_small_core = &per_cpu(small_core, cpu);
+	zalloc_cpumask_var_node(&this_small_core->cpu_l1_cache_map,
+				GFP_KERNEL, cpu_to_node(cpu));
+}
+
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned int cpu;
@@ -701,12 +736,19 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 			set_cpu_numa_mem(cpu,
 				local_memory_node(numa_cpu_lookup_table[cpu]));
 		}
+
+		if (has_big_cores)
+			alloc_small_core_data(cpu);
 	}
 
 	/* Init the cpumasks so the boot CPU is related to itself */
 	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
 	cpumask_set_cpu(boot_cpuid, cpu_l2_cache_mask(boot_cpuid));
 	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
+	if (has_big_cores) {
+		cpumask_set_cpu(boot_cpuid,
+				cpu_smallcore_mask(boot_cpuid));
+	}
 
 	if (smp_ops && smp_ops->probe)
 		smp_ops->probe();
@@ -991,10 +1033,83 @@ static void remove_cpu_from_masks(int cpu)
 		set_cpus_unrelated(cpu, i, cpu_core_mask);
 		set_cpus_unrelated(cpu, i, cpu_l2_cache_mask);
 		set_cpus_unrelated(cpu, i, cpu_sibling_mask);
+		if (has_big_cores)
+			set_cpus_unrelated(cpu, i, cpu_smallcore_mask);
 	}
 }
 #endif
 
+static inline void init_small_core_data(int cpu,
+					struct small_core_sibling *cpu_sc)
+{
+	struct device_node *dn;
+	int first_thread = cpu_first_thread_sibling(cpu);
+	int i, cpu_group_start = -1;
+	struct thread_groups tg;
+
+	cpumask_set_cpu(cpu, cpu_sc->cpu_l1_cache_map);
+
+	dn = of_get_cpu_node(cpu, NULL);
+	if (unlikely(!dn)) {
+		WARN_ON(1);
+		goto out;
+	}
+
+	if (unlikely(parse_thread_groups(dn, &tg,
+					 THREAD_GROUP_SHARE_L1))) {
+		WARN_ON(1);
+		goto out;
+	}
+
+	cpu_group_start = get_cpu_thread_group_start(cpu, &tg);
+
+	if (unlikely(cpu_group_start == -1)) {
+		WARN_ON(1);
+		goto out;
+	}
+
+	for (i = first_thread; i < first_thread + threads_per_core; i++) {
+		int i_group_start = get_cpu_thread_group_start(i, &tg);
+
+		if (unlikely(i_group_start == -1)) {
+			WARN_ON(1);
+			goto out;
+		}
+
+		if (i_group_start == cpu_group_start)
+			cpumask_set_cpu(i, cpu_sc->cpu_l1_cache_map);
+	}
+
+	cpu_sc->parse_success = true;
+out:
+	of_node_put(dn);
+}
+
+static inline void add_cpu_to_smallcore_masks(int cpu)
+{
+	struct small_core_sibling *this_small_core = &per_cpu(small_core, cpu);
+	int i, first_thread = cpu_first_thread_sibling(cpu);
+
+	if (!has_big_cores)
+		return;
+
+	if (unlikely(cpumask_empty(this_small_core->cpu_l1_cache_map)))
+		init_small_core_data(cpu, this_small_core);
+
+	cpumask_set_cpu(cpu, cpu_smallcore_mask(cpu));
+
+	for (i = first_thread; i < first_thread + threads_per_core; i++) {
+		if (unlikely(!this_small_core->parse_success)) {
+			/* Fallback to siblings of the big-core */
+			set_cpus_related(i, cpu, cpu_smallcore_mask);
+			continue;
+		}
+
+		if (cpumask_test_cpu(i, this_small_core->cpu_l1_cache_map))
+			set_cpus_related(i, cpu, cpu_smallcore_mask);
+	}
+}
+
 static void add_cpu_to_masks(int cpu)
 {
 	int first_thread = cpu_first_thread_sibling(cpu);
@@ -1006,11 +1121,11 @@ static void add_cpu_to_masks(int cpu)
 	 * add it to it's own thread sibling mask.
 	 */
 	cpumask_set_cpu(cpu, cpu_sibling_mask(cpu));
-
 	for (i = first_thread; i < first_thread + threads_per_core; i++)
 		if (cpu_online(i))
 			set_cpus_related(i, cpu, cpu_sibling_mask);
 
+	add_cpu_to_smallcore_masks(cpu);
 	/*
 	 * Copy the thread sibling mask into the cache sibling mask
 	 * and mark any CPUs that share an L2 with this CPU.
@@ -1040,6 +1155,7 @@ static void add_cpu_to_masks(int cpu)
 void start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
+	struct cpumask *(*sibling_mask)(int) = cpu_sibling_mask;
 
 	mmgrab(&init_mm);
 	current->active_mm = &init_mm;
@@ -1065,11 +1181,13 @@ void start_secondary(void *unused)
 	/* Update topology CPU masks */
 	add_cpu_to_masks(cpu);
 
+	if (has_big_cores)
+		sibling_mask = cpu_smallcore_mask;
 	/*
 	 * Check for any shared caches. Note that this must be done on a
 	 * per-core basis because one core in the pair might be disabled.
 	 */
-	if (!cpumask_equal(cpu_l2_cache_mask(cpu), cpu_sibling_mask(cpu)))
+	if (!cpumask_equal(cpu_l2_cache_mask(cpu), sibling_mask(cpu)))
 		shared_caches = true;
 
 	set_numa_node(numa_cpu_lookup_table[cpu]);
@@ -1136,6 +1254,13 @@ static const struct cpumask *shared_cache_mask(int cpu)
 	return cpu_l2_cache_mask(cpu);
 }
 
+#ifdef CONFIG_SCHED_SMT
+static const struct cpumask *smallcore_smt_mask(int cpu)
+{
+	return cpu_smallcore_mask(cpu);
+}
+#endif
+
 static struct sched_domain_topology_level power9_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
@@ -1158,6 +1283,13 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 	dump_numa_cpu_topology();
 
+#ifdef CONFIG_SCHED_SMT
+	if (has_big_cores) {
+		pr_info("Using small cores at SMT level\n");
+		power9_topology[0].mask = smallcore_smt_mask;
+		powerpc_topology[0].mask = smallcore_smt_mask;
+	}
+#endif
 	/*
 	 * If any CPU detects that it's sharing a cache with another CPU then
 	 * use the deeper topology that is aware of this sharing.
-- 
1.9.4
