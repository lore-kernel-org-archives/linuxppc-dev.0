Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrmV3mXSzDwpx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:44:10 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58EcwNM131645
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:44:08 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m3jueb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:44:08 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:44:07 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 10/16] powerpc/mm/radix: Rename function and drop unused arg
Date: Wed,  8 Jun 2016 20:13:17 +0530
In-Reply-To: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465397003-26812-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 54c0aac39e3e..00c354064280 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -20,20 +20,20 @@ extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end
 
 extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
 extern void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-extern void radix___local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
-				    unsigned long ap, int nid);
 extern void radix__local_flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
+extern void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
+					      unsigned long ap);
 extern void radix__tlb_flush(struct mmu_gather *tlb);
 #ifdef CONFIG_SMP
 extern void radix__flush_tlb_mm(struct mm_struct *mm);
 extern void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-extern void radix___flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
-			      unsigned long ap, int nid);
 extern void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
+extern void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
+					unsigned long ap);
 #else
 #define radix__flush_tlb_mm(mm)		radix__local_flush_tlb_mm(mm)
 #define radix__flush_tlb_page(vma,addr)	radix__local_flush_tlb_page(vma,addr)
-#define radix___flush_tlb_page(mm,addr,p,i)	radix___local_flush_tlb_page(mm,addr,p,i)
+#define radix__flush_tlb_page_psize(mm,addr,p) radix__local_flush_tlb_page_psize(mm,addr,p)
 #define radix__flush_tlb_pwc(tlb, addr)	radix__local_flush_tlb_pwc(tlb, addr)
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
index 4212e7638a6f..c33c3f24bad2 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -138,8 +138,8 @@ void radix__local_flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
 }
 EXPORT_SYMBOL(radix__local_flush_tlb_pwc);
 
-void radix___local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
-			    unsigned long ap, int nid)
+void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
+				       unsigned long ap)
 {
 	unsigned long pid;
 
@@ -157,8 +157,8 @@ void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmadd
 	if (vma && is_vm_hugetlb_page(vma))
 		return __local_flush_hugetlb_page(vma, vmaddr);
 #endif
-	radix___local_flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
-			       mmu_get_ap(mmu_virtual_psize), 0);
+	radix__local_flush_tlb_page_psize(vma ? vma->vm_mm : NULL, vmaddr,
+					  mmu_get_ap(mmu_virtual_psize));
 }
 EXPORT_SYMBOL(radix__local_flush_tlb_page);
 
@@ -212,8 +212,8 @@ no_context:
 }
 EXPORT_SYMBOL(radix__flush_tlb_pwc);
 
-void radix___flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
-		       unsigned long ap, int nid)
+void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
+				 unsigned long ap)
 {
 	unsigned long pid;
 
@@ -241,8 +241,8 @@ void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
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
