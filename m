Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id CC6CA1A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 21:23:19 +1100 (AEDT)
Message-Id: <abec39712d536a31fb35f80931ff8e590c3874bb.1454932181.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454932181.git.christophe.leroy@c-s.fr>
References: <cover.1454932181.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 06/23] powerpc32: refactor x_mapped_by_bats() and
 x_mapped_by_tlbcam() together
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  9 Feb 2016 11:23:16 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

x_mapped_by_bats() and x_mapped_by_tlbcam() serve the same kind of
purpose, and are never defined at the same time.
So rename them x_block_mapped() and define them in the relevant
places

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change
v3: Functions are mutually exclusive so renamed iaw Scott comment instead of grouping into a single function
v4: no change
v5: no change
v6: no change
v7: Don't include x_block_mapped() from compilation in
arch/powerpc/mm/fsl_booke_mmu.c when CONFIG_FSL_BOOKE is not set
(problem reported by kbuild robot with a configuration having
CONFIG_FSL_BOOK3E and not CONFIG_FSL_BOOKE)

 arch/powerpc/mm/fsl_booke_mmu.c |  4 ++--
 arch/powerpc/mm/mmu_decl.h      | 10 ++++++++++
 arch/powerpc/mm/pgtable_32.c    | 44 ++++++-----------------------------------
 arch/powerpc/mm/ppc_mmu_32.c    |  4 ++--
 4 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index f3afe3d..5d45341 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -75,7 +75,7 @@ unsigned long tlbcam_sz(int idx)
 /*
  * Return PA for this VA if it is mapped by a CAM, or 0
  */
-phys_addr_t v_mapped_by_tlbcam(unsigned long va)
+phys_addr_t v_block_mapped(unsigned long va)
 {
 	int b;
 	for (b = 0; b < tlbcam_index; ++b)
@@ -87,7 +87,7 @@ phys_addr_t v_mapped_by_tlbcam(unsigned long va)
 /*
  * Return VA for a given PA or 0 if not mapped
  */
-unsigned long p_mapped_by_tlbcam(phys_addr_t pa)
+unsigned long p_block_mapped(phys_addr_t pa)
 {
 	int b;
 	for (b = 0; b < tlbcam_index; ++b)
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 7faeb9f..40dd5d3 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -158,3 +158,13 @@ struct tlbcam {
 	u32	MAS7;
 };
 #endif
+
+#if defined(CONFIG_6xx) || defined(CONFIG_FSL_BOOKE)
+/* 6xx have BATS */
+/* FSL_BOOKE have TLBCAM */
+phys_addr_t v_block_mapped(unsigned long va);
+unsigned long p_block_mapped(phys_addr_t pa);
+#else
+static inline phys_addr_t v_block_mapped(unsigned long va) { return 0; }
+static inline unsigned long p_block_mapped(phys_addr_t pa) { return 0; }
+#endif
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 7692d1b..db0d35e 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -41,32 +41,8 @@ unsigned long ioremap_base;
 unsigned long ioremap_bot;
 EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
-#ifdef CONFIG_6xx
-#define HAVE_BATS	1
-#endif
-
-#if defined(CONFIG_FSL_BOOKE)
-#define HAVE_TLBCAM	1
-#endif
-
 extern char etext[], _stext[];
 
-#ifdef HAVE_BATS
-extern phys_addr_t v_mapped_by_bats(unsigned long va);
-extern unsigned long p_mapped_by_bats(phys_addr_t pa);
-#else /* !HAVE_BATS */
-#define v_mapped_by_bats(x)	(0UL)
-#define p_mapped_by_bats(x)	(0UL)
-#endif /* HAVE_BATS */
-
-#ifdef HAVE_TLBCAM
-extern phys_addr_t v_mapped_by_tlbcam(unsigned long va);
-extern unsigned long p_mapped_by_tlbcam(phys_addr_t pa);
-#else /* !HAVE_TLBCAM */
-#define v_mapped_by_tlbcam(x)	(0UL)
-#define p_mapped_by_tlbcam(x)	(0UL)
-#endif /* HAVE_TLBCAM */
-
 #define PGDIR_ORDER	(32 + PGD_T_LOG2 - PGDIR_SHIFT)
 
 #ifndef CONFIG_PPC_4K_PAGES
@@ -228,19 +204,10 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 
 	/*
 	 * Is it already mapped?  Perhaps overlapped by a previous
-	 * BAT mapping.  If the whole area is mapped then we're done,
-	 * otherwise remap it since we want to keep the virt addrs for
-	 * each request contiguous.
-	 *
-	 * We make the assumption here that if the bottom and top
-	 * of the range we want are mapped then it's mapped to the
-	 * same virt address (and this is contiguous).
-	 *  -- Cort
+	 * mapping.
 	 */
-	if ((v = p_mapped_by_bats(p)) /*&& p_mapped_by_bats(p+size-1)*/ )
-		goto out;
-
-	if ((v = p_mapped_by_tlbcam(p)))
+	v = p_block_mapped(p);
+	if (v)
 		goto out;
 
 	if (slab_is_available()) {
@@ -278,7 +245,8 @@ void iounmap(volatile void __iomem *addr)
 	 * If mapped by BATs then there is nothing to do.
 	 * Calling vfree() generates a benign warning.
 	 */
-	if (v_mapped_by_bats((unsigned long)addr)) return;
+	if (v_block_mapped((unsigned long)addr))
+		return;
 
 	if (addr > high_memory && (unsigned long) addr < ioremap_bot)
 		vunmap((void *) (PAGE_MASK & (unsigned long)addr));
@@ -403,7 +371,7 @@ static int __change_page_attr(struct page *page, pgprot_t prot)
 	BUG_ON(PageHighMem(page));
 	address = (unsigned long)page_address(page);
 
-	if (v_mapped_by_bats(address) || v_mapped_by_tlbcam(address))
+	if (v_block_mapped(address))
 		return 0;
 	if (!get_pteptr(&init_mm, address, &kpte, &kpmd))
 		return -EINVAL;
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 6b2f3e4..2a049fb 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -49,7 +49,7 @@ struct batrange {		/* stores address ranges mapped by BATs */
 /*
  * Return PA for this VA if it is mapped by a BAT, or 0
  */
-phys_addr_t v_mapped_by_bats(unsigned long va)
+phys_addr_t v_block_mapped(unsigned long va)
 {
 	int b;
 	for (b = 0; b < 4; ++b)
@@ -61,7 +61,7 @@ phys_addr_t v_mapped_by_bats(unsigned long va)
 /*
  * Return VA for a given PA or 0 if not mapped
  */
-unsigned long p_mapped_by_bats(phys_addr_t pa)
+unsigned long p_block_mapped(phys_addr_t pa)
 {
 	int b;
 	for (b = 0; b < 4; ++b)
-- 
2.1.0
