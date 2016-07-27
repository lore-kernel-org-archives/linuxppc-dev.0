Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxzf6PRszDrZ3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:23:10 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6REJQbe077083
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:08 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24e1btpnv1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:08 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 27 Jul 2016 10:23:07 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E9D17C90042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:22:54 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6REN75R38011088
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 14:23:07 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA17FAE054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:04 -0400 (EDT)
Received: from oc1376853207.ibm.com (unknown [9.77.146.137])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 87B81AE056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:04 -0400 (EDT)
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V2 2/8] powerpc/memory: Parse new memory property to register
 blocks.
Date: Wed, 27 Jul 2016 09:23:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <f77ccfa8-ade6-c0c4-ab3f-8dc3a80ed099@linux.vnet.ibm.com>
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
register the relevant memory blocks with the operating system.
This property format is intended to provide a more compact
representation of memory when communicating with the front end
processor, especially when describing vast amounts of RAM.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 7f436ba..b9a1534 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -69,6 +69,8 @@ struct boot_param_header {
  * OF address retreival & translation
  */
 
+extern int n_mem_addr_cells;
+
 /* Parse the ibm,dma-window property of an OF node into the busno, phys and
  * size parameters.
  */
@@ -81,8 +83,9 @@ extern void of_instantiate_rtc(void);
 extern int of_get_ibm_chip_id(struct device_node *np);
 
 /* The of_drconf_cell struct defines the layout of the LMB array
- * specified in the device tree property
- * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
+ * specified in the device tree properties,
+ *     ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
+ *     ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory-v2
  */
 struct of_drconf_cell {
 	u64	base_addr;
@@ -92,9 +95,32 @@ struct of_drconf_cell {
 	u32	flags;
 };
 
-#define DRCONF_MEM_ASSIGNED	0x00000008
-#define DRCONF_MEM_AI_INVALID	0x00000040
-#define DRCONF_MEM_RESERVED	0x00000080
+#define DRCONF_MEM_ASSIGNED		0x00000008
+#define DRCONF_MEM_AI_INVALID		0x00000040
+#define DRCONF_MEM_RESERVED		0x00000080
+
+struct of_drconf_cell_v2 {
+	u32	num_seq_lmbs;
+	u64	base_addr;
+	u32	drc_index;
+	u32	aa_index;
+	u32	flags;
+} __attribute__((packed));
+
+
+static inline int dyn_mem_v2_len(int entries)
+{
+	int drconf_v2_cells = (n_mem_addr_cells + 4);
+	int drconf_v2_cells_len = (drconf_v2_cells * sizeof(unsigned int));
+	return (((entries) * drconf_v2_cells_len) +
+                (1 * sizeof(unsigned int)));
+}
+
+extern void read_drconf_cell_v2(struct of_drconf_cell_v2 *drmem,
+				const __be32 **cellp);
+extern void read_one_drc_info(int **info, char **drc_type, char **drc_name,
+			unsigned long int *fdi_p, unsigned long int *nsl_p,
+			unsigned long int *si_p, unsigned long int *ldi_p);
 
 /*
  * There are two methods for telling firmware what our capabilities are.
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 669a15e..ad294ce 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -57,8 +57,10 @@
 EXPORT_SYMBOL(node_data);
 
 static int min_common_depth;
-static int n_mem_addr_cells, n_mem_size_cells;
+int n_mem_addr_cells;
+static int n_mem_size_cells;
 static int form1_affinity;
+EXPORT_SYMBOL(n_mem_addr_cells);
 
 #define MAX_DISTANCE_REF_POINTS 4
 static int distance_ref_points_depth;
@@ -405,6 +405,24 @@ static void read_drconf_cell(struct of_drconf_cell *drmem, const __be32 **cellp)
 
 	*cellp = cp + 4;
 }
+ 
+ /*
+ * Retrieve and validate the ibm,dynamic-memory property of the device tree.
+ * Read the next memory block set entry from the ibm,dynamic-memory-v2 property
+ * and return the information in the provided of_drconf_cell_v2 structure.
+ */
+void read_drconf_cell_v2(struct of_drconf_cell_v2 *drmem, const __be32 **cellp)
+{
+	const __be32 *cp = (const __be32 *)*cellp;
+	drmem->num_seq_lmbs = be32_to_cpu(*cp++);
+	drmem->base_addr = read_n_cells(n_mem_addr_cells, &cp);
+	drmem->drc_index = be32_to_cpu(*cp++);
+	drmem->aa_index = be32_to_cpu(*cp++);
+	drmem->flags = be32_to_cpu(*cp++);
+
+	*cellp = cp;
+}
+EXPORT_SYMBOL(read_drconf_cell_v2);
 
 /*
  * Retrieve and validate the ibm,dynamic-memory property of the device tree.
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 946e34f..a55bc1e 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -56,6 +56,7 @@
 #include <asm/opal.h>
 #include <asm/fadump.h>
 #include <asm/debug.h>
+#include <asm/firmware.h>
 
 #include <mm/mmu_decl.h>
 
@@ -441,12 +442,12 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
 
 #ifdef CONFIG_PPC_PSERIES
 /*
- * Interpret the ibm,dynamic-memory property in the
- * /ibm,dynamic-reconfiguration-memory node.
+ * Interpret the ibm,dynamic-memory property/ibm,dynamic-memory-v2
+ * in the /ibm,dynamic-reconfiguration-memory node.
  * This contains a list of memory blocks along with NUMA affinity
  * information.
  */
-static int __init early_init_dt_scan_drconf_memory(unsigned long node)
+static int __init early_init_dt_scan_drconf_memory_v1(unsigned long node)
 {
 	const __be32 *dm, *ls, *usm;
 	int l;
@@ -516,6 +517,105 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 	memblock_dump_all();
 	return 0;
 }
+
+static int __init early_init_dt_scan_drconf_memory_v2(unsigned long node)
+{
+	const __be32 *dm, *ls, *usm;
+	int l;
+	unsigned long num_sets;
+	u64 size, base, memblock_size;
+	unsigned int is_kexec_kdump = 0, rngs;
+
+	ls = of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
+	if (ls == NULL || l < dt_root_size_cells * sizeof(__be32))
+		return 0;
+	memblock_size = dt_mem_next_cell(dt_root_size_cells, &ls);
+
+	dm = of_get_flat_dt_prop(node, "ibm,dynamic-memory-v2", &l);
+	if (dm == NULL || l < sizeof(__be32))
+		return 0;
+
+	num_sets = of_read_number(dm++, 1);
+	if (l < (num_sets * (dt_root_addr_cells + 4) + 1) * sizeof(__be32))
+		return 0;
+
+	/* check if this is a kexec/kdump kernel. */
+	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory", &l);
+	if (usm != NULL)
+		is_kexec_kdump = 1;
+
+	if (n_mem_addr_cells == 0)
+		n_mem_addr_cells = dt_root_addr_cells;
+
+	for (; num_sets != 0; --num_sets) {
+		struct of_drconf_cell_v2 drmem;
+		unsigned long nsl;
+
+		read_drconf_cell_v2(&drmem, &dm);
+		base = drmem.base_addr;
+		nsl = drmem.num_seq_lmbs;
+		size = memblock_size;
+
+		/* SKip this block if the reserved bit is set in flags
+		 * or if the block is not assigned to this partition
+		 */
+		if ((drmem.flags & DRCONF_MEM_RESERVED) ||
+		    !(drmem.flags & DRCONF_MEM_ASSIGNED))
+			continue;
+
+		for (; nsl != 0; nsl--) {
+			size = memblock_size;
+			rngs = 1;
+			if (is_kexec_kdump)
+				/*
+				 * For each memblock in ibm,dynamic-memory,
+				 * a corresponding entry in
+				 * linux,drconf-usable-memory property
+				 * contains a counter 'p' followed by 'p'
+				 * (base, size) duple.  Now read the counter
+				 * from linux,drconf-usable-memory property
+				 */
+				rngs = dt_mem_next_cell(dt_root_size_cells,
+							&usm);
+
+			if (rngs) {
+				do {
+					if (is_kexec_kdump) {
+						base = dt_mem_next_cell(
+							dt_root_addr_cells,
+							&usm);
+						size = dt_mem_next_cell(
+							dt_root_size_cells,
+							&usm);
+					}
+					if (iommu_is_off) {
+						if (base >= 0x80000000ul)
+							continue;
+						if ((base + size) >
+								0x80000000ul)
+							size = 0x80000000ul -
+								base;
+					}
+					memblock_add(base, size);
+				} while (--rngs);
+			}
+
+			base += size;
+		}
+	}
+
+	memblock_dump_all();
+	return 0;
+}
+
+static int __init early_init_dt_scan_drconf_memory(unsigned long node)
+{
+	if (firmware_has_feature(FW_FEATURE_DYN_MEM_V2))
+		return early_init_dt_scan_drconf_memory_v2(node);
+	else
+		return early_init_dt_scan_drconf_memory_v1(node);
+}
+
 #else
 #define early_init_dt_scan_drconf_memory(node)	0
 #endif /* CONFIG_PPC_PSERIES */
