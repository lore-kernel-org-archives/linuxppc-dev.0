Return-Path: <mwb@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E9751A045E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 06:33:34 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 3 Mar 2016 12:33:31 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 692203E40047
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 12:33:29 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u23JXTdj25690134
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 12:33:29 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u23JXTrW020478
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 12:33:29 -0700
Received: from oc1376853207.ibm.com (oc1376853207.ibm.com.austin.ibm.com
 [9.53.92.222] (may be forged))
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u23JXS9x020433
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 12:33:28 -0700
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/devtree: Parse new DRC mem/cpu/dev device tree
 elements
Message-ID: <56D89188.9090008@linux.vnet.ibm.com>
Date: Thu, 3 Mar 2016 13:33:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Several properties in the DRC device tree format are replaced by
more compact representations to allow, for example, for the encoding
of vast amounts of memory, and or reduced duplication of information
in related data structures.

"ibm,drc-info": This property, when present, replaces the following
four properties: “ibm,drc-indexes”, “ibm,drc-names”, “ibm,drc-types”
and “ibm,drc-power-domains”.  This property is defined for all
dynamically reconfigurable platform nodes.  The "ibm,drc-info" elements
are intended to provide a more compact representation, and reduce some
search overhead.

"ibm,dynamic-memory-v2": This property replaces the "ibm,dynamic-memory"
node representation within the "ibm,dynamic-reconfiguration-memory"
property.  This element format is intended to provide a more compact
representation of memory, especially, for systems with massive amounts
of RAM.

"ibm,architecture.vec": Bit flags are added to this data structure
by the front end processor to inform the kernel as to whether to expect
the changes to one or both of the device tree structures "ibm,drc-info"
and "ibm,dynamic-memory-v2".

The new element structures, "ibm,dynamic-memory-v2" and "ibm,drc-info",
should completely replace the previously used structures at execution.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/include/asm/firmware.h 
b/arch/powerpc/include/asm/firmware.h
index b062924..a9d66d5 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -51,6 +51,8 @@
  #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
  #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
  #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
+#define FW_FEATURE_RPS_DM2	ASM_CONST(0x0000000400000000)
+#define FW_FEATURE_RPS_DRC_INFO	ASM_CONST(0x0000000800000000)

  #ifndef __ASSEMBLY__

@@ -66,7 +68,8 @@ enum {
  		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
  		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
  		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
-		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
+		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
+		FW_FEATURE_RPS_DM2 | FW_FEATURE_RPS_DRC_INFO,
  	FW_FEATURE_PSERIES_ALWAYS = 0,
  	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
  	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/include/asm/prom.h 
b/arch/powerpc/include/asm/prom.h
index 7f436ba..dc4c5c0 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -81,8 +81,9 @@ extern void of_instantiate_rtc(void);
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
@@ -92,9 +93,36 @@ struct of_drconf_cell {
  	u32	flags;
  };

-#define DRCONF_MEM_ASSIGNED	0x00000008
-#define DRCONF_MEM_AI_INVALID	0x00000040
-#define DRCONF_MEM_RESERVED	0x00000080
+struct of_drconf_cell_v2 {
+	u32	num_seq_lmbs;
+	u64	base_addr;
+	u32	drc_index;
+	u32	aa_index;
+	u32	flags;
+};
+
+#define DRCONF_MEM_PRESERVED		0x00000001
+#define DRCONF_MEM_PRESERVABLE		0x00000002
+#define DRCONF_MEM_PRESERVED_STATE	0x00000004
+#define DRCONF_MEM_ASSIGNED		0x00000008
+#define DRCONF_MEM_NO_H_MIGRATE_DATA	0x00000010
+#define DRCONF_MEM_DRC_INVALID		0x00000020
+#define DRCONF_MEM_AI_INVALID		0x00000040
+#define DRCONF_MEM_RESERVED		0x00000080
+#define DRCONF_MEM_RESERVED_SW		0x80000000
+
+/*
+ * Set of dynamic DLPAR memory function operations
+ */
+struct dlpar_memory_ops {
+	struct property* (*clone_drconf_property)(struct device_node *dn);
+	int (*add_by_count)(u32 lmbs_to_add, struct property **prop);
+	int (*add_by_index)(u32 lmbs_to_add, struct property **prop);
+	int (*remove_by_count)(u32 lmbs_to_add, struct property **prop);
+	int (*remove_by_index)(u32 lmbs_to_add, struct property **prop);
+	void (*update_drconf_property)(struct device_node *dn,
+					struct property *prop);
+};

  /*
   * There are two methods for telling firmware what our capabilities are.
@@ -155,6 +183,8 @@ struct of_drconf_cell {
  #define OV5_PFO_HW_842		0x0E40	/* PFO Compression Accelerator */
  #define OV5_PFO_HW_ENCR		0x0E20	/* PFO Encryption Accelerator */
  #define OV5_SUB_PROCESSORS	0x0F01	/* 1,2,or 4 Sub-Processors supported */
+#define OV5_RPS_DM2		0x1601	/* Redef Prop Structures: dyn-mem-v2 */
+#define OV5_RPS_DRC_INFO	0x1602	/* Redef Prop Structures: drc-info   */

  /* Option Vector 6: IBM PAPR hints */
  #define OV6_LINUX		0x02	/* Linux is our OS */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 7030b03..909bae7 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -55,6 +55,7 @@
  #include <asm/opal.h>
  #include <asm/fadump.h>
  #include <asm/debug.h>
+#include <asm/firmware.h>

  #include <mm/mmu_decl.h>

@@ -435,35 +436,35 @@ static int __init 
early_init_dt_scan_chosen_ppc(unsigned long node,

  #ifdef CONFIG_PPC_PSERIES
  /*
- * Interpret the ibm,dynamic-memory property in the
- * /ibm,dynamic-reconfiguration-memory node.
+ * Interpret the ibm,dynamic-memory or ibm,dynamic-memory-v2 property
+ * in the /ibm,dynamic-reconfiguration-memory node.
   * This contains a list of memory blocks along with NUMA affinity
   * information.
   */
-static int __init early_init_dt_scan_drconf_memory(unsigned long node)
+static int __init early_init_dt_scan_drconf_memory_v1(unsigned long node,
+							u64 memblock_size,
+							int *endnow)
  {
-	const __be32 *dm, *ls, *usm;
  	int l;
+	const __be32 *dm, *usm;
  	unsigned long n, flags;
-	u64 base, size, memblock_size;
+	u64 base, size;
  	unsigned int is_kexec_kdump = 0, rngs;

-	ls = of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
-	if (ls == NULL || l < dt_root_size_cells * sizeof(__be32))
-		return 0;
-	memblock_size = dt_mem_next_cell(dt_root_size_cells, &ls);
-
  	dm = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &l);
-	if (dm == NULL || l < sizeof(__be32))
+	if (dm == NULL || l < sizeof(__be32)) {
+		(*endnow) = 1;
  		return 0;
+	}

  	n = of_read_number(dm++, 1);	/* number of entries */
-	if (l < (n * (dt_root_addr_cells + 4) + 1) * sizeof(__be32))
+	if (l < (n * (dt_root_addr_cells + 4) + 1) * sizeof(__be32)) {
+		(*endnow) = 1;
  		return 0;
+	}

  	/* check if this is a kexec/kdump kernel. */
-	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory",
-						 &l);
+	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory", &l);
  	if (usm != NULL)
  		is_kexec_kdump = 1;

@@ -473,20 +474,21 @@ static int __init 
early_init_dt_scan_drconf_memory(unsigned long node)
  		/* skip DRC index, pad, assoc. list index, flags */
  		dm += 4;
  		/* skip this block if the reserved bit is set in flags
-		   or if the block is not assigned to this partition */
+		 * or if the block is not assigned to this partition
+		 */
  		if ((flags & DRCONF_MEM_RESERVED) ||
-				!(flags & DRCONF_MEM_ASSIGNED))
+			!(flags & DRCONF_MEM_ASSIGNED))
  			continue;
  		size = memblock_size;
  		rngs = 1;
  		if (is_kexec_kdump) {
-			/*
-			 * For each memblock in ibm,dynamic-memory, a corresponding
-			 * entry in linux,drconf-usable-memory property contains
-			 * a counter 'p' followed by 'p' (base, size) duple.
-			 * Now read the counter from
-			 * linux,drconf-usable-memory property
-			 */
+		/*
+		 * For each memblock in ibm,dynamic-memory, a corresponding
+		 * entry in linux,drconf-usable-memory property contains
+		 * a counter 'p' followed by 'p' (base, size) duple.
+		 * Now read the counter from
+		 * linux,drconf-usable-memory property
+		 */
  			rngs = dt_mem_next_cell(dt_root_size_cells, &usm);
  			if (!rngs) /* there are no (base, size) duple */
  				continue;
@@ -505,11 +507,126 @@ static int __init 
early_init_dt_scan_drconf_memory(unsigned long node)
  					size = 0x80000000ul - base;
  			}
  			memblock_add(base, size);
+
  		} while (--rngs);
  	}
-	memblock_dump_all();
+
+	return 0;
+}
+
+static int __init early_init_dt_scan_drconf_memory_v2(unsigned long node,
+							u64 memblock_size,
+							int *endnow)
+{
+	int l;
+	const __be32 *dm, *usm;
+	unsigned long n, flags;
+	u64 base, size;
+	unsigned int is_kexec_kdump = 0, rngs;
+
+	dm = of_get_flat_dt_prop(node, "ibm,dynamic-memory-v2", &l);
+	if (dm == NULL || l < sizeof(__be32)) {
+		(*endnow) = 1;
+		return 0;
+	}
+
+	n = of_read_number(dm++, 1);	/* number of sets */
+	if (l < (n * (dt_root_addr_cells + 4) + 1) * sizeof(__be32)) {
+		(*endnow) = 1;
+		return 0;
+	}
+
+	/* Check if this is a kexec/kdump kernel. */
+	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory", &l);
+	if (usm != NULL)
+		is_kexec_kdump = 1;
+
+	for (; n != 0; --n) {
+		unsigned long n2;
+
+		/* Basic fields of the current DRC/LMB set */
+		n2 = of_read_number(dm++, 1);	/* num of LMBs in set */
+		if (n2 == 0)
+			continue;
+		base = dt_mem_next_cell(dt_root_addr_cells, &dm);
+		dm += 2;
+		flags = of_read_number(dm++, 1);
+
+		/* Skip this set if the reserved bit is set in flags
+		 * or if the blocks of this set are not assigned to
+		 * this partition
+		 */
+		if ((flags & DRCONF_MEM_RESERVED) ||
+			!(flags & DRCONF_MEM_ASSIGNED)) {
+			base += (n2 * memblock_size);
+			continue;
+		}
+
+		size = memblock_size;
+		rngs = 1;
+
+		for (; n2 != 0; --n2) {
+			do {
+				if (is_kexec_kdump) {
+				/*
+				 * For each memblock in ibm,dynamic-memory,
+				 * a corresponding entry in
+				 * linux,drconf-usable-memory property
+				 * contains a counter 'p' followed by 'p'
+				 * (base, size) duple.  Now read the counter
+				 * from linux,drconf-usable-memory property.
+				 */
+					rngs = dt_mem_next_cell(
+							dt_root_size_cells,
+							&usm);
+					if (!rngs)
+						/* there are no
+						 * (base, size) duple
+						 */
+						continue;
+				}
+
+				if (iommu_is_off) {
+					if (base >= 0x80000000ul)
+						continue;
+					if ((base + size) > 0x80000000ul)
+						size = 0x80000000ul - base;
+				}
+
+				memblock_add(base, size);
+
+			} while (--rngs);
+
+			base += size;
+		}
+	}
+
  	return 0;
  }
+
+static int __init early_init_dt_scan_drconf_memory(unsigned long node)
+{
+	int l, rc = 0, endnow = 0;
+	const __be32 *ls;
+	u64 memblock_size;
+
+	ls = of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
+	if (ls == NULL || l < dt_root_size_cells * sizeof(__be32))
+		return 0;
+	memblock_size = dt_mem_next_cell(dt_root_size_cells, &ls);
+
+	if (!firmware_has_feature(FW_FEATURE_RPS_DM2))
+		rc = early_init_dt_scan_drconf_memory_v1(node, memblock_size,
+							&endnow);
+	else
+		rc = early_init_dt_scan_drconf_memory_v2(node, memblock_size,
+							&endnow);
+
+	if (!endnow)
+		memblock_dump_all();
+
+	return rc;
+}
  #else
  #define early_init_dt_scan_drconf_memory(node)	0
  #endif /* CONFIG_PPC_PSERIES */
diff --git a/arch/powerpc/kernel/prom_init.c 
b/arch/powerpc/kernel/prom_init.c
index da51925..9c54e84 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -694,7 +694,7 @@ unsigned char ibm_architecture_vec[] = {
  	OV4_MIN_ENT_CAP,		/* minimum VP entitled capacity */

  	/* option vector 5: PAPR/OF options */
-	VECTOR_LENGTH(18),		/* length */
+	VECTOR_LENGTH(22),		/* length */
  	0,				/* don't ignore, don't halt */
  	OV5_FEAT(OV5_LPAR) | OV5_FEAT(OV5_SPLPAR) | OV5_FEAT(OV5_LARGE_PAGES) |
  	OV5_FEAT(OV5_DRCONF_MEMORY) | OV5_FEAT(OV5_DONATE_DEDICATE_CPU) |
@@ -727,6 +727,10 @@ unsigned char ibm_architecture_vec[] = {
  	OV5_FEAT(OV5_PFO_HW_RNG) | OV5_FEAT(OV5_PFO_HW_ENCR) |
  	OV5_FEAT(OV5_PFO_HW_842),
  	OV5_FEAT(OV5_SUB_PROCESSORS),
+	0,
+	0,
+	0,
+	OV5_FEAT(OV5_RPS_DM2) | OV5_FEAT(OV5_RPS_DRC_INFO),

  	/* option vector 6: IBM PAPR hints */
  	VECTOR_LENGTH(3),		/* length */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 669a15e..97b2690 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -389,7 +389,7 @@ static unsigned long read_n_cells(int n, const 
__be32 **buf)

  /*
   * Read the next memblock list entry from the ibm,dynamic-memory property
- * and return the information in the provided of_drconf_cell structure.
+ * and return the information in the provided of_drconf_cell/series 
structure.
   */
  static void read_drconf_cell(struct of_drconf_cell *drmem, const 
__be32 **cellp)
  {
@@ -407,30 +407,77 @@ static void read_drconf_cell(struct of_drconf_cell 
*drmem, const __be32 **cellp)
  }

  /*
- * Retrieve and validate the ibm,dynamic-memory property of the device 
tree.
+ * Read the next memblock set entry from the ibm,dynamic-memory-v2 property
+ * and return the information in the provided of_drconf_cell_v2 structure.
+ */
+static void read_drconf_cell_v2(struct of_drconf_cell_v2 *drmem,
+				const __be32 **cellp)
+{
+	const __be32 *cp;
+
+	cp = *cellp;
+	drmem->num_seq_lmbs = of_read_number(&cp[0], 1);
+	cp++;
+
+	*cellp = cp;
+	drmem->base_addr = read_n_cells(n_mem_addr_cells, cellp);
+
+	cp = *cellp;
+	drmem->drc_index = of_read_number(&cp[0], 1);
+	drmem->aa_index = of_read_number(&cp[1], 1);
+	drmem->flags = of_read_number(&cp[2], 1);
+
+	*cellp = cp + 3;
+}
+
+/*
+ * Retrieve and validate the ibm,dynamic-memory[-v2] property of the
+ * device tree.
   *
   * The layout of the ibm,dynamic-memory property is a number N of memblock
   * list entries followed by N memblock list entries.  Each memblock 
list entry
   * contains information as laid out in the of_drconf_cell struct above.
+ *
+ * The layout of the ibm,dynamic-memory-v2 property is a number N of 
memblock
+ * list entries.
   */
  static int of_get_drconf_memory(struct device_node *memory, const 
__be32 **dm)
  {
  	const __be32 *prop;
  	u32 len, entries;

-	prop = of_get_property(memory, "ibm,dynamic-memory", &len);
-	if (!prop || len < sizeof(unsigned int))
-		return 0;
+	if (firmware_has_feature(FW_FEATURE_RPS_DM2)) {
+		prop = of_get_property(memory, "ibm,dynamic-memory-v2", &len);
+		if (!prop || len < sizeof(unsigned int))
+			return 0;

-	entries = of_read_number(prop++, 1);
+		entries = of_read_number(prop++, 1);

-	/* Now that we know the number of entries, revalidate the size
-	 * of the property read in to ensure we have everything
-	 */
-	if (len < (entries * (n_mem_addr_cells + 4) + 1) * sizeof(unsigned int))
-		return 0;
+		/* Now that we know the number of set entries, revalidate the
+		 * size of the property read in to ensure we have everything.
+		 */
+		if (len < (entries * (n_mem_addr_cells + 4) + 1) *
+			   sizeof(unsigned int))
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

@@ -459,7 +506,7 @@ struct assoc_arrays {
  /*
   * Retrieve and validate the list of associativity arrays for drconf
   * memory from the ibm,associativity-lookup-arrays property of the
- * device tree..
+ * device tree.
   *
   * The layout of the ibm,associativity-lookup-arrays property is a 
number N
   * indicating the number of associativity arrays, followed by a number M
@@ -493,7 +540,7 @@ static int of_get_assoc_arrays(struct device_node 
*memory,
   * This is like of_node_to_nid_single() for memory represented in the
   * ibm,dynamic-reconfiguration-memory node.
   */
-static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
+static int of_drconf_to_nid_single(u32 drmem_flags, u32 drmem_aa_index,
  				   struct assoc_arrays *aa)
  {
  	int default_nid = 0;
@@ -501,16 +548,16 @@ static int of_drconf_to_nid_single(struct 
of_drconf_cell *drmem,
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
@@ -661,58 +708,147 @@ static void __init parse_drconf_memory(struct 
device_node *memory)
  	int nid;
  	struct assoc_arrays aa = { .arrays = NULL };

-	n = of_get_drconf_memory(memory, &dm);
-	if (!n)
-		return;
+	if (firmware_has_feature(FW_FEATURE_RPS_DM2)) {
+		const __be32 *prop, *p;
+		u32	len;
+
+		prop = of_get_property(memory, "ibm,dynamic-memory-v2", &len);
+		if (!prop)
+			return;
+		p = prop;
+
+		n = of_get_drconf_memory(memory, &dm);	/* Num sets */
+		if (!n)
+			return;
+
+		lmb_size = of_get_lmb_size(memory);
+		if (!lmb_size)
+			return;
+
+		rc = of_get_assoc_arrays(memory, &aa);
+		if (rc)
+			return;
+
+		for (; n != 0; n--) {
+			struct of_drconf_cell_v2 drmem;
+
+			/* Get the current LMB set */
+			read_drconf_cell_v2(&drmem, &dm);
+			base = drmem.base_addr;
+
+			/* Check if this is a kexec/kdump kernel */
+			usm = of_get_usable_memory(memory);
+			if (usm != NULL)
+				is_kexec_kdump = 1;
+
+			/* Skip this block if the reserved bit is set in
+			 * flags (0x80) or if the block is not assigned
+			 * to this partition (0x8)
+			 */
+			if ((drmem.flags & DRCONF_MEM_RESERVED)
+			    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
+				continue;

-	lmb_size = of_get_lmb_size(memory);
-	if (!lmb_size)
-		return;
+			for (; drmem.num_seq_lmbs != 0; --drmem.num_seq_lmbs) {
+				size = lmb_size;
+				ranges = 1;
+
+				if (is_kexec_kdump) {
+					ranges = read_usm_ranges(&usm);
+					if (!ranges)
+						/* there are no (base, size)
+						 * duple
+						 */
+						continue;
+				}
+				do {
+					if (is_kexec_kdump) {
+						base = read_n_cells(
+							n_mem_addr_cells,
+								&usm);
+						size = read_n_cells(
+							n_mem_size_cells,
+								&usm);
+					}
+					nid = of_drconf_to_nid_single(
+							drmem.flags,
+							drmem.aa_index, &aa);
+					fake_numa_create_new_node(
+						((base + size) >> PAGE_SHIFT),
+						&nid);
+					node_set_online(nid);
+					sz = numa_enforce_memory_limit(base,
+									size);
+					if (sz)
+						memblock_set_node(base, sz,
+							&memblock.memory, nid);
+				} while (--ranges);
+
+				base += sz;
+			}
+		}
+	} else {

-	rc = of_get_assoc_arrays(memory, &aa);
-	if (rc)
-		return;
+		n = of_get_drconf_memory(memory, &dm);
+		if (!n)
+			return;

-	/* check if this is a kexec/kdump kernel */
-	usm = of_get_usable_memory(memory);
-	if (usm != NULL)
-		is_kexec_kdump = 1;
+		lmb_size = of_get_lmb_size(memory);
+		if (!lmb_size)
+			return;

-	for (; n != 0; --n) {
-		struct of_drconf_cell drmem;
+		rc = of_get_assoc_arrays(memory, &aa);
+		if (rc)
+			return;

-		read_drconf_cell(&drmem, &dm);
+		/* Check if this is a kexec/kdump kernel */
+		usm = of_get_usable_memory(memory);
+		if (usm != NULL)
+			is_kexec_kdump = 1;

-		/* skip this block if the reserved bit is set in flags (0x80)
-		   or if the block is not assigned to this partition (0x8) */
-		if ((drmem.flags & DRCONF_MEM_RESERVED)
-		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
-			continue;
+		for (; n != 0; --n) {
+			struct of_drconf_cell drmem;

-		base = drmem.base_addr;
-		size = lmb_size;
-		ranges = 1;
+			read_drconf_cell(&drmem, &dm);

-		if (is_kexec_kdump) {
-			ranges = read_usm_ranges(&usm);
-			if (!ranges) /* there are no (base, size) duple */
+			/* skip this block if the reserved bit is set in
+			 * flags (0x80) or if the block is not assigned
+			 * to this partition (0x8)
+			 */
+			if ((drmem.flags & DRCONF_MEM_RESERVED)
+			    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
  				continue;
-		}
-		do {
+
+			base = drmem.base_addr;
+			size = lmb_size;
+			ranges = 1;
+
  			if (is_kexec_kdump) {
-				base = read_n_cells(n_mem_addr_cells, &usm);
-				size = read_n_cells(n_mem_size_cells, &usm);
+				ranges = read_usm_ranges(&usm);
+				if (!ranges)
+					/* there are no (base, size) duple */
+					continue;
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
-		} while (--ranges);
+			do {
+				if (is_kexec_kdump) {
+					base = read_n_cells(n_mem_addr_cells,
+								&usm);
+					size = read_n_cells(n_mem_size_cells,
+								&usm);
+				}
+				nid = of_drconf_to_nid_single(drmem.flags,
+								drmem.aa_index,
+								&aa);
+				fake_numa_create_new_node(
+					((base + size) >> PAGE_SHIFT),
+					&nid);
+				node_set_online(nid);
+				sz = numa_enforce_memory_limit(base, size);
+				if (sz)
+					memblock_set_node(base, sz,
+							&memblock.memory, nid);
+			} while (--ranges);
+		}
  	}
  }

@@ -1035,7 +1171,13 @@ early_param("topology_updates", 
early_topology_updates);
  /*
   * Find the node associated with a hot added memory section for
   * memory represented in the device tree by the property
- * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory.
+ *
+ *     ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
+ *         or
+ *     ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory-v2
+ *
+ * The layout of the ibm,dynamic-memory[-v2] property is a number
+ * N of memblock list entries.
   */
  static int hot_add_drconf_scn_to_nid(struct device_node *memory,
  				     unsigned long scn_addr)
@@ -1044,6 +1186,7 @@ static int hot_add_drconf_scn_to_nid(struct 
device_node *memory,
  	unsigned int drconf_cell_cnt, rc;
  	unsigned long lmb_size;
  	struct assoc_arrays aa;
+
  	int nid = -1;

  	drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
@@ -1059,21 +1202,37 @@ static int hot_add_drconf_scn_to_nid(struct 
device_node *memory,
  		return -1;

  	for (; drconf_cell_cnt != 0; --drconf_cell_cnt) {
-		struct of_drconf_cell drmem;

-		read_drconf_cell(&drmem, &dm);
+		if (firmware_has_feature(FW_FEATURE_RPS_DM2)) {
+			struct of_drconf_cell_v2	drmem;

-		/* skip this block if it is reserved or not assigned to
-		 * this partition */
-		if ((drmem.flags & DRCONF_MEM_RESERVED)
-		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
-			continue;
+			read_drconf_cell_v2(&drmem, &dm);

-		if ((scn_addr < drmem.base_addr)
-		    || (scn_addr >= (drmem.base_addr + lmb_size)))
-			continue;
+			/* Skip this block/series if it is reserved or not
+			 * assigned to this partition
+			 */
+			if ((drmem.flags & DRCONF_MEM_RESERVED)
+			    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
+				continue;
+
+			if ((scn_addr < drmem.base_addr)
+			    || (scn_addr >= (drmem.base_addr +
+					     (drmem.num_seq_lmbs * lmb_size))))
+				continue;
+			nid = of_drconf_to_nid_single(drmem.flags,
+						      drmem.aa_index, &aa);
+		} else {
+			struct of_drconf_cell	drmem;
+
+			read_drconf_cell(&drmem, &dm);
+
+			if ((scn_addr < drmem.base_addr)
+			    || (scn_addr >= (drmem.base_addr + lmb_size)))
+				continue;
+			nid = of_drconf_to_nid_single(drmem.flags,
+						      drmem.aa_index, &aa);
+		}

-		nid = of_drconf_to_nid_single(&drmem, &aa);
  		break;
  	}

diff --git a/arch/powerpc/platforms/pseries/firmware.c 
b/arch/powerpc/platforms/pseries/firmware.c
index 8c80588..00243ee 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -111,6 +111,8 @@ static __initdata struct vec5_fw_feature
  vec5_fw_features_table[] = {
  	{FW_FEATURE_TYPE1_AFFINITY,	OV5_TYPE1_AFFINITY},
  	{FW_FEATURE_PRRN,		OV5_PRRN},
+	{FW_FEATURE_RPS_DM2,		OV5_RPS_DM2},
+	{FW_FEATURE_RPS_DRC_INFO,	OV5_RPS_DRC_INFO},
  };

  void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c 
b/arch/powerpc/platforms/pseries/hotplug-memory.c
index e9ff44c..02f7159 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -81,7 +81,7 @@ static struct property 
*dlpar_clone_drconf_property(struct device_node *dn)
  	struct property *prop, *new_prop;
  	struct of_drconf_cell *lmbs;
  	u32 num_lmbs, *p;
-	int i;
+	int i = 0;

  	prop = of_find_property(dn, "ibm,dynamic-memory", NULL);
  	if (!prop)
@@ -116,13 +116,55 @@ static struct property 
*dlpar_clone_drconf_property(struct device_node *dn)
  	return new_prop;
  }

-static struct memory_block *lmb_to_memblock(struct of_drconf_cell *lmb)
+static struct property *dlpar_clone_drconf_property_v2(struct 
device_node *dn)
+{
+	struct property *prop, *new_prop;
+	struct of_drconf_cell_v2 *lmbs;
+	u32 num_lmbs, *p;
+	int i = 0;
+
+	prop = of_find_property(dn, "ibm,dynamic-memory-v2", NULL);
+	if (!prop)
+		return NULL;
+
+	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
+	if (!new_prop)
+		return NULL;
+
+	new_prop->name = kstrdup(prop->name, GFP_KERNEL);
+	new_prop->value = kmemdup(prop->value, prop->length, GFP_KERNEL);
+	if (!new_prop->name || !new_prop->value) {
+		dlpar_free_drconf_property(new_prop);
+		return NULL;
+	}
+
+	new_prop->length = prop->length;
+
+	/* Convert the property to cpu endian-ness */
+	p = new_prop->value;
+	*p = be32_to_cpu(*p);
+
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell_v2 *)p;
+
+	for (i = 0; i < num_lmbs; i++) {
+		lmbs[i].num_seq_lmbs = be32_to_cpu(lmbs[i].num_seq_lmbs);
+		lmbs[i].base_addr = be64_to_cpu(lmbs[i].base_addr);
+		lmbs[i].drc_index = be32_to_cpu(lmbs[i].drc_index);
+		lmbs[i].aa_index = be32_to_cpu(lmbs[i].aa_index);
+		lmbs[i].flags = be32_to_cpu(lmbs[i].flags);
+	}
+
+	return new_prop;
+}
+
+static struct memory_block *lmb_to_memblock(u64 lmb_base_addr)
  {
  	unsigned long section_nr;
  	struct mem_section *mem_sect;
  	struct memory_block *mem_block;

-	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
+	section_nr = pfn_to_section_nr(PFN_DOWN(lmb_base_addr));
  	mem_sect = __nr_to_section(section_nr);

  	mem_block = find_memory_block(mem_sect);
@@ -188,19 +230,19 @@ static int pseries_remove_mem_node(struct 
device_node *np)
  	return 0;
  }

-static bool lmb_is_removable(struct of_drconf_cell *lmb)
+static bool lmb_is_removable(u32 lmb_flags, u64 lmb_base_addr)
  {
  	int i, scns_per_block;
  	int rc = 1;
  	unsigned long pfn, block_sz;
  	u64 phys_addr;

-	if (!(lmb->flags & DRCONF_MEM_ASSIGNED))
+	if (!(lmb_flags & DRCONF_MEM_ASSIGNED))
  		return false;

  	block_sz = memory_block_size_bytes();
  	scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
-	phys_addr = lmb->base_addr;
+	phys_addr = lmb_base_addr;

  	for (i = 0; i < scns_per_block; i++) {
  		pfn = PFN_DOWN(phys_addr);
@@ -215,6 +257,8 @@ static bool lmb_is_removable(struct of_drconf_cell *lmb)
  }

  static int dlpar_add_lmb(struct of_drconf_cell *);
+static int dlpar_add_lmb_v2(struct of_drconf_cell_v2 *lmb, int drc_index,
+			int num_to_add);

  static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
  {
@@ -222,10 +266,10 @@ static int dlpar_remove_lmb(struct of_drconf_cell 
*lmb)
  	unsigned long block_sz;
  	int nid, rc;

-	if (!lmb_is_removable(lmb))
+	if (!lmb_is_removable(lmb->flags, lmb->base_addr))
  		return -EINVAL;

-	mem_block = lmb_to_memblock(lmb);
+	mem_block = lmb_to_memblock(lmb->base_addr);
  	if (!mem_block)
  		return -EINVAL;

@@ -249,7 +293,7 @@ static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
  }

  static int dlpar_memory_remove_by_count(u32 lmbs_to_remove,
-					struct property *prop)
+					struct property **prop)
  {
  	struct of_drconf_cell *lmbs;
  	int lmbs_removed = 0;
@@ -262,7 +306,7 @@ static int dlpar_memory_remove_by_count(u32 
lmbs_to_remove,
  	if (lmbs_to_remove == 0)
  		return -EINVAL;

-	p = prop->value;
+	p = (*prop)->value;
  	num_lmbs = *p++;
  	lmbs = (struct of_drconf_cell *)p;

@@ -320,7 +364,7 @@ static int dlpar_memory_remove_by_count(u32 
lmbs_to_remove,
  	return rc;
  }

-static int dlpar_memory_remove_by_index(u32 drc_index, struct property 
*prop)
+static int dlpar_memory_remove_by_index(u32 drc_index, struct property 
**prop)
  {
  	struct of_drconf_cell *lmbs;
  	u32 num_lmbs, *p;
@@ -329,13 +373,13 @@ static int dlpar_memory_remove_by_index(u32 
drc_index, struct property *prop)

  	pr_info("Attempting to hot-remove LMB, drc index %x\n", drc_index);

-	p = prop->value;
+	p = (*prop)->value;
  	num_lmbs = *p++;
  	lmbs = (struct of_drconf_cell *)p;

  	lmb_found = 0;
  	for (i = 0; i < num_lmbs; i++) {
-		if (lmbs[i].drc_index == drc_index) {
+		if ((lmbs[i].drc_index + i) == drc_index) {
  			lmb_found = 1;
  			rc = dlpar_remove_lmb(&lmbs[i]);
  			break;
@@ -354,6 +398,590 @@ static int dlpar_memory_remove_by_index(u32 
drc_index, struct property *prop)
  	return rc;
  }

+static struct property *dlpar_clone_extend_property(struct property *prop,
+						unsigned int extra_bytes_space)
+{
+	struct property *new_prop = NULL;
+
+	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
+	if (!new_prop)
+		return NULL;
+
+	new_prop->name = kstrdup(prop->name, GFP_KERNEL);
+	new_prop->value = kmemdup(prop->value, prop->length+extra_bytes_space,
+					GFP_KERNEL);
+	if (!new_prop->name || !new_prop->value)
+		return NULL;
+
+	new_prop->length = prop->length + extra_bytes_space;
+
+	return new_prop;
+}
+
+static inline int drconf_copy_lmbs(struct of_drconf_cell_v2 *lmb_set,
+				int src_lmb, int dest_lmb)
+{
+	lmb_set[dest_lmb].num_seq_lmbs = lmb_set[src_lmb].num_seq_lmbs;
+	lmb_set[dest_lmb].base_addr = lmb_set[src_lmb].base_addr;
+	lmb_set[dest_lmb].drc_index = lmb_set[src_lmb].drc_index;
+	lmb_set[dest_lmb].aa_index = lmb_set[src_lmb].aa_index;
+	lmb_set[dest_lmb].flags = lmb_set[src_lmb].flags;
+	return 0;
+}
+
+static inline int drconf_shift_lmbs_up(struct of_drconf_cell_v2 *lmb_set,
+					int num_lmbs, int shift_point)
+{
+	int i;
+
+	for (i = num_lmbs; i != (shift_point+1); i--)
+		drconf_copy_lmbs(lmb_set, i-1, i);
+	return 0;
+}
+
+static inline int drconf_set(struct of_drconf_cell_v2 *lmb_set, int 
lmb_ndx,
+			u32 new_num_seq_lmbs, u32 new_drc_index,
+			u64 new_base_addr)
+{
+	lmb_set[lmb_ndx].num_seq_lmbs = new_num_seq_lmbs;
+	lmb_set[lmb_ndx].drc_index = new_drc_index;
+	lmb_set[lmb_ndx].base_addr = new_base_addr;
+	return 0;
+}
+
+static int dlpar_remove_lmb_v2(struct of_drconf_cell_v2 *lmb, int 
drc_index,
+				int num_to_remove)
+{
+	struct memory_block *mem_block;
+	unsigned long block_sz;
+	int nid, i, rc;
+
+	for (i = 0; i < num_to_remove; i++) {
+		block_sz = pseries_memory_block_size();
+
+		if (!lmb_is_removable(lmb[i].flags,
+				      lmb[i].base_addr+(i*block_sz)))
+			return -EINVAL;
+
+		mem_block = lmb_to_memblock(lmb[i].base_addr+(i*block_sz));
+		if (!mem_block)
+			return -EINVAL;
+
+		rc = device_offline(&mem_block->dev);
+		put_device(&mem_block->dev);
+		if (rc)
+			return rc;
+
+		nid = memory_add_physaddr_to_nid(lmb[i].base_addr+(i*block_sz));
+
+		remove_memory(nid, lmb[i].base_addr+(i*block_sz), block_sz);
+
+		/* Update memory regions for memory remove */
+		memblock_remove(lmb[i].base_addr+(i*block_sz), block_sz);
+
+		dlpar_release_drc(lmb[i].drc_index);
+
+		lmb[i].flags &= ~DRCONF_MEM_ASSIGNED;
+	}
+
+	return 0;
+}
+
+static int dlpar_memory_remove_by_count_v2(u32 lmbs_to_remove,
+					struct property **prop)
+{
+	struct of_drconf_cell_v2 *lmbs;
+	int lmbs_removed = 0;
+	int lmbs_available = 0;
+	unsigned long block_sz;
+	u32 num_lmbs, *p;
+	int i, rc;
+
+	pr_info("Attempting to hot-remove %d LMB(s)\n", lmbs_to_remove);
+
+	if (lmbs_to_remove == 0)
+		return -EINVAL;
+
+	block_sz = pseries_memory_block_size();		/* TBD Confirm */
+
+	p = (*prop)->value;
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell_v2 *)p;
+
+	/* Validate that there are enough LMBs to satisfy the request */
+	for (i = 0; i < num_lmbs; i++) {
+		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
+			lmbs_available += lmbs[i].num_seq_lmbs;
+	}
+
+	if (lmbs_available < lmbs_to_remove)
+		return -EINVAL;
+
+	/*
+	 * Find/remove block(s) of LMBs that we previously reserved
+	 */
+	for (i = 0; i < num_lmbs && lmbs_removed < lmbs_to_remove; i++) {
+		int nr = (lmbs_to_remove - lmbs_removed) % lmbs[i].num_seq_lmbs;
+		struct property *prop2 = NULL;
+
+		if (lmbs[i].num_seq_lmbs == nr) {
+			rc = dlpar_remove_lmb_v2(&lmbs[i],
+						 lmbs[i].drc_index, nr);
+			if (rc)
+				continue;
+
+			lmbs_removed += nr;
+
+			/* Mark this lmb so we can add it later if all
+			 * of the requested LMBs cannot be removed.
+			 */
+			lmbs[i].flags |= DRCONF_MEM_RESERVED_SW;
+			continue;
+
+		} else {
+
+			/*
+			 * Grow the property by one LMB.
+			 * Split the current LMB in two with the 'reserved'
+			 *   drc_index entries going to the existing memory
+			 *   LMB, and the remaining drc_index entries going
+			 *   to the next, new LMB.
+			 */
+			prop2 = dlpar_clone_extend_property(*prop,
+					sizeof(struct of_drconf_cell_v2));
+			dlpar_free_drconf_property(*prop);
+			*prop = prop2;
+			p = (*prop)->value;
+			num_lmbs = *p++;
+			lmbs = (struct of_drconf_cell_v2 *)p;
+
+			drconf_shift_lmbs_up(lmbs, num_lmbs+1, i);
+			drconf_copy_lmbs(lmbs, i+1, i);
+
+			drconf_set(lmbs, i, nr, lmbs[i].drc_index,
+				   lmbs[i].base_addr);
+			drconf_set(lmbs, i+1, lmbs[i].num_seq_lmbs - nr,
+				lmbs[i+1].drc_index+nr,
+				lmbs[i+1].base_addr+(nr*block_sz));
+
+			(*p)++;			/* + Increment 'num_lmbs' */
+			num_lmbs = (*p);
+
+			/* Now remove the blocks assigned to the 'lower' LMB */
+			rc = dlpar_remove_lmb_v2(&lmbs[i], lmbs[i].drc_index,
+						 nr);
+			if (rc)
+				continue;
+
+			lmbs_removed += nr;
+
+			/* Mark this LMB so we can add it later if all of the
+			 * requested LMBs cannot be removed.
+			 */
+			lmbs[i].flags |= DRCONF_MEM_RESERVED_SW;
+		}
+	}
+
+	if (lmbs_removed != lmbs_to_remove) {
+		pr_err("Memory hot-remove failed, adding LMB's back\n");
+
+		for (i = 0; i < num_lmbs; i++) {
+			if (!(lmbs[i].flags & DRCONF_MEM_RESERVED_SW))
+				continue;
+
+			/*
+			 * Restore current block of N lmbs
+			 */
+			rc = dlpar_add_lmb_v2(&lmbs[i], lmbs[i].drc_index,
+						lmbs[i].num_seq_lmbs);
+			if (rc)
+				pr_err("Failed to add LMB back, drc index %x\n",
+				       lmbs[i].drc_index);
+
+			lmbs[i].flags &= ~DRCONF_MEM_RESERVED_SW;
+		}
+
+		rc = -EINVAL;
+	} else {
+		for (i = 0; i < num_lmbs; i++) {
+			if (!(lmbs[i].flags & DRCONF_MEM_RESERVED_SW))
+				continue;
+
+			pr_info("Memory at %llx was hot-removed\n",
+				lmbs[i].base_addr);
+
+			lmbs[i].flags &= ~DRCONF_MEM_RESERVED_SW;
+		}
+		rc = 0;
+	}
+
+	return rc;
+}
+
+static int dlpar_memory_remove_by_index_v2(u32 drc_index,
+					struct property **prop)
+{
+	struct of_drconf_cell_v2 *lmbs;
+	struct property *prop2;
+	unsigned long block_sz;
+	u32 num_lmbs, *p;
+	int lmb_found;
+	int i, rc = 0;
+
+	pr_info("Attempting to hot-remove LMB, drc index %x\n", drc_index);
+
+	block_sz = pseries_memory_block_size();
+
+	p = (*prop)->value;
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell_v2 *)p;
+
+	lmb_found = 0;
+	for (i = 0; (i < num_lmbs) && !lmb_found; i++) {
+		u32 nsl = lmbs[i].num_seq_lmbs;
+		u32 di  = lmbs[i].drc_index;
+		u64 ba  = lmbs[i].base_addr;
+
+		if ((lmbs[i].drc_index == drc_index) &&
+		    (lmbs[i].num_seq_lmbs == 1)) {
+		/*
+		 * Take it all, and
+		 * Exit the loop
+		 */
+			lmb_found = 1;
+			rc = dlpar_remove_lmb_v2(&lmbs[i], drc_index, 1);
+			break;
+
+		} else if (lmbs[i].drc_index == drc_index) {
+		/*
+		 * Grow the property by one LMB
+		 * Split the current LMB in two
+		 * + Duplicate this LMB (deal with head+block+tail)
+		 *   - Set first LMB to (num to remove)
+		 *   - Set second LMB to (size of block) - (num to remove)
+		 *     & update drc_index
+		 * + Increment 'num_lmbs'
+		 */
+			prop2 = dlpar_clone_extend_property(*prop,
+					sizeof(struct of_drconf_cell_v2));
+			dlpar_free_drconf_property(*prop);
+			*prop = prop2;
+			p = (*prop)->value;
+			num_lmbs = *p++;
+			lmbs = (struct of_drconf_cell_v2 *)p;
+
+			drconf_shift_lmbs_up(lmbs, num_lmbs+1, i);
+			drconf_copy_lmbs(lmbs, i+1, i);
+
+			drconf_set(lmbs, i, nsl - 1, lmbs[i].drc_index, ba);
+			drconf_set(lmbs, i+1, 1,
+				lmbs[i+1].drc_index+nsl-1,
+				ba+((nsl-1)*block_sz));
+
+			(*p)++;			/* + Increment 'num_lmbs' */
+			num_lmbs = (*p);
+			lmb_found = 1;
+
+		} else if ((lmbs[i].drc_index+lmbs[i].num_seq_lmbs-1) ==
+								drc_index) {
+		/*
+		 * Grow the property by one LMB
+		 * Split the LMB in two
+		 * + Duplicate LMB block (deal with head+block+tail)
+		 *   - Set first LMB to (size of block) - (num to remove)
+		 *     & update drc_index
+		 *   - Set second LMB to (num to remove)
+		 * + Increment 'num_lmbs'
+		 */
+			prop2 = dlpar_clone_extend_property(*prop,
+					sizeof(struct of_drconf_cell_v2));
+			dlpar_free_drconf_property(*prop);
+			*prop = prop2;
+			p = (*prop)->value;
+			num_lmbs = *p++;
+			lmbs = (struct of_drconf_cell_v2 *)p;
+
+			drconf_shift_lmbs_up(lmbs, num_lmbs+1, i);
+			drconf_copy_lmbs(lmbs, i+1, i);
+
+			drconf_set(lmbs, i, 1, lmbs[i].drc_index, ba);
+			drconf_set(lmbs, i+1, nsl - 1,
+				lmbs[i+1].drc_index+1,
+				ba+(1*block_sz));
+
+			(*p)++;			/* + Increment 'num_lmbs' */
+			num_lmbs = (*p);
+			lmb_found = 1;
+
+		} else {
+		/*
+		 * Split the block in three
+		 * + Clone the property, again, with an extra 2 blocks
+		 *   - Discard the previous copy
+		 * + Duplicate this block (deal with head+block+tail)
+		 *   - Set first block size to (drc_index-block.drc_index)
+		 *   - Set second block size to 1
+		 *     & update block.drc_index
+		 *   - Set third block size to (size of block - 1 -
+		 *     (drc_index-block.drc_index)) & update block.drc_index
+		 * + 'num_lmbs' += 2
+		 */
+			u32 offset = drc_index - lmbs[i].drc_index;
+
+			prop2 = dlpar_clone_extend_property(*prop,
+					2 * sizeof(struct of_drconf_cell_v2));
+			dlpar_free_drconf_property(*prop);
+			*prop = prop2;
+			p = (*prop)->value;
+			num_lmbs = *p++;
+			lmbs = (struct of_drconf_cell_v2 *)p;
+
+			drconf_shift_lmbs_up(lmbs, num_lmbs+2, i);
+			drconf_copy_lmbs(lmbs, i+2, i+1);
+			drconf_copy_lmbs(lmbs, i+2, i);
+
+			drconf_set(lmbs, i, offset, di, ba);
+			drconf_set(lmbs, i+1, 1, drc_index,
+				ba+(offset*block_sz));
+			drconf_set(lmbs, i+2, nsl-offset-1, drc_index+1,
+				ba+((offset+1)*block_sz));
+
+			(*p) += 2;		/* + Increment 'num_lmbs' */
+			num_lmbs = (*p);
+			lmb_found = 1;
+		}
+	}
+
+	if (!lmb_found)
+		rc = -EINVAL;
+
+	if (rc)
+		pr_info("Failed to hot-remove memory at %llx\n",
+			lmbs[i].base_addr);
+	else
+		pr_info("Memory at %llx was hot-removed\n", lmbs[i].base_addr);
+
+	return rc;
+}
+
+static int dlpar_add_lmb_v2(struct of_drconf_cell_v2 *lmb, int drc_index,
+			int num_to_add)
+{
+	struct memory_block *mem_block;
+	unsigned long block_sz;
+	int nid, rc;
+
+	if (lmb->flags & DRCONF_MEM_ASSIGNED)
+		return -EINVAL;
+
+	block_sz = memory_block_size_bytes();
+
+	rc = dlpar_acquire_drc(lmb->drc_index);
+	if (rc)
+		return rc;
+
+	/* Find the node id for this address */
+	nid = memory_add_physaddr_to_nid(lmb->base_addr);
+
+	/* Add the memory */
+	rc = add_memory(nid, lmb->base_addr, block_sz);
+	if (rc) {
+		dlpar_release_drc(lmb->drc_index);
+		return rc;
+	}
+
+	/* Register this block of memory */
+	rc = memblock_add(lmb->base_addr, block_sz);
+	if (rc) {
+		remove_memory(nid, lmb->base_addr, block_sz);
+		dlpar_release_drc(lmb->drc_index);
+		return rc;
+	}
+
+	mem_block = lmb_to_memblock(lmb->base_addr);
+	if (!mem_block) {
+		remove_memory(nid, lmb->base_addr, block_sz);
+		dlpar_release_drc(lmb->drc_index);
+		return -EINVAL;
+	}
+
+	rc = device_online(&mem_block->dev);
+	put_device(&mem_block->dev);
+	if (rc) {
+		remove_memory(nid, lmb->base_addr, block_sz);
+		dlpar_release_drc(lmb->drc_index);
+		return rc;
+	}
+
+	lmb->flags |= DRCONF_MEM_ASSIGNED;
+
+	return 0;
+}
+
+static int dlpar_memory_add_by_count_v2(u32 lmbs_to_add, struct 
property **prop)
+{
+	struct of_drconf_cell_v2 *lmbs;
+	struct property *prop2;
+	unsigned long block_sz;
+	u32 num_lmbs, *p;
+	int lmbs_available = 0;
+	int lmbs_added = 0;
+	int i, rc = 0;
+
+	pr_info("Attempting to hot-add %d LMB(s)\n", lmbs_to_add);
+
+	if (lmbs_to_add == 0)
+		return -EINVAL;
+
+	p = (*prop)->value;
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell_v2 *)p;
+
+	/* Validate that there are enough LMBs to satisfy the request */
+	for (i = 0; i < num_lmbs; i++) {
+		if (!(lmbs[i].flags & DRCONF_MEM_ASSIGNED))
+			lmbs_available += lmbs[i].num_seq_lmbs;
+	}
+
+	if (lmbs_available < lmbs_to_add)
+		return -EINVAL;
+
+	block_sz = memory_block_size_bytes();
+
+	/*
+	 * Find/add block(s) of LMBs that are not reserved
+	 */
+	for (i = 0; i < num_lmbs && lmbs_to_add != lmbs_added; i++) {
+
+		int nr  = (lmbs_to_add - lmbs_added) % lmbs[i].num_seq_lmbs;
+		u32 nsl = lmbs[i].num_seq_lmbs;
+		u64 ba  = lmbs[i].base_addr;
+
+		if (!(lmbs[i].flags & DRCONF_MEM_RESERVED_SW))
+			continue;
+
+		if (lmbs[i].num_seq_lmbs <= lmbs_to_add) {
+		/*
+		 * Add them all
+		 * Mark this LMB so we can remove it later if all
+		 * of the requested LMBs cannot be removed.
+		 */
+		} else {
+		/*
+		 * Grow the property by one LMB
+		 * Split the current LMB in two
+		 * + Duplicate this LMB (deal with head+block+tail)
+		 *   - Set first LMB to (num to add)
+		 *   - Set second LMB to (size of block) - (num to add)
+		 *     & update other params
+		 * + Increment 'num_lmbs'
+		 */
+			prop2 = dlpar_clone_extend_property(*prop,
+					sizeof(struct of_drconf_cell_v2));
+			dlpar_free_drconf_property(*prop);
+			*prop = prop2;
+			p = (*prop)->value;
+			num_lmbs = *p++;
+			lmbs = (struct of_drconf_cell_v2 *)p;
+
+			drconf_shift_lmbs_up(lmbs, num_lmbs+1, i);
+			drconf_copy_lmbs(lmbs, i+1, i);
+
+			drconf_set(lmbs, i, nsl - nr, lmbs[i].drc_index, ba);
+			drconf_set(lmbs, i+1, nr,
+				lmbs[i+1].drc_index+nsl-nr,
+				ba+((nsl-nr)*block_sz));
+
+			(*p)++;			/* + Increment 'num_lmbs' */
+			num_lmbs = (*p);
+		}
+
+		/*
+		 * Add the identified set of new memory blocks
+		 */
+		rc = dlpar_add_lmb_v2(&lmbs[i], lmbs[i].drc_index, nr);
+		if (rc)
+			continue;
+
+		lmbs_added += nr;
+
+		/* Mark this lmb so we can remove it later if all
+		 * of the requested LMBs cannot be added.
+		 */
+		lmbs[i].flags |= DRCONF_MEM_RESERVED_SW;
+	}
+
+	if (lmbs_added != lmbs_to_add) {
+		pr_err("Memory hot-add failed, removing any added LMBs\n");
+
+		for (i = 0; i < num_lmbs; i++) {
+			if (!(lmbs[i].flags & DRCONF_MEM_RESERVED_SW))
+				continue;
+
+			rc = dlpar_remove_lmb_v2(&lmbs[i], lmbs[i].drc_index,
+						lmbs[i].num_seq_lmbs);
+			if (rc)
+				pr_err("Failed to remove LMB, drc index %x\n",
+				       be32_to_cpu(lmbs[i].drc_index));
+
+			i += (lmbs[i].num_seq_lmbs - 1);
+		}
+		rc = -EINVAL;
+	} else {
+		for (i = 0; i < num_lmbs; i++) {
+			if (!(lmbs[i].flags & DRCONF_MEM_RESERVED_SW))
+				continue;
+
+			pr_info("Memory at %llx (drc index %x) was hot-added\n",
+				lmbs[i].base_addr, lmbs[i].drc_index);
+
+			lmbs[i].flags &= ~DRCONF_MEM_RESERVED_SW;
+		}
+	}
+
+	return rc;
+}
+
+static int dlpar_memory_add_by_index_v2(u32 drc_index, struct property 
**prop)
+{
+	struct of_drconf_cell_v2 *lmbs;
+	u32 num_lmbs, *p;
+	int i, lmb_found;
+	int rc;
+
+	pr_info("Attempting to hot-add LMB, drc index %x\n", drc_index);
+
+	p = (*prop)->value;
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell_v2 *)p;
+
+	lmb_found = 0;
+	for (i = 0; i < num_lmbs; i++) {
+		int fdi = lmbs[i].drc_index;
+		int ldi = lmbs[i].drc_index+lmbs[i].num_seq_lmbs-1;
+
+		if ((fdi <= drc_index) && (drc_index <= ldi)) {
+			int nr  = ldi - drc_index + 1;
+
+			lmb_found = 1;
+			rc = dlpar_add_lmb_v2(&lmbs[i], fdi, nr);
+			break;
+		}
+	}
+
+	if (!lmb_found)
+		rc = -EINVAL;
+
+	if (rc)
+		pr_info("Failed to hot-add memory, drc index %x\n", drc_index);
+	else
+		pr_info("Memory at %llx (drc index %x) was hot-added\n",
+			lmbs[i].base_addr, drc_index);
+
+	return rc;
+}
+
+
  #else
  static inline int pseries_remove_memblock(unsigned long base,
  					  unsigned int memblock_size)
@@ -373,11 +1001,23 @@ static int dlpar_remove_lmb(struct of_drconf_cell 
*lmb)
  	return -EOPNOTSUPP;
  }
  static int dlpar_memory_remove_by_count(u32 lmbs_to_remove,
-					struct property *prop)
+					struct property **prop)
+{
+	return -EOPNOTSUPP;
+}
+static int dlpar_memory_remove_by_index(u32 drc_index, struct property 
**prop)
+{
+	return -EOPNOTSUPP;
+}
+
+static int dlpar_memory_remove_by_count_v2(u32 lmbs_to_remove,
+					struct property **prop)
  {
  	return -EOPNOTSUPP;
  }
-static int dlpar_memory_remove_by_index(u32 drc_index, struct property 
*prop)
+
+static int dlpar_memory_remove_by_index_v2(u32 drc_index,
+					struct property **prop)
  {
  	return -EOPNOTSUPP;
  }
@@ -417,7 +1057,7 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)
  		return rc;
  	}

-	mem_block = lmb_to_memblock(lmb);
+	mem_block = lmb_to_memblock(lmb->base_addr);
  	if (!mem_block) {
  		remove_memory(nid, lmb->base_addr, block_sz);
  		dlpar_release_drc(lmb->drc_index);
@@ -436,7 +1076,7 @@ static int dlpar_add_lmb(struct of_drconf_cell *lmb)
  	return 0;
  }

-static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property 
*prop)
+static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property 
**prop)
  {
  	struct of_drconf_cell *lmbs;
  	u32 num_lmbs, *p;
@@ -449,7 +1089,7 @@ static int dlpar_memory_add_by_count(u32 
lmbs_to_add, struct property *prop)
  	if (lmbs_to_add == 0)
  		return -EINVAL;

-	p = prop->value;
+	p = (*prop)->value;
  	num_lmbs = *p++;
  	lmbs = (struct of_drconf_cell *)p;

@@ -502,7 +1142,7 @@ static int dlpar_memory_add_by_count(u32 
lmbs_to_add, struct property *prop)
  	return rc;
  }

-static int dlpar_memory_add_by_index(u32 drc_index, struct property *prop)
+static int dlpar_memory_add_by_index(u32 drc_index, struct property **prop)
  {
  	struct of_drconf_cell *lmbs;
  	u32 num_lmbs, *p;
@@ -511,7 +1151,7 @@ static int dlpar_memory_add_by_index(u32 drc_index, 
struct property *prop)

  	pr_info("Attempting to hot-add LMB, drc index %x\n", drc_index);

-	p = prop->value;
+	p = (*prop)->value;
  	num_lmbs = *p++;
  	lmbs = (struct of_drconf_cell *)p;

@@ -541,15 +1181,15 @@ static void dlpar_update_drconf_property(struct 
device_node *dn,
  {
  	struct of_drconf_cell *lmbs;
  	u32 num_lmbs, *p;
-	int i;
+	int i = 0;

  	/* Convert the property back to BE */
  	p = prop->value;
  	num_lmbs = *p;
  	*p = cpu_to_be32(*p);
  	p++;
-
  	lmbs = (struct of_drconf_cell *)p;
+
  	for (i = 0; i < num_lmbs; i++) {
  		lmbs[i].base_addr = cpu_to_be64(lmbs[i].base_addr);
  		lmbs[i].drc_index = cpu_to_be32(lmbs[i].drc_index);
@@ -561,10 +1201,55 @@ static void dlpar_update_drconf_property(struct 
device_node *dn,
  	rtas_hp_event = false;
  }

+static void dlpar_update_drconf_property_v2(struct device_node *dn,
+					 struct property *prop)
+{
+	struct of_drconf_cell_v2 *lmbs;
+	u32 num_lmbs, *p;
+	int i = 0;
+
+	/* Convert the property back to BE */
+	p = prop->value;
+	num_lmbs = *p;
+	*p = cpu_to_be32(*p);
+	p++;
+	lmbs = (struct of_drconf_cell_v2 *)p;
+
+	for (i = 0; i < num_lmbs; i++) {
+		lmbs[i].num_seq_lmbs = cpu_to_be32(lmbs[i].num_seq_lmbs);
+		lmbs[i].base_addr = cpu_to_be64(lmbs[i].base_addr);
+		lmbs[i].drc_index = cpu_to_be32(lmbs[i].drc_index);
+		lmbs[i].flags = cpu_to_be32(lmbs[i].flags);
+	}
+
+	rtas_hp_event = true;
+	of_update_property(dn, prop);
+	rtas_hp_event = false;
+}
+
+static struct dlpar_memory_ops dyn_mem_v1 = {
+	dlpar_clone_drconf_property,
+	dlpar_memory_add_by_count,
+	dlpar_memory_add_by_index,
+	dlpar_memory_remove_by_count,
+	dlpar_memory_remove_by_index,
+	dlpar_update_drconf_property,
+};
+
+static struct dlpar_memory_ops dyn_mem_v2 = {
+	dlpar_clone_drconf_property_v2,
+	dlpar_memory_add_by_count_v2,
+	dlpar_memory_add_by_index_v2,
+	dlpar_memory_remove_by_count_v2,
+	dlpar_memory_remove_by_index_v2,
+	dlpar_update_drconf_property_v2,
+};
+
  int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
  {
  	struct device_node *dn;
  	struct property *prop;
+	struct dlpar_memory_ops *ops;
  	u32 count, drc_index;
  	int rc;

@@ -573,13 +1258,18 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)

  	lock_device_hotplug();

+	if (firmware_has_feature(FW_FEATURE_RPS_DRC_INFO))
+		ops = &dyn_mem_v2;
+	else
+		ops = &dyn_mem_v1;
+
  	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
  	if (!dn) {
  		rc = -EINVAL;
  		goto dlpar_memory_out;
  	}

-	prop = dlpar_clone_drconf_property(dn);
+	prop = ops->clone_drconf_property(dn);
  	if (!prop) {
  		rc = -EINVAL;
  		goto dlpar_memory_out;
@@ -588,17 +1278,17 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
  	switch (hp_elog->action) {
  	case PSERIES_HP_ELOG_ACTION_ADD:
  		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
-			rc = dlpar_memory_add_by_count(count, prop);
+			rc = ops->add_by_count(count, &prop);
  		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
-			rc = dlpar_memory_add_by_index(drc_index, prop);
+			rc = ops->add_by_index(drc_index, &prop);
  		else
  			rc = -EINVAL;
  		break;
  	case PSERIES_HP_ELOG_ACTION_REMOVE:
  		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
-			rc = dlpar_memory_remove_by_count(count, prop);
+			rc = ops->remove_by_count(count, &prop);
  		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
-			rc = dlpar_memory_remove_by_index(drc_index, prop);
+			rc = ops->remove_by_index(drc_index, &prop);
  		else
  			rc = -EINVAL;
  		break;
@@ -611,7 +1301,7 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
  	if (rc)
  		dlpar_free_drconf_property(prop);
  	else
-		dlpar_update_drconf_property(dn, prop);
+		ops->update_drconf_property(dn, prop);

  dlpar_memory_out:
  	of_node_put(dn);
@@ -653,8 +1343,8 @@ static int pseries_add_mem_node(struct device_node *np)

  static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
  {
-	struct of_drconf_cell *new_drmem, *old_drmem;
  	unsigned long memblock_size;
+	struct of_drconf_cell *new_drmem, *old_drmem;
  	u32 entries;
  	__be32 *p;
  	int i, rc = -EINVAL;
@@ -670,9 +1360,16 @@ static int pseries_update_drconf_memory(struct 
of_reconfig_data *pr)
  	if (!p)
  		return -EINVAL;

+	entries = be32_to_cpu(*p++);
+	old_drmem = (struct of_drconf_cell *)p;
+
+	p = (__be32 *)pr->prop->value;
+	p++;
+	new_drmem = (struct of_drconf_cell *)p;
+
  	/* The first int of the property is the number of lmb's described
-	 * by the property. This is followed by an array of of_drconf_cell
-	 * entries. Get the number of entries and skip to the array of
+	 * by the property.  This is followed by an array of of_drconf_cell
+	 * entries.  Get the number of entries and skip to the array of
  	 * of_drconf_cell's.
  	 */
  	entries = be32_to_cpu(*p++);
@@ -686,19 +1383,81 @@ static int pseries_update_drconf_memory(struct 
of_reconfig_data *pr)
  		if ((be32_to_cpu(old_drmem[i].flags) & DRCONF_MEM_ASSIGNED) &&
  		    (!(be32_to_cpu(new_drmem[i].flags) & DRCONF_MEM_ASSIGNED))) {
  			rc = pseries_remove_memblock(
-				be64_to_cpu(old_drmem[i].base_addr),
-						     memblock_size);
+					be64_to_cpu(old_drmem[i].base_addr),
+					memblock_size);
  			break;
  		} else if ((!(be32_to_cpu(old_drmem[i].flags) &
-			    DRCONF_MEM_ASSIGNED)) &&
-			    (be32_to_cpu(new_drmem[i].flags) &
-			    DRCONF_MEM_ASSIGNED)) {
+					  DRCONF_MEM_ASSIGNED)) &&
+			     (be32_to_cpu(new_drmem[i].flags) &
+					  DRCONF_MEM_ASSIGNED)) {
  			rc = memblock_add(be64_to_cpu(old_drmem[i].base_addr),
-					  memblock_size);
+						      memblock_size);
  			rc = (rc < 0) ? -EINVAL : 0;
  			break;
  		}
  	}
+
+	return rc;
+}
+
+static int pseries_update_drconf_memory_v2(struct of_reconfig_data *pr)
+{
+	unsigned long memblock_size;
+	struct of_drconf_cell_v2 *new_drmem, *old_drmem;
+	u32 entries;
+	__be32 *p;
+	int i, rc = -EINVAL;
+
+	if (rtas_hp_event)
+		return 0;
+
+	memblock_size = pseries_memory_block_size();
+	if (!memblock_size)
+		return -EINVAL;
+
+	p = (__be32 *) pr->old_prop->value;
+	if (!p)
+		return -EINVAL;
+
+	/* The first int of the property is the number
+	 * of lmb's described by the property.
+	 */
+	entries = be32_to_cpu(*p++);
+	old_drmem = (struct of_drconf_cell_v2 *)p;
+
+	p = (__be32 *)pr->prop->value;
+	p++;
+	new_drmem = (struct of_drconf_cell_v2 *)p;
+
+	for (i = 0; i < entries; i++) {
+		u32 n2 = be32_to_cpu(new_drmem[i].num_seq_lmbs);
+		u64 base = be64_to_cpu(old_drmem[i].base_addr);
+		int j, done = 0, done_rc = 0;
+
+		for (j = 0; j < n2; j++) {
+			if ((old_drmem[i].flags & DRCONF_MEM_ASSIGNED) &&
+			    (!(new_drmem[i].flags & DRCONF_MEM_ASSIGNED))) {
+				rc = pseries_remove_memblock(
+						base,
+						memblock_size);
+				break;
+			} else if ((!(be32_to_cpu(old_drmem[i].flags) &
+				      DRCONF_MEM_ASSIGNED)) &&
+				   (!(old_drmem[i].flags &
+				      DRCONF_MEM_ASSIGNED))) {
+				rc = memblock_add(base, memblock_size);
+				done_rc = (rc < 0) ? -EINVAL : 0;
+				done = 1;
+			}
+			base += memblock_size;
+		}
+
+		if (done) {
+			rc = done_rc;
+			break;
+		}
+	}
+
  	return rc;
  }

@@ -718,6 +1477,8 @@ static int pseries_memory_notifier(struct 
notifier_block *nb,
  	case OF_RECONFIG_UPDATE_PROPERTY:
  		if (!strcmp(rd->prop->name, "ibm,dynamic-memory"))
  			err = pseries_update_drconf_memory(rd);
+		if (!strcmp(rd->prop->name, "ibm,dynamic-memory-v2"))
+			err = pseries_update_drconf_memory_v2(rd);
  		break;
  	}
  	return notifier_from_errno(err);
diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c 
b/arch/powerpc/platforms/pseries/pseries_energy.c
index 9276779..bd150f8 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -33,12 +33,24 @@ static int sysfs_entries;

  /* Helper routines */

+/* Align upwards - arithmetic mode (hence _a) */
+static inline uint8_t *align_upwards_a(uint8_t *stack, int offset,
+					uintptr_t align)
+{
+	uintptr_t addr  = (uintptr_t)stack;
+
+	addr += offset;
+	if (addr % align != 0)
+		addr += align - addr % align;
+	return (uint8_t *)addr;
+}
+
+
  /* Helper Routines to convert between drc_index to cpu numbers */

  static u32 cpu_to_drc_index(int cpu)
  {
  	struct device_node *dn = NULL;
-	const int *indexes;
  	int i;
  	int rc = 1;
  	u32 ret = 0;
@@ -46,18 +58,87 @@ static u32 cpu_to_drc_index(int cpu)
  	dn = of_find_node_by_path("/cpus");
  	if (dn == NULL)
  		goto err;
-	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
-	if (indexes == NULL)
-		goto err_of_node_put;
+
  	/* Convert logical cpu number to core number */
  	i = cpu_core_index_of_thread(cpu);
-	/*
-	 * The first element indexes[0] is the number of drc_indexes
-	 * returned in the list.  Hence i+1 will get the drc_index
-	 * corresponding to core number i.
-	 */
-	WARN_ON(i > indexes[0]);
-	ret = indexes[i + 1];
+
+	if (firmware_has_feature(FW_FEATURE_RPS_DRC_INFO)) {
+		const unsigned int *info = (const unsigned int *)4;
+		unsigned int entries, j, iw = i, fdi = 0;
+		unsigned int ldi = 0, n = 0, si = 0;
+
+		info = of_get_property(dn, "ibm,drc-info", NULL);
+		if (info == NULL)
+			goto err_of_node_put;
+
+		entries = be32_to_cpu(*info++);
+
+		for (j = 0; j < entries; j++) {
+			char *drc_type;
+			char *drc_name;
+
+			fdi = n = si = ldi = 0;
+
+			/* Get drc-type:encode-string; verify "CPU" */
+			drc_type = (char *)info;
+			if (strcmp(drc_type, "CPU"))
+				goto err;
+			info = (unsigned int *)align_upwards_a((uint8_t *)info,
+							strlen(drc_type)+1,
+							sizeof(u32));
+
+			/* Get/skip drc-name-prefix:encode-string */
+			drc_name = (char *)info;
+			info = (unsigned int *)align_upwards_a((uint8_t *)info,
+							strlen(drc_name)+1,
+							sizeof(u32));
+
+			/* Get drc-index-start:encode-int */
+			fdi = be32_to_cpu(*info);
+			info++;
+
+			/* Get/skip drc-name-suffix-start:encode-int (?) */
+			info++;
+
+			/* Get number-sequential-elements:encode-int */
+			n = be32_to_cpu(*info);
+			info++;
+
+			/* Get sequential-increment:encode-int */
+			si = be32_to_cpu(*info);
+			info++;
+
+			/* Get/skip drc-power-domain:encode-int */
+			info++;
+
+			/* Should now know end of current entry */
+
+			ldi = fdi + ((n-1)*si);
+
+			if (iw < ldi)
+				break;
+
+			WARN_ON(((iw-fdi)%si) != 0);
+		}
+		WARN_ON((n == 0) | (si == 0));
+
+		ret = ldi + (iw*si);
+	} else {
+		const int *indexes;
+
+		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
+		if (indexes == NULL)
+			goto err_of_node_put;
+
+		/*
+		 * The first element indexes[0] is the number of drc_indexes
+		 * returned in the list.  Hence i+1 will get the drc_index
+		 * corresponding to core number i.
+		 */
+		WARN_ON(i > indexes[0]);
+		ret = indexes[i + 1];
+	}
+
  	rc = 0;

  err_of_node_put:
@@ -78,21 +159,86 @@ static int drc_index_to_cpu(u32 drc_index)
  	dn = of_find_node_by_path("/cpus");
  	if (dn == NULL)
  		goto err;
-	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
-	if (indexes == NULL)
-		goto err_of_node_put;
-	/*
-	 * First element in the array is the number of drc_indexes
-	 * returned.  Search through the list to find the matching
-	 * drc_index and get the core number
-	 */
-	for (i = 0; i < indexes[0]; i++) {
-		if (indexes[i + 1] == drc_index)
+
+	if (firmware_has_feature(FW_FEATURE_RPS_DRC_INFO)) {
+		const unsigned int *info = (const  unsigned int *)dn;
+		unsigned int entries, j, ret;
+		unsigned int fdi = 0, ldi = 0, n = 0, si = 0;
+
+		info = of_get_property(dn, "ibm,drc-info", NULL);
+		if (info == NULL)
+			goto err_of_node_put;
+
+		entries = be32_to_cpu(*info++);
+
+		for (j = 0; j < entries; j++) {
+			char *drc_type;
+			char *drc_name;
+
+			fdi = n = si = ldi = 0;
+
+			/* Get drc-type:encode-string; verify "CPU" */
+			drc_type = (char *)info;
+			if (strcmp(drc_type, "CPU"))
+				goto err;
+			info = (unsigned int *)align_upwards_a((uint8_t *)info,
+							strlen(drc_type)+1,
+							sizeof(u32));
+
+			/* Get/skip drc-name-prefix:encode-string */
+			drc_name = (char *)info;
+			info = (unsigned int *)align_upwards_a((uint8_t *)info,
+							strlen(drc_name)+1,
+							sizeof(u32));
+
+			/* Get drc-index-start:encode-int */
+			fdi = be32_to_cpu(*info);
+			info++;
+
+			/* Get/skip drc-name-suffix-start:encode-int (?) */
+			info++;
+
+			/* Get number-sequential-elements:encode-int */
+			n = be32_to_cpu(*info);
+			info++;
+
+			/* Get sequential-increment:encode-int */
+			si = be32_to_cpu(*info);
+			info++;
+
+			/* Get/skip drc-power-domain:encode-int */
+			info++;
+
+			/* Should now know end of current entry */
+
+			ldi = fdi + ((n-1)*si);
+
+			WARN_ON(drc_index < fdi);
+			if (drc_index > ldi)
+				continue;
+
+			WARN_ON(((drc_index-fdi)%si) != 0);
+
+			ret = ((drc_index-fdi)/si);
  			break;
+		}
+	} else {
+		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
+		if (indexes == NULL)
+			goto err_of_node_put;
+		/*
+		 * First element in the array is the number of drc_indexes
+		 * returned.  Search through the list to find the matching
+		 * drc_index and get the core number
+		 */
+		for (i = 0; i < indexes[0]; i++) {
+			if (indexes[i + 1] == drc_index)
+				break;
+		}
+		/* Convert core number to logical cpu number */
+		cpu = cpu_first_thread_of_core(i);
+		rc = 0;
  	}
-	/* Convert core number to logical cpu number */
-	cpu = cpu_first_thread_of_core(i);
-	rc = 0;

  err_of_node_put:
  	of_node_put(dn);
diff --git a/drivers/pci/hotplug/rpadlpar_core.c 
b/drivers/pci/hotplug/rpadlpar_core.c
index b46b57d..068dcb2 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -27,6 +27,7 @@
  #include <linux/mutex.h>
  #include <asm/rtas.h>
  #include <asm/vio.h>
+#include <asm/firmware.h>

  #include "../pci.h"
  #include "rpaphp.h"
@@ -44,15 +45,14 @@ static struct device_node *find_vio_slot_node(char 
*drc_name)
  {
  	struct device_node *parent = of_find_node_by_name(NULL, "vdevice");
  	struct device_node *dn = NULL;
-	char *name;
  	int rc;

  	if (!parent)
  		return NULL;

  	while ((dn = of_get_next_child(parent, dn))) {
-		rc = rpaphp_get_drc_props(dn, NULL, &name, NULL, NULL);
-		if ((rc == 0) && (!strcmp(drc_name, name)))
+		rc = rpaphp_check_drc_props(dn, drc_name, NULL);
+		if (rc == 0)
  			break;
  	}

@@ -64,15 +64,12 @@ static struct device_node 
*find_php_slot_pci_node(char *drc_name,
  						  char *drc_type)
  {
  	struct device_node *np = NULL;
-	char *name;
-	char *type;
  	int rc;

  	while ((np = of_find_node_by_name(np, "pci"))) {
-		rc = rpaphp_get_drc_props(np, NULL, &name, &type, NULL);
+		rc = rpaphp_check_drc_props(np, drc_name, drc_type);
  		if (rc == 0)
-			if (!strcmp(drc_name, name) && !strcmp(drc_type, type))
-				break;
+			break;
  	}

  	return np;
diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index 7db024e..83fd3b8 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -93,6 +93,8 @@ int rpaphp_get_sensor_state(struct slot *slot, int 
*state);
  int rpaphp_add_slot(struct device_node *dn);
  int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
  		char **drc_name, char **drc_type, int *drc_power_domain);
+int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
+		char *drc_type);

  /* rpaphp_slot.c */
  void dealloc_slot_struct(struct slot *slot);
diff --git a/drivers/pci/hotplug/rpaphp_core.c 
b/drivers/pci/hotplug/rpaphp_core.c
index 611f605..bd9eb7d 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -30,6 +30,7 @@
  #include <linux/smp.h>
  #include <linux/init.h>
  #include <linux/vmalloc.h>
+#include <asm/firmware.h>
  #include <asm/eeh.h>       /* for eeh_add_device() */
  #include <asm/rtas.h>		/* rtas_call */
  #include <asm/pci-bridge.h>	/* for pci_controller */
@@ -142,15 +143,6 @@ static enum pci_bus_speed get_max_bus_speed(struct 
slot *slot)
  	case 5:
  	case 6:
  		speed = PCI_SPEED_33MHz;	/* speed for case 1-6 */
-		break;
-	case 7:
-	case 8:
-		speed = PCI_SPEED_66MHz;
-		break;
-	case 11:
-	case 14:
-		speed = PCI_SPEED_66MHz_PCIX;
-		break;
  	case 12:
  	case 15:
  		speed = PCI_SPEED_100MHz_PCIX;
@@ -244,6 +236,124 @@ int rpaphp_get_drc_props(struct device_node *dn, 
int *drc_index,
  }
  EXPORT_SYMBOL_GPL(rpaphp_get_drc_props);

+/* Verify the existence of 'drc_name' and/or 'drc_type' within the current
+ * node.  First obtain it's my-drc-index property.  Next obtain the DRC 
info
+ * from it's parent.  Use the my-drc-index for correlation, and 
obtain/validate
+ * the requested properties.
+ */
+
+/* Align upwards - arithmetic mode (hence _a) */
+static inline uint8_t *align_upwards_a(uint8_t *stack, int offset,
+					uintptr_t align)
+{
+	uintptr_t addr  = (uintptr_t)stack;
+
+	addr += offset;
+	if (addr % align != 0)
+		addr += align - addr % align;
+	return (uint8_t *)addr;
+}
+
+int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
+			char *drc_type)
+{
+	const unsigned int *my_index;
+	char *name_tmp, *type_tmp;
+	int i, rc;
+
+	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
+	if (!my_index) {
+		/* Node isn't DLPAR/hotplug capable */
+		return -EINVAL;
+	}
+
+	if (firmware_has_feature(FW_FEATURE_RPS_DRC_INFO)) {
+		const unsigned int *info = (const unsigned int *)dn;
+		unsigned int entries, j;
+		unsigned int fdi = 0, ldi = 0, n = 0, si = 0;
+		int ret = -EINVAL;
+
+		info = of_get_property(dn->parent, "ibm,drc-info", NULL);
+		if (info == NULL)
+			return -EINVAL;
+
+		entries = be32_to_cpu(*info);
+
+		for (j = 0; j < entries; j++) {
+			char *drc_type;
+			char *drc_name;
+
+			fdi = n = si = ldi = 0;
+
+			/* Get drc-type:encode-string; verify it */
+			drc_type = (char *)info;
+			info = (unsigned int *)align_upwards_a((uint8_t *)info,
+							strlen(drc_type)+1,
+							sizeof(u32));
+
+			/* Get drc-name-prefix:encode-string; verify it? */
+			drc_name = (char *)info;
+			info = (unsigned int *)align_upwards_a((uint8_t *)info,
+							strlen(drc_name)+1,
+							sizeof(u32));
+
+			/* Get sequential-increment:encode-int */
+			si = be32_to_cpu(*info);
+			info++;
+
+			/* Get/skip drc-power-domain:encode-int */
+			info++;
+
+			/* Should now know end of current entry */
+
+			ldi = fdi + ((n-1)*si);
+
+			WARN_ON(*my_index < fdi);
+			if (*my_index > ldi)
+				continue;
+
+			WARN_ON(((*my_index-fdi)%si) != 0);
+
+			ret = ((*my_index-fdi)/si);
+			break;
+		}
+		/* Found it */
+	} else {
+		const int *indexes, *names;
+		const int *types, *domains;
+
+		rc = get_children_props(dn->parent, &indexes, &names, &types,
+					&domains);
+		if (rc < 0)
+			return -EINVAL;
+
+		name_tmp = (char *) &names[1];
+		type_tmp = (char *) &types[1];
+
+		/* Iterate through parent properties, looking for
+		 * my-drc-index
+		 */
+		for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
+			if ((unsigned int) indexes[i + 1] == *my_index) {
+				break;
+			} else {
+				name_tmp += (strlen(name_tmp) + 1);
+				type_tmp += (strlen(type_tmp) + 1);
+			}
+		}
+
+		if (((drc_name == NULL) ||
+		    (drc_name && !strcmp(drc_name, name_tmp))) &&
+		    ((drc_type == NULL) ||
+		     (drc_type && !strcmp(drc_type, type_tmp))))
+			return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(rpaphp_check_drc_props);
+
+
  static int is_php_type(char *drc_type)
  {
  	unsigned long value;
