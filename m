Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3HTz74K6zDqhR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 10:42:31 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u720Yokh058400
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 20:42:30 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24grd4r9v9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 20:42:30 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 18:42:29 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 34A7B3E40044
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 18:42:23 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V3 3/8] powerpc/memory: Parse new memory property to
 initialize structures.
Date: Mon, 1 Aug 2016 19:42:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <ce21356b-c588-bb8f-8f61-1092b919e5fb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/memory: Add parallel routines to parse the new property
"ibm,dynamic-memory-v2" property when it is present, and then to
finish initialization of the relevant memory structures with the
operating system.  This code is shared between the boot-time
initialization functions and the runtime functions for memory
hotplug, so it needs to be able to handle both formats.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 669a15e..18b4ee7 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -407,9 +407,8 @@
 
 	*cellp = cp + 4;
 }
- 
- /*
- * Retrieve and validate the ibm,dynamic-memory property of the device tree.
+
+/*
  * Read the next memory block set entry from the ibm,dynamic-memory-v2 property
  * and return the information in the provided of_drconf_cell_v2 structure.
  */
@@ -427,30 +426,55 @@
 EXPORT_SYMBOL(read_drconf_cell_v2);
 
 /*
- * Retrieve and validate the ibm,dynamic-memory property of the device tree.
+ * Retrieve and validate the ibm,dynamic-memory[-v2] property of the
+ * device tree.
+ *
+ * The layout of the ibm,dynamic-memory property is a number N of memory
+ * block description list entries followed by N memory block description
+ * list entries.  Each memory block description list entry contains
+ * information as laid out in the of_drconf_cell struct above.
  *
- * The layout of the ibm,dynamic-memory property is a number N of memblock
- * list entries followed by N memblock list entries.  Each memblock list entry
- * contains information as laid out in the of_drconf_cell struct above.
+ * The layout of the ibm,dynamic-memory-v2 property is a number N of memory
+ * block set description list entries, followed by N memory block set
+ * description set entries.
  */
 static int of_get_drconf_memory(struct device_node *memory, const __be32 **dm)
 {
 	const __be32 *prop;
 	u32 len, entries;
 
-	prop = of_get_property(memory, "ibm,dynamic-memory", &len);
-	if (!prop || len < sizeof(unsigned int))
-		return 0;
+	if (firmware_has_feature(FW_FEATURE_DYN_MEM_V2)) {
 
-	entries = of_read_number(prop++, 1);
+		prop = of_get_property(memory, "ibm,dynamic-memory-v2", &len);
+		if (!prop || len < sizeof(unsigned int))
+			return 0;
 
-	/* Now that we know the number of entries, revalidate the size
-	 * of the property read in to ensure we have everything
-	 */
-	if (len < (entries * (n_mem_addr_cells + 4) + 1) * sizeof(unsigned int))
-		return 0;
+		entries = of_read_number(prop++, 1);
+
+		/* Now that we know the number of set entries, revalidate the
+		 * size of the property read in to ensure we have everything.
+		 */
+		if (len < dyn_mem_v2_len(entries))
+			return 0;
+
+		*dm = prop;
+	} else {
+		prop = of_get_property(memory, "ibm,dynamic-memory", &len);
+		if (!prop || len < sizeof(unsigned int))
+			return 0;
+
+		entries = of_read_number(prop++, 1);
+
+		/* Now that we know the number of entries, revalidate the size
+		 * of the property read in to ensure we have everything
+		 */
+		if (len < (entries * (n_mem_addr_cells + 4) + 1) *
+			   sizeof(unsigned int))
+			return 0;
+
+		*dm = prop;
+	}
 
-	*dm = prop;
 	return entries;
 }
 
@@ -513,7 +537,7 @@
  * This is like of_node_to_nid_single() for memory represented in the
  * ibm,dynamic-reconfiguration-memory node.
  */
-static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
+static int of_drconf_to_nid_single(u32 drmem_flags, u32 drmem_aa_index,
 				   struct assoc_arrays *aa)
 {
 	int default_nid = 0;
@@ -521,16 +545,16 @@
 	int index;
 
 	if (min_common_depth > 0 && min_common_depth <= aa->array_sz &&
-	    !(drmem->flags & DRCONF_MEM_AI_INVALID) &&
-	    drmem->aa_index < aa->n_arrays) {
-		index = drmem->aa_index * aa->array_sz + min_common_depth - 1;
+	    !(drmem_flags & DRCONF_MEM_AI_INVALID) &&
+	    drmem_aa_index < aa->n_arrays) {
+		index = drmem_aa_index * aa->array_sz + min_common_depth - 1;
 		nid = of_read_number(&aa->arrays[index], 1);
 
 		if (nid == 0xffff || nid >= MAX_NUMNODES)
 			nid = default_nid;
 
 		if (nid > 0) {
-			index = drmem->aa_index * aa->array_sz;
+			index = drmem_aa_index * aa->array_sz;
 			initialize_distance_lookup_table(nid,
 							&aa->arrays[index]);
 		}
@@ -665,7 +697,7 @@
  * Extract NUMA information from the ibm,dynamic-reconfiguration-memory
  * node.  This assumes n_mem_{addr,size}_cells have been set.
  */
-static void __init parse_drconf_memory(struct device_node *memory)
+static void __init parse_drconf_memory_v1(struct device_node *memory)
 {
 	const __be32 *uninitialized_var(dm), *usm;
 	unsigned int n, rc, ranges, is_kexec_kdump = 0;
@@ -715,10 +747,11 @@
 				base = read_n_cells(n_mem_addr_cells, &usm);
 				size = read_n_cells(n_mem_size_cells, &usm);
 			}
-			nid = of_drconf_to_nid_single(&drmem, &aa);
+			nid = of_drconf_to_nid_single(drmem.flags,
+							drmem.aa_index, &aa);
 			fake_numa_create_new_node(
 				((base + size) >> PAGE_SHIFT),
-					   &nid);
+					    &nid);
 			node_set_online(nid);
 			sz = numa_enforce_memory_limit(base, size);
 			if (sz)
@@ -728,6 +761,78 @@
 	}
 }
 
+static void __init parse_drconf_memory_v2(struct device_node *memory)
+{
+	const __be32 *uninitialized_var(dm);
+	unsigned int num_lmb_sets, rc;
+	unsigned long lmb_size, base;
+	unsigned long size, sz;
+	int nid;
+	struct assoc_arrays aa = { .arrays = NULL };
+	const __be32 *prop, *p;
+	u32	len;
+
+	prop = of_get_property(memory, "ibm,dynamic-memory-v2", &len);
+	if (!prop)
+		return;
+	p = prop;
+
+	num_lmb_sets = of_get_drconf_memory(memory, &dm);
+	if (!num_lmb_sets)
+		return;
+
+	lmb_size = of_get_lmb_size(memory);
+	if (!lmb_size)
+		return;
+
+	rc = of_get_assoc_arrays(memory, &aa);
+	if (rc)
+		return;
+
+	for (; num_lmb_sets != 0; num_lmb_sets--) {
+		struct of_drconf_cell_v2 drmem;
+		unsigned long nsl;
+
+		/* Get the current LMB set */
+		read_drconf_cell_v2(&drmem, &dm);
+		base = drmem.base_addr;
+		nsl = drmem.num_seq_lmbs;
+
+		/* Skip this block if the reserved bit is set in
+		 * flags (0x80) or if the block is not assigned
+		 * to this partition (0x8)
+		 */
+		if ((drmem.flags & DRCONF_MEM_RESERVED)
+		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
+			continue;
+
+		for (; nsl != 0; nsl--) {
+			size = lmb_size;
+
+			nid = of_drconf_to_nid_single(drmem.flags,
+						drmem.aa_index, &aa);
+			fake_numa_create_new_node(
+					((base + size) >> PAGE_SHIFT),
+					&nid);
+			node_set_online(nid);
+			sz = numa_enforce_memory_limit(base, size);
+			if (sz)
+				memblock_set_node(base, sz,
+						&memblock.memory, nid);
+
+			base += sz;
+		}
+	}
+}
+
+static void __init parse_drconf_memory(struct device_node *memory)
+{
+	if (firmware_has_feature(FW_FEATURE_DYN_MEM_V2))
+		parse_drconf_memory_v2(memory);
+	else
+		parse_drconf_memory_v1(memory);
+}
+
 static int __init parse_numa_properties(void)
 {
 	struct device_node *memory;
@@ -1082,8 +1211,8 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
 		if ((scn_addr < drmem.base_addr)
 		    || (scn_addr >= (drmem.base_addr + lmb_size)))
 			continue;
-
-		nid = of_drconf_to_nid_single(&drmem, &aa);
+		nid = of_drconf_to_nid_single(drmem.flags,
+						drmem.aa_index, &aa);
 		break;
 	}
 
