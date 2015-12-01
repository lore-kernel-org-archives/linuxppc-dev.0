Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75EEC1A1AB2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:37:22 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 09:07:20 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CA2F3E004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 09:07:58 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB13bHWc12386692
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:17 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB13bGji022465
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:16 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 29/35] powerpc/mm: Add a _PAGE_PTE bit
Date: Tue,  1 Dec 2015 09:06:54 +0530
Message-Id: <1448941020-15168-30-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For a pte entry we will have _PAGE_PTE set. Our pte page
address have a minimum alignment requirement of HUGEPD_SHIFT_MASK + 1.
We use the lower 7 bits to indicate hugepd. ie.

For pmd and pgd we can find:
1) _PAGE_PTE set pte -> indicate PTE
2) bits [2..6] non zero -> indicate hugepd.
   They also encode the size. We skip bit 1 (_PAGE_PRESENT).
3) othewise pointer to next table.

Acked-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  9 ++++++---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 23 +++++++++--------------
 arch/powerpc/include/asm/book3s/64/hash.h     | 13 +++++++------
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  3 +--
 arch/powerpc/include/asm/pte-common.h         |  5 +++++
 arch/powerpc/mm/hugetlbpage.c                 |  4 ++--
 arch/powerpc/mm/pgtable.c                     |  4 ++++
 arch/powerpc/mm/pgtable_64.c                  |  7 +------
 8 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index b4d25529d179..e59832c94609 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -116,10 +116,13 @@ static inline int pgd_huge(pgd_t pgd)
 static inline int hugepd_ok(hugepd_t hpd)
 {
 	/*
-	 * hugepd pointer, bottom two bits == 00 and next 4 bits
-	 * indicate size of table
+	 * if it is not a pte and have hugepd shift mask
+	 * set, then it is a hugepd directory pointer
 	 */
-	return (((hpd.pd & 0x3) == 0x0) && ((hpd.pd & HUGEPD_SHIFT_MASK) != 0));
+	if (!(hpd.pd & _PAGE_PTE) &&
+	    ((hpd.pd & HUGEPD_SHIFT_MASK) != 0))
+		return true;
+	return false;
 }
 #define is_hugepd(hpd)		(hugepd_ok(hpd))
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 7570677c11c3..52110d7af659 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -130,25 +130,25 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
 static inline int pmd_huge(pmd_t pmd)
 {
 	/*
-	 * leaf pte for huge page, bottom two bits != 00
+	 * leaf pte for huge page
 	 */
-	return ((pmd_val(pmd) & 0x3) != 0x0);
+	return !!(pmd_val(pmd) & _PAGE_PTE);
 }
 
 static inline int pud_huge(pud_t pud)
 {
 	/*
-	 * leaf pte for huge page, bottom two bits != 00
+	 * leaf pte for huge page
 	 */
-	return ((pud_val(pud) & 0x3) != 0x0);
+	return !!(pud_val(pud) & _PAGE_PTE);
 }
 
 static inline int pgd_huge(pgd_t pgd)
 {
 	/*
-	 * leaf pte for huge page, bottom two bits != 00
+	 * leaf pte for huge page
 	 */
-	return ((pgd_val(pgd) & 0x3) != 0x0);
+	return !!(pgd_val(pgd) & _PAGE_PTE);
 }
 #define pgd_huge pgd_huge
 
@@ -236,10 +236,8 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
  */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
-	/*
-	 * leaf pte for huge page, bottom two bits != 00
-	 */
-	return (pmd_val(pmd) & 0x3) && (pmd_val(pmd) & _PAGE_THP_HUGE);
+	return !!((pmd_val(pmd) & (_PAGE_PTE | _PAGE_THP_HUGE)) ==
+		  (_PAGE_PTE | _PAGE_THP_HUGE));
 }
 
 static inline int pmd_trans_splitting(pmd_t pmd)
@@ -251,10 +249,7 @@ static inline int pmd_trans_splitting(pmd_t pmd)
 
 static inline int pmd_large(pmd_t pmd)
 {
-	/*
-	 * leaf pte for huge page, bottom two bits != 00
-	 */
-	return ((pmd_val(pmd) & 0x3) != 0x0);
+	return !!(pmd_val(pmd) & _PAGE_PTE);
 }
 
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 42e1273adad1..8b929e531758 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -14,11 +14,12 @@
  * We could create separate kernel read-only if we used the 3 PP bits
  * combinations that newer processors provide but we currently don't.
  */
-#define _PAGE_PRESENT		0x00001 /* software: pte contains a translation */
-#define _PAGE_USER		0x00002 /* matches one of the PP bits */
+#define _PAGE_PTE		0x00001
+#define _PAGE_PRESENT		0x00002 /* software: pte contains a translation */
 #define _PAGE_BIT_SWAP_TYPE	2
-#define _PAGE_EXEC		0x00004 /* No execute on POWER4 and newer (we invert) */
-#define _PAGE_GUARDED		0x00008
+#define _PAGE_USER		0x00004 /* matches one of the PP bits */
+#define _PAGE_EXEC		0x00008 /* No execute on POWER4 and newer (we invert) */
+#define _PAGE_GUARDED		0x00010
 /* We can derive Memory coherence from _PAGE_NO_CACHE */
 #define _PAGE_COHERENT		0x0
 #define _PAGE_NO_CACHE		0x00020 /* I: cache inhibit */
@@ -49,7 +50,7 @@
  */
 #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
 			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
-			 _PAGE_THP_HUGE)
+			 _PAGE_THP_HUGE | _PAGE_PTE)
 
 #ifdef CONFIG_PPC_64K_PAGES
 #include <asm/book3s/64/hash-64k.h>
@@ -135,7 +136,7 @@
  * pgprot changes
  */
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
-			 _PAGE_ACCESSED | _PAGE_SPECIAL)
+			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE)
 /*
  * Mask of bits returned by pte_pgprot()
  */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index f2ace2cac7bb..bb97b6a52b84 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -213,8 +213,7 @@ static inline int pmd_protnone(pmd_t pmd)
 
 static inline pmd_t pmd_mkhuge(pmd_t pmd)
 {
-	/* Do nothing, mk_pmd() does this part.  */
-	return pmd;
+	return __pmd(pmd_val(pmd) | (_PAGE_PTE | _PAGE_THP_HUGE));
 }
 
 #define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 71537a319fc8..1ec67b043065 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -40,6 +40,11 @@
 #else
 #define _PAGE_RW 0
 #endif
+
+#ifndef _PAGE_PTE
+#define _PAGE_PTE 0
+#endif
+
 #ifndef _PMD_PRESENT_MASK
 #define _PMD_PRESENT_MASK	_PMD_PRESENT
 #endif
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index bc72e542a83e..61b8b7ccea4f 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -894,8 +894,8 @@ void flush_dcache_icache_hugepage(struct page *page)
  * We have 4 cases for pgds and pmds:
  * (1) invalid (all zeroes)
  * (2) pointer to next table, as normal; bottom 6 bits == 0
- * (3) leaf pte for huge page, bottom two bits != 00
- * (4) hugepd pointer, bottom two bits == 00, next 4 bits indicate size of table
+ * (3) leaf pte for huge page _PAGE_PTE set
+ * (4) hugepd pointer, _PAGE_PTE = 0 and bits [2..6] indicate size of table
  *
  * So long as we atomically load page table pointers we are safe against teardown,
  * we can follow the address down to the the page and take a ref on it.
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 83dfcb55ffef..83dfd7925c72 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -179,6 +179,10 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	 */
 	VM_WARN_ON((pte_val(*ptep) & (_PAGE_PRESENT | _PAGE_USER)) ==
 		(_PAGE_PRESENT | _PAGE_USER));
+	/*
+	 * Add the pte bit when tryint set a pte
+	 */
+	pte = __pte(pte_val(pte) | _PAGE_PTE);
 
 	/* Note: mm->context.id might not yet have been assigned as
 	 * this context might not have been activated yet when this
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index d42dd289abfe..ea6bc31debb0 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -765,13 +765,8 @@ static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot)
 pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
 {
 	unsigned long pmdv;
-	/*
-	 * For a valid pte, we would have _PAGE_PRESENT always
-	 * set. We use this to check THP page at pmd level.
-	 * leaf pte for huge page, bottom two bits != 00
-	 */
+
 	pmdv = pfn << PTE_RPN_SHIFT;
-	pmdv |= _PAGE_THP_HUGE;
 	return pmd_set_protbits(__pmd(pmdv), pgprot);
 }
 
-- 
2.5.0
