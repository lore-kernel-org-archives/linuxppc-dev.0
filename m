Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id E866E67D3D
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:30:37 +1100 (EST)
Message-Id: <20061102125627.590883000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
Date: Thu, 02 Nov 2006 13:56:04 +0100
From: s.hauer@pengutronix.de
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 09/16] powerpc: remove occurences of PPC_MULTIPLATFORM in
	head_64.S
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since iSeries is merged to MULTIPLATFORM, there is no way to build a 64bit
kernel without MULTIPLATFORM, so PPC_MULTIPLATFORM can be removed in
64bit-only files 

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Index: arch/powerpc/kernel/head_64.S
===================================================================
--- a/arch/powerpc/kernel/head_64.S.orig
+++ b/arch/powerpc/kernel/head_64.S
@@ -74,13 +74,11 @@
 	.text
 	.globl  _stext
 _stext:
-#ifdef CONFIG_PPC_MULTIPLATFORM
 _GLOBAL(__start)
 	/* NOP this out unconditionally */
 BEGIN_FTR_SECTION
 	b	.__start_initialization_multiplatform
 END_FTR_SECTION(0, 1)
-#endif /* CONFIG_PPC_MULTIPLATFORM */
 
 	/* Catch branch to 0 in real mode */
 	trap
@@ -1595,7 +1593,6 @@ _STATIC(__start_initialization_iSeries)
 	b	.start_here_common
 #endif /* CONFIG_PPC_ISERIES */
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
 
 _STATIC(__mmu_off)
 	mfmsr	r3
@@ -1621,13 +1618,11 @@ _STATIC(__mmu_off)
  *
  */
 _GLOBAL(__start_initialization_multiplatform)
-#ifdef CONFIG_PPC_MULTIPLATFORM
 	/*
 	 * Are we booted from a PROM Of-type client-interface ?
 	 */
 	cmpldi	cr0,r5,0
 	bne	.__boot_from_prom		/* yes -> prom */
-#endif
 
 	/* Save parameters */
 	mr	r31,r3
@@ -1656,7 +1651,6 @@ _GLOBAL(__start_initialization_multiplat
 	bl	.__mmu_off
 	b	.__after_prom_start
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
 _STATIC(__boot_from_prom)
 	/* Save parameters */
 	mr	r31,r3
@@ -1696,7 +1690,6 @@ _STATIC(__boot_from_prom)
 	bl	.prom_init
 	/* We never return */
 	trap
-#endif
 
 /*
  * At this point, r3 contains the physical address we are running at,
@@ -1752,8 +1745,6 @@ _STATIC(__after_prom_start)
 	bl	.copy_and_flush		/* copy the rest */
 	b	.start_here_multiplatform
 
-#endif /* CONFIG_PPC_MULTIPLATFORM */
-
 /*
  * Copy routine used to copy the kernel to start at physical address 0
  * and flush and invalidate the caches as needed.
@@ -1913,7 +1904,6 @@ _GLOBAL(enable_64b_mode)
 	isync
 	blr
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
 /*
  * This is where the main kernel code starts.
  */
@@ -1977,7 +1967,6 @@ _STATIC(start_here_multiplatform)
 	mtspr	SPRN_SRR1,r4
 	rfid
 	b	.	/* prevent speculative execution */
-#endif /* CONFIG_PPC_MULTIPLATFORM */
 	
 	/* This is where all platforms converge execution */
 _STATIC(start_here_common)
Index: arch/powerpc/kernel/entry_64.S
===================================================================
--- a/arch/powerpc/kernel/entry_64.S.orig
+++ b/arch/powerpc/kernel/entry_64.S
@@ -735,8 +735,6 @@ _STATIC(rtas_restore_regs)
 
 #endif /* CONFIG_PPC_RTAS */
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
-
 _GLOBAL(enter_prom)
 	mflr	r0
 	std	r0,16(r1)
@@ -821,5 +819,3 @@ _GLOBAL(enter_prom)
 	ld	r0,16(r1)
 	mtlr    r0
         blr
-	
-#endif	/* CONFIG_PPC_MULTIPLATFORM */

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
