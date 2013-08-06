Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 27/63] powerpc: Make NUMA device node code endian safe
Date: Wed,  7 Aug 2013 02:01:44 +1000
Message-Id: <1375804940-22050-28-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alistair Popple <alistair@popple.id.au>

The device tree is big endian so make sure we byteswap on little
endian. We assume any pHyp calls also return big endian results in
memory.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/mm/numa.c | 100 +++++++++++++++++++++++++------------------------
 1 file changed, 52 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 501e32c..c916127 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -58,7 +58,7 @@ static int form1_affinity;
 
 #define MAX_DISTANCE_REF_POINTS 4
 static int distance_ref_points_depth;
-static const unsigned int *distance_ref_points;
+static const __be32 *distance_ref_points;
 static int distance_lookup_table[MAX_NUMNODES][MAX_DISTANCE_REF_POINTS];
 
 /*
@@ -179,7 +179,7 @@ static void unmap_cpu_from_node(unsigned long cpu)
 #endif /* CONFIG_HOTPLUG_CPU || CONFIG_PPC_SPLPAR */
 
 /* must hold reference to node during call */
-static const int *of_get_associativity(struct device_node *dev)
+static const __be32 *of_get_associativity(struct device_node *dev)
 {
 	return of_get_property(dev, "ibm,associativity", NULL);
 }
@@ -189,9 +189,9 @@ static const int *of_get_associativity(struct device_node *dev)
  * it exists (the property exists only in kexec/kdump kernels,
  * added by kexec-tools)
  */
-static const u32 *of_get_usable_memory(struct device_node *memory)
+static const __be32 *of_get_usable_memory(struct device_node *memory)
 {
-	const u32 *prop;
+	const __be32 *prop;
 	u32 len;
 	prop = of_get_property(memory, "linux,drconf-usable-memory", &len);
 	if (!prop || len < sizeof(unsigned int))
@@ -219,7 +219,7 @@ int __node_distance(int a, int b)
 }
 
 static void initialize_distance_lookup_table(int nid,
-		const unsigned int *associativity)
+		const __be32 *associativity)
 {
 	int i;
 
@@ -227,29 +227,32 @@ static void initialize_distance_lookup_table(int nid,
 		return;
 
 	for (i = 0; i < distance_ref_points_depth; i++) {
-		distance_lookup_table[nid][i] =
-			associativity[distance_ref_points[i]];
+		const __be32 *entry;
+
+		entry = &associativity[be32_to_cpu(distance_ref_points[i])];
+		distance_lookup_table[nid][i] = of_read_number(entry, 1);
 	}
 }
 
 /* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
  * info is found.
  */
-static int associativity_to_nid(const unsigned int *associativity)
+static int associativity_to_nid(const __be32 *associativity)
 {
 	int nid = -1;
 
 	if (min_common_depth == -1)
 		goto out;
 
-	if (associativity[0] >= min_common_depth)
-		nid = associativity[min_common_depth];
+	if (of_read_number(associativity, 1) >= min_common_depth)
+		nid = of_read_number(&associativity[min_common_depth], 1);
 
 	/* POWER4 LPAR uses 0xffff as invalid node */
 	if (nid == 0xffff || nid >= MAX_NUMNODES)
 		nid = -1;
 
-	if (nid > 0 && associativity[0] >= distance_ref_points_depth)
+	if (nid > 0 &&
+	    of_read_number(associativity, 1) >= distance_ref_points_depth)
 		initialize_distance_lookup_table(nid, associativity);
 
 out:
@@ -262,7 +265,7 @@ out:
 static int of_node_to_nid_single(struct device_node *device)
 {
 	int nid = -1;
-	const unsigned int *tmp;
+	const __be32 *tmp;
 
 	tmp = of_get_associativity(device);
 	if (tmp)
@@ -334,7 +337,7 @@ static int __init find_min_common_depth(void)
 	}
 
 	if (form1_affinity) {
-		depth = distance_ref_points[0];
+		depth = of_read_number(distance_ref_points, 1);
 	} else {
 		if (distance_ref_points_depth < 2) {
 			printk(KERN_WARNING "NUMA: "
@@ -342,7 +345,7 @@ static int __init find_min_common_depth(void)
 			goto err;
 		}
 
-		depth = distance_ref_points[1];
+		depth = of_read_number(&distance_ref_points[1], 1);
 	}
 
 	/*
@@ -376,12 +379,12 @@ static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
 	of_node_put(memory);
 }
 
-static unsigned long read_n_cells(int n, const unsigned int **buf)
+static unsigned long read_n_cells(int n, const __be32 **buf)
 {
 	unsigned long result = 0;
 
 	while (n--) {
-		result = (result << 32) | **buf;
+		result = (result << 32) | of_read_number(*buf, 1);
 		(*buf)++;
 	}
 	return result;
@@ -391,17 +394,17 @@ static unsigned long read_n_cells(int n, const unsigned int **buf)
  * Read the next memblock list entry from the ibm,dynamic-memory property
  * and return the information in the provided of_drconf_cell structure.
  */
-static void read_drconf_cell(struct of_drconf_cell *drmem, const u32 **cellp)
+static void read_drconf_cell(struct of_drconf_cell *drmem, const __be32 **cellp)
 {
-	const u32 *cp;
+	const __be32 *cp;
 
 	drmem->base_addr = read_n_cells(n_mem_addr_cells, cellp);
 
 	cp = *cellp;
-	drmem->drc_index = cp[0];
-	drmem->reserved = cp[1];
-	drmem->aa_index = cp[2];
-	drmem->flags = cp[3];
+	drmem->drc_index = of_read_number(cp, 1);
+	drmem->reserved = of_read_number(&cp[1], 1);
+	drmem->aa_index = of_read_number(&cp[2], 1);
+	drmem->flags = of_read_number(&cp[3], 1);
 
 	*cellp = cp + 4;
 }
@@ -413,16 +416,16 @@ static void read_drconf_cell(struct of_drconf_cell *drmem, const u32 **cellp)
  * list entries followed by N memblock list entries.  Each memblock list entry
  * contains information as laid out in the of_drconf_cell struct above.
  */
-static int of_get_drconf_memory(struct device_node *memory, const u32 **dm)
+static int of_get_drconf_memory(struct device_node *memory, const __be32 **dm)
 {
-	const u32 *prop;
+	const __be32 *prop;
 	u32 len, entries;
 
 	prop = of_get_property(memory, "ibm,dynamic-memory", &len);
 	if (!prop || len < sizeof(unsigned int))
 		return 0;
 
-	entries = *prop++;
+	entries = of_read_number(prop++, 1);
 
 	/* Now that we know the number of entries, revalidate the size
 	 * of the property read in to ensure we have everything
@@ -440,7 +443,7 @@ static int of_get_drconf_memory(struct device_node *memory, const u32 **dm)
  */
 static u64 of_get_lmb_size(struct device_node *memory)
 {
-	const u32 *prop;
+	const __be32 *prop;
 	u32 len;
 
 	prop = of_get_property(memory, "ibm,lmb-size", &len);
@@ -453,7 +456,7 @@ static u64 of_get_lmb_size(struct device_node *memory)
 struct assoc_arrays {
 	u32	n_arrays;
 	u32	array_sz;
-	const u32 *arrays;
+	const __be32 *arrays;
 };
 
 /*
@@ -469,15 +472,15 @@ struct assoc_arrays {
 static int of_get_assoc_arrays(struct device_node *memory,
 			       struct assoc_arrays *aa)
 {
-	const u32 *prop;
+	const __be32 *prop;
 	u32 len;
 
 	prop = of_get_property(memory, "ibm,associativity-lookup-arrays", &len);
 	if (!prop || len < 2 * sizeof(unsigned int))
 		return -1;
 
-	aa->n_arrays = *prop++;
-	aa->array_sz = *prop++;
+	aa->n_arrays = of_read_number(prop++, 1);
+	aa->array_sz = of_read_number(prop++, 1);
 
 	/* Now that we know the number of arrays and size of each array,
 	 * revalidate the size of the property read in.
@@ -504,7 +507,7 @@ static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
 	    !(drmem->flags & DRCONF_MEM_AI_INVALID) &&
 	    drmem->aa_index < aa->n_arrays) {
 		index = drmem->aa_index * aa->array_sz + min_common_depth - 1;
-		nid = aa->arrays[index];
+		nid = of_read_number(&aa->arrays[index], 1);
 
 		if (nid == 0xffff || nid >= MAX_NUMNODES)
 			nid = default_nid;
@@ -595,7 +598,7 @@ static unsigned long __init numa_enforce_memory_limit(unsigned long start,
  * Reads the counter for a given entry in
  * linux,drconf-usable-memory property
  */
-static inline int __init read_usm_ranges(const u32 **usm)
+static inline int __init read_usm_ranges(const __be32 **usm)
 {
 	/*
 	 * For each lmb in ibm,dynamic-memory a corresponding
@@ -612,7 +615,7 @@ static inline int __init read_usm_ranges(const u32 **usm)
  */
 static void __init parse_drconf_memory(struct device_node *memory)
 {
-	const u32 *uninitialized_var(dm), *usm;
+	const __be32 *uninitialized_var(dm), *usm;
 	unsigned int n, rc, ranges, is_kexec_kdump = 0;
 	unsigned long lmb_size, base, size, sz;
 	int nid;
@@ -721,7 +724,7 @@ static int __init parse_numa_properties(void)
 		unsigned long size;
 		int nid;
 		int ranges;
-		const unsigned int *memcell_buf;
+		const __be32 *memcell_buf;
 		unsigned int len;
 
 		memcell_buf = of_get_property(memory,
@@ -1106,7 +1109,7 @@ early_param("numa", early_numa);
 static int hot_add_drconf_scn_to_nid(struct device_node *memory,
 				     unsigned long scn_addr)
 {
-	const u32 *dm;
+	const __be32 *dm;
 	unsigned int drconf_cell_cnt, rc;
 	unsigned long lmb_size;
 	struct assoc_arrays aa;
@@ -1159,7 +1162,7 @@ int hot_add_node_scn_to_nid(unsigned long scn_addr)
 	for_each_node_by_type(memory, "memory") {
 		unsigned long start, size;
 		int ranges;
-		const unsigned int *memcell_buf;
+		const __be32 *memcell_buf;
 		unsigned int len;
 
 		memcell_buf = of_get_property(memory, "reg", &len);
@@ -1232,7 +1235,7 @@ static u64 hot_add_drconf_memory_max(void)
         struct device_node *memory = NULL;
         unsigned int drconf_cell_cnt = 0;
         u64 lmb_size = 0;
-        const u32 *dm = 0;
+	const __be32 *dm = 0;
 
         memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
         if (memory) {
@@ -1337,40 +1340,41 @@ static int update_cpu_associativity_changes_mask(void)
  * Convert the associativity domain numbers returned from the hypervisor
  * to the sequence they would appear in the ibm,associativity property.
  */
-static int vphn_unpack_associativity(const long *packed, unsigned int *unpacked)
+static int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
 {
 	int i, nr_assoc_doms = 0;
-	const u16 *field = (const u16*) packed;
+	const __be16 *field = (const __be16 *) packed;
 
 #define VPHN_FIELD_UNUSED	(0xffff)
 #define VPHN_FIELD_MSB		(0x8000)
 #define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
 
 	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
-		if (*field == VPHN_FIELD_UNUSED) {
+		if (be16_to_cpup(field) == VPHN_FIELD_UNUSED) {
 			/* All significant fields processed, and remaining
 			 * fields contain the reserved value of all 1's.
 			 * Just store them.
 			 */
-			unpacked[i] = *((u32*)field);
+			unpacked[i] = *((__be32 *)field);
 			field += 2;
-		} else if (*field & VPHN_FIELD_MSB) {
+		} else if (be16_to_cpup(field) & VPHN_FIELD_MSB) {
 			/* Data is in the lower 15 bits of this field */
-			unpacked[i] = *field & VPHN_FIELD_MASK;
+			unpacked[i] = cpu_to_be32(
+				be16_to_cpup(field) & VPHN_FIELD_MASK);
 			field++;
 			nr_assoc_doms++;
 		} else {
 			/* Data is in the lower 15 bits of this field
 			 * concatenated with the next 16 bit field
 			 */
-			unpacked[i] = *((u32*)field);
+			unpacked[i] = *((__be32 *)field);
 			field += 2;
 			nr_assoc_doms++;
 		}
 	}
 
 	/* The first cell contains the length of the property */
-	unpacked[0] = nr_assoc_doms;
+	unpacked[0] = cpu_to_be32(nr_assoc_doms);
 
 	return nr_assoc_doms;
 }
@@ -1379,7 +1383,7 @@ static int vphn_unpack_associativity(const long *packed, unsigned int *unpacked)
  * Retrieve the new associativity information for a virtual processor's
  * home node.
  */
-static long hcall_vphn(unsigned long cpu, unsigned int *associativity)
+static long hcall_vphn(unsigned long cpu, __be32 *associativity)
 {
 	long rc;
 	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
@@ -1393,7 +1397,7 @@ static long hcall_vphn(unsigned long cpu, unsigned int *associativity)
 }
 
 static long vphn_get_associativity(unsigned long cpu,
-					unsigned int *associativity)
+					__be32 *associativity)
 {
 	long rc;
 
@@ -1450,7 +1454,7 @@ int arch_update_cpu_topology(void)
 {
 	unsigned int cpu, sibling, changed = 0;
 	struct topology_update_data *updates, *ud;
-	unsigned int associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	cpumask_t updated_cpus;
 	struct device *dev;
 	int weight, new_nid, i = 0;
-- 
1.8.1.2
