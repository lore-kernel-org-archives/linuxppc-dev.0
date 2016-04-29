Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDy76ZQhzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 33/70] powerpc/mm/radix: Add radix callback for pmd
 accessors
Date: Fri, 29 Apr 2016 23:25:56 +1000
Message-Id: <1461936393-10131-33-git-send-email-mpe@ellerman.id.au>
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

This only does 64K Linux page support for now. 64K hash Linux config
THP needs to differentiate it from hugetlb huge page because with THP we
need to track hash pte slot information with respect to each subpage.
This is not needed with hugetlb hugepage, because we don't do MPSS with
hugetlb.

Radix doesn't have any such restrictions.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h    |  9 ++++-----
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 23 +++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/radix.h       |  9 +++++++++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index d4e1f1f5322f..c00e39fa3eba 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -97,8 +97,8 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
 
 extern int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			   unsigned long pfn, unsigned long size, pgprot_t);
-static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
-			       unsigned long pfn, pgprot_t prot)
+static inline int hash__remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
+				 unsigned long pfn, pgprot_t prot)
 {
 	if (pfn > (PTE_RPN_MASK >> PAGE_SHIFT)) {
 		WARN(1, "remap_4k_pfn called with wrong pfn value\n");
@@ -182,14 +182,13 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
  * that for explicit huge pages.
  *
  */
-static inline int pmd_trans_huge(pmd_t pmd)
+static inline int hash__pmd_trans_huge(pmd_t pmd)
 {
 	return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE)) ==
 		  (_PAGE_PTE | H_PAGE_THP_HUGE));
 }
 
-#define __HAVE_ARCH_PMD_SAME
-static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
+static inline int hash__pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 {
 	return (((pmd_raw(pmd_a) ^ pmd_raw(pmd_b)) & ~cpu_to_be64(_PAGE_HPTEFLAGS)) == 0);
 }
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index ceadc2fd408f..27b5e34abe24 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -89,6 +89,29 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
 }
 
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	if (radix_enabled())
+		return radix__pmd_trans_huge(pmd);
+	return hash__pmd_trans_huge(pmd);
+}
+
+#define __HAVE_ARCH_PMD_SAME
+static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
+{
+	if (radix_enabled())
+		return radix__pmd_same(pmd_a, pmd_b);
+	return hash__pmd_same(pmd_a, pmd_b);
+}
 #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
+
+static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
+			       unsigned long pfn, pgprot_t prot)
+{
+	if (radix_enabled())
+		BUG();
+	return hash__remap_4k_pfn(vma, addr, pfn, prot);
+
+}
 #endif	/* __ASSEMBLY__ */
 #endif /*_ASM_POWERPC_BOOK3S_64_PGTABLE_64K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 4b581a0ebc0a..db7e678e2bb6 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -121,5 +121,14 @@ static inline int radix__pgd_bad(pgd_t pgd)
 	return !!(pgd_val(pgd) & RADIX_PGD_BAD_BITS);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+
+static inline int radix__pmd_trans_huge(pmd_t pmd)
+{
+	return !!(pmd_val(pmd) & _PAGE_PTE);
+}
+
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif
-- 
2.5.0
