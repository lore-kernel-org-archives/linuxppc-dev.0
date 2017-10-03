Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y67VW32ZbzDqlP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 05:54:11 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v93InOtv071629
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 14:54:08 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dcedrx6cn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Oct 2017 14:54:07 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 3 Oct 2017 14:54:07 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v93Is4mm53805092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 18:54:04 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CF322803D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 14:53:58 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id CFF542803A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 14:53:57 -0400 (EDT)
Subject: [PATCH3/8] powerpc/mm: Separate ibm,
 dynamic-memory data from DT format
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 03 Oct 2017 13:39:53 -0500
In-Reply-To: <150705593139.7318.5934648279979743833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <150705593139.7318.5934648279979743833.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150705599288.7318.16521958695843062503.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently have code to parse the dynamic reconfiguration LMB
information from the ibm,dynamic-meory device tree property in
multiple locations (numa.c, prom.c, and pseries/hotplug-memory.c).
In anticipation of adding support for a version 2 of the
ibm,dynamic-memory property this patch aims to separate the device
tree information from the device tree format.

To do this an array of per-LMB information is created at boot time
and any pieces of code that need to look at LMB information are then
updated to use this array instead of parsing the device tree directly.

Doing this provides several benefits. The device tree property
parsing is located in a single place, it makes walking through the
possible LMBs on a system easier, and provides a common data structure
so that any piece of the kernel needing LMB information does not
have to provide multiple parsing routines for the supported devide
tree formats.

This patch consolidates the device tree parsing into a common
location, builds the LMB array at boot time, and updates the prom
code to use the new LMB array.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/drmem.h |   45 ++++++++++++++
 arch/powerpc/kernel/prom.c       |  126 +++++++++++++++++++-------------------
 arch/powerpc/mm/Makefile         |    2 -
 arch/powerpc/mm/drmem.c          |   84 +++++++++++++++++++++++++
 4 files changed, 194 insertions(+), 63 deletions(-)
 create mode 100644 arch/powerpc/include/asm/drmem.h
 create mode 100644 arch/powerpc/mm/drmem.c

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
new file mode 100644
index 000000000000..cafe1a3b7da6
--- /dev/null
+++ b/arch/powerpc/include/asm/drmem.h
@@ -0,0 +1,45 @@
+/*
+ * drmem.h: Power specific logical memory block representation
+ *
+ * Copyright 2017 IBM Corporation
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
+struct drmem_lmb {
+	u64     base_addr;
+	u32     drc_index;
+	u32     aa_index;
+	u32     flags;
+};
+
+struct drmem_lmb_info {
+	struct drmem_lmb        *lmbs;
+	int                     n_lmbs;
+	u32                     lmb_size;
+};
+
+extern struct drmem_lmb_info *drmem_info;
+
+#define for_each_drmem_lmb_in_range(lmb, start, end)		\
+	for ((lmb) = (start); (lmb) <= (end); (lmb)++)
+
+#define for_each_drmem_lmb(lmb)					\
+	for_each_drmem_lmb_in_range((lmb),			\
+		&drmem_info->lmbs[0],				\
+		&drmem_info->lmbs[drmem_info->n_lmbs - 1])
+
+static inline u32 drmem_lmb_size(void)
+{
+	return drmem_info->lmb_size;
+}
+
+extern int __init init_drmem_lmbs(unsigned long node);
+
+#endif
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f83056297441..a41d6348ef9e 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -58,6 +58,7 @@
 #include <asm/epapr_hcalls.h>
 #include <asm/firmware.h>
 #include <asm/dt_cpu_ftrs.h>
+#include <asm/drmem.h>
 
 #include <mm/mmu_decl.h>
 
@@ -454,80 +455,74 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
 
 #ifdef CONFIG_PPC_PSERIES
 /*
- * Interpret the ibm,dynamic-memory property in the
- * /ibm,dynamic-reconfiguration-memory node.
+ * Interpret the ibm dynamic reconfiguration memory LMBs.
  * This contains a list of memory blocks along with NUMA affinity
  * information.
  */
-static int __init early_init_dt_scan_drconf_memory(unsigned long node)
+
+static void __init add_drmem_lmb(struct drmem_lmb *lmb, const __be32 **usm)
 {
-	const __be32 *dm, *ls, *usm;
-	int l;
-	unsigned long n, flags;
-	u64 base, size, memblock_size;
-	unsigned int is_kexec_kdump = 0, rngs;
+	u64 base, size;
+	int is_kexec_kdump = 0, rngs;
 
-	ls = of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
-	if (ls == NULL || l < dt_root_size_cells * sizeof(__be32))
-		return 0;
-	memblock_size = dt_mem_next_cell(dt_root_size_cells, &ls);
+	base = lmb->base_addr;
+	size = drmem_lmb_size();
+	rngs = 1;
 
-	dm = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &l);
-	if (dm == NULL || l < sizeof(__be32))
-		return 0;
+	if (*usm)
+		is_kexec_kdump = 1;
 
-	n = of_read_number(dm++, 1);	/* number of entries */
-	if (l < (n * (dt_root_addr_cells + 4) + 1) * sizeof(__be32))
-		return 0;
+	if (is_kexec_kdump) {
+		/*
+		 * For each memblock in ibm,dynamic-memory, a
+		 * corresponding entry in linux,drconf-usable-memory
+		 * property contains a counter 'p' followed by 'p'
+		 * (base, size) duple. Now read the counter from
+		 * linux,drconf-usable-memory property
+		 */
+		rngs = dt_mem_next_cell(dt_root_size_cells, usm);
+		if (!rngs) /* there are no (base, size) duple */
+			return;
+	}
+
+	do {
+		if (is_kexec_kdump) {
+			base = dt_mem_next_cell(dt_root_addr_cells, usm);
+			size = dt_mem_next_cell(dt_root_size_cells, usm);
+		}
+
+		if (iommu_is_off) {
+			if (base >= 0x80000000ul)
+				continue;
+			if ((base + size) > 0x80000000ul)
+				size = 0x80000000ul - base;
+		}
+
+		memblock_add(base, size);
+	} while (--rngs);
+}
+
+static void __init early_init_dt_scan_drmem_lmbs(unsigned long node)
+{
+	struct drmem_lmb *lmb;
+	const __be32 *usm;
+	int l;
 
 	/* check if this is a kexec/kdump kernel. */
-	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory",
-						 &l);
-	if (usm != NULL)
-		is_kexec_kdump = 1;
+	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory", &l);
 
-	for (; n != 0; --n) {
-		base = dt_mem_next_cell(dt_root_addr_cells, &dm);
-		flags = of_read_number(&dm[3], 1);
-		/* skip DRC index, pad, assoc. list index, flags */
-		dm += 4;
+	for_each_drmem_lmb(lmb) {
 		/* skip this block if the reserved bit is set in flags
-		   or if the block is not assigned to this partition */
-		if ((flags & DRCONF_MEM_RESERVED) ||
-				!(flags & DRCONF_MEM_ASSIGNED))
+		 * or if the block is not assigned to this partition.
+		 */
+		if ((lmb->flags & DRCONF_MEM_RESERVED) ||
+		    !(lmb->flags & DRCONF_MEM_ASSIGNED))
 			continue;
-		size = memblock_size;
-		rngs = 1;
-		if (is_kexec_kdump) {
-			/*
-			 * For each memblock in ibm,dynamic-memory, a corresponding
-			 * entry in linux,drconf-usable-memory property contains
-			 * a counter 'p' followed by 'p' (base, size) duple.
-			 * Now read the counter from
-			 * linux,drconf-usable-memory property
-			 */
-			rngs = dt_mem_next_cell(dt_root_size_cells, &usm);
-			if (!rngs) /* there are no (base, size) duple */
-				continue;
-		}
-		do {
-			if (is_kexec_kdump) {
-				base = dt_mem_next_cell(dt_root_addr_cells,
-							 &usm);
-				size = dt_mem_next_cell(dt_root_size_cells,
-							 &usm);
-			}
-			if (iommu_is_off) {
-				if (base >= 0x80000000ul)
-					continue;
-				if ((base + size) > 0x80000000ul)
-					size = 0x80000000ul - base;
-			}
-			memblock_add(base, size);
-		} while (--rngs);
+
+		add_drmem_lmb(lmb, &usm);
 	}
+
 	memblock_dump_all();
-	return 0;
 }
 #else
 #define early_init_dt_scan_drconf_memory(node)	0
@@ -537,9 +532,16 @@ static int __init early_init_dt_scan_memory_ppc(unsigned long node,
 						const char *uname,
 						int depth, void *data)
 {
+	int rc;
+
 	if (depth == 1 &&
-	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0)
-		return early_init_dt_scan_drconf_memory(node);
+	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
+		rc = init_drmem_lmbs(node);
+		if (!rc)
+			early_init_dt_scan_drmem_lmbs(node);
+
+		return rc;
+	}
 	
 	return early_init_dt_scan_memory(node, uname, depth, data);
 }
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index fb844d2f266e..8186d5721bfe 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -8,7 +8,7 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
-				   init-common.o mmu_context.o
+				   init-common.o mmu_context.o drmem.o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
new file mode 100644
index 000000000000..8ad7cf36b2c4
--- /dev/null
+++ b/arch/powerpc/mm/drmem.c
@@ -0,0 +1,84 @@
+/*
+ * Dynamic reconfiguration memory support
+ *
+ * Copyright 2017 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) "drmem: " fmt
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/bootmem.h>
+#include <asm/prom.h>
+#include <asm/drmem.h>
+
+static struct drmem_lmb_info __drmem_info;
+struct drmem_lmb_info *drmem_info = &__drmem_info;
+
+int __init init_drmem_lmbs(unsigned long node)
+{
+	struct drmem_lmb *lmb;
+	const __be32 *prop;
+	int prop_sz;
+	u32 len;
+
+	prop = of_get_flat_dt_prop(node, "ibm,lmb-size", &len);
+	if (!prop || len < dt_root_size_cells * sizeof(__be32))
+		return -1;
+
+	drmem_info->lmb_size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+	prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &len);
+	if (!prop || len < dt_root_size_cells * sizeof(__be32))
+		return -1;
+
+	drmem_info->n_lmbs = of_read_number(prop++, 1);
+	prop_sz = drmem_info->n_lmbs * sizeof(struct of_drconf_cell)
+		  + sizeof(__be32);
+	if (prop_sz < len)
+		return -1;
+
+	drmem_info->lmbs = alloc_bootmem(drmem_info->n_lmbs * sizeof(*lmb));
+	if (!drmem_info->lmbs)
+		return -1;
+
+	for_each_drmem_lmb(lmb) {
+		lmb->base_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		lmb->drc_index = of_read_number(prop++, 1);
+
+		prop++; /* skip reserved field */
+
+		lmb->aa_index = of_read_number(prop++, 1);
+		lmb->flags = of_read_number(prop++, 1);
+	}
+
+	return 0;
+}
+
+static int __init drmem_init(void)
+{
+	struct drmem_lmb *lmbs;
+	u32 lmbs_sz;
+
+	if (drmem_info->lmbs) {
+		lmbs_sz = drmem_info->n_lmbs * sizeof(*lmbs);
+		lmbs = kcalloc(drmem_info->n_lmbs, sizeof(*lmbs), GFP_KERNEL);
+
+		if (lmbs) {
+			memcpy(lmbs, drmem_info->lmbs, lmbs_sz);
+			free_bootmem(__pa(drmem_info->lmbs), lmbs_sz);
+			drmem_info->lmbs = lmbs;
+		}
+	}
+
+	return 0;
+}
+
+late_initcall(drmem_init);
+
