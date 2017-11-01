Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRyD32Nd4zDr6C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 05:58:26 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA1IusUr014528
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Nov 2017 14:58:24 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dyh36sq77-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 14:58:24 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 1 Nov 2017 14:58:23 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, John Allen
 <jallen@linux.vnet.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH V6 1/2] pseries/nodes: Ensure enough nodes avail for operations
In-Reply-To: <b7c79722-f4fb-05f5-74b9-98030fa31f38@linux.vnet.ibm.com>
Date: Wed, 1 Nov 2017 13:58:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <e0519480-4229-fe7a-d036-22ddfe2ec9f0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pseries/nodes: On pseries systems which allow 'hot-add' of CPU or
memory resources, it may occur that the new resources are to be
inserted into nodes that were not used for these resources at bootup.
In the kernel, any node that is used must be defined and initialized.
This patch ensures that sufficient nodes are defined to support
configuration requirements after boot, as well as at boot.

This patch extracts the value of the lowest domain level (number
of allocable resources) from the device tree property
"ibm,max-associativity-domains" to use as the maximum number of nodes
to setup as possibly available in the system.  This new setting will
override the instruction,

    nodes_and(node_possible_map, node_possible_map, node_online_map);

presently seen in the function arch/powerpc/mm/numa.c:initmem_init().

If the property is not present at boot, no operation will be performed
to define or enable additional nodes.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V6:
  -- Remove some node initialization/allocation from boot setup
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
 
