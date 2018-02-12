Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgBw35jcMzF0nk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 04:08:51 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id o11so1658848pls.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 09:08:51 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 06/12] powerpc/mm/numa: move numa topology discovery
 earlier
Date: Tue, 13 Feb 2018 03:08:16 +1000
Message-Id: <20180212170822.14612-7-npiggin@gmail.com>
In-Reply-To: <20180212170822.14612-1-npiggin@gmail.com>
References: <20180212170822.14612-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Split sparsemem initialisation from basic numa topology discovery.

XXX: untested with lpars
---
 arch/powerpc/include/asm/setup.h   |  1 +
 arch/powerpc/kernel/setup-common.c |  3 +++
 arch/powerpc/mm/mem.c              |  5 ++++-
 arch/powerpc/mm/numa.c             | 32 +++++++++++++++++++-------------
 4 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 469b7fdc9be4..d2bf233aebd5 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -23,6 +23,7 @@ extern void reloc_got2(unsigned long);
 #define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
 
 void check_for_initrd(void);
+void mem_topology_setup(void);
 void initmem_init(void);
 void setup_panic(void);
 #define ARCH_PANIC_TIMEOUT 180
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index af128ee67248..f8a6b8ad13b4 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -888,6 +888,9 @@ void __init setup_arch(char **cmdline_p)
 	/* Check the SMT related command line arguments (ppc64). */
 	check_smt_enabled();
 
+	/* Parse memory topology */
+	mem_topology_setup();
+
 	/* On BookE, setup per-core TLB data structures. */
 	setup_tlb_core_data();
 
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 1281c6eb3a85..70f7b6426a15 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -213,7 +213,7 @@ walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
 EXPORT_SYMBOL_GPL(walk_system_ram_range);
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-void __init initmem_init(void)
+void __init mem_topology_setup(void)
 {
 	max_low_pfn = max_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
 	min_low_pfn = MEMORY_START >> PAGE_SHIFT;
@@ -225,7 +225,10 @@ void __init initmem_init(void)
 	 * memblock_regions
 	 */
 	memblock_set_node(0, (phys_addr_t)ULLONG_MAX, &memblock.memory, 0);
+}
 
+void __init initmem_init(void)
+{
 	/* XXX need to clip this if using highmem? */
 	sparse_memory_present_with_active_regions(0);
 	sparse_init();
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index e9ec465068f1..1eec1bcc03a6 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -836,18 +836,13 @@ static void __init find_possible_nodes(void)
 	of_node_put(rtas);
 }
 
-void __init initmem_init(void)
+void __init mem_topology_setup(void)
 {
-	int nid, cpu;
-
-	max_low_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
-	max_pfn = max_low_pfn;
+	int cpu;
 
 	if (parse_numa_properties())
 		setup_nonnuma();
 
-	memblock_dump_all();
-
 	/*
 	 * Modify the set of possible NUMA nodes to reflect information
 	 * available about the set of online nodes, and the set of nodes
@@ -858,6 +853,23 @@ void __init initmem_init(void)
 
 	find_possible_nodes();
 
+	setup_node_to_cpumask_map();
+
+	reset_numa_cpu_lookup_table();
+
+	for_each_present_cpu(cpu)
+		numa_setup_cpu(cpu);
+}
+
+void __init initmem_init(void)
+{
+	int nid;
+
+	max_low_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
+	max_pfn = max_low_pfn;
+
+	memblock_dump_all();
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
@@ -868,10 +880,6 @@ void __init initmem_init(void)
 
 	sparse_init();
 
-	setup_node_to_cpumask_map();
-
-	reset_numa_cpu_lookup_table();
-
 	/*
 	 * We need the numa_cpu_lookup_table to be accurate for all CPUs,
 	 * even before we online them, so that we can use cpu_to_{node,mem}
@@ -881,8 +889,6 @@ void __init initmem_init(void)
 	 */
 	cpuhp_setup_state_nocalls(CPUHP_POWER_NUMA_PREPARE, "powerpc/numa:prepare",
 				  ppc_numa_cpu_prepare, ppc_numa_cpu_dead);
-	for_each_present_cpu(cpu)
-		numa_setup_cpu(cpu);
 }
 
 static int __init early_numa(char *p)
-- 
2.16.1
