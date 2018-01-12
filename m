Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ2XQ1NRnzF0jx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 23:45:23 +1100 (AEDT)
Message-Id: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/8] powerpc/8xx: Remove CPU6 ERRATA Workaround
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Jan 2018 13:45:19 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CPU6 ERRATA affects only MPC860 revisions prior to C.0. Manufacturing
of those revisiosn was stopped in 1999-2000.
Therefore, it has been almost 20 years since this ERRATA has been
fixed in the silicon.

This patch removes the workaround for that ERRATA.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/configs/mpc866_ads_defconfig |  1 -
 arch/powerpc/include/asm/reg_8xx.h        | 82 -------------------------------
 arch/powerpc/kernel/head_8xx.S            | 54 +++++---------------
 arch/powerpc/platforms/8xx/Kconfig        | 12 -----
 4 files changed, 12 insertions(+), 137 deletions(-)

diff --git a/arch/powerpc/configs/mpc866_ads_defconfig b/arch/powerpc/configs/mpc866_ads_defconfig
index f1f176c29fa3..5320735395e7 100644
--- a/arch/powerpc/configs/mpc866_ads_defconfig
+++ b/arch/powerpc/configs/mpc866_ads_defconfig
@@ -13,7 +13,6 @@ CONFIG_EXPERT=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MPC86XADS=y
 CONFIG_8xx_COPYBACK=y
-CONFIG_8xx_CPU6=y
 CONFIG_GEN_RTC=y
 CONFIG_HZ_1000=y
 CONFIG_MATH_EMULATION=y
diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index 53a7e2955d3e..7192eece6c3e 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -66,86 +66,4 @@
 #define DC_DFWT		0x40000000	/* Data cache is forced write through */
 #define DC_LES		0x20000000	/* Caches are little endian mode */
 
-#ifdef CONFIG_8xx_CPU6
-#define do_mtspr_cpu6(rn, rn_addr, v)	\
-	do {								\
-		int _reg_cpu6 = rn_addr, _tmp_cpu6;		\
-		asm volatile("stw %0, %1;"				\
-			     "lwz %0, %1;"				\
-			     "mtspr " __stringify(rn) ",%2" :		\
-			     : "r" (_reg_cpu6), "m"(_tmp_cpu6),		\
-			       "r" ((unsigned long)(v))			\
-			     : "memory");				\
-	} while (0)
-
-#define do_mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" :	\
-				     : "r" ((unsigned long)(v))		\
-				     : "memory")
-#define mtspr(rn, v) \
-	do {								\
-		if (rn == SPRN_IMMR)					\
-			do_mtspr_cpu6(rn, 0x3d30, v);			\
-		else if (rn == SPRN_IC_CST)				\
-			do_mtspr_cpu6(rn, 0x2110, v);			\
-		else if (rn == SPRN_IC_ADR)				\
-			do_mtspr_cpu6(rn, 0x2310, v);			\
-		else if (rn == SPRN_IC_DAT)				\
-			do_mtspr_cpu6(rn, 0x2510, v);			\
-		else if (rn == SPRN_DC_CST)				\
-			do_mtspr_cpu6(rn, 0x3110, v);			\
-		else if (rn == SPRN_DC_ADR)				\
-			do_mtspr_cpu6(rn, 0x3310, v);			\
-		else if (rn == SPRN_DC_DAT)				\
-			do_mtspr_cpu6(rn, 0x3510, v);			\
-		else if (rn == SPRN_MI_CTR)				\
-			do_mtspr_cpu6(rn, 0x2180, v);			\
-		else if (rn == SPRN_MI_AP)				\
-			do_mtspr_cpu6(rn, 0x2580, v);			\
-		else if (rn == SPRN_MI_EPN)				\
-			do_mtspr_cpu6(rn, 0x2780, v);			\
-		else if (rn == SPRN_MI_TWC)				\
-			do_mtspr_cpu6(rn, 0x2b80, v);			\
-		else if (rn == SPRN_MI_RPN)				\
-			do_mtspr_cpu6(rn, 0x2d80, v);			\
-		else if (rn == SPRN_MI_CAM)				\
-			do_mtspr_cpu6(rn, 0x2190, v);			\
-		else if (rn == SPRN_MI_RAM0)				\
-			do_mtspr_cpu6(rn, 0x2390, v);			\
-		else if (rn == SPRN_MI_RAM1)				\
-			do_mtspr_cpu6(rn, 0x2590, v);			\
-		else if (rn == SPRN_MD_CTR)				\
-			do_mtspr_cpu6(rn, 0x3180, v);			\
-		else if (rn == SPRN_M_CASID)				\
-			do_mtspr_cpu6(rn, 0x3380, v);			\
-		else if (rn == SPRN_MD_AP)				\
-			do_mtspr_cpu6(rn, 0x3580, v);			\
-		else if (rn == SPRN_MD_EPN)				\
-			do_mtspr_cpu6(rn, 0x3780, v);			\
-		else if (rn == SPRN_M_TWB)				\
-			do_mtspr_cpu6(rn, 0x3980, v);			\
-		else if (rn == SPRN_MD_TWC)				\
-			do_mtspr_cpu6(rn, 0x3b80, v);			\
-		else if (rn == SPRN_MD_RPN)				\
-			do_mtspr_cpu6(rn, 0x3d80, v);			\
-		else if (rn == SPRN_M_TW)				\
-			do_mtspr_cpu6(rn, 0x3f80, v);			\
-		else if (rn == SPRN_MD_CAM)				\
-			do_mtspr_cpu6(rn, 0x3190, v);			\
-		else if (rn == SPRN_MD_RAM0)				\
-			do_mtspr_cpu6(rn, 0x3390, v);			\
-		else if (rn == SPRN_MD_RAM1)				\
-			do_mtspr_cpu6(rn, 0x3590, v);			\
-		else if (rn == SPRN_DEC)				\
-			do_mtspr_cpu6(rn, 0x2c00, v);			\
-		else if (rn == SPRN_TBWL)				\
-			do_mtspr_cpu6(rn, 0x3880, v);			\
-		else if (rn == SPRN_TBWU)				\
-			do_mtspr_cpu6(rn, 0x3a80, v);			\
-		else if (rn == SPRN_DPDR)				\
-			do_mtspr_cpu6(rn, 0x2d30, v);			\
-		else							\
-			do_mtspr(rn, v);				\
-	} while (0)
-#endif
-
 #endif /* _ASM_POWERPC_REG_8xx_H */
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 4fee00d414e8..728b513c07b8 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -33,23 +33,6 @@
 #include <asm/fixmap.h>
 #include <asm/export.h>
 
-/* Macro to make the code more readable. */
-#ifdef CONFIG_8xx_CPU6
-#define SPRN_MI_TWC_ADDR	0x2b80
-#define SPRN_MI_RPN_ADDR	0x2d80
-#define SPRN_MD_TWC_ADDR	0x3b80
-#define SPRN_MD_RPN_ADDR	0x3d80
-
-#define MTSPR_CPU6(spr, reg, treg)	\
-	li	treg, spr##_ADDR;	\
-	stw	treg, 12(r0);		\
-	lwz	treg, 12(r0);		\
-	mtspr	spr, reg
-#else
-#define MTSPR_CPU6(spr, reg, treg)	\
-	mtspr	spr, reg
-#endif
-
 #if CONFIG_TASK_SIZE <= 0x80000000 && CONFIG_PAGE_OFFSET >= 0x80000000
 /* By simply checking Address >= 0x80000000, we know if its a kernel address */
 #define SIMPLE_KERNEL_ADDRESS		1
@@ -326,7 +309,7 @@ SystemCall:
 #endif
 
 InstructionTLBMiss:
-#if defined(CONFIG_8xx_CPU6) || defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
+#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mtspr	SPRN_SPRG_SCRATCH2, r3
 #endif
 	EXCEPTION_PROLOG_0
@@ -393,7 +376,7 @@ _ENTRY(ITLBMiss_cmp)
 	/* Insert the APG into the TWC from the Linux PTE. */
 	rlwimi	r11, r10, 0, 25, 26
 	/* Load the MI_TWC with the attributes for this "segment." */
-	MTSPR_CPU6(SPRN_MI_TWC, r11, r3)	/* Set segment attributes */
+	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
 
 #if defined (CONFIG_HUGETLB_PAGE) && defined (CONFIG_PPC_4K_PAGES)
 	rlwimi	r10, r11, 1, MI_SPS16K
@@ -415,10 +398,10 @@ _ENTRY(ITLBMiss_cmp)
 #else
 	rlwimi	r10, r11, 0, 0x0ff8	/* Set 24-27, clear 20-23,28 */
 #endif
-	MTSPR_CPU6(SPRN_MI_RPN, r10, r3)	/* Update TLB entry */
+	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
-#if defined(CONFIG_8xx_CPU6) || defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
+#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mfspr	r3, SPRN_SPRG_SCRATCH2
 #endif
 	EXCEPTION_EPILOG_0
@@ -512,7 +495,7 @@ _ENTRY(DTLBMiss_jmp)
 	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
 	 */
 	rlwimi	r11, r10, 32-5, 30, 30
-	MTSPR_CPU6(SPRN_MD_TWC, r11, r3)
+	mtspr	SPRN_MD_TWC, r11
 
 	/* In 4k pages mode, SPS (bit 28) in RPN must match PS[1] (bit 29)
 	 * In 16k pages mode, SPS is always 1 */
@@ -546,7 +529,7 @@ _ENTRY(DTLBMiss_jmp)
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 #endif
 	rlwimi	r10, r11, 0, 20, 20	/* clear 20 */
-	MTSPR_CPU6(SPRN_MD_RPN, r10, r3)	/* Update TLB entry */
+	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
 	mfspr	r3, SPRN_SPRG_SCRATCH2
@@ -684,12 +667,12 @@ DTLBMissIMMR:
 	mtcr	r3
 	/* Set 512k byte guarded page and mark it valid */
 	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
-	MTSPR_CPU6(SPRN_MD_TWC, r10, r11)
+	mtspr	SPRN_MD_TWC, r10
 	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
 	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
 			  _PAGE_PRESENT | _PAGE_NO_CACHE
-	MTSPR_CPU6(SPRN_MD_RPN, r10, r11)	/* Update TLB entry */
+	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
 	li	r11, RPN_PATTERN
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
@@ -701,11 +684,11 @@ DTLBMissLinear:
 	mtcr	r3
 	/* Set 8M byte page and mark it valid */
 	li	r11, MD_PS8MEG | MD_SVALID
-	MTSPR_CPU6(SPRN_MD_TWC, r11, r3)
+	mtspr	SPRN_MD_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
 			  _PAGE_PRESENT
-	MTSPR_CPU6(SPRN_MD_RPN, r10, r11)	/* Update TLB entry */
+	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
 	li	r11, RPN_PATTERN
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
@@ -718,11 +701,11 @@ ITLBMissLinear:
 	mtcr	r3
 	/* Set 8M byte page and mark it valid */
 	li	r11, MI_PS8MEG | MI_SVALID | _PAGE_EXEC
-	MTSPR_CPU6(SPRN_MI_TWC, r11, r3)
+	mtspr	SPRN_MI_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
 			  _PAGE_PRESENT
-	MTSPR_CPU6(SPRN_MI_RPN, r10, r11)	/* Update TLB entry */
+	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
 	mfspr	r3, SPRN_SPRG_SCRATCH2
 	EXCEPTION_EPILOG_0
@@ -933,13 +916,6 @@ start_here:
 	 */
 	lis	r6, swapper_pg_dir@ha
 	tophys(r6,r6)
-#ifdef CONFIG_8xx_CPU6
-	lis	r4, cpu6_errata_word@h
-	ori	r4, r4, cpu6_errata_word@l
-	li	r3, 0x3f80
-	stw	r3, 12(r4)
-	lwz	r3, 12(r4)
-#endif
 	mtspr	SPRN_M_TW, r6
 	lis	r4,2f@h
 	ori	r4,r4,2f@l
@@ -1094,12 +1070,6 @@ swapper_pg_dir:
 abatron_pteptrs:
 	.space	8
 
-#ifdef CONFIG_8xx_CPU6
-	.globl	cpu6_errata_word
-cpu6_errata_word:
-	.space	16
-#endif
-
 #ifdef CONFIG_PPC_8xx_PERF_EVENT
 	.globl	itlb_miss_counter
 itlb_miss_counter:
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index e7f33e96b395..e417988eaef9 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -124,18 +124,6 @@ config 8xx_GPIO
 
 	  If in doubt, say Y here.
 
-config 8xx_CPU6
-	bool "CPU6 Silicon Errata (860 Pre Rev. C)"
-	help
-	  MPC860 CPUs, prior to Rev C have some bugs in the silicon, which
-	  require workarounds for Linux (and most other OSes to work).  If you
-	  get a BUG() very early in boot, this might fix the problem.  For
-	  more details read the document entitled "MPC860 Family Device Errata
-	  Reference" on Freescale's website.  This option also incurs a
-	  performance hit.
-
-	  If in doubt, say N here.
-
 config 8xx_CPU15
 	bool "CPU15 Silicon Errata"
 	depends on !HUGETLB_PAGE
-- 
2.13.3
