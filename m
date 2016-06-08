Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrmQ4TJ7zDwsL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:44:06 +1000 (AEST)
Received: from pps.filterd (m0082756.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58Ed5Pk046370
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:44:05 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9mf2sby-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:44:05 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:44:04 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 09/16] powerpc/mm/radix: Add tlb flush of THP ptes
Date: Wed,  8 Jun 2016 20:13:16 +0530
In-Reply-To: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465397003-26812-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of flushing the entire mm, implement a flush_pmd_tlb_range

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/tlbflush-radix.h | 2 ++
 arch/powerpc/include/asm/book3s/64/tlbflush.h       | 9 +++++++++
 arch/powerpc/mm/pgtable-book3s64.c                  | 4 ++--
 arch/powerpc/mm/tlb-radix.c                         | 7 +++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 862c8fa50268..54c0aac39e3e 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -12,6 +12,8 @@ static inline int mmu_get_ap(int psize)
 
 extern void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 					 unsigned long end, int psize);
+extern void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
+				       unsigned long start, unsigned long end);
 extern void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end);
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 541cf809e38e..5f322e0ed385 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -7,6 +7,15 @@
 #include <asm/book3s/64/tlbflush-hash.h>
 #include <asm/book3s/64/tlbflush-radix.h>
 
+#define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
+static inline void flush_pmd_tlb_range(struct vm_area_struct *vma,
+				       unsigned long start, unsigned long end)
+{
+	if (radix_enabled())
+		return radix__flush_pmd_tlb_range(vma, start, end);
+	return hash__flush_tlb_range(vma, start, end);
+}
+
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 670318766545..7bb8acffe876 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -33,7 +33,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	changed = !pmd_same(*(pmdp), entry);
 	if (changed) {
 		__ptep_set_access_flags(pmdp_ptep(pmdp), pmd_pte(entry));
-		flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	}
 	return changed;
 }
@@ -66,7 +66,7 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
 	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
-	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	/*
 	 * This ensures that generic code that rely on IRQ disabling
 	 * to prevent a parallel THP split work as expected.
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 74b0c90045ab..4212e7638a6f 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -350,3 +350,10 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 err_out:
 	preempt_enable();
 }
+
+void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
+{
+	radix__flush_tlb_range_psize(vma->vm_mm, start, end, MMU_PAGE_2M);
+}
+EXPORT_SYMBOL(radix__flush_pmd_tlb_range);
-- 
2.7.4
