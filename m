Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B77432C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 10:24:38 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 19 Feb 2014 16:24:36 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 4913F3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 16:24:34 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1JNO3EM10289530
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 00:24:04 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1JNMQiP032630
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 16:22:27 -0700
Date: Wed, 19 Feb 2014 15:22:21 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michal Hocko <mhocko@suse.cz>, Mel Gorman <mgorman@suse.de>,
 linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Ben Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3 v2] powerpc: enable CONFIG_HAVE_PERCPU_NUMA_NODE_ID
Message-ID: <20140219232221.GD413@linux.vnet.ibm.com>
References: <20140219231641.GA413@linux.vnet.ibm.com>
 <20140219231714.GB413@linux.vnet.ibm.com>
 <20140219231800.GC413@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140219231800.GC413@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Apologies, I sent a stale version of this patch a moment ago...]

In order to enable CONFIG_HAVE_MEMORYLESS_NODES, it is necessary to have
somewhere to store the cpu <-> local-memory-node mapping. We could
create another powerpc-specific lookup table, but the generic functions
in include/linux/topology.h (protected by HAVE_PERCPU_NUMA_NODE_ID) are
sufficient. This also allows us to remove the existing powerpc-specific
cpu <-> node lookup table.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Ben Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 957bf34..a84816c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -449,6 +449,10 @@ config NODES_SHIFT
 	default "4"
 	depends on NEED_MULTIPLE_NODES
 
+config USE_PERCPU_NUMA_NODE_ID
+	def_bool y
+	depends on NUMA
+
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 	depends on PPC64
diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 7b58917..c8fbd1c 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -29,7 +29,6 @@ extern struct pglist_data *node_data[];
  * Following are specific to this numa platform.
  */
 
-extern int numa_cpu_lookup_table[];
 extern cpumask_var_t node_to_cpumask_map[];
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern unsigned long max_pfn;
diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index d0b5fca..8bbe8cc 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -20,19 +20,6 @@ struct device_node;
 
 #include <asm/mmzone.h>
 
-static inline int cpu_to_node(int cpu)
-{
-	int nid;
-
-	nid = numa_cpu_lookup_table[cpu];
-
-	/*
-	 * During early boot, the numa-cpu lookup table might not have been
-	 * setup for all CPUs yet. In such cases, default to node 0.
-	 */
-	return (nid < 0) ? 0 : nid;
-}
-
 #define parent_node(node)	(node)
 
 #define cpumask_of_node(node) ((node) == -1 ?				\
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ac2621a..f45e68d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -739,6 +739,9 @@ void start_secondary(void *unused)
 	}
 	traverse_core_siblings(cpu, true);
 
+	set_cpu_numa_node(cpu, cpu_to_node(cpu));
+	set_cpu_numa_mem(cpu, local_memory_node(cpu_to_node(cpu)));
+
 	smp_wmb();
 	notify_cpu_starting(cpu);
 	set_cpu_online(cpu, true);
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 30a42e2..57e2809 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -46,11 +46,9 @@ static char *cmdline __initdata;
 static int numa_debug;
 #define dbg(args...) if (numa_debug) { printk(KERN_INFO args); }
 
-int numa_cpu_lookup_table[NR_CPUS];
 cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
 struct pglist_data *node_data[MAX_NUMNODES];
 
-EXPORT_SYMBOL(numa_cpu_lookup_table);
 EXPORT_SYMBOL(node_to_cpumask_map);
 EXPORT_SYMBOL(node_data);
 
@@ -154,22 +152,25 @@ static void __init get_node_active_region(unsigned long pfn,
 	}
 }
 
-static void reset_numa_cpu_lookup_table(void)
+static void reset_numa_cpu_node(void)
 {
 	unsigned int cpu;
 
-	for_each_possible_cpu(cpu)
-		numa_cpu_lookup_table[cpu] = -1;
+	for_each_possible_cpu(cpu) {
+		set_cpu_numa_node(cpu, -1);
+		set_cpu_numa_mem(cpu, -1);
+	}
 }
 
-static void update_numa_cpu_lookup_table(unsigned int cpu, int node)
+static void update_numa_cpu_node(unsigned int cpu, int node)
 {
-	numa_cpu_lookup_table[cpu] = node;
+	set_cpu_numa_node(cpu, node);
+	set_cpu_numa_mem(cpu, local_memory_node(node));
 }
 
 static void map_cpu_to_node(int cpu, int node)
 {
-	update_numa_cpu_lookup_table(cpu, node);
+	update_numa_cpu_node(cpu, node);
 
 	dbg("adding cpu %d to node %d\n", cpu, node);
 
@@ -180,7 +181,7 @@ static void map_cpu_to_node(int cpu, int node)
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PPC_SPLPAR)
 static void unmap_cpu_from_node(unsigned long cpu)
 {
-	int node = numa_cpu_lookup_table[cpu];
+	int node = cpu_to_node(cpu);
 
 	dbg("removing cpu %lu from node %d\n", cpu, node);
 
@@ -545,7 +546,7 @@ static int numa_setup_cpu(unsigned long lcpu)
 	 * directly instead of querying the firmware, since it represents
 	 * the most recent mapping notified to us by the platform (eg: VPHN).
 	 */
-	if ((nid = numa_cpu_lookup_table[lcpu]) >= 0) {
+	if ((nid = cpu_to_node(lcpu)) >= 0) {
 		map_cpu_to_node(lcpu, nid);
 		return nid;
 	}
@@ -1119,7 +1120,7 @@ void __init do_init_bootmem(void)
 	 */
 	setup_node_to_cpumask_map();
 
-	reset_numa_cpu_lookup_table();
+	reset_numa_cpu_node();
 	register_cpu_notifier(&ppc64_numa_nb);
 	cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
 			  (void *)(unsigned long)boot_cpuid);
@@ -1518,7 +1519,7 @@ static int update_lookup_table(void *data)
 		base = cpu_first_thread_sibling(update->cpu);
 
 		for (j = 0; j < threads_per_core; j++) {
-			update_numa_cpu_lookup_table(base + j, nid);
+			update_numa_cpu_node(base + j, nid);
 		}
 	}
 
@@ -1571,7 +1572,7 @@ int arch_update_cpu_topology(void)
 		if (new_nid < 0 || !node_online(new_nid))
 			new_nid = first_online_node;
 
-		if (new_nid == numa_cpu_lookup_table[cpu]) {
+		if (new_nid == cpu_to_node(cpu)) {
 			cpumask_andnot(&cpu_associativity_changes_mask,
 					&cpu_associativity_changes_mask,
 					cpu_sibling_mask(cpu));
@@ -1583,7 +1584,7 @@ int arch_update_cpu_topology(void)
 			ud = &updates[i++];
 			ud->cpu = sibling;
 			ud->new_nid = new_nid;
-			ud->old_nid = numa_cpu_lookup_table[sibling];
+			ud->old_nid = cpu_to_node(sibling);
 			cpumask_set_cpu(sibling, &updated_cpus);
 			if (i < weight)
 				ud->next = &updates[i];
