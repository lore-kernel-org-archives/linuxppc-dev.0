Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0D31A050B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 04:28:31 +1000 (AEST)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Sun, 27 Sep 2015 12:28:29 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 62B2238C8046
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 14:28:26 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8RISQlb50987010
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 18:28:26 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8RISPYf024967
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 14:28:26 -0400
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>
Cc: <anton@samba.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <cl@linux.com>,
 <nacc@linux.vnet.ibm.com>, <gkurz@linux.vnet.ibm.com>,
 <grant.likely@linaro.org>, <nikunj@linux.vnet.ibm.com>,
 <raghavendra.kt@linux.vnet.ibm.com>, <khandual@linux.vnet.ibm.com>
Subject: [PATCH RFC 2/5] powerpc:numa Rename functions referring to nid as
 chipid
Date: Sun, 27 Sep 2015 23:59:10 +0530
Message-Id: <1443378553-2146-3-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
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

There is no change in the fuctionality

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index d5e6eee..f84ed2f 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -235,47 +235,47 @@ static void initialize_distance_lookup_table(int nid,
 	}
 }
 
-/* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
+/* Returns chipid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
  * info is found.
  */
-static int associativity_to_nid(const __be32 *associativity)
+static int associativity_to_chipid(const __be32 *associativity)
 {
-	int nid = -1;
+	int chipid = -1;
 
 	if (min_common_depth == -1)
 		goto out;
 
 	if (of_read_number(associativity, 1) >= min_common_depth)
-		nid = of_read_number(&associativity[min_common_depth], 1);
+		chipid = of_read_number(&associativity[min_common_depth], 1);
 
 	/* POWER4 LPAR uses 0xffff as invalid node */
-	if (nid == 0xffff || nid >= MAX_NUMNODES)
-		nid = -1;
+	if (chipid == 0xffff || chipid >= MAX_NUMNODES)
+		chipid = -1;
 
-	if (nid > 0 &&
+	if (chipid > 0 &&
 		of_read_number(associativity, 1) >= distance_ref_points_depth) {
 		/*
 		 * Skip the length field and send start of associativity array
 		 */
-		initialize_distance_lookup_table(nid, associativity + 1);
+		initialize_distance_lookup_table(chipid, associativity + 1);
 	}
 
 out:
-	return nid;
+	return chipid;
 }
 
-/* Returns the nid associated with the given device tree node,
+/* Returns the chipid associated with the given device tree node,
  * or -1 if not found.
  */
-static int of_node_to_nid_single(struct device_node *device)
+static int of_node_to_chipid_single(struct device_node *device)
 {
-	int nid = -1;
+	int chipid = -1;
 	const __be32 *tmp;
 
 	tmp = of_get_associativity(device);
 	if (tmp)
-		nid = associativity_to_nid(tmp);
-	return nid;
+		chipid = associativity_to_chipid(tmp);
+	return chipid;
 }
 
 /* Walk the device tree upwards, looking for an associativity id */
@@ -286,7 +286,7 @@ int of_node_to_nid(struct device_node *device)
 
 	of_node_get(device);
 	while (device) {
-		nid = of_node_to_nid_single(device);
+		nid = of_node_to_chipid_single(device);
 		if (nid != -1)
 			break;
 
@@ -498,7 +498,7 @@ static int of_get_assoc_arrays(struct device_node *memory,
 }
 
 /*
- * This is like of_node_to_nid_single() for memory represented in the
+ * This is like of_node_to_chipid_single() for memory represented in the
  * ibm,dynamic-reconfiguration-memory node.
  */
 static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
@@ -557,7 +557,7 @@ static int numa_setup_cpu(unsigned long lcpu)
 			goto out;
 	}
 
-	nid = of_node_to_nid_single(cpu);
+	nid = of_node_to_chipid_single(cpu);
 
 out_present:
 	if (nid < 0 || !node_online(nid))
@@ -754,7 +754,7 @@ static int __init parse_numa_properties(void)
 
 		cpu = of_get_cpu_node(i, NULL);
 		BUG_ON(!cpu);
-		nid = of_node_to_nid_single(cpu);
+		nid = of_node_to_chipid_single(cpu);
 		of_node_put(cpu);
 
 		/*
@@ -796,7 +796,7 @@ new_range:
 		 * have associativity properties.  If none, then
 		 * everything goes to default_nid.
 		 */
-		nid = of_node_to_nid_single(memory);
+		nid = of_node_to_chipid_single(memory);
 		if (nid < 0)
 			nid = default_nid;
 
@@ -1119,7 +1119,7 @@ static int hot_add_node_scn_to_nid(unsigned long scn_addr)
 			if ((scn_addr < start) || (scn_addr >= (start + size)))
 				continue;
 
-			nid = of_node_to_nid_single(memory);
+			nid = of_node_to_chipid_single(memory);
 			break;
 		}
 
@@ -1415,7 +1415,7 @@ int arch_update_cpu_topology(void)
 
 		/* Use associativity from first thread for all siblings */
 		vphn_get_associativity(cpu, associativity);
-		new_nid = associativity_to_nid(associativity);
+		new_nid = associativity_to_chipid(associativity);
 		if (new_nid < 0 || !node_online(new_nid))
 			new_nid = first_online_node;
 
-- 
1.7.11.7
