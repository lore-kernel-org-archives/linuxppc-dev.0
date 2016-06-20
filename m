Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYCG52k91zDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:01:49 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5KDxWiB053481
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 10:01:47 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n2f0c212-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 10:01:47 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 08:01:45 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 60BB61FF0061
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 08:01:23 -0600 (MDT)
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5KE0IRF47251514
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 14:01:38 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BF63AE063
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 10:01:38 -0400 (EDT)
Received: from [9.41.92.173] (unknown [9.41.92.173])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 782D8AE04E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 10:01:38 -0400 (EDT)
Subject: [PATCH 2/2] powerpc/pseries: Dynamic add entires to associativity
 lookup array
To: linuxppc-dev@lists.ozlabs.org
References: <5767F684.9090802@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 20 Jun 2016 09:01:38 -0500
MIME-Version: 1.0
In-Reply-To: <5767F684.9090802@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5767F742.4040302@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dynamically add entries to the associativity lookup array

The ibm,associativity-lookup-arrays property may only contain
associativity arrays for LMBs present at boot time. When hotplug
adding a LMB its associativity array may not be in the associativity
lookup array, this patch adds the ability to add new entries to the
associativity lookup array.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   93 ++++++++++++++++-------
 1 file changed, 66 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index b10f2ef..f62eef652 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -191,14 +191,72 @@ static int dlpar_update_device_tree_lmb(struct of_drconf_cell *lmb)
 	return 0;
 }
 
+static u32 find_aa_index(struct device_node *dr_node,
+			 struct property *ala_prop, const u32 *lmb_assoc)
+{
+	u32 *assoc_arrays;
+	u32 aa_index;
+	int aa_arrays, aa_array_entries, aa_array_sz;
+	int i, index;
+
+	/* The ibm,associativity-lookup-arrays property is defined to be
+	 * a 32-bit value specifying the number of associativity arrays
+	 * followed by a 32-bitvalue specifying the number of entries per
+	 * array, followed by the associativity arrays.
+	 */
+	assoc_arrays = ala_prop->value;
+
+	aa_arrays = be32_to_cpu(assoc_arrays[0]);
+	aa_array_entries = be32_to_cpu(assoc_arrays[1]);
+	aa_array_sz = aa_array_entries * sizeof(u32);
+
+	aa_index = -1;
+	for (i = 0; i < aa_arrays; i++) {
+		index = (i * aa_array_entries) + 2;
+
+		if (memcmp(&assoc_arrays[index], &lmb_assoc[1], aa_array_sz))
+			continue;
+
+		aa_index = i;
+		break;
+	}
+
+	if (aa_index == -1) {
+		struct property *new_prop;
+		u32 new_prop_size;
+
+		new_prop_size = ala_prop->length + aa_array_sz;
+		new_prop = dlpar_clone_property(ala_prop, new_prop_size);
+		if (!new_prop)
+			return -1;
+
+		assoc_arrays = new_prop->value;
+
+		/* increment the number of entries in the lookup array */
+		assoc_arrays[0] = cpu_to_be32(aa_arrays + 1);
+
+		/* copy the new associativity into the lookup array */
+		index = aa_arrays * aa_array_entries + 2;
+		memcpy(&assoc_arrays[index], &lmb_assoc[1], aa_array_sz);
+
+		of_update_property(dr_node, new_prop);
+
+		/* The associativity lookup array index for this lmb is
+		 * number of entries - 1 since we added its associativity
+		 * to the end of the lookup array.
+		 */
+		aa_index = be32_to_cpu(assoc_arrays[0]) - 1;
+	}
+
+	return aa_index;
+}
+
 static u32 lookup_lmb_associativity_index(struct of_drconf_cell *lmb)
 {
 	struct device_node *parent, *lmb_node, *dr_node;
+	struct property *ala_prop;
 	const u32 *lmb_assoc;
-	const u32 *assoc_arrays;
 	u32 aa_index;
-	int aa_arrays, aa_array_entries, aa_array_sz;
-	int i;
 
 	parent = of_find_node_by_path("/");
 	if (!parent)
@@ -222,34 +280,15 @@ static u32 lookup_lmb_associativity_index(struct of_drconf_cell *lmb)
 		return -ENODEV;
 	}
 
-	assoc_arrays = of_get_property(dr_node,
-				       "ibm,associativity-lookup-arrays",
-				       NULL);
-	of_node_put(dr_node);
-	if (!assoc_arrays) {
+	ala_prop = of_find_property(dr_node, "ibm,associativity-lookup-arrays",
+				    NULL);
+	if (!ala_prop) {
+		of_node_put(dr_node);
 		dlpar_free_cc_nodes(lmb_node);
 		return -ENODEV;
 	}
 
-	/* The ibm,associativity-lookup-arrays property is defined to be
-	 * a 32-bit value specifying the number of associativity arrays
-	 * followed by a 32-bitvalue specifying the number of entries per
-	 * array, followed by the associativity arrays.
-	 */
-	aa_arrays = be32_to_cpu(assoc_arrays[0]);
-	aa_array_entries = be32_to_cpu(assoc_arrays[1]);
-	aa_array_sz = aa_array_entries * sizeof(u32);
-
-	aa_index = -1;
-	for (i = 0; i < aa_arrays; i++) {
-		int indx = (i * aa_array_entries) + 2;
-
-		if (memcmp(&assoc_arrays[indx], &lmb_assoc[1], aa_array_sz))
-			continue;
-
-		aa_index = i;
-		break;
-	}
+	aa_index = find_aa_index(dr_node, ala_prop, lmb_assoc);
 
 	dlpar_free_cc_nodes(lmb_node);
 	return aa_index;
