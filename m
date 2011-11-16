Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Nov 2011 09:58:08 +1100
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 03/11] KVM: PPC: Allow use of small pages to back guest memory
Message-ID: <20111116225808.GD26985@bloggs.ozlabs.ibm.com>
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nishanth Aravamudan <nacc@us.ibm.com>

This puts the page frame numbers for the memory backing the guest in
the slot->rmap array for each slot, rather than using the ram_pginfo
array.  Since the rmap array is vmalloc'd, we use real_vmalloc_addr()
to access it when we access it in real mode in kvmppc_h_enter().
The rmap array contains one PFN for each small page, even if the
backing memory is large pages.

This lets us get rid of the ram_pginfo array.

[paulus@samba.org - Cleaned up and reorganized a bit, abstracted out
HPTE page size encoding functions, added check that memory being
added in kvmppc_core_prepare_memory_region is all in one VMA.]

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_host.h |    8 --
 arch/powerpc/kvm/book3s_64_mmu_hv.c |   47 +++++++----
 arch/powerpc/kvm/book3s_hv.c        |  153 +++++++++++++++++------------------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c |   90 ++++++++++----------
 4 files changed, 151 insertions(+), 147 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 56f7046..52fd741 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -145,11 +145,6 @@ struct kvmppc_exit_timing {
 	};
 };
 
-struct kvmppc_pginfo {
-	unsigned long pfn;
-	atomic_t refcnt;
-};
-
 struct kvmppc_spapr_tce_table {
 	struct list_head list;
 	struct kvm *kvm;
@@ -179,17 +174,14 @@ struct kvm_arch {
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	unsigned long hpt_virt;
 	struct revmap_entry *revmap;
-	unsigned long ram_npages;
 	unsigned long ram_psize;
 	unsigned long ram_porder;
-	struct kvmppc_pginfo *ram_pginfo;
 	unsigned int lpid;
 	unsigned int host_lpid;
 	unsigned long host_lpcr;
 	unsigned long sdr1;
 	unsigned long host_sdr1;
 	int tlbie_lock;
-	int n_rma_pages;
 	unsigned long lpcr;
 	unsigned long rmor;
 	struct kvmppc_rma_info *rma;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 2b9b8be..bed6c61 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -34,8 +34,6 @@
 #include <asm/ppc-opcode.h>
 #include <asm/cputable.h>
 
-/* Pages in the VRMA are 16MB pages */
-#define VRMA_PAGE_ORDER	24
 #define VRMA_VSID	0x1ffffffUL	/* 1TB VSID reserved for VRMA */
 
 /* POWER7 has 10-bit LPIDs, PPC970 has 6-bit LPIDs */
@@ -95,19 +93,33 @@ void kvmppc_free_hpt(struct kvm *kvm)
 	free_pages(kvm->arch.hpt_virt, HPT_ORDER - PAGE_SHIFT);
 }
 
+/* Bits in first HPTE dword for pagesize 4k, 64k or 16M */
+static inline unsigned long hpte0_pgsize_encoding(unsigned long pgsize)
+{
+	return (pgsize > 0x1000) ? HPTE_V_LARGE : 0;
+}
+
+/* Bits in second HPTE dword for pagesize 4k, 64k or 16M */
+static inline unsigned long hpte1_pgsize_encoding(unsigned long pgsize)
+{
+	return (pgsize == 0x10000) ? 0x1000 : 0;
+}
+
 void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 {
 	unsigned long i;
-	unsigned long npages = kvm->arch.ram_npages;
+	unsigned long npages;
 	unsigned long pfn;
 	unsigned long *hpte;
-	unsigned long hash;
+	unsigned long addr, hash;
+	unsigned long psize = kvm->arch.ram_psize;
 	unsigned long porder = kvm->arch.ram_porder;
 	struct revmap_entry *rev;
-	struct kvmppc_pginfo *pginfo = kvm->arch.ram_pginfo;
+	struct kvm_memory_slot *memslot;
+	unsigned long hp0, hp1;
 
-	if (!pginfo)
-		return;
+	memslot = &kvm->memslots->memslots[mem->slot];
+	npages = memslot->npages >> (porder - PAGE_SHIFT);
 
 	/* VRMA can't be > 1TB */
 	if (npages > 1ul << (40 - porder))
@@ -116,10 +128,16 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 	if (npages > HPT_NPTEG)
 		npages = HPT_NPTEG;
 
+	hp0 = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
+		HPTE_V_BOLTED | hpte0_pgsize_encoding(psize) | HPTE_V_VALID;
+	hp1 = hpte1_pgsize_encoding(psize) |
+		HPTE_R_R | HPTE_R_C | HPTE_R_M | PP_RWXX;
+
 	for (i = 0; i < npages; ++i) {
-		pfn = pginfo[i].pfn;
+		pfn = memslot->rmap[i << (porder - PAGE_SHIFT)];
 		if (!pfn)
-			break;
+			continue;
+		addr = i << porder;
 		/* can't use hpt_hash since va > 64 bits */
 		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & HPT_HASH_MASK;
 		/*
@@ -131,17 +149,14 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 		hash = (hash << 3) + 7;
 		hpte = (unsigned long *) (kvm->arch.hpt_virt + (hash << 4));
 		/* HPTE low word - RPN, protection, etc. */
-		hpte[1] = (pfn << PAGE_SHIFT) | HPTE_R_R | HPTE_R_C |
-			HPTE_R_M | PP_RWXX;
+		hpte[1] = hp1 | (pfn << PAGE_SHIFT);
 		smp_wmb();
-		hpte[0] = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
-			(i << (VRMA_PAGE_ORDER - 16)) | HPTE_V_BOLTED |
-			HPTE_V_LARGE | HPTE_V_VALID;
+		/* HPTE high word - virtual address, bolted, valid, large */
+		hpte[0] = hp0 | ((addr >> 16) & ~0x7fUL);
 
 		/* Reverse map info */
 		rev = &kvm->arch.revmap[hash];
-		rev->guest_rpte = (i << porder) | HPTE_R_R | HPTE_R_C |
-			HPTE_R_M | PP_RWXX;
+		rev->guest_rpte = hp1 | addr;
 	}
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d1f0774..bc512ef 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -47,14 +47,7 @@
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
-
-/*
- * For now, limit memory to 64GB and require it to be large pages.
- * This value is chosen because it makes the ram_pginfo array be
- * 64kB in size, which is about as large as we want to be trying
- * to allocate with kmalloc.
- */
-#define MAX_MEM_ORDER		36
+#include <linux/hugetlb.h>
 
 #define LARGE_PAGE_ORDER	24	/* 16MB pages */
 
@@ -149,6 +142,7 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 	unsigned long pg_offset;
 	void *va;
 	struct kvm_vcpu *tvcpu;
+	struct kvm_memory_slot *memslot;
 
 	tvcpu = kvmppc_find_vcpu(kvm, vcpuid);
 	if (!tvcpu)
@@ -162,13 +156,14 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 		if (vpa & 0x7f)
 			return H_PARAMETER;
 		/* registering new area; convert logical addr to real */
-		pg_index = vpa >> kvm->arch.ram_porder;
-		pg_offset = vpa & (kvm->arch.ram_psize - 1);
-		if (pg_index >= kvm->arch.ram_npages)
+		pg_index = vpa >> PAGE_SHIFT;
+		pg_offset = vpa & (PAGE_SIZE - 1);
+		memslot = gfn_to_memslot(kvm, pg_index);
+		if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
 			return H_PARAMETER;
-		if (kvm->arch.ram_pginfo[pg_index].pfn == 0)
+		ra = memslot->rmap[pg_index - memslot->base_gfn] << PAGE_SHIFT;
+		if (!ra)
 			return H_PARAMETER;
-		ra = kvm->arch.ram_pginfo[pg_index].pfn << PAGE_SHIFT;
 		ra |= pg_offset;
 		va = __va(ra);
 		if (flags <= 1)
@@ -1079,13 +1074,12 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 				      struct kvm_userspace_memory_region *mem)
 {
 	unsigned long psize, porder;
-	unsigned long i, npages, totalpages;
-	unsigned long pg_ix;
-	struct kvmppc_pginfo *pginfo;
+	unsigned long i, npages;
 	struct kvmppc_rma_info *ri = NULL;
 	struct vm_area_struct *vma;
 	struct page *page;
 	unsigned long hva;
+	unsigned long lpcr;
 
 	/*
 	 * This could be an attempt at adding memory or it could be MMIO
@@ -1098,6 +1092,13 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 	if (!vma || vma->vm_start > mem->userspace_addr)
 		goto err_unlock;
 
+	/* For now require the memory to be in one vma */
+	if (mem->userspace_addr + mem->memory_size > vma->vm_end) {
+		pr_err("not one vma %llx > %lx\n",
+		       mem->userspace_addr + mem->memory_size, vma->vm_end);
+		goto err_unlock;
+	}
+
 	/* Anything with VM_IO will be handled as MMIO pass-through */
 	if (vma->vm_flags & VM_IO) {
 		unsigned long offset = mem->userspace_addr - vma->vm_start;
@@ -1125,6 +1126,9 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 		return 0;
 	}
 
+	psize = vma_kernel_pagesize(vma);
+	porder = __ilog2(psize);
+
 	/* Is this one of our preallocated RMAs? */
 	if (mem->guest_phys_addr == 0) {
 		if (vma && vma->vm_file &&
@@ -1135,9 +1139,6 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 
 	up_read(&current->mm->mmap_sem);
 
-	/* For now, only allow 16MB pages for memory */
-	porder = LARGE_PAGE_ORDER;
-	psize = 1ul << porder;
 	if ((mem->memory_size & (psize - 1)) ||
 	    (mem->guest_phys_addr & (psize - 1))) {
 		pr_err("bad memory_size=%llx @ %llx\n",
@@ -1145,30 +1146,43 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 		return -EINVAL;
 	}
 
-	npages = mem->memory_size >> porder;
-	totalpages = (mem->guest_phys_addr + mem->memory_size) >> porder;
-
-	/* More memory than we have space to track? */
-	if (totalpages > (1ul << (MAX_MEM_ORDER - LARGE_PAGE_ORDER)))
-		return -EINVAL;
-
 	/* Do we already have an RMA registered? */
 	if (mem->guest_phys_addr == 0 && kvm->arch.rma)
 		return -EINVAL;
 
-	if (totalpages > kvm->arch.ram_npages)
-		kvm->arch.ram_npages = totalpages;
+	if (!ri && mem->guest_phys_addr == 0) {
+		if (cpu_has_feature(CPU_FTR_ARCH_201)) {
+			pr_err("CPU requires an RMO\n");
+			return -EINVAL;
+		}
 
-	if (!ri && mem->guest_phys_addr == 0 &&
-	    cpu_has_feature(CPU_FTR_ARCH_201)) {
-		pr_err("CPU requires an RMO\n");
-		return -EINVAL;
+		/* We can handle 4k, 64k and 16M pages in the VRMA */
+		if (!(psize == 0x1000 || psize == 0x1000000 ||
+		      (psize == 0x10000 && cpu_has_feature(CPU_FTR_ARCH_206))))
+			return -EINVAL;
+		lpcr = kvm->arch.lpcr;
+		switch (porder) {
+		case 12:
+			lpcr &= ~(LPCR_VRMA_L);
+			break;
+		case 16:
+			lpcr |= (LPCR_VRMA_L | LPCR_VRMA_LP1);
+			break;
+		case 24:
+			lpcr |= LPCR_VRMA_L;
+			break;
+		}
+		kvm->arch.lpcr = lpcr;
+	}
+
+	if (!ri && psize < kvm->arch.ram_psize) {
+		kvm->arch.ram_psize = psize;
+		kvm->arch.ram_porder = porder;
 	}
 
 	/* Handle pre-allocated RMAs */
 	if (ri) {
 		unsigned long rma_size;
-		unsigned long lpcr;
 		long rmls;
 
 		rma_size = ri->npages << PAGE_SHIFT;
@@ -1181,7 +1195,6 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 		}
 		atomic_inc(&ri->use_count);
 		kvm->arch.rma = ri;
-		kvm->arch.n_rma_pages = rma_size >> porder;
 
 		/* Update LPCR and RMOR */
 		lpcr = kvm->arch.lpcr;
@@ -1205,28 +1218,15 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 			ri->base_pfn << PAGE_SHIFT, rma_size, lpcr);
 	}
 
-	pg_ix = mem->guest_phys_addr >> porder;
-	pginfo = kvm->arch.ram_pginfo + pg_ix;
-	for (i = 0; i < npages; ++i, ++pg_ix) {
-		if (ri && pg_ix < kvm->arch.n_rma_pages) {
-			pginfo[i].pfn = ri->base_pfn +
-				(pg_ix << (porder - PAGE_SHIFT));
-			continue;
-		}
-		hva = mem->userspace_addr + (i << porder);
+	npages = mem->memory_size >> PAGE_SHIFT;
+	for (i = 0; i < npages; ++i) {
+		hva = mem->userspace_addr + (i << PAGE_SHIFT);
 		page = hva_to_page(hva);
 		if (!page) {
 			pr_err("oops, no pfn for hva %lx\n", hva);
 			goto err;
 		}
-		/* Check it's a 16MB page */
-		if (!PageHead(page) ||
-		    compound_order(page) != (LARGE_PAGE_ORDER - PAGE_SHIFT)) {
-			pr_err("page at %lx isn't 16MB (o=%d)\n",
-			       hva, compound_order(page));
-			goto err;
-		}
-		pginfo[i].pfn = page_to_pfn(page);
+		memslot->rmap[i] = page_to_pfn(page);
 	}
 
 	return 0;
@@ -1248,8 +1248,6 @@ void kvmppc_core_commit_memory_region(struct kvm *kvm,
 int kvmppc_core_init_vm(struct kvm *kvm)
 {
 	long r;
-	unsigned long npages = 1ul << (MAX_MEM_ORDER - LARGE_PAGE_ORDER);
-	long err = -ENOMEM;
 	unsigned long lpcr;
 
 	/* Allocate hashed page table */
@@ -1259,19 +1257,9 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 
 	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
 
-	kvm->arch.ram_pginfo = kzalloc(npages * sizeof(struct kvmppc_pginfo),
-				       GFP_KERNEL);
-	if (!kvm->arch.ram_pginfo) {
-		pr_err("kvmppc_core_init_vm: couldn't alloc %lu bytes\n",
-		       npages * sizeof(struct kvmppc_pginfo));
-		goto out_free;
-	}
-
-	kvm->arch.ram_npages = 0;
-	kvm->arch.ram_psize = 1ul << LARGE_PAGE_ORDER;
+	kvm->arch.ram_psize = 1ul << LARGE_PAGE_ORDER;	/* max page size */
 	kvm->arch.ram_porder = LARGE_PAGE_ORDER;
 	kvm->arch.rma = NULL;
-	kvm->arch.n_rma_pages = 0;
 
 	kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
 
@@ -1298,25 +1286,34 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 	kvm->arch.lpcr = lpcr;
 
 	return 0;
-
- out_free:
-	kvmppc_free_hpt(kvm);
-	return err;
 }
 
 void kvmppc_core_destroy_vm(struct kvm *kvm)
 {
-	struct kvmppc_pginfo *pginfo;
-	unsigned long i;
-
-	if (kvm->arch.ram_pginfo) {
-		pginfo = kvm->arch.ram_pginfo;
-		kvm->arch.ram_pginfo = NULL;
-		for (i = kvm->arch.n_rma_pages; i < kvm->arch.ram_npages; ++i)
-			if (pginfo[i].pfn)
-				put_page(pfn_to_page(pginfo[i].pfn));
-		kfree(pginfo);
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *memslot;
+	unsigned long i, j, npages;
+	unsigned long *rmap;
+	struct page *page;
+
+	slots = kvm_memslots(kvm);
+	for (i = 0; i < slots->nmemslots; i++) {
+		memslot = &slots->memslots[i];
+		rmap = memslot->rmap;
+		npages = memslot->npages;
+
+		if ((memslot->flags & KVM_MEMSLOT_INVALID) || !rmap)
+			continue;
+		for (j = 0; j < npages; j++) {
+			if (rmap[j]) {
+				page = pfn_to_page(rmap[j]);
+				if (PageHuge(page))
+					page = compound_head(page);
+				put_page(page);
+			}
+		}
 	}
+
 	if (kvm->arch.rma) {
 		kvm_release_rma(kvm->arch.rma);
 		kvm->arch.rma = NULL;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 2da8fac..b82da85 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -61,10 +61,12 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 {
 	unsigned long porder;
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long i, lpn, pa, gpa, psize;
+	unsigned long i, pa, gpa, gfn, psize;
 	unsigned long *hpte;
 	struct revmap_entry *rev;
 	unsigned long g_ptel = ptel;
+	struct kvm_memory_slot *memslot;
+	unsigned long *rmap_entry;
 
 	/* only handle 4k, 64k and 16M pages for now */
 	porder = 12;
@@ -108,59 +110,57 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	 * first check for RAM pages
 	 */
 	gpa = (ptel & HPTE_R_RPN) & ~(psize - 1);
-	if ((gpa >> kvm->arch.ram_porder) < kvm->arch.ram_npages) {
-		lpn = (ptel & HPTE_R_RPN) >> kvm->arch.ram_porder;
-		if (porder > kvm->arch.ram_porder)
-			return H_PARAMETER;
-		pa = kvm->arch.ram_pginfo[lpn].pfn << PAGE_SHIFT;
-		if (!pa)
-			return H_PARAMETER;
-		/* Check WIMG */
-		if ((ptel & HPTE_R_WIMG) != HPTE_R_M &&
-		    (ptel & HPTE_R_WIMG) != (HPTE_R_W | HPTE_R_I | HPTE_R_M))
+	gfn = gpa >> PAGE_SHIFT;
+	memslot = builtin_gfn_to_memslot(kvm, gfn);
+	if (memslot && !(memslot->flags & KVM_MEMSLOT_INVALID)) {
+		unsigned long egfn = (gpa + psize) >> PAGE_SHIFT;
+
+		/* Check if the requested page fits entirely in the memslot. */
+		if ((egfn - memslot->base_gfn) > memslot->npages)
 			return H_PARAMETER;
-		ptel &= ~(HPTE_R_PP0 - kvm->arch.ram_psize);
-		ptel |= pa;
-	} else {
-		struct kvm_memory_slot *memslot;
-
-		/* Check WIMG */
-		if ((ptel & HPTE_R_WIMG) != (HPTE_R_I) &&
-		    (ptel & HPTE_R_WIMG) != (HPTE_R_I | HPTE_R_G))
-			return H_PARAMETER;		
-
-		/* Else check for MMIO pass-through */
-		memslot = builtin_gfn_to_memslot(kvm, gpa >> PAGE_SHIFT);
-		if (memslot && memslot->flags & KVM_MEMSLOT_IO) {
-			unsigned long egfn = (gpa + psize) >> PAGE_SHIFT;
-
-			/* Check if the requested page fits entirely in
-			 * the memslot and check if the start pfn fits
-			 * out page size alignment
-			 */
-			if ((egfn - memslot->base_gfn) > memslot->npages)
-				return H_PARAMETER;
+
+		/* Check for MMIO pass-through */
+		if (memslot->flags & KVM_MEMSLOT_IO) {
+			/* check if the start pfn has page size alignment */
 			pa = kvm->arch.io_slot_pfn[memslot->id] << PAGE_SHIFT;
 			pa += gpa - (memslot->base_gfn << PAGE_SHIFT);
 			if (pa & (psize - 1))
 				return H_PARAMETER;
 
-			/* Make up HPTE */
-			ptel &= ~(HPTE_R_PP0 - psize);
-			ptel |= pa;
+			/* Check WIMG */
+			if ((ptel & HPTE_R_WIMG) != (HPTE_R_I) &&
+			    (ptel & HPTE_R_WIMG) != (HPTE_R_I | HPTE_R_G))
+				return H_PARAMETER;		
+		} else {
+			/* System RAM */
+			if (porder > kvm->arch.ram_porder)
+				return H_PARAMETER;
+			rmap_entry = &memslot->rmap[gfn - memslot->base_gfn];
+			rmap_entry = real_vmalloc_addr(rmap_entry);
+			pa = *rmap_entry << PAGE_SHIFT;
+			if (!pa)
+				return H_PARAMETER;
+
+			/* Check WIMG */
+			if ((ptel & HPTE_R_WIMG) != HPTE_R_M &&
+			    (ptel & HPTE_R_WIMG) != (HPTE_R_W | HPTE_R_I | HPTE_R_M))
+				return H_PARAMETER;
 		}
+		ptel &= ~(HPTE_R_PP0 - psize);
+		ptel |= pa;
+
+	} else {
 		/* Else check for MMIO emulation */
-		else if (cpu_has_feature(CPU_FTR_ARCH_206)) {
-			/* Leave RPN intact */
-
-			/* We force no-execute and set key to 1 to cause
-			 * faults on access.
-			 * XXX Should we instead just return H_PARAMETER if
-			 * N isn't already set ?
-			 */
-			ptel |= HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_R_N;
-		} else
+		if (!cpu_has_feature(CPU_FTR_ARCH_206))
 			return H_PARAMETER;
+
+		/* Leave RPN intact */
+		/* We force no-execute and set key to 1 to cause
+		 * faults on access.
+		 * XXX Should we instead just return H_PARAMETER if
+		 * N isn't already set ?
+		 */
+		ptel |= HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_R_N;
 	}
 	pteh &= ~0x60UL;
 	
-- 
1.7.7.2
