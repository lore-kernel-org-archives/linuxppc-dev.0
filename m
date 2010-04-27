Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013432.657193481@samba.org>
Date: Tue, 27 Apr 2010 11:32:43 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 12/15] powerpc: cpumask: Convert NUMA code to new cpumask API
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

Convert NUMA code to new cpumask API. We shift the node to cpumask
setup code until after we complete bootmem allocation so we can
dynamically allocate the cpumasks.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/include/asm/mmzone.h
===================================================================
--- linux-cpumask.orig/arch/powerpc/include/asm/mmzone.h	2010-04-12 09:17:47.847946437 +1000
+++ linux-cpumask/arch/powerpc/include/asm/mmzone.h	2010-04-22 13:03:26.335446079 +1000
@@ -30,7 +30,7 @@ extern struct pglist_data *node_data[];
  */
 
 extern int numa_cpu_lookup_table[];
-extern cpumask_t numa_cpumask_lookup_table[];
+extern cpumask_var_t node_to_cpumask_map[];
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern unsigned long max_pfn;
 #endif
Index: linux-cpumask/arch/powerpc/mm/numa.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/mm/numa.c	2010-04-12 09:17:47.817946138 +1000
+++ linux-cpumask/arch/powerpc/mm/numa.c	2010-04-22 13:03:26.335446079 +1000
@@ -33,16 +33,41 @@ static int numa_debug;
 #define dbg(args...) if (numa_debug) { printk(KERN_INFO args); }
 
 int numa_cpu_lookup_table[NR_CPUS];
-cpumask_t numa_cpumask_lookup_table[MAX_NUMNODES];
+cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
 struct pglist_data *node_data[MAX_NUMNODES];
 
 EXPORT_SYMBOL(numa_cpu_lookup_table);
-EXPORT_SYMBOL(numa_cpumask_lookup_table);
+EXPORT_SYMBOL(node_to_cpumask_map);
 EXPORT_SYMBOL(node_data);
 
 static int min_common_depth;
 static int n_mem_addr_cells, n_mem_size_cells;
 
+/*
+ * Allocate node_to_cpumask_map based on number of available nodes
+ * Requires node_possible_map to be valid.
+ *
+ * Note: node_to_cpumask() is not valid until after this is done.
+ */
+static void __init setup_node_to_cpumask_map(void)
+{
+	unsigned int node, num = 0;
+
+	/* setup nr_node_ids if not done yet */
+	if (nr_node_ids == MAX_NUMNODES) {
+		for_each_node_mask(node, node_possible_map)
+			num = node;
+		nr_node_ids = num + 1;
+	}
+
+	/* allocate the map */
+	for (node = 0; node < nr_node_ids; node++)
+		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
+
+	/* cpumask_of_node() will now work */
+	dbg("Node to cpumask map for %d nodes\n", nr_node_ids);
+}
+
 static int __cpuinit fake_numa_create_new_node(unsigned long end_pfn,
 						unsigned int *nid)
 {
@@ -138,8 +163,8 @@ static void __cpuinit map_cpu_to_node(in
 
 	dbg("adding cpu %d to node %d\n", cpu, node);
 
-	if (!(cpu_isset(cpu, numa_cpumask_lookup_table[node])))
-		cpu_set(cpu, numa_cpumask_lookup_table[node]);
+	if (!(cpumask_test_cpu(cpu, node_to_cpumask_map[node])))
+		cpumask_set_cpu(cpu, node_to_cpumask_map[node]);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -149,8 +174,8 @@ static void unmap_cpu_from_node(unsigned
 
 	dbg("removing cpu %lu from node %d\n", cpu, node);
 
-	if (cpu_isset(cpu, numa_cpumask_lookup_table[node])) {
-		cpu_clear(cpu, numa_cpumask_lookup_table[node]);
+	if (cpumask_test_cpu(cpu, node_to_cpumask_map[node])) {
+		cpumask_set_cpu(cpu, node_to_cpumask_map[node]);
 	} else {
 		printk(KERN_ERR "WARNING: cpu %lu not found in node %d\n",
 		       cpu, node);
@@ -737,8 +762,9 @@ void __init dump_numa_cpu_topology(void)
 		 * If we used a CPU iterator here we would miss printing
 		 * the holes in the cpumap.
 		 */
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-			if (cpu_isset(cpu, numa_cpumask_lookup_table[node])) {
+		for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+			if (cpumask_test_cpu(cpu,
+					node_to_cpumask_map[node])) {
 				if (count == 0)
 					printk(" %u", cpu);
 				++count;
@@ -750,7 +776,7 @@ void __init dump_numa_cpu_topology(void)
 		}
 
 		if (count > 1)
-			printk("-%u", NR_CPUS - 1);
+			printk("-%u", nr_cpu_ids - 1);
 		printk("\n");
 	}
 }
@@ -926,10 +952,6 @@ void __init do_init_bootmem(void)
 	else
 		dump_numa_memory_topology();
 
-	register_cpu_notifier(&ppc64_numa_nb);
-	cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
-			  (void *)(unsigned long)boot_cpuid);
-
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 		void *bootmem_vaddr;
@@ -983,6 +1005,16 @@ void __init do_init_bootmem(void)
 	}
 
 	init_bootmem_done = 1;
+
+	/*
+	 * Now bootmem is initialised we can create the node to cpumask
+	 * lookup tables and setup the cpu callback to populate them.
+	 */
+	setup_node_to_cpumask_map();
+
+	register_cpu_notifier(&ppc64_numa_nb);
+	cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
+			  (void *)(unsigned long)boot_cpuid);
 }
 
 void __init paging_init(void)
Index: linux-cpumask/arch/powerpc/include/asm/topology.h
===================================================================
--- linux-cpumask.orig/arch/powerpc/include/asm/topology.h	2010-04-22 13:03:22.535446350 +1000
+++ linux-cpumask/arch/powerpc/include/asm/topology.h	2010-04-22 13:03:26.345446035 +1000
@@ -19,7 +19,7 @@ static inline int cpu_to_node(int cpu)
 
 #define cpumask_of_node(node) ((node) == -1 ?				\
 			       cpu_all_mask :				\
-			       &numa_cpumask_lookup_table[node])
+			       node_to_cpumask_map[node])
 
 int of_node_to_nid(struct device_node *device);
 
