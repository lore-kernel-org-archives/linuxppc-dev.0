Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLr1k74H3zDsSc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 06:01:30 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6VJx4bW174367
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 16:01:29 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c26dsx9pv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 16:01:28 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 31 Jul 2017 16:01:28 -0400
Subject: [RFC PATCH 3/3] powerpc/mm: Separate LMB information from device
 tree format
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: jallen@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com
Date: Mon, 31 Jul 2017 15:48:27 -0400
In-Reply-To: <20170731193259.8956.18833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20170731193259.8956.18833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20170731194827.8956.63916.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the upcoming introduction of a new device tree property format
for memory (ibm,dynamic-memory-v2), we should separate the data for
the LMBs on a system from the device tree format used to represent
them. Witout doing this we face the task of having to update each
piece of the kernel that wants LMB information to know how
to parse all possible device tree formats.

This patch solves this by creating an array LMB information at boot
time. This array will hold all relevant information poresented in
the device tree for each LMB; base address, drc index, associativity
array index, and flags.

Any need to get LMB information can now use the array to get LMB
information directly without having to determine which version of
the device tree format is in use and know how to parse each one.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/lmb.h |   44 ++++++++++
 arch/powerpc/mm/Makefile       |    2 
 arch/powerpc/mm/lmb.c          |  146 ++++++++++++++++++++++++++++++++
 arch/powerpc/mm/numa.c         |  181 +++++++---------------------------------
 4 files changed, 221 insertions(+), 152 deletions(-)
 create mode 100644 arch/powerpc/include/asm/lmb.h
 create mode 100644 arch/powerpc/mm/lmb.c

diff --git a/arch/powerpc/include/asm/lmb.h b/arch/powerpc/include/asm/lmb.h
new file mode 100644
index 0000000..7ff2fa6
--- /dev/null
+++ b/arch/powerpc/include/asm/lmb.h
@@ -0,0 +1,44 @@
+/*
+ * lmb.h: Power specific logical memory block representation
+ *
+ * ** Add (C) **
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_POWERPC_LMB_H
+#define _ASM_POWERPC_LMB_H
+
+extern struct lmb_data *lmb_array;
+extern int n_mem_addr_cells, n_mem_size_cells;
+
+struct lmb {
+	u64	base_address;
+	u32	drc_index;
+	u32	aa_index;
+	u32	flags;
+};
+
+struct lmb_data {
+	struct lmb	*lmbs;
+	int		num_lmbs;
+	u32		lmb_size;
+};
+
+extern struct lmb_data *lmb_array;
+
+#define for_each_lmb(_lmb)					\
+	for (_lmb = &lmb_array->lmbs[0];			\
+	     _lmb != &lmb_array->lmbs[lmb_array->num_lmbs];	\
+	     _lmb++)
+
+extern int lmb_init(void);
+extern u32 lmb_get_lmb_size(void);
+extern u64 lmb_get_max_memory(void);
+extern unsigned long read_n_cells(int n, const __be32 **buf);
+extern void get_n_mem_cells(int *n_addr_cells, int *n_size_cells);
+
+#endif
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 7414034..56c2591 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_40x)		+= 40x_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx_mmu.o
 obj-$(CONFIG_PPC_FSL_BOOK3E)	+= fsl_booke_mmu.o
-obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
+obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o lmb.o
 obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-y				+= hugetlbpage.o
diff --git a/arch/powerpc/mm/lmb.c b/arch/powerpc/mm/lmb.c
new file mode 100644
index 0000000..e12e5be
--- /dev/null
+++ b/arch/powerpc/mm/lmb.c
@@ -0,0 +1,146 @@
+/*
+ * pSeries LMB support
+ *
+ * ** Add (C)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) "lmb: " fmt
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/bootmem.h>
+#include <asm/prom.h>
+#include <asm/lmb.h>
+
+struct lmb_data __lmb_data;
+struct lmb_data *lmb_array = &__lmb_data;
+int n_mem_addr_cells, n_mem_size_cells;
+
+unsigned long read_n_cells(int n, const __be32 **buf)
+{
+	unsigned long result = 0;
+
+	while (n--) {
+		result = (result << 32) | of_read_number(*buf, 1);
+		(*buf)++;
+	}
+	return result;
+}
+
+void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
+{
+	struct device_node *memory = NULL;
+
+	memory = of_find_node_by_type(memory, "memory");
+	if (!memory)
+		panic("numa.c: No memory nodes found!");
+
+	*n_addr_cells = of_n_addr_cells(memory);
+	*n_size_cells = of_n_size_cells(memory);
+	of_node_put(memory);
+}
+
+u32 lmb_get_lmb_size(void)
+{
+	return lmb_array->lmb_size;
+}
+
+u64 lmb_get_max_memory(void)
+{
+	u32 last_index = lmb_array->num_lmbs - 1;
+
+	return lmb_array->lmbs[last_index].base_address + lmb_array->lmb_size;
+}
+
+/*
+ * Retrieve and validate the ibm,dynamic-memory property of the device tree.
+ *
+ * The layout of the ibm,dynamic-memory property is a number N of memblock
+ * list entries followed by N memblock list entries.  Each memblock list entry
+ * contains information as laid out in the of_drconf_cell struct above.
+ */
+static int of_get_drconf_memory(struct device_node *memory, const __be32 **dm)
+{
+	const __be32 *prop;
+	u32 len, entries;
+
+	prop = of_get_property(memory, "ibm,dynamic-memory", &len);
+	if (!prop || len < sizeof(unsigned int))
+		return 0;
+
+	entries = of_read_number(prop++, 1);
+
+	/* Now that we know the number of entries, revalidate the size
+	 * of the property read in to ensure we have everything
+	 */
+	if (len < (entries * (n_mem_addr_cells + 4) + 1) * sizeof(unsigned int))
+		return 0;
+
+	*dm = prop;
+	return entries;
+}
+
+static int lmb_init_drconf_memory_v1(struct device_node *memory)
+{
+	const __be32 *dm;
+	struct lmb *lmb;
+	size_t lmb_array_sz;
+
+	lmb_array->num_lmbs = of_get_drconf_memory(memory, &dm);
+	if (!lmb_array->num_lmbs)
+		return -1;
+
+	lmb_array_sz = lmb_array->num_lmbs * sizeof(*lmb);
+	lmb_array->lmbs = alloc_bootmem(lmb_array_sz);
+	if (!lmb_array->lmbs) {
+		pr_err("lmb array allocation failed\n");
+		return -1;
+	}
+
+	for_each_lmb(lmb) {
+		lmb->base_address = read_n_cells(n_mem_addr_cells, &dm);
+		lmb->drc_index = of_read_number(dm++, 1);
+
+		/* skip past the reserved field */
+		dm++;
+
+		lmb->aa_index = of_read_number(dm++, 1);
+		lmb->flags = of_read_number(dm++, 1);
+
+		pr_err("Init %llx, %x\n", lmb->base_address, lmb->drc_index);
+	}
+
+	return 0;
+}
+
+int lmb_init(void)
+{
+	const __be32 *prop;
+	struct device_node *memory;
+	int len;
+	int rc = -1;
+
+	pr_err("get mem node\n");
+	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (memory)
+		rc = lmb_init_drconf_memory_v1(memory);
+
+	if (rc) {
+		of_node_put(memory);
+		return rc;
+	}
+
+	prop = of_get_property(memory, "ibm,lmb-size", &len);
+	if (prop)
+		lmb_array->lmb_size = read_n_cells(n_mem_size_cells, &prop);
+
+	of_node_put(memory);
+	return 0;
+}
+
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 24d9299..61415f0 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -40,6 +40,7 @@
 #include <asm/hvcall.h>
 #include <asm/setup.h>
 #include <asm/vdso.h>
+#include <asm/lmb.h>
 
 static int numa_enabled = 1;
 
@@ -57,7 +58,6 @@
 EXPORT_SYMBOL(node_data);
 
 static int min_common_depth;
-static int n_mem_addr_cells, n_mem_size_cells;
 static int form1_affinity;
 
 #define MAX_DISTANCE_REF_POINTS 4
@@ -371,93 +371,6 @@ static int __init find_min_common_depth(void)
 	return -1;
 }
 
-static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
-{
-	struct device_node *memory = NULL;
-
-	memory = of_find_node_by_type(memory, "memory");
-	if (!memory)
-		panic("numa.c: No memory nodes found!");
-
-	*n_addr_cells = of_n_addr_cells(memory);
-	*n_size_cells = of_n_size_cells(memory);
-	of_node_put(memory);
-}
-
-static unsigned long read_n_cells(int n, const __be32 **buf)
-{
-	unsigned long result = 0;
-
-	while (n--) {
-		result = (result << 32) | of_read_number(*buf, 1);
-		(*buf)++;
-	}
-	return result;
-}
-
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
@@ -509,7 +422,7 @@ static int of_get_assoc_arrays(struct assoc_arrays *aa)
  * This is like of_node_to_nid_single() for memory represented in the
  * ibm,dynamic-reconfiguration-memory node.
  */
-static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
+static int of_drconf_to_nid_single(struct lmb *lmb,
 				   struct assoc_arrays *aa)
 {
 	int default_nid = 0;
@@ -517,16 +430,16 @@ static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
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
@@ -658,22 +571,18 @@ static inline int __init read_usm_ranges(const __be32 **usm)
 }
 
 /*
- * Extract NUMA information from the ibm,dynamic-reconfiguration-memory
- * node.  This assumes n_mem_{addr,size}_cells have been set.
+ * Extract NUMA information from the lmb array.
  */
-static void __init parse_drconf_memory(struct device_node *memory)
+static void __init parse_lmb_memory(void)
 {
+	struct lmb *lmb;
 	const __be32 *uninitialized_var(dm), *usm;
-	unsigned int n, rc, ranges, is_kexec_kdump = 0;
+	unsigned int rc, ranges, is_kexec_kdump = 0;
 	unsigned long lmb_size, base, size, sz;
 	int nid;
 	struct assoc_arrays aa = { .arrays = NULL };
 
-	n = of_get_drconf_memory(memory, &dm);
-	if (!n)
-		return;
-
-	lmb_size = of_get_lmb_size(memory);
+	lmb_size = lmb_get_lmb_size();
 	if (!lmb_size)
 		return;
 
@@ -686,18 +595,14 @@ static void __init parse_drconf_memory(struct device_node *memory)
 	if (usm != NULL)
 		is_kexec_kdump = 1;
 
-	for (; n != 0; --n) {
-		struct of_drconf_cell drmem;
-
-		read_drconf_cell(&drmem, &dm);
-
+	for_each_lmb(lmb) {
 		/* skip this block if the reserved bit is set in flags (0x80)
 		   or if the block is not assigned to this partition (0x8) */
-		if ((drmem.flags & DRCONF_MEM_RESERVED)
-		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
+		if ((lmb->flags & DRCONF_MEM_RESERVED)
+		    || !(lmb->flags & DRCONF_MEM_ASSIGNED))
 			continue;
 
-		base = drmem.base_addr;
+		base = lmb->base_address;
 		size = lmb_size;
 		ranges = 1;
 
@@ -711,7 +616,7 @@ static void __init parse_drconf_memory(struct device_node *memory)
 				base = read_n_cells(n_mem_addr_cells, &usm);
 				size = read_n_cells(n_mem_size_cells, &usm);
 			}
-			nid = of_drconf_to_nid_single(&drmem, &aa);
+			nid = of_drconf_to_nid_single(lmb, &aa);
 			fake_numa_create_new_node(
 				((base + size) >> PAGE_SHIFT),
 					   &nid);
@@ -815,9 +720,8 @@ static int __init parse_numa_properties(void)
 	 * ibm,dynamic-memory property in the
 	 * ibm,dynamic-reconfiguration-memory node.
 	 */
-	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (memory)
-		parse_drconf_memory(memory);
+	lmb_init();
+	parse_lmb_memory();
 
 	return 0;
 }
@@ -995,20 +899,15 @@ static int __init early_topology_updates(char *p)
  * memory represented in the device tree by the property
  * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory.
  */
-static int hot_add_drconf_scn_to_nid(struct device_node *memory,
-				     unsigned long scn_addr)
+static int hot_add_drconf_scn_to_nid(unsigned long scn_addr)
 {
-	const __be32 *dm;
-	unsigned int drconf_cell_cnt, rc;
+	struct lmb *lmb;
 	unsigned long lmb_size;
 	struct assoc_arrays aa;
+	int rc;
 	int nid = -1;
 
-	drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
-	if (!drconf_cell_cnt)
-		return -1;
-
-	lmb_size = of_get_lmb_size(memory);
+	lmb_size = lmb_get_lmb_size();
 	if (!lmb_size)
 		return -1;
 
@@ -1016,22 +915,18 @@ static int hot_add_drconf_scn_to_nid(struct device_node *memory,
 	if (rc)
 		return -1;
 
-	for (; drconf_cell_cnt != 0; --drconf_cell_cnt) {
-		struct of_drconf_cell drmem;
-
-		read_drconf_cell(&drmem, &dm);
-
+	for_each_lmb(lmb) {
 		/* skip this block if it is reserved or not assigned to
 		 * this partition */
-		if ((drmem.flags & DRCONF_MEM_RESERVED)
-		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
+		if ((lmb->flags & DRCONF_MEM_RESERVED)
+		    || !(lmb->flags & DRCONF_MEM_ASSIGNED))
 			continue;
 
-		if ((scn_addr < drmem.base_addr)
-		    || (scn_addr >= (drmem.base_addr + lmb_size)))
+		if ((scn_addr < lmb->base_address)
+		    || (scn_addr >= (lmb->base_address + lmb_size)))
 			continue;
 
-		nid = of_drconf_to_nid_single(&drmem, &aa);
+		nid = of_drconf_to_nid_single(lmb, &aa);
 		break;
 	}
 
@@ -1096,7 +991,7 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 
 	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
 	if (memory) {
-		nid = hot_add_drconf_scn_to_nid(memory, scn_addr);
+		nid = hot_add_drconf_scn_to_nid(scn_addr);
 		of_node_put(memory);
 	} else {
 		nid = hot_add_node_scn_to_nid(scn_addr);
@@ -1110,13 +1005,8 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 
 static u64 hot_add_drconf_memory_max(void)
 {
-	struct device_node *memory = NULL;
 	struct device_node *dn = NULL;
-	unsigned int drconf_cell_cnt = 0;
-	u64 lmb_size = 0;
-	const __be32 *dm = NULL;
 	const __be64 *lrdr = NULL;
-	struct of_drconf_cell drmem;
 
 	dn = of_find_node_by_path("/rtas");
 	if (dn) {
@@ -1126,18 +1016,7 @@ static u64 hot_add_drconf_memory_max(void)
 			return be64_to_cpup(lrdr);
 	}
 
-	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (memory) {
-		drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
-		lmb_size = of_get_lmb_size(memory);
-
-		/* Advance to the last cell, each cell has 6 32 bit integers */
-		dm += (drconf_cell_cnt - 1) * 6;
-		read_drconf_cell(&drmem, &dm);
-		of_node_put(memory);
-		return drmem.base_addr + lmb_size;
-	}
-	return 0;
+	return lmb_get_max_memory();
 }
 
 /*
