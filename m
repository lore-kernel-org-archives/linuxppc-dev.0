Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6C3C1A02CD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 04:28:27 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Sun, 27 Sep 2015 14:28:24 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1DF26C90045
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 14:19:25 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8RISLxQ40763572
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 18:28:21 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8RISKVR012901
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 14:28:21 -0400
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>
Cc: <anton@samba.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <cl@linux.com>,
 <nacc@linux.vnet.ibm.com>, <gkurz@linux.vnet.ibm.com>,
 <grant.likely@linaro.org>, <nikunj@linux.vnet.ibm.com>,
 <raghavendra.kt@linux.vnet.ibm.com>, <khandual@linux.vnet.ibm.com>,
 Raghavendra K T <raghavendra.kt@linux.inet.ibm.com>
Subject: [PATCH RFC 1/5] powerpc:numa Add numa_cpu_lookup function to update
 lookup table
Date: Sun, 27 Sep 2015 23:59:09 +0530
Message-Id: <1443378553-2146-2-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
In-Reply-To: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We access numa_cpu_lookup_table array directly in all the places
to read/update numa cpu lookup information. Instead use a helper
function to update.

This is helpful in changing the way numa<-->cpu mapping in single
place when needed.

This is a cosmetic change, no change in functionality.

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.inet.ibm.com>
---
 arch/powerpc/include/asm/mmzone.h |  2 +-
 arch/powerpc/kernel/smp.c         | 10 +++++-----
 arch/powerpc/mm/numa.c            | 28 +++++++++++++++++-----------
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 7b58917..c24a5f4 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -29,7 +29,7 @@ extern struct pglist_data *node_data[];
  * Following are specific to this numa platform.
  */
 
-extern int numa_cpu_lookup_table[];
+extern int numa_cpu_lookup(int cpu);
 extern cpumask_var_t node_to_cpumask_map[];
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern unsigned long max_pfn;
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ec9ec20..56fbe9e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -381,9 +381,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		 * numa_node_id() works after this.
 		 */
 		if (cpu_present(cpu)) {
-			set_cpu_numa_node(cpu, numa_cpu_lookup_table[cpu]);
+			set_cpu_numa_node(cpu, numa_cpu_lookup(cpu));
 			set_cpu_numa_mem(cpu,
-				local_memory_node(numa_cpu_lookup_table[cpu]));
+				local_memory_node(numa_cpu_lookup(cpu)));
 		}
 	}
 
@@ -400,7 +400,7 @@ void smp_prepare_boot_cpu(void)
 #ifdef CONFIG_PPC64
 	paca[boot_cpuid].__current = current;
 #endif
-	set_numa_node(numa_cpu_lookup_table[boot_cpuid]);
+	set_numa_node(numa_cpu_lookup(boot_cpuid));
 	current_set[boot_cpuid] = task_thread_info(current);
 }
 
@@ -718,8 +718,8 @@ void start_secondary(void *unused)
 	}
 	traverse_core_siblings(cpu, true);
 
-	set_numa_node(numa_cpu_lookup_table[cpu]);
-	set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]));
+	set_numa_node(numa_cpu_lookup(cpu));
+	set_numa_mem(local_memory_node(numa_cpu_lookup(cpu)));
 
 	smp_wmb();
 	notify_cpu_starting(cpu);
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 8b9502a..d5e6eee 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -52,7 +52,6 @@ int numa_cpu_lookup_table[NR_CPUS];
 cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
 struct pglist_data *node_data[MAX_NUMNODES];
 
-EXPORT_SYMBOL(numa_cpu_lookup_table);
 EXPORT_SYMBOL(node_to_cpumask_map);
 EXPORT_SYMBOL(node_data);
 
@@ -134,19 +133,25 @@ static int __init fake_numa_create_new_node(unsigned long end_pfn,
 	return 0;
 }
 
-static void reset_numa_cpu_lookup_table(void)
+int numa_cpu_lookup(int cpu)
 {
-	unsigned int cpu;
-
-	for_each_possible_cpu(cpu)
-		numa_cpu_lookup_table[cpu] = -1;
+	return numa_cpu_lookup_table[cpu];
 }
+EXPORT_SYMBOL(numa_cpu_lookup);
 
-static void update_numa_cpu_lookup_table(unsigned int cpu, int node)
+static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node)
 {
 	numa_cpu_lookup_table[cpu] = node;
 }
 
+static void reset_numa_cpu_lookup_table(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu)
+		update_numa_cpu_lookup_table(cpu, -1);
+}
+
 static void map_cpu_to_node(int cpu, int node)
 {
 	update_numa_cpu_lookup_table(cpu, node);
@@ -160,7 +165,7 @@ static void map_cpu_to_node(int cpu, int node)
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PPC_SPLPAR)
 static void unmap_cpu_from_node(unsigned long cpu)
 {
-	int node = numa_cpu_lookup_table[cpu];
+	int node = numa_cpu_lookup(cpu);
 
 	dbg("removing cpu %lu from node %d\n", cpu, node);
 
@@ -536,7 +541,8 @@ static int numa_setup_cpu(unsigned long lcpu)
 	 * directly instead of querying the firmware, since it represents
 	 * the most recent mapping notified to us by the platform (eg: VPHN).
 	 */
-	if ((nid = numa_cpu_lookup_table[lcpu]) >= 0) {
+	nid = numa_cpu_lookup(lcpu);
+	if (nid >= 0) {
 		map_cpu_to_node(lcpu, nid);
 		return nid;
 	}
@@ -1413,7 +1419,7 @@ int arch_update_cpu_topology(void)
 		if (new_nid < 0 || !node_online(new_nid))
 			new_nid = first_online_node;
 
-		if (new_nid == numa_cpu_lookup_table[cpu]) {
+		if (new_nid == numa_cpu_lookup(cpu)) {
 			cpumask_andnot(&cpu_associativity_changes_mask,
 					&cpu_associativity_changes_mask,
 					cpu_sibling_mask(cpu));
@@ -1425,7 +1431,7 @@ int arch_update_cpu_topology(void)
 			ud = &updates[i++];
 			ud->cpu = sibling;
 			ud->new_nid = new_nid;
-			ud->old_nid = numa_cpu_lookup_table[sibling];
+			ud->old_nid = numa_cpu_lookup(sibling);
 			cpumask_set_cpu(sibling, &updated_cpus);
 			if (i < weight)
 				ud->next = &updates[i];
-- 
1.7.11.7
