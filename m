Return-Path: <chandru@in.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74FDDDE04D
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 23:49:44 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6BDmiIA008381
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 23:48:44 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6BDnhEd209742
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 23:49:43 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6BDngTn021387
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 23:49:43 +1000
From: Chandru <chandru@in.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4][V2] powerpc : add support for linux,
	usable-memory properties for drconf memory
Date: Fri, 11 Jul 2008 19:19:36 +0530
References: <200807080014.24910.chandru@in.ibm.com>
	<48768CE9.2080802@austin.ibm.com>
	<200807111639.22032.chandru@in.ibm.com>
In-Reply-To: <200807111639.22032.chandru@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807111919.36401.chandru@in.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Neuling <mikey@neuling.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scan for linux,usable-memory properties in case of dynamic reconfiguration 
memory. Support for kexec/kdump. 

Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
---

Patch applies on linux-next tree (patch-v2.6.26-rc9-next-20080711.gz)

 arch/powerpc/kernel/prom.c |   40 +++++++++++++++++++++++------
 arch/powerpc/mm/numa.c     |   48 ++++++++++++++++++++++++-----------
 2 files changed, 65 insertions(+), 23 deletions(-)

diff -Naurp linux-2.6.26-rc9-orig/arch/powerpc/kernel/prom.c 
linux-2.6.26-rc9/arch/powerpc/kernel/prom.c
--- linux-2.6.26-rc9-orig/arch/powerpc/kernel/prom.c	2008-07-11 
14:44:55.000000000 +0530
+++ linux-2.6.26-rc9/arch/powerpc/kernel/prom.c	2008-07-11 14:58:26.000000000 
+0530
@@ -888,9 +888,10 @@ static u64 __init dt_mem_next_cell(int s
  */
 static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 {
-	cell_t *dm, *ls;
-	unsigned long l, n, flags;
+	cell_t *dm, *ls, *usm;
+	unsigned long l, n, flags, ranges;
 	u64 base, size, lmb_size;
+	char buf[32];
 
 	ls = (cell_t *)of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
 	if (ls == NULL || l < dt_root_size_cells * sizeof(cell_t))
@@ -914,14 +915,37 @@ static int __init early_init_dt_scan_drc
 		   or if the block is not assigned to this partition (0x8) */
 		if ((flags & 0x80) || !(flags & 0x8))
 			continue;
-		size = lmb_size;
-		if (iommu_is_off) {
+		if (iommu_is_off)
 			if (base >= 0x80000000ul)
 				continue;
-			if ((base + size) > 0x80000000ul)
-				size = 0x80000000ul - base;
-		}
-		lmb_add(base, size);
+		size = lmb_size;
+
+		/*
+		 * Append 'n' to 'linux,usable-memory' to get special
+		 * properties passed in by tools like kexec-tools. Relevant
+		 * only if this is a kexec/kdump kernel.
+		 */
+		sprintf(buf, "linux,usable-memory%d", (int)n);
+		usm = of_get_flat_dt_prop(node, buf, &l);
+		ranges = 1;
+		if (usm != NULL)
+			ranges = (l >> 2)/(dt_root_addr_cells
+						+ dt_root_size_cells);
+		do {
+			if (usm != NULL) {
+				base = dt_mem_next_cell(dt_root_addr_cells,
+							 &usm);
+				size = dt_mem_next_cell(dt_root_size_cells,
+							 &usm);
+				if (size == 0)
+					break;
+			}
+			if (iommu_is_off)
+				if ((base + size) > 0x80000000ul)
+					size = 0x80000000ul - base;
+
+			lmb_add(base, size);
+		} while (--ranges);
 	}
 	lmb_dump_all();
 	return 0;
diff -Naurp linux-2.6.26-rc9-orig/arch/powerpc/mm/numa.c 
linux-2.6.26-rc9/arch/powerpc/mm/numa.c
--- linux-2.6.26-rc9-orig/arch/powerpc/mm/numa.c	2008-07-11 14:44:55.000000000 
+0530
+++ linux-2.6.26-rc9/arch/powerpc/mm/numa.c	2008-07-11 15:01:56.000000000 
+0530
@@ -493,11 +493,13 @@ static unsigned long __init numa_enforce
  */
 static void __init parse_drconf_memory(struct device_node *memory)
 {
-	const u32 *dm;
-	unsigned int n, rc;
-	unsigned long lmb_size, size;
+	const u32 *dm, *usm;
+	unsigned int n, rc, len, ranges;
+	unsigned long lmb_size, size, sz;
 	int nid;
 	struct assoc_arrays aa;
+	char buf[32];
+	u64 base;
 
 	n = of_get_drconf_memory(memory, &dm);
 	if (!n)
@@ -524,19 +526,35 @@ static void __init parse_drconf_memory(s
 
 		nid = of_drconf_to_nid_single(&drmem, &aa);
 
-		fake_numa_create_new_node(
-				((drmem.base_addr + lmb_size) >> PAGE_SHIFT),
-					   &nid);
-
-		node_set_online(nid);
-
-		size = numa_enforce_memory_limit(drmem.base_addr, lmb_size);
-		if (!size)
-			continue;
+		/*
+		 * Append 'n' to 'linux,usable-memory' to get special
+		 * properties passed in by tools like kexec-tools. Relevant
+		 * only if this is a kexec/kdump kernel.
+		 */
+		sprintf(buf, "linux,usable-memory%d", (int)n);
+		usm = of_get_property(memory, buf, &len);
+		ranges = 1;
+		if (usm != NULL)
+			ranges = (len >> 2) /
+					 (n_mem_addr_cells + n_mem_size_cells);
+
+		base = drmem.base_addr;
+		size = lmb_size;
+		do {
+			if (usm != NULL) {
+				base = read_n_cells(n_mem_addr_cells, &usm);
+				size = read_n_cells(n_mem_size_cells, &usm);
+			}
 
-		add_active_range(nid, drmem.base_addr >> PAGE_SHIFT,
-				 (drmem.base_addr >> PAGE_SHIFT)
-				 + (size >> PAGE_SHIFT));
+			fake_numa_create_new_node(((base + size) >> PAGE_SHIFT),
+							 &nid);
+			node_set_online(nid);
+			sz = numa_enforce_memory_limit(base, size);
+			if (sz)
+				add_active_range(nid, base >> PAGE_SHIFT,
+						 (base >> PAGE_SHIFT)
+						+ (sz >> PAGE_SHIFT));
+		} while (--ranges);
 	}
 }
 
