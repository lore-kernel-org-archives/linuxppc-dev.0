Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yR2lF6DfPzDqwZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 18:18:49 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i5so13084181pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 00:18:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 7/7] powerpc/64s/radix: Only flush local TLB for spurious
 fault flushes
Date: Tue, 31 Oct 2017 18:18:28 +1100
Message-Id: <20171031071828.28448-2-npiggin@gmail.com>
In-Reply-To: <20171031071828.28448-1-npiggin@gmail.com>
References: <20171031064432.25190-1-npiggin@gmail.com>
 <20171031071828.28448-1-npiggin@gmail.com>
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

XXX: This still needs some consideration with accelerators, not for
merge yet
---
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  5 +++
 arch/powerpc/include/asm/book3s/64/tlbflush.h      | 11 ++++++
 arch/powerpc/mm/pgtable-book3s64.c                 |  5 ++-
 arch/powerpc/mm/pgtable.c                          |  2 +-
 arch/powerpc/mm/tlb-radix.c                        | 40 +++++++++++++++++++---
 5 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index af06c6fe8a9f..f1851eb64026 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -16,6 +16,8 @@ extern void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long sta
 					 unsigned long end, int psize);
 extern void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
 				       unsigned long start, unsigned long end);
+extern void radix__local_flush_pmd_tlb_range(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end);
 extern void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end);
@@ -25,6 +27,9 @@ extern void radix__local_flush_all_mm(struct mm_struct *mm);
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
index 70760d018bcd..accfb49247a4 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -98,6 +98,17 @@ static inline void flush_all_mm(struct mm_struct *mm)
 #define flush_tlb_page(vma, addr)	local_flush_tlb_page(vma, addr)
 #define flush_all_mm(mm)		local_flush_all_mm(mm)
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
index db7e696e4faf..2aca596e3853 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -410,16 +410,18 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 		asm volatile("ptesync": : :"memory");
 		if (local) {
-			__tlbiel_va_range(start, end, pid, page_size, mmu_virtual_psize);
+			__tlbiel_va_range(start, end, pid, page_size,
+						mmu_virtual_psize);
 			if (hflush)
 				__tlbiel_va_range(hstart, hend, pid,
-						HPAGE_PMD_SIZE, MMU_PAGE_2M);
+					HPAGE_PMD_SIZE, MMU_PAGE_2M);
 			asm volatile("ptesync": : :"memory");
 		} else {
-			__tlbie_va_range(start, end, pid, page_size, mmu_virtual_psize);
+			__tlbie_va_range(start, end, pid, page_size,
+						mmu_virtual_psize);
 			if (hflush)
 				__tlbie_va_range(hstart, hend, pid,
-						HPAGE_PMD_SIZE, MMU_PAGE_2M);
+					HPAGE_PMD_SIZE, MMU_PAGE_2M);
 			asm volatile("eieio; tlbsync; ptesync": : :"memory");
 		}
 	}
@@ -477,6 +479,30 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	tlb->need_flush_all = 0;
 }
 
+void radix__local_flush_tlb_range_psize(struct mm_struct *mm,
+				unsigned long start, unsigned long end,
+				int psize)
+{
+	unsigned long pid;
+	unsigned int page_shift = mmu_psize_defs[psize].shift;
+	unsigned long page_size = 1UL << page_shift;
+	unsigned long nr_pages = (end - start) >> page_shift;
+	bool full;
+
+	pid = mm->context.id;
+	if (unlikely(pid == MMU_NO_CONTEXT))
+		return;
+
+	preempt_disable();
+	full = (end == TLB_FLUSH_ALL ||
+			nr_pages > tlb_local_single_page_flush_ceiling);
+	if (full)
+		_tlbiel_pid(pid, RIC_FLUSH_TLB);
+	else
+		_tlbiel_va_range(start, end, pid, page_size, psize, false);
+	preempt_enable();
+}
+
 static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
 				unsigned long start, unsigned long end,
 				int psize, bool also_pwc)
@@ -604,6 +630,12 @@ void radix__flush_tlb_lpid(unsigned long lpid)
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
2.15.0.rc2
