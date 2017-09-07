Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp3Mv6wFDzDrXG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 00:52:43 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id q76so4607007pfq.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 07:52:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: [RFC PATCH 8/8] powerpc/64s/radix: Only flush local TLB for spurious
 fault flushes
Date: Fri,  8 Sep 2017 00:51:48 +1000
Message-Id: <20170907145148.24398-9-npiggin@gmail.com>
In-Reply-To: <20170907145148.24398-1-npiggin@gmail.com>
References: <20170907145148.24398-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When permissiveness is relaxed, or found to have been relaxed by
another thread, we flush that address out of the TLB to avoid a
future fault or micro-fault due to a stale TLB entry.

Currently for processes with TLBs on other CPUs, this flush is always
done with a global tlbie. Although that could reduce faults on remote
CPUs, a broadcast operation seems to be wasteful for something that
can be handled in-core by the remote CPU if it comes to it.

This is not benchmarked yet. It does seem cut some tlbie operations
from the bus.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  5 ++++
 arch/powerpc/include/asm/book3s/64/tlbflush.h      | 11 +++++++++
 arch/powerpc/mm/pgtable-book3s64.c                 |  5 +++-
 arch/powerpc/mm/pgtable.c                          |  2 +-
 arch/powerpc/mm/tlb-radix.c                        | 27 ++++++++++++++++++++++
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index b12460b306a7..34cd864b8fc1 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -16,6 +16,8 @@ extern bool radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long sta
 					 unsigned long end, int psize);
 extern void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
 				       unsigned long start, unsigned long end);
+extern void radix__local_flush_pmd_tlb_range(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end);
 extern void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end);
@@ -24,6 +26,9 @@ extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
 extern void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void radix__local_flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 					      int psize);
+extern void radix__local_flush_tlb_range_psize(struct mm_struct *mm,
+				unsigned long start, unsigned long end,
+				int psize);
 extern void radix__tlb_flush(struct mmu_gather *tlb);
 #ifdef CONFIG_SMP
 extern void radix__flush_tlb_mm(struct mm_struct *mm);
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 72b925f97bab..8a8b3e11a28e 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -83,6 +83,17 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 #define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
 #define flush_tlb_page(vma, addr)	local_flush_tlb_page(vma, addr)
 #endif /* CONFIG_SMP */
+
+#define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
+static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
+						unsigned long address)
+{
+	if (radix_enabled())
+		radix__local_flush_tlb_page(vma, address);
+	else
+		flush_tlb_page(vma, address);
+}
+
 /*
  * flush the page walk cache for the address
  */
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 3b65917785a5..e46f346388d6 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -40,7 +40,10 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	if (changed) {
 		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp),
 					pmd_pte(entry), address);
-		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+		if (radix_enabled())
+			radix__local_flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+		else
+			flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	}
 	return changed;
 }
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index a03ff3d99e0c..acd6ae8062ce 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -223,7 +223,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 		if (!is_vm_hugetlb_page(vma))
 			assert_pte_locked(vma->vm_mm, address);
 		__ptep_set_access_flags(vma->vm_mm, ptep, entry, address);
-		flush_tlb_page(vma, address);
+		flush_tlb_fix_spurious_fault(vma, address);
 	}
 	return changed;
 }
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 7452e1f4aa3c..bcb41d037593 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -396,6 +396,27 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 static unsigned long tlb_local_single_page_flush_ceiling __read_mostly = POWER9_TLB_SETS_RADIX * 2;
 
+void radix__local_flush_tlb_range_psize(struct mm_struct *mm,
+				unsigned long start, unsigned long end,
+				int psize)
+{
+	unsigned long pid;
+	unsigned int page_shift = mmu_psize_defs[psize].shift;
+	unsigned long page_size = 1UL << page_shift;
+
+	pid = mm ? mm->context.id : 0;
+	if (unlikely(pid == MMU_NO_CONTEXT))
+		return;
+
+	preempt_disable();
+	if (end == TLB_FLUSH_ALL || ((end - start) >> page_shift) >
+				tlb_local_single_page_flush_ceiling)
+		_tlbiel_pid(pid, RIC_FLUSH_TLB);
+	else
+		_tlbiel_va_range(start, end, pid, page_size, psize);
+	preempt_enable();
+}
+
 static bool __radix__flush_tlb_range_psize(struct mm_struct *mm,
 				unsigned long start, unsigned long end,
 				int psize, bool also_pwc)
@@ -518,6 +539,12 @@ void radix__flush_tlb_lpid(unsigned long lpid)
 }
 EXPORT_SYMBOL(radix__flush_tlb_lpid);
 
+void radix__local_flush_pmd_tlb_range(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
+{
+	radix__local_flush_tlb_range_psize(vma->vm_mm, start, end, MMU_PAGE_2M);
+}
+
 void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
 				unsigned long start, unsigned long end)
 {
-- 
2.13.3
