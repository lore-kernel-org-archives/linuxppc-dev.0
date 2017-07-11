Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6TlT1ycRzDqgQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 03:36:21 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6BHY1Qt052117
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 13:36:19 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bn0mx7q6n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 13:36:19 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 11 Jul 2017 13:36:17 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, John Allen
 <jallen@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Rashmica Gupta <rashmicy@gmail.com>, Ingo Molnar <mingo@kernel.org>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V8 1/2] powerpc/hotplug: Ensure enough nodes avail for
 operations
In-Reply-To: <e9fc1b4b-7876-48ec-a004-b3a6f376ed0e@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 12:36:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <afcbcb50-e140-f153-f29b-d0415db12fb7@linux.vnet.ibm.com>
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
 
