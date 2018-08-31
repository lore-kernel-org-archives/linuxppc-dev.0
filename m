Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 421ppL0bSLzF38M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 16:08:57 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel] KVM: PPC: Avoid mapping compound pages to TCEs in real
 mode
Date: Fri, 31 Aug 2018 16:08:50 +1000
Message-Id: <20180831060850.33010-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment the real mode handler of H_PUT_TCE calls iommu_tce_xchg_rm()
which in turn reads the old TCE and if it was a valid entry - marks
the physical page dirty if it was mapped for writing. Since it is
the real mode, realmode_pfn_to_page() is used instead of pfn_to_page()
to get the page struct. However SetPageDirty() itself reads the compound
page head and returns a virtual address for the head page struct and
setting dirty bit for that kills the system.

This moves dirty bit setting before updating the hardware table to make
sure compound pages are never mapped in the real mode so when H_PUT_TCE
or H_STUFF_TCE try clearing a TCE, they won't get a compound page to mark
dirty.

This changes kvmppc_rm_tce_validate() to check if the preregistered
memory is backed with pages bigger than hardware IOMMU pages; if this is
the case, we forward the request to the virtual mode handlers where it
can be safely processed.

The second check makes the first check rather unnecessary but since
the actual crash happened at the SetPageDirty() call site, this marks
the spot with WARN_ON_ONCE.

In order to keep virtual and real mode handlers in sync, this adjusts
iommu_tce_xchg() as well.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is made on top of:
[PATCH kernel 0/4] KVM: PPC: Some error handling rework
  KVM: PPC: Validate all tces before updating tables
  KVM: PPC: Inform the userspace about TCE update failures
  KVM: PPC: Validate TCEs against preregistered memory page sizes
  KVM: PPC: Propagate errors to the guest when failed instead of
    ignoring
---
 arch/powerpc/include/asm/mmu_context.h |  3 ++-
 arch/powerpc/kernel/iommu.c            | 19 ++++++++-----------
 arch/powerpc/kvm/book3s_64_vio_hv.c    | 15 +++++++++++----
 arch/powerpc/mm/mmu_context_iommu.c    |  4 +++-
 4 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b2f89b6..073d72f9b 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -31,7 +31,8 @@ extern void mm_iommu_cleanup(struct mm_struct *mm);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
 		unsigned long ua, unsigned long size);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(
-		struct mm_struct *mm, unsigned long ua, unsigned long size);
+		struct mm_struct *mm, unsigned long ua, unsigned long size,
+		unsigned int *pshift);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries);
 extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index af7a20d..62e014d 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -998,12 +998,11 @@ long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
 {
 	long ret;
 
-	ret = tbl->it_ops->exchange(tbl, entry, hpa, direction);
-
-	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
-			(*direction == DMA_BIDIRECTIONAL)))
+	if (*direction == DMA_FROM_DEVICE || *direction == DMA_BIDIRECTIONAL)
 		SetPageDirty(pfn_to_page(*hpa >> PAGE_SHIFT));
 
+	ret = tbl->it_ops->exchange(tbl, entry, hpa, direction);
+
 	/* if (unlikely(ret))
 		pr_err("iommu_tce: %s failed on hwaddr=%lx ioba=%lx kva=%lx ret=%d\n",
 			__func__, hwaddr, entry << tbl->it_page_shift,
@@ -1019,20 +1018,18 @@ long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
 {
 	long ret;
 
-	ret = tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
-
-	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
-			(*direction == DMA_BIDIRECTIONAL))) {
+	if (*direction == DMA_FROM_DEVICE || *direction == DMA_BIDIRECTIONAL) {
 		struct page *pg = realmode_pfn_to_page(*hpa >> PAGE_SHIFT);
 
 		if (likely(pg)) {
+			if (WARN_ON_ONCE(PageCompound(pg)))
+				return -EPERM;
 			SetPageDirty(pg);
-		} else {
-			tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
-			ret = -EFAULT;
 		}
 	}
 
+	ret = tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_tce_xchg_rm);
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 8d82133..ce4d2f4 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -118,11 +118,17 @@ static long kvmppc_rm_tce_validate(struct kvmppc_spapr_tce_table *stt,
 		unsigned long hpa = 0;
 		struct mm_iommu_table_group_mem_t *mem;
 		long shift = stit->tbl->it_page_shift;
+		unsigned int memshift = 0;
 
-		mem = mm_iommu_lookup_rm(stt->kvm->mm, ua, 1ULL << shift);
+		mem = mm_iommu_lookup_rm(stt->kvm->mm, ua, 1ULL << shift,
+				&memshift);
 		if (!mem)
 			return H_TOO_HARD;
 
+		/* Marking compound pages dirty in real mode is too complex */
+		if (memshift > shift)
+			return H_TOO_HARD;
+
 		if (mm_iommu_ua_to_hpa_rm(mem, ua, shift, &hpa))
 			return H_TOO_HARD;
 	}
@@ -222,7 +228,7 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
 		/* it_userspace allocation might be delayed */
 		return H_TOO_HARD;
 
-	mem = mm_iommu_lookup_rm(kvm->mm, be64_to_cpu(*pua), pgsize);
+	mem = mm_iommu_lookup_rm(kvm->mm, be64_to_cpu(*pua), pgsize, NULL);
 	if (!mem)
 		return H_TOO_HARD;
 
@@ -287,7 +293,7 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 		/* it_userspace allocation might be delayed */
 		return H_TOO_HARD;
 
-	mem = mm_iommu_lookup_rm(kvm->mm, ua, 1ULL << tbl->it_page_shift);
+	mem = mm_iommu_lookup_rm(kvm->mm, ua, 1ULL << tbl->it_page_shift, NULL);
 	if (!mem)
 		return H_TOO_HARD;
 
@@ -472,7 +478,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
 			return H_TOO_HARD;
 
-		mem = mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K);
+		mem = mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K,
+				NULL);
 		if (mem)
 			prereg = mm_iommu_ua_to_hpa_rm(mem, ua,
 					IOMMU_PAGE_SHIFT_4K, &tces) == 0;
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index c9ee9e2..5c31fa5 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -344,7 +344,7 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
 EXPORT_SYMBOL_GPL(mm_iommu_lookup);
 
 struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(struct mm_struct *mm,
-		unsigned long ua, unsigned long size)
+		unsigned long ua, unsigned long size, unsigned int *pshift)
 {
 	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
 
@@ -354,6 +354,8 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(struct mm_struct *mm,
 				(ua + size <= mem->ua +
 				 (mem->entries << PAGE_SHIFT))) {
 			ret = mem;
+			if (pshift)
+				*pshift = mem->pageshift;
 			break;
 		}
 	}
-- 
2.11.0
