Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Nov 2011 09:59:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 05/11] KVM: PPC: Use a separate vmalloc'd array to store pfns
Message-ID: <20111116225916.GF26985@bloggs.ozlabs.ibm.com>
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

This changes the book3s_hv code to store the page frame numbers in
a separate vmalloc'd array, pointed to by an array in struct kvm_arch,
rather than the memslot->rmap arrays.  This frees up the rmap arrays
to be used later to store reverse mapping information.  For large page
regions, we now store only one pfn per large page rather than one pfn
per small page.  This reduces the size of the pfns arrays and eliminates
redundant get_page and put_page calls.

We also now pin the guest pages and store the pfns in the commit_memory
function rather than the prepare_memory function.  This avoids a memory
leak should the add memory procedure hit an error after calling the
prepare_memory function.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |   15 ++++
 arch/powerpc/include/asm/kvm_host.h      |    4 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |   10 ++-
 arch/powerpc/kvm/book3s_hv.c             |  124 +++++++++++++++++++-----------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |   14 ++--
 5 files changed, 112 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 63542dd..9243f35 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -106,4 +106,19 @@ static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
 	return 0;				/* error */
 }
 
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+static inline unsigned long *kvmppc_pfn_entry(struct kvm *kvm,
+			struct kvm_memory_slot *memslot, unsigned long gfn)
+{
+	int id = memslot->id;
+	unsigned long index;
+
+	if (!kvm->arch.slot_pfns[id])
+		return NULL;
+	index = gfn - memslot->base_gfn;
+	index >>= kvm->arch.slot_page_order[id] - PAGE_SHIFT;
+	return &kvm->arch.slot_pfns[id][index];
+}
+#endif /* CONFIG_KVM_BOOK3S_64_HV */
+
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index e0751e5..93b7e04 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -174,8 +174,6 @@ struct kvm_arch {
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	unsigned long hpt_virt;
 	struct revmap_entry *revmap;
-	unsigned long ram_psize;
-	unsigned long ram_porder;
 	unsigned int lpid;
 	unsigned int host_lpid;
 	unsigned long host_lpcr;
@@ -186,6 +184,8 @@ struct kvm_arch {
 	unsigned long rmor;
 	struct kvmppc_rma_info *rma;
 	struct list_head spapr_tce_tables;
+	unsigned long *slot_pfns[KVM_MEMORY_SLOTS + KVM_PRIVATE_MEM_SLOTS];
+	int slot_page_order[KVM_MEMORY_SLOTS + KVM_PRIVATE_MEM_SLOTS];
 	unsigned short last_vcpu[NR_CPUS];
 	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
 #endif /* CONFIG_KVM_BOOK3S_64_HV */
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index bed6c61..4d558c4 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -112,13 +112,17 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 	unsigned long pfn;
 	unsigned long *hpte;
 	unsigned long addr, hash;
-	unsigned long psize = kvm->arch.ram_psize;
-	unsigned long porder = kvm->arch.ram_porder;
+	unsigned long psize;
+	int porder;
 	struct revmap_entry *rev;
 	struct kvm_memory_slot *memslot;
 	unsigned long hp0, hp1;
+	unsigned long *pfns;
 
 	memslot = &kvm->memslots->memslots[mem->slot];
+	pfns = kvm->arch.slot_pfns[mem->slot];
+	porder = kvm->arch.slot_page_order[mem->slot];
+	psize = 1ul << porder;
 	npages = memslot->npages >> (porder - PAGE_SHIFT);
 
 	/* VRMA can't be > 1TB */
@@ -134,7 +138,7 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 		HPTE_R_R | HPTE_R_C | HPTE_R_M | PP_RWXX;
 
 	for (i = 0; i < npages; ++i) {
-		pfn = memslot->rmap[i << (porder - PAGE_SHIFT)];
+		pfn = pfns[i];
 		if (!pfn)
 			continue;
 		addr = i << porder;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 48a0648..7434258 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -133,16 +133,40 @@ static void init_vpa(struct kvm_vcpu *vcpu, struct lppaca *vpa)
 	vpa->yield_count = 1;
 }
 
+unsigned long kvmppc_logical_to_real(struct kvm *kvm, unsigned long gpa,
+				     unsigned long *nb_ret)
+{
+	struct kvm_memory_slot *memslot;
+	unsigned long gfn, ra, offset;
+	unsigned long *pfnp;
+	unsigned long pg_size;
+
+	gfn = gpa >> PAGE_SHIFT;
+	memslot = gfn_to_memslot(kvm, gfn);
+	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
+		return 0;
+	pfnp = kvmppc_pfn_entry(kvm, memslot, gfn);
+	if (!pfnp)
+		return 0;
+	ra = *pfnp << PAGE_SHIFT;
+	if (!ra)
+		return 0;
+	pg_size = 1ul << kvm->arch.slot_page_order[memslot->id];
+	offset = gpa & (pg_size - 1);
+	if (nb_ret)
+		*nb_ret = pg_size - offset;
+	return ra + offset;
+}
+
 static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 				       unsigned long flags,
 				       unsigned long vcpuid, unsigned long vpa)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long pg_index, ra, len;
-	unsigned long pg_offset;
+	unsigned long ra, len;
+	unsigned long nb;
 	void *va;
 	struct kvm_vcpu *tvcpu;
-	struct kvm_memory_slot *memslot;
 
 	tvcpu = kvmppc_find_vcpu(kvm, vcpuid);
 	if (!tvcpu)
@@ -156,21 +180,15 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 		if (vpa & 0x7f)
 			return H_PARAMETER;
 		/* registering new area; convert logical addr to real */
-		pg_index = vpa >> PAGE_SHIFT;
-		pg_offset = vpa & (PAGE_SIZE - 1);
-		memslot = gfn_to_memslot(kvm, pg_index);
-		if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
-			return H_PARAMETER;
-		ra = memslot->rmap[pg_index - memslot->base_gfn] << PAGE_SHIFT;
+		ra = kvmppc_logical_to_real(kvm, vpa, &nb);
 		if (!ra)
 			return H_PARAMETER;
-		ra |= pg_offset;
 		va = __va(ra);
 		if (flags <= 1)
 			len = *(unsigned short *)(va + 4);
 		else
 			len = *(unsigned int *)(va + 4);
-		if (pg_offset + len > kvm->arch.ram_psize)
+		if (len > nb)
 			return H_PARAMETER;
 		switch (flags) {
 		case 1:		/* register VPA */
@@ -1077,9 +1095,11 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 	unsigned long i, npages;
 	struct kvmppc_rma_info *ri = NULL;
 	struct vm_area_struct *vma;
-	struct page *page;
-	unsigned long hva, pfn;
+	unsigned long pfn;
 	unsigned long lpcr;
+	unsigned long *pfns = NULL;
+
+	npages = mem->memory_size >> PAGE_SHIFT;
 
 	/*
 	 * This could be an attempt at adding memory or it could be MMIO
@@ -1092,8 +1112,6 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 	if (!vma || vma->vm_start > mem->userspace_addr)
 		goto err_unlock;
 
-	npages = mem->memory_size >> PAGE_SHIFT;
-
 	/* For now require the memory to be in one vma */
 	if (mem->userspace_addr + mem->memory_size > vma->vm_end) {
 		pr_err("not one vma %llx > %lx\n",
@@ -1120,12 +1138,17 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 
 		/*
 		 * Tag the memslot with a private flag and store the pfns
-		 * in the rmap array.
+		 * in the pfns array.
 		 */
+		pfns = vzalloc(npages * sizeof(unsigned long));
+		if (!pfns)
+			return -ENOMEM;
+		kvm->arch.slot_pfns[mem->slot] = pfns;
+		kvm->arch.slot_page_order[mem->slot] = PAGE_SHIFT;
 		memslot->flags |= KVM_MEMSLOT_IO;
 		pfn = vma->vm_pgoff + (offset >> PAGE_SHIFT);
 		for (i = 0; i < npages; ++i)
-			memslot->rmap[i] = pfn++;
+			pfns[i] = pfn++;
 		return 0;
 	}
 
@@ -1146,23 +1169,23 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 	    (mem->guest_phys_addr & (psize - 1))) {
 		pr_err("bad memory_size=%llx @ %llx\n",
 		       mem->memory_size, mem->guest_phys_addr);
-		return -EINVAL;
+		goto err;
 	}
 
 	/* Do we already have an RMA registered? */
 	if (mem->guest_phys_addr == 0 && kvm->arch.rma)
-		return -EINVAL;
+		goto err;
 
 	if (!ri && mem->guest_phys_addr == 0) {
 		if (cpu_has_feature(CPU_FTR_ARCH_201)) {
 			pr_err("CPU requires an RMO\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		/* We can handle 4k, 64k and 16M pages in the VRMA */
 		if (!(psize == 0x1000 || psize == 0x1000000 ||
 		      (psize == 0x10000 && cpu_has_feature(CPU_FTR_ARCH_206))))
-			return -EINVAL;
+			goto err;
 		lpcr = kvm->arch.lpcr;
 		switch (porder) {
 		case 12:
@@ -1178,10 +1201,7 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 		kvm->arch.lpcr = lpcr;
 	}
 
-	if (!ri && psize < kvm->arch.ram_psize) {
-		kvm->arch.ram_psize = psize;
-		kvm->arch.ram_porder = porder;
-	}
+	kvm->arch.slot_page_order[mem->slot] = porder;
 
 	/* Handle pre-allocated RMAs */
 	if (ri) {
@@ -1194,7 +1214,7 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 		rmls = lpcr_rmls(rma_size);
 		if (rmls < 0) {
 			pr_err("Can't use RMA of 0x%lx bytes\n", rma_size);
-			return -EINVAL;
+			goto err;
 		}
 		atomic_inc(&ri->use_count);
 		kvm->arch.rma = ri;
@@ -1221,15 +1241,11 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 			ri->base_pfn << PAGE_SHIFT, rma_size, lpcr);
 	}
 
-	for (i = 0; i < npages; ++i) {
-		hva = mem->userspace_addr + (i << PAGE_SHIFT);
-		page = hva_to_page(hva);
-		if (!page) {
-			pr_err("oops, no pfn for hva %lx\n", hva);
-			goto err;
-		}
-		memslot->rmap[i] = page_to_pfn(page);
-	}
+
+	pfns = vzalloc(npages * sizeof(unsigned long));
+	if (!pfns)
+		return -ENOMEM;
+	kvm->arch.slot_pfns[mem->slot] = pfns;
 
 	return 0;
 
@@ -1242,6 +1258,25 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 void kvmppc_core_commit_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem)
 {
+	unsigned long i, npages, *pfns;
+	unsigned long hva;
+	unsigned long porder = kvm->arch.slot_page_order[mem->slot];
+	struct page *page;
+	struct kvm_memory_slot *memslot;
+
+	memslot = &kvm->memslots->memslots[mem->slot];
+	if (memslot->flags & KVM_MEMSLOT_IO)
+		return;
+
+	pfns = kvm->arch.slot_pfns[mem->slot];
+	npages = mem->memory_size >> porder;
+	for (i = 0; i < npages; ++i) {
+		hva = mem->userspace_addr + (i << porder);
+		page = hva_to_page(hva);
+		if (page)
+			pfns[i] = page_to_pfn(page);
+	}
+
 	if (mem->guest_phys_addr == 0 && mem->memory_size != 0 &&
 	    !kvm->arch.rma)
 		kvmppc_map_vrma(kvm, mem);
@@ -1259,10 +1294,7 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 
 	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
 
-	kvm->arch.ram_psize = 1ul << LARGE_PAGE_ORDER;	/* max page size */
-	kvm->arch.ram_porder = LARGE_PAGE_ORDER;
 	kvm->arch.rma = NULL;
-
 	kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
 
 	if (cpu_has_feature(CPU_FTR_ARCH_201)) {
@@ -1295,25 +1327,29 @@ void kvmppc_core_destroy_vm(struct kvm *kvm)
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
 	unsigned long i, j, npages;
-	unsigned long *rmap;
+	unsigned long *pfns;
 	struct page *page;
+	unsigned long porder;
 
 	slots = kvm_memslots(kvm);
 	for (i = 0; i < slots->nmemslots; i++) {
 		memslot = &slots->memslots[i];
-		rmap = memslot->rmap;
-		npages = memslot->npages;
+		pfns = kvm->arch.slot_pfns[i];
+		porder = kvm->arch.slot_page_order[i];
+		npages = memslot->npages >> (porder - PAGE_SHIFT);
 
-		if ((memslot->flags & KVM_MEMSLOT_INVALID) || !rmap)
+		if ((memslot->flags & KVM_MEMSLOT_INVALID) || !pfns)
 			continue;
 		for (j = 0; j < npages; j++) {
-			if (rmap[j]) {
-				page = pfn_to_page(rmap[j]);
+			if (pfns[j]) {
+				page = pfn_to_page(pfns[j]);
 				if (PageHuge(page))
 					page = compound_head(page);
 				put_page(page);
 			}
 		}
+		vfree(pfns);
+		kvm->arch.slot_pfns[i] = NULL;
 	}
 
 	if (kvm->arch.rma) {
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 5a84791..5438442 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -66,7 +66,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	struct revmap_entry *rev;
 	unsigned long g_ptel = ptel;
 	struct kvm_memory_slot *memslot;
-	unsigned long *rmap_entry;
+	unsigned long *pfnp, pte_size;
 
 	/* only handle 4k, 64k and 16M pages for now */
 	porder = 12;
@@ -127,7 +127,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 				return H_PARAMETER;		
 		} else {
 			/* System RAM */
-			if (porder > kvm->arch.ram_porder)
+			if (porder > kvm->arch.slot_page_order[memslot->id])
 				return H_PARAMETER;
 
 			/* Check WIMG */
@@ -135,13 +135,15 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			    (ptel & HPTE_R_WIMG) != (HPTE_R_W | HPTE_R_I | HPTE_R_M))
 				return H_PARAMETER;
 		}
-		rmap_entry = &memslot->rmap[gfn - memslot->base_gfn];
-		rmap_entry = real_vmalloc_addr(rmap_entry);
-		if (!rmap_entry)
+		pfnp = kvmppc_pfn_entry(kvm, memslot, gfn);
+		if (!pfnp)
 			return H_PARAMETER;
-		pa = *rmap_entry << PAGE_SHIFT;
+		pfnp = real_vmalloc_addr(pfnp);
+		pa = *pfnp << PAGE_SHIFT;
 		if (!pa)
 			return H_PARAMETER;
+		pte_size = 1ul << kvm->arch.slot_page_order[memslot->id];
+		pa |= gpa & (pte_size - 1);
 
 		/* check if the start pfn has page size alignment */
 		if (pa & (psize - 1))
-- 
1.7.7.2
