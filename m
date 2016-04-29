Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDy62VvVzDqBM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 31/70] powerpc/mm: Add radix callbacks to pte accessors
Date: Fri, 29 Apr 2016 23:25:54 +1000
Message-Id: <1461936393-10131-31-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

For those pte accessors, that operate on a different set of pte bits
between hash/radix, we add a generic variant that does a conditional
to hash linux or radix variant.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 41 +++++++++---------
 arch/powerpc/include/asm/book3s/64/pgtable.h | 64 ++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index b601e05ab2ce..62714399a1a0 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -85,23 +85,26 @@
 #define _PTEIDX_SECONDARY	0x8
 #define _PTEIDX_GROUP_IX	0x7
 
-#define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
-#define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
+#define H_PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
+#define H_PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
 #ifndef __ASSEMBLY__
-#define	pmd_bad(pmd)		(pmd_val(pmd) & PMD_BAD_BITS)
-
-#define	pud_bad(pud)		(pud_val(pud) & PUD_BAD_BITS)
+#define	hash__pmd_bad(pmd)		(pmd_val(pmd) & H_PMD_BAD_BITS)
+#define	hash__pud_bad(pud)		(pud_val(pud) & H_PUD_BAD_BITS)
+static inline int hash__pgd_bad(pgd_t pgd)
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
+static inline unsigned long hash__pte_update(struct mm_struct *mm,
+					 unsigned long addr,
+					 pte_t *ptep, unsigned long clr,
+					 unsigned long set,
+					 int huge)
 {
 	__be64 old_be, tmp_be;
 	unsigned long old;
@@ -132,7 +135,7 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 /* Set the dirty and/or accessed bits atomically in a linux PTE, this
  * function doesn't need to flush the hash entry
  */
-static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
+static inline void hash__ptep_set_access_flags(pte_t *ptep, pte_t entry)
 {
 	__be64 old, tmp, val, mask;
 
@@ -153,27 +156,23 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 	:"cc");
 }
 
-static inline int pgd_bad(pgd_t pgd)
+static inline int hash__pte_same(pte_t pte_a, pte_t pte_b)
 {
-	return (pgd_val(pgd) == 0);
+	return (((pte_raw(pte_a) ^ pte_raw(pte_b)) & ~cpu_to_be64(_PAGE_HPTEFLAGS)) == 0);
 }
 
-#define __HAVE_ARCH_PTE_SAME
-static inline int pte_same(pte_t pte_a, pte_t pte_b)
+static inline int hash__pte_none(pte_t pte)
 {
-	return (((pte_raw(pte_a) ^ pte_raw(pte_b)) & ~cpu_to_be64(_PAGE_HPTEFLAGS)) == 0);
+	return (pte_val(pte) & ~H_PTE_NONE_MASK) == 0;
 }
 
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
+static inline void hash__set_pte_at(struct mm_struct *mm, unsigned long addr,
+				  pte_t *ptep, pte_t pte, int percpu)
 {
 	/*
 	 * Anything else just stores the PTE normally. That covers all 64-bit
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c47c3f7fc4e0..bb0639a8c250 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -262,6 +262,14 @@ extern unsigned long __pgd_table_size;
 
 #endif /* __real_pte */
 
+static inline unsigned long pte_update(struct mm_struct *mm, unsigned long addr,
+				       pte_t *ptep, unsigned long clr,
+				       unsigned long set, int huge)
+{
+	if (radix_enabled())
+		return radix__pte_update(mm, addr, ptep, clr, set, huge);
+	return hash__pte_update(mm, addr, ptep, clr, set, huge);
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
+		return radix__ptep_set_access_flags(ptep, entry);
+	return hash__ptep_set_access_flags(ptep, entry);
+}
+
+#define __HAVE_ARCH_PTE_SAME
+static inline int pte_same(pte_t pte_a, pte_t pte_b)
+{
+	if (radix_enabled())
+		return radix__pte_same(pte_a, pte_b);
+	return hash__pte_same(pte_a, pte_b);
+}
+
+static inline int pte_none(pte_t pte)
+{
+	if (radix_enabled())
+		return radix__pte_none(pte);
+	return hash__pte_none(pte);
+}
+
+static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte, int percpu)
+{
+	if (radix_enabled())
+		return radix__set_pte_at(mm, addr, ptep, pte, percpu);
+	return hash__set_pte_at(mm, addr, ptep, pte, percpu);
+}
 
 #define _PAGE_CACHE_CTL	(_PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
 
@@ -555,6 +596,13 @@ static inline void pmd_clear(pmd_t *pmdp)
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_present(pmd)	(!pmd_none(pmd))
 
+static inline int pmd_bad(pmd_t pmd)
+{
+	if (radix_enabled())
+		return radix__pmd_bad(pmd);
+	return hash__pmd_bad(pmd);
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
+		return radix__pud_bad(pud);
+	return hash__pud_bad(pud);
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
+		return radix__pgd_bad(pgd);
+	return hash__pgd_bad(pgd);
+}
+
 extern struct page *pgd_page(pgd_t pgd);
 
 /* Pointers in the page table tree are physical addresses */
-- 
2.5.0
