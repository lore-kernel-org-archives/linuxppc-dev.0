Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 8AAC61A0185
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 02:03:49 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH 03/11] powerpc32: Use kmem_cache memory for PGDIR
Message-Id: <20141216150338.6C0591A5E08@localhost.localdomain>
Date: Tue, 16 Dec 2014 16:03:38 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When pages are not 4K, PGDIR table is allocated with kmalloc(). In order to
optimise TLB handlers, aligned memory is needed. kmalloc() doesn't provide
aligned memory blocks, so lets use a kmem_cache pool instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/include/asm/pgtable-ppc32.h |  4 ++++
 arch/powerpc/mm/pgtable_32.c             | 16 ++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 543bb8e..d323e8b 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -346,10 +346,14 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 #define pte_to_pgoff(pte)	(pte_val(pte) >> 3)
 #define pgoff_to_pte(off)	((pte_t) { ((off) << 3) | _PAGE_FILE })
 
+#ifndef CONFIG_PPC_4K_PAGES
+void pgtable_cache_init(void);
+#else
 /*
  * No page table caches to initialise
  */
 #define pgtable_cache_init()	do { } while (0)
+#endif
 
 extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep,
 		      pmd_t **pmdp);
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index cf11342..730dc2d 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -73,13 +73,25 @@ extern unsigned long p_mapped_by_tlbcam(phys_addr_t pa);
 
 #define PGDIR_ORDER	(32 + PGD_T_LOG2 - PGDIR_SHIFT)
 
+#ifndef CONFIG_PPC_4K_PAGES
+static struct kmem_cache *pgtable_cache;
+
+void pgtable_cache_init(void)
+{
+	pgtable_cache = kmem_cache_create("PGDIR cache", 1 << PGDIR_ORDER,
+					  1 << PGDIR_ORDER, 0, NULL);
+	if (pgtable_cache == NULL)
+		panic("Couldn't allocate pgtable caches");
+}
+#endif
+
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *ret;
 
 	/* pgdir take page or two with 4K pages and a page fraction otherwise */
 #ifndef CONFIG_PPC_4K_PAGES
-	ret = kzalloc(1 << PGDIR_ORDER, GFP_KERNEL);
+	ret = kmem_cache_alloc(pgtable_cache, GFP_KERNEL | __GFP_ZERO);
 #else
 	ret = (pgd_t *)__get_free_pages(GFP_KERNEL|__GFP_ZERO,
 			PGDIR_ORDER - PAGE_SHIFT);
@@ -90,7 +102,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
 #ifndef CONFIG_PPC_4K_PAGES
-	kfree((void *)pgd);
+	kmem_cache_free(pgtable_cache, (void *)pgd);
 #else
 	free_pages((unsigned long)pgd, PGDIR_ORDER - PAGE_SHIFT);
 #endif
-- 
2.1.0
