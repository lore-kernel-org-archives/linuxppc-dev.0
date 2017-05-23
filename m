Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXJy639JTzDqdq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 01:15:58 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4NFDIK6051015
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 11:15:51 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2am3rxj2xg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 11:15:51 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 23 May 2017 09:15:49 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bharata B Rao <bharata@linux.vnet.ib>,
 Balbir Singh <bsingharora@gmail.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
Date: Tue, 23 May 2017 10:15:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Removing or adding memory via the PowerPC hotplug interface shows
anomalies in the association between memory and nodes.  The code
was updated to initialize more possible nodes to make them available
to subsequent DLPAR hotplug-memory operations, even if they are not
needed at boot time.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 15c2dd5..3d58c1f 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -870,7 +870,7 @@ void __init dump_numa_cpu_topology(void)
 }
 
 /* Initialize NODE_DATA for a node on the local memory */
-static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
+static void setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 {
 	u64 spanned_pages = end_pfn - start_pfn;
 	const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);
@@ -878,23 +878,41 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	void *nd;
 	int tnid;
 
-	nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
-	nd = __va(nd_pa);
+	if (!node_data[nid]) {
+		nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
+		nd = __va(nd_pa);
 
-	/* report and initialize */
-	pr_info("  NODE_DATA [mem %#010Lx-%#010Lx]\n",
-		nd_pa, nd_pa + nd_size - 1);
-	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
-	if (tnid != nid)
-		pr_info("    NODE_DATA(%d) on node %d\n", nid, tnid);
+		node_data[nid] = nd;
+		memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
+		NODE_DATA(nid)->node_id = nid;
+
+		/* report and initialize */
+		pr_info("  NODE_DATA [mem %#010Lx-%#010Lx]\n",
+			nd_pa, nd_pa + nd_size - 1);
+		tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
+		if (tnid != nid)
+			pr_info("    NODE_DATA(%d) on node %d\n", nid, tnid);
+	} else {
+		nd_pa = (u64) node_data[nid];
+		nd = __va(nd_pa);
+	}
 
-	node_data[nid] = nd;
-	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
-	NODE_DATA(nid)->node_id = nid;
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
 	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
 }
 
+static void setup_nodes(void)
+{
+	int i, l = 32 /* MAX_NUMNODES */;
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
@@ -914,6 +932,8 @@ void __init initmem_init(void)
 	 */
 	nodes_and(node_possible_map, node_possible_map, node_online_map);
 
+	setup_nodes();
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
