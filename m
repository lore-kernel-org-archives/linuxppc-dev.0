Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 13B592C012C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 16:58:26 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 4 Apr 2013 11:24:08 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id EAA79394004F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 11:28:21 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r345wFkx5046598
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 11:28:16 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r345wJLl026883
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 05:58:20 GMT
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V5 19/25] powerpc/THP: Differentiate THP PMD entries from
 HUGETLB PMD entries
Date: Thu,  4 Apr 2013 11:27:57 +0530
Message-Id: <1365055083-31956-20-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

HUGETLB clear the top bit of PMD entries and use that to indicate
a HUGETLB page directory. Since we store pfns in PMDs for THP,
we would have the top bit cleared by default. Add the top bit mask
for THP PMD entries and clear that when we are looking for pmd_pfn.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable.h |   16 +++++++++++++---
 arch/powerpc/mm/pgtable.c          |    5 ++++-
 arch/powerpc/mm/pgtable_64.c       |    2 +-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 9fbe2a7..9681de4 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -31,7 +31,7 @@ struct mm_struct;
 #define PMD_HUGE_SPLITTING	0x008
 #define PMD_HUGE_SAO		0x010 /* strong Access order */
 #define PMD_HUGE_HASHPTE	0x020
-#define PMD_ISHUGE		0x040
+#define _PMD_ISHUGE		0x040
 #define PMD_HUGE_DIRTY		0x080 /* C: page changed */
 #define PMD_HUGE_ACCESSED	0x100 /* R: page referenced */
 #define PMD_HUGE_RW		0x200 /* software: user write access allowed */
@@ -44,6 +44,14 @@ struct mm_struct;
 #define PMD_HUGE_RPN_SHIFT	PTE_RPN_SHIFT
 #define HUGE_PAGE_SIZE		(ASM_CONST(1) << 24)
 #define HUGE_PAGE_MASK		(~(HUGE_PAGE_SIZE - 1))
+/*
+ * HugeTLB looks at the top bit of the Linux page table entries to
+ * decide whether it is a huge page directory or not. Mark HUGE
+ * PMD to differentiate
+ */
+#define PMD_HUGE_NOT_HUGETLB	(ASM_CONST(1) << 63)
+#define PMD_ISHUGE		(_PMD_ISHUGE | PMD_HUGE_NOT_HUGETLB)
+#define PMD_HUGE_PROTBITS	(0xfff | PMD_HUGE_NOT_HUGETLB)
 
 #ifndef __ASSEMBLY__
 extern void hpte_need_hugepage_flush(struct mm_struct *mm, unsigned long addr,
@@ -70,8 +78,9 @@ static inline int pmd_trans_splitting(pmd_t pmd)
 
 static inline int pmd_trans_huge(pmd_t pmd)
 {
-	return pmd_val(pmd) & PMD_ISHUGE;
+	return ((pmd_val(pmd) & PMD_ISHUGE) ==  PMD_ISHUGE);
 }
+
 /* We will enable it in the last patch */
 #define has_transparent_hugepage() 0
 #else
@@ -84,7 +93,8 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
 	/*
 	 * Only called for hugepage pmd
 	 */
-	return pmd_val(pmd) >> PMD_HUGE_RPN_SHIFT;
+	unsigned long val = pmd_val(pmd) & ~PMD_HUGE_PROTBITS;
+	return val  >> PMD_HUGE_RPN_SHIFT;
 }
 
 static inline int pmd_young(pmd_t pmd)
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 9f33780..cf3ca8e 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -517,7 +517,10 @@ static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot)
 pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
 {
 	pmd_t pmd;
-
+	/*
+	 * We cannot support that many PFNs
+	 */
+	VM_BUG_ON(pfn & PMD_HUGE_NOT_HUGETLB);
 	pmd_val(pmd) = pfn << PMD_HUGE_RPN_SHIFT;
 	pmd_val(pmd) |= PMD_ISHUGE;
 	pmd = pmd_set_protbits(pmd, pgprot);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 6fc3488..cd53020 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -345,7 +345,7 @@ EXPORT_SYMBOL(__iounmap_at);
 struct page *pmd_page(pmd_t pmd)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pmd_val(pmd) & PMD_ISHUGE)
+	if ((pmd_val(pmd) & PMD_ISHUGE) == PMD_ISHUGE)
 		return pfn_to_page(pmd_pfn(pmd));
 #endif
 	return virt_to_page(pmd_page_vaddr(pmd));
-- 
1.7.10
