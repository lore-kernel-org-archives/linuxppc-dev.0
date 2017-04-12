Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3CM56NVVzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 04:37:05 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CIa5Ck013832
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 14:36:55 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sq2h7s34-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 14:36:54 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 14:36:53 -0400
Subject: [PATCH 2/5] powerpc/memory: Parse new memory property to register
 blocks.
Subject: [PATCH 2/5] powerpc/memory: Parse new memory property to register
 blocks.
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: ltc-virtual-io@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com
Date: Wed, 12 Apr 2017 13:36:51 -0500
In-Reply-To: <149202212688.38498.11025778802721939795.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <149202212688.38498.11025778802721939795.stgit@powerkvm6.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149202220663.38498.16058798191355447457.stgit@powerkvm6.aus.stglabs.ibm.com>
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
 arch/powerpc/include/asm/firmware.h       |    4 +
 arch/powerpc/include/asm/prom.h           |   25 +++++-
 arch/powerpc/kernel/prom.c                |  125 ++++++++++++++++++++++++-----
 arch/powerpc/mm/numa.c                    |   20 ++++-
 arch/powerpc/platforms/pseries/firmware.c |    1 
 5 files changed, 146 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 329d537..062e5f5 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -52,6 +52,7 @@
 #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
 #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
 #define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000400000000)
+#define FW_FEATURE_DYN_MEM_V2	ASM_CONST(0x0000000800000000)
 
 #ifndef __ASSEMBLY__
 
@@ -68,7 +69,8 @@ enum {
 		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
-		FW_FEATURE_HPT_RESIZE | FW_FEATURE_DRC_INFO,
+		FW_FEATURE_HPT_RESIZE | FW_FEATURE_DRC_INFO |
+		FW_FEATURE_DYN_MEM_V2,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index d469d7c..77d76d8 100644
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
@@ -81,8 +83,9 @@ void of_parse_dma_window(struct device_node *dn, const __be32 *dma_window,
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
@@ -92,9 +95,20 @@ struct of_drconf_cell {
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
+extern void read_drconf_cell_v2(struct of_drconf_cell_v2 *drmem,
+				const __be32 **cellp);
 
 extern int of_one_drc_info(struct property **prop, void **curval,
 			char **dtype, char **dname,
@@ -180,6 +194,7 @@ extern int of_one_drc_info(struct property **prop, void **curval,
 /* Radix Table Extensions */
 #define OV5_RADIX_GTSE		0x1A40	/* Guest Translation Shoot Down Avail */
 #define OV5_DRC_INFO		0x1640	/* Redef Prop Structures: drc-info   */
+#define OV5_DYN_MEM_V2		0x1680	/* Redef Prop Structures: dyn-mem-v2   */
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index bca4abd..1bc0a36 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -76,6 +76,21 @@
 static phys_addr_t first_memblock_size;
 static int __initdata boot_cpu_count;
 
+#ifdef	CONFIG_PPC64
+static int if_iommu_is_off(u64 base, u64 *size)
+{
+	if (iommu_is_off) {
+		if (base >= 0x80000000ul)
+			return 1;
+		if ((base + (*size)) > 0x80000000ul)
+			(*size) = 0x80000000ul - base;
+	}
+	return 0;
+}
+#else
+#define	if_iommu_is_off(base, size)	0
+#endif
+
 static int __init early_parse_mem(char *p)
 {
 	if (!p)
@@ -444,23 +459,34 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
 
 #ifdef CONFIG_PPC_PSERIES
 /*
- * Interpret the ibm,dynamic-memory property in the
- * /ibm,dynamic-reconfiguration-memory node.
+ * Retrieve and validate the ibm,lmb-size property for drconf memory
+ * from the flattened device tree.
+ */
+static u64 __init get_lmb_size(unsigned long node)
+{
+	const __be32 *ls;
+	int len;
+	ls = of_get_flat_dt_prop(node, "ibm,lmb-size", &len);
+	if (!ls || len < dt_root_size_cells * sizeof(__be32))
+		return 0;
+	return dt_mem_next_cell(dt_root_size_cells, &ls);
+}
+
+/*
+ * Interpret the ibm,dynamic-memory property/ibm,dynamic-memory-v2
+ * in the /ibm,dynamic-reconfiguration-memory node.
  * This contains a list of memory blocks along with NUMA affinity
  * information.
  */
-static int __init early_init_dt_scan_drconf_memory(unsigned long node)
+static int __init early_init_dt_scan_drconf_memory_v1(unsigned long node)
 {
-	const __be32 *dm, *ls, *usm;
+	const __be32 *dm, *usm;
 	int l;
 	unsigned long n, flags;
 	u64 base, size, memblock_size;
 	unsigned int is_kexec_kdump = 0, rngs;
 
-	ls = of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
-	if (ls == NULL || l < dt_root_size_cells * sizeof(__be32))
-		return 0;
-	memblock_size = dt_mem_next_cell(dt_root_size_cells, &ls);
+	memblock_size = get_lmb_size(node);
 
 	dm = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &l);
 	if (dm == NULL || l < sizeof(__be32))
@@ -507,18 +533,78 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 				size = dt_mem_next_cell(dt_root_size_cells,
 							 &usm);
 			}
-			if (iommu_is_off) {
-				if (base >= 0x80000000ul)
-					continue;
-				if ((base + size) > 0x80000000ul)
-					size = 0x80000000ul - base;
-			}
+			if (if_iommu_is_off(base, &size))
+				continue;
 			memblock_add(base, size);
 		} while (--rngs);
 	}
 	memblock_dump_all();
 	return 0;
 }
+
+static int __init early_init_dt_scan_drconf_memory_v2(unsigned long node)
+{
+	const __be32 *dm;
+	int l;
+	unsigned long num_sets;
+	u64 size, base, memblock_size;
+
+	memblock_size = get_lmb_size(node);
+
+	dm = of_get_flat_dt_prop(node, "ibm,dynamic-memory-v2", &l);
+	if (dm == NULL || l < sizeof(__be32))
+		return 0;
+
+	/* Verify expected length of the array of ibm,dynamic-memory-v2
+	 * structs fits in the actual size of the property data.
+	 */
+	num_sets = of_read_number(dm++, 1);
+	if (l < (num_sets * (dt_root_addr_cells + 4) + 1) * sizeof(__be32))
+		return 0;
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
+			if (if_iommu_is_off(base, &size))
+				continue;
+			memblock_add(base, size);
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
+	const __be32 *dm;
+	int l;
+	dm = of_get_flat_dt_prop(node, "ibm,dynamic-memory-v2", &l);
+	if (dm == NULL || l < sizeof(__be32))
+		return early_init_dt_scan_drconf_memory_v1(node);
+	else
+		return early_init_dt_scan_drconf_memory_v2(node);
+}
+
 #else
 #define early_init_dt_scan_drconf_memory(node)	0
 #endif /* CONFIG_PPC_PSERIES */
@@ -550,14 +636,9 @@ static int __init early_init_dt_scan_memory_ppc(unsigned long node,
 
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
-#ifdef CONFIG_PPC64
-	if (iommu_is_off) {
-		if (base >= 0x80000000ul)
-			return;
-		if ((base + size) > 0x80000000ul)
-			size = 0x80000000ul - base;
-	}
-#endif
+	if (if_iommu_is_off(base, &size))
+		return;
+
 	/* Keep track of the beginning of memory -and- the size of
 	 * the very first block in the device-tree as it represents
 	 * the RMA on ppc64 server
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 9befaee..4fdc5ff 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -57,7 +57,8 @@
 EXPORT_SYMBOL(node_data);
 
 static int min_common_depth;
-static int n_mem_addr_cells, n_mem_size_cells;
+int n_mem_addr_cells;
+static int n_mem_size_cells;
 static int form1_affinity;
 
 #define MAX_DISTANCE_REF_POINTS 4
@@ -405,6 +406,23 @@ static void read_drconf_cell(struct of_drconf_cell *drmem, const __be32 **cellp)
 
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
 
 /*
  * Retrieve and validate the ibm,dynamic-memory property of the device tree.
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 757d757..eb688ae 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -115,6 +115,7 @@ struct vec5_fw_feature {
 	{FW_FEATURE_TYPE1_AFFINITY,	OV5_TYPE1_AFFINITY},
 	{FW_FEATURE_PRRN,		OV5_PRRN},
 	{FW_FEATURE_DRC_INFO,		OV5_DRC_INFO},
+	{FW_FEATURE_DYN_MEM_V2,		OV5_DYN_MEM_V2},
 };
 
 static void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
