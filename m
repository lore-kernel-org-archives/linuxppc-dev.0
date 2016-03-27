Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqqJ2wtkzDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:32 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:25:30 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0DCB43E40030
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:29 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u2R8PTEX31719532
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:25:29 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8PSY4028107
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:28 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 28/65] powerpc/mm/radix: Add radix callback for pmd accessors
Date: Sun, 27 Mar 2016 13:53:36 +0530
Message-Id: <1459067053-10835-28-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This only does 64k linux page support for now. 64k hash linux config
THP need to differentiate it from hugetlb huge page because with THP
we need to track hash pte slot information with respect to each subpage.
This is not needed with hugetlb hugepage, because we don't do MPSS with
hugetlb.

Radix doesn't have any such restrictions.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h    |  9 ++++-----
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 23 +++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/radix.h       |  9 +++++++++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 173f35e9faef..ad797a8cc615 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -97,8 +97,8 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
 
 extern int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			   unsigned long pfn, unsigned long size, pgprot_t);
-static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
-			       unsigned long pfn, pgprot_t prot)
+static inline int hlremap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
+				 unsigned long pfn, pgprot_t prot)
 {
 	if (pfn > (PTE_RPN_MASK >> PAGE_SHIFT)) {
 		WARN(1, "remap_4k_pfn called with wrong pfn value\n");
@@ -182,14 +182,13 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
  * that for explicit huge pages.
  *
  */
-static inline int pmd_trans_huge(pmd_t pmd)
+static inline int hlpmd_trans_huge(pmd_t pmd)
 {
 	return !!((pmd_val(pmd) & (_PAGE_PTE | H_PAGE_THP_HUGE)) ==
 		  (_PAGE_PTE | H_PAGE_THP_HUGE));
 }
 
-#define __HAVE_ARCH_PMD_SAME
-static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
+static inline int hlpmd_same(pmd_t pmd_a, pmd_t pmd_b)
 {
 	return (((pmd_val(pmd_a) ^ pmd_val(pmd_b)) & ~_PAGE_HPTEFLAGS) == 0);
 }
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index ceadc2fd408f..028b8f6e002b 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -89,6 +89,29 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
 }
 
+static inline int pmd_trans_huge(pmd_t pmd)
+{
+	if (radix_enabled())
+		return rpmd_trans_huge(pmd);
+	return hlpmd_trans_huge(pmd);
+}
+
+#define __HAVE_ARCH_PMD_SAME
+static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
+{
+	if (radix_enabled())
+		return rpmd_same(pmd_a, pmd_b);
+	return hlpmd_same(pmd_a, pmd_b);
+}
 #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
+
+static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
+			       unsigned long pfn, pgprot_t prot)
+{
+	if (radix_enabled())
+		BUG();
+	return hlremap_4k_pfn(vma, addr, pfn, prot);
+
+}
 #endif	/* __ASSEMBLY__ */
 #endif /*_ASM_POWERPC_BOOK3S_64_PGTABLE_64K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 72e18d5c96b4..46a5381324f5 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -124,5 +124,14 @@ static inline int rpgd_bad(pgd_t pgd)
 	return !!(pgd_val(pgd) & R_PGD_BAD_BITS);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+
+static inline int rpmd_trans_huge(pmd_t pmd)
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
