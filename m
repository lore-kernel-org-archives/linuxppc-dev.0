Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwvf14GcpzDqXs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 04:28:41 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8IIOHbi063535
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 14:28:39 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d2hacfq2w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 14:28:39 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 18 Sep 2017 14:28:38 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/nodes: Ensure enough nodes avail for operations
In-Reply-To: <49626c85-d466-3f99-bde8-f459e278f6ee@linux.vnet.ibm.com>
Date: Mon, 18 Sep 2017 13:28:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <d62dd6c7-7676-5fe0-4f63-baada9213908@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/nodes: On systems like PowerPC which allow 'hot-add' of CPU
or memory resources, it may occur that the new resources are to be
inserted into nodes that were not used for these resources at bootup.
In the kernel, any node that is used must be defined and initialized
at boot.

This patch extracts the value of the lowest domain level (number of
allocable resources) from the "rtas" device tree property
"ibm,current-associativity-domains" or the device tree property
"ibm,max-associativity-domains" to use as the maximum number of nodes
to setup as possibly available in the system.  This new setting will
override the instruction,

    nodes_and(node_possible_map, node_possible_map, node_online_map);

presently seen in the function arch/powerpc/mm/numa.c:initmem_init().

If the property is not present at boot, no operation will be performed
to define or enable additional nodes.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index ec098b3..b385cd0 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -892,6 +892,51 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
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
+		prop = of_get_property(rtas,
+					"ibm,current-associativity-domains", &len);
+		if (!prop || len < sizeof(unsigned int)) {
+			prop = of_get_property(rtas,
+					"ibm,max-associativity-domains", &len);
+			goto endit;
+		}
+
+		entries = of_read_number(prop++, 1);
+
+		if (len < (entries * sizeof(unsigned int)))
+			goto endit;
+
+		if ((0 <= min_common_depth) && (min_common_depth <= (entries-1)))
+			entries = min_common_depth;
+		else
+			entries -= 1;
+
+		numnodes = of_read_number(&prop[entries], 1);
+
+		printk(KERN_INFO "numa: Nodes = %d (mcd = %d)\n", numnodes,
+			min_common_depth);
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
@@ -911,6 +956,8 @@ void __init initmem_init(void)
 	 */
 	nodes_and(node_possible_map, node_possible_map, node_online_map);
 
+	node_associativity_setup();
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
