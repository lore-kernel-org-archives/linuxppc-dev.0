Return-Path: <chandru@in.ibm.com>
Received: from e28esmtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33C4DDDF5D
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 00:28:23 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id m7TESJpS019421
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 19:58:19 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7TESJSv1744978
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 19:58:19 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id m7TESITq021493
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 19:58:19 +0530
From: Chandru <chandru@in.ibm.com>
To: paulus@samba.org
Subject: [PATCH][V3] powerpc: add support for dynamic reconfiguration memory
	in kexec/kdump kernels
Date: Fri, 29 Aug 2008 19:58:16 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808291958.16496.chandru@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

kdump kernel needs to use only those memory regions that it is allowed to use 
(crashkernel, rtas, tce ..etc ). Each of these regions have their own sizes 
and are currently added under  'linux,usable-memory' property under each 
memory@ node of the device tree.  ibm,dynamic-memory property of 
ibm,dynamic-reconfiguration-memory node (on power6) now stores in it the 
representation for most of the logical memory blocks with the size of each 
memory block being a constant (lmb_size).  If one or more or part of the above 
mentioned regions lie under one of the lmb from ibm,dynamic-memory property, 
there is a need to identify those regions within the given lmb. Following 
patch recognizes a new property 'linux,drconf-usable-memory' property added by 
kexec-tools. Each entry in this property is of the form 'a counter'  followed 
by those many (base, size) duple for the above mentioned regions.

Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
---

Patch was tested on a power6 box. Could you pls add this patch to powerpc git 
tree ? . Thanks,

 arch/powerpc/kernel/prom.c |   40 +++++++++++++++--
 arch/powerpc/mm/numa.c     |   79 +++++++++++++++++++++++++++--------
 2 files changed, 96 insertions(+), 23 deletions(-)

diff -Naurp powerpc-orig/arch/powerpc/kernel/prom.c 
powerpc/arch/powerpc/kernel/prom.c
--- powerpc-orig/arch/powerpc/kernel/prom.c	2008-08-14 08:23:25.000000000 +0530
+++ powerpc/arch/powerpc/kernel/prom.c	2008-08-14 14:35:24.000000000 +0530
@@ -888,9 +888,10 @@ static u64 __init dt_mem_next_cell(int s
  */
 static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 {
-	cell_t *dm, *ls;
+	cell_t *dm, *ls, *usm;
 	unsigned long l, n, flags;
 	u64 base, size, lmb_size;
+	unsigned int is_kexec_kdump = 0, rngs;
 
 	ls = (cell_t *)of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
 	if (ls == NULL || l < dt_root_size_cells * sizeof(cell_t))
@@ -905,6 +906,12 @@ static int __init early_init_dt_scan_drc
 	if (l < (n * (dt_root_addr_cells + 4) + 1) * sizeof(cell_t))
 		return 0;
 
+	/* check if this is a kexec/kdump kernel. */
+	usm = (cell_t *)of_get_flat_dt_prop(node, "linux,drconf-usable-memory",
+						 &l);
+	if (usm != NULL)
+		is_kexec_kdump = 1;
+
 	for (; n != 0; --n) {
 		base = dt_mem_next_cell(dt_root_addr_cells, &dm);
 		flags = dm[3];
@@ -915,13 +922,34 @@ static int __init early_init_dt_scan_drc
 		if ((flags & 0x80) || !(flags & 0x8))
 			continue;
 		size = lmb_size;
-		if (iommu_is_off) {
-			if (base >= 0x80000000ul)
+		rngs = 1;
+		if (is_kexec_kdump) {
+			/*
+			 * For each lmb in ibm,dynamic-memory, a corresponding
+			 * entry in linux,drconf-usable-memory property contains
+			 * a counter 'p' followed by 'p' (base, size) duple.
+			 * Now read the counter from
+			 * linux,drconf-usable-memory property
+			 */
+			rngs = dt_mem_next_cell(dt_root_size_cells, &usm);
+			if (!rngs) /* there are no (base, size) duple */
 				continue;
-			if ((base + size) > 0x80000000ul)
-				size = 0x80000000ul - base;
 		}
-		lmb_add(base, size);
+		do {
+			if (is_kexec_kdump) {
+				base = dt_mem_next_cell(dt_root_addr_cells,
+							 &usm);
+				size = dt_mem_next_cell(dt_root_size_cells,
+							 &usm);
+			}
+			if (iommu_is_off) {
+				if (base >= 0x80000000ul)
+					continue;
+				if ((base + size) > 0x80000000ul)
+					size = 0x80000000ul - base;
+			}
+			lmb_add(base, size);
+		} while (--rngs);
 	}
 	lmb_dump_all();
 	return 0;
diff -Naurp powerpc-orig/arch/powerpc/mm/numa.c powerpc/arch/powerpc/mm/numa.c
--- powerpc-orig/arch/powerpc/mm/numa.c	2008-08-14 08:23:25.000000000 +0530
+++ powerpc/arch/powerpc/mm/numa.c	2008-08-14 14:35:42.000000000 +0530
@@ -150,6 +150,21 @@ static const int *of_get_associativity(s
 	return of_get_property(dev, "ibm,associativity", NULL);
 }
 
+/*
+ * Returns the property linux,drconf-usable-memory if
+ * it exists (the property exists only in kexec/kdump kernels,
+ * added by kexec-tools)
+ */
+static const u32 *of_get_usable_memory(struct device_node *memory)
+{
+	const u32 *prop;
+	u32 len;
+	prop = of_get_property(memory, "linux,drconf-usable-memory", &len);
+	if (!prop || len < sizeof(unsigned int))
+		return 0;
+	return prop;
+}
+
 /* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
  * info is found.
  */
@@ -487,14 +502,29 @@ static unsigned long __init numa_enforce
 }
 
 /*
+ * Reads the counter for a given entry in
+ * linux,drconf-usable-memory property
+ */
+static inline int __init read_usm_ranges(const u32 **usm)
+{
+	/*
+	 * For each lmb in ibm,dynamic-memory a corresponding
+	 * entry in linux,drconf-usable-memory property contains
+	 * a counter followed by that many (base, size) duple.
+	 * read the counter from linux,drconf-usable-memory
+	 */
+	return read_n_cells(n_mem_size_cells, usm);
+}
+
+/*
  * Extract NUMA information from the ibm,dynamic-reconfiguration-memory
  * node.  This assumes n_mem_{addr,size}_cells have been set.
  */
 static void __init parse_drconf_memory(struct device_node *memory)
 {
-	const u32 *dm;
-	unsigned int n, rc;
-	unsigned long lmb_size, size;
+	const u32 *dm, *usm;
+	unsigned int n, rc, ranges, is_kexec_kdump = 0;
+	unsigned long lmb_size, base, size, sz;
 	int nid;
 	struct assoc_arrays aa;
 
@@ -510,6 +540,11 @@ static void __init parse_drconf_memory(s
 	if (rc)
 		return;
 
+	/* check if this is a kexec/kdump kernel */
+	usm = of_get_usable_memory(memory);
+	if (usm != NULL)
+		is_kexec_kdump = 1;
+
 	for (; n != 0; --n) {
 		struct of_drconf_cell drmem;
 
@@ -521,21 +556,31 @@ static void __init parse_drconf_memory(s
 		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
 			continue;
 
-		nid = of_drconf_to_nid_single(&drmem, &aa);
-
-		fake_numa_create_new_node(
-				((drmem.base_addr + lmb_size) >> PAGE_SHIFT),
+		base = drmem.base_addr;
+		size = lmb_size;
+		ranges = 1;
+
+		if (is_kexec_kdump) {
+			ranges = read_usm_ranges(&usm);
+			if (!ranges) /* there are no (base, size) duple */
+				continue;
+		}
+		do {
+			if (is_kexec_kdump) {
+				base = read_n_cells(n_mem_addr_cells, &usm);
+				size = read_n_cells(n_mem_size_cells, &usm);
+			}
+			nid = of_drconf_to_nid_single(&drmem, &aa);
+			fake_numa_create_new_node(
+				((base + size) >> PAGE_SHIFT),
 					   &nid);
-
-		node_set_online(nid);
-
-		size = numa_enforce_memory_limit(drmem.base_addr, lmb_size);
-		if (!size)
-			continue;
-
-		add_active_range(nid, drmem.base_addr >> PAGE_SHIFT,
-				 (drmem.base_addr >> PAGE_SHIFT)
-				 + (size >> PAGE_SHIFT));
+			node_set_online(nid);
+			sz = numa_enforce_memory_limit(base, size);
+			if (sz)
+				add_active_range(nid, base >> PAGE_SHIFT,
+						 (base >> PAGE_SHIFT)
+						 + (sz >> PAGE_SHIFT));
+		} while (--ranges);
 	}
 }
