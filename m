Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd7Sl48pDzDr4J
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 04:26:15 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAGHPMn8031672
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:25:48 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e9bvqbr7v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:25:45 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 16 Nov 2017 10:24:50 -0700
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V7 1/3] powerpc/nodes: Ensure enough nodes avail for operations
In-Reply-To: <c88f7263-4f99-c13d-c4d2-9fa8f3d59b8f@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 11:24:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <8dc75276-0f5e-4c44-05eb-a194c3303c66@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc systems which allow 'hot-add' of CPU or memory resources,
it may occur that the new resources are to be inserted into nodes
that were not used for these resources at bootup.  In the kernel,
any node that is used must be defined and initialized.  These empty
nodes may occur when,

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

This patch ensures that sufficient nodes are defined to support
configuration requirements after boot, as well as at boot.  This
patch set fixes a couple of problems.

* Nodes known to powerpc to be memoryless at boot, but to have
  CPUs in them are allowed to be 'possible' and 'online'.  Memory
  allocations for those nodes are taken from another node that does
  have memory until and if memory is hot-added to the node.
* Nodes which have no resources assigned at boot, but which may still
  be referenced subsequently by affinity or associativity attributes,
  are kept in the list of 'possible' nodes for powerpc.  Hot-add of
  memory or CPUs to the system can reference these nodes and bring
  them online instead of redirecting to one of the set of nodes that
  were known to have memory at boot.

This patch extracts the value of the lowest domain level (number of
allocable resources) from the device tree property
"ibm,max-associativity-domains" to use as the maximum number of nodes
to setup as possibly available in the system.  This new setting will
override the instruction,

    nodes_and(node_possible_map, node_possible_map, node_online_map);

presently seen in the function arch/powerpc/mm/numa.c:initmem_init().

If the "ibm,max-associativity-domains" property is not present at boot,
no operation will be performed to define or enable additional nodes, or
enable the above 'nodes_and()'.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V6:
  -- Remove some node initialization/allocation from boot setup
     to later in runtime to try to limit memory needs early on
  -- Augment descriptive documentation for patch
---
 arch/powerpc/mm/numa.c |   40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index eb604b3..334a1ff 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -892,6 +892,37 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
 }
 
+static void __init find_possible_nodes(void)
+{
+	struct device_node *rtas;
+	u32 numnodes, i;
+
+	if (min_common_depth <= 0)
+		return;
+
+	rtas = of_find_node_by_path("/rtas");
+	if (!rtas)
+		return;
+
+	if (of_property_read_u32_index(rtas,
+				"ibm,max-associativity-domains",
+				min_common_depth, &numnodes))
+		goto out;
+
+	pr_info("numa: Nodes = %d (mcd = %d)\n", numnodes,
+		min_common_depth);
+
+	for (i = 0; i < numnodes; i++) {
+		if (!node_possible(i)) {
+			setup_node_data(i, 0, 0);
+			node_set(i, node_possible_map);
+		}
+	}
+
+out:
+	of_node_put(rtas);
+}
+
 void __init initmem_init(void)
 {
 	int nid, cpu;
@@ -905,12 +936,15 @@ void __init initmem_init(void)
 	memblock_dump_all();
 
 	/*
-	 * Reduce the possible NUMA nodes to the online NUMA nodes,
-	 * since we do not support node hotplug. This ensures that  we
-	 * lower the maximum NUMA node ID to what is actually present.
+	 * Modify the set of possible NUMA nodes to reflect information
+	 * available about the set of online nodes, and the set of nodes
+	 * that we expect to make use of for this platform's affinity
+	 * calculations.
 	 */
 	nodes_and(node_possible_map, node_possible_map, node_online_map);
 
+	find_possible_nodes();
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
