Return-Path: <paulus@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BE171A0810
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 17:13:14 +1100 (AEDT)
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [RFC PATCH 3/9] powerpc/mm/64: Use physical addresses in upper page
 table tree levels
Date: Sat, 20 Feb 2016 17:12:34 +1100
Message-Id: <1455948760-24710-4-git-send-email-paulus@samba.org>
In-Reply-To: <1455948760-24710-1-git-send-email-paulus@samba.org>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This changes the Linux page tables to store physical addresses
rather than kernel virtual addresses in the upper levels of the
tree (pgd, pud and pmd) for all 64-bit machines.

This frees up some high order bits, and will be needed with book3s
PowerISA v3.0 machines which read the page table tree in hardware
in radix mode.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h    |  2 +-
 arch/powerpc/include/asm/book3s/64/hash.h       | 10 ++++------
 arch/powerpc/include/asm/nohash/64/pgtable-4k.h |  2 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h    | 10 ++++------
 arch/powerpc/include/asm/pgalloc-64.h           | 16 ++++++++--------
 5 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index bee3643..0425d3e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -64,7 +64,7 @@
 #define pgd_none(pgd)		(!pgd_val(pgd))
 #define pgd_bad(pgd)		(pgd_val(pgd) == 0)
 #define pgd_present(pgd)	(pgd_val(pgd) != 0)
-#define pgd_page_vaddr(pgd)	(pgd_val(pgd) & ~PGD_MASKED_BITS)
+#define pgd_page_vaddr(pgd)	__va(pgd_val(pgd) & ~PGD_MASKED_BITS)
 
 static inline void pgd_clear(pgd_t *pgdp)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 64eff40..fcab33f 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -222,13 +222,11 @@
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
 #ifndef __ASSEMBLY__
-#define	pmd_bad(pmd)		(!is_kernel_addr(pmd_val(pmd)) \
-				 || (pmd_val(pmd) & PMD_BAD_BITS))
-#define pmd_page_vaddr(pmd)	(pmd_val(pmd) & ~PMD_MASKED_BITS)
+#define	pmd_bad(pmd)		(pmd_val(pmd) & PMD_BAD_BITS)
+#define pmd_page_vaddr(pmd)	__va(pmd_val(pmd) & ~PMD_MASKED_BITS)
 
-#define	pud_bad(pud)		(!is_kernel_addr(pud_val(pud)) \
-				 || (pud_val(pud) & PUD_BAD_BITS))
-#define pud_page_vaddr(pud)	(pud_val(pud) & ~PUD_MASKED_BITS)
+#define	pud_bad(pud)		(pud_val(pud) & PUD_BAD_BITS)
+#define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
 
 #define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
 #define pmd_index(address) (((address) >> (PMD_SHIFT)) & (PTRS_PER_PMD - 1))
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
index fc7d517..c8319e8 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
@@ -55,7 +55,7 @@
 #define pgd_none(pgd)		(!pgd_val(pgd))
 #define pgd_bad(pgd)		(pgd_val(pgd) == 0)
 #define pgd_present(pgd)	(pgd_val(pgd) != 0)
-#define pgd_page_vaddr(pgd)	(pgd_val(pgd) & ~PGD_MASKED_BITS)
+#define pgd_page_vaddr(pgd)	__va(pgd_val(pgd) & ~PGD_MASKED_BITS)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index b9f734d..484c0e1 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -127,10 +127,9 @@ static inline pte_t pmd_pte(pmd_t pmd)
 }
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
-#define	pmd_bad(pmd)		(!is_kernel_addr(pmd_val(pmd)) \
-				 || (pmd_val(pmd) & PMD_BAD_BITS))
+#define	pmd_bad(pmd)		(pmd_val(pmd) & PMD_BAD_BITS)
 #define	pmd_present(pmd)	(!pmd_none(pmd))
-#define pmd_page_vaddr(pmd)	(pmd_val(pmd) & ~PMD_MASKED_BITS)
+#define pmd_page_vaddr(pmd)	__va(pmd_val(pmd) & ~PMD_MASKED_BITS)
 extern struct page *pmd_page(pmd_t pmd);
 
 static inline void pud_set(pud_t *pudp, unsigned long val)
@@ -144,10 +143,9 @@ static inline void pud_clear(pud_t *pudp)
 }
 
 #define pud_none(pud)		(!pud_val(pud))
-#define	pud_bad(pud)		(!is_kernel_addr(pud_val(pud)) \
-				 || (pud_val(pud) & PUD_BAD_BITS))
+#define	pud_bad(pud)		(pud_val(pud) & PUD_BAD_BITS)
 #define pud_present(pud)	(pud_val(pud) != 0)
-#define pud_page_vaddr(pud)	(pud_val(pud) & ~PUD_MASKED_BITS)
+#define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
 
 extern struct page *pud_page(pud_t pud);
 
diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index 69ef28a..4f4609d 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -53,7 +53,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 #ifndef CONFIG_PPC_64K_PAGES
 
-#define pgd_populate(MM, PGD, PUD)	pgd_set(PGD, (unsigned long)PUD)
+#define pgd_populate(MM, PGD, PUD)	pgd_set(PGD, __pa(PUD))
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
@@ -68,19 +68,19 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
-	pud_set(pud, (unsigned long)pmd);
+	pud_set(pud, __pa(pmd));
 }
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 				       pte_t *pte)
 {
-	pmd_set(pmd, (unsigned long)pte);
+	pmd_set(pmd, __pa(pte));
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 				pgtable_t pte_page)
 {
-	pmd_set(pmd, (unsigned long)page_address(pte_page));
+	pmd_set(pmd, __pa(page_address(pte_page)));
 }
 
 #define pmd_pgtable(pmd) pmd_page(pmd)
@@ -171,23 +171,23 @@ extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
 extern void __tlb_remove_table(void *_table);
 #endif
 
-#define pud_populate(mm, pud, pmd)	pud_set(pud, (unsigned long)pmd)
+#define pud_populate(mm, pud, pmd)	pud_set(pud, __pa(pmd))
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 				       pte_t *pte)
 {
-	pmd_set(pmd, (unsigned long)pte);
+	pmd_set(pmd, __pa(pte));
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 				pgtable_t pte_page)
 {
-	pmd_set(pmd, (unsigned long)pte_page);
+	pmd_set(pmd, __pa(pte_page));
 }
 
 static inline pgtable_t pmd_pgtable(pmd_t pmd)
 {
-	return (pgtable_t)(pmd_val(pmd) & ~PMD_MASKED_BITS);
+	return (pgtable_t)__va(pmd_val(pmd) & ~PMD_MASKED_BITS);
 }
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
-- 
2.5.0
