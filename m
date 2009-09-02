Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B1DADB7B9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 11:48:46 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 165F6DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 11:48:45 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n821mgNH031651
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2009 20:48:42 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Use HW PTE format if CONFIG_PTE_64BIT
Date: Tue,  1 Sep 2009 20:48:42 -0500
Message-Id: <1251856122-24560-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Switch to using the Power ISA defined PTE format when we have a 64-bit
PTE.  This makes the code handling between fsl-booke and book3e-64
similiar for TLB faults.

Additionally this lets use take advantage of the page size encodings and
full permissions that the HW PTE defines.

Also defined _PMD_PRESENT, _PMD_PRESENT_MASK, and _PMD_BAD since the
32-bit ppc arch code expects them.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/pgtable-ppc32.h |    2 +
 arch/powerpc/include/asm/pte-book3e.h    |    3 ++
 arch/powerpc/include/asm/pte-fsl-booke.h |    7 -----
 arch/powerpc/kernel/head_fsl_booke.S     |   36 ++++++++++++++++++++---------
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index f2c52e2..55646ad 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -111,6 +111,8 @@ extern int icache_44x_need_flush;
 #include <asm/pte-40x.h>
 #elif defined(CONFIG_44x)
 #include <asm/pte-44x.h>
+#elif defined(CONFIG_FSL_BOOKE) && defined(CONFIG_PTE_64BIT)
+#include <asm/pte-book3e.h>
 #elif defined(CONFIG_FSL_BOOKE)
 #include <asm/pte-fsl-booke.h>
 #elif defined(CONFIG_8xx)
diff --git a/arch/powerpc/include/asm/pte-book3e.h b/arch/powerpc/include/asm/pte-book3e.h
index b82b9dc..082d515 100644
--- a/arch/powerpc/include/asm/pte-book3e.h
+++ b/arch/powerpc/include/asm/pte-book3e.h
@@ -75,6 +75,9 @@
 /* On 32-bit, we never clear the top part of the PTE */
 #ifdef CONFIG_PPC32
 #define _PTE_NONE_MASK	0xffffffff00000000ULL
+#define _PMD_PRESENT	0
+#define _PMD_PRESENT_MASK (PAGE_MASK)
+#define _PMD_BAD	(~PAGE_MASK)
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/pte-fsl-booke.h b/arch/powerpc/include/asm/pte-fsl-booke.h
index ce8a9e9..2c12be5 100644
--- a/arch/powerpc/include/asm/pte-fsl-booke.h
+++ b/arch/powerpc/include/asm/pte-fsl-booke.h
@@ -33,13 +33,6 @@
 #define _PAGE_WRITETHRU	0x00400	/* H: W bit */
 #define _PAGE_SPECIAL	0x00800 /* S: Special page */
 
-#ifdef CONFIG_PTE_64BIT
-/* ERPN in a PTE never gets cleared, ignore it */
-#define _PTE_NONE_MASK	0xffffffffffff0000ULL
-/* We extend the size of the PTE flags area when using 64-bit PTEs */
-#define PTE_RPN_SHIFT	(PAGE_SHIFT + 8)
-#endif
-
 #define _PMD_PRESENT	0
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 2c5af52..975788c 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -575,7 +575,12 @@ interrupt_base:
 	 *       place or can we save a couple of instructions here ?
 	 */
 	mfspr	r12,SPRN_ESR
+#ifdef CONFIG_PTE_64BIT
+	li	r13,_PAGE_PRESENT
+	oris	r13,r13,_PAGE_ACCESSED@h
+#else
 	li	r13,_PAGE_PRESENT|_PAGE_ACCESSED
+#endif
 	rlwimi	r13,r12,11,29,29
 
 	FIND_PTE
@@ -643,7 +648,12 @@ interrupt_base:
 
 4:
 	/* Make up the required permissions */
+#ifdef CONFIG_PTE_64BIT
+	li	r13,_PAGE_PRESENT | _PAGE_EXEC
+	oris	r13,r13,_PAGE_ACCESSED@h
+#else
 	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
+#endif
 
 	FIND_PTE
 	andc.	r13,r13,r11		/* Check permission */
@@ -733,7 +743,7 @@ finish_tlb_load:
 
 	mfspr	r12, SPRN_MAS2
 #ifdef CONFIG_PTE_64BIT
-	rlwimi	r12, r11, 26, 24, 31	/* extract ...WIMGE from pte */
+	rlwimi	r12, r11, 32-19, 27, 31	/* extract WIMGE from pte */
 #else
 	rlwimi	r12, r11, 26, 27, 31	/* extract WIMGE from pte */
 #endif
@@ -742,6 +752,20 @@ finish_tlb_load:
 #endif
 	mtspr	SPRN_MAS2, r12
 
+#ifdef CONFIG_PTE_64BIT
+	rlwinm	r12, r11, 32-2, 26, 31	/* Move in perm bits */
+	andi.	r10, r11, _PAGE_DIRTY
+	bne	1f
+	li	r10, MAS3_SW | MAS3_UW
+	andc	r12, r12, r10
+1:	rlwimi	r12, r13, 20, 0, 11	/* grab RPN[32:43] */
+	rlwimi	r12, r11, 20, 12, 19	/* grab RPN[44:51] */
+	mtspr	SPRN_MAS3, r12
+BEGIN_MMU_FTR_SECTION
+	srwi	r10, r13, 12		/* grab RPN[12:31] */
+	mtspr	SPRN_MAS7, r10
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
+#else
 	li	r10, (_PAGE_EXEC | _PAGE_PRESENT)
 	rlwimi	r10, r11, 31, 29, 29	/* extract _PAGE_DIRTY into SW */
 	and	r12, r11, r10
@@ -749,16 +773,6 @@ finish_tlb_load:
 	slwi	r10, r12, 1
 	or	r10, r10, r12
 	iseleq	r12, r12, r10
-	
-#ifdef CONFIG_PTE_64BIT
-	rlwimi	r12, r13, 24, 0, 7	/* grab RPN[32:39] */
-	rlwimi	r12, r11, 24, 8, 19	/* grab RPN[40:51] */
-	mtspr	SPRN_MAS3, r12
-BEGIN_MMU_FTR_SECTION
-	srwi	r10, r13, 8		/* grab RPN[8:31] */
-	mtspr	SPRN_MAS7, r10
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
-#else
 	rlwimi	r11, r12, 0, 20, 31	/* Extract RPN from PTE and merge with perms */
 	mtspr	SPRN_MAS3, r11
 #endif
-- 
1.6.0.6
