Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AEAD91400C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 05:21:55 +1000 (EST)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc: Use PFN_PHYS() to avoid truncating the physical
 address
Date: Tue, 6 May 2014 13:47:57 -0500
Message-ID: <1399402077-6288-1-git-send-email-Emilian.Medve@Freescale.com>
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

v2: Rebased and updated due to upstream changes since v1

 arch/powerpc/include/asm/io.h          |  2 +-
 arch/powerpc/include/asm/page.h        |  2 +-
 arch/powerpc/include/asm/pgalloc-32.h  |  2 +-
 arch/powerpc/include/asm/rtas.h        |  3 ++-
 arch/powerpc/kernel/crash_dump.c       |  2 +-
 arch/powerpc/kernel/eeh.c              |  4 +---
 arch/powerpc/kernel/io-workarounds.c   |  2 +-
 arch/powerpc/kernel/pci-common.c       |  2 +-
 arch/powerpc/kernel/vdso.c             |  6 +++---
 arch/powerpc/kvm/book3s_64_mmu_host.c  |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |  5 ++---
 arch/powerpc/kvm/book3s_hv.c           | 10 +++++-----
 arch/powerpc/kvm/book3s_hv_rm_mmu.c    |  4 ++--
 arch/powerpc/kvm/e500_mmu_host.c       |  5 ++---
 arch/powerpc/mm/hugepage-hash64.c      |  2 +-
 arch/powerpc/mm/hugetlbpage-book3e.c   |  2 +-
 arch/powerpc/mm/hugetlbpage-hash64.c   |  2 +-
 arch/powerpc/mm/mem.c                  |  9 ++++-----
 arch/powerpc/mm/numa.c                 | 13 +++++++------
 arch/powerpc/platforms/powernv/opal.c  |  2 +-
 arch/powerpc/platforms/pseries/iommu.c |  8 ++++----
 21 files changed, 43 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 97d3869..8f7af05 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -790,7 +790,7 @@ static inline void * phys_to_virt(unsigned long address)
 /*
  * Change "struct page" to physical address.
  */
-#define page_to_phys(page)	((phys_addr_t)page_to_pfn(page) << PAGE_SHIFT)
+#define page_to_phys(page)	PFN_PHYS(page_to_pfn(page))
 
 /*
  * 32 bits still uses virt_to_bus() for it's implementation of DMA
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 32e4e21..7193d45 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -131,7 +131,7 @@ extern long long virt_phys_offset;
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
index b390f55..c19bd9f 100644
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
index 7a13f37..a46a9c2 100644
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
index 3764fb7..7f2ba3d 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -271,7 +271,6 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 static inline unsigned long eeh_token_to_phys(unsigned long token)
 {
 	pte_t *ptep;
-	unsigned long pa;
 	int hugepage_shift;
 
 	/*
@@ -281,9 +280,8 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 	if (!ptep)
 		return token;
 	WARN_ON(hugepage_shift);
-	pa = pte_pfn(*ptep) << PAGE_SHIFT;
 
-	return pa | (token & (PAGE_SIZE-1));
+	return PFN_PHYS(pte_pfn(*ptep)) | (token & (PAGE_SIZE-1));
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
index add166a..c26f5a9 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -411,7 +411,7 @@ pgprot_t pci_phys_mem_access_prot(struct file *file,
 {
 	struct pci_dev *pdev = NULL;
 	struct resource *found = NULL;
-	resource_size_t offset = ((resource_size_t)pfn) << PAGE_SHIFT;
+	resource_size_t offset = PFN_PHYS(pfn);
 	int i;
 
 	if (page_is_ram(pfn))
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index ce74c33..d8095ad 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -144,12 +144,12 @@ struct lib64_elfinfo
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
index 0d513af..4dbdba6 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -110,7 +110,7 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte,
 		r = -EINVAL;
 		goto out;
 	}
-	hpaddr = pfn << PAGE_SHIFT;
+	hpaddr = PFN_PHYS(pfn);
 
 	/* and write the mapping ea -> hpa into the pt */
 	vcpu->arch.mmu.esid_to_vsid(vcpu, orig_pte->eaddr >> SID_SHIFT, &vsid);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index fb25ebc..f01110f 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -349,8 +349,7 @@ static long kvmppc_get_guest_page(struct kvm *kvm, unsigned long gfn,
 	spin_lock(&kvm->arch.slot_phys_lock);
 	for (i = 0; i < npages; ++i) {
 		if (!physp[i]) {
-			physp[i] = ((pfn + i) << PAGE_SHIFT) +
-				got + is_io + pgorder;
+			physp[i] = PFN_PHYS(pfn + i) + got + is_io + pgorder;
 			got = 0;
 		}
 	}
@@ -725,7 +724,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 */
 	if (psize < PAGE_SIZE)
 		psize = PAGE_SIZE;
-	r = (r & ~(HPTE_R_PP0 - psize)) | ((pfn << PAGE_SHIFT) & ~(psize - 1));
+	r = (r & ~(HPTE_R_PP0 - psize)) | (PFN_PHYS(pfn) & ~(psize - 1));
 	if (hpte_is_writable(r) && !write_ok)
 		r = hpte_make_readonly(r);
 	ret = RESUME_GUEST;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8227dba..5c96231 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2232,10 +2232,11 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 			/* POWER7 */
 			lpcr_mask = LPCR_VPM0 | LPCR_VRMA_L | LPCR_RMLS;
 			lpcr = rmls << LPCR_RMLS_SH;
-			kvm->arch.rmor = ri->base_pfn << PAGE_SHIFT;
+			kvm->arch.rmor = PFN_PHYS(ri->base_pfn);
 		}
-		pr_info("KVM: Using RMO at %lx size %lx (LPCR = %lx)\n",
-			ri->base_pfn << PAGE_SHIFT, rma_size, lpcr);
+		pr_info("KVM: Using RMO at %llx size %lx (LPCR = %lx)\n",
+			(unsigned long long)PFN_PHYS(ri->base_pfn),
+			rma_size, lpcr);
 
 		/* Initialize phys addrs of pages in RMO */
 		npages = kvm_rma_pages;
@@ -2246,8 +2247,7 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 				npages = memslot->npages;
 			spin_lock(&kvm->arch.slot_phys_lock);
 			for (i = 0; i < npages; ++i)
-				physp[i] = ((ri->base_pfn + i) << PAGE_SHIFT) +
-					porder;
+				physp[i] = PFN_PHYS(ri->base_pfn + i) + porder;
 			spin_unlock(&kvm->arch.slot_phys_lock);
 		}
 	}
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 1d6c56a..799503c 100644
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
 
@@ -239,7 +239,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 				/* make the actual HPTE be read-only */
 				ptel = hpte_make_readonly(ptel);
 			is_io = hpte_cache_bits(pte_val(pte));
-			pa = pte_pfn(pte) << PAGE_SHIFT;
+			pa = PFN_PHYS(pte_pfn(pte));
 			pa |= hva & (pte_size - 1);
 			pa |= gpa & ~PAGE_MASK;
 		}
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index dd2cc03..2368e2c 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -168,8 +168,7 @@ void kvmppc_map_magic(struct kvm_vcpu *vcpu)
 	magic.mas1 = MAS1_VALID | MAS1_TS | MAS1_TID(stid) |
 		     MAS1_TSIZE(BOOK3E_PAGESZ_4K);
 	magic.mas2 = vcpu->arch.magic_page_ea | MAS2_M;
-	magic.mas7_3 = ((u64)pfn << PAGE_SHIFT) |
-		       MAS3_SW | MAS3_SR | MAS3_UW | MAS3_UR;
+	magic.mas7_3 = PFN_PHYS(pfn) | MAS3_SW | MAS3_SR | MAS3_UW | MAS3_UR;
 	magic.mas8 = 0;
 
 	__write_host_tlbe(&magic, MAS0_TLBSEL(1) | MAS0_ESEL(tlbcam_index));
@@ -311,7 +310,7 @@ static void kvmppc_e500_setup_stlbe(
 	/* Force IPROT=0 for all guest mappings. */
 	stlbe->mas1 = MAS1_TSIZE(tsize) | get_tlb_sts(gtlbe) | MAS1_VALID;
 	stlbe->mas2 = (gvaddr & MAS2_EPN) | (ref->flags & E500_TLB_MAS2_ATTR);
-	stlbe->mas7_3 = ((u64)pfn << PAGE_SHIFT) |
+	stlbe->mas7_3 = PFN_PHYS(pfn) |
 			e500_shadow_mas3_attrib(gtlbe->mas7_3, pr);
 
 #ifdef CONFIG_KVM_BOOKE_HV
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 826893f..5004539 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -118,7 +118,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		unsigned long hpte_group;
 
 		/* insert new entry */
-		pa = pmd_pfn(__pmd(old_pmd)) << PAGE_SHIFT;
+		pa = PFN_PHYS(pmd_pfn(__pmd(old_pmd)));
 repeat:
 		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
 
diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index 5e4ee25..1c94b28 100644
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
index a5bcf93..3351ae2 100644
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
index 2c8e90f..32202c9 100644
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
@@ -333,9 +333,8 @@ void __init mem_init(void)
 
 		highmem_mapnr = lowmem_end_addr >> PAGE_SHIFT;
 		for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
-			phys_addr_t paddr = (phys_addr_t)pfn << PAGE_SHIFT;
 			struct page *page = pfn_to_page(pfn);
-			if (!memblock_is_reserved(paddr))
+			if (!memblock_is_reserved(PFN_PHYS(pfn)))
 				free_highmem_page(page);
 		}
 	}
@@ -417,7 +416,7 @@ void flush_dcache_icache_page(struct page *page)
 	/* On 8xx there is no need to kmap since highmem is not supported */
 	__flush_dcache_icache(page_address(page)); 
 #else
-	__flush_dcache_icache_phys(page_to_pfn(page) << PAGE_SHIFT);
+	__flush_dcache_icache_phys(PFN_PHYS(page_to_pfn(page)));
 #endif
 }
 EXPORT_SYMBOL(flush_dcache_icache_page);
@@ -553,7 +552,7 @@ subsys_initcall(add_system_ram_resources);
  */
 int devmem_is_allowed(unsigned long pfn)
 {
-	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
+	if (iomem_is_exclusive(PFN_PHYS(pfn)))
 		return 0;
 	if (!page_is_ram(pfn))
 		return 1;
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 3b181b2..123e677 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -116,7 +116,7 @@ static int __init fake_numa_create_new_node(unsigned long end_pfn,
 
 	curr_boundary = mem;
 
-	if ((end_pfn << PAGE_SHIFT) > mem) {
+	if (PFN_PHYS(end_pfn) > mem) {
 		/*
 		 * Skip commas and spaces
 		 */
@@ -939,7 +939,7 @@ static void __init *careful_zallocation(int nid, unsigned long size,
 	int new_nid;
 	unsigned long ret_paddr;
 
-	ret_paddr = __memblock_alloc_base(size, align, end_pfn << PAGE_SHIFT);
+	ret_paddr = __memblock_alloc_base(size, align, PFN_PHYS(end_pfn));
 
 	/* retry over all memory */
 	if (!ret_paddr)
@@ -1013,7 +1013,7 @@ static void __init mark_reserved_regions_for_nid(int nid)
 			 * then trim size to active region
 			 */
 			if (end_pfn > node_ar.end_pfn)
-				reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
+				reserve_size = PFN_PHYS(node_ar.end_pfn)
 					- physbase;
 			/*
 			 * Only worry about *this* node, others may not
@@ -1039,7 +1039,7 @@ static void __init mark_reserved_regions_for_nid(int nid)
 			 *   reserved region
 			 */
 			start_pfn = node_ar.end_pfn;
-			physbase = start_pfn << PAGE_SHIFT;
+			physbase = PFN_PHYS(start_pfn);
 			size = size - reserve_size;
 			get_node_active_region(start_pfn, &node_ar);
 		}
@@ -1088,8 +1088,9 @@ void __init do_init_bootmem(void)
 		if (NODE_DATA(nid)->node_spanned_pages == 0)
   			continue;
 
-  		dbg("start_paddr = %lx\n", start_pfn << PAGE_SHIFT);
-  		dbg("end_paddr = %lx\n", end_pfn << PAGE_SHIFT);
+		dbg("start_paddr = %llx\nend_paddr = %llx\n",
+		    (unsigned long long)PFN_PHYS(start_pfn),
+		    (unsigned long long)PFN_PHYS(end_pfn));
 
 		bootmap_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
 		bootmem_vaddr = careful_zallocation(nid,
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 360ad80c..052e423 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -653,7 +653,7 @@ struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
 	first = sg;
 
 	while (vmalloc_size > 0) {
-		uint64_t data = vmalloc_to_pfn(vmalloc_addr) << PAGE_SHIFT;
+		uint64_t data = PFN_PHYS(vmalloc_to_pfn(vmalloc_addr));
 		uint64_t length = min(vmalloc_size, PAGE_SIZE);
 
 		sg->entry[i].data = cpu_to_be64(data);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 33b552f..96c7bb1 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -359,8 +359,8 @@ static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
 
 	tce_shift = be32_to_cpu(maprange->tce_shift);
 	tce_size = 1ULL << tce_shift;
-	next = start_pfn << PAGE_SHIFT;
-	num_tce = num_pfn << PAGE_SHIFT;
+	next = PFN_PHYS(start_pfn);
+	num_tce = PFN_PHYS(num_pfn);
 
 	/* round back to the beginning of the tce page size */
 	num_tce += next & (tce_size - 1);
@@ -415,8 +415,8 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
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
1.9.2
