Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 425bQF2HVVzF3Fj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 19:49:39 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@ozlabs.org>
Subject: [RFC PATCH kernel v2] KVM: PPC: Avoid marking DMA-mapped pages dirty
 in real mode
Date: Thu,  6 Sep 2018 19:49:32 +1000
Message-Id: <20180906094932.43891-1-aik@ozlabs.ru>
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

This adds a dirty bit tracking into the MM/IOMMU API:
- this uses the lowest bit of the cached host phys address to carry
the dirty bit;
- this marks pages dirty when they are unpinned which happens when
the preregistered memory is released which always happens in virtual
mode;
- this changes mm_iommu_ua_to_hpa{_rm} to take DMA direction parameter so
the bit is set when just about to map a page. This might seem rather early
as there is a chance of failure after the translation. The other way
of doing this would be adding a new mm_iommu_ua_mark_dirty() helper
which would have to do the useraddr->hpa lookup again which seems
suboptimal as we normally:
- do not see mapping errors;
- map the entire guest so it is TCE_WRITE;
- consequences of a page being marked dirty are not worth of the extra
lookup.

This moves dirty bit setting away from iommu_tce_xchg{_rm} to the callers
which are KVM and VFIO. KVM requires the memory preregistration; VFIO
uses the same mechanism which KVM does when VFIO_SPAPR_TCE_v2_IOMMU
or explicitly marks pages dirty when VFIO_SPAPR_TCE_IOMMU.

This removes realmode_pfn_to_page() as it is not used anymore.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

v1 was here: https://www.spinics.net/lists/kvm-ppc/msg14218.html
This is based on top of (it does not really depend on this but rebase does not just work):
[PATCH kernel 0/4] KVM: PPC: Some error handling rework
  KVM: PPC: Validate all tces before updating tables
  KVM: PPC: Inform the userspace about TCE update failures
  KVM: PPC: Validate TCEs against preregistered memory page sizes
  KVM: PPC: Propagate errors to the guest when failed instead of
    ignoring



---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 -
 arch/powerpc/include/asm/mmu_context.h       |  7 ++--
 arch/powerpc/kernel/iommu.c                  | 16 ---------
 arch/powerpc/kvm/book3s_64_vio.c             |  5 +--
 arch/powerpc/kvm/book3s_64_vio_hv.c          |  7 ++--
 arch/powerpc/mm/init_64.c                    | 49 ----------------------------
 arch/powerpc/mm/mmu_context_iommu.c          | 23 ++++++++++---
 drivers/vfio/vfio_iommu_spapr_tce.c          | 26 +++++++++++----
 8 files changed, 50 insertions(+), 84 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 13a688f..2fdc865 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1051,7 +1051,6 @@ static inline void vmemmap_remove_mapping(unsigned long start,
 	return hash__vmemmap_remove_mapping(start, page_size);
 }
 #endif
-struct page *realmode_pfn_to_page(unsigned long pfn);
 
 static inline pte_t pmd_pte(pmd_t pmd)
 {
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b2f89b6..ebafa43 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -7,6 +7,7 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/dma-direction.h>
 #include <asm/mmu.h>	
 #include <asm/cputable.h>
 #include <asm/cputhreads.h>
@@ -35,9 +36,11 @@ extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(
 extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries);
 extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
-		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
+		unsigned long ua, unsigned int pageshift,
+		enum dma_data_direction dir, unsigned long *hpa);
 extern long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
-		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
+		unsigned long ua, unsigned int pageshift,
+		enum dma_data_direction dir, unsigned long *hpa);
 extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
 extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
 #endif
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index af7a20d..1540e7f 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1000,10 +1000,6 @@ long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
 
 	ret = tbl->it_ops->exchange(tbl, entry, hpa, direction);
 
-	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
-			(*direction == DMA_BIDIRECTIONAL)))
-		SetPageDirty(pfn_to_page(*hpa >> PAGE_SHIFT));
-
 	/* if (unlikely(ret))
 		pr_err("iommu_tce: %s failed on hwaddr=%lx ioba=%lx kva=%lx ret=%d\n",
 			__func__, hwaddr, entry << tbl->it_page_shift,
@@ -1021,18 +1017,6 @@ long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
 
 	ret = tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
 
-	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
-			(*direction == DMA_BIDIRECTIONAL))) {
-		struct page *pg = realmode_pfn_to_page(*hpa >> PAGE_SHIFT);
-
-		if (likely(pg)) {
-			SetPageDirty(pg);
-		} else {
-			tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
-			ret = -EFAULT;
-		}
-	}
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_tce_xchg_rm);
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 5e3151b..174299d 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -391,7 +391,7 @@ static long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt,
 		if (!mem)
 			return H_TOO_HARD;
 
-		if (mm_iommu_ua_to_hpa(mem, ua, shift, &hpa))
+		if (mm_iommu_ua_to_hpa(mem, ua, shift, DMA_NONE, &hpa))
 			return H_TOO_HARD;
 	}
 
@@ -483,7 +483,8 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 		/* This only handles v2 IOMMU type, v1 is handled via ioctl() */
 		return H_TOO_HARD;
 
-	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, tbl->it_page_shift, &hpa)))
+	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, tbl->it_page_shift, dir,
+			&hpa)))
 		return H_TOO_HARD;
 
 	if (mm_iommu_mapped_inc(mem))
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 8d82133..5f810dc 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -123,7 +123,7 @@ static long kvmppc_rm_tce_validate(struct kvmppc_spapr_tce_table *stt,
 		if (!mem)
 			return H_TOO_HARD;
 
-		if (mm_iommu_ua_to_hpa_rm(mem, ua, shift, &hpa))
+		if (mm_iommu_ua_to_hpa_rm(mem, ua, shift, DMA_NONE, &hpa))
 			return H_TOO_HARD;
 	}
 
@@ -292,7 +292,7 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 		return H_TOO_HARD;
 
 	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, tbl->it_page_shift,
-			&hpa)))
+			dir, &hpa)))
 		return H_TOO_HARD;
 
 	if (WARN_ON_ONCE_RM(mm_iommu_mapped_inc(mem)))
@@ -475,7 +475,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		mem = mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K);
 		if (mem)
 			prereg = mm_iommu_ua_to_hpa_rm(mem, ua,
-					IOMMU_PAGE_SHIFT_4K, &tces) == 0;
+					IOMMU_PAGE_SHIFT_4K, DMA_NONE,
+					&tces) == 0;
 	}
 
 	if (!prereg) {
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 51ce091..7a9886f 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -308,55 +308,6 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 {
 }
 
-/*
- * We do not have access to the sparsemem vmemmap, so we fallback to
- * walking the list of sparsemem blocks which we already maintain for
- * the sake of crashdump. In the long run, we might want to maintain
- * a tree if performance of that linear walk becomes a problem.
- *
- * realmode_pfn_to_page functions can fail due to:
- * 1) As real sparsemem blocks do not lay in RAM continously (they
- * are in virtual address space which is not available in the real mode),
- * the requested page struct can be split between blocks so get_page/put_page
- * may fail.
- * 2) When huge pages are used, the get_page/put_page API will fail
- * in real mode as the linked addresses in the page struct are virtual
- * too.
- */
-struct page *realmode_pfn_to_page(unsigned long pfn)
-{
-	struct vmemmap_backing *vmem_back;
-	struct page *page;
-	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
-	unsigned long pg_va = (unsigned long) pfn_to_page(pfn);
-
-	for (vmem_back = vmemmap_list; vmem_back; vmem_back = vmem_back->list) {
-		if (pg_va < vmem_back->virt_addr)
-			continue;
-
-		/* After vmemmap_list entry free is possible, need check all */
-		if ((pg_va + sizeof(struct page)) <=
-				(vmem_back->virt_addr + page_size)) {
-			page = (struct page *) (vmem_back->phys + pg_va -
-				vmem_back->virt_addr);
-			return page;
-		}
-	}
-
-	/* Probably that page struct is split between real pages */
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
-
-#else
-
-struct page *realmode_pfn_to_page(unsigned long pfn)
-{
-	struct page *page = pfn_to_page(pfn);
-	return page;
-}
-EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
-
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index c9ee9e2..bc59a73 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -18,11 +18,15 @@
 #include <linux/migrate.h>
 #include <linux/hugetlb.h>
 #include <linux/swap.h>
+#include <linux/sizes.h>
 #include <asm/mmu_context.h>
 #include <asm/pte-walk.h>
 
 static DEFINE_MUTEX(mem_list_mutex);
 
+#define MM_IOMMU_TABLE_GROUP_PAGE_DIRTY	0x1
+#define MM_IOMMU_TABLE_GROUP_PAGE_MASK	(SZ_4K - 1)
+
 struct mm_iommu_table_group_mem_t {
 	struct list_head next;
 	struct rcu_head rcu;
@@ -263,6 +267,9 @@ static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
 		if (!page)
 			continue;
 
+		if (mem->hpas[i] & MM_IOMMU_TABLE_GROUP_PAGE_DIRTY)
+			SetPageDirty(page);
+
 		put_page(page);
 		mem->hpas[i] = 0;
 	}
@@ -379,7 +386,8 @@ struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
 EXPORT_SYMBOL_GPL(mm_iommu_find);
 
 long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
-		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
+		unsigned long ua, unsigned int pageshift,
+		enum dma_data_direction dir, unsigned long *hpa)
 {
 	const long entry = (ua - mem->ua) >> PAGE_SHIFT;
 	u64 *va = &mem->hpas[entry];
@@ -390,14 +398,18 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 	if (pageshift > mem->pageshift)
 		return -EFAULT;
 
-	*hpa = *va | (ua & ~PAGE_MASK);
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		*va |= MM_IOMMU_TABLE_GROUP_PAGE_DIRTY;
+
+	*hpa = (*va & ~MM_IOMMU_TABLE_GROUP_PAGE_MASK) | (ua & ~PAGE_MASK);
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
 
 long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
-		unsigned long ua, unsigned int pageshift, unsigned long *hpa)
+		unsigned long ua, unsigned int pageshift,
+		enum dma_data_direction dir, unsigned long *hpa)
 {
 	const long entry = (ua - mem->ua) >> PAGE_SHIFT;
 	void *va = &mem->hpas[entry];
@@ -413,7 +425,10 @@ long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
 	if (!pa)
 		return -EFAULT;
 
-	*hpa = *pa | (ua & ~PAGE_MASK);
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		*pa |= MM_IOMMU_TABLE_GROUP_PAGE_DIRTY;
+
+	*hpa = (*pa & ~MM_IOMMU_TABLE_GROUP_PAGE_MASK) | (ua & ~PAGE_MASK);
 
 	return 0;
 }
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 96721b1..8fea7cd1 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -410,16 +410,21 @@ static void tce_iommu_release(void *iommu_data)
 }
 
 static void tce_iommu_unuse_page(struct tce_container *container,
-		unsigned long hpa)
+		unsigned long hpa, enum dma_data_direction dir)
 {
 	struct page *page;
 
 	page = pfn_to_page(hpa >> PAGE_SHIFT);
+
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		SetPageDirty(page);
+
 	put_page(page);
 }
 
 static int tce_iommu_prereg_ua_to_hpa(struct tce_container *container,
 		unsigned long tce, unsigned long shift,
+		enum dma_data_direction dir,
 		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
 {
 	long ret = 0;
@@ -429,7 +434,7 @@ static int tce_iommu_prereg_ua_to_hpa(struct tce_container *container,
 	if (!mem)
 		return -EINVAL;
 
-	ret = mm_iommu_ua_to_hpa(mem, tce, shift, phpa);
+	ret = mm_iommu_ua_to_hpa(mem, tce, shift, dir, phpa);
 	if (ret)
 		return -EINVAL;
 
@@ -450,10 +455,17 @@ static void tce_iommu_unuse_page_v2(struct tce_container *container,
 		return;
 
 	ret = tce_iommu_prereg_ua_to_hpa(container, be64_to_cpu(*pua),
-			tbl->it_page_shift, &hpa, &mem);
+			tbl->it_page_shift, DMA_NONE, &hpa, &mem);
 	if (ret)
 		pr_debug("%s: tce %llx at #%lx was not cached, ret=%d\n",
 				__func__, be64_to_cpu(*pua), entry, ret);
+
+	/*
+	 * VFIO_SPAPR_TCE_v2_IOMMU requires preregistered memory which
+	 * keeps track of dirty pages separately so we do not call
+	 * SetPageDirty(page) here unlike tce_iommu_unuse_page() does.
+	 */
+
 	if (mem)
 		mm_iommu_mapped_dec(mem);
 
@@ -485,7 +497,7 @@ static int tce_iommu_clear(struct tce_container *container,
 			continue;
 		}
 
-		tce_iommu_unuse_page(container, oldhpa);
+		tce_iommu_unuse_page(container, oldhpa, direction);
 	}
 
 	return 0;
@@ -532,7 +544,7 @@ static long tce_iommu_build(struct tce_container *container,
 		dirtmp = direction;
 		ret = iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
 		if (ret) {
-			tce_iommu_unuse_page(container, hpa);
+			tce_iommu_unuse_page(container, hpa, dirtmp);
 			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
 					__func__, entry << tbl->it_page_shift,
 					tce, ret);
@@ -540,7 +552,7 @@ static long tce_iommu_build(struct tce_container *container,
 		}
 
 		if (dirtmp != DMA_NONE)
-			tce_iommu_unuse_page(container, hpa);
+			tce_iommu_unuse_page(container, hpa, dirtmp);
 
 		tce += IOMMU_PAGE_SIZE(tbl);
 	}
@@ -566,7 +578,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry + i);
 
 		ret = tce_iommu_prereg_ua_to_hpa(container,
-				tce, tbl->it_page_shift, &hpa, &mem);
+				tce, tbl->it_page_shift, direction, &hpa, &mem);
 		if (ret)
 			break;
 
-- 
2.11.0
