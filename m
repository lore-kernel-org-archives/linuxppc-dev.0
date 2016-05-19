Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9NkG4wTDzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:59:02 +1000 (AEST)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:29:00 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 62CC8125805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:31:10 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7wunK50856114
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:56 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7wsnR006638
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:56 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 6/7] powerpc/mm/hugetlb: Add flush_hugetlb_tlb_range
Date: Thu, 19 May 2016 13:28:49 +0530
Message-Id: <1463644730-10946-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 68839e6adcf1..73953a44d4e3 100644
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
index f0d6c9d38916..3b3e5e944af7 100644
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
index 19d0d08b396f..076a57ee8790 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3893,6 +3893,14 @@ same_page:
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
@@ -3953,7 +3961,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
