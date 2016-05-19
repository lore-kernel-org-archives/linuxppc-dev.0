Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9NkG1dY6zDqjc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:59:02 +1000 (AEST)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:28:59 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6730EE0065
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:32:09 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7wuiV32833614
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:56 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7wr2k006605
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:55 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 4/7] powerpc/mm/radix: Rename function and drop unused arg
Date: Thu, 19 May 2016 13:28:47 +0530
Message-Id: <1463644730-10946-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/tlbflush-radix.h | 10 +++++-----
 arch/powerpc/mm/hugetlbpage-radix.c                 |  4 ++--
 arch/powerpc/mm/tlb-radix.c                         | 16 ++++++++--------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 823528d34688..07b2e0031dad 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -20,18 +20,18 @@ extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end
 
 extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
 extern void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-extern void radix___local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
-				    unsigned long ap, int nid);
+extern void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
+					      unsigned long ap);
 extern void radix__tlb_flush(struct mmu_gather *tlb);
 #ifdef CONFIG_SMP
 extern void radix__flush_tlb_mm(struct mm_struct *mm);
 extern void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-extern void radix___flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
-			      unsigned long ap, int nid);
+extern void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
+					unsigned long ap);
 #else
 #define radix__flush_tlb_mm(mm)		radix__local_flush_tlb_mm(mm)
 #define radix__flush_tlb_page(vma,addr)	radix__local_flush_tlb_page(vma,addr)
-#define radix___flush_tlb_page(mm,addr,p,i)	radix___local_flush_tlb_page(mm,addr,p,i)
+#define radix__flush_tlb_page_psize(mm,addr,p) radix__local_flush_tlb_page_psize(mm,addr,p)
 #endif
 
 #endif
diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 1e11559e1aac..0dfa1816f0c6 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -20,7 +20,7 @@ void radix__flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 		WARN(1, "Wrong huge page shift\n");
 		return ;
 	}
-	radix___flush_tlb_page(vma->vm_mm, vmaddr, ap, 0);
+	radix__flush_tlb_page_psize(vma->vm_mm, vmaddr, ap);
 }
 
 void radix__local_flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
@@ -37,7 +37,7 @@ void radix__local_flush_hugetlb_page(struct vm_area_struct *vma, unsigned long v
 		WARN(1, "Wrong huge page shift\n");
 		return ;
 	}
-	radix___local_flush_tlb_page(vma->vm_mm, vmaddr, ap, 0);
+	radix__local_flush_tlb_page_psize(vma->vm_mm, vmaddr, ap);
 }
 
 /*
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index fe2fc58d2e00..b1dc4675925d 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -127,8 +127,8 @@ void radix__local_flush_tlb_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(radix__local_flush_tlb_mm);
 
-void radix___local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
-			    unsigned long ap, int nid)
+void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
+				       unsigned long ap)
 {
 	unsigned int pid;
 
@@ -146,8 +146,8 @@ void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmadd
 	if (vma && is_vm_hugetlb_page(vma))
 		return __local_flush_hugetlb_page(vma, vmaddr);
 #endif
-	radix___local_flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
-			       mmu_get_ap(mmu_virtual_psize), 0);
+	radix__local_flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
+					  mmu_get_ap(mmu_virtual_psize));
 }
 EXPORT_SYMBOL(radix__local_flush_tlb_page);
 
@@ -176,8 +176,8 @@ no_context:
 }
 EXPORT_SYMBOL(radix__flush_tlb_mm);
 
-void radix___flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
-		       unsigned long ap, int nid)
+void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
+				 unsigned long ap)
 {
 	unsigned int pid;
 
@@ -205,8 +205,8 @@ void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 	if (vma && is_vm_hugetlb_page(vma))
 		return flush_hugetlb_page(vma, vmaddr);
 #endif
-	radix___flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
-			 mmu_get_ap(mmu_virtual_psize), 0);
+	radix__flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
+				    mmu_get_ap(mmu_virtual_psize));
 }
 EXPORT_SYMBOL(radix__flush_tlb_page);
 
-- 
2.7.4
