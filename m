Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrNQ3nZtzDqy2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:26:46 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:26:43 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 05/10] powerpc/mm: use _raw variant of page table accessors
Date: Wed,  8 Jun 2016 19:55:53 +0530
Message-Id: <1465395958-21349-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This switch few of the page table accessor to use the __raw variant
and does the cpu to big endian conversion of constants. This helps in
generating better code.

For ex: a pgd_none(pgd) check with and without fix is listed below

Without fix:
------------
   2240:	20 00 61 eb 	ld      r27,32(r1)
/* PGD level */
typedef struct { __be64 pgd; } pgd_t;
static inline unsigned long pgd_val(pgd_t x)
{
	return be64_to_cpu(x.pgd);

    2244:	22 00 66 78 	rldicl  r6,r3,32,32
    2248:	3e 40 7d 54 	rotlwi  r29,r3,8
    224c:	0e c0 7d 50 	rlwimi  r29,r3,24,0,7
    2250:	3e 40 c5 54 	rotlwi  r5,r6,8
    2254:	2e c4 7d 50 	rlwimi  r29,r3,24,16,23
    2258:	0e c0 c5 50 	rlwimi  r5,r6,24,0,7
    225c:	2e c4 c5 50 	rlwimi  r5,r6,24,16,23
    2260:	c6 07 bd 7b 	rldicr  r29,r29,32,31
    2264:	78 2b bd 7f 	or      r29,r29,r5
		if (pgd_none(pgd))
    2268:	00 00 bd 2f 	cmpdi   cr7,r29,0
    226c:	54 03 9e 41 	beq     cr7,25c0 <__get_user_pages_fast+0x500>

With fix:
---------
    2370:	20 00 61 eb 	ld      r27,32(r1)
		if (pgd_none(pgd))
    2374:	00 00 bd 2f 	cmpdi   cr7,r29,0
    2378:	a8 03 9e 41 	beq     cr7,2720 <__get_user_pages_fast+0x530>
			break;
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h  |  6 +-
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h |  6 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h     | 99 +++++++++++++++++-------
 arch/powerpc/include/asm/pgtable-be-types.h      | 15 ++++
 4 files changed, 91 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
index 71e9abced493..9db83b4e017d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
@@ -11,7 +11,7 @@ static inline int pmd_huge(pmd_t pmd)
 	 * leaf pte for huge page
 	 */
 	if (radix_enabled())
-		return !!(pmd_val(pmd) & _PAGE_PTE);
+		return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
 	return 0;
 }
 
@@ -21,7 +21,7 @@ static inline int pud_huge(pud_t pud)
 	 * leaf pte for huge page
 	 */
 	if (radix_enabled())
-		return !!(pud_val(pud) & _PAGE_PTE);
+		return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
 	return 0;
 }
 
@@ -31,7 +31,7 @@ static inline int pgd_huge(pgd_t pgd)
 	 * leaf pte for huge page
 	 */
 	if (radix_enabled())
-		return !!(pgd_val(pgd) & _PAGE_PTE);
+		return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
 	return 0;
 }
 #define pgd_huge pgd_huge
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index cb2d0a5fa3f8..0d2845b44763 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -15,7 +15,7 @@ static inline int pmd_huge(pmd_t pmd)
 	/*
 	 * leaf pte for huge page
 	 */
-	return !!(pmd_val(pmd) & _PAGE_PTE);
+	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
 }
 
 static inline int pud_huge(pud_t pud)
@@ -23,7 +23,7 @@ static inline int pud_huge(pud_t pud)
 	/*
 	 * leaf pte for huge page
 	 */
-	return !!(pud_val(pud) & _PAGE_PTE);
+	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
 }
 
 static inline int pgd_huge(pgd_t pgd)
@@ -31,7 +31,7 @@ static inline int pgd_huge(pgd_t pgd)
 	/*
 	 * leaf pte for huge page
 	 */
-	return !!(pgd_val(pgd) & _PAGE_PTE);
+	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PTE));
 }
 #define pgd_huge pgd_huge
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 88a5ecaa157b..d3ab97e3c744 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -317,7 +317,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if ((pte_val(*ptep) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
+	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
 		return 0;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
@@ -335,8 +335,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-
-	if ((pte_val(*ptep) & _PAGE_WRITE) == 0)
+	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_WRITE)) == 0)
 		return;
 
 	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 0);
@@ -345,7 +344,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	if ((pte_val(*ptep) & _PAGE_WRITE) == 0)
+	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_WRITE)) == 0)
 		return;
 
 	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 1);
@@ -364,17 +363,35 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 {
 	pte_update(mm, addr, ptep, ~0UL, 0, 0);
 }
-static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_WRITE);}
-static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
-static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
-static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
+
+static inline int pte_write(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_WRITE));
+}
+
+static inline int pte_dirty(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DIRTY));
+}
+
+static inline int pte_young(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_ACCESSED));
+}
+
+static inline int pte_special(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_SPECIAL));
+}
+
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline bool pte_soft_dirty(pte_t pte)
 {
-	return !!(pte_val(pte) & _PAGE_SOFT_DIRTY);
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_SOFT_DIRTY));
 }
+
 static inline pte_t pte_mksoft_dirty(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
@@ -394,14 +411,14 @@ static inline pte_t pte_clear_soft_dirty(pte_t pte)
  */
 static inline int pte_protnone(pte_t pte)
 {
-	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PRIVILEGED)) ==
-		(_PAGE_PRESENT | _PAGE_PRIVILEGED);
+	return (pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED)) ==
+		cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED);
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
 static inline int pte_present(pte_t pte)
 {
-	return !!(pte_val(pte) & _PAGE_PRESENT);
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT));
 }
 /*
  * Conversion functions: convert a page and protection to a page entry,
@@ -473,7 +490,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 static inline bool pte_user(pte_t pte)
 {
-	return !(pte_val(pte) & _PAGE_PRIVILEGED);
+	return !(pte_raw(pte) & cpu_to_be64(_PAGE_PRIVILEGED));
 }
 
 /* Encode and de-code a swap entry */
@@ -516,10 +533,12 @@ static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
 }
+
 static inline bool pte_swp_soft_dirty(pte_t pte)
 {
-	return !!(pte_val(pte) & _PAGE_SWP_SOFT_DIRTY);
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_SWP_SOFT_DIRTY));
 }
+
 static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~_PAGE_SWP_SOFT_DIRTY);
@@ -625,8 +644,16 @@ static inline void pmd_clear(pmd_t *pmdp)
 	*pmdp = __pmd(0);
 }
 
-#define pmd_none(pmd)		(!pmd_val(pmd))
-#define	pmd_present(pmd)	(!pmd_none(pmd))
+static inline int pmd_none(pmd_t pmd)
+{
+	return !pmd_raw(pmd);
+}
+
+static inline int pmd_present(pmd_t pmd)
+{
+
+	return !pmd_none(pmd);
+}
 
 static inline int pmd_bad(pmd_t pmd)
 {
@@ -645,19 +672,26 @@ static inline void pud_clear(pud_t *pudp)
 	*pudp = __pud(0);
 }
 
-#define pud_none(pud)		(!pud_val(pud))
-#define pud_present(pud)	(pud_val(pud) != 0)
+static inline int pud_none(pud_t pud)
+{
+	return !pud_raw(pud);
+}
+
+static inline int pud_present(pud_t pud)
+{
+	return !pud_none(pud);
+}
 
 extern struct page *pud_page(pud_t pud);
 extern struct page *pmd_page(pmd_t pmd);
 static inline pte_t pud_pte(pud_t pud)
 {
-	return __pte(pud_val(pud));
+	return __pte_raw(pud_raw(pud));
 }
 
 static inline pud_t pte_pud(pte_t pte)
 {
-	return __pud(pte_val(pte));
+	return __pud_raw(pte_raw(pte));
 }
 #define pud_write(pud)		pte_write(pud_pte(pud))
 
@@ -680,17 +714,24 @@ static inline void pgd_clear(pgd_t *pgdp)
 	*pgdp = __pgd(0);
 }
 
-#define pgd_none(pgd)		(!pgd_val(pgd))
-#define pgd_present(pgd)	(!pgd_none(pgd))
+static inline int pgd_none(pgd_t pgd)
+{
+	return !pgd_raw(pgd);
+}
+
+static inline int pgd_present(pgd_t pgd)
+{
+	return !pgd_none(pgd);
+}
 
 static inline pte_t pgd_pte(pgd_t pgd)
 {
-	return __pte(pgd_val(pgd));
+	return __pte_raw(pgd_raw(pgd));
 }
 
 static inline pgd_t pte_pgd(pte_t pte)
 {
-	return __pgd(pte_val(pte));
+	return __pgd_raw(pte_raw(pte));
 }
 
 static inline int pgd_bad(pgd_t pgd)
@@ -782,12 +823,12 @@ struct page *realmode_pfn_to_page(unsigned long pfn);
 
 static inline pte_t pmd_pte(pmd_t pmd)
 {
-	return __pte(pmd_val(pmd));
+	return __pte_raw(pmd_raw(pmd));
 }
 
 static inline pmd_t pte_pmd(pte_t pte)
 {
-	return __pmd(pte_val(pte));
+	return __pmd_raw(pte_raw(pte));
 }
 
 static inline pte_t *pmdp_ptep(pmd_t *pmd)
@@ -848,7 +889,7 @@ pmd_hugepage_update(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp,
 
 static inline int pmd_large(pmd_t pmd)
 {
-	return !!(pmd_val(pmd) & _PAGE_PTE);
+	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
 }
 
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
@@ -864,7 +905,7 @@ static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
+	if ((pmd_raw(*pmdp) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
 		return 0;
 	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
 	return ((old & _PAGE_ACCESSED) != 0);
@@ -875,7 +916,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pmd_t *pmdp)
 {
 
-	if ((pmd_val(*pmdp) & _PAGE_WRITE) == 0)
+	if ((pmd_raw(*pmdp) & cpu_to_be64(_PAGE_WRITE)) == 0)
 		return;
 
 	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
diff --git a/arch/powerpc/include/asm/pgtable-be-types.h b/arch/powerpc/include/asm/pgtable-be-types.h
index e2bf208605b1..49c0a5a80efa 100644
--- a/arch/powerpc/include/asm/pgtable-be-types.h
+++ b/arch/powerpc/include/asm/pgtable-be-types.h
@@ -6,6 +6,7 @@
 /* PTE level */
 typedef struct { __be64 pte; } pte_t;
 #define __pte(x)	((pte_t) { cpu_to_be64(x) })
+#define __pte_raw(x)	((pte_t) { (x) })
 static inline unsigned long pte_val(pte_t x)
 {
 	return be64_to_cpu(x.pte);
@@ -20,6 +21,7 @@ static inline __be64 pte_raw(pte_t x)
 #ifdef CONFIG_PPC64
 typedef struct { __be64 pmd; } pmd_t;
 #define __pmd(x)	((pmd_t) { cpu_to_be64(x) })
+#define __pmd_raw(x)	((pmd_t) { (x) })
 static inline unsigned long pmd_val(pmd_t x)
 {
 	return be64_to_cpu(x.pmd);
@@ -37,21 +39,34 @@ static inline __be64 pmd_raw(pmd_t x)
 #if defined(CONFIG_PPC_BOOK3S_64) || !defined(CONFIG_PPC_64K_PAGES)
 typedef struct { __be64 pud; } pud_t;
 #define __pud(x)	((pud_t) { cpu_to_be64(x) })
+#define __pud_raw(x)	((pud_t) { (x) })
 static inline unsigned long pud_val(pud_t x)
 {
 	return be64_to_cpu(x.pud);
 }
+
+static inline __be64 pud_raw(pud_t x)
+{
+	return x.pud;
+}
+
 #endif /* CONFIG_PPC_BOOK3S_64 || !CONFIG_PPC_64K_PAGES */
 #endif /* CONFIG_PPC64 */
 
 /* PGD level */
 typedef struct { __be64 pgd; } pgd_t;
 #define __pgd(x)	((pgd_t) { cpu_to_be64(x) })
+#define __pgd_raw(x)	((pgd_t) { (x) })
 static inline unsigned long pgd_val(pgd_t x)
 {
 	return be64_to_cpu(x.pgd);
 }
 
+static inline __be64 pgd_raw(pgd_t x)
+{
+	return x.pgd;
+}
+
 /* Page protection bits */
 typedef struct { unsigned long pgprot; } pgprot_t;
 #define pgprot_val(x)	((x).pgprot)
-- 
2.7.4
