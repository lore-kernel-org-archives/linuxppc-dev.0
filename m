Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6vml0kM3zDqjY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:08:55 +1000 (AEST)
Message-Id: <62894dc90217ccac507945f3af58dcba6aa14405.1499633349.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1499633349.git.christophe.leroy@c-s.fr>
References: <cover.1499633349.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/7] powerpc/8xx: Make pinning of ITLBs optional
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Jul 2017 12:08:51 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As stated in a comment in head_8xx.S, today we "Always pin the first
8 MB ITLB to prevent ITLB misses while mucking around with SRR0/SRR1
in asm".

This issue has just been cleared by the preceding patch, therefore
we can make this pinning optional (on by default) and independent
of DATA pinning.

This patch also makes pinning of IMMR independent of pinning of DATA.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig           | 10 ++++++++
 arch/powerpc/kernel/head_8xx.S | 57 +++++++++++++++++++++++++++++++++---------
 arch/powerpc/mm/8xx_mmu.c      |  8 +++++-
 3 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 36f858c37ca7..d09b259d3621 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1167,10 +1167,20 @@ config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
 	depends on ADVANCED_OPTIONS && 8xx
 
+config PIN_TLB_DATA
+	bool "Pinned TLB for DATA"
+	depends on PIN_TLB
+	default y
+
 config PIN_TLB_IMMR
 	bool "Pinned TLB for IMMR"
 	depends on PIN_TLB
 	default y
+
+config PIN_TLB_TEXT
+	bool "Pinned TLB for TEXT"
+	depends on PIN_TLB
+	default y
 endmenu
 
 if PPC64
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 02671e33905c..b889b5812274 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -55,6 +55,15 @@
 #define SIMPLE_KERNEL_ADDRESS		1
 #endif
 
+/*
+ * We need an ITLB miss handler for kernel addresses if:
+ * - Either we have modules
+ * - Or we have not pinned the first 8M
+ */
+#if defined(CONFIG_MODULES) || !defined(CONFIG_PIN_TLB_TEXT) || \
+    defined(CONFIG_DEBUG_PAGEALLOC)
+#define ITLB_MISS_KERNEL	1
+#endif
 
 /*
  * Value for the bits that have fixed value in RPN entries.
@@ -318,7 +327,7 @@ SystemCall:
 #endif
 
 InstructionTLBMiss:
-#if defined(CONFIG_8xx_CPU6) || defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC) || defined (CONFIG_HUGETLB_PAGE)
+#if defined(CONFIG_8xx_CPU6) || defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mtspr	SPRN_SPRG_SCRATCH2, r3
 #endif
 	EXCEPTION_PROLOG_0
@@ -336,24 +345,32 @@ InstructionTLBMiss:
 	INVALIDATE_ADJACENT_PAGES_CPU15(r11, r10)
 	/* Only modules will cause ITLB Misses as we always
 	 * pin the first 8MB of kernel memory */
-#if defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC) || defined (CONFIG_HUGETLB_PAGE)
+#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mfcr	r3
 #endif
-#if defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
-#ifdef SIMPLE_KERNEL_ADDRESS
+#ifdef ITLB_MISS_KERNEL
+#if defined(SIMPLE_KERNEL_ADDRESS) && defined(CONFIG_PIN_TLB_TEXT)
 	andis.	r11, r10, 0x8000	/* Address >= 0x80000000 */
 #else
 	rlwinm	r11, r10, 16, 0xfff8
 	cmpli	cr0, r11, PAGE_OFFSET@h
+#ifndef CONFIG_PIN_TLB_TEXT
+	/* It is assumed that kernel code fits into the first 8M page */
+_ENTRY(ITLBMiss_cmp)
+	cmpli	cr7, r11, (PAGE_OFFSET + 0x0800000)@h
+#endif
 #endif
 #endif
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
-#if defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
-#ifdef SIMPLE_KERNEL_ADDRESS
+#ifdef ITLB_MISS_KERNEL
+#if defined(SIMPLE_KERNEL_ADDRESS) && defined(CONFIG_PIN_TLB_TEXT)
 	beq+	3f
 #else
 	blt+	3f
 #endif
+#ifndef CONFIG_PIN_TLB_TEXT
+	blt	cr7, ITLBMissLinear
+#endif
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 3:
 #endif
@@ -371,7 +388,7 @@ InstructionTLBMiss:
 	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
 	lwz	r10, 0(r10)	/* Get the pte */
 4:
-#if defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC) || defined (CONFIG_HUGETLB_PAGE)
+#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mtcr	r3
 #endif
 	/* Insert the APG into the TWC from the Linux PTE. */
@@ -402,7 +419,7 @@ InstructionTLBMiss:
 	MTSPR_CPU6(SPRN_MI_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
-#if defined(CONFIG_8xx_CPU6) || defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC) || defined (CONFIG_HUGETLB_PAGE)
+#if defined(CONFIG_8xx_CPU6) || defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mfspr	r3, SPRN_SPRG_SCRATCH2
 #endif
 	EXCEPTION_EPILOG_0
@@ -697,6 +714,22 @@ DTLBMissLinear:
 	EXCEPTION_EPILOG_0
 	rfi
 
+#ifndef CONFIG_PIN_TLB_TEXT
+ITLBMissLinear:
+	mtcr	r3
+	/* Set 8M byte page and mark it valid */
+	li	r11, MI_PS8MEG | MI_SVALID | _PAGE_EXEC
+	MTSPR_CPU6(SPRN_MI_TWC, r11, r3)
+	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
+	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
+			  _PAGE_PRESENT
+	MTSPR_CPU6(SPRN_MI_RPN, r10, r11)	/* Update TLB entry */
+
+	mfspr	r3, SPRN_SPRG_SCRATCH2
+	EXCEPTION_EPILOG_0
+	rfi
+#endif
+
 /* This is the procedure to calculate the data EA for buggy dcbx,dcbi instructions
  * by decoding the registers used by the dcbx instruction and adding them.
  * DAR is set to the calculated address.
@@ -958,15 +991,14 @@ initial_mmu:
 	mtspr	SPRN_MD_CTR, r10	/* remove PINNED DTLB entries */
 
 	tlbia			/* Invalidate all TLB entries */
-/* Always pin the first 8 MB ITLB to prevent ITLB
-   misses while mucking around with SRR0/SRR1 in asm
-*/
+#ifdef CONFIG_PIN_TLB_TEXT
 	lis	r8, MI_RSV4I@h
 	ori	r8, r8, 0x1c00
 
 	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
+#endif
 
-#ifdef CONFIG_PIN_TLB
+#ifdef CONFIG_PIN_TLB_DATA
 	oris	r10, r10, MD_RSV4I@h
 	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
 #endif
@@ -992,6 +1024,7 @@ initial_mmu:
 	 * internal registers (among other things).
 	 */
 #ifdef CONFIG_PIN_TLB_IMMR
+	oris	r10, r10, MD_RSV4I@h
 	ori	r10, r10, 0x1c00
 	mtspr	SPRN_MD_CTR, r10
 
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index f3a00cef9c34..ab3b10746f36 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -65,7 +65,7 @@ unsigned long p_block_mapped(phys_addr_t pa)
 void __init MMU_init_hw(void)
 {
 	/* PIN up to the 3 first 8Mb after IMMR in DTLB table */
-#ifdef CONFIG_PIN_TLB
+#ifdef CONFIG_PIN_TLB_DATA
 	unsigned long ctr = mfspr(SPRN_MD_CTR) & 0xfe000000;
 	unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY;
 #ifdef CONFIG_PIN_TLB_IMMR
@@ -103,6 +103,9 @@ static void mmu_mapin_immr(void)
 extern unsigned int DTLBMiss_jmp;
 #endif
 extern unsigned int DTLBMiss_cmp, FixupDAR_cmp;
+#ifndef CONFIG_PIN_TLB_TEXT
+extern unsigned int ITLBMiss_cmp;
+#endif
 
 void mmu_patch_cmp_limit(unsigned int *addr, unsigned long mapped)
 {
@@ -123,6 +126,9 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 #ifndef CONFIG_PIN_TLB_IMMR
 		patch_instruction(&DTLBMiss_jmp, PPC_INST_NOP);
 #endif
+#ifndef CONFIG_PIN_TLB_TEXT
+		mmu_patch_cmp_limit(&ITLBMiss_cmp, 0);
+#endif
 	} else {
 		mapped = top & ~(LARGE_PAGE_SIZE_8M - 1);
 	}
-- 
2.12.0
