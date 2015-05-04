Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5196C1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 03:29:33 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 4 May 2015 22:59:30 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3CEDEE0056
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 23:02:19 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t44HTRH862586972
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 22:59:27 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t44HTQAL022252
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 22:59:26 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com
Subject: [RFC PATCH] mm/thp: Use new function to clear pmd before THP splitting
Date: Mon,  4 May 2015 22:59:16 +0530
Message-Id: <1430760556-28137-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Archs like ppc64 require pte_t * to remain stable in some code path.
They use local_irq_disable to prevent a parallel split. Generic code
clear pmd instead of marking it _PAGE_SPLITTING in code path
where we can afford to mark pmd none before splitting. Use a
variant of pmdp_splitting_clear_notify that arch can override.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |  4 ++++
 arch/powerpc/mm/pgtable_64.c             | 11 +++++++++++
 include/asm-generic/pgtable.h            |  4 ++++
 mm/huge_memory.c                         |  4 ++--
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 43e6ad424c7f..307e705cbead 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -576,6 +576,10 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 extern void pmdp_splitting_flush(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp);
 
+#define __HAVE_ARCH_PMDP_SPLITTING_CLEAR_NOTIFY
+extern void pmdp_splitting_clear_notify(struct vm_area_struct *vma,
+					unsigned long address, pmd_t *pmdp);
+
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
 extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				       pgtable_t pgtable);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 59daa5eeec25..c30b15894edf 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -36,6 +36,7 @@
 #include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
+#include <linux/mmu_notifier.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -598,6 +599,16 @@ pmd_t pmdp_clear_flush(struct vm_area_struct *vma, unsigned long address,
 	return pmd;
 }
 
+void pmdp_splitting_clear_notify(struct vm_area_struct *vma,
+				 unsigned long address, pmd_t *pmdp)
+{
+	pmdp_clear_flush_notify(vma, address, pmdp);
+	/*
+	 * Serialize against find_linux_pte_or_hugepte
+	 */
+	kick_all_cpus_sync();
+}
+
 int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long address, pmd_t *pmdp)
 {
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 39f1d6a2b04d..83ed56c8594a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -189,6 +189,10 @@ extern void pmdp_splitting_flush(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp);
 #endif
 
+#ifndef __HAVE_ARCH_PMDP_SPLITTING_CLEAR_NOTIFY
+#define pmdp_splitting_clear_notify pmdp_clear_flush_notify
+#endif
+
 #ifndef __HAVE_ARCH_PGTABLE_DEPOSIT
 extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				       pgtable_t pgtable);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 078832cf3636..f596312980f9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1031,7 +1031,7 @@ static int do_huge_pmd_wp_page_fallback(struct mm_struct *mm,
 		goto out_free_pages;
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 
-	pmdp_clear_flush_notify(vma, haddr, pmd);
+	pmdp_splitting_clear_notify(vma, haddr, pmd);
 	/* leave pmd empty until pte is filled */
 
 	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
@@ -2865,7 +2865,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	pmd_t _pmd;
 	int i;
 
-	pmdp_clear_flush_notify(vma, haddr, pmd);
+	pmdp_splitting_clear_notify(vma, haddr, pmd);
 	/* leave pmd empty until pte is filled */
 
 	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
-- 
2.1.4
