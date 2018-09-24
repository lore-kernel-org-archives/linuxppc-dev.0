Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JdbX24C2zF3DK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 19:05:59 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8O95sqd022604
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 05:05:58 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mpua6m2u4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 05:05:57 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 24 Sep 2018 03:05:14 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 5/5] arch/powerpc/mm/hugetlb: NestMMU workaround for
 hugetlb mprotect RW upgrade
Date: Mon, 24 Sep 2018 14:34:18 +0530
In-Reply-To: <20180924090418.31282-1-aneesh.kumar@linux.ibm.com>
References: <20180924090418.31282-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180924090418.31282-6-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NestMMU requires us to mark the pte invalid and flush the tlb when we do a
RW upgrade of pte. We fixed a variant of this in the fault path in commit
Fixes: bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h |  8 +++++
 arch/powerpc/include/asm/hugetlb.h           |  2 +-
 arch/powerpc/mm/hugetlbpage.c                | 35 ++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 50888388a359..45a94885c1fa 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -39,4 +39,12 @@ static inline bool gigantic_page_supported(void)
 }
 #endif
 
+#define huge_ptep_modify_prot_start huge_ptep_modify_prot_start
+extern pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep);
+
+#define huge_ptep_modify_prot_commit huge_ptep_modify_prot_commit
+extern void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep,
+					 pte_t old_pte, pte_t new_pte);
 #endif
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 2d00cc530083..60c1d37e446a 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -4,7 +4,6 @@
 
 #ifdef CONFIG_HUGETLB_PAGE
 #include <asm/page.h>
-#include <asm-generic/hugetlb.h>
 
 extern struct kmem_cache *hugepte_cache;
 
@@ -176,6 +175,7 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
 
+#include <asm-generic/hugetlb.h>
 #else /* ! CONFIG_HUGETLB_PAGE */
 static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 				      unsigned long vmaddr)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index e87f9ef9115b..8c7ee22c2ac7 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -906,3 +906,38 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 
 	return 1;
 }
+
+#ifdef CONFIG_PPC_BOOK3S_64
+pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
+				  unsigned long addr, pte_t *ptep)
+{
+	unsigned long pte_val;
+	/*
+	 * Clear the _PAGE_PRESENT so that no hardware parallel update is
+	 * possible. Also keep the pte_present true so that we don't take
+	 * wrong fault.
+	 */
+	pte_val = pte_update(vma->vm_mm, addr, ptep,
+			     _PAGE_PRESENT, _PAGE_INVALID, 1);
+
+	return __pte(pte_val);
+}
+EXPORT_SYMBOL(huge_ptep_modify_prot_start);
+
+void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
+				  pte_t *ptep, pte_t old_pte, pte_t pte)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	/*
+	 * To avoid NMMU hang while relaxing access we need to flush the tlb before
+	 * we set the new value.
+	 */
+	if (is_pte_upgrade(pte_val(old_pte), pte_val(pte)) &&
+	    (atomic_read(&mm->context.copros) > 0))
+		flush_hugetlb_page(vma, addr);
+
+	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+}
+EXPORT_SYMBOL(huge_ptep_modify_prot_commit);
+#endif
-- 
2.17.1
