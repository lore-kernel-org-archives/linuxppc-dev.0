Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0141.outbound.protection.outlook.com [157.56.111.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6387A1A0D50
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 00:55:48 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>,
 <scottwood@Freescale.com>
Subject: [PATCH v3] powerpc: Use PFN_PHYS() to avoid truncating the physical
 address
Date: Wed, 25 Mar 2015 08:49:12 -0500
Message-ID: <1427291352-31256-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

v3: Rebased and updated due to upstream changes since v2

v2: Rebased and updated due to upstream changes since v1

 arch/powerpc/include/asm/io.h          | 2 +-
 arch/powerpc/include/asm/page.h        | 2 +-
 arch/powerpc/include/asm/pgalloc-32.h  | 2 +-
 arch/powerpc/include/asm/rtas.h        | 3 ++-
 arch/powerpc/kernel/crash_dump.c       | 2 +-
 arch/powerpc/kernel/eeh.c              | 4 +---
 arch/powerpc/kernel/io-workarounds.c   | 2 +-
 arch/powerpc/kernel/pci-common.c       | 2 +-
 arch/powerpc/kernel/vdso.c             | 6 +++---
 arch/powerpc/kvm/book3s_64_mmu_host.c  | 2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c    | 2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c    | 4 ++--
 arch/powerpc/kvm/e500_mmu_host.c       | 5 ++---
 arch/powerpc/mm/hugepage-hash64.c      | 2 +-
 arch/powerpc/mm/hugetlbpage-book3e.c   | 2 +-
 arch/powerpc/mm/hugetlbpage-hash64.c   | 2 +-
 arch/powerpc/mm/mem.c                  | 9 ++++-----
 arch/powerpc/mm/numa.c                 | 5 ++---
 arch/powerpc/platforms/powernv/opal.c  | 2 +-
 arch/powerpc/platforms/pseries/iommu.c | 8 ++++----
 20 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 9eaf301..d6454f5 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -794,7 +794,7 @@ static inline void * phys_to_virt(unsigned long address)
 /*
  * Change "struct page" to physical address.
  */
-#define page_to_phys(page)	((phys_addr_t)page_to_pfn(page) << PAGE_SHIFT)
+#define page_to_phys(page)	PFN_PHYS(page_to_pfn(page))
 
 /*
  * 32 bits still uses virt_to_bus() for it's implementation of DMA
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 69c0598..30f33ed 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -128,7 +128,7 @@ extern long long virt_phys_offset;
 #endif
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+#define pfn_to_kaddr(pfn)	__va(PFN_PHYS(pfn))
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
 /*
diff --git a/arch/powerpc/include/asm/pgalloc-32.h b/arch/powerpc/include/asm/pgalloc-32.h
index 842846c..3d19a8e 100644
--- a/arch/powerpc/include/asm/pgalloc-32.h
+++ b/arch/powerpc/include/asm/pgalloc-32.h
@@ -24,7 +24,7 @@ extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 #define pmd_populate_kernel(mm, pmd, pte)	\
 		(pmd_val(*(pmd)) = __pa(pte) | _PMD_PRESENT)
 #define pmd_populate(mm, pmd, pte)	\
-		(pmd_val(*(pmd)) = (page_to_pfn(pte) << PAGE_SHIFT) | _PMD_PRESENT)
+		(pmd_val(*(pmd)) = PFN_PHYS(page_to_pfn(pte)) | _PMD_PRESENT)
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #else
 #define pmd_populate_kernel(mm, pmd, pte)	\
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 2e23e92..2e430b6d 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -3,6 +3,7 @@
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
+#include <linux/pfn.h>
 #include <asm/page.h>
 
 /*
@@ -418,7 +419,7 @@ extern void rtas_take_timebase(void);
 #ifdef CONFIG_PPC_RTAS
 static inline int page_is_rtas_user_buf(unsigned long pfn)
 {
-	unsigned long paddr = (pfn << PAGE_SHIFT);
+	unsigned long paddr = PFN_PHYS(pfn);
 	if (paddr >= rtas_rmo_buf && paddr < (rtas_rmo_buf + RTAS_RMOBUF_MAX))
 		return 1;
 	return 0;
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index cfa0f81..b6578ee 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -104,7 +104,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 		return 0;
 
 	csize = min_t(size_t, csize, PAGE_SIZE);
-	paddr = pfn << PAGE_SHIFT;
+	paddr = PFN_PHYS(pfn);
 
 	if (memblock_is_region_memory(paddr, csize)) {
 		vaddr = __va(paddr);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 3b2252e..119af20 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -326,7 +326,6 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 static inline unsigned long eeh_token_to_phys(unsigned long token)
 {
 	pte_t *ptep;
-	unsigned long pa;
 	int hugepage_shift;
 
 	/*
@@ -336,9 +335,8 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 	if (!ptep)
 		return token;
 	WARN_ON(hugepage_shift);
-	pa = pte_pfn(*ptep) << PAGE_SHIFT;
 
-	return pa | (token & (PAGE_SIZE-1));
+	return PFN_PHYS(pte_pfn(*ptep)) | (token & (PAGE_SIZE - 1));
 }
 
 /*
diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
index 24b968f..dd9a4a2 100644
--- a/arch/powerpc/kernel/io-workarounds.c
+++ b/arch/powerpc/kernel/io-workarounds.c
@@ -81,7 +81,7 @@ struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
 			 * we don't have hugepages backing iomem
 			 */
 			WARN_ON(hugepage_shift);
-			paddr = pte_pfn(*ptep) << PAGE_SHIFT;
+			paddr = PFN_PHYS(pte_pfn(*ptep));
 		}
 		bus = iowa_pci_find(vaddr, paddr);
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 2a525c9..132e42c 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -381,7 +381,7 @@ pgprot_t pci_phys_mem_access_prot(struct file *file,
 {
 	struct pci_dev *pdev = NULL;
 	struct resource *found = NULL;
-	resource_size_t offset = ((resource_size_t)pfn) << PAGE_SHIFT;
+	resource_size_t offset = PFN_PHYS(pfn);
 	int i;
 
 	if (page_is_ram(pfn))
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 305eb0d..05ba299 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -143,12 +143,12 @@ struct lib64_elfinfo
 #ifdef __DEBUG
 static void dump_one_vdso_page(struct page *pg, struct page *upg)
 {
-	printk("kpg: %p (c:%d,f:%08lx)", __va(page_to_pfn(pg) << PAGE_SHIFT),
+	printk("kpg: %p (c:%d,f:%08lx)", __va(PFN_PHYS(page_to_pfn(pg)));
 	       page_count(pg),
 	       pg->flags);
 	if (upg && !IS_ERR(upg) /* && pg != upg*/) {
-		printk(" upg: %p (c:%d,f:%08lx)", __va(page_to_pfn(upg)
-						       << PAGE_SHIFT),
+		printk(" upg: %p (c:%d,f:%08lx)",
+		       __va(PFN_PHYS(page_to_pfn(upg))),
 		       page_count(upg),
 		       upg->flags);
 	}
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index b982d92..c92c042 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -111,7 +111,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte,
 		r = -EINVAL;
 		goto out;
 	}
-	hpaddr = pfn << PAGE_SHIFT;
+	hpaddr = PFN_PHYS(pfn);
 
 	/* and write the mapping ea -> hpa into the pt */
 	vcpu->arch.mmu.esid_to_vsid(vcpu, orig_pte->eaddr >> SID_SHIFT, &vsid);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 534acb3..74222fb 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -579,7 +579,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 */
 	if (psize < PAGE_SIZE)
 		psize = PAGE_SIZE;
-	r = (r & ~(HPTE_R_PP0 - psize)) | ((pfn << PAGE_SHIFT) & ~(psize - 1));
+	r = (r & ~(HPTE_R_PP0 - psize)) | (PFN_PHYS(pfn) & ~(psize - 1));
 	if (hpte_is_writable(r) && !write_ok)
 		r = hpte_make_readonly(r);
 	ret = RESUME_GUEST;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 625407e..7ee3bc9 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -31,7 +31,7 @@ static void *real_vmalloc_addr(void *x)
 	if (!p || !pte_present(*p))
 		return NULL;
 	/* assume we don't have huge pages in vmalloc space... */
-	addr = (pte_pfn(*p) << PAGE_SHIFT) | (addr & ~PAGE_MASK);
+	addr = PFN_PHYS(pte_pfn(*p)) | (addr & ~PAGE_MASK);
 	return __va(addr);
 }
 
@@ -217,7 +217,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 			/* make the actual HPTE be read-only */
 			ptel = hpte_make_readonly(ptel);
 		is_io = hpte_cache_bits(pte_val(pte));
-		pa = pte_pfn(pte) << PAGE_SHIFT;
+		pa = PFN_PHYS(pte_pfn(pte));
 		pa |= hva & (pte_size - 1);
 		pa |= gpa & ~PAGE_MASK;
 	}
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index cc536d4..ead173e 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -174,8 +174,7 @@ void kvmppc_map_magic(struct kvm_vcpu *vcpu)
 	magic.mas1 = MAS1_VALID | MAS1_TS | MAS1_TID(stid) |
 		     MAS1_TSIZE(BOOK3E_PAGESZ_4K);
 	magic.mas2 = vcpu->arch.magic_page_ea | MAS2_M;
-	magic.mas7_3 = ((u64)pfn << PAGE_SHIFT) |
-		       MAS3_SW | MAS3_SR | MAS3_UW | MAS3_UR;
+	magic.mas7_3 = PFN_PHYS(pfn) | MAS3_SW | MAS3_SR | MAS3_UW | MAS3_UR;
 	magic.mas8 = 0;
 
 	__write_host_tlbe(&magic, MAS0_TLBSEL(1) | MAS0_ESEL(tlbcam_index), 0);
@@ -317,7 +316,7 @@ static void kvmppc_e500_setup_stlbe(
 	/* Force IPROT=0 for all guest mappings. */
 	stlbe->mas1 = MAS1_TSIZE(tsize) | get_tlb_sts(gtlbe) | MAS1_VALID;
 	stlbe->mas2 = (gvaddr & MAS2_EPN) | (ref->flags & E500_TLB_MAS2_ATTR);
-	stlbe->mas7_3 = ((u64)pfn << PAGE_SHIFT) |
+	stlbe->mas7_3 = PFN_PHYS(pfn) |
 			e500_shadow_mas3_attrib(gtlbe->mas7_3, pr);
 }
 
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 8668651..a7fc8fa 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -127,7 +127,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		unsigned long hpte_group;
 
 		/* insert new entry */
-		pa = pmd_pfn(__pmd(old_pmd)) << PAGE_SHIFT;
+		pa = PFN_PHYS(pmd_pfn(__pmd(old_pmd)));
 		new_pmd |= _PAGE_HASHPTE;
 
 		/* Add in WIMG bits */
diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index ba47aaf..2f29c61 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -123,7 +123,7 @@ void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 	mas1 = MAS1_VALID | MAS1_TID(mm->context.id) | MAS1_TSIZE(tsize);
 	mas2 = ea & ~((1UL << shift) - 1);
 	mas2 |= (pte_val(pte) >> PTE_WIMGE_SHIFT) & MAS2_WIMGE_MASK;
-	mas7_3 = (u64)pte_pfn(pte) << PAGE_SHIFT;
+	mas7_3 = PFN_PHYS(pte_pfn(pte));
 	mas7_3 |= (pte_val(pte) >> PTE_BAP_SHIFT) & MAS3_BAP_MASK;
 	if (!pte_dirty(pte))
 		mas7_3 &= ~(MAS3_SW|MAS3_UW);
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index d94b1af..5a4d74b 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -88,7 +88,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	if (likely(!(old_pte & _PAGE_HASHPTE))) {
 		unsigned long hash = hpt_hash(vpn, shift, ssize);
 
-		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
+		pa = PFN_PHYS(pte_pfn(__pte(old_pte)));
 
 		/* clear HPTE slot informations in new PTE */
 #ifdef CONFIG_PPC_64K_PAGES
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index b7285a5..d2409ca 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -82,7 +82,7 @@ int page_is_ram(unsigned long pfn)
 #ifndef CONFIG_PPC64	/* XXX for now */
 	return pfn < max_pfn;
 #else
-	unsigned long paddr = (pfn << PAGE_SHIFT);
+	unsigned long paddr = PFN_PHYS(pfn);
 	struct memblock_region *reg;
 
 	for_each_memblock(memory, reg)
@@ -343,9 +343,8 @@ void __init mem_init(void)
 
 		highmem_mapnr = lowmem_end_addr >> PAGE_SHIFT;
 		for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
-			phys_addr_t paddr = (phys_addr_t)pfn << PAGE_SHIFT;
 			struct page *page = pfn_to_page(pfn);
-			if (!memblock_is_reserved(paddr))
+			if (!memblock_is_reserved(PFN_PHYS(pfn)))
 				free_highmem_page(page);
 		}
 	}
@@ -427,7 +426,7 @@ void flush_dcache_icache_page(struct page *page)
 	/* On 8xx there is no need to kmap since highmem is not supported */
 	__flush_dcache_icache(page_address(page)); 
 #else
-	__flush_dcache_icache_phys(page_to_pfn(page) << PAGE_SHIFT);
+	__flush_dcache_icache_phys(PFN_PHYS(page_to_pfn(page)));
 #endif
 }
 EXPORT_SYMBOL(flush_dcache_icache_page);
@@ -563,7 +562,7 @@ subsys_initcall(add_system_ram_resources);
  */
 int devmem_is_allowed(unsigned long pfn)
 {
-	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
+	if (iomem_is_exclusive(PFN_PHYS(pfn)))
 		return 0;
 	if (!page_is_ram(pfn))
 		return 1;
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0257a7d..31b4b57 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -118,7 +118,7 @@ static int __init fake_numa_create_new_node(unsigned long end_pfn,
 
 	curr_boundary = mem;
 
-	if ((end_pfn << PAGE_SHIFT) > mem) {
+	if (PFN_PHYS(end_pfn) > mem) {
 		/*
 		 * Skip commas and spaces
 		 */
@@ -922,8 +922,7 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 
 	if (spanned_pages)
 		pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n",
-			nid, start_pfn << PAGE_SHIFT,
-			(end_pfn << PAGE_SHIFT) - 1);
+			nid, PFN_PHYS(start_pfn), PFN_PHYS(end_pfn) - 1);
 	else
 		pr_info("Initmem setup node %d\n", nid);
 
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 18fd4e7..a7cc51a 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -845,7 +845,7 @@ struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
 	first = sg;
 
 	while (vmalloc_size > 0) {
-		uint64_t data = vmalloc_to_pfn(vmalloc_addr) << PAGE_SHIFT;
+		uint64_t data = PFN_PHYS(vmalloc_to_pfn(vmalloc_addr));
 		uint64_t length = min(vmalloc_size, PAGE_SIZE);
 
 		sg->entry[i].data = cpu_to_be64(data);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 7803a19..246a7e4 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -358,8 +358,8 @@ static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
 
 	tce_shift = be32_to_cpu(maprange->tce_shift);
 	tce_size = 1ULL << tce_shift;
-	next = start_pfn << PAGE_SHIFT;
-	num_tce = num_pfn << PAGE_SHIFT;
+	next = PFN_PHYS(start_pfn);
+	num_tce = PFN_PHYS(num_pfn);
 
 	/* round back to the beginning of the tce page size */
 	num_tce += next & (tce_size - 1);
@@ -414,8 +414,8 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 	liobn = (u64)be32_to_cpu(maprange->liobn);
 	tce_shift = be32_to_cpu(maprange->tce_shift);
 	tce_size = 1ULL << tce_shift;
-	next = start_pfn << PAGE_SHIFT;
-	num_tce = num_pfn << PAGE_SHIFT;
+	next = PFN_PHYS(start_pfn);
+	num_tce = PFN_PHYS(num_pfn);
 
 	/* round back to the beginning of the tce page size */
 	num_tce += next & (tce_size - 1);
-- 
2.3.3
