Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4VF02jDyzDsyX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 01:50:44 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9REmfUQ049659
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:50:42 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26bjhmwgc6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:50:41 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 27 Oct 2016 08:50:39 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 148EB19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 08:50:02 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9REob1615794538
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 07:50:37 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EC636E038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 08:50:37 -0600 (MDT)
Received: from powerkvm6.aus.stglabs.ibm.com (unknown [9.40.192.78])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id 1CF5B6E03A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 08:50:37 -0600 (MDT)
Received: from powerkvm6.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by powerkvm6.aus.stglabs.ibm.com (Postfix) with ESMTP id 12C1AC203E1D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 10:24:16 -0500 (CDT)
Subject: [PATCH V8 2/8] powerpc/memory: Parse new memory property to
 register blocks.
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 26 Oct 2016 10:24:16 -0500
In-Reply-To: <147749538075.195514.2242191562019252303.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <147749538075.195514.2242191562019252303.stgit@powerkvm6.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147749544402.195514.14916602158482724282.stgit@powerkvm6.aus.stglabs.ibm.com>
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

[V2: Revise contant names.]
[V3: Fix error parsing the new memory block sets.]
[V4: Move a couple of function prototypes from header file
     a later patch where first used.
     Amend some comments.
     Change a firmware architure vec check for scan actual device tree.
     Compress some common code.]
[V5: Resynchronize/resubmit]
[V6: No change]
[V7: Correct mail threading]
[v8: Insert more useful variable names]

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/prom.h |   24 ++++++++--
 arch/powerpc/kernel/prom.c      |   97 ++++++++++++++++++++++++++++++++++++---
 arch/powerpc/mm/numa.c          |   22 ++++++++-
 3 files changed, 129 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index bc7c4b5..43a002b 100644
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
 
 /*
  * There are two methods for telling firmware what our capabilities are.
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index b0245be..2d49887 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -443,23 +443,34 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
 
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
@@ -518,6 +529,76 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
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
+
+			if (iommu_is_off) {
+				if (base >= 0x80000000ul)
+					continue;
+				if ((base + size) > 0x80000000ul)
+					size = 0x80000000ul - base;
+			}
+			memblock_add(base, size);
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
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 75b9cd6..fe8e6e7 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -57,8 +57,10 @@ EXPORT_SYMBOL(node_to_cpumask_map);
 EXPORT_SYMBOL(node_data);
 
 static int min_common_depth;
-static int n_mem_addr_cells, n_mem_size_cells;
+int n_mem_addr_cells;
+static int n_mem_size_cells;
 static int form1_affinity;
+EXPORT_SYMBOL(n_mem_addr_cells);
 
 #define MAX_DISTANCE_REF_POINTS 4
 static int distance_ref_points_depth;
@@ -405,6 +407,24 @@ static void read_drconf_cell(struct of_drconf_cell *drmem, const __be32 **cellp)
 
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
