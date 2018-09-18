Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F8L82HSdzF3Fm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 02:57:20 +1000 (AEST)
Message-Id: <3e7b4c6e023d9bba2b76439492a1ad65c72b3023.1537288312.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537288312.git.christophe.leroy@c-s.fr>
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 07/20] powerpc/mm: Use hardware assistance in TLB handlers
 on the 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 18 Sep 2018 16:57:16 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today, on the 8xx the TLB handlers do SW tablewalk by doing all
the calculation in ASM, in order to match with the Linux page
table structure.

The 8xx offers hardware assistance which allows significant size
reduction of the TLB handlers, hence also reduces the time spent
in the handlers.

However, using this HW assistance implies some constraints on the
page table structure:
- Regardless of the main page size used (4k or 16k), the
level 1 table (PGD) contains 1024 entries and each PGD entry covers
a 4Mbytes area which is managed by a level 2 table (PTE) containing
also 1024 entries each describing a 4k page.
- 16k pages require 4 identifical entries in the L2 table
- 512k pages PTE have to be spread every 128 bytes in the L2 table
- 8M pages PTE are at the address pointed by the L1 entry and each
8M page require 2 identical entries in the PGD.

This patch modifies the TLB handlers to use HW assistance for 4K PAGES.

Before that patch, the mean time spent in TLB miss handlers is:
- ITLB miss: 80 ticks
- DTLB miss: 62 ticks
After that patch, the mean time spent in TLB miss handlers is:
- ITLB miss: 72 ticks
- DTLB miss: 54 ticks
So the improvement is 10% for ITLB and 13% for DTLB misses

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 97 +++++++++++++-----------------------------
 arch/powerpc/mm/8xx_mmu.c      |  4 +-
 2 files changed, 32 insertions(+), 69 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 9b31721b522c..50e97027b507 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -292,7 +292,7 @@ SystemCall:
 	. = 0x1100
 /*
  * For the MPC8xx, this is a software tablewalk to load the instruction
- * TLB.  The task switch loads the M_TW register with the pointer to the first
+ * TLB.  The task switch loads the M_TWB register with the pointer to the first
  * level table.
  * If we discover there is no second level table (value is zero) or if there
  * is an invalid pte, we load that into the TLB, which causes another fault
@@ -314,7 +314,7 @@ SystemCall:
 InstructionTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
 	mtspr	SPRN_SPRG_SCRATCH1, r11
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
+#ifdef ITLB_MISS_KERNEL
 	mtspr	SPRN_SPRG_SCRATCH2, r12
 #endif
 
@@ -323,12 +323,11 @@ InstructionTLBMiss:
 	 */
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
 	INVALIDATE_ADJACENT_PAGES_CPU15(r11, r10)
+	mtspr	SPRN_MD_EPN, r10
 	/* Only modules will cause ITLB Misses as we always
 	 * pin the first 8MB of kernel memory */
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
-	mfcr	r12
-#endif
 #ifdef ITLB_MISS_KERNEL
+	mfcr	r12
 #if defined(SIMPLE_KERNEL_ADDRESS) && defined(CONFIG_PIN_TLB_TEXT)
 	andis.	r11, r10, 0x8000	/* Address >= 0x80000000 */
 #else
@@ -341,7 +340,7 @@ InstructionTLBMiss:
 #endif
 #endif
 #endif
-	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
+	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
 #ifdef ITLB_MISS_KERNEL
 #if defined(SIMPLE_KERNEL_ADDRESS) && defined(CONFIG_PIN_TLB_TEXT)
 	beq+	3f
@@ -351,23 +350,17 @@ InstructionTLBMiss:
 #ifndef CONFIG_PIN_TLB_TEXT
 	blt	cr7, ITLBMissLinear
 #endif
-	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
+	rlwinm	r11, r11, 0, 20, 31
+	oris	r11, r11, (swapper_pg_dir - PAGE_OFFSET)@ha
 3:
 #endif
-	/* Insert level 1 index */
-	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
 
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
-#ifdef CONFIG_HUGETLB_PAGE
-	mtcr	r11
-	bt-	28, 10f		/* bit 28 = Large page (8M) */
-#endif
-	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
+	mtspr	SPRN_MD_TWC, r11
+	mfspr	r10, SPRN_MD_TWC
 	lwz	r10, 0(r10)	/* Get the pte */
-4:
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
+
+#ifdef ITLB_MISS_KERNEL
 	mtcr	r12
 #endif
 	/* Load the MI_TWC with the attributes for this "segment." */
@@ -392,7 +385,7 @@ InstructionTLBMiss:
 	/* Restore registers */
 0:	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
+#ifdef ITLB_MISS_KERNEL
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 #endif
 	rfi
@@ -405,20 +398,12 @@ InstructionTLBMiss:
 	stw	r10, (itlb_miss_counter - PAGE_OFFSET)@l(0)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
+#ifdef ITLB_MISS_KERNEL
 	mfspr	r12, SPRN_SPRG_SCRATCH2
 #endif
 	rfi
 #endif
 
-#ifdef CONFIG_HUGETLB_PAGE
-10:	/* 8M pages */
-	/* Level 2 base */
-	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-#endif
-
 	. = 0x1200
 DataStoreTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
@@ -432,7 +417,7 @@ DataStoreTLBMiss:
 	mfspr	r10, SPRN_MD_EPN
 	rlwinm	r11, r10, 16, 0xfff8
 	cmpli	cr0, r11, PAGE_OFFSET@h
-	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
+	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
 	blt+	3f
 	rlwinm	r11, r10, 16, 0xfff8
 #ifndef CONFIG_PIN_TLB_IMMR
@@ -445,24 +430,16 @@ DataStoreTLBMiss:
 	patch_site	0b, patch__dtlbmiss_immr_jmp
 #endif
 	blt	cr7, DTLBMissLinear
-	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
+	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
+	rlwinm	r11, r11, 0, 20, 31
+	oris	r11, r11, (swapper_pg_dir - PAGE_OFFSET)@ha
 3:
-
-	/* Insert level 1 index */
-	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
 
-	/* We have a pte table, so load fetch the pte from the table.
-	 */
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
-#ifdef CONFIG_HUGETLB_PAGE
-	mtcr	r11
-	bt-	28, 10f		/* bit 28 = Large page (8M) */
-#endif
-	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
+	mtspr	SPRN_MD_TWC, r11
+	mfspr	r10, SPRN_MD_TWC
 	lwz	r10, 0(r10)	/* Get the pte */
-4:
+
 	mtcr	r12
 
 	/* Insert the Guarded flag into the TWC from the Linux PTE.
@@ -517,15 +494,6 @@ DataStoreTLBMiss:
 	rfi
 #endif
 
-#ifdef CONFIG_HUGETLB_PAGE
-10:	/* 8M pages */
-	/* Extract level 2 index */
-	/* Level 2 base */
-	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-#endif
-
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
  * addresses.  There is nothing to do but handle a big time error fault.
@@ -696,9 +664,10 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	/* fetch instruction from memory. */
 	mfspr	r10, SPRN_SRR0
+	mtspr	SPRN_MD_EPN, r10
 	rlwinm	r11, r10, 16, 0xfff8
 	cmpli	cr0, r11, PAGE_OFFSET@h
-	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
+	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
 	blt+	3f
 	rlwinm	r11, r10, 16, 0xfff8
 
@@ -708,17 +677,17 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	/* create physical page address from effective address */
 	tophys(r11, r10)
 	blt-	cr7, 201f
-	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
-	/* Insert level 1 index */
-3:	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
+	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
+	rlwinm	r11, r11, 0, 20, 31
+	oris	r11, r11, (swapper_pg_dir - PAGE_OFFSET)@ha
+3:
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	mtspr	SPRN_MD_TWC, r11
 	mtcr	r11
+	mfspr	r11, SPRN_MD_TWC
+	lwz	r11, 0(r11)	/* Get the pte */
 	bt	28,200f		/* bit 28 = Large page (8M) */
 	bt	29,202f		/* bit 29 = Large page (8M or 512K) */
-	rlwinm	r11, r11,0,0,19	/* Extract page descriptor page address */
-	/* Insert level 2 index */
-	rlwimi	r11, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
-	lwz	r11, 0(r11)	/* Get the pte */
 	/* concat physical page address(r11) and page offset(r10) */
 	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT, 31
 201:	lwz	r11,0(r11)
@@ -740,18 +709,12 @@ FixupDAR:/* Entry point for dcbx workaround. */
 141:	mfspr	r10,SPRN_SPRG_SCRATCH2
 	b	DARFixed	/* Nope, go back to normal TLB processing */
 
-	/* concat physical page address(r11) and page offset(r10) */
 200:
-	rlwinm	r11, r10, 0, ~HUGEPD_SHIFT_MASK
-	lwz	r11, 0(r11)	/* Get the pte */
 	/* concat physical page address(r11) and page offset(r10) */
 	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT_8M, 31
 	b	201b
 
 202:
-	rlwinm	r11, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
-	rlwimi	r11, r10, 32 - (PAGE_SHIFT_512K - 2), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
-	lwz	r11, 0(r11)	/* Get the pte */
 	/* concat physical page address(r11) and page offset(r10) */
 	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT_512K, 31
 	b	201b
@@ -867,7 +830,7 @@ start_here:
 
 	lis	r6, swapper_pg_dir@ha
 	tophys(r6,r6)
-	mtspr	SPRN_M_TW, r6
+	mtspr	SPRN_M_TWB, r6
 
 	bl	early_init	/* We have to do this with MMU on */
 
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index d39f3af03221..896e710e5697 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -174,12 +174,12 @@ void set_context(unsigned long id, pgd_t *pgd)
 	*(ptr + 1) = pgd;
 #endif
 
-	/* Register M_TW will contain base address of level 1 table minus the
+	/* Register M_TWB will contain base address of level 1 table minus the
 	 * lower part of the kernel PGDIR base address, so that all accesses to
 	 * level 1 table are done relative to lower part of kernel PGDIR base
 	 * address.
 	 */
-	mtspr(SPRN_M_TW, __pa(pgd) - offset);
+	mtspr(SPRN_M_TWB, __pa(pgd) - offset);
 
 	/* Update context */
 	mtspr(SPRN_M_CASID, id - 1);
-- 
2.13.3
