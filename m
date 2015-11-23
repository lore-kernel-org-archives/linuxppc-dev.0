Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA65E1A03A1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:24:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:24:04 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 495D22CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:24:01 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANANaWq37028090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:23:44 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANANSYU013089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:23:29 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 10/31] powerpc/mm: Don't use pmd_val,
 pud_val and pgd_val as lvalue
Date: Mon, 23 Nov 2015 15:52:19 +0530
Message-Id: <1448274160-28446-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We convert them static inline function here as we did with pte_val in
the previous patch

Acked-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  6 ++++-
 arch/powerpc/include/asm/book3s/64/hash-4k.h |  6 ++++-
 arch/powerpc/include/asm/book3s/64/pgtable.h | 36 +++++++++++++++++++++-------
 arch/powerpc/include/asm/page.h              | 34 +++++++++++++++++++-------
 arch/powerpc/include/asm/pgalloc-32.h        | 34 +++++++++++++++++++-------
 arch/powerpc/include/asm/pgalloc-64.h        | 17 +++++++++----
 arch/powerpc/include/asm/pgtable-ppc32.h     |  7 +++++-
 arch/powerpc/include/asm/pgtable-ppc64-4k.h  |  6 ++++-
 arch/powerpc/include/asm/pgtable-ppc64.h     | 36 +++++++++++++++++++++-------
 arch/powerpc/mm/40x_mmu.c                    | 10 ++++----
 arch/powerpc/mm/pgtable_64.c                 | 19 +++++++--------
 11 files changed, 154 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 2afe5958c837..9e47515b2e01 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -105,7 +105,11 @@ extern unsigned long ioremap_bot;
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
 #define	pmd_present(pmd)	(pmd_val(pmd) & _PMD_PRESENT_MASK)
-#define	pmd_clear(pmdp)		do { pmd_val(*(pmdp)) = 0; } while (0)
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	*pmdp = __pmd(0);
+}
+
 
 /*
  * When flushing the tlb entry for a page, we also need to flush the hash
diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 15518b620f5a..537eacecf6e9 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -71,9 +71,13 @@
 #define pgd_none(pgd)		(!pgd_val(pgd))
 #define pgd_bad(pgd)		(pgd_val(pgd) == 0)
 #define pgd_present(pgd)	(pgd_val(pgd) != 0)
-#define pgd_clear(pgdp)		(pgd_val(*(pgdp)) = 0)
 #define pgd_page_vaddr(pgd)	(pgd_val(pgd) & ~PGD_MASKED_BITS)
 
+static inline void pgd_clear(pgd_t *pgdp)
+{
+	*pgdp = __pgd(0);
+}
+
 static inline pte_t pgd_pte(pgd_t pgd)
 {
 	return __pte(pgd_val(pgd));
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index e41b9d47cc32..f7e35c791369 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -238,21 +238,38 @@
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
-#define pmd_set(pmdp, pmdval)	(pmd_val(*(pmdp)) = (pmdval))
+static inline void pmd_set(pmd_t *pmdp, unsigned long val)
+{
+	*pmdp = __pmd(val);
+}
+
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	*pmdp = __pmd(0);
+}
+
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(!is_kernel_addr(pmd_val(pmd)) \
 				 || (pmd_val(pmd) & PMD_BAD_BITS))
 #define	pmd_present(pmd)	(!pmd_none(pmd))
-#define	pmd_clear(pmdp)		(pmd_val(*(pmdp)) = 0)
 #define pmd_page_vaddr(pmd)	(pmd_val(pmd) & ~PMD_MASKED_BITS)
 extern struct page *pmd_page(pmd_t pmd);
 
-#define pud_set(pudp, pudval)	(pud_val(*(pudp)) = (pudval))
+static inline void pud_set(pud_t *pudp, unsigned long val)
+{
+	*pudp = __pud(val);
+}
+
+static inline void pud_clear(pud_t *pudp)
+{
+	*pudp = __pud(0);
+}
+
 #define pud_none(pud)		(!pud_val(pud))
 #define	pud_bad(pud)		(!is_kernel_addr(pud_val(pud)) \
 				 || (pud_val(pud) & PUD_BAD_BITS))
 #define pud_present(pud)	(pud_val(pud) != 0)
-#define pud_clear(pudp)		(pud_val(*(pudp)) = 0)
 #define pud_page_vaddr(pud)	(pud_val(pud) & ~PUD_MASKED_BITS)
 
 extern struct page *pud_page(pud_t pud);
@@ -267,8 +284,11 @@ static inline pud_t pte_pud(pte_t pte)
 	return __pud(pte_val(pte));
 }
 #define pud_write(pud)		pte_write(pud_pte(pud))
-#define pgd_set(pgdp, pudp)	({pgd_val(*(pgdp)) = (unsigned long)(pudp);})
 #define pgd_write(pgd)		pte_write(pgd_pte(pgd))
+static inline void pgd_set(pgd_t *pgdp, unsigned long val)
+{
+	*pgdp = __pgd(val);
+}
 
 /*
  * Find an entry in a page-table-directory.  We combine the address region
@@ -590,14 +610,12 @@ static inline pmd_t pmd_mkhuge(pmd_t pmd)
 
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 {
-	pmd_val(pmd) &= ~_PAGE_PRESENT;
-	return pmd;
+	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
 }
 
 static inline pmd_t pmd_mksplitting(pmd_t pmd)
 {
-	pmd_val(pmd) |= _PAGE_SPLITTING;
-	return pmd;
+	return __pmd(pmd_val(pmd) | _PAGE_SPLITTING);
 }
 
 #define __HAVE_ARCH_PMD_SAME
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 0e9d1d32053f..9d2f38e1b21d 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -303,21 +303,30 @@ typedef struct { pte_t pte; } real_pte_t;
 /* PMD level */
 #ifdef CONFIG_PPC64
 typedef struct { unsigned long pmd; } pmd_t;
-#define pmd_val(x)	((x).pmd)
 #define __pmd(x)	((pmd_t) { (x) })
+static inline unsigned long pmd_val(pmd_t x)
+{
+	return x.pmd;
+}
 
 /* PUD level exusts only on 4k pages */
 #ifndef CONFIG_PPC_64K_PAGES
 typedef struct { unsigned long pud; } pud_t;
-#define pud_val(x)	((x).pud)
 #define __pud(x)	((pud_t) { (x) })
+static inline unsigned long pud_val(pud_t x)
+{
+	return x.pud;
+}
 #endif /* !CONFIG_PPC_64K_PAGES */
 #endif /* CONFIG_PPC64 */
 
 /* PGD level */
 typedef struct { unsigned long pgd; } pgd_t;
-#define pgd_val(x)	((x).pgd)
 #define __pgd(x)	((pgd_t) { (x) })
+static inline unsigned long pgd_val(pgd_t x)
+{
+	return x.pgd;
+}
 
 /* Page protection bits */
 typedef struct { unsigned long pgprot; } pgprot_t;
@@ -346,22 +355,31 @@ typedef pte_t real_pte_t;
 
 #ifdef CONFIG_PPC64
 typedef unsigned long pmd_t;
-#define pmd_val(x)	(x)
 #define __pmd(x)	(x)
+static inline unsigned long pmd_val(pmd_t pmd)
+{
+	return pmd;
+}
 
 #ifndef CONFIG_PPC_64K_PAGES
 typedef unsigned long pud_t;
-#define pud_val(x)	(x)
 #define __pud(x)	(x)
+static inline unsigned long pud_val(pud_t pud)
+{
+	return pud;
+}
 #endif /* !CONFIG_PPC_64K_PAGES */
 #endif /* CONFIG_PPC64 */
 
 typedef unsigned long pgd_t;
-#define pgd_val(x)	(x)
-#define pgprot_val(x)	(x)
+#define __pgd(x)	(x)
+static inline unsigned long pgd_val(pgd_t pgd)
+{
+	return pgd;
+}
 
 typedef unsigned long pgprot_t;
-#define __pgd(x)	(x)
+#define pgprot_val(x)	(x)
 #define __pgprot(x)	(x)
 
 #endif
diff --git a/arch/powerpc/include/asm/pgalloc-32.h b/arch/powerpc/include/asm/pgalloc-32.h
index 842846c1b711..76d6b9e0c8a9 100644
--- a/arch/powerpc/include/asm/pgalloc-32.h
+++ b/arch/powerpc/include/asm/pgalloc-32.h
@@ -21,16 +21,34 @@ extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 /* #define pgd_populate(mm, pmd, pte)      BUG() */
 
 #ifndef CONFIG_BOOKE
-#define pmd_populate_kernel(mm, pmd, pte)	\
-		(pmd_val(*(pmd)) = __pa(pte) | _PMD_PRESENT)
-#define pmd_populate(mm, pmd, pte)	\
-		(pmd_val(*(pmd)) = (page_to_pfn(pte) << PAGE_SHIFT) | _PMD_PRESENT)
+
+static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
+				       pte_t *pte)
+{
+	*pmdp = __pmd(__pa(pte) | _PMD_PRESENT);
+}
+
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
+				pgtable_t pte_page)
+{
+	*pmdp = __pmd((page_to_pfn(pte_page) << PAGE_SHIFT) | _PMD_PRESENT);
+}
+
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #else
-#define pmd_populate_kernel(mm, pmd, pte)	\
-		(pmd_val(*(pmd)) = (unsigned long)pte | _PMD_PRESENT)
-#define pmd_populate(mm, pmd, pte)	\
-		(pmd_val(*(pmd)) = (unsigned long)lowmem_page_address(pte) | _PMD_PRESENT)
+
+static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
+				       pte_t *pte)
+{
+	*pmdp = __pmd((unsigned long)pte | _PMD_PRESENT);
+}
+
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
+				pgtable_t pte_page)
+{
+	*pmdp = __pmd((unsigned long)lowmem_page_address(pte_page) | _PMD_PRESENT);
+}
+
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #endif
 
diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index 4b0be20fcbfd..d8cde71f6734 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -53,7 +53,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 #ifndef CONFIG_PPC_64K_PAGES
 
-#define pgd_populate(MM, PGD, PUD)	pgd_set(PGD, PUD)
+#define pgd_populate(MM, PGD, PUD)	pgd_set(PGD, (unsigned long)PUD)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
@@ -71,9 +71,18 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 	pud_set(pud, (unsigned long)pmd);
 }
 
-#define pmd_populate(mm, pmd, pte_page) \
-	pmd_populate_kernel(mm, pmd, page_address(pte_page))
-#define pmd_populate_kernel(mm, pmd, pte) pmd_set(pmd, (unsigned long)(pte))
+static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
+				       pte_t *pte)
+{
+	pmd_set(pmd, (unsigned long)pte);
+}
+
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
+				pgtable_t pte_page)
+{
+	pmd_set(pmd, (unsigned long)page_address(pte_page));
+}
+
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index aac6547b0823..fbb23c54b998 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -128,7 +128,12 @@ extern int icache_44x_need_flush;
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
 #define	pmd_present(pmd)	(pmd_val(pmd) & _PMD_PRESENT_MASK)
-#define	pmd_clear(pmdp)		do { pmd_val(*(pmdp)) = 0; } while (0)
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	*pmdp = __pmd(0);
+}
+
+
 
 /*
  * When flushing the tlb entry for a page, we also need to flush the hash
diff --git a/arch/powerpc/include/asm/pgtable-ppc64-4k.h b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
index 132ee1d482c2..7bace25d6b62 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-4k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
@@ -55,11 +55,15 @@
 #define pgd_none(pgd)		(!pgd_val(pgd))
 #define pgd_bad(pgd)		(pgd_val(pgd) == 0)
 #define pgd_present(pgd)	(pgd_val(pgd) != 0)
-#define pgd_clear(pgdp)		(pgd_val(*(pgdp)) = 0)
 #define pgd_page_vaddr(pgd)	(pgd_val(pgd) & ~PGD_MASKED_BITS)
 
 #ifndef __ASSEMBLY__
 
+static inline void pgd_clear(pgd_t *pgdp)
+{
+	*pgdp = __pgd(0);
+}
+
 static inline pte_t pgd_pte(pgd_t pgd)
 {
 	return __pte(pgd_val(pgd));
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 1ef0fea32e1e..6be203d43fd1 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -144,21 +144,37 @@
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
-#define pmd_set(pmdp, pmdval) 	(pmd_val(*(pmdp)) = (pmdval))
+static inline void pmd_set(pmd_t *pmdp, unsigned long val)
+{
+	*pmdp = __pmd(val);
+}
+
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	*pmdp = __pmd(0);
+}
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(!is_kernel_addr(pmd_val(pmd)) \
 				 || (pmd_val(pmd) & PMD_BAD_BITS))
 #define	pmd_present(pmd)	(!pmd_none(pmd))
-#define	pmd_clear(pmdp)		(pmd_val(*(pmdp)) = 0)
 #define pmd_page_vaddr(pmd)	(pmd_val(pmd) & ~PMD_MASKED_BITS)
 extern struct page *pmd_page(pmd_t pmd);
 
-#define pud_set(pudp, pudval)	(pud_val(*(pudp)) = (pudval))
+static inline void pud_set(pud_t *pudp, unsigned long val)
+{
+	*pudp = __pud(val);
+}
+
+static inline void pud_clear(pud_t *pudp)
+{
+	*pudp = __pud(0);
+}
+
 #define pud_none(pud)		(!pud_val(pud))
 #define	pud_bad(pud)		(!is_kernel_addr(pud_val(pud)) \
 				 || (pud_val(pud) & PUD_BAD_BITS))
 #define pud_present(pud)	(pud_val(pud) != 0)
-#define pud_clear(pudp)		(pud_val(*(pudp)) = 0)
 #define pud_page_vaddr(pud)	(pud_val(pud) & ~PUD_MASKED_BITS)
 
 extern struct page *pud_page(pud_t pud);
@@ -173,9 +189,13 @@ static inline pud_t pte_pud(pte_t pte)
 	return __pud(pte_val(pte));
 }
 #define pud_write(pud)		pte_write(pud_pte(pud))
-#define pgd_set(pgdp, pudp)	({pgd_val(*(pgdp)) = (unsigned long)(pudp);})
 #define pgd_write(pgd)		pte_write(pgd_pte(pgd))
 
+static inline void pgd_set(pgd_t *pgdp, unsigned long val)
+{
+	*pgdp = __pgd(val);
+}
+
 /*
  * Find an entry in a page-table-directory.  We combine the address region
  * (the high order N bits) and the pgd portion of the address.
@@ -528,14 +548,12 @@ static inline pmd_t pmd_mkhuge(pmd_t pmd)
 
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 {
-	pmd_val(pmd) &= ~_PAGE_PRESENT;
-	return pmd;
+	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
 }
 
 static inline pmd_t pmd_mksplitting(pmd_t pmd)
 {
-	pmd_val(pmd) |= _PAGE_SPLITTING;
-	return pmd;
+	return __pmd(pmd_val(pmd) | _PAGE_SPLITTING);
 }
 
 #define __HAVE_ARCH_PMD_SAME
diff --git a/arch/powerpc/mm/40x_mmu.c b/arch/powerpc/mm/40x_mmu.c
index 5810967511d4..31a5d42df8c9 100644
--- a/arch/powerpc/mm/40x_mmu.c
+++ b/arch/powerpc/mm/40x_mmu.c
@@ -110,10 +110,10 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 		unsigned long val = p | _PMD_SIZE_16M | _PAGE_EXEC | _PAGE_HWWRITE;
 
 		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
-		pmd_val(*pmdp++) = val;
-		pmd_val(*pmdp++) = val;
-		pmd_val(*pmdp++) = val;
-		pmd_val(*pmdp++) = val;
+		*pmdp++ = __pmd(val);
+		*pmdp++ = __pmd(val);
+		*pmdp++ = __pmd(val);
+		*pmdp++ = __pmd(val);
 
 		v += LARGE_PAGE_SIZE_16M;
 		p += LARGE_PAGE_SIZE_16M;
@@ -125,7 +125,7 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 		unsigned long val = p | _PMD_SIZE_4M | _PAGE_EXEC | _PAGE_HWWRITE;
 
 		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
-		pmd_val(*pmdp) = val;
+		*pmdp = __pmd(val);
 
 		v += LARGE_PAGE_SIZE_4M;
 		p += LARGE_PAGE_SIZE_4M;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index e92cb2146b18..d692ae31cfc7 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -759,22 +759,20 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 
 static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot)
 {
-	pmd_val(pmd) |= pgprot_val(pgprot);
-	return pmd;
+	return __pmd(pmd_val(pmd) | pgprot_val(pgprot));
 }
 
 pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
 {
-	pmd_t pmd;
+	unsigned long pmdv;
 	/*
 	 * For a valid pte, we would have _PAGE_PRESENT always
 	 * set. We use this to check THP page at pmd level.
 	 * leaf pte for huge page, bottom two bits != 00
 	 */
-	pmd_val(pmd) = pfn << PTE_RPN_SHIFT;
-	pmd_val(pmd) |= _PAGE_THP_HUGE;
-	pmd = pmd_set_protbits(pmd, pgprot);
-	return pmd;
+	pmdv = pfn << PTE_RPN_SHIFT;
+	pmdv |= _PAGE_THP_HUGE;
+	return pmd_set_protbits(__pmd(pmdv), pgprot);
 }
 
 pmd_t mk_pmd(struct page *page, pgprot_t pgprot)
@@ -784,10 +782,11 @@ pmd_t mk_pmd(struct page *page, pgprot_t pgprot)
 
 pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
+	unsigned long pmdv;
 
-	pmd_val(pmd) &= _HPAGE_CHG_MASK;
-	pmd = pmd_set_protbits(pmd, newprot);
-	return pmd;
+	pmdv = pmd_val(pmd);
+	pmdv &= _HPAGE_CHG_MASK;
+	return pmd_set_protbits(__pmd(pmdv), newprot);
 }
 
 /*
-- 
2.5.0
