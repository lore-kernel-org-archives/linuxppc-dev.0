Return-Path: <paulus@ozlabs.org>
Date: Tue, 6 Dec 2011 17:04:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH 03/13] KVM: PPC: Keep page physical addresses in per-slot
 arrays
Message-ID: <20111206060401.GG12389@drongo>
References: <20111206060156.GD12389@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111206060156.GD12389@drongo>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allocates an array for each memory slot that is added to store
the physical addresses of the pages in the slot.  This array is
vmalloc'd and accessed in kvmppc_h_enter using real_vmalloc_addr().
This allows us to remove the ram_pginfo field from the kvm_arch
struct, and removes the 64GB guest RAM limit that we had.

We use the low-order bits of the array entries to store a flag
indicating that we have done get_page on the corresponding page,
and therefore need to call put_page when we are finished with the
page.  Currently this is set for all pages except those in our
special RMO regions.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_host.h |    8 ++-
 arch/powerpc/kvm/book3s_64_mmu_hv.c |   18 +++---
 arch/powerpc/kvm/book3s_hv.c        |  114 +++++++++++++++++------------------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c |   44 ++++++++++++-
 4 files changed, 109 insertions(+), 75 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 629df2e..cf6b4d7 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -175,25 +175,27 @@ struct revmap_entry {
 	unsigned long guest_rpte;
 };
 
+/* Low-order bits in kvm->arch.slot_phys[][] */
+#define KVMPPC_GOT_PAGE		0x80
+
 struct kvm_arch {
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
 	struct list_head spapr_tce_tables;
+	unsigned long *slot_phys[KVM_MEMORY_SLOTS + KVM_PRIVATE_MEM_SLOTS];
+	int slot_npages[KVM_MEMORY_SLOTS + KVM_PRIVATE_MEM_SLOTS];
 	unsigned short last_vcpu[NR_CPUS];
 	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
 #endif /* CONFIG_KVM_BOOK3S_64_HV */
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 80ece8d..e4c6069 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -98,16 +98,16 @@ void kvmppc_free_hpt(struct kvm *kvm)
 void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 {
 	unsigned long i;
-	unsigned long npages = kvm->arch.ram_npages;
-	unsigned long pfn;
+	unsigned long npages;
+	unsigned long pa;
 	unsigned long *hpte;
 	unsigned long hash;
 	unsigned long porder = kvm->arch.ram_porder;
 	struct revmap_entry *rev;
-	struct kvmppc_pginfo *pginfo = kvm->arch.ram_pginfo;
+	unsigned long *physp;
 
-	if (!pginfo)
-		return;
+	physp = kvm->arch.slot_phys[mem->slot];
+	npages = kvm->arch.slot_npages[mem->slot];
 
 	/* VRMA can't be > 1TB */
 	if (npages > 1ul << (40 - porder))
@@ -117,9 +117,10 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 		npages = HPT_NPTEG;
 
 	for (i = 0; i < npages; ++i) {
-		pfn = pginfo[i].pfn;
-		if (!pfn)
+		pa = physp[i];
+		if (!pa)
 			break;
+		pa &= PAGE_MASK;
 		/* can't use hpt_hash since va > 64 bits */
 		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & HPT_HASH_MASK;
 		/*
@@ -131,8 +132,7 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 		hash = (hash << 3) + 7;
 		hpte = (unsigned long *) (kvm->arch.hpt_virt + (hash << 4));
 		/* HPTE low word - RPN, protection, etc. */
-		hpte[1] = (pfn << PAGE_SHIFT) | HPTE_R_R | HPTE_R_C |
-			HPTE_R_M | PP_RWXX;
+		hpte[1] = pa | HPTE_R_R | HPTE_R_C | HPTE_R_M | PP_RWXX;
 		smp_wmb();
 		hpte[0] = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
 			(i << (VRMA_PAGE_ORDER - 16)) | HPTE_V_BOLTED |
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5efdd5b..c2ee5a7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -48,14 +48,6 @@
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
 
-/*
- * For now, limit memory to 64GB and require it to be large pages.
- * This value is chosen because it makes the ram_pginfo array be
- * 64kB in size, which is about as large as we want to be trying
- * to allocate with kmalloc.
- */
-#define MAX_MEM_ORDER		36
-
 #define LARGE_PAGE_ORDER	24	/* 16MB pages */
 
 /* #define EXIT_DEBUG */
@@ -145,10 +137,12 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 				       unsigned long vcpuid, unsigned long vpa)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long pg_index, ra, len;
+	unsigned long gfn, pg_index, ra, len;
 	unsigned long pg_offset;
 	void *va;
 	struct kvm_vcpu *tvcpu;
+	struct kvm_memory_slot *memslot;
+	unsigned long *physp;
 
 	tvcpu = kvmppc_find_vcpu(kvm, vcpuid);
 	if (!tvcpu)
@@ -162,14 +156,20 @@ static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
 		if (vpa & 0x7f)
 			return H_PARAMETER;
 		/* registering new area; convert logical addr to real */
-		pg_index = vpa >> kvm->arch.ram_porder;
-		pg_offset = vpa & (kvm->arch.ram_psize - 1);
-		if (pg_index >= kvm->arch.ram_npages)
+		gfn = vpa >> PAGE_SHIFT;
+		memslot = gfn_to_memslot(kvm, gfn);
+		if (!memslot || !(memslot->flags & KVM_MEMSLOT_INVALID))
+			return H_PARAMETER;
+		physp = kvm->arch.slot_phys[memslot->id];
+		if (!physp)
 			return H_PARAMETER;
-		if (kvm->arch.ram_pginfo[pg_index].pfn == 0)
+		pg_index = (gfn - memslot->base_gfn) >>
+			(kvm->arch.ram_porder - PAGE_SHIFT);
+		pg_offset = vpa & (kvm->arch.ram_psize - 1);
+		ra = physp[pg_index];
+		if (!ra)
 			return H_PARAMETER;
-		ra = kvm->arch.ram_pginfo[pg_index].pfn << PAGE_SHIFT;
-		ra |= pg_offset;
+		ra = (ra & PAGE_MASK) | pg_offset;
 		va = __va(ra);
 		if (flags <= 1)
 			len = *(unsigned short *)(va + 4);
@@ -1106,12 +1106,11 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem)
 {
 	unsigned long psize, porder;
-	unsigned long i, npages, totalpages;
-	unsigned long pg_ix;
-	struct kvmppc_pginfo *pginfo;
+	unsigned long i, npages;
 	unsigned long hva;
 	struct kvmppc_rma_info *ri = NULL;
 	struct page *page;
+	unsigned long *phys;
 
 	/* For now, only allow 16MB pages */
 	porder = LARGE_PAGE_ORDER;
@@ -1123,20 +1122,21 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 		return -EINVAL;
 	}
 
+	/* Allocate a slot_phys array */
 	npages = mem->memory_size >> porder;
-	totalpages = (mem->guest_phys_addr + mem->memory_size) >> porder;
-
-	/* More memory than we have space to track? */
-	if (totalpages > (1ul << (MAX_MEM_ORDER - LARGE_PAGE_ORDER)))
-		return -EINVAL;
+	phys = kvm->arch.slot_phys[mem->slot];
+	if (!phys) {
+		phys = vzalloc(npages * sizeof(unsigned long));
+		if (!phys)
+			return -ENOMEM;
+		kvm->arch.slot_phys[mem->slot] = phys;
+		kvm->arch.slot_npages[mem->slot] = npages;
+	}
 
 	/* Do we already have an RMA registered? */
 	if (mem->guest_phys_addr == 0 && kvm->arch.rma)
 		return -EINVAL;
 
-	if (totalpages > kvm->arch.ram_npages)
-		kvm->arch.ram_npages = totalpages;
-
 	/* Is this one of our preallocated RMAs? */
 	if (mem->guest_phys_addr == 0) {
 		struct vm_area_struct *vma;
@@ -1169,7 +1169,6 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 		}
 		atomic_inc(&ri->use_count);
 		kvm->arch.rma = ri;
-		kvm->arch.n_rma_pages = rma_size >> porder;
 
 		/* Update LPCR and RMOR */
 		lpcr = kvm->arch.lpcr;
@@ -1193,12 +1192,9 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 			ri->base_pfn << PAGE_SHIFT, rma_size, lpcr);
 	}
 
-	pg_ix = mem->guest_phys_addr >> porder;
-	pginfo = kvm->arch.ram_pginfo + pg_ix;
-	for (i = 0; i < npages; ++i, ++pg_ix) {
-		if (ri && pg_ix < kvm->arch.n_rma_pages) {
-			pginfo[i].pfn = ri->base_pfn +
-				(pg_ix << (porder - PAGE_SHIFT));
+	for (i = 0; i < npages; ++i) {
+		if (ri && i < ri->npages) {
+			phys[i] = (ri->base_pfn << PAGE_SHIFT) + (i << porder);
 			continue;
 		}
 		hva = mem->userspace_addr + (i << porder);
@@ -1214,7 +1210,7 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 			       hva, compound_order(page));
 			goto err;
 		}
-		pginfo[i].pfn = page_to_pfn(page);
+		phys[i] = (page_to_pfn(page) << PAGE_SHIFT) | KVMPPC_GOT_PAGE;
 	}
 
 	return 0;
@@ -1223,6 +1219,28 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 	return -EINVAL;
 }
 
+static void unpin_slot(struct kvm *kvm, int slot_id)
+{
+	unsigned long *physp;
+	unsigned long j, npages, pfn;
+	struct page *page;
+
+	physp = kvm->arch.slot_phys[slot_id];
+	npages = kvm->arch.slot_npages[slot_id];
+	if (physp) {
+		for (j = 0; j < npages; j++) {
+			if (!(physp[j] & KVMPPC_GOT_PAGE))
+				continue;
+			pfn = physp[j] >> PAGE_SHIFT;
+			page = pfn_to_page(pfn);
+			SetPageDirty(page);
+			put_page(page);
+		}
+		vfree(physp);
+		kvm->arch.slot_phys[slot_id] = NULL;
+	}
+}
+
 void kvmppc_core_commit_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem)
 {
@@ -1234,8 +1252,6 @@ void kvmppc_core_commit_memory_region(struct kvm *kvm,
 int kvmppc_core_init_vm(struct kvm *kvm)
 {
 	long r;
-	unsigned long npages = 1ul << (MAX_MEM_ORDER - LARGE_PAGE_ORDER);
-	long err = -ENOMEM;
 	unsigned long lpcr;
 
 	/* Allocate hashed page table */
@@ -1245,19 +1261,9 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 
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
 	kvm->arch.ram_psize = 1ul << LARGE_PAGE_ORDER;
 	kvm->arch.ram_porder = LARGE_PAGE_ORDER;
 	kvm->arch.rma = NULL;
-	kvm->arch.n_rma_pages = 0;
 
 	kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
 
@@ -1280,25 +1286,15 @@ int kvmppc_core_init_vm(struct kvm *kvm)
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
 	unsigned long i;
 
-	if (kvm->arch.ram_pginfo) {
-		pginfo = kvm->arch.ram_pginfo;
-		kvm->arch.ram_pginfo = NULL;
-		for (i = kvm->arch.n_rma_pages; i < kvm->arch.ram_npages; ++i)
-			if (pginfo[i].pfn)
-				put_page(pfn_to_page(pginfo[i].pfn));
-		kfree(pginfo);
-	}
+	for (i = 0; i < KVM_MEMORY_SLOTS + KVM_PRIVATE_MEM_SLOTS; i++)
+		unpin_slot(kvm, i);
+
 	if (kvm->arch.rma) {
 		kvm_release_rma(kvm->arch.rma);
 		kvm->arch.rma = NULL;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 6148493..5f45ba7 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -20,6 +20,28 @@
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
 
+/*
+ * Since this file is built in even if KVM is a module, we need
+ * a local copy of this function for the case where kvm_main.c is
+ * modular.
+ */
+static struct kvm_memory_slot *builtin_gfn_to_memslot(struct kvm *kvm,
+						gfn_t gfn)
+{
+	int i;
+	struct kvm_memslots *slots;
+
+	slots = kvm_memslots(kvm);
+	for (i = 0; i < slots->nmemslots; ++i) {
+		struct kvm_memory_slot *memslot = &slots->memslots[i];
+
+		if (gfn >= memslot->base_gfn
+		    && gfn < memslot->base_gfn + memslot->npages)
+			return memslot;
+	}
+	return NULL;
+}
+
 /* Translate address of a vmalloc'd thing to a linear map address */
 static void *real_vmalloc_addr(void *x)
 {
@@ -59,10 +81,12 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 {
 	unsigned long porder;
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long i, lpn, pa;
+	unsigned long i, gfn, lpn, pa;
 	unsigned long *hpte;
 	struct revmap_entry *rev;
 	unsigned long g_ptel = ptel;
+	struct kvm_memory_slot *memslot;
+	unsigned long *physp;
 
 	/* only handle 4k, 64k and 16M pages for now */
 	porder = 12;
@@ -80,12 +104,24 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		} else
 			return H_PARAMETER;
 	}
-	lpn = (ptel & HPTE_R_RPN) >> kvm->arch.ram_porder;
-	if (lpn >= kvm->arch.ram_npages || porder > kvm->arch.ram_porder)
+	if (porder > kvm->arch.ram_porder)
+		return H_PARAMETER;
+
+	gfn = ((ptel & HPTE_R_RPN) & ~((1ul << porder) - 1)) >> PAGE_SHIFT;
+	memslot = builtin_gfn_to_memslot(kvm, gfn);
+	if (!(memslot && !(memslot->flags & KVM_MEMSLOT_INVALID)))
 		return H_PARAMETER;
-	pa = kvm->arch.ram_pginfo[lpn].pfn << PAGE_SHIFT;
+	physp = kvm->arch.slot_phys[memslot->id];
+	if (!physp)
+		return H_PARAMETER;
+
+	lpn = (gfn - memslot->base_gfn) >> (kvm->arch.ram_porder - PAGE_SHIFT);
+	physp = real_vmalloc_addr(physp + lpn);
+	pa = *physp;
 	if (!pa)
 		return H_PARAMETER;
+	pa &= PAGE_MASK;
+
 	/* Check WIMG */
 	if ((ptel & HPTE_R_WIMG) != HPTE_R_M &&
 	    (ptel & HPTE_R_WIMG) != (HPTE_R_W | HPTE_R_I | HPTE_R_M))
-- 
1.7.5.4
