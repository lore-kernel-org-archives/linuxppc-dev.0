Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypLDn3KhnzDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 04:02:49 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1H09cP069012
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 12:02:47 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ek7seux6t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 12:02:45 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 1 Dec 2017 12:02:44 -0500
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vB1H2YEV44368106
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 17:02:42 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A854AC058
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:03:40 -0500 (EST)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id 02744AC041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:03:39 -0500 (EST)
Subject: [PATCH V3 5/9] powerpc/numa: Update numa code use walk_drmem_lmbs
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 01 Dec 2017 10:47:21 -0600
In-Reply-To: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151214683375.64022.973293798858507048.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update code in powerpc/numa.c to use the walk_drmem_lmbs()
routine instead of parsing the device tree directly. This is
in anticipation of introducing a new ibm,dynamic-memory-v2
property with a different format. This will allow the numa code
to use a single initialization routine per-LMB irregardless of
the device tree format.

Additionally, to support additional routines in numa.c that need
to look up LMB information, an late_init routine is added to drmem.c
to allocate the array of LMB information. This LMB array will provide
per-LMB information to separate the LMB data from the device tree
format.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---

Updates for V3: Convert numa.c to use walk_drmem_lmbs routine and
add the late init call for allocating the LMB array.

Updates for V2: Removed unused device node paramter to
numa_setup_drmem_lmbs() and hot_add_drconf_scn_to_nid().

 arch/powerpc/include/asm/drmem.h |    4 +
 arch/powerpc/mm/drmem.c          |  100 +++++++++++++++++
 arch/powerpc/mm/numa.c           |  222 +++++++++-----------------------------
 3 files changed, 154 insertions(+), 172 deletions(-)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index c7fc5c4d8a7c..679da30a1bea 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -40,6 +40,10 @@ static inline u32 drmem_lmb_size(void)
 	return drmem_info->lmb_size;
 }
 
+u64 drmem_lmb_memory_max(void);
+void __init walk_drmem_lmbs(struct device_node *dn,
+			void (*func)(struct drmem_lmb *, const __be32 **));
+
 #ifdef CONFIG_PPC_PSERIES
 void __init walk_drmem_lmbs_early(unsigned long node,
 			void (*func)(struct drmem_lmb *, const __be32 **));
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index f8ee0f355405..5888ac3ca8a9 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -21,7 +21,14 @@
 static struct drmem_lmb_info __drmem_info;
 struct drmem_lmb_info *drmem_info = &__drmem_info;
 
-#ifdef CONFIG_PPC_PSERIES
+u64 drmem_lmb_memory_max(void)
+{
+	struct drmem_lmb *last_lmb;
+
+	last_lmb = &drmem_info->lmbs[drmem_info->n_lmbs - 1];
+	return last_lmb->base_addr + drmem_lmb_size();
+}
+
 static void __init read_drconf_v1_cell(struct drmem_lmb *lmb,
 				       const __be32 **prop)
 {
@@ -52,6 +59,7 @@ static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
 	}
 }
 
+#ifdef CONFIG_PPC_PSERIES
 void __init walk_drmem_lmbs_early(unsigned long node,
 			void (*func)(struct drmem_lmb *, const __be32 **))
 {
@@ -74,3 +82,93 @@ void __init walk_drmem_lmbs_early(unsigned long node,
 }
 
 #endif
+
+static int __init init_drmem_lmb_size(struct device_node *dn)
+{
+	const __be32 *prop;
+	int len;
+
+	if (drmem_info->lmb_size)
+		return 0;
+
+	prop = of_get_property(dn, "ibm,lmb-size", &len);
+	if (!prop || len < dt_root_size_cells * sizeof(__be32)) {
+		pr_info("Could not determine LMB size\n");
+		return -1;
+	}
+
+	drmem_info->lmb_size = dt_mem_next_cell(dt_root_size_cells, &prop);
+	return 0;
+}
+
+/*
+ * Returns the property linux,drconf-usable-memory if
+ * it exists (the property exists only in kexec/kdump kernels,
+ * added by kexec-tools)
+ */
+static const __be32 *of_get_usable_memory(struct device_node *dn)
+{
+	const __be32 *prop;
+	u32 len;
+
+	prop = of_get_property(dn, "linux,drconf-usable-memory", &len);
+	if (!prop || len < sizeof(unsigned int))
+		return NULL;
+
+	return prop;
+}
+
+void __init walk_drmem_lmbs(struct device_node *dn,
+			    void (*func)(struct drmem_lmb *, const __be32 **))
+{
+	const __be32 *prop, *usm;
+
+	if (init_drmem_lmb_size(dn))
+		return;
+
+	usm = of_get_usable_memory(dn);
+
+	prop = of_get_property(dn, "ibm,dynamic-memory", NULL);
+	if (prop)
+		__walk_drmem_v1_lmbs(prop, usm, func);
+}
+
+static void __init init_drmem_v1_lmbs(const __be32 *prop)
+{
+	struct drmem_lmb *lmb;
+
+	drmem_info->n_lmbs = of_read_number(prop++, 1);
+
+	drmem_info->lmbs = kcalloc(drmem_info->n_lmbs, sizeof(*lmb),
+				   GFP_KERNEL);
+	if (!drmem_info->lmbs)
+		return;
+
+	for_each_drmem_lmb(lmb)
+		read_drconf_v1_cell(lmb, &prop);
+}
+
+static int __init drmem_init(void)
+{
+	struct device_node *dn;
+	const __be32 *prop;
+
+	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!dn) {
+		pr_info("No dynamic reconfiguration memory found\n");
+		return 0;
+	}
+
+	if (init_drmem_lmb_size(dn)) {
+		of_node_put(dn);
+		return 0;
+	}
+
+	prop = of_get_property(dn, "ibm,dynamic-memory", NULL);
+	if (prop)
+		init_drmem_v1_lmbs(prop);
+
+	of_node_put(dn);
+	return 0;
+}
+late_initcall(drmem_init);
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index d25278adaead..0e573f9b9d38 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -40,6 +40,7 @@
 #include <asm/hvcall.h>
 #include <asm/setup.h>
 #include <asm/vdso.h>
+#include <asm/drmem.h>
 
 static int numa_enabled = 1;
 
@@ -179,29 +180,6 @@ static const __be32 *of_get_associativity(struct device_node *dev)
 	return of_get_property(dev, "ibm,associativity", NULL);
 }
 
-/*
- * Returns the property linux,drconf-usable-memory if
- * it exists (the property exists only in kexec/kdump kernels,
- * added by kexec-tools)
- */
-static const __be32 *of_get_usable_memory(void)
-{
-	struct device_node *memory;
-	const __be32 *prop;
-	u32 len;
-
-	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (!memory)
-		return NULL;
-
-	prop = of_get_property(memory, "linux,drconf-usable-memory", &len);
-	of_node_put(memory);
-
-	if (!prop || len < sizeof(unsigned int))
-		return NULL;
-	return prop;
-}
-
 int __node_distance(int a, int b)
 {
 	int i;
@@ -395,69 +373,6 @@ static unsigned long read_n_cells(int n, const __be32 **buf)
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
@@ -509,7 +424,7 @@ static int of_get_assoc_arrays(struct assoc_arrays *aa)
  * This is like of_node_to_nid_single() for memory represented in the
  * ibm,dynamic-reconfiguration-memory node.
  */
-static int of_drconf_to_nid_single(struct of_drconf_cell *drmem)
+static int of_drconf_to_nid_single(struct drmem_lmb *lmb)
 {
 	struct assoc_arrays aa = { .arrays = NULL };
 	int default_nid = 0;
@@ -521,16 +436,16 @@ static int of_drconf_to_nid_single(struct of_drconf_cell *drmem)
 		return default_nid;
 
 	if (min_common_depth > 0 && min_common_depth <= aa.array_sz &&
-	    !(drmem->flags & DRCONF_MEM_AI_INVALID) &&
-	    drmem->aa_index < aa.n_arrays) {
-		index = drmem->aa_index * aa.array_sz + min_common_depth - 1;
+	    !(lmb->flags & DRCONF_MEM_AI_INVALID) &&
+	    lmb->aa_index < aa.n_arrays) {
+		index = lmb->aa_index * aa.array_sz + min_common_depth - 1;
 		nid = of_read_number(&aa.arrays[index], 1);
 
 		if (nid == 0xffff || nid >= MAX_NUMNODES)
 			nid = default_nid;
 
 		if (nid > 0) {
-			index = drmem->aa_index * aa.array_sz;
+			index = lmb->aa_index * aa.array_sz;
 			initialize_distance_lookup_table(nid,
 							&aa.arrays[index]);
 		}
@@ -665,62 +580,47 @@ static inline int __init read_usm_ranges(const __be32 **usm)
  * Extract NUMA information from the ibm,dynamic-reconfiguration-memory
  * node.  This assumes n_mem_{addr,size}_cells have been set.
  */
-static void __init parse_drconf_memory(struct device_node *memory)
+static void __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
+					const __be32 **usm)
 {
-	const __be32 *uninitialized_var(dm), *usm;
-	unsigned int n, ranges, is_kexec_kdump = 0;
-	unsigned long lmb_size, base, size, sz;
+	unsigned int ranges, is_kexec_kdump = 0;
+	unsigned long base, size, sz;
 	int nid;
 
-	n = of_get_drconf_memory(memory, &dm);
-	if (!n)
-		return;
-
-	lmb_size = of_get_lmb_size(memory);
-	if (!lmb_size)
+	/* skip this block if the reserved bit is set in flags (0x80)
+	 * or if the block is not assigned to this partition (0x8)
+	 */
+	if ((lmb->flags & DRCONF_MEM_RESERVED)
+	    || !(lmb->flags & DRCONF_MEM_ASSIGNED))
 		return;
 
-	/* check if this is a kexec/kdump kernel */
-	usm = of_get_usable_memory();
-	if (usm != NULL)
+	if (*usm)
 		is_kexec_kdump = 1;
 
-	for (; n != 0; --n) {
-		struct of_drconf_cell drmem;
+	base = lmb->base_addr;
+	size = drmem_lmb_size();
+	ranges = 1;
 
-		read_drconf_cell(&drmem, &dm);
-
-		/* skip this block if the reserved bit is set in flags (0x80)
-		   or if the block is not assigned to this partition (0x8) */
-		if ((drmem.flags & DRCONF_MEM_RESERVED)
-		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
-			continue;
-
-		base = drmem.base_addr;
-		size = lmb_size;
-		ranges = 1;
+	if (is_kexec_kdump) {
+		ranges = read_usm_ranges(usm);
+		if (!ranges) /* there are no (base, size) duple */
+			return;
+	}
 
+	do {
 		if (is_kexec_kdump) {
-			ranges = read_usm_ranges(&usm);
-			if (!ranges) /* there are no (base, size) duple */
-				continue;
+			base = read_n_cells(n_mem_addr_cells, usm);
+			size = read_n_cells(n_mem_size_cells, usm);
 		}
-		do {
-			if (is_kexec_kdump) {
-				base = read_n_cells(n_mem_addr_cells, &usm);
-				size = read_n_cells(n_mem_size_cells, &usm);
-			}
-			nid = of_drconf_to_nid_single(&drmem);
-			fake_numa_create_new_node(
-				((base + size) >> PAGE_SHIFT),
-					   &nid);
-			node_set_online(nid);
-			sz = numa_enforce_memory_limit(base, size);
-			if (sz)
-				memblock_set_node(base, sz,
-						  &memblock.memory, nid);
-		} while (--ranges);
-	}
+
+		nid = of_drconf_to_nid_single(lmb);
+		fake_numa_create_new_node(((base + size) >> PAGE_SHIFT),
+					  &nid);
+		node_set_online(nid);
+		sz = numa_enforce_memory_limit(base, size);
+		if (sz)
+			memblock_set_node(base, sz, &memblock.memory, nid);
+	} while (--ranges);
 }
 
 static int __init parse_numa_properties(void)
@@ -815,8 +715,10 @@ static int __init parse_numa_properties(void)
 	 * ibm,dynamic-reconfiguration-memory node.
 	 */
 	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (memory)
-		parse_drconf_memory(memory);
+	if (memory) {
+		walk_drmem_lmbs(memory, numa_setup_drmem_lmb);
+		of_node_put(memory);
+	}
 
 	return 0;
 }
@@ -994,38 +896,26 @@ early_param("topology_updates", early_topology_updates);
  * memory represented in the device tree by the property
  * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory.
  */
-static int hot_add_drconf_scn_to_nid(struct device_node *memory,
-				     unsigned long scn_addr)
+static int hot_add_drconf_scn_to_nid(unsigned long scn_addr)
 {
-	const __be32 *dm;
-	unsigned int drconf_cell_cnt;
+	struct drmem_lmb *lmb;
 	unsigned long lmb_size;
 	int nid = -1;
 
-	drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
-	if (!drconf_cell_cnt)
-		return -1;
-
-	lmb_size = of_get_lmb_size(memory);
-	if (!lmb_size)
-		return -1;
-
-	for (; drconf_cell_cnt != 0; --drconf_cell_cnt) {
-		struct of_drconf_cell drmem;
-
-		read_drconf_cell(&drmem, &dm);
+	lmb_size = drmem_lmb_size();
 
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
 
-		nid = of_drconf_to_nid_single(&drmem);
+		nid = of_drconf_to_nid_single(lmb);
 		break;
 	}
 
@@ -1090,7 +980,7 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 
 	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
 	if (memory) {
-		nid = hot_add_drconf_scn_to_nid(memory, scn_addr);
+		nid = hot_add_drconf_scn_to_nid(scn_addr);
 		of_node_put(memory);
 	} else {
 		nid = hot_add_node_scn_to_nid(scn_addr);
@@ -1106,11 +996,7 @@ static u64 hot_add_drconf_memory_max(void)
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
@@ -1122,14 +1008,8 @@ static u64 hot_add_drconf_memory_max(void)
 
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
