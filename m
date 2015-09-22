Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 6E44E1A05A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:50:49 +1000 (AEST)
Message-Id: <bfa8400abd8b5174942616aae5876a55242f5468.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442939410.git.christophe.leroy@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 08/25] powerpc/8xx: Map IMMR area with 512k page at a fixed
 address
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:50:44 +0200 (CEST)
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
the reference 600s period. 77% of the missed are on user addresses
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

With the patch, on the same principle as what was done for the RAM,
the IMMR gets mapped by a 512k page.

In 4k pages mode, we reserve a 4Mb area for mapping IMMR. The TLB
miss handler checks that we are within the first 512k and bail out
with page not marked valid if we are outside

In 16k pages mode, it is not realistic to reserve a 64Mb area, so
we do a standard mapping of the 512k area using 32 pages of 16:
the CPM will be mapped via the first two pages, and the SEC engine
will be mapped via the 16th and 17th pages

With this patch applies, the number of DTLB misses during the 10 min
period is reduced to 11.8 millions for a duration of 5.8s, which
represents 2% of the non-idle time hence yet another 10% reduction.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2:
- using bt instead of blt/bgt
- reorganised in order to have only one taken branch for both 512k
and 8M instead of a first branch for both 8M and 512k then a second
branch for 512k

 arch/powerpc/include/asm/pgtable-ppc32.h |  5 ++++
 arch/powerpc/kernel/head_8xx.S           | 36 ++++++++++++++++++++++-
 arch/powerpc/mm/8xx_mmu.c                | 50 ++++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable_32.c             | 20 +++++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 9c32656..ad5324f 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -53,6 +53,11 @@ extern int icache_44x_need_flush;
 #define pgd_ERROR(e) \
 	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
+#ifdef CONFIG_PPC_8xx
+#define IMMR_BASE	(0xff000000UL)
+#define IMMR_SIZE	(1UL << 19)
+#endif
+
 /*
  * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
  * value (for now) on others, from where we can start layout kernel
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 603124e..41b5d1b 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -253,6 +253,37 @@ DataAccess:
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
 
@@ -404,6 +435,9 @@ DataStoreTLBMiss:
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
 	mtcr	r11
 	bt-	28,DTLBMiss8M		/* bit 28 = Large page (8M) */
+#ifdef CONFIG_PPC_4K_PAGES
+	bt-	29,DTLBMiss512k		/* bit 29 = Large page (8M or 512K) */
+#endif
 	mtcr	r3
 
 	/* We have a pte table, so load fetch the pte from the table.
@@ -558,7 +592,7 @@ FixupDAR:/* Entry point for dcbx workaround. */
 3:	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
 	mtcr	r11
-	bt	28,200f		/* bit 28 = Large page (8M) */
+	bt	29,200f		/* bit 29 = Large page (8M or 512K) */
 	rlwinm	r11, r11,0,0,19	/* Extract page descriptor page address */
 	/* Insert level 2 index */
 	rlwimi	r11, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 0ddcb37..eeca14b 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -17,6 +17,54 @@
 #include "mmu_decl.h"
 
 extern int __map_without_ltlbs;
+
+/*
+ * Return PA for this VA if it is in IMMR area, or 0
+ */
+phys_addr_t v_mapped_by_ltlb(unsigned long va)
+{
+	unsigned long p = mfspr(SPRN_IMMR) & 0xfff80000;
+
+	if (__map_without_ltlbs)
+		return 0;
+	if (va >= IMMR_BASE && va < IMMR_BASE + IMMR_SIZE)
+		return p + va - IMMR_BASE;
+	return 0;
+}
+
+/*
+ * Return VA for a given PA or 0 if not mapped
+ */
+unsigned long p_mapped_by_ltlb(phys_addr_t pa)
+{
+	unsigned long p = mfspr(SPRN_IMMR) & 0xfff80000;
+
+	if (__map_without_ltlbs)
+		return 0;
+	if (pa >= p && pa < p + IMMR_SIZE)
+		return IMMR_BASE + pa - p;
+	return 0;
+}
+
+static void mmu_mapin_immr(void)
+{
+	unsigned long p = mfspr(SPRN_IMMR) & 0xfff80000;
+	unsigned long v = IMMR_BASE;
+#ifdef CONFIG_PPC_4K_PAGES
+	pmd_t *pmdp;
+	unsigned long val = p | MD_PS512K | MD_GUARDED;
+
+	pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
+	pmd_val(*pmdp) = val;
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
@@ -79,6 +127,8 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 	 */
 	memblock_set_current_limit(mapped);
 
+	mmu_mapin_immr();
+
 	return mapped;
 }
 
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 3fd9083..1f2fdbc 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -49,6 +49,10 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 #define HAVE_TLBCAM	1
 #endif
 
+#if CONFIG_PPC_8xx
+#define HAVE_LTLB	1
+#endif
+
 extern char etext[], _stext[];
 
 #ifdef HAVE_BATS
@@ -67,6 +71,14 @@ extern unsigned long p_mapped_by_tlbcam(phys_addr_t pa);
 #define p_mapped_by_tlbcam(x)	(0UL)
 #endif /* HAVE_TLBCAM */
 
+#ifdef HAVE_LTLB
+phys_addr_t v_mapped_by_ltlb(unsigned long va);
+unsigned long p_mapped_by_ltlb(phys_addr_t pa);
+#else /* !HAVE_LTLB */
+#define v_mapped_by_ltlb(x)	(0UL)
+#define p_mapped_by_ltlb(x)	(0UL)
+#endif /* HAVE_LTLB */
+
 static inline unsigned long p_mapped_by_other(phys_addr_t pa)
 {
 	unsigned long v;
@@ -75,6 +87,10 @@ static inline unsigned long p_mapped_by_other(phys_addr_t pa)
 	if (v /*&& p_mapped_by_bats(p+size-1)*/)
 		return v;
 
+	v = p_mapped_by_ltlb(pa);
+	if (v)
+		return v;
+
 	return p_mapped_by_tlbcam(pa);
 }
 
@@ -86,6 +102,10 @@ static inline phys_addr_t v_mapped_by_other(unsigned long va)
 	if (p)
 		return p;
 
+	p = v_mapped_by_ltlb(va);
+	if (p)
+		return p;
+
 	return v_mapped_by_tlbcam(va);
 }
 
-- 
2.1.0
