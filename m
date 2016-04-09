Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmKY3swyzDqD7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:15:45 +1000 (AEST)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:15:43 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C8A481FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:03:49 -0600 (MDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396FeT836962316
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:15:40 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396FecW015078
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:15:40 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 28/68] powerpc/mm: Add radix callbacks to pte accessors
Date: Sat,  9 Apr 2016 11:43:24 +0530
Message-Id: <1460182444-2468-29-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For those pte accessors, that operate on a different set of pte bits
between hash/radix, we add a generic variant that does a conditional
to hash linux or radix variant.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 41 +++++++++---------
 arch/powerpc/include/asm/book3s/64/pgtable.h | 64 ++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 833a897a0794..958491f59c2a 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -88,23 +88,26 @@
 /* Hash table based platforms need atomic updates of the linux PTE */
 #define PTE_ATOMIC_UPDATES	1
 
-#define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
-#define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
+#define H_PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
+#define H_PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
 #ifndef __ASSEMBLY__
-#define	pmd_bad(pmd)		(pmd_val(pmd) & PMD_BAD_BITS)
-
-#define	pud_bad(pud)		(pud_val(pud) & PUD_BAD_BITS)
+#define	hlpmd_bad(pmd)		(pmd_val(pmd) & H_PMD_BAD_BITS)
+#define	hlpud_bad(pud)		(pud_val(pud) & H_PUD_BAD_BITS)
+static inline int hlpgd_bad(pgd_t pgd)
+{
+	return (pgd_val(pgd) == 0);
+}
 
 extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, unsigned long pte, int huge);
 extern unsigned long htab_convert_pte_flags(unsigned long pteflags);
 /* Atomic PTE updates */
-static inline unsigned long pte_update(struct mm_struct *mm,
-				       unsigned long addr,
-				       pte_t *ptep, unsigned long clr,
-				       unsigned long set,
-				       int huge)
+static inline unsigned long hlpte_update(struct mm_struct *mm,
+					 unsigned long addr,
+					 pte_t *ptep, unsigned long clr,
+					 unsigned long set,
+					 int huge)
 {
 	unsigned long old, tmp;
 	unsigned long busy = cpu_to_be64(H_PAGE_BUSY);
@@ -137,7 +140,7 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 /* Set the dirty and/or accessed bits atomically in a linux PTE, this
  * function doesn't need to flush the hash entry
  */
-static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
+static inline void __hlptep_set_access_flags(pte_t *ptep, pte_t entry)
 {
 	unsigned long bits = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_READ | _PAGE_WRITE | _PAGE_EXEC |
@@ -160,24 +163,20 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 	:"cc");
 }
 
-static inline int pgd_bad(pgd_t pgd)
+#define hlpte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
+
+static inline int hlpte_none(pte_t pte)
 {
-	return (pgd_val(pgd) == 0);
+	return (pte_val(pte) & ~H_PTE_NONE_MASK) == 0;
 }
 
-#define __HAVE_ARCH_PTE_SAME
-#define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
-
-/* Generic accessors to PTE bits */
-static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~H_PTE_NONE_MASK) == 0; }
-
 /* This low level function performs the actual PTE insertion
  * Setting the PTE depends on the MMU type and other factors. It's
  * an horrible mess that I'm not going to try to clean up now but
  * I'm keeping it in one place rather than spread around
  */
-static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, pte_t pte, int percpu)
+static inline void __set_hlpte_at(struct mm_struct *mm, unsigned long addr,
+				  pte_t *ptep, pte_t pte, int percpu)
 {
 	/*
 	 * Anything else just stores the PTE normally. That covers all 64-bit
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c47c3f7fc4e0..c11cc60ae8b6 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -262,6 +262,14 @@ extern unsigned long __pgd_table_size;
 
 #endif /* __real_pte */
 
+static inline unsigned long pte_update(struct mm_struct *mm, unsigned long addr,
+				       pte_t *ptep, unsigned long clr,
+				       unsigned long set, int huge)
+{
+	if (radix_enabled())
+		return rpte_update(mm, addr, ptep, clr, set, huge);
+	return hlpte_update(mm, addr, ptep, clr, set, huge);
+}
 /*
  * For hash even if we have _PAGE_ACCESSED = 0, we do a pte_update.
  * We currently remove entries from the hashtable regardless of whether
@@ -501,6 +509,39 @@ static inline bool check_pte_access(unsigned long access, unsigned long ptev)
 
 	return true;
 }
+/*
+ * Generic functions with hash/radix callbacks
+ */
+
+static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
+{
+	if (radix_enabled())
+		return __rptep_set_access_flags(ptep, entry);
+	return __hlptep_set_access_flags(ptep, entry);
+}
+
+#define __HAVE_ARCH_PTE_SAME
+static inline int pte_same(pte_t pte_a, pte_t pte_b)
+{
+	if (radix_enabled())
+		return rpte_same(pte_a, pte_b);
+	return hlpte_same(pte_a, pte_b);
+}
+
+static inline int pte_none(pte_t pte)
+{
+	if (radix_enabled())
+		return rpte_none(pte);
+	return hlpte_none(pte);
+}
+
+static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte, int percpu)
+{
+	if (radix_enabled())
+		return __set_rpte_at(mm, addr, ptep, pte, percpu);
+	return __set_hlpte_at(mm, addr, ptep, pte, percpu);
+}
 
 #define _PAGE_CACHE_CTL	(_PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
 
@@ -555,6 +596,13 @@ static inline void pmd_clear(pmd_t *pmdp)
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_present(pmd)	(!pmd_none(pmd))
 
+static inline int pmd_bad(pmd_t pmd)
+{
+	if (radix_enabled())
+		return rpmd_bad(pmd);
+	return hlpmd_bad(pmd);
+}
+
 static inline void pud_set(pud_t *pudp, unsigned long val)
 {
 	*pudp = __pud(val);
@@ -580,6 +628,15 @@ static inline pud_t pte_pud(pte_t pte)
 	return __pud(pte_val(pte));
 }
 #define pud_write(pud)		pte_write(pud_pte(pud))
+
+static inline int pud_bad(pud_t pud)
+{
+	if (radix_enabled())
+		return rpud_bad(pud);
+	return hlpud_bad(pud);
+}
+
+
 #define pgd_write(pgd)		pte_write(pgd_pte(pgd))
 static inline void pgd_set(pgd_t *pgdp, unsigned long val)
 {
@@ -604,6 +661,13 @@ static inline pgd_t pte_pgd(pte_t pte)
 	return __pgd(pte_val(pte));
 }
 
+static inline int pgd_bad(pgd_t pgd)
+{
+	if (radix_enabled())
+		return rpgd_bad(pgd);
+	return hlpgd_bad(pgd);
+}
+
 extern struct page *pgd_page(pgd_t pgd);
 
 /* Pointers in the page table tree are physical addresses */
-- 
2.5.0
