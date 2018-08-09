Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mH2T4WnYzDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 15:32:33 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w795TBli018928
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Aug 2018 01:32:31 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2krekd9td5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Aug 2018 01:32:31 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 8 Aug 2018 23:32:30 -0600
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
Subject: [PATCH v6 2/2] powerpc: Use cpu_smallcore_sibling_mask at SMT level
 on bigcores
Date: Thu,  9 Aug 2018 11:02:08 +0530
In-Reply-To: <1533792728-6304-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1533792728-6304-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1533792728-6304-3-git-send-email-ego@linux.vnet.ibm.com>
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
   SMT domain ceases to exist as each domain consists of just one
   group.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/smp.h |  6 ++++
 arch/powerpc/kernel/smp.c      | 62 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 29ffaab..30798c7 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -99,6 +99,7 @@ static inline void set_hard_smp_processor_id(int cpu, int phys)
 #endif
 
 DECLARE_PER_CPU(cpumask_var_t, cpu_sibling_map);
+DECLARE_PER_CPU(cpumask_var_t, cpu_smallcore_sibling_map);
 DECLARE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
 DECLARE_PER_CPU(cpumask_var_t, cpu_core_map);
 
@@ -107,6 +108,11 @@ static inline struct cpumask *cpu_sibling_mask(int cpu)
 	return per_cpu(cpu_sibling_map, cpu);
 }
 
+static inline struct cpumask *cpu_smallcore_sibling_mask(int cpu)
+{
+	return per_cpu(cpu_smallcore_sibling_map, cpu);
+}
+
 static inline struct cpumask *cpu_core_mask(int cpu)
 {
 	return per_cpu(cpu_core_map, cpu);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 4794d6b..a515780 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -76,10 +76,12 @@
 struct thread_info *secondary_ti;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
+DEFINE_PER_CPU(cpumask_var_t, cpu_smallcore_sibling_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_l2_cache_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_core_map);
 
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
+EXPORT_PER_CPU_SYMBOL(cpu_smallcore_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 
@@ -689,6 +691,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for_each_possible_cpu(cpu) {
 		zalloc_cpumask_var_node(&per_cpu(cpu_sibling_map, cpu),
 					GFP_KERNEL, cpu_to_node(cpu));
+		zalloc_cpumask_var_node(&per_cpu(cpu_smallcore_sibling_map,
+						 cpu),
+					GFP_KERNEL, cpu_to_node(cpu));
 		zalloc_cpumask_var_node(&per_cpu(cpu_l2_cache_map, cpu),
 					GFP_KERNEL, cpu_to_node(cpu));
 		zalloc_cpumask_var_node(&per_cpu(cpu_core_map, cpu),
@@ -707,6 +712,10 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
 	cpumask_set_cpu(boot_cpuid, cpu_l2_cache_mask(boot_cpuid));
 	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
+	if (has_big_cores) {
+		cpumask_set_cpu(boot_cpuid,
+				cpu_smallcore_sibling_mask(boot_cpuid));
+	}
 
 	if (smp_ops && smp_ops->probe)
 		smp_ops->probe();
@@ -991,6 +1000,10 @@ static void remove_cpu_from_masks(int cpu)
 		set_cpus_unrelated(cpu, i, cpu_core_mask);
 		set_cpus_unrelated(cpu, i, cpu_l2_cache_mask);
 		set_cpus_unrelated(cpu, i, cpu_sibling_mask);
+		if (has_big_cores) {
+			set_cpus_unrelated(cpu, i,
+					   cpu_smallcore_sibling_mask);
+		}
 	}
 }
 #endif
@@ -999,7 +1012,17 @@ static void add_cpu_to_masks(int cpu)
 {
 	int first_thread = cpu_first_thread_sibling(cpu);
 	int chipid = cpu_to_chip_id(cpu);
-	int i;
+
+	struct thread_groups tg;
+	int i, cpu_group_start = -1;
+
+	if (has_big_cores) {
+		struct device_node *dn = of_get_cpu_node(cpu, NULL);
+
+		parse_thread_groups(dn, &tg);
+		cpu_group_start = get_cpu_thread_group_start(cpu, &tg);
+		cpumask_set_cpu(cpu, cpu_smallcore_sibling_mask(cpu));
+	}
 
 	/*
 	 * This CPU will not be in the online mask yet so we need to manually
@@ -1007,9 +1030,21 @@ static void add_cpu_to_masks(int cpu)
 	 */
 	cpumask_set_cpu(cpu, cpu_sibling_mask(cpu));
 
-	for (i = first_thread; i < first_thread + threads_per_core; i++)
-		if (cpu_online(i))
-			set_cpus_related(i, cpu, cpu_sibling_mask);
+	for (i = first_thread; i < first_thread + threads_per_core; i++) {
+		int i_group_start;
+
+		if (!cpu_online(i))
+			continue;
+
+		set_cpus_related(i, cpu, cpu_sibling_mask);
+
+		if (!has_big_cores)
+			continue;
+
+		i_group_start = get_cpu_thread_group_start(i, &tg);
+		if (i_group_start == cpu_group_start)
+			set_cpus_related(i, cpu, cpu_smallcore_sibling_mask);
+	}
 
 	/*
 	 * Copy the thread sibling mask into the cache sibling mask
@@ -1040,6 +1075,7 @@ static void add_cpu_to_masks(int cpu)
 void start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
+	struct cpumask *(*sibling_mask)(int) = cpu_sibling_mask;
 
 	mmgrab(&init_mm);
 	current->active_mm = &init_mm;
@@ -1065,11 +1101,13 @@ void start_secondary(void *unused)
 	/* Update topology CPU masks */
 	add_cpu_to_masks(cpu);
 
+	if (has_big_cores)
+		sibling_mask = cpu_smallcore_sibling_mask;
 	/*
 	 * Check for any shared caches. Note that this must be done on a
 	 * per-core basis because one core in the pair might be disabled.
 	 */
-	if (!cpumask_equal(cpu_l2_cache_mask(cpu), cpu_sibling_mask(cpu)))
+	if (!cpumask_equal(cpu_l2_cache_mask(cpu), sibling_mask(cpu)))
 		shared_caches = true;
 
 	set_numa_node(numa_cpu_lookup_table[cpu]);
@@ -1136,6 +1174,13 @@ static const struct cpumask *shared_cache_mask(int cpu)
 	return cpu_l2_cache_mask(cpu);
 }
 
+#ifdef CONFIG_SCHED_SMT
+static const struct cpumask *smallcore_smt_mask(int cpu)
+{
+	return cpu_smallcore_sibling_mask(cpu);
+}
+#endif
+
 static struct sched_domain_topology_level power9_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
@@ -1158,6 +1203,13 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
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
