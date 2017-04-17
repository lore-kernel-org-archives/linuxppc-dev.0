Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6BPf2Ld4zDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 01:04:38 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3HEwqwE042984
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 11:04:27 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ucdjvs4t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 11:04:26 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 09:04:26 -0600
Subject: [PATCH V2 3/5] powerpc/memory: Parse new memory property to
 initialize structures.
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: ltc-virtual-io@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com
Date: Mon, 17 Apr 2017 10:04:23 -0500
In-Reply-To: <149244134630.49112.5423447491302011316.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <149244134630.49112.5423447491302011316.stgit@powerkvm6.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149244144640.49112.3568906361161752729.stgit@powerkvm6.aus.stglabs.ibm.com>
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
 arch/powerpc/include/asm/prom.h |    8 ++
 arch/powerpc/mm/numa.c          |  193 +++++++++++++++++++++++++++++----------
 2 files changed, 152 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 77d76d8..b919c1e 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -117,6 +117,14 @@ extern int of_one_drc_info(struct property **prop, void **curval,
 			u32 *sequential_inc_p,
 			u32 *last_drc_index_p);
 
+static inline int dyn_mem_v2_len(int entries)
+{
+	/* Calculate for counter + number of cells that follow */
+	int drconf_v2_cells = (n_mem_addr_cells + 4);
+	int drconf_v2_cells_len = (drconf_v2_cells * sizeof(unsigned int));
+	return (((entries) * drconf_v2_cells_len) + sizeof(unsigned int));
+}
+
 /*
  * There are two methods for telling firmware what our capabilities are.
  * Newer machines have an "ibm,client-architecture-support" method on the
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 4fdc5ff..b035a8a 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -425,30 +425,55 @@ void read_drconf_cell_v2(struct of_drconf_cell_v2 *drmem, const __be32 **cellp)
 }
 
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
 
@@ -511,7 +536,7 @@ static int of_get_assoc_arrays(struct device_node *memory,
  * This is like of_node_to_nid_single() for memory represented in the
  * ibm,dynamic-reconfiguration-memory node.
  */
-static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
+static int of_drconf_to_nid_single(u32 drmem_flags, u32 drmem_aa_index,
 				   struct assoc_arrays *aa)
 {
 	int default_nid = 0;
@@ -519,16 +544,16 @@ static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
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
@@ -660,28 +685,37 @@ static inline int __init read_usm_ranges(const __be32 **usm)
 }
 
 /*
+ * Support routine for parse_drconf_memory_[v1/v2]
+ */
+static unsigned long __init parse_drconf_memory_common(u32 flags,
+			u32 aa_index, struct assoc_arrays *aa,
+			unsigned long base, unsigned long size)
+{
+	unsigned int nid;
+	unsigned long sz;
+
+	nid = of_drconf_to_nid_single(flags, aa_index, aa);
+	fake_numa_create_new_node(((base + size) >> PAGE_SHIFT),
+				&nid);
+	node_set_online(nid);
+	sz = numa_enforce_memory_limit(base, size);
+	if (sz)
+		memblock_set_node(base, sz, &memblock.memory, nid);
+
+	return sz;
+}
+
+/*
  * Extract NUMA information from the ibm,dynamic-reconfiguration-memory
  * node.  This assumes n_mem_{addr,size}_cells have been set.
  */
-static void __init parse_drconf_memory(struct device_node *memory)
+static void __init parse_drconf_memory_v1(struct device_node *memory,
+			unsigned int n, unsigned long lmb_size,
+			struct assoc_arrays *aa, const __be32 **dm)
 {
-	const __be32 *uninitialized_var(dm), *usm;
-	unsigned int n, rc, ranges, is_kexec_kdump = 0;
-	unsigned long lmb_size, base, size, sz;
-	int nid;
-	struct assoc_arrays aa = { .arrays = NULL };
-
-	n = of_get_drconf_memory(memory, &dm);
-	if (!n)
-		return;
-
-	lmb_size = of_get_lmb_size(memory);
-	if (!lmb_size)
-		return;
-
-	rc = of_get_assoc_arrays(memory, &aa);
-	if (rc)
-		return;
+	const __be32 *usm;
+	unsigned int ranges, is_kexec_kdump = 0;
+	unsigned long base, size;
 
 	/* check if this is a kexec/kdump kernel */
 	usm = of_get_usable_memory(memory);
@@ -691,7 +725,7 @@ static void __init parse_drconf_memory(struct device_node *memory)
 	for (; n != 0; --n) {
 		struct of_drconf_cell drmem;
 
-		read_drconf_cell(&drmem, &dm);
+		read_drconf_cell(&drmem, dm);
 
 		/* skip this block if the reserved bit is set in flags (0x80)
 		   or if the block is not assigned to this partition (0x8) */
@@ -713,19 +747,80 @@ static void __init parse_drconf_memory(struct device_node *memory)
 				base = read_n_cells(n_mem_addr_cells, &usm);
 				size = read_n_cells(n_mem_size_cells, &usm);
 			}
-			nid = of_drconf_to_nid_single(&drmem, &aa);
-			fake_numa_create_new_node(
-				((base + size) >> PAGE_SHIFT),
-					   &nid);
-			node_set_online(nid);
-			sz = numa_enforce_memory_limit(base, size);
-			if (sz)
-				memblock_set_node(base, sz,
-						  &memblock.memory, nid);
+
+			parse_drconf_memory_common(drmem.flags,
+				drmem.aa_index, aa, base, size);
+
 		} while (--ranges);
 	}
 }
 
+static void __init parse_drconf_memory_v2(struct device_node *memory,
+			unsigned int n, unsigned long lmb_size,
+			struct assoc_arrays *aa, unsigned int v2len,
+			const __be32 *v2prop, const __be32 **dm)
+{
+	unsigned long base;
+	unsigned long size;
+
+	for (; n != 0; n--) {
+		struct of_drconf_cell_v2 drmem;
+		unsigned long nsl;
+
+		/* Get the current LMB set */
+		read_drconf_cell_v2(&drmem, dm);
+
+		/* Skip this block if the reserved bit is set in
+		 * flags (0x80) or if the block is not assigned
+		 * to this partition (0x8)
+		 */
+		if ((drmem.flags & DRCONF_MEM_RESERVED)
+		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
+			continue;
+
+		base = drmem.base_addr;
+		nsl = drmem.num_seq_lmbs;
+
+		for (; nsl != 0; nsl--) {
+			size = lmb_size;
+
+			base += parse_drconf_memory_common(drmem.flags,
+					drmem.aa_index, aa, base, size);
+		}
+	}
+}
+
+static void __init parse_drconf_memory(struct device_node *memory)
+{
+	const __be32 *uninitialized_var(dm);
+	unsigned int n, v2len;
+	unsigned long lmb_size;
+	struct assoc_arrays aa = { .arrays = NULL };
+	const __be32 *v2prop;
+	int rc;
+
+	/* Get the number of sub-structures to be processed */
+	n = of_get_drconf_memory(memory, &dm);
+	if (!n)
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
+	v2prop = of_get_property(memory, "ibm,dynamic-memory-v2", &v2len);
+
+	if (!v2prop || v2len < sizeof(unsigned int))
+		parse_drconf_memory_v1(memory, n, lmb_size, &aa, &dm);
+	else
+		parse_drconf_memory_v2(memory, n, lmb_size, &aa,
+					v2len, v2prop, &dm);
+}
+
 static int __init parse_numa_properties(void)
 {
 	struct device_node *memory;
@@ -1039,8 +1134,8 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
 		if ((scn_addr < drmem.base_addr)
 		    || (scn_addr >= (drmem.base_addr + lmb_size)))
 			continue;
-
-		nid = of_drconf_to_nid_single(&drmem, &aa);
+		nid = of_drconf_to_nid_single(drmem.flags,
+						drmem.aa_index, &aa);
 		break;
 	}
 
