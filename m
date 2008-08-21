Return-Path: <bgill@blarg.am.freescale.net>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8002EDF01F
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 04:50:30 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m7LIoN47021830
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 11:50:24 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	m7LIoMUh027916
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 13:50:23 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] 85xx: fix build warning, remove silly cast
Date: Thu, 21 Aug 2008 13:50:22 -0500
Message-Id: <1219344622-13638-1-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes a build warning when PHYS_64BIT is enabled, and
removes an unnecessary cast to phys_addr_t (the variable
being cast is already a phys_addr_t)

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/mm/fsl_booke_mmu.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index ce10e2b..23cee39 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -202,7 +202,7 @@ adjust_total_lowmem(void)
 		cam_max_size = max_lowmem_size;
 
 	/* adjust lowmem size to max_lowmem_size */
-	ram = min(max_lowmem_size, (phys_addr_t)total_lowmem);
+	ram = min(max_lowmem_size, total_lowmem);
 
 	/* Calculate CAM values */
 	__cam0 = 1UL << 2 * (__ilog2(ram) / 2);
@@ -225,7 +225,8 @@ adjust_total_lowmem(void)
 	printk(KERN_INFO "Memory CAM mapping: CAM0=%ldMb, CAM1=%ldMb,"
 			" CAM2=%ldMb residual: %ldMb\n",
 			__cam0 >> 20, __cam1 >> 20, __cam2 >> 20,
-			(total_lowmem - __cam0 - __cam1 - __cam2) >> 20);
+			(long int)((total_lowmem - __cam0 - __cam1 - __cam2)
+				   >> 20));
 	__max_low_memory = __cam0 + __cam1 + __cam2;
 	__initial_memory_limit_addr = memstart_addr + __max_low_memory;
 }
-- 
1.5.5.1
