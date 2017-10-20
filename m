Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJRfW3DzLzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Oct 2017 00:36:51 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9KDZ0D6115695
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 09:36:49 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dqfwq77vq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 09:36:48 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 20 Oct 2017 09:36:47 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9KDaivr65863720
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 13:36:44 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 969B728046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 09:36:37 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id 6D1ED2803D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 09:36:37 -0400 (EDT)
Subject: [PATCH v2 4/8] powerpc/numa: Update numa code use drmem LMB array
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 20 Oct 2017 08:22:12 -0500
In-Reply-To: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150850573244.9118.15508508521024302755.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update code in powerpc/numa.c to use the array of dynamic
reconfiguration memory LMBs instead of parsing the device tree
property directly. This allows for the removal of several
helper routines used to read dynamic reconfiguration memory
device tree property information and eases the gathering of
LMB information.

This patch also prepares the numa code for support of the
version 2 dynamic reconfiguration memory property.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---

Updates for V2: Removed unused device node paramter to
numa_setup_drmem_lmbs() and hot_add_drconf_scn_to_nid().
---
 arch/powerpc/include/asm/drmem.h |    1 
 arch/powerpc/mm/drmem.c          |    9 ++
 arch/powerpc/mm/numa.c           |  158 ++++++++------------------------------
 3 files changed, 42 insertions(+), 126 deletions(-)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index cafe1a3b7da6..912712ecf6c6 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -41,5 +41,6 @@ static inline u32 drmem_lmb_size(void)
 }
 
 extern int __init init_drmem_lmbs(unsigned long node);
+extern u64 drmem_lmb_memory_max(void);
 
 #endif
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 8ad7cf36b2c4..96e453e1fdd7 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -61,6 +61,14 @@ int __init init_drmem_lmbs(unsigned long node)
 	return 0;
 }
 
+u64 drmem_lmb_memory_max(void)
+{
+	struct drmem_lmb *last_lmb;
+
+	last_lmb = &drmem_info->lmbs[drmem_info->n_lmbs - 1];
+	return last_lmb->base_addr + drmem_lmb_size();
+}
+
 static int __init drmem_init(void)
 {
 	struct drmem_lmb *lmbs;
@@ -81,4 +89,3 @@ static int __init drmem_init(void)
 }
 
 late_initcall(drmem_init);
-
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index a9aa353d41cd..6cddc7e73b21 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -40,6 +40,7 @@
 #include <asm/hvcall.h>
 #include <asm/setup.h>
 #include <asm/vdso.h>
+#include <asm/drmem.h>
 
 static int numa_enabled = 1;
 
@@ -395,69 +396,6 @@ static unsigned long read_n_cells(int n, const __be32 **buf)
 	return result;
 }
 
-/*
- * Read the next memblock list entry from the ibm,dynamic-memory property
- * and return the information in the provided of_drconf_cell structure.
- */
-static void read_drconf_cell(struct of_drconf_cell *drmem, const __be32 **cellp)
-{
-	const __be32 *cp;
-
-	drmem->base_addr = read_n_cells(n_mem_addr_cells, cellp);
-
-	cp = *cellp;
-	drmem->drc_index = of_read_number(cp, 1);
-	drmem->reserved = of_read_number(&cp[1], 1);
-	drmem->aa_index = of_read_number(&cp[2], 1);
-	drmem->flags = of_read_number(&cp[3], 1);
-
-	*cellp = cp + 4;
-}
-
-/*
- * Retrieve and validate the ibm,dynamic-memory property of the device tree.
- *
- * The layout of the ibm,dynamic-memory property is a number N of memblock
- * list entries followed by N memblock list entries.  Each memblock list entry
- * contains information as laid out in the of_drconf_cell struct above.
- */
-static int of_get_drconf_memory(struct device_node *memory, const __be32 **dm)
-{
-	const __be32 *prop;
-	u32 len, entries;
-
-	prop = of_get_property(memory, "ibm,dynamic-memory", &len);
-	if (!prop || len < sizeof(unsigned int))
-		return 0;
-
-	entries = of_read_number(prop++, 1);
-
-	/* Now that we know the number of entries, revalidate the size
-	 * of the property read in to ensure we have everything
-	 */
-	if (len < (entries * (n_mem_addr_cells + 4) + 1) * sizeof(unsigned int))
-		return 0;
-
-	*dm = prop;
-	return entries;
-}
-
-/*
- * Retrieve and validate the ibm,lmb-size property for drconf memory
- * from the device tree.
- */
-static u64 of_get_lmb_size(struct device_node *memory)
-{
-	const __be32 *prop;
-	u32 len;
-
-	prop = of_get_property(memory, "ibm,lmb-size", &len);
-	if (!prop || len < sizeof(unsigned int))
-		return 0;
-
-	return read_n_cells(n_mem_size_cells, &prop);
-}
-
 struct assoc_arrays {
 	u32	n_arrays;
 	u32	array_sz;
@@ -509,7 +447,7 @@ static int of_get_assoc_arrays(struct assoc_arrays *aa)
  * This is like of_node_to_nid_single() for memory represented in the
  * ibm,dynamic-reconfiguration-memory node.
  */
-static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
+static int of_drconf_to_nid_single(struct drmem_lmb *lmb,
 				   struct assoc_arrays *aa)
 {
 	int default_nid = 0;
@@ -517,16 +455,16 @@ static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
 	int index;
 
 	if (min_common_depth > 0 && min_common_depth <= aa->array_sz &&
-	    !(drmem->flags & DRCONF_MEM_AI_INVALID) &&
-	    drmem->aa_index < aa->n_arrays) {
-		index = drmem->aa_index * aa->array_sz + min_common_depth - 1;
+	    !(lmb->flags & DRCONF_MEM_AI_INVALID) &&
+	    lmb->aa_index < aa->n_arrays) {
+		index = lmb->aa_index * aa->array_sz + min_common_depth - 1;
 		nid = of_read_number(&aa->arrays[index], 1);
 
 		if (nid == 0xffff || nid >= MAX_NUMNODES)
 			nid = default_nid;
 
 		if (nid > 0) {
-			index = drmem->aa_index * aa->array_sz;
+			index = lmb->aa_index * aa->array_sz;
 			initialize_distance_lookup_table(nid,
 							&aa->arrays[index]);
 		}
@@ -661,22 +599,15 @@ static inline int __init read_usm_ranges(const __be32 **usm)
  * Extract NUMA information from the ibm,dynamic-reconfiguration-memory
  * node.  This assumes n_mem_{addr,size}_cells have been set.
  */
-static void __init parse_drconf_memory(struct device_node *memory)
+static void __init numa_setup_drmem_lmbs(void)
 {
-	const __be32 *uninitialized_var(dm), *usm;
-	unsigned int n, rc, ranges, is_kexec_kdump = 0;
-	unsigned long lmb_size, base, size, sz;
+	struct drmem_lmb *lmb;
+	const __be32 *usm;
+	unsigned int rc, ranges, is_kexec_kdump = 0;
+	unsigned long base, size, sz;
 	int nid;
 	struct assoc_arrays aa = { .arrays = NULL };
 
-	n = of_get_drconf_memory(memory, &dm);
-	if (!n)
-		return;
-
-	lmb_size = of_get_lmb_size(memory);
-	if (!lmb_size)
-		return;
-
 	rc = of_get_assoc_arrays(&aa);
 	if (rc)
 		return;
@@ -686,19 +617,15 @@ static void __init parse_drconf_memory(struct device_node *memory)
 	if (usm != NULL)
 		is_kexec_kdump = 1;
 
-	for (; n != 0; --n) {
-		struct of_drconf_cell drmem;
-
-		read_drconf_cell(&drmem, &dm);
-
+	for_each_drmem_lmb(lmb) {
 		/* skip this block if the reserved bit is set in flags (0x80)
 		   or if the block is not assigned to this partition (0x8) */
-		if ((drmem.flags & DRCONF_MEM_RESERVED)
-		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
+		if ((lmb->flags & DRCONF_MEM_RESERVED)
+		    || !(lmb->flags & DRCONF_MEM_ASSIGNED))
 			continue;
 
-		base = drmem.base_addr;
-		size = lmb_size;
+		base = lmb->base_addr;
+		size = drmem_lmb_size();
 		ranges = 1;
 
 		if (is_kexec_kdump) {
@@ -711,7 +638,7 @@ static void __init parse_drconf_memory(struct device_node *memory)
 				base = read_n_cells(n_mem_addr_cells, &usm);
 				size = read_n_cells(n_mem_size_cells, &usm);
 			}
-			nid = of_drconf_to_nid_single(&drmem, &aa);
+			nid = of_drconf_to_nid_single(lmb, &aa);
 			fake_numa_create_new_node(
 				((base + size) >> PAGE_SHIFT),
 					   &nid);
@@ -816,8 +743,10 @@ static int __init parse_numa_properties(void)
 	 * ibm,dynamic-reconfiguration-memory node.
 	 */
 	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (memory)
-		parse_drconf_memory(memory);
+	if (memory) {
+		numa_setup_drmem_lmbs();
+		of_node_put(memory);
+	}
 
 	return 0;
 }
@@ -995,43 +924,32 @@ early_param("topology_updates", early_topology_updates);
  * memory represented in the device tree by the property
  * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory.
  */
-static int hot_add_drconf_scn_to_nid(struct device_node *memory,
-				     unsigned long scn_addr)
+static int hot_add_drconf_scn_to_nid(unsigned long scn_addr)
 {
-	const __be32 *dm;
-	unsigned int drconf_cell_cnt, rc;
+	struct drmem_lmb *lmb;
+	unsigned int rc;
 	unsigned long lmb_size;
 	struct assoc_arrays aa;
 	int nid = -1;
 
-	drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
-	if (!drconf_cell_cnt)
-		return -1;
-
-	lmb_size = of_get_lmb_size(memory);
-	if (!lmb_size)
-		return -1;
+	lmb_size = drmem_lmb_size();
 
 	rc = of_get_assoc_arrays(&aa);
 	if (rc)
 		return -1;
 
-	for (; drconf_cell_cnt != 0; --drconf_cell_cnt) {
-		struct of_drconf_cell drmem;
-
-		read_drconf_cell(&drmem, &dm);
-
+	for_each_drmem_lmb(lmb) {
 		/* skip this block if it is reserved or not assigned to
 		 * this partition */
-		if ((drmem.flags & DRCONF_MEM_RESERVED)
-		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
+		if ((lmb->flags & DRCONF_MEM_RESERVED)
+		    || !(lmb->flags & DRCONF_MEM_ASSIGNED))
 			continue;
 
-		if ((scn_addr < drmem.base_addr)
-		    || (scn_addr >= (drmem.base_addr + lmb_size)))
+		if ((scn_addr < lmb->base_addr)
+		    || (scn_addr >= (lmb->base_addr + lmb_size)))
 			continue;
 
-		nid = of_drconf_to_nid_single(&drmem, &aa);
+		nid = of_drconf_to_nid_single(lmb, &aa);
 		break;
 	}
 
@@ -1096,7 +1014,7 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 
 	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
 	if (memory) {
-		nid = hot_add_drconf_scn_to_nid(memory, scn_addr);
+		nid = hot_add_drconf_scn_to_nid(scn_addr);
 		of_node_put(memory);
 	} else {
 		nid = hot_add_node_scn_to_nid(scn_addr);
@@ -1112,11 +1030,7 @@ static u64 hot_add_drconf_memory_max(void)
 {
 	struct device_node *memory = NULL;
 	struct device_node *dn = NULL;
-	unsigned int drconf_cell_cnt = 0;
-	u64 lmb_size = 0;
-	const __be32 *dm = NULL;
 	const __be64 *lrdr = NULL;
-	struct of_drconf_cell drmem;
 
 	dn = of_find_node_by_path("/rtas");
 	if (dn) {
@@ -1128,14 +1042,8 @@ static u64 hot_add_drconf_memory_max(void)
 
 	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
 	if (memory) {
-		drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
-		lmb_size = of_get_lmb_size(memory);
-
-		/* Advance to the last cell, each cell has 6 32 bit integers */
-		dm += (drconf_cell_cnt - 1) * 6;
-		read_drconf_cell(&drmem, &dm);
 		of_node_put(memory);
-		return drmem.base_addr + lmb_size;
+		return drmem_lmb_memory_max();
 	}
 	return 0;
 }
