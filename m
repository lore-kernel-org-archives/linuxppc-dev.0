Return-Path: <chandru@in.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 17A7DDE7D9
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 04:44:27 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m67IhpSB018163
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 04:43:51 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67IhxDb4567156
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 04:43:59 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67IiQ9i015835
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 04:44:26 +1000
From: Chandru <chandru@in.ibm.com>
To: kexec@lists.infradead.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] kdump : add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
Date: Tue, 8 Jul 2008 00:14:24 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807080014.24910.chandru@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

kexec-tools adds  crash, rtas, and tce memory regions as linux,usable-memory 
properties in device-tree.  Following changes are made in the kernel to 
recognize these special properties in case of 
ibm,dynamic-reconfiguration-memory node of device-tree.

Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
---

diff -Naurp linux-2.6.26-rc9-orig/arch/powerpc/kernel/prom.c 
linux-2.6.26-rc9/arch/powerpc/kernel/prom.c
--- linux-2.6.26-rc9-orig/arch/powerpc/kernel/prom.c	2008-07-06 
04:23:22.000000000 +0530
+++ linux-2.6.26-rc9/arch/powerpc/kernel/prom.c	2008-07-07 17:23:58.000000000 
+0530
@@ -884,9 +884,10 @@ static u64 __init dt_mem_next_cell(int s
  */
 static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 {
-	cell_t *dm, *ls;
+	cell_t *dm, *ls, *endp, *usm;
 	unsigned long l, n, flags;
 	u64 base, size, lmb_size;
+	char buf[32], t[8];
 
 	ls = (cell_t *)of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
 	if (ls == NULL || l < dt_root_size_cells * sizeof(cell_t))
@@ -917,7 +918,33 @@ static int __init early_init_dt_scan_drc
 			if ((base + size) > 0x80000000ul)
 				size = 0x80000000ul - base;
 		}
-		lmb_add(base, size);
+		strcpy(buf, "linux,usable-memory");
+		sprintf(t, "%d", (int)n);
+		strcat(buf, t);
+		usm = (cell_t *)of_get_flat_dt_prop(node,
+						 (const char *)buf, &l);
+		if (usm != NULL) {
+			endp = usm + (l / sizeof(cell_t));
+			while ((endp - usm) >= (dt_root_addr_cells +
+						 dt_root_size_cells)) {
+				base = dt_mem_next_cell(dt_root_addr_cells,
+								 &usm);
+				size = dt_mem_next_cell(dt_root_size_cells,
+								 &usm);
+				if (size == 0)
+					continue;
+				if (iommu_is_off) {
+					if ((base + size) > 0x80000000ul)
+						size = 0x80000000ul - base;
+				}
+				lmb_add(base, size);
+			}
+
+			/* Continue with next lmb entry */
+			continue;
+		} else {
+			lmb_add(base, size);
+		}
 	}
 	lmb_dump_all();
 	return 0;
diff -Naurp linux-2.6.26-rc9-orig/arch/powerpc/mm/numa.c 
linux-2.6.26-rc9/arch/powerpc/mm/numa.c
--- linux-2.6.26-rc9-orig/arch/powerpc/mm/numa.c	2008-07-06 04:23:22.000000000 
+0530
+++ linux-2.6.26-rc9/arch/powerpc/mm/numa.c	2008-07-07 17:50:35.000000000 
+0530
@@ -349,18 +349,33 @@ static unsigned long __init numa_enforce
 	return lmb_end_of_DRAM() - start;
 }
 
+static void set_nodeinfo(int nid, unsigned long start, unsigned long size)
+{
+	fake_numa_create_new_node(((start + size) >> PAGE_SHIFT),
+					&nid);
+	node_set_online(nid);
+
+	size = numa_enforce_memory_limit(start, size);
+	if (!size)
+		return;
+	add_active_range(nid, start >> PAGE_SHIFT,
+			(start >> PAGE_SHIFT) + (size >> PAGE_SHIFT));
+	return;
+}
+
 /*
  * Extract NUMA information from the ibm,dynamic-reconfiguration-memory
  * node.  This assumes n_mem_{addr,size}_cells have been set.
  */
 static void __init parse_drconf_memory(struct device_node *memory)
 {
-	const unsigned int *lm, *dm, *aa;
+	const unsigned int *lm, *dm, *aa, *usm;
 	unsigned int ls, ld, la;
 	unsigned int n, aam, aalen;
 	unsigned long lmb_size, size, start;
 	int nid, default_nid = 0;
-	unsigned int ai, flags;
+	unsigned int ai, flags, len, ranges;
+	char buf[32], t[8];
 
 	lm = of_get_property(memory, "ibm,lmb-size", &ls);
 	dm = of_get_property(memory, "ibm,dynamic-memory", &ld);
@@ -396,16 +411,27 @@ static void __init parse_drconf_memory(s
 				nid = default_nid;
 		}
 
-		fake_numa_create_new_node(((start + lmb_size) >> PAGE_SHIFT),
-						&nid);
-		node_set_online(nid);
+		strcpy(buf, "linux,usable-memory");
+		sprintf(t, "%d", (int)n);
+		strcat(buf, t);
+		usm = of_get_property(memory, (const char *)buf, &len);
+		if (usm != NULL) {
+			ranges = (len >> 2) / (n_mem_addr_cells +
+						 n_mem_size_cells);
+
+dr_new_range:		start = read_n_cells(n_mem_addr_cells, &usm);
+			size = read_n_cells(n_mem_size_cells, &usm);
+			if (size == 0)
+				continue;
 
-		size = numa_enforce_memory_limit(start, lmb_size);
-		if (!size)
-			continue;
+			set_nodeinfo(nid, start, size);
+			if (--ranges)
+				goto dr_new_range;
 
-		add_active_range(nid, start >> PAGE_SHIFT,
-				 (start >> PAGE_SHIFT) + (size >> PAGE_SHIFT));
+			continue;
+		} else {
+			set_nodeinfo(nid, start, lmb_size);
+		}
 	}
 }
 
