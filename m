Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C3D41A01C0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:43:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:43:01 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2304D3578054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L6gpHO24314060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:59 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L6gQrK015634
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:26 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 30/31] powerpc/mm: Move THP headers around
Date: Mon, 21 Sep 2015 12:10:57 +0530
Message-Id: <1442817658-2588-31-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We support THP only with book3s_64 and 64K page size. Move
THP details to hash64-64k.h to clarify the same.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 126 +++++++++++++
 arch/powerpc/include/asm/book3s/64/hash.h     | 223 ++++++-----------------
 arch/powerpc/include/asm/booke/64/pgtable.h   | 245 +-------------------------
 arch/powerpc/mm/hash_native_64.c              |  10 ++
 arch/powerpc/mm/pgtable_64.c                  |   2 +-
 arch/powerpc/platforms/pseries/lpar.c         |  10 ++
 6 files changed, 201 insertions(+), 415 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 0869e5fe5d08..3ea7cd4704b9 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -159,6 +159,132 @@ static inline int hugepd_ok(hugepd_t hpd)
 #define is_hugepd(pdep)			0
 #endif /* CONFIG_HUGETLB_PAGE */
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+extern unsigned long pmd_hugepage_update(struct mm_struct *mm,
+					 unsigned long addr,
+					 pmd_t *pmdp,
+					 unsigned long clr,
+					 unsigned long set);
+static inline char *get_hpte_slot_array(pmd_t *pmdp)
+{
+	/*
+	 * The hpte hindex is stored in the pgtable whose address is in the
+	 * second half of the PMD
+	 *
+	 * Order this load with the test for pmd_trans_huge in the caller
+	 */
+	smp_rmb();
+	return *(char **)(pmdp + PTRS_PER_PMD);
+
+
+}
+/*
+ * The linux hugepage PMD now include the pmd entries followed by the address
+ * to the stashed pgtable_t. The stashed pgtable_t contains the hpte bits.
+ * [ 1 bit secondary | 3 bit hidx | 1 bit valid | 000]. We use one byte per
+ * each HPTE entry. With 16MB hugepage and 64K HPTE we need 256 entries and
+ * with 4K HPTE we need 4096 entries. Both will fit in a 4K pgtable_t.
+ *
+ * The last three bits are intentionally left to zero. This memory location
+ * are also used as normal page PTE pointers. So if we have any pointers
+ * left around while we collapse a hugepage, we need to make sure
+ * _PAGE_PRESENT bit of that is zero when we look at them
+ */
+static inline unsigned int hpte_valid(unsigned char *hpte_slot_array, int index)
+{
+	return (hpte_slot_array[index] >> 3) & 0x1;
+}
+
+static inline unsigned int hpte_hash_index(unsigned char *hpte_slot_array,
+					   int index)
+{
+	return hpte_slot_array[index] >> 4;
+}
+
+static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
+					unsigned int index, unsigned int hidx)
+{
+	hpte_slot_array[index] = hidx << 4 | 0x1 << 3;
+}
+
+/*
+ *
+ * For core kernel code by design pmd_trans_huge is never run on any hugetlbfs
+ * page. The hugetlbfs page table walking and mangling paths are totally
+ * separated form the core VM paths and they're differentiated by
+ *  VM_HUGETLB being set on vm_flags well before any pmd_trans_huge could run.
+ *
+ * pmd_trans_huge() is defined as false at build time if
+ * CONFIG_TRANSPARENT_HUGEPAGE=n to optimize away code blocks at build
+ * time in such case.
+ *
+ * For ppc64 we need to differntiate from explicit hugepages from THP, because
+ * for THP we also track the subpage details at the pmd level. We don't do
+ * that for explicit huge pages.
+ *
+ */
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	/*
+	 * leaf pte for huge page, bottom two bits != 00
+	 */
+	return (pmd_val(pmd) & 0x3) && (pmd_val(pmd) & _PAGE_THP_HUGE);
+}
+
+static inline int pmd_trans_splitting(pmd_t pmd)
+{
+	if (pmd_trans_huge(pmd))
+		return pmd_val(pmd) & _PAGE_SPLITTING;
+	return 0;
+}
+
+static inline int pmd_large(pmd_t pmd)
+{
+	/*
+	 * leaf pte for huge page, bottom two bits != 00
+	 */
+	return ((pmd_val(pmd) & 0x3) != 0x0);
+}
+
+static inline pmd_t pmd_mknotpresent(pmd_t pmd)
+{
+	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
+}
+
+static inline pmd_t pmd_mksplitting(pmd_t pmd)
+{
+	return __pmd(pmd_val(pmd) | _PAGE_SPLITTING);
+}
+
+#define __HAVE_ARCH_PMD_SAME
+static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
+{
+	return (((pmd_val(pmd_a) ^ pmd_val(pmd_b)) & ~_PAGE_HPTEFLAGS) == 0);
+}
+
+static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
+					      unsigned long addr, pmd_t *pmdp)
+{
+	unsigned long old;
+
+	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
+		return 0;
+	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
+	return ((old & _PAGE_ACCESSED) != 0);
+}
+
+#define __HAVE_ARCH_PMDP_SET_WRPROTECT
+static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
+				      pmd_t *pmdp)
+{
+
+	if ((pmd_val(*pmdp) & _PAGE_RW) == 0)
+		return;
+
+	pmd_hugepage_update(mm, addr, pmdp, _PAGE_RW, 0);
+}
+
+#endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_64K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 92831cf798ce..d7c5c96b0faa 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -2,6 +2,55 @@
 #define _ASM_POWERPC_BOOK3S_64_HASH_H
 #ifdef __KERNEL__
 
+/*
+ * Common bits between 4K and 64K pages in a linux-style PTE.
+ * These match the bits in the (hardware-defined) PowerPC PTE as closely
+ * as possible. Additional bits may be defined in pgtable-hash64-*.h
+ *
+ * Note: We only support user read/write permissions. Supervisor always
+ * have full read/write to pages above PAGE_OFFSET (pages below that
+ * always use the user access permissions).
+ *
+ * We could create separate kernel read-only if we used the 3 PP bits
+ * combinations that newer processors provide but we currently don't.
+ */
+#define _PAGE_PRESENT		0x00001 /* software: pte contains a translation */
+#define _PAGE_USER		0x00002 /* matches one of the PP bits */
+#define _PAGE_BIT_SWAP_TYPE	2
+#define _PAGE_EXEC		0x00004 /* No execute on POWER4 and newer (we invert) */
+#define _PAGE_GUARDED		0x00008
+/* We can derive Memory coherence from _PAGE_NO_CACHE */
+#define _PAGE_COHERENT		0x0
+#define _PAGE_NO_CACHE		0x00020 /* I: cache inhibit */
+#define _PAGE_WRITETHRU		0x00040 /* W: cache write-through */
+#define _PAGE_DIRTY		0x00080 /* C: page changed */
+#define _PAGE_ACCESSED		0x00100 /* R: page referenced */
+#define _PAGE_RW		0x00200 /* software: user write access allowed */
+#define _PAGE_HASHPTE		0x00400 /* software: pte has an associated HPTE */
+#define _PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
+#define _PAGE_F_GIX		0x07000 /* full page: hidx bits */
+#define _PAGE_F_GIX_SHIFT	12
+#define _PAGE_F_SECOND		0x08000 /* Whether to use secondary hash or not */
+#define _PAGE_SPECIAL		0x10000 /* software: special page */
+
+/*
+ * THP pages can't be special. So use the _PAGE_SPECIAL
+ */
+#define _PAGE_SPLITTING _PAGE_SPECIAL
+
+/*
+ * We need to differentiate between explicit huge page and THP huge
+ * page, since THP huge page also need to track real subpage details
+ */
+#define _PAGE_THP_HUGE  _PAGE_4K_PFN
+
+/*
+ * set of bits not changed in pmd_modify.
+ */
+#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
+			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
+			 _PAGE_THP_HUGE)
+
 #ifdef CONFIG_PPC_64K_PAGES
 #include <asm/book3s/64/hash-64k.h>
 #else
@@ -59,36 +108,6 @@
 #else
 #error "Hash Config needs mm slice enabled"
 #endif /* CONFIG_PPC_MM_SLICES */
-/*
- * Common bits between 4K and 64K pages in a linux-style PTE.
- * These match the bits in the (hardware-defined) PowerPC PTE as closely
- * as possible. Additional bits may be defined in pgtable-hash64-*.h
- *
- * Note: We only support user read/write permissions. Supervisor always
- * have full read/write to pages above PAGE_OFFSET (pages below that
- * always use the user access permissions).
- *
- * We could create separate kernel read-only if we used the 3 PP bits
- * combinations that newer processors provide but we currently don't.
- */
-#define _PAGE_PRESENT		0x00001 /* software: pte contains a translation */
-#define _PAGE_USER		0x00002 /* matches one of the PP bits */
-#define _PAGE_BIT_SWAP_TYPE	2
-#define _PAGE_EXEC		0x00004 /* No execute on POWER4 and newer (we invert) */
-#define _PAGE_GUARDED		0x00008
-/* We can derive Memory coherence from _PAGE_NO_CACHE */
-#define _PAGE_COHERENT		0x0
-#define _PAGE_NO_CACHE		0x00020 /* I: cache inhibit */
-#define _PAGE_WRITETHRU		0x00040 /* W: cache write-through */
-#define _PAGE_DIRTY		0x00080 /* C: page changed */
-#define _PAGE_ACCESSED		0x00100 /* R: page referenced */
-#define _PAGE_RW		0x00200 /* software: user write access allowed */
-#define _PAGE_HASHPTE		0x00400 /* software: pte has an associated HPTE */
-#define _PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
-#define _PAGE_F_GIX		0x07000 /* full page: hidx bits */
-#define _PAGE_F_GIX_SHIFT	12
-#define _PAGE_F_SECOND		0x08000 /* Whether to use secondary hash or not */
-#define _PAGE_SPECIAL		0x10000 /* software: special page */
 
 /* No separate kernel read-only */
 #define _PAGE_KERNEL_RW		(_PAGE_RW | _PAGE_DIRTY) /* user access blocked by key */
@@ -107,24 +126,6 @@
 
 /* Hash table based platforms need atomic updates of the linux PTE */
 #define PTE_ATOMIC_UPDATES	1
-
-/*
- * THP pages can't be special. So use the _PAGE_SPECIAL
- */
-#define _PAGE_SPLITTING _PAGE_SPECIAL
-
-/*
- * We need to differentiate between explicit huge page and THP huge
- * page, since THP huge page also need to track real subpage details
- */
-#define _PAGE_THP_HUGE  _PAGE_4K_PFN
-
-/*
- * set of bits not changed in pmd_modify.
- */
-#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
-			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
-			 _PAGE_THP_HUGE)
 #define _PTE_NONE_MASK	_PAGE_HPTEFLAGS
 /*
  * The mask convered by the RPN must be a ULL on 32-bit platforms with
@@ -237,11 +238,6 @@ extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, unsigned long pte, int huge);
 extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 				   pmd_t *pmdp, unsigned long old_pmd);
-extern unsigned long pmd_hugepage_update(struct mm_struct *mm,
-					 unsigned long addr,
-					 pmd_t *pmdp,
-					 unsigned long clr,
-					 unsigned long set);
 extern unsigned long htab_convert_pte_flags(unsigned long pteflags);
 /* Atomic PTE updates */
 static inline unsigned long pte_update(struct mm_struct *mm,
@@ -367,127 +363,6 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
 
-static inline char *get_hpte_slot_array(pmd_t *pmdp)
-{
-	/*
-	 * The hpte hindex is stored in the pgtable whose address is in the
-	 * second half of the PMD
-	 *
-	 * Order this load with the test for pmd_trans_huge in the caller
-	 */
-	smp_rmb();
-	return *(char **)(pmdp + PTRS_PER_PMD);
-
-
-}
-/*
- * The linux hugepage PMD now include the pmd entries followed by the address
- * to the stashed pgtable_t. The stashed pgtable_t contains the hpte bits.
- * [ 1 bit secondary | 3 bit hidx | 1 bit valid | 000]. We use one byte per
- * each HPTE entry. With 16MB hugepage and 64K HPTE we need 256 entries and
- * with 4K HPTE we need 4096 entries. Both will fit in a 4K pgtable_t.
- *
- * The last three bits are intentionally left to zero. This memory location
- * are also used as normal page PTE pointers. So if we have any pointers
- * left around while we collapse a hugepage, we need to make sure
- * _PAGE_PRESENT bit of that is zero when we look at them
- */
-static inline unsigned int hpte_valid(unsigned char *hpte_slot_array, int index)
-{
-	return (hpte_slot_array[index] >> 3) & 0x1;
-}
-
-static inline unsigned int hpte_hash_index(unsigned char *hpte_slot_array,
-					   int index)
-{
-	return hpte_slot_array[index] >> 4;
-}
-
-static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
-					unsigned int index, unsigned int hidx)
-{
-	hpte_slot_array[index] = hidx << 4 | 0x1 << 3;
-}
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-/*
- *
- * For core kernel code by design pmd_trans_huge is never run on any hugetlbfs
- * page. The hugetlbfs page table walking and mangling paths are totally
- * separated form the core VM paths and they're differentiated by
- *  VM_HUGETLB being set on vm_flags well before any pmd_trans_huge could run.
- *
- * pmd_trans_huge() is defined as false at build time if
- * CONFIG_TRANSPARENT_HUGEPAGE=n to optimize away code blocks at build
- * time in such case.
- *
- * For ppc64 we need to differntiate from explicit hugepages from THP, because
- * for THP we also track the subpage details at the pmd level. We don't do
- * that for explicit huge pages.
- *
- */
-static inline int pmd_trans_huge(pmd_t pmd)
-{
-	/*
-	 * leaf pte for huge page, bottom two bits != 00
-	 */
-	return (pmd_val(pmd) & 0x3) && (pmd_val(pmd) & _PAGE_THP_HUGE);
-}
-
-static inline int pmd_trans_splitting(pmd_t pmd)
-{
-	if (pmd_trans_huge(pmd))
-		return pmd_val(pmd) & _PAGE_SPLITTING;
-	return 0;
-}
-
-#endif
-static inline int pmd_large(pmd_t pmd)
-{
-	/*
-	 * leaf pte for huge page, bottom two bits != 00
-	 */
-	return ((pmd_val(pmd) & 0x3) != 0x0);
-}
-
-static inline pmd_t pmd_mknotpresent(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
-}
-
-static inline pmd_t pmd_mksplitting(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) | _PAGE_SPLITTING);
-}
-
-#define __HAVE_ARCH_PMD_SAME
-static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
-{
-	return (((pmd_val(pmd_a) ^ pmd_val(pmd_b)) & ~_PAGE_HPTEFLAGS) == 0);
-}
-
-static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
-					      unsigned long addr, pmd_t *pmdp)
-{
-	unsigned long old;
-
-	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
-		return 0;
-	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
-	return ((old & _PAGE_ACCESSED) != 0);
-}
-
-#define __HAVE_ARCH_PMDP_SET_WRPROTECT
-static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
-				      pmd_t *pmdp)
-{
-
-	if ((pmd_val(*pmdp) & _PAGE_RW) == 0)
-		return;
-
-	pmd_hugepage_update(mm, addr, pmdp, _PAGE_RW, 0);
-}
-
 /* Generic accessors to PTE bits */
 static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
 static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
diff --git a/arch/powerpc/include/asm/booke/64/pgtable.h b/arch/powerpc/include/asm/booke/64/pgtable.h
index 81e850c32c13..5c81a7bcbeef 100644
--- a/arch/powerpc/include/asm/booke/64/pgtable.h
+++ b/arch/powerpc/include/asm/booke/64/pgtable.h
@@ -154,6 +154,11 @@ static inline void pmd_clear(pmd_t *pmdp)
 	*pmdp = __pmd(0);
 }
 
+static inline pte_t pmd_pte(pmd_t pmd)
+{
+	return __pte(pmd_val(pmd));
+}
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(!is_kernel_addr(pmd_val(pmd)) \
 				 || (pmd_val(pmd) & PMD_BAD_BITS))
@@ -389,244 +394,4 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
 #endif /* __ASSEMBLY__ */
 
-/*
- * THP pages can't be special. So use the _PAGE_SPECIAL
- */
-#define _PAGE_SPLITTING _PAGE_SPECIAL
-
-/*
- * We need to differentiate between explicit huge page and THP huge
- * page, since THP huge page also need to track real subpage details
- */
-#define _PAGE_THP_HUGE  _PAGE_4K_PFN
-
-/*
- * set of bits not changed in pmd_modify.
- */
-#define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
-			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
-			 _PAGE_THP_HUGE)
-
-#ifndef __ASSEMBLY__
-/*
- * The linux hugepage PMD now include the pmd entries followed by the address
- * to the stashed pgtable_t. The stashed pgtable_t contains the hpte bits.
- * [ 1 bit secondary | 3 bit hidx | 1 bit valid | 000]. We use one byte per
- * each HPTE entry. With 16MB hugepage and 64K HPTE we need 256 entries and
- * with 4K HPTE we need 4096 entries. Both will fit in a 4K pgtable_t.
- *
- * The last three bits are intentionally left to zero. This memory location
- * are also used as normal page PTE pointers. So if we have any pointers
- * left around while we collapse a hugepage, we need to make sure
- * _PAGE_PRESENT bit of that is zero when we look at them
- */
-static inline unsigned int hpte_valid(unsigned char *hpte_slot_array, int index)
-{
-	return (hpte_slot_array[index] >> 3) & 0x1;
-}
-
-static inline unsigned int hpte_hash_index(unsigned char *hpte_slot_array,
-					   int index)
-{
-	return hpte_slot_array[index] >> 4;
-}
-
-static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
-					unsigned int index, unsigned int hidx)
-{
-	hpte_slot_array[index] = hidx << 4 | 0x1 << 3;
-}
-
-struct page *realmode_pfn_to_page(unsigned long pfn);
-
-static inline char *get_hpte_slot_array(pmd_t *pmdp)
-{
-	/*
-	 * The hpte hindex is stored in the pgtable whose address is in the
-	 * second half of the PMD
-	 *
-	 * Order this load with the test for pmd_trans_huge in the caller
-	 */
-	smp_rmb();
-	return *(char **)(pmdp + PTRS_PER_PMD);
-
-
-}
-
-extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
-				   pmd_t *pmdp, unsigned long old_pmd);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
-extern pmd_t mk_pmd(struct page *page, pgprot_t pgprot);
-extern pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot);
-extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
-		       pmd_t *pmdp, pmd_t pmd);
-extern void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
-				 pmd_t *pmd);
-/*
- *
- * For core kernel code by design pmd_trans_huge is never run on any hugetlbfs
- * page. The hugetlbfs page table walking and mangling paths are totally
- * separated form the core VM paths and they're differentiated by
- *  VM_HUGETLB being set on vm_flags well before any pmd_trans_huge could run.
- *
- * pmd_trans_huge() is defined as false at build time if
- * CONFIG_TRANSPARENT_HUGEPAGE=n to optimize away code blocks at build
- * time in such case.
- *
- * For ppc64 we need to differntiate from explicit hugepages from THP, because
- * for THP we also track the subpage details at the pmd level. We don't do
- * that for explicit huge pages.
- *
- */
-static inline int pmd_trans_huge(pmd_t pmd)
-{
-	/*
-	 * leaf pte for huge page, bottom two bits != 00
-	 */
-	return (pmd_val(pmd) & 0x3) && (pmd_val(pmd) & _PAGE_THP_HUGE);
-}
-
-static inline int pmd_trans_splitting(pmd_t pmd)
-{
-	if (pmd_trans_huge(pmd))
-		return pmd_val(pmd) & _PAGE_SPLITTING;
-	return 0;
-}
-
-extern int has_transparent_hugepage(void);
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-
-static inline int pmd_large(pmd_t pmd)
-{
-	/*
-	 * leaf pte for huge page, bottom two bits != 00
-	 */
-	return ((pmd_val(pmd) & 0x3) != 0x0);
-}
-
-static inline pte_t pmd_pte(pmd_t pmd)
-{
-	return __pte(pmd_val(pmd));
-}
-
-static inline pmd_t pte_pmd(pte_t pte)
-{
-	return __pmd(pte_val(pte));
-}
-
-static inline pte_t *pmdp_ptep(pmd_t *pmd)
-{
-	return (pte_t *)pmd;
-}
-
-#define pmd_pfn(pmd)		pte_pfn(pmd_pte(pmd))
-#define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
-#define pmd_young(pmd)		pte_young(pmd_pte(pmd))
-#define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
-#define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
-#define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
-#define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
-#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
-
-#define __HAVE_ARCH_PMD_WRITE
-#define pmd_write(pmd)		pte_write(pmd_pte(pmd))
-
-static inline pmd_t pmd_mkhuge(pmd_t pmd)
-{
-	/* Do nothing, mk_pmd() does this part.  */
-	return pmd;
-}
-
-static inline pmd_t pmd_mknotpresent(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
-}
-
-static inline pmd_t pmd_mksplitting(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) | _PAGE_SPLITTING);
-}
-
-#define __HAVE_ARCH_PMD_SAME
-static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
-{
-	return (((pmd_val(pmd_a) ^ pmd_val(pmd_b)) & ~_PAGE_HPTEFLAGS) == 0);
-}
-
-#define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
-extern int pmdp_set_access_flags(struct vm_area_struct *vma,
-				 unsigned long address, pmd_t *pmdp,
-				 pmd_t entry, int dirty);
-
-extern unsigned long pmd_hugepage_update(struct mm_struct *mm,
-					 unsigned long addr,
-					 pmd_t *pmdp,
-					 unsigned long clr,
-					 unsigned long set);
-
-static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
-					      unsigned long addr, pmd_t *pmdp)
-{
-	unsigned long old;
-
-	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
-		return 0;
-	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
-	return ((old & _PAGE_ACCESSED) != 0);
-}
-
-#define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
-extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-				     unsigned long address, pmd_t *pmdp);
-#define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
-extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
-				  unsigned long address, pmd_t *pmdp);
-
-#define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
-extern pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
-				     unsigned long addr, pmd_t *pmdp);
-
-#define __HAVE_ARCH_PMDP_SET_WRPROTECT
-static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
-				      pmd_t *pmdp)
-{
-
-	if ((pmd_val(*pmdp) & _PAGE_RW) == 0)
-		return;
-
-	pmd_hugepage_update(mm, addr, pmdp, _PAGE_RW, 0);
-}
-
-#define __HAVE_ARCH_PMDP_SPLITTING_FLUSH
-extern void pmdp_splitting_flush(struct vm_area_struct *vma,
-				 unsigned long address, pmd_t *pmdp);
-
-extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
-				 unsigned long address, pmd_t *pmdp);
-#define pmdp_collapse_flush pmdp_collapse_flush
-
-#define __HAVE_ARCH_PGTABLE_DEPOSIT
-extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				       pgtable_t pgtable);
-#define __HAVE_ARCH_PGTABLE_WITHDRAW
-extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
-
-#define __HAVE_ARCH_PMDP_INVALIDATE
-extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
-			    pmd_t *pmdp);
-
-#define pmd_move_must_withdraw pmd_move_must_withdraw
-struct spinlock;
-static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
-					 struct spinlock *old_pmd_ptl)
-{
-	/*
-	 * Archs like ppc64 use pgtable to store per pmd
-	 * specific information. So when we switch the pmd,
-	 * we should also withdraw and deposit the pgtable
-	 */
-	return true;
-}
-#endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOKE_64_PGTABLE_H */
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 13befa35d8a8..538390638b63 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -429,6 +429,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void native_hugepage_invalidate(unsigned long vsid,
 				       unsigned long addr,
 				       unsigned char *hpte_slot_array,
@@ -482,6 +483,15 @@ static void native_hugepage_invalidate(unsigned long vsid,
 	}
 	local_irq_restore(flags);
 }
+#else
+static void native_hugepage_invalidate(unsigned long vsid,
+				       unsigned long addr,
+				       unsigned char *hpte_slot_array,
+				       int psize, int ssize, int local)
+{
+	WARN(1, "%s called without THP support\n", __func__);
+}
+#endif
 
 static inline int __hpte_actual_psize(unsigned int lp, int psize)
 {
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 3967e3cce03e..d42dd289abfe 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -359,7 +359,7 @@ struct page *pud_page(pud_t pud)
 struct page *pmd_page(pmd_t pmd)
 {
 	if (pmd_trans_huge(pmd) || pmd_huge(pmd))
-		return pfn_to_page(pmd_pfn(pmd));
+		return pte_page(pmd_pte(pmd));
 	return virt_to_page(pmd_page_vaddr(pmd));
 }
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index b7a67e3d2201..6d46547871aa 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -396,6 +396,7 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	BUG_ON(lpar_rc != H_SUCCESS);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * Limit iterations holding pSeries_lpar_tlbie_lock to 3. We also need
  * to make sure that we avoid bouncing the hypervisor tlbie lock.
@@ -494,6 +495,15 @@ static void pSeries_lpar_hugepage_invalidate(unsigned long vsid,
 		__pSeries_lpar_hugepage_invalidate(slot_array, vpn_array,
 						   index, psize, ssize);
 }
+#else
+static void pSeries_lpar_hugepage_invalidate(unsigned long vsid,
+					     unsigned long addr,
+					     unsigned char *hpte_slot_array,
+					     int psize, int ssize, int local)
+{
+	WARN(1, "%s called without THP support\n", __func__);
+}
+#endif
 
 static void pSeries_lpar_hpte_removebolted(unsigned long ea,
 					   int psize, int ssize)
-- 
2.5.0
