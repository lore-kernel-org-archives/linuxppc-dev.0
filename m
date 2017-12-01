Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypLDT6kYwzDsPY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 04:02:33 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1Gs0m1113799
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 12:02:32 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ek8wgqgrc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 12:02:31 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 1 Dec 2017 12:02:30 -0500
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vB1H2Sjj39125102
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 17:02:29 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62934AC040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:03:27 -0500 (EST)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id 3B626AC055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 12:03:27 -0500 (EST)
Subject: [PATCH V3 4/9] powerpc/mm: Separate ibm,
 dynamic-memory data from DT format
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 01 Dec 2017 10:47:08 -0600
In-Reply-To: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151214682046.64022.2440958479061972.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
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
multiple locations; numa.c, prom.c, and pseries/hotplug-memory.c.
In anticipation of adding support for a version 2 of the
ibm,dynamic-memory property this patch aims to separate the device
tree information from the device tree format.

Doing this requires a two step process to avoid a possibly very large
bootmem allocation early in boot. During initial boot, new routines
are provided to walk the device tree property and make a call-back
for each LMB.

The second step (introduced in later patches) will allocate an
array of LMB information that can be used directly without needing
to know the DT format.

This approach provides the benefit of consolidating the device tree
property parsing to a single location and (eventually) providing
a common data structure for retrieving LMB information.

This patch introduces a routine to walk the ibm,dynamic-memory
property in the flattened device tree and updates the prom.c code
to use this to initialize memory.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---

Updates for V3: Converted from doing a bootmem allocation early in
boot for the LMB array to providing a routine to walk the memory
property and provide a callback for each LMB.

Updates for V2: Correct build break for non-pseries builds.

 arch/powerpc/include/asm/drmem.h |   48 ++++++++++++++++
 arch/powerpc/kernel/prom.c       |  114 ++++++++++++++++----------------------
 arch/powerpc/mm/Makefile         |    2 -
 arch/powerpc/mm/drmem.c          |   76 +++++++++++++++++++++++++
 4 files changed, 173 insertions(+), 67 deletions(-)
 create mode 100644 arch/powerpc/include/asm/drmem.h
 create mode 100644 arch/powerpc/mm/drmem.c

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
new file mode 100644
index 000000000000..c7fc5c4d8a7c
--- /dev/null
+++ b/arch/powerpc/include/asm/drmem.h
@@ -0,0 +1,48 @@
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
+#ifdef CONFIG_PPC_PSERIES
+void __init walk_drmem_lmbs_early(unsigned long node,
+			void (*func)(struct drmem_lmb *, const __be32 **));
+#endif
+#endif
+
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index b15bae265c90..b800f1acc4fc 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -59,6 +59,7 @@
 #include <asm/epapr_hcalls.h>
 #include <asm/firmware.h>
 #include <asm/dt_cpu_ftrs.h>
+#include <asm/drmem.h>
 
 #include <mm/mmu_decl.h>
 
@@ -455,92 +456,73 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
 
 #ifdef CONFIG_PPC_PSERIES
 /*
- * Interpret the ibm,dynamic-memory property in the
- * /ibm,dynamic-reconfiguration-memory node.
+ * Interpret the ibm dynamic reconfiguration memory LMBs.
  * This contains a list of memory blocks along with NUMA affinity
  * information.
  */
-static int __init early_init_dt_scan_drconf_memory(unsigned long node)
+static void __init early_init_drmem_lmb(struct drmem_lmb *lmb,
+					const __be32 **usm)
 {
-	const __be32 *dm, *ls, *usm;
-	int l;
-	unsigned long n, flags;
-	u64 base, size, memblock_size;
-	unsigned int is_kexec_kdump = 0, rngs;
-
-	ls = of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
-	if (ls == NULL || l < dt_root_size_cells * sizeof(__be32))
-		return 0;
-	memblock_size = dt_mem_next_cell(dt_root_size_cells, &ls);
+	u64 base, size;
+	int is_kexec_kdump = 0, rngs;
 
-	dm = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &l);
-	if (dm == NULL || l < sizeof(__be32))
-		return 0;
+	base = lmb->base_addr;
+	size = drmem_lmb_size();
+	rngs = 1;
 
-	n = of_read_number(dm++, 1);	/* number of entries */
-	if (l < (n * (dt_root_addr_cells + 4) + 1) * sizeof(__be32))
-		return 0;
+	/* skip this block if the reserved bit is set in flags
+	 * or if the block is not assigned to this partition.
+	 */
+	if ((lmb->flags & DRCONF_MEM_RESERVED) ||
+	    !(lmb->flags & DRCONF_MEM_ASSIGNED))
+		return;
 
-	/* check if this is a kexec/kdump kernel. */
-	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory",
-						 &l);
-	if (usm != NULL)
+	if (*usm)
 		is_kexec_kdump = 1;
 
-	for (; n != 0; --n) {
-		base = dt_mem_next_cell(dt_root_addr_cells, &dm);
-		flags = of_read_number(&dm[3], 1);
-		/* skip DRC index, pad, assoc. list index, flags */
-		dm += 4;
-		/* skip this block if the reserved bit is set in flags
-		   or if the block is not assigned to this partition */
-		if ((flags & DRCONF_MEM_RESERVED) ||
-				!(flags & DRCONF_MEM_ASSIGNED))
-			continue;
-		size = memblock_size;
-		rngs = 1;
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
 		if (is_kexec_kdump) {
-			/*
-			 * For each memblock in ibm,dynamic-memory, a corresponding
-			 * entry in linux,drconf-usable-memory property contains
-			 * a counter 'p' followed by 'p' (base, size) duple.
-			 * Now read the counter from
-			 * linux,drconf-usable-memory property
-			 */
-			rngs = dt_mem_next_cell(dt_root_size_cells, &usm);
-			if (!rngs) /* there are no (base, size) duple */
+			base = dt_mem_next_cell(dt_root_addr_cells, usm);
+			size = dt_mem_next_cell(dt_root_size_cells, usm);
+		}
+
+		if (iommu_is_off) {
+			if (base >= 0x80000000ul)
 				continue;
+			if ((base + size) > 0x80000000ul)
+				size = 0x80000000ul - base;
 		}
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
-	}
-	memblock_dump_all();
-	return 0;
+
+		DBG("Adding: %llx -> %llx\n", base, size);
+		memblock_add(base, size);
+	} while (--rngs);
 }
-#else
-#define early_init_dt_scan_drconf_memory(node)	0
 #endif /* CONFIG_PPC_PSERIES */
 
 static int __init early_init_dt_scan_memory_ppc(unsigned long node,
 						const char *uname,
 						int depth, void *data)
 {
+#ifdef CONFIG_PPC_PSERIES
 	if (depth == 1 &&
-	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0)
-		return early_init_dt_scan_drconf_memory(node);
+	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
+		walk_drmem_lmbs_early(node, early_init_drmem_lmb);
+		return 0;
+	}
+#endif
 	
 	return early_init_dt_scan_memory(node, uname, depth, data);
 }
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 76a6b057d454..8d271bfe2d94 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -9,7 +9,7 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
-				   init-common.o mmu_context.o
+				   init-common.o mmu_context.o drmem.o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
new file mode 100644
index 000000000000..f8ee0f355405
--- /dev/null
+++ b/arch/powerpc/mm/drmem.c
@@ -0,0 +1,76 @@
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
+#include <linux/memblock.h>
+#include <asm/prom.h>
+#include <asm/drmem.h>
+
+static struct drmem_lmb_info __drmem_info;
+struct drmem_lmb_info *drmem_info = &__drmem_info;
+
+#ifdef CONFIG_PPC_PSERIES
+static void __init read_drconf_v1_cell(struct drmem_lmb *lmb,
+				       const __be32 **prop)
+{
+	const __be32 *p = *prop;
+
+	lmb->base_addr = dt_mem_next_cell(dt_root_addr_cells, &p);
+	lmb->drc_index = of_read_number(p++, 1);
+
+	p++; /* skip reserved field */
+
+	lmb->aa_index = of_read_number(p++, 1);
+	lmb->flags = of_read_number(p++, 1);
+
+	*prop = p;
+}
+
+static void __init __walk_drmem_v1_lmbs(const __be32 *prop, const __be32 *usm,
+			void (*func)(struct drmem_lmb *, const __be32 **))
+{
+	struct drmem_lmb lmb;
+	u32 i, n_lmbs;
+
+	n_lmbs = of_read_number(prop++, 1);
+
+	for (i = 0; i < n_lmbs; i++) {
+		read_drconf_v1_cell(&lmb, &prop);
+		func(&lmb, &usm);
+	}
+}
+
+void __init walk_drmem_lmbs_early(unsigned long node,
+			void (*func)(struct drmem_lmb *, const __be32 **))
+{
+	const __be32 *prop, *usm;
+	int len;
+
+	prop = of_get_flat_dt_prop(node, "ibm,lmb-size", &len);
+	if (!prop || len < dt_root_size_cells * sizeof(__be32))
+		return;
+
+	drmem_info->lmb_size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory", &len);
+
+	prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &len);
+	if (prop)
+		__walk_drmem_v1_lmbs(prop, usm, func);
+
+	memblock_dump_all();
+}
+
+#endif
