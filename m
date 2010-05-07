Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0ED72B7D6C
	for <linuxppc-dev@ozlabs.org>; Fri,  7 May 2010 18:00:44 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4780PYD019145
	for <linuxppc-dev@ozlabs.org>; Fri, 7 May 2010 01:00:36 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o47892Hm024011
	for <linuxppc-dev@ozlabs.org>; Fri, 7 May 2010 03:09:03 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] pte_fsl_booke: fix instruction TLB error permission check
Date: Fri,  7 May 2010 16:38:34 +0800
Message-Id: <1273221514-8683-1-git-send-email-leoli@freescale.com>
Cc: Jin Qing <b24347@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check the user/supervisor execution permission base on the code address.
This fixes the following oops on module loading or removing.

Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0xf938d040
Oops: Kernel access of bad area, sig: 11 [#1]

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jin Qing <b24347@freescale.com>
---
 arch/powerpc/kernel/head_fsl_booke.S |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 78aac7b..61b6687 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -684,6 +684,13 @@ interrupt_base:
 	rlwinm	r12,r12,0,16,1
 	mtspr	SPRN_MAS1,r12
 
+	/* Make up the required permissions for kernel code */
+#ifdef CONFIG_PTE_64BIT
+	li	r13,_PAGE_PRESENT | _PAGE_BAP_SX
+	oris	r13,r13,_PAGE_ACCESSED@h
+#else
+	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
+#endif
 	b	4f
 
 	/* Get the PGD for the current thread */
@@ -691,15 +698,15 @@ interrupt_base:
 	mfspr	r11,SPRN_SPRG_THREAD
 	lwz	r11,PGDIR(r11)
 
-4:
-	/* Make up the required permissions */
+	/* Make up the required permissions for user code */
 #ifdef CONFIG_PTE_64BIT
-	li	r13,_PAGE_PRESENT | _PAGE_EXEC
+	li	r13,_PAGE_PRESENT | _PAGE_BAP_UX
 	oris	r13,r13,_PAGE_ACCESSED@h
 #else
 	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
 #endif
 
+4:
 	FIND_PTE
 	andc.	r13,r13,r11		/* Check permission */
 
-- 
1.6.6-rc1.GIT
