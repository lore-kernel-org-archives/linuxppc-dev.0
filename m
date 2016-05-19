Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9NkG1HGCzDqZj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:59:01 +1000 (AEST)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:28:59 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 21042E0064
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:32:09 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7wtkV28377158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:55 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7wrCj006599
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:54 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 3/7] powerpc/mm/radix: Add tlb flush of THP ptes
Date: Thu, 19 May 2016 13:28:46 +0530
Message-Id: <1463644730-10946-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Instead of flushing the entire mm, implement a flush_pmd_tlb_range

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  4 ++
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |  9 ++++
 arch/powerpc/mm/pgtable-book3s64.c                 |  4 +-
 arch/powerpc/mm/tlb-radix.c                        | 54 ++++++++++++++++++++++
 4 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 13ef38828dfe..823528d34688 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -10,6 +10,10 @@ static inline int mmu_get_ap(int psize)
 	return mmu_psize_defs[psize].ap;
 }
 
+extern void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
+					 unsigned long end, int psize);
+extern void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
+				       unsigned long start, unsigned long end);
 extern void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end);
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index d98424ae356c..f0d6c9d38916 100644
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
index 5807f5d72e1b..fe2fc58d2e00 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -243,3 +243,57 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	struct mm_struct *mm = tlb->mm;
 	radix__flush_tlb_mm(mm);
 }
+
+#define TLB_FLUSH_ALL -1UL
+/*
+ * Number of pages above which we will do a bcast tlbie. Just a
+ * number at this point copied from x86
+ */
+static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
+
+void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
+				  unsigned long end, int psize)
+{
+	unsigned int pid;
+	unsigned long addr;
+	int local = mm_is_core_local(mm);
+	unsigned long ap = mmu_get_ap(psize);
+	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
+	unsigned long page_size = 1UL << mmu_psize_defs[psize].shift;
+
+
+	preempt_disable();
+	pid = mm ? mm->context.id : 0;
+	if (unlikely(pid == MMU_NO_CONTEXT))
+		goto err_out;
+
+	if (end == TLB_FLUSH_ALL ||
+	    (end - start) > tlb_single_page_flush_ceiling * page_size) {
+		if (local)
+			_tlbiel_pid(pid);
+		else
+			_tlbie_pid(pid);
+		goto err_out;
+	}
+	for (addr = start; addr < end; addr += page_size) {
+
+		if (local)
+			_tlbiel_va(addr, pid, ap);
+		else {
+			if (lock_tlbie)
+				raw_spin_lock(&native_tlbie_lock);
+			_tlbie_va(addr, pid, ap);
+			if (lock_tlbie)
+				raw_spin_unlock(&native_tlbie_lock);
+		}
+	}
+err_out:
+	preempt_enable();
+}
+
+void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
+{
+	radix__flush_tlb_range_psize(vma->vm_mm, start, end, MMU_PAGE_2M);
+}
+EXPORT_SYMBOL(radix__flush_pmd_tlb_range);
-- 
2.7.4
