Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4fXV2htFzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 01:04:10 +1000 (AEST)
Message-Id: <e4c99d13abe69060d01069ae74d439bf9adff3f9.1462052179.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1462052179.git.christophe.leroy@c-s.fr>
References: <cover.1462052179.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 5/7] powerpc/8xx: Don't use page table for linear memory
 space
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 11 May 2016 17:04:06 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of using the first level page table to define mappings for
the linear memory space, we can use direct mapping from the TLB
handling routines. This has several advantages:
* No need to read the tables at each TLB miss
* No issue in 16k pages mode where the 1st level table maps 64 Mbytes

The size of the available linear space is known at system startup.
In order to avoid data access at each TLB miss to know the memory
size, the TLB routine is patched at startup with the proper size

This patch provides a 10%-15% improvment of TLB miss handling for
kernel addresses

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: No change

 arch/powerpc/kernel/head_8xx.S | 71 ++++++++++++++++++++++--------------------
 arch/powerpc/mm/8xx_mmu.c      | 56 +++++++++++----------------------
 2 files changed, 55 insertions(+), 72 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index d9a1656..3de7d02 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -389,52 +389,52 @@ InstructionTLBMiss:
  * not enough space in the DataStoreTLBMiss area
  */
 DTLBMissIMMR:
-	mtcr	r3
+	mtcr	r10
 	/* Set 512k byte guarded page and mark it valid */
 	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
-	MTSPR_CPU6(SPRN_MD_TWC, r10, r3)
+	MTSPR_CPU6(SPRN_MD_TWC, r10, r11)
 	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
 	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
 			  _PAGE_PRESENT | _PAGE_NO_CACHE
-	MTSPR_CPU6(SPRN_MD_RPN, r10, r3)	/* Update TLB entry */
+	MTSPR_CPU6(SPRN_MD_RPN, r10, r11)	/* Update TLB entry */
 
 	li	r11, RPN_PATTERN
-	mfspr	r3, SPRN_SPRG_SCRATCH2
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
 	EXCEPTION_EPILOG_0
 	rfi
 
 	. = 0x1200
 DataStoreTLBMiss:
-	mtspr	SPRN_SPRG_SCRATCH2, r3
 	EXCEPTION_PROLOG_0
-	mfcr	r3
+	mfcr	r10
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	mfspr	r10, SPRN_MD_EPN
-	IS_KERNEL(r11, r10)
-	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
-	BRANCH_UNLESS_KERNEL(3f)
-
-	rlwinm	r11, r10, 16, 0xfff8
+	mfspr	r11, SPRN_MD_EPN
+	rlwinm	r11, r11, 16, 0xfff8
 #ifndef CONFIG_PIN_TLB
 	cmpli	cr0, r11, VIRT_IMMR_BASE@h
+#endif
+	cmpli	cr7, r11, PAGE_OFFSET@h
+#ifndef CONFIG_PIN_TLB
 _ENTRY(DTLBMiss_jmp)
 	beq-	DTLBMissIMMR
 #endif
+	bge-	cr7, 4f
 
-	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
+	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
 3:
+	mtcr	r10
+#ifdef CONFIG_8xx_CPU6
+	mtspr	SPRN_SPRG_SCRATCH2, r3
+#endif
+	mfspr	r10, SPRN_MD_EPN
 
 	/* Insert level 1 index */
 	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
-	mtcr	r11
-	bt-	28,DTLBMiss8M		/* bit 28 = Large page (8M) */
-	mtcr	r3
 
 	/* We have a pte table, so load fetch the pte from the table.
 	 */
@@ -482,29 +482,30 @@ _ENTRY(DTLBMiss_jmp)
 	MTSPR_CPU6(SPRN_MD_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
+#ifdef CONFIG_8xx_CPU6
 	mfspr	r3, SPRN_SPRG_SCRATCH2
+#endif
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
 	EXCEPTION_EPILOG_0
 	rfi
 
-DTLBMiss8M:
-	mtcr	r3
-	ori	r11, r11, MD_SVALID
-	MTSPR_CPU6(SPRN_MD_TWC, r11, r3)
-#ifdef CONFIG_PPC_16K_PAGES
-	/*
-	 * In 16k pages mode, each PGD entry defines a 64M block.
-	 * Here we select the 8M page within the block.
-	 */
-	rlwimi	r11, r10, 0, 0x03800000
-#endif
-	rlwinm	r10, r11, 0, 0xff800000
+4:
+_ENTRY(DTLBMiss_cmp)
+	cmpli	cr0, r11, PAGE_OFFSET@h
+	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
+	bge-	3b
+
+	mtcr	r10
+	/* Set 8M byte page and mark it valid */
+	li	r10, MD_PS8MEG | MD_SVALID
+	MTSPR_CPU6(SPRN_MD_TWC, r10, r11)
+	mfspr	r10, SPRN_MD_EPN
+	rlwinm	r10, r10, 0, 0x0f800000		/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
 			  _PAGE_PRESENT
-	MTSPR_CPU6(SPRN_MD_RPN, r10, r3)	/* Update TLB entry */
+	MTSPR_CPU6(SPRN_MD_RPN, r10, r11)	/* Update TLB entry */
 
 	li	r11, RPN_PATTERN
-	mfspr	r3, SPRN_SPRG_SCRATCH2
 	mtspr	SPRN_DAR, r11	/* Tag DAR */
 	EXCEPTION_EPILOG_0
 	rfi
@@ -583,12 +584,14 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	IS_KERNEL(r11, r10)
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
 	BRANCH_UNLESS_KERNEL(3f)
+	rlwinm	r11, r10, 16, 0xfff8
+_ENTRY(FixupDAR_cmp)
+	cmpli	cr7, r11, PAGE_OFFSET@h
+	blt-	cr7, 200f
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 	/* Insert level 1 index */
 3:	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
-	mtcr	r11
-	bt	28,200f		/* bit 28 = Large page (8M) */
 	rlwinm	r11, r11,0,0,19	/* Extract page descriptor page address */
 	/* Insert level 2 index */
 	rlwimi	r11, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
@@ -614,8 +617,8 @@ FixupDAR:/* Entry point for dcbx workaround. */
 141:	mfspr	r10,SPRN_SPRG_SCRATCH2
 	b	DARFixed	/* Nope, go back to normal TLB processing */
 
-	/* concat physical page address(r11) and page offset(r10) */
-200:	rlwimi	r11, r10, 0, 32 - (PAGE_SHIFT << 1), 31
+	/* create physical page address from effective address */
+200:	tophys(r11, r10)
 	b	201b
 
 144:	mfspr	r10, SPRN_DSISR
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 2207725..996dfaa 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -58,9 +58,7 @@ void __init MMU_init_hw(void)
 	/* Nothing to do for the time being but keep it similar to other PPC */
 }
 
-#define LARGE_PAGE_SIZE_4M	(1<<22)
 #define LARGE_PAGE_SIZE_8M	(1<<23)
-#define LARGE_PAGE_SIZE_64M	(1<<26)
 
 static void mmu_mapin_immr(void)
 {
@@ -77,52 +75,33 @@ static void mmu_mapin_immr(void)
 #ifndef CONFIG_PIN_TLB
 extern unsigned int DTLBMiss_jmp;
 #endif
+extern unsigned int DTLBMiss_cmp, FixupDAR_cmp;
 
-unsigned long __init mmu_mapin_ram(unsigned long top)
+void mmu_patch_cmp_limit(unsigned int *addr, unsigned long mapped)
 {
-	unsigned long v, s, mapped;
-	phys_addr_t p;
+	unsigned int instr = *addr;
 
-	v = KERNELBASE;
-	p = 0;
-	s = top;
+	instr &= 0xffff0000;
+	instr |= (unsigned long)__va(mapped) >> 16;
+	patch_instruction(addr, instr);
+}
+
+unsigned long __init mmu_mapin_ram(unsigned long top)
+{
+	unsigned long mapped;
 
 	if (__map_without_ltlbs) {
+		mapped = 0;
 		mmu_mapin_immr();
 #ifndef CONFIG_PIN_TLB
 		patch_instruction(&DTLBMiss_jmp, PPC_INST_NOP);
 #endif
-		return 0;
-	}
-
-#ifdef CONFIG_PPC_4K_PAGES
-	while (s >= LARGE_PAGE_SIZE_8M) {
-		pmd_t *pmdp;
-		unsigned long val = p | MD_PS8MEG;
-
-		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
-		*pmdp++ = __pmd(val);
-		*pmdp++ = __pmd(val + LARGE_PAGE_SIZE_4M);
-
-		v += LARGE_PAGE_SIZE_8M;
-		p += LARGE_PAGE_SIZE_8M;
-		s -= LARGE_PAGE_SIZE_8M;
+	} else {
+		mapped = top & ~(LARGE_PAGE_SIZE_8M - 1);
 	}
-#else /* CONFIG_PPC_16K_PAGES */
-	while (s >= LARGE_PAGE_SIZE_64M) {
-		pmd_t *pmdp;
-		unsigned long val = p | MD_PS8MEG;
-
-		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
-		*pmdp++ = __pmd(val);
-
-		v += LARGE_PAGE_SIZE_64M;
-		p += LARGE_PAGE_SIZE_64M;
-		s -= LARGE_PAGE_SIZE_64M;
-	}
-#endif
 
-	mapped = top - s;
+	mmu_patch_cmp_limit(&DTLBMiss_cmp, mapped);
+	mmu_patch_cmp_limit(&FixupDAR_cmp, mapped);
 
 	/* If the size of RAM is not an exact power of two, we may not
 	 * have covered RAM in its entirety with 8 MiB
@@ -131,7 +110,8 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 	 * coverage with normal-sized pages (or other reasons) do not
 	 * attempt to allocate outside the allowed range.
 	 */
-	memblock_set_current_limit(mapped);
+	if (mapped)
+		memblock_set_current_limit(mapped);
 
 	return mapped;
 }
-- 
2.1.0
