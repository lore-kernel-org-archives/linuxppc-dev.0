Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzks01gKtzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 01:01:24 +1000 (AEST)
Message-Id: <b4f92b43d5c09f4d56bdf086baa303efc7018d05.1462052178.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1462052178.git.christophe.leroy@c-s.fr>
References: <cover.1462052178.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/7] powerpc/8xx: Map IMMR area with 512k page at a fixed
 address
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  3 May 2016 17:01:19 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once the linear memory space has been mapped with 8Mb pages, as
seen in the related commit, we get 11 millions DTLB missed during
the reference 600s period. 77% of the misses are on user addresses
and 23% are on kernel addresses (1 fourth for linear address space
and 3 fourth for virtual address space)

Traditionaly, each driver manages one computer board which has its
own components with its own memory maps.
But on embedded chips like the MPC8xx, the SOC has all registers
located in the same IO area.

When looking at ioremaps done during startup, we see that
many drivers are re-mapping small parts of the IMMR for their own use
and all those small pieces gets their own 4k page, amplifying the
number of TLB misses: in our system we get 0xff000000 mapped 31 times
and 0xff003000 mapped 9 times.

Even if each part of IMMR was mapped only once with 4k pages, it would
still be several small mappings towards linear area.

This patch maps the IMMR with a single 512k page.

With this patch applied, the number of DTLB misses during the 10 min
period is reduced to 11.8 millions for a duration of 5.8s, which
represents 2% of the non-idle time hence yet another 10% reduction.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 29 ++++++++++++++++++++++
 arch/powerpc/mm/8xx_mmu.c      | 56 +++++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/mm/mmu_decl.h     |  3 ++-
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 378a185..44f4edb 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -384,6 +384,27 @@ InstructionTLBMiss:
 	EXCEPTION_EPILOG_0
 	rfi
 
+/*
+ * Bottom part of DataStoreTLBMiss handler for IMMR area
+ * not enough space in the DataStoreTLBMiss area
+ */
+DTLBMissIMMR:
+	mtcr	r3
+	/* Set 512k byte guarded page and mark it valid */
+	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
+	MTSPR_CPU6(SPRN_MD_TWC, r10, r3)
+	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
+	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
+			  _PAGE_PRESENT | _PAGE_NO_CACHE
+	MTSPR_CPU6(SPRN_MD_RPN, r10, r3)	/* Update TLB entry */
+
+	li	r11, RPN_PATTERN
+	mfspr	r3, SPRN_SPRG_SCRATCH2
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	EXCEPTION_EPILOG_0
+	rfi
+
 	. = 0x1200
 DataStoreTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH2, r3
@@ -397,6 +418,14 @@ DataStoreTLBMiss:
 	IS_KERNEL(r11, r10)
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
 	BRANCH_UNLESS_KERNEL(3f)
+
+	rlwinm	r11, r10, 16, 0xfff8
+#ifndef CONFIG_PIN_TLB
+	cmpli	cr0, r11, VIRT_IMMR_BASE@h
+_ENTRY(DTLBMiss_jmp)
+	beq-	DTLBMissIMMR
+#endif
+
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 3:
 
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 9491005..2207725 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -13,10 +13,43 @@
  */
 
 #include <linux/memblock.h>
+#include <asm/fixmap.h>
+#include <asm/code-patching.h>
 
 #include "mmu_decl.h"
 
+#define IMMR_SIZE (FIX_IMMR_SIZE << PAGE_SHIFT)
+
 extern int __map_without_ltlbs;
+
+/*
+ * Return PA for this VA if it is in IMMR area, or 0
+ */
+phys_addr_t v_block_mapped(unsigned long va)
+{
+	unsigned long p = PHYS_IMMR_BASE;
+
+	if (__map_without_ltlbs)
+		return 0;
+	if (va >= VIRT_IMMR_BASE && va < VIRT_IMMR_BASE + IMMR_SIZE)
+		return p + va - VIRT_IMMR_BASE;
+	return 0;
+}
+
+/*
+ * Return VA for a given PA or 0 if not mapped
+ */
+unsigned long p_block_mapped(phys_addr_t pa)
+{
+	unsigned long p = PHYS_IMMR_BASE;
+
+	if (__map_without_ltlbs)
+		return 0;
+	if (pa >= p && pa < p + IMMR_SIZE)
+		return VIRT_IMMR_BASE + pa - p;
+	return 0;
+}
+
 /*
  * MMU_init_hw does the chip-specific initialization of the MMU hardware.
  */
@@ -29,6 +62,22 @@ void __init MMU_init_hw(void)
 #define LARGE_PAGE_SIZE_8M	(1<<23)
 #define LARGE_PAGE_SIZE_64M	(1<<26)
 
+static void mmu_mapin_immr(void)
+{
+	unsigned long p = PHYS_IMMR_BASE;
+	unsigned long v = VIRT_IMMR_BASE;
+	unsigned long f = pgprot_val(PAGE_KERNEL_NCG);
+	int offset;
+
+	for (offset = 0; offset < IMMR_SIZE; offset += PAGE_SIZE)
+		map_page(v + offset, p + offset, f);
+}
+
+/* Address of instructions to patch */
+#ifndef CONFIG_PIN_TLB
+extern unsigned int DTLBMiss_jmp;
+#endif
+
 unsigned long __init mmu_mapin_ram(unsigned long top)
 {
 	unsigned long v, s, mapped;
@@ -38,8 +87,13 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 	p = 0;
 	s = top;
 
-	if (__map_without_ltlbs)
+	if (__map_without_ltlbs) {
+		mmu_mapin_immr();
+#ifndef CONFIG_PIN_TLB
+		patch_instruction(&DTLBMiss_jmp, PPC_INST_NOP);
+#endif
 		return 0;
+	}
 
 #ifdef CONFIG_PPC_4K_PAGES
 	while (s >= LARGE_PAGE_SIZE_8M) {
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index a41fab9..af51100 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -161,9 +161,10 @@ struct tlbcam {
 };
 #endif
 
-#if defined(CONFIG_6xx) || defined(CONFIG_FSL_BOOKE)
+#if defined(CONFIG_6xx) || defined(CONFIG_FSL_BOOKE) || defined(CONFIG_PPC_8xx)
 /* 6xx have BATS */
 /* FSL_BOOKE have TLBCAM */
+/* 8xx have LTLB */
 phys_addr_t v_block_mapped(unsigned long va);
 unsigned long p_block_mapped(phys_addr_t pa);
 #else
-- 
2.1.0
