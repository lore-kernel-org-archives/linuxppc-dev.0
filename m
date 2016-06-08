Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrmY4pFZzDt2T
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:44:13 +1000 (AEST)
Received: from pps.filterd (m0048817.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58Ed0fO038503
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:44:11 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9mfamge-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:44:11 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:44:10 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 11/16] powerpc/mm/radix/hugetlb: Add helper for finding
 page size from hstate
Date: Wed,  8 Jun 2016 20:13:18 +0530
In-Reply-To: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465397003-26812-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 00c354064280..efb13bbc6df2 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -22,14 +22,14 @@ extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
 extern void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void radix__local_flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
 extern void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
-					      unsigned long ap);
+					      int psize);
 extern void radix__tlb_flush(struct mmu_gather *tlb);
 #ifdef CONFIG_SMP
 extern void radix__flush_tlb_mm(struct mm_struct *mm);
 extern void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
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
index c33c3f24bad2..a32d8aab2376 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -139,9 +139,10 @@ void radix__local_flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
 EXPORT_SYMBOL(radix__local_flush_tlb_pwc);
 
 void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
-				       unsigned long ap)
+				       int psize)
 {
 	unsigned long pid;
+	unsigned long ap = mmu_get_ap(psize);
 
 	preempt_disable();
 	pid = mm ? mm->context.id : 0;
@@ -158,7 +159,7 @@ void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmadd
 		return __local_flush_hugetlb_page(vma, vmaddr);
 #endif
 	radix__local_flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
-					  mmu_get_ap(mmu_virtual_psize));
+					  mmu_virtual_psize);
 }
 EXPORT_SYMBOL(radix__local_flush_tlb_page);
 
@@ -213,9 +214,10 @@ no_context:
 EXPORT_SYMBOL(radix__flush_tlb_pwc);
 
 void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
-				 unsigned long ap)
+				 int psize)
 {
 	unsigned long pid;
+	unsigned long ap = mmu_get_ap(psize);
 
 	preempt_disable();
 	pid = mm ? mm->context.id : 0;
@@ -242,7 +244,7 @@ void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 		return flush_hugetlb_page(vma, vmaddr);
 #endif
 	radix__flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
-				    mmu_get_ap(mmu_virtual_psize));
+				    mmu_virtual_psize);
 }
 EXPORT_SYMBOL(radix__flush_tlb_page);
 
-- 
2.7.4
