Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wc11s74N7zDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 01:32:00 +1000 (AEST)
Message-Id: <83aadb3163da87ec017ca4a61afcc29520a27eff.1496070452.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1496070452.git.christophe.leroy@c-s.fr>
References: <cover.1496070452.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/7] powerpc/mm: rename map_page() to map_kernel_page() on
 PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 29 May 2017 17:31:56 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 2 ++
 arch/powerpc/include/asm/nohash/32/pgtable.h | 2 ++
 arch/powerpc/mm/8xx_mmu.c                    | 2 +-
 arch/powerpc/mm/dma-noncoherent.c            | 2 +-
 arch/powerpc/mm/mem.c                        | 4 ++--
 arch/powerpc/mm/mmu_decl.h                   | 1 -
 arch/powerpc/mm/pgtable_32.c                 | 8 ++++----
 7 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 26ed228d4dc6..7fb755880409 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -297,6 +297,8 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
 extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep,
 		      pmd_t **pmdp);
 
+int map_kernel_page(unsigned long va, phys_addr_t pa, int flags);
+
 /* Generic accessors to PTE bits */
 static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
 static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 5134ade2e850..91314268f04f 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -340,6 +340,8 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
 extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep,
 		      pmd_t **pmdp);
 
+int map_kernel_page(unsigned long va, phys_addr_t pa, int flags);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_POWERPC_NOHASH_32_PGTABLE_H */
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 6c5025e81236..f4c6472f2fc4 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -88,7 +88,7 @@ static void mmu_mapin_immr(void)
 	int offset;
 
 	for (offset = 0; offset < IMMR_SIZE; offset += PAGE_SIZE)
-		map_page(v + offset, p + offset, f);
+		map_kernel_page(v + offset, p + offset, f);
 }
 
 /* Address of instructions to patch */
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 2dc74e5c6458..382528475433 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -227,7 +227,7 @@ __dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t
 
 		do {
 			SetPageReserved(page);
-			map_page(vaddr, page_to_phys(page),
+			map_kernel_page(vaddr, page_to_phys(page),
 				 pgprot_val(pgprot_noncached(PAGE_KERNEL)));
 			page++;
 			vaddr += PAGE_SIZE;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index de5a90e1ceaa..8e9bef964dbf 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -305,11 +305,11 @@ void __init paging_init(void)
 	unsigned long end = __fix_to_virt(FIX_HOLE);
 
 	for (; v < end; v += PAGE_SIZE)
-		map_page(v, 0, 0); /* XXX gross */
+		map_kernel_page(v, 0, 0); /* XXX gross */
 #endif
 
 #ifdef CONFIG_HIGHMEM
-	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
+	map_kernel_page(PKMAP_BASE, 0, 0);	/* XXX gross */
 	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
 
 	kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index f988db655e5b..d46128b22150 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -94,7 +94,6 @@ extern void _tlbia(void);
 #ifdef CONFIG_PPC32
 
 extern void mapin_ram(void);
-extern int map_page(unsigned long va, phys_addr_t pa, int flags);
 extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, pgprot_t prot);
 
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index a65c0b4c0669..9c23c0965566 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -189,7 +189,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 
 	err = 0;
 	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
-		err = map_page(v+i, p+i, flags);
+		err = map_kernel_page(v+i, p+i, flags);
 	if (err) {
 		if (slab_is_available())
 			vunmap((void *)v);
@@ -215,7 +215,7 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
-int map_page(unsigned long va, phys_addr_t pa, int flags)
+int map_kernel_page(unsigned long va, phys_addr_t pa, int flags)
 {
 	pmd_t *pd;
 	pte_t *pg;
@@ -255,7 +255,7 @@ void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 		ktext = ((char *)v >= _stext && (char *)v < etext) ||
 			((char *)v >= _sinittext && (char *)v < _einittext);
 		f = ktext ? pgprot_val(PAGE_KERNEL_TEXT) : pgprot_val(PAGE_KERNEL);
-		map_page(v, p, f);
+		map_kernel_page(v, p, f);
 #ifdef CONFIG_PPC_STD_MMU_32
 		if (ktext)
 			hash_preload(&init_mm, v, 0, 0x300);
@@ -387,7 +387,7 @@ void __set_fixmap (enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
 		return;
 	}
 
-	map_page(address, phys, pgprot_val(flags));
+	map_kernel_page(address, phys, pgprot_val(flags));
 	fixmaps++;
 }
 
-- 
2.12.0
