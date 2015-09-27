Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE50B1A0705
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 04:28:40 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Sun, 27 Sep 2015 14:28:38 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id AA8EAC90041
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 14:19:38 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8RISZ2w52887636
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 18:28:35 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8RISYLd005992
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 14:28:35 -0400
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>
Cc: <anton@samba.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <cl@linux.com>,
 <nacc@linux.vnet.ibm.com>, <gkurz@linux.vnet.ibm.com>,
 <grant.likely@linaro.org>, <nikunj@linux.vnet.ibm.com>,
 <raghavendra.kt@linux.vnet.ibm.com>, <khandual@linux.vnet.ibm.com>
Subject: [PATCH RFC 4/5] powerpc:numa Add helper functions to maintain chipid
 to nid mapping
Date: Sun, 27 Sep 2015 23:59:12 +0530
Message-Id: <1443378553-2146-5-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
In-Reply-To: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create arrays that maps serial nids and sparse chipids.

Note: My original idea had only two arrays of chipid to nid map. Final
code is inspired by driver/acpi/numa.c that maps a proximity node with
a logical node by Takayoshi Kochi <t-kochi@bq.jp.nec.com>, and thus
uses an additional chipid_map nodemask. The mask helps in first unused
nid easily by knowing first unset bit in the mask.

No change in functionality.

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index dd2073b..f015cad 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -63,6 +63,11 @@ static int form1_affinity;
 static int distance_ref_points_depth;
 static const __be32 *distance_ref_points;
 static int distance_lookup_table[MAX_NUMNODES][MAX_DISTANCE_REF_POINTS];
+static nodemask_t chipid_map = NODE_MASK_NONE;
+static int chipid_to_nid_map[MAX_NUMNODES]
+				= { [0 ... MAX_NUMNODES - 1] = NUMA_NO_NODE };
+static int nid_to_chipid_map[MAX_NUMNODES]
+				= { [0 ... MAX_NUMNODES - 1] = NUMA_NO_NODE };
 
 /*
  * Allocate node_to_cpumask_map based on number of available nodes
@@ -133,6 +138,48 @@ static int __init fake_numa_create_new_node(unsigned long end_pfn,
 	return 0;
 }
 
+int chipid_to_nid(int chipid)
+{
+	if (chipid < 0)
+		return NUMA_NO_NODE;
+	return chipid_to_nid_map[chipid];
+}
+
+int nid_to_chipid(int nid)
+{
+	if (nid < 0)
+		return NUMA_NO_NODE;
+	return nid_to_chipid_map[nid];
+}
+
+static void __map_chipid_to_nid(int chipid, int nid)
+{
+	if (chipid_to_nid_map[chipid] == NUMA_NO_NODE
+	     || nid < chipid_to_nid_map[chipid])
+		chipid_to_nid_map[chipid] = nid;
+	if (nid_to_chipid_map[nid] == NUMA_NO_NODE
+	    || chipid < nid_to_chipid_map[nid])
+		nid_to_chipid_map[nid] = chipid;
+}
+
+int map_chipid_to_nid(int chipid)
+{
+	int nid;
+
+	if (chipid < 0 || chipid >= MAX_NUMNODES)
+		return NUMA_NO_NODE;
+
+	nid = chipid_to_nid_map[chipid];
+	if (nid == NUMA_NO_NODE) {
+		if (nodes_weight(chipid_map) >= MAX_NUMNODES)
+			return NUMA_NO_NODE;
+		nid = first_unset_node(chipid_map);
+		__map_chipid_to_nid(chipid, nid);
+		node_set(nid, chipid_map);
+	}
+	return nid;
+}
+
 int numa_cpu_lookup(int cpu)
 {
 	return numa_cpu_lookup_table[cpu];
@@ -264,7 +311,6 @@ out:
 	return chipid;
 }
 
-
  /* Return the nid from associativity */
 static int associativity_to_nid(const __be32 *associativity)
 {
-- 
1.7.11.7
