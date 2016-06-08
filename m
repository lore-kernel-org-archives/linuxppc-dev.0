Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrmc6bLdzDt2T
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:44:16 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58Ecxfh135844
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:44:15 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m3tv0r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:44:15 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:44:14 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 12/16] powerpc/mm/hugetlb: Add flush_hugetlb_tlb_range
Date: Wed,  8 Jun 2016 20:13:19 +0530
In-Reply-To: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465397003-26812-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some archs like ppc64 need to do special things when flushing tlb for
hugepage. Add a new helper to flush hugetlb tlb range. This helps us to
avoid flushing the entire tlb mapping for the pid.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/tlbflush-radix.h |  2 ++
 arch/powerpc/include/asm/book3s/64/tlbflush.h       | 10 ++++++++++
 arch/powerpc/mm/hugetlbpage-radix.c                 | 10 ++++++++++
 mm/hugetlb.c                                        | 10 +++++++++-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index efb13bbc6df2..91178f0f5ad8 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -10,6 +10,8 @@ static inline int mmu_get_ap(int psize)
 	return mmu_psize_defs[psize].ap;
 }
 
+extern void radix__flush_hugetlb_tlb_range(struct vm_area_struct *vma,
+					   unsigned long start, unsigned long end);
 extern void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 					 unsigned long end, int psize);
 extern void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 5f322e0ed385..02cd7def893d 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -16,6 +16,16 @@ static inline void flush_pmd_tlb_range(struct vm_area_struct *vma,
 	return hash__flush_tlb_range(vma, start, end);
 }
 
+#define __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
+static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
+					   unsigned long start,
+					   unsigned long end)
+{
+	if (radix_enabled())
+		return radix__flush_hugetlb_tlb_range(vma, start, end);
+	return hash__flush_tlb_range(vma, start, end);
+}
+
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 1eca0deaf89b..35254a678456 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -25,6 +25,16 @@ void radix__local_flush_hugetlb_page(struct vm_area_struct *vma, unsigned long v
 	radix__local_flush_tlb_page_psize(vma->vm_mm, vmaddr, psize);
 }
 
+void radix__flush_hugetlb_tlb_range(struct vm_area_struct *vma, unsigned long start,
+				   unsigned long end)
+{
+	int psize;
+	struct hstate *hstate = hstate_file(vma->vm_file);
+
+	psize = hstate_get_psize(hstate);
+	radix__flush_tlb_range_psize(vma->vm_mm, start, end, psize);
+}
+
 /*
  * A vairant of hugetlb_get_unmapped_area doing topdown search
  * FIXME!! should we do as x86 does or non hugetlb area does ?
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cab0b1861670..3495c519583d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3897,6 +3897,14 @@ same_page:
 	return i ? i : -EFAULT;
 }
 
+#ifndef __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
+/*
+ * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
+ * implement this.
+ */
+#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
+#endif
+
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
@@ -3957,7 +3965,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * once we release i_mmap_rwsem, another task can do the final put_page
 	 * and that page table be reused and filled with junk.
 	 */
-	flush_tlb_range(vma, start, end);
+	flush_hugetlb_tlb_range(vma, start, end);
 	mmu_notifier_invalidate_range(mm, start, end);
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
 	mmu_notifier_invalidate_range_end(mm, start, end);
-- 
2.7.4
