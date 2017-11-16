Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd7Vk53wGzDr25
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 04:27:58 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAGHQZV5047180
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:27:56 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e9de95sbj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:27:55 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 16 Nov 2017 10:27:55 -0700
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <c88f7263-4f99-c13d-c4d2-9fa8f3d59b8f@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: RESEND [PATCH V7 2/3] poserpc/initnodes: Ensure nodes initialized for
 hotplug
Date: Thu, 16 Nov 2017 11:27:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <4ae139ec-87a1-ad1d-0b1e-eef1a0e2e365@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc systems which allow 'hot-add' of CPU, it may occur that
the new resources are to be inserted into nodes that were not used
for memory resources at bootup.  Many different configurations of
PowerPC resources may need to be supported depending upon the
environment.  Important characteristics of the nodes and operating
environment include:

* Dedicated vs. shared resources.  Shared resources require
  information such as the VPHN hcall for CPU assignment to nodes.
  Associativity decisions made based on dedicated resource rules,
  such as associativity properties in the device tree, may vary
  from decisions made using the values returned by the VPHN hcall.
* memoryless nodes at boot.  Nodes need to be defined as 'possible'
  at boot for operation with other code modules.  Previously, the
  powerpc code would limit the set of possible nodes to those which
  have memory assigned at boot, and were thus online.  Subsequent
  add/remove of CPUs or memory would only work with this subset of
  possible nodes.
* memoryless nodes with CPUs at boot.  Due to the previous restriction
  on nodes, nodes that had CPUs but no memory were being collapsed
  into other nodes that did have memory at boot.  In practice this
  meant that the node assignment presented by the runtime kernel
  differed from the affinity and associativity attributes presented
  by the device tree or VPHN hcalls.  Nodes that might be known to
  the pHyp were not 'possible' in the runtime kernel because they did
  not have memory at boot.

This patch fixes some problems encountered at runtime with
configurations that support memory-less nodes, or that hot-add CPUs
into nodes that are memoryless during system execution after boot.
The problems of interest include,

* Nodes known to powerpc to be memoryless at boot, but to have
  CPUs in them are allowed to be 'possible' and 'online'.  Memory
  allocations for those nodes are taken from another node that does
  have memory until and if memory is hot-added to the node.
* Nodes which have no resources assigned at boot, but which may still
  be referenced subsequently by affinity or associativity attributes,
  are kept in the list of 'possible' nodes for powerpc.  Hot-add of
  memory or CPUs to the system can reference these nodes and bring
  them online instead of redirecting the references to one of the set
  of nodes known to have memory at boot.

Note that this software operates under the context of CPU hotplug.
We are not doing memory hotplug in this code, but rather updating
the kernel's CPU topology (i.e. arch_update_cpu_topology /
numa_update_cpu_topology).  We are initializing a node that may be
used by CPUs or memory before it can be referenced as invalid by a
CPU hotplug operation.  CPU hotplug operations are protected by a
range of APIs including cpu_maps_update_begin/cpu_maps_update_done,
cpus_read/write_lock / cpus_read/write_unlock, device locks, and more.
Memory hotplug operations, including try_online_node, are protected
by mem_hotplug_begin/mem_hotplug_done, device locks, and more.  In
the case of CPUs being hot-added to a previously memoryless node, the
try_online_node operation occurs wholly within the CPU locks with no
overlap.  Using HMC hot-add/hot-remove operations, we have been able
to add and remove CPUs to any possible node without failures.  HMC
operations involve a degree self-serialization, though.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V6:
  -- Add some needed node initialization to runtime code that maps
     CPUs based on VPHN associativity
  -- Add error checks and alternate recovery for compile flag
     CONFIG_MEMORY_HOTPLUG
  -- Add alternate node selection recovery for !CONFIG_MEMORY_HOTPLUG
  -- Add more information to the patch introductory text
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
