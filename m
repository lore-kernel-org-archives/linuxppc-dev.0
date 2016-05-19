Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9NkG423RzDqdp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:59:02 +1000 (AEST)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:29:00 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DA00D3940069
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:56 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7wucu8716354
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:56 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7wss5006620
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:56 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 5/7] powerpc/mm/radix/hugetlb: Add helper for finding page
 size from hstate
Date: Thu, 19 May 2016 13:28:48 +0530
Message-Id: <1463644730-10946-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1463644730-10946-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1463644730-10946-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the helper instead of open coding the same at multiple place

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hugetlb-radix.h | 15 +++++++++++
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  4 +--
 arch/powerpc/mm/hugetlbpage-radix.c                | 29 ++++++----------------
 arch/powerpc/mm/tlb-radix.c                        | 10 +++++---
 4 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h b/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
index 60f47649306f..c45189aa7476 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
@@ -11,4 +11,19 @@ extern unsigned long
 radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 				unsigned long len, unsigned long pgoff,
 				unsigned long flags);
+
+static inline int hstate_get_psize(struct hstate *hstate)
+{
+	unsigned long shift;
+
+	shift = huge_page_shift(hstate);
+	if (shift == mmu_psize_defs[MMU_PAGE_2M].shift)
+		return MMU_PAGE_2M;
+	else if (shift == mmu_psize_defs[MMU_PAGE_1G].shift)
+		return MMU_PAGE_1G;
+	else {
+		WARN(1, "Wrong huge page shift\n");
+		return mmu_virtual_psize;
+	}
+}
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 07b2e0031dad..68839e6adcf1 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -21,13 +21,13 @@ extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end
 extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
 extern void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
-					      unsigned long ap);
+					      int psize);
 extern void radix__tlb_flush(struct mmu_gather *tlb);
 #ifdef CONFIG_SMP
 extern void radix__flush_tlb_mm(struct mm_struct *mm);
 extern void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
-					unsigned long ap);
+					int psize);
 #else
 #define radix__flush_tlb_mm(mm)		radix__local_flush_tlb_mm(mm)
 #define radix__flush_tlb_page(vma,addr)	radix__local_flush_tlb_page(vma,addr)
diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 0dfa1816f0c6..1eca0deaf89b 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -5,39 +5,24 @@
 #include <asm/cacheflush.h>
 #include <asm/machdep.h>
 #include <asm/mman.h>
+#include <asm/tlb.h>
 
 void radix__flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
-	unsigned long ap, shift;
+	int psize;
 	struct hstate *hstate = hstate_file(vma->vm_file);
 
-	shift = huge_page_shift(hstate);
-	if (shift == mmu_psize_defs[MMU_PAGE_2M].shift)
-		ap = mmu_get_ap(MMU_PAGE_2M);
-	else if (shift == mmu_psize_defs[MMU_PAGE_1G].shift)
-		ap = mmu_get_ap(MMU_PAGE_1G);
-	else {
-		WARN(1, "Wrong huge page shift\n");
-		return ;
-	}
-	radix__flush_tlb_page_psize(vma->vm_mm, vmaddr, ap);
+	psize = hstate_get_psize(hstate);
+	radix__flush_tlb_page_psize(vma->vm_mm, vmaddr, psize);
 }
 
 void radix__local_flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
-	unsigned long ap, shift;
+	int psize;
 	struct hstate *hstate = hstate_file(vma->vm_file);
 
-	shift = huge_page_shift(hstate);
-	if (shift == mmu_psize_defs[MMU_PAGE_2M].shift)
-		ap = mmu_get_ap(MMU_PAGE_2M);
-	else if (shift == mmu_psize_defs[MMU_PAGE_1G].shift)
-		ap = mmu_get_ap(MMU_PAGE_1G);
-	else {
-		WARN(1, "Wrong huge page shift\n");
-		return ;
-	}
-	radix__local_flush_tlb_page_psize(vma->vm_mm, vmaddr, ap);
+	psize = hstate_get_psize(hstate);
+	radix__local_flush_tlb_page_psize(vma->vm_mm, vmaddr, psize);
 }
 
 /*
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index b1dc4675925d..7bc3d1402c63 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -128,9 +128,10 @@ void radix__local_flush_tlb_mm(struct mm_struct *mm)
 EXPORT_SYMBOL(radix__local_flush_tlb_mm);
 
 void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
-				       unsigned long ap)
+				       int psize)
 {
 	unsigned int pid;
+	unsigned long ap = mmu_get_ap(psize);
 
 	preempt_disable();
 	pid = mm ? mm->context.id : 0;
@@ -147,7 +148,7 @@ void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmadd
 		return __local_flush_hugetlb_page(vma, vmaddr);
 #endif
 	radix__local_flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
-					  mmu_get_ap(mmu_virtual_psize));
+					  mmu_virtual_psize);
 }
 EXPORT_SYMBOL(radix__local_flush_tlb_page);
 
@@ -177,9 +178,10 @@ no_context:
 EXPORT_SYMBOL(radix__flush_tlb_mm);
 
 void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
-				 unsigned long ap)
+				 int psize)
 {
 	unsigned int pid;
+	unsigned long ap = mmu_get_ap(psize);
 
 	preempt_disable();
 	pid = mm ? mm->context.id : 0;
@@ -206,7 +208,7 @@ void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 		return flush_hugetlb_page(vma, vmaddr);
 #endif
 	radix__flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
-				    mmu_get_ap(mmu_virtual_psize));
+				    mmu_virtual_psize);
 }
 EXPORT_SYMBOL(radix__flush_tlb_page);
 
-- 
2.7.4
