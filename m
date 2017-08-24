Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xddhv6t4zzDrKj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 08:08:15 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7OM4Fca010749
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 18:08:13 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2chyq0khmq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 18:08:12 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 16:08:12 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V10 2/2] powerpc/nodes: Ensure enough nodes avail for
 operations
In-Reply-To: <db1b23c1-67bc-fb0f-51f9-af4bc564d9ef@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 17:07:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <efa83205-dd02-105f-a0a6-8d6ff4231612@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
To: linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: John Allen <jallen@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [PATCH V10 2/2] powerpc/nodes: Ensure enough nodes avail for operations

powerpc/nodes: On systems like PowerPC which allow 'hot-add' of CPU
or memory resources, it may occur that the new resources are to be
inserted into nodes that were not used for these resources at bootup.
In the kernel, any node that is used must be defined and initialized
at boot.

This patch extracts the value of the 'min_common_depth' element from
the "rtas" device tree property "ibm,max-associativity-domains" to use
as the maximum number of nodes to setup as possibly available in the
system.  [The 'min_common_depth' element is calculated from memory
associations found while loading all of the configured memory into
the system data structures at boot.]  This new setting will override
the instruction,

    nodes_and(node_possible_map, node_possible_map, node_online_map);

presently seen in the function arch/powerpc/mm/numa.c:initmem_init().

If the property is not present at boot, no operation will be performed
to define or enable additional nodes.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V10:
  -- Try to use 'min_common_depth' from NUMA initialization to select
     domain level to use for maximum nodes.
---
 arch/powerpc/mm/numa.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 73427e290..841d3b6 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -896,6 +896,48 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
 }
 
+static void __init node_associativity_setup(void)
+{
+	struct device_node *rtas;
+
+	rtas = of_find_node_by_path("/rtas");
+	if (rtas) {
+		const __be32 *prop;
+		u32 len, entries, numnodes, i;
+
+		prop = of_get_property(rtas, "ibm,max-associativity-domains", &len);
+		if (!prop || len < sizeof(unsigned int))
+			goto endit;
+
+		entries = of_read_number(prop++, 1);
+
+		if (len < (entries * sizeof(unsigned int)))
+			goto endit;
+
+		dbg("numa: Debug: Entries = %d MCD = %d\n", entries, min_common_depth);
+
+		if ((0 <= min_common_depth) && (min_common_depth <= (entries-1)))
+			entries = min_common_depth;
+		else
+			entries -= 1;
+
+		numnodes = of_read_number(&prop[entries], 1);
+
+		printk(KERN_INFO "numa: Nodes = %d\n", numnodes);
+
+		for (i = 0; i < numnodes; i++) {
+			if (!node_possible(i)) {
+				setup_node_data(i, 0, 0);
+				node_set(i, node_possible_map);
+			}
+		}
+	}
+
+endit:
+	if (rtas)
+		of_node_put(rtas);
+}
+
 void __init initmem_init(void)
 {
 	int nid, cpu;
@@ -915,6 +957,8 @@ void __init initmem_init(void)
 	 */
 	nodes_and(node_possible_map, node_possible_map, node_online_map);
 
+	node_associativity_setup();
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
