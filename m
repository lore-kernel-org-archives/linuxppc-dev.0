Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17773.28334.978291.968642@cargo.ozlabs.ibm.com>
Date: Wed, 29 Nov 2006 22:27:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Support ibm,dynamic-reconfiguration-memory nodes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For PAPR partitions with large amounts of memory, the firmware has an
alternative, more compact representation for the information about the
memory in the partition and its NUMA associativity information.  This
adds the code to the kernel to parse this alternative representation,
and also sets the bit that tells firmware that we can handle the
alternative representation.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index c18dbe7..bdf0e63 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -804,6 +804,55 @@ static unsigned long __init dt_mem_next_
 	return of_read_ulong(p, s);
 }
 
+#ifdef CONFIG_PPC64
+/*
+ * Interpret the ibm,dynamic-memory property in the
+ * /ibm,dynamic-reconfiguration-memory node.
+ * This contains a list of memory blocks along with NUMA affinity
+ * information.
+ */
+static int __init early_init_dt_scan_drconf_memory(unsigned long node)
+{
+	cell_t *dm, *ls;
+	unsigned long l, n;
+	unsigned long base, size, lmb_size, flags;
+
+	ls = (cell_t *)of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
+	if (ls == NULL || l < dt_root_size_cells * sizeof(cell_t))
+		return 0;
+	lmb_size = dt_mem_next_cell(dt_root_size_cells, &ls);
+
+	dm = (cell_t *)of_get_flat_dt_prop(node, "ibm,dynamic-memory", &l);
+	if (dm == NULL || l < sizeof(cell_t))
+		return 0;
+
+	n = *dm++;	/* number of entries */
+	if (l < (n * (dt_root_addr_cells + 4) + 1) * sizeof(cell_t))
+		return 0;
+
+	for (; n != 0; --n) {
+		base = dt_mem_next_cell(dt_root_addr_cells, &dm);
+		flags = dm[3];
+		/* skip DRC index, pad, assoc. list index, flags */
+		dm += 4;
+		/* skip this block if the reserved bit is set */
+		if (flags & 0x80)
+			continue;
+		size = lmb_size;
+		if (iommu_is_off) {
+			if (base >= 0x80000000ul)
+				continue;
+			if ((base + size) > 0x80000000ul)
+				size = 0x80000000ul - base;
+		}
+		lmb_add(base, size);
+	}
+
+	return 0;
+}
+#else
+#define early_init_dt_scan_drconf_memory(node)	0
+#endif /* CONFIG_PPC64 */
 
 static int __init early_init_dt_scan_memory(unsigned long node,
 					    const char *uname, int depth, void *data)
@@ -812,6 +861,11 @@ static int __init early_init_dt_scan_mem
 	cell_t *reg, *endp;
 	unsigned long l;
 
+	/* Look for the ibm,dynamic-reconfiguration-memory node */
+	if (depth == 1 &&
+	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0)
+		return early_init_dt_scan_drconf_memory(node);
+
 	/* We are scanning "memory" nodes only */
 	if (type == NULL) {
 		/*
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 396109a..66c893d 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -678,7 +678,7 @@ static unsigned char ibm_architecture_ve
 	/* option vector 5: PAPR/OF options */
 	3 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
-	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES,
+	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY,
 };
 
 /* Old method - ELF header with PT_NOTE sections */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 9da01dc..d8cdd2a 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -295,6 +295,59 @@ static unsigned long __init numa_enforce
 	return lmb_end_of_DRAM() - start;
 }
 
+/*
+ * Extract NUMA information from the ibm,dynamic-reconfiguration-memory
+ * node.  This assumes n_mem_{addr,size}_cells have been set.
+ */
+static void __init parse_drconf_memory(struct device_node *memory)
+{
+	const unsigned int *lm, *dm, *aa;
+	unsigned int ls, ld, la;
+	unsigned int n, aam, aalen;
+	unsigned long lmb_size, size;
+	int nid, default_nid = 0;
+	unsigned int start, ai, flags;
+
+	lm = get_property(memory, "ibm,lmb-size", &ls);
+	dm = get_property(memory, "ibm,dynamic-memory", &ld);
+	aa = get_property(memory, "ibm,associativity-lookup-arrays", &la);
+	if (!lm || !dm || !aa ||
+	    ls < sizeof(unsigned int) || ld < sizeof(unsigned int) ||
+	    la < 2 * sizeof(unsigned int))
+		return;
+
+	lmb_size = read_n_cells(n_mem_size_cells, &lm);
+	n = *dm++;		/* number of LMBs */
+	aam = *aa++;		/* number of associativity lists */
+	aalen = *aa++;		/* length of each associativity list */
+	if (ld < (n * (n_mem_addr_cells + 4) + 1) * sizeof(unsigned int) ||
+	    la < (aam * aalen + 2) * sizeof(unsigned int))
+		return;
+
+	for (; n != 0; --n) {
+		start = read_n_cells(n_mem_addr_cells, &dm);
+		ai = dm[2];
+		flags = dm[3];	/* flags & 0x40 means assoc index is invalid */
+		dm += 4;
+		nid = default_nid;
+		if (min_common_depth > 0 && min_common_depth <= aalen &&
+		    (flags & 0x40) == 0 && ai < aam) {
+			/* this is like of_node_to_nid_single */
+			nid = aa[ai * aalen + min_common_depth - 1];
+			if (nid == 0xffff || nid >= MAX_NUMNODES)
+				nid = default_nid;
+		}
+		node_set_online(nid);
+
+		size = numa_enforce_memory_limit(start, lmb_size);
+		if (!size)
+			continue;
+
+		add_active_range(nid, start >> PAGE_SHIFT,
+				 (start >> PAGE_SHIFT) + (size >> PAGE_SHIFT));
+	}
+}
+
 static int __init parse_numa_properties(void)
 {
 	struct device_node *cpu = NULL;
@@ -385,6 +438,14 @@ new_range:
 			goto new_range;
 	}
 
+	/*
+	 * Now do the same thing for each LMB listed in the ibm,dynamic-memory
+	 * property in the ibm,dynamic-reconfiguration-memory node.
+	 */
+	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (memory)
+		parse_drconf_memory(memory);
+
 	return 0;
 }
 
