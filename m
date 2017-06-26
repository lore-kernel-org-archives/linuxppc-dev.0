Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxBbB3KcHzDr2w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 00:41:58 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5QEdHXv125342
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 10:41:56 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bb2b2wtb4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 10:41:56 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 26 Jun 2017 10:41:54 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V7 1/2] powerpc/hotplug: Ensure enough nodes avail for
 operations
In-Reply-To: <92f2886f-e517-445e-3992-deddde9ac817@linux.vnet.ibm.com>
Date: Mon, 26 Jun 2017 09:41:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a16eb1c5-e2dd-6501-ca98-cd9925d5e86e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


powerpc/hotplug: On systems like PowerPC which allow 'hot-add' of CPU
or memory resources, it may occur that the new resources are to be
inserted into nodes that were not used for these resources at bootup.
In the kernel, any node that is used must be defined and initialized
at boot.  In order to meet both needs, this patch adds a new kernel
command line option (numnodes=<int>) for use by the PowerPC architecture-
specific code that defines the maximum number of nodes that the kernel
will ever need in its current hardware environment.  The boot code that
initializes nodes for PowerPC will read this value and use it to ensure
that all of the desired nodes are setup in the 'node_possible_map', and
elsewhere.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
---
 arch/powerpc/mm/numa.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index e6f742d..0746d93 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -60,10 +60,27 @@
 static int n_mem_addr_cells, n_mem_size_cells;
 static int form1_affinity;
 
+#define TOPOLOGY_DEF_NUM_NODES	0
 #define MAX_DISTANCE_REF_POINTS 4
 static int distance_ref_points_depth;
 static const __be32 *distance_ref_points;
 static int distance_lookup_table[MAX_NUMNODES][MAX_DISTANCE_REF_POINTS];
+static int topology_num_nodes = TOPOLOGY_DEF_NUM_NODES;
+
+/*
+ * Topology-related early parameters
+ */
+static int __init early_num_nodes(char *p)
+{
+	if (!p)
+		return 1;
+
+	topology_num_nodes = memparse(p, &p);
+	dbg("topology num nodes = 0x%d\n", topology_num_nodes);
+
+	return 0;
+}
+early_param("numnodes", early_num_nodes);
 
 /*
  * Allocate node_to_cpumask_map based on number of available nodes
@@ -892,6 +909,18 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
 }
 
+static void __init setup_min_nodes(void)
+{
+	int i, l = topology_num_nodes;
+
+	for (i = 0; i < l; i++) {
+		if (!node_possible(i)) {
+			setup_node_data(i, 0, 0);
+			node_set(i, node_possible_map);
+		}
+	}
+}
+
 void __init initmem_init(void)
 {
 	int nid, cpu;
@@ -911,6 +940,8 @@ void __init initmem_init(void)
 	 */
 	nodes_and(node_possible_map, node_possible_map, node_online_map);
 
+	setup_min_nodes();
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
