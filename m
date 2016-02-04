Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 6953B1A026C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 21:33:19 +1100 (AEDT)
Message-Id: <240ec2c9fb303060bf57a194314a54e88abfb784.1454581227.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454581226.git.christophe.leroy@c-s.fr>
References: <cover.1454581226.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 08/23] powerpc/8xx: Map IMMR area with 512k page at a fixed
 address
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  4 Feb 2016 11:33:17 +0100 (CET)
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

With the patch, on the same principle as what was done for the RAM,
the IMMR gets mapped by a 512k page.

In 4k pages mode, we reserve a 4Mb area for mapping IMMR. The TLB
miss handler checks that we are within the first 512k and bail out
with page not marked valid if we are outside

In 16k pages mode, it is not realistic to reserve a 64Mb area, so
we do a standard mapping of the 512k area using 32 pages of 16k.
The CPM will be mapped via the first two pages, and the SEC engine
will be mapped via the 16th and 17th pages. As the pages are marked
guarded, there will be no speculative accesses.

With this patch applied, the number of DTLB misses during the 10 min
period is reduced to 11.8 millions for a duration of 5.8s, which
represents 2% of the non-idle time hence yet another 10% reduction.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2:
- using bt instead of blt/bgt
- reorganised in order to have only one taken branch for both 512k
and 8M instead of a first branch for both 8M and 512k then a second
branch for 512k

v3:
- using fixmap
- using the new x_block_mapped() functions

v4: no change
v5: no change
v6: removed use of pmd_val() as L-value

 arch/powerpc/include/asm/fixmap.h |  9 ++++++-
 arch/powerpc/kernel/head_8xx.S    | 36 +++++++++++++++++++++++++-
 arch/powerpc/mm/8xx_mmu.c         | 53 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/mmu_decl.h        |  3 ++-
 4 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index d7dd8fb..b954dc3 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -52,12 +52,19 @@ enum fixed_addresses {
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
 #ifdef CONFIG_PPC_8xx
-	/* For IMMR we need an aligned 512K area */
 	FIX_IMMR_START,
+#ifdef CONFIG_PPC_4K_PAGES
+	/* For IMMR we need an aligned 4M area (full PGD entry) */
+	FIX_IMMR_TOP = (FIX_IMMR_START - 1 + ((4 * 1024 * 1024) / PAGE_SIZE)) &
+		       ~(((4 * 1024 * 1024) / PAGE_SIZE) - 1),
+	FIX_IMMR_BASE = FIX_IMMR_TOP - 1 + ((4 * 1024 * 1024) / PAGE_SIZE),
+#else
+	/* For IMMR we need an aligned 512K area */
 	FIX_IMMR_TOP = (FIX_IMMR_START - 1 + ((512 * 1024) / PAGE_SIZE)) &
 		       ~(((512 * 1024) / PAGE_SIZE) - 1),
 	FIX_IMMR_BASE = FIX_IMMR_TOP - 1 + ((512 * 1024) / PAGE_SIZE),
 #endif
+#endif
 	/* FIX_PCIE_MCFG, */
 	__end_of_fixed_addresses
 };
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 09173ae..ae721a1 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -254,6 +254,37 @@ DataAccess:
 	. = 0x400
 InstructionAccess:
 
+/*
+ * Bottom part of DTLBMiss handler for 512k pages
+ * not enough space in the primary location
+ */
+#ifdef CONFIG_PPC_4K_PAGES
+/*
+ * 512k pages are only used for mapping IMMR area in 4K pages mode.
+ * Only map the first 512k page of the 4M area covered by the PGD entry.
+ * This should not happen, but if we are called for another page of that
+ * area, don't mark it valid
+ *
+ * In 16k pages mode, IMMR is directly mapped with 16k pages
+ */
+DTLBMiss512k:
+	rlwinm.	r10, r10, 0, 0x00380000
+	bne-	1f
+	ori	r11, r11, MD_SVALID
+1:	mtcr	r3
+	MTSPR_CPU6(SPRN_MD_TWC, r11, r3)
+	rlwinm	r10, r11, 0, 0xffc00000
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SHARED | _PAGE_DIRTY	| \
+			  _PAGE_PRESENT | _PAGE_NO_CACHE
+	MTSPR_CPU6(SPRN_MD_RPN, r10, r3)	/* Update TLB entry */
+
+	li	r11, RPN_PATTERN
+	mfspr	r3, SPRN_SPRG_SCRATCH2
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	EXCEPTION_EPILOG_0
+	rfi
+#endif
+
 /* External interrupt */
 	EXCEPTION(0x500, HardwareInterrupt, do_IRQ, EXC_XFER_LITE)
 
@@ -405,6 +436,9 @@ DataStoreTLBMiss:
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
 	mtcr	r11
 	bt-	28,DTLBMiss8M		/* bit 28 = Large page (8M) */
+#ifdef CONFIG_PPC_4K_PAGES
+	bt-	29,DTLBMiss512k		/* bit 29 = Large page (8M or 512K) */
+#endif
 	mtcr	r3
 
 	/* We have a pte table, so load fetch the pte from the table.
@@ -559,7 +593,7 @@ FixupDAR:/* Entry point for dcbx workaround. */
 3:	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
 	mtcr	r11
-	bt	28,200f		/* bit 28 = Large page (8M) */
+	bt	29,200f		/* bit 29 = Large page (8M or 512K) */
 	rlwinm	r11, r11,0,0,19	/* Extract page descriptor page address */
 	/* Insert level 2 index */
 	rlwimi	r11, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index a84f5eb..f37d5ec 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -13,10 +13,61 @@
  */
 
 #include <linux/memblock.h>
+#include <asm/fixmap.h>
 
 #include "mmu_decl.h"
 
+#define IMMR_SIZE (__fix_to_virt(FIX_IMMR_TOP) + PAGE_SIZE - VIRT_IMMR_BASE)
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
+static void mmu_mapin_immr(void)
+{
+	unsigned long p = PHYS_IMMR_BASE;
+	unsigned long v = VIRT_IMMR_BASE;
+#ifdef CONFIG_PPC_4K_PAGES
+	pmd_t *pmdp;
+	unsigned long val = p | MD_PS512K | MD_GUARDED;
+
+	pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
+	*pmdp = __pmd(val);
+#else /* CONFIG_PPC_16K_PAGES */
+	unsigned long f = pgprot_val(PAGE_KERNEL_NCG);
+	int offset;
+
+	for (offset = 0; offset < IMMR_SIZE; offset += PAGE_SIZE)
+		map_page(v + offset, p + offset, f);
+#endif
+}
+
 /*
  * MMU_init_hw does the chip-specific initialization of the MMU hardware.
  */
@@ -79,6 +130,8 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 	 */
 	memblock_set_current_limit(mapped);
 
+	mmu_mapin_immr();
+
 	return mapped;
 }
 
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index e7228b7..3872332 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -166,9 +166,10 @@ struct tlbcam {
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
