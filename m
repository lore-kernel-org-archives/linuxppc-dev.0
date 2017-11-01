Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRyD81swnzDr6C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 05:58:32 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA1Iutkd028799
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Nov 2017 14:58:29 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dyh3h1mmt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 14:58:28 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 1 Nov 2017 14:58:27 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, John Allen
 <jallen@linux.vnet.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH V6 2/2] pseries/initnodes: Ensure nodes initialized for hotplug
In-Reply-To: <b7c79722-f4fb-05f5-74b9-98030fa31f38@linux.vnet.ibm.com>
Date: Wed, 1 Nov 2017 13:58:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <129c79ac-3fc6-95c4-1eef-43f862c510c3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pseries/nodes: On pseries systems which allow 'hot-add' of CPU,
it may occur that the new resources are to be inserted into nodes
that were not used for memory resources at bootup.  Many different
configurations of PowerPC resources may need to be supported depending
upon the environment.  This patch fixes some problems encountered at
runtime with configurations that support memory-less nodes, or that
hot-add CPUs into nodes that are memoryless during system execution
after boot.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V6:
  -- Add some needed node initialization to runtime code that maps
     CPUs based on VPHN associativity
  -- Add error checks and alternate recovery for compile flag
     CONFIG_MEMORY_HOTPLUG
  -- Add alternate node selection recovery for !CONFIG_MEMORY_HOTPLUG
---
 arch/powerpc/mm/numa.c |   51 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 334a1ff..163f4cc 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -551,7 +551,7 @@ static int numa_setup_cpu(unsigned long lcpu)
 	nid = of_node_to_nid_single(cpu);
 
 out_present:
-	if (nid < 0 || !node_online(nid))
+	if (nid < 0 || !node_possible(nid))
 		nid = first_online_node;
 
 	map_cpu_to_node(lcpu, nid);
@@ -867,7 +867,7 @@ void __init dump_numa_cpu_topology(void)
 }
 
 /* Initialize NODE_DATA for a node on the local memory */
-static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
+static void setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 {
 	u64 spanned_pages = end_pfn - start_pfn;
 	const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);
@@ -913,10 +913,8 @@ static void __init find_possible_nodes(void)
 		min_common_depth);
 
 	for (i = 0; i < numnodes; i++) {
-		if (!node_possible(i)) {
-			setup_node_data(i, 0, 0);
+		if (!node_possible(i))
 			node_set(i, node_possible_map);
-		}
 	}
 
 out:
@@ -1312,6 +1310,42 @@ static long vphn_get_associativity(unsigned long cpu,
 	return rc;
 }
 
+static inline int find_cpu_nid(int cpu)
+{
+	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	int new_nid;
+
+	/* Use associativity from first thread for all siblings */
+	vphn_get_associativity(cpu, associativity);
+	new_nid = associativity_to_nid(associativity);
+	if (new_nid < 0 || !node_possible(new_nid))
+		new_nid = first_online_node;
+
+	if (NODE_DATA(new_nid) == NULL) {
+#ifdef CONFIG_MEMORY_HOTPLUG
+		/*
+		 * Need to ensure that NODE_DATA is initialized
+		 * for a node from available memory (see
+		 * memblock_alloc_try_nid).  If unable to init
+		 * the node, then default to nearest node that
+		 * has memory installed.
+		 */
+		if (try_online_node(new_nid))
+			new_nid = first_online_node;
+#else
+		/*
+		 * Default to using the nearest node that has
+		 * memory installed.  Otherwise, it would be 
+		 * necessary to patch the kernel MM code to deal
+		 * with more memoryless-node error conditions.
+		 */
+		new_nid = first_online_node;
+#endif
+	}
+
+	return new_nid;
+}
+
 /*
  * Update the CPU maps and sysfs entries for a single CPU when its NUMA
  * characteristics change. This function doesn't perform any locking and is
@@ -1379,7 +1413,6 @@ int numa_update_cpu_topology(bool cpus_locked)
 {
 	unsigned int cpu, sibling, changed = 0;
 	struct topology_update_data *updates, *ud;
-	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	cpumask_t updated_cpus;
 	struct device *dev;
 	int weight, new_nid, i = 0;
@@ -1417,11 +1450,7 @@ int numa_update_cpu_topology(bool cpus_locked)
 			continue;
 		}
 
-		/* Use associativity from first thread for all siblings */
-		vphn_get_associativity(cpu, associativity);
-		new_nid = associativity_to_nid(associativity);
-		if (new_nid < 0 || !node_online(new_nid))
-			new_nid = first_online_node;
+		new_nid = find_cpu_nid(cpu);
 
 		if (new_nid == numa_cpu_lookup_table[cpu]) {
 			cpumask_andnot(&cpu_associativity_changes_mask,
