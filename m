Return-Path: <chandru@in.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6CF5BDDEF3
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 21:12:48 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m5DBCJ0C013905
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 21:12:19 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5DBCIR6223284
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 21:12:18 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5DBCIIk024951
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 21:12:18 +1000
Received: from guara.in.ibm.com (guara.in.ibm.com [9.124.35.86])
	by d23av03.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m5DBCHJ7024934
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 21:12:17 +1000
From: Chandru <chandru@in.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH] powerpc: add usable-memory property to drconf memory
Date: Fri, 13 Jun 2008 16:42:17 +0530
References: <200806131451.39467.chandru@in.ibm.com>
In-Reply-To: <200806131451.39467.chandru@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806131642.17532.chandru@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 13 June 2008 14:51:39 Chandru wrote:
> kexec-tools in user space collects rtas, crash , tce region ranges
> from /proc/device-tree/ and passes them as linux,usable-memory properties
> to second/kdump kernel in the device tree buffer. With drconf memory in
> power6 machines, we need a similar method to preserve those regions in the
> kdump kernel.  This patch adopts a method to append the number 'n' from
> n'th lmb entry in ibm,dynamic-memory as a string to "linux,usable-memory"
> string , so as to distinguish each usable-memory region and it's size. 
> Another place that needs similar change but not included in this patch is
> in
> arch/powerpc/mm/numa.c.

The previous patch had  two missing lines. Hence sending it again. Sorry about 
this  :(.

Signed-off-by: Chandru S <chandru@in.ibm.com>
---


--- arch/powerpc/kernel/prom.c.orig	2008-06-13 11:42:45.000000000 +0530
+++ arch/powerpc/kernel/prom.c	2008-06-13 16:21:04.000000000 +0530
@@ -884,20 +884,22 @@ static u64 __init dt_mem_next_cell(int s
  */
 static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 {
-	cell_t *dm, *ls;
-	unsigned long l, n, flags;
+	cell_t *dm, *ls, *udm, *reg, *endp;
+	unsigned long l, n, un, flags;
 	u64 base, size, lmb_size;
+	char buf[64], t[8];
 
 	ls = (cell_t *)of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
 	if (ls == NULL || l < dt_root_size_cells * sizeof(cell_t))
 		return 0;
 	lmb_size = dt_mem_next_cell(dt_root_size_cells, &ls);
 
-	dm = (cell_t *)of_get_flat_dt_prop(node, "ibm,dynamic-memory", &l);
+	udm = dm = (cell_t *)of_get_flat_dt_prop(node,
+						"ibm,dynamic-memory", &l);
 	if (dm == NULL || l < sizeof(cell_t))
 		return 0;
 
-	n = *dm++;	/* number of entries */
+	un = n = *dm++;	/* number of entries */
 	if (l < (n * (dt_root_addr_cells + 4) + 1) * sizeof(cell_t))
 		return 0;
 
@@ -919,6 +921,41 @@ static int __init early_init_dt_scan_drc
 		}
 		lmb_add(base, size);
 	}
+
+	/* Scan usable-memory properties */
+	for (; un != 0; --un) {
+		base = dt_mem_next_cell(dt_root_addr_cells, &udm);
+		flags = dm[3];
+		udm += 4;
+		if ((flags & 0x80) || !(flags & 0x8))
+			continue;
+		strcpy(buf, "linux,usable-memory");
+		sprintf(t, "%d", (int)un);
+		strcat(buf, t);
+		reg = (cell_t *)of_get_flat_dt_prop(node,
+					(const char *)buf, &l);
+		if (reg == NULL)
+			continue;
+		/* remove the previously added lmb */
+		lmb_remove(base, (base+lmb_size));
+		endp = reg + (l / sizeof(cell_t));
+		while ((endp - reg) >= (dt_root_addr_cells +
+						dt_root_size_cells)) {
+
+			base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+			size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+			if (size == 0)
+				continue;
+			if (iommu_is_off) {
+				if (base >= 0x80000000ul)
+					continue;
+				if ((base + size) > 0x80000000ul)
+					size = 0x80000000ul - base;
+			}
+			lmb_add(base, size);
+		}
+	}
 	lmb_dump_all();
 	return 0;
 }
