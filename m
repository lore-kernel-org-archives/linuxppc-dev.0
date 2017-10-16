Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFqHM71RMzDrFw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 18:11:11 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9G6x11O028312
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 03:11:09 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dm79ud4y9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 03:11:09 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 16 Oct 2017 03:11:08 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/radix: Drop unneeded NULL check
Date: Mon, 16 Oct 2017 12:41:00 +0530
Message-Id: <20171016071100.8497-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>

We call these functions with non-NULL mm or vma. Hence we can skip the NULL
check in these functions. We also remove now unused function
__local_flush_hugetlb_page().

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hugetlb.h |  6 ------
 arch/powerpc/mm/tlb-radix.c        | 18 ++++++++----------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index b8a0fb442c64..795d825c2edd 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -40,12 +40,6 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 		return radix__flush_hugetlb_page(vma, vmaddr);
 }
 
-static inline void __local_flush_hugetlb_page(struct vm_area_struct *vma,
-					      unsigned long vmaddr)
-{
-	if (radix_enabled())
-		return radix__local_flush_hugetlb_page(vma, vmaddr);
-}
 #else
 
 static inline pte_t *hugepd_page(hugepd_t hpd)
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 191cc5abc940..98fdf2243d35 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -164,7 +164,7 @@ void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmadd
 	unsigned long ap = mmu_get_ap(psize);
 
 	preempt_disable();
-	pid = mm ? mm->context.id : 0;
+	pid = mm->context.id;
 	if (pid != MMU_NO_CONTEXT)
 		_tlbiel_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
 	preempt_enable();
@@ -175,10 +175,9 @@ void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmadd
 #ifdef CONFIG_HUGETLB_PAGE
 	/* need the return fix for nohash.c */
 	if (vma && is_vm_hugetlb_page(vma))
-		return __local_flush_hugetlb_page(vma, vmaddr);
+		return radix__local_flush_hugetlb_page(vma, vmaddr);
 #endif
-	radix__local_flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
-					  mmu_virtual_psize);
+	radix__local_flush_tlb_page_psize(vma->vm_mm, vmaddr, mmu_virtual_psize);
 }
 EXPORT_SYMBOL(radix__local_flush_tlb_page);
 
@@ -232,7 +231,7 @@ void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 	unsigned long ap = mmu_get_ap(psize);
 
 	preempt_disable();
-	pid = mm ? mm->context.id : 0;
+	pid = mm->context.id;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto bail;
 	if (!mm_is_thread_local(mm))
@@ -247,10 +246,9 @@ void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
 #ifdef CONFIG_HUGETLB_PAGE
 	if (vma && is_vm_hugetlb_page(vma))
-		return flush_hugetlb_page(vma, vmaddr);
+		return radix__flush_hugetlb_page(vma, vmaddr);
 #endif
-	radix__flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
-				    mmu_virtual_psize);
+	radix__flush_tlb_page_psize(vma->vm_mm, vmaddr, mmu_virtual_psize);
 }
 EXPORT_SYMBOL(radix__flush_tlb_page);
 
@@ -330,7 +328,7 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 
 
 	preempt_disable();
-	pid = mm ? mm->context.id : 0;
+	pid = mm->context.id;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto err_out;
 
@@ -361,7 +359,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 	unsigned long pid, end;
 
 
-	pid = mm ? mm->context.id : 0;
+	pid = mm->context.id;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto no_context;
 
-- 
2.13.6
