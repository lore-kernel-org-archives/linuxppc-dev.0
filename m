Return-Path: <chandru@in.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B06A9DDF60
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 19:02:07 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6M92O3A001148
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 19:02:24 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6M9203q3551272
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 19:02:00 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6M91xgJ013207
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 19:02:00 +1000
From: Chandru <chandru@in.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/4][V2] powerpc : add support for linux,
	usable-memory properties for drconf memory
Date: Tue, 22 Jul 2008 14:31:48 +0530
References: <200807080014.24910.chandru@in.ibm.com>
	<200807111639.22032.chandru@in.ibm.com>
	<200807111919.36401.chandru@in.ibm.com>
In-Reply-To: <200807111919.36401.chandru@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807221431.49268.chandru@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scan for linux,usable-memory properties in case of dynamic reconfiguration 
memory . Support for kexec/kdump.

Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
---

Patch applies on powerpc tree. Patch was reviewed by Nathan Fontenot, Stephen 
Rothwell, Michael Neuling.  

 arch/powerpc/kernel/prom.c |   40 +++++++++++++++++++++++------
 arch/powerpc/mm/numa.c     |   48 ++++++++++++++++++++++++-----------
 2 files changed, 65 insertions(+), 23 deletions(-)

diff -Naurp powerpc-orig/arch/powerpc/kernel/prom.c 
powerpc/arch/powerpc/kernel/prom.c
--- powerpc-orig/arch/powerpc/kernel/prom.c	2008-07-22 14:11:53.000000000 
+0530
+++ powerpc/arch/powerpc/kernel/prom.c	2008-07-22 14:12:17.000000000 +0530
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
diff -Naurp powerpc-orig/arch/powerpc/mm/numa.c powerpc/arch/powerpc/mm/numa.c
--- powerpc-orig/arch/powerpc/mm/numa.c	2008-07-22 14:11:53.000000000 +0530
+++ powerpc/arch/powerpc/mm/numa.c	2008-07-22 14:12:17.000000000 +0530
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
