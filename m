Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yNJhf5hmLzDr28
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 07:37:06 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9QKb3Nm030956
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 16:37:05 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dujhrcecw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 16:37:04 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 26 Oct 2017 16:36:53 -0400
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/2] pseries/initnodes: Ensure nodes initialized for hotplug
In-Reply-To: <237b5727-7329-5608-5fa1-0cd465415db2@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 15:36:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <51cdbb88-4ead-7bf7-6e18-297d9b7e1e75@linux.vnet.ibm.com>
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
hot-add resources during system execution after boot.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V5:
  -- Reorganize code used to associatively map CPUs to nodes and
     ensure initialization of nodes at runtime.
---
 arch/powerpc/mm/numa.c |   45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 18fc40d..4d615a4 100644
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
@@ -1310,6 +1310,40 @@ static long vphn_get_associativity(unsigned long cpu,
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
+	/*
+	 * Need to ensure that NODE_DATA is allocated/initialized for
+	 * a node from available memory (see memblock_alloc_try_nid).
+	 * Code executed after boot (like local_memory_node) may not
+	 * know enough to recover fully for memoryless nodes. 
+	 */
+	if (NODE_DATA(new_nid) == NULL) {
+		setup_node_data(new_nid, 0, 0);
+		try_online_node(new_nid);
+
+		/*
+		 * Node structures successfully initialized, but
+		 * we still need the memoryliess node to be offline.
+		 */
+		node_set_offline(new_nid);
+	}
+
+	if (NODE_DATA(new_nid)->node_spanned_pages == 0)
+		return first_online_node;
+
+	return new_nid;
+}
+
 /*
  * Update the CPU maps and sysfs entries for a single CPU when its NUMA
  * characteristics change. This function doesn't perform any locking and is
@@ -1377,7 +1411,6 @@ int numa_update_cpu_topology(bool cpus_locked)
 {
 	unsigned int cpu, sibling, changed = 0;
 	struct topology_update_data *updates, *ud;
-	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	cpumask_t updated_cpus;
 	struct device *dev;
 	int weight, new_nid, i = 0;
@@ -1415,11 +1448,7 @@ int numa_update_cpu_topology(bool cpus_locked)
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
