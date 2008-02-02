Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63AE9DDE3D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 18:47:26 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/1] [PPC] 8xx swap bug-fix
Date: Sat, 2 Feb 2008 10:47:31 +0300
References: <20080201181003.a3daf6ed.kim.phillips@freescale.com>
In-Reply-To: <20080201181003.a3daf6ed.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802021047.32055.yur@emcraft.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hello,

 Here is the patch which makes Linux-2.6 swap routines operate correctly on
the ppc-8xx-based machines.

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
--
diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index eb8d26f..321bda2 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -329,8 +329,18 @@ InstructionTLBMiss:
 	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
 	lwz	r10, 0(r11)	/* Get the pte */
 
+#ifdef CONFIG_SWAP
+	/* do not set the _PAGE_ACCESSED bit of a non-present page */
+	andi.	r11, r10, _PAGE_PRESENT
+	beq	4f
+	ori	r10, r10, _PAGE_ACCESSED
+	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
+	stw	r10, 0(r11)
+4:
+#else
 	ori	r10, r10, _PAGE_ACCESSED
 	stw	r10, 0(r11)
+#endif
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 21, 22 and 28 must be clear.
@@ -395,8 +405,17 @@ DataStoreTLBMiss:
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	SPRN_MD_TWC, r11
 
-	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
+#ifdef CONFIG_SWAP
+	/* do not set the _PAGE_ACCESSED bit of a non-present page */
+	andi.	r11, r10, _PAGE_PRESENT
+	beq	4f
+	ori	r10, r10, _PAGE_ACCESSED
+4:
+	/* and update pte in table */
+#else
 	ori	r10, r10, _PAGE_ACCESSED
+#endif
+	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
 	stw	r10, 0(r11)
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
@@ -575,7 +594,16 @@ DataTLBError:
 
 	/* Update 'changed', among others.
 	*/
+#ifdef CONFIG_SWAP
+	ori	r10, r10, _PAGE_DIRTY|_PAGE_HWWRITE
+	/* do not set the _PAGE_ACCESSED bit of a non-present page */
+	andi.	r11, r10, _PAGE_PRESENT
+	beq	4f
+	ori	r10, r10, _PAGE_ACCESSED
+4:
+#else
 	ori	r10, r10, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
+#endif
 	mfspr	r11, SPRN_MD_TWC		/* Get pte address again */
 	stw	r10, 0(r11)		/* and update pte in table */
 
diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
index c159315..76717ff 100644
--- a/include/asm-ppc/pgtable.h
+++ b/include/asm-ppc/pgtable.h
@@ -341,14 +341,6 @@ extern unsigned long ioremap_bot, ioremap_base;
 #define _PMD_PAGE_MASK	0x000c
 #define _PMD_PAGE_8M	0x000c
 
-/*
- * The 8xx TLB miss handler allegedly sets _PAGE_ACCESSED in the PTE
- * for an address even if _PAGE_PRESENT is not set, as a performance
- * optimization.  This is a bug if you ever want to use swap unless
- * _PAGE_ACCESSED is 2, which it isn't, or unless you have 8xx-specific
- * definitions for __swp_entry etc. below, which would be gross.
- *  -- paulus
- */
 #define _PTE_NONE_MASK _PAGE_ACCESSED
 
 #else /* CONFIG_6xx */

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
