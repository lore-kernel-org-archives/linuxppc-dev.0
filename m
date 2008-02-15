Return-Path: <bgill@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC1F6DDFB2
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 05:21:35 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m1FILVn4021322
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 11:21:31 -0700 (MST)
Received: from monty.am.freescale.net (monty.am.freescale.net [10.82.19.26])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m1FILUnM008472
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 12:21:31 -0600 (CST)
Received: from monty.am.freescale.net (localhost.localdomain [127.0.0.1])
	by monty.am.freescale.net (8.14.2/8.14.2) with ESMTP id m1FIHEeU001849
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 12:17:15 -0600
Received: from localhost (bgill@localhost)
	by monty.am.freescale.net (8.14.2/8.14.2/Submit) with ESMTP id
	m1FIHEwU001846
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 12:17:14 -0600
Date: Fri, 15 Feb 2008 12:17:14 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] prom.c: Fix dt_mem_next_cell() to read the full mem cells
Message-ID: <Pine.LNX.4.64.0802151215210.1840@monty.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

dt_mem_next_cell() currently does of_read_ulong().  This does
not allow for the case where #size-cells and/or #address-cells = 2 on
a 32-bit system, as it will end up reading 32 bits instead of the
expected 64. Change it to use of_read_number instead and always return
a u64.

Signed-off-by: Becky Bruce <becky.bruce at freescale.com>
---
 arch/powerpc/kernel/prom.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index c17a585..ff600ef 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -865,12 +865,12 @@ static int __init early_init_dt_scan_root(unsigned long node,
 	return 1;
 }
 
-static unsigned long __init dt_mem_next_cell(int s, cell_t **cellp)
+static u64 __init dt_mem_next_cell(int s, cell_t **cellp)
 {
 	cell_t *p = *cellp;
 
 	*cellp = p + s;
-	return of_read_ulong(p, s);
+	return of_read_number(p, s);
 }
 
 #ifdef CONFIG_PPC_PSERIES
@@ -883,8 +883,8 @@ static unsigned long __init dt_mem_next_cell(int s, cell_t **cellp)
 static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 {
 	cell_t *dm, *ls;
-	unsigned long l, n;
-	unsigned long base, size, lmb_size, flags;
+	unsigned long l, n, flags;
+	u64 base, size, lmb_size;
 
 	ls = (cell_t *)of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
 	if (ls == NULL || l < dt_root_size_cells * sizeof(cell_t))
@@ -959,14 +959,15 @@ static int __init early_init_dt_scan_memory(unsigned long node,
 	    uname, l, reg[0], reg[1], reg[2], reg[3]);
 
 	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
-		unsigned long base, size;
+		u64 base, size;
 
 		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
 		size = dt_mem_next_cell(dt_root_size_cells, &reg);
 
 		if (size == 0)
 			continue;
-		DBG(" - %lx ,  %lx\n", base, size);
+		DBG(" - %llx ,  %llx\n", (unsigned long long)base,
+		    (unsigned long long)size);
 #ifdef CONFIG_PPC64
 		if (iommu_is_off) {
 			if (base >= 0x80000000ul)
-- 
1.5.3.8
