Return-Path: <paulus@ozlabs.org>
Date: Tue, 13 Dec 2011 09:31:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH v3 07/14] KVM: PPC: Only get pages when actually needed, not
 in prepare_memory_region()
Message-ID: <20111212223100.GH18868@bloggs.ozlabs.ibm.com>
References: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes the code from kvmppc_core_prepare_memory_region() that
looked up the VMA for the region being added and called hva_to_page
to get the pfns for the memory.  We have no guarantee that there will
be anything mapped there at the time of the KVM_SET_USER_MEMORY_REGION
ioctl call; userspace can do that ioctl and then map memory into the
region later.

Instead we defer looking up the pfn for each memory page until it is
needed, which generally means when the guest does an H_ENTER hcall on
the page.  Since we can't call get_user_pages in real mode, if we don't
already have the pfn for the page, kvmppc_h_enter() will return
H_TOO_HARD and we then call kvmppc_virtmode_h_enter() once we get back
to kernel context.  That calls kvmppc_get_guest_page() to get the pfn
for the page, and then calls back to kvmppc_h_enter() to redo the HPTE
insertion.

When the first vcpu starts executing, we need to have the RMO or VRMA
region mapped so that the guest's real mode accesses will work.  Thus
we now have a check in kvmppc_vcpu_run() to see if the RMO/VRMA is set
up and if not, call kvmppc_hv_setup_rma().  It checks if the memslot
starting at guest physical 0 now has RMO memory mapped there; if so it
sets it up for the guest, otherwise on POWER7 it sets up the VRMA.
The function that does that, kvmppc_map_vrma, is now a bit simpler,
as it calls kvmppc_virtmode_h_enter instead of creating the HPTE itself.

Since we are now potentially updating entries in the slot_phys[]
arrays from multiple vcpu threads, we now have a spinlock protecting
those updates to ensure that we don't lose track of any references
to pages.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h    |    4 +
 arch/powerpc/include/asm/kvm_book3s_64.h |   12 ++
 arch/powerpc/include/asm/kvm_host.h      |    2 +
 arch/powerpc/include/asm/kvm_ppc.h       |    4 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  130 +++++++++++++---
 arch/powerpc/kvm/book3s_hv.c             |  244 +++++++++++++++++-------------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |   54 ++++----
 7 files changed, 290 insertions(+), 160 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index a2a89c6..5329c21 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -143,6 +143,10 @@ extern pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 extern void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long addr,
 			unsigned long *nb_ret);
 extern void kvmppc_unpin_guest_page(struct kvm *kvm, void *addr);
+extern long kvmppc_virtmode_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
+			long pte_index, unsigned long pteh, unsigned long ptel);
+extern long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
+			long pte_index, unsigned long pteh, unsigned long ptel);
 
 extern void kvmppc_entry_trampoline(void);
 extern void kvmppc_hv_entry_trampoline(void);
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 300ec04..7e6f2ed 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -101,4 +101,16 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 	return rb;
 }
 
+static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
+{
+	/* only handle 4k, 64k and 16M pages for now */
+	if (!(h & HPTE_V_LARGE))
+		return 1ul << 12;		/* 4k page */
+	if ((l & 0xf000) == 0x1000 && cpu_has_feature(CPU_FTR_ARCH_206))
+		return 1ul << 16;		/* 64k page */
+	if ((l & 0xff000) == 0)
+		return 1ul << 24;		/* 16M page */
+	return 0;				/* error */
+}
+
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 7a17ab5..beb22ba 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -194,7 +194,9 @@ struct kvm_arch {
 	unsigned long lpcr;
 	unsigned long rmor;
 	struct kvmppc_rma_info *rma;
+	int rma_setup_done;
 	struct list_head spapr_tce_tables;
+	spinlock_t slot_phys_lock;
 	unsigned long *slot_phys[KVM_MEM_SLOTS_NUM];
 	int slot_npages[KVM_MEM_SLOTS_NUM];
 	unsigned short last_vcpu[NR_CPUS];
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index fc2d696..111e1b4 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -121,8 +121,8 @@ extern long kvmppc_alloc_hpt(struct kvm *kvm);
 extern void kvmppc_free_hpt(struct kvm *kvm);
 extern long kvmppc_prepare_vrma(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem);
-extern void kvmppc_map_vrma(struct kvm *kvm,
-			    struct kvm_userspace_memory_region *mem);
+extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
+			    struct kvm_memory_slot *memslot);
 extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce *args);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index dcd39dc..87016cc 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -95,19 +95,17 @@ void kvmppc_free_hpt(struct kvm *kvm)
 	free_pages(kvm->arch.hpt_virt, HPT_ORDER - PAGE_SHIFT);
 }
 
-void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
+void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot)
 {
+	struct kvm *kvm = vcpu->kvm;
 	unsigned long i;
 	unsigned long npages;
-	unsigned long pa;
-	unsigned long *hpte;
-	unsigned long hash;
+	unsigned long hp_v, hp_r;
+	unsigned long addr, hash;
 	unsigned long porder = kvm->arch.ram_porder;
-	struct revmap_entry *rev;
-	unsigned long *physp;
+	long ret;
 
-	physp = kvm->arch.slot_phys[mem->slot];
-	npages = kvm->arch.slot_npages[mem->slot];
+	npages = kvm->arch.slot_npages[memslot->id];
 
 	/* VRMA can't be > 1TB */
 	if (npages > 1ul << (40 - porder))
@@ -117,10 +115,7 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 		npages = HPT_NPTEG;
 
 	for (i = 0; i < npages; ++i) {
-		pa = physp[i];
-		if (!pa)
-			break;
-		pa &= PAGE_MASK;
+		addr = i << porder;
 		/* can't use hpt_hash since va > 64 bits */
 		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & HPT_HASH_MASK;
 		/*
@@ -130,18 +125,16 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 		 * is available and use it.
 		 */
 		hash = (hash << 3) + 7;
-		hpte = (unsigned long *) (kvm->arch.hpt_virt + (hash << 4));
-		/* HPTE low word - RPN, protection, etc. */
-		hpte[1] = pa | HPTE_R_R | HPTE_R_C | HPTE_R_M | PP_RWXX;
-		smp_wmb();
-		hpte[0] = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
+		hp_v = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
 			(i << (VRMA_PAGE_ORDER - 16)) | HPTE_V_BOLTED |
 			HPTE_V_LARGE | HPTE_V_VALID;
-
-		/* Reverse map info */
-		rev = &kvm->arch.revmap[hash];
-		rev->guest_rpte = (i << porder) | HPTE_R_R | HPTE_R_C |
-			HPTE_R_M | PP_RWXX;
+		hp_r = addr | HPTE_R_R | HPTE_R_C | HPTE_R_M | PP_RWXX;
+		ret = kvmppc_virtmode_h_enter(vcpu, H_EXACT, hash, hp_v, hp_r);
+		if (ret != H_SUCCESS) {
+			pr_err("KVM: map_vrma at %lx failed, ret=%ld\n",
+			       addr, ret);
+			break;
+		}
 	}
 }
 
@@ -178,6 +171,92 @@ static void kvmppc_mmu_book3s_64_hv_reset_msr(struct kvm_vcpu *vcpu)
 	kvmppc_set_msr(vcpu, MSR_SF | MSR_ME);
 }
 
+/*
+ * This is called to get a reference to a guest page if there isn't
+ * one already in the kvm->arch.slot_phys[][] arrays.
+ */
+static long kvmppc_get_guest_page(struct kvm *kvm, unsigned long gfn,
+				  struct kvm_memory_slot *memslot)
+{
+	unsigned long start;
+	long np;
+	struct page *page, *pages[1];
+	unsigned long *physp;
+	unsigned long pfn, i;
+
+	physp = kvm->arch.slot_phys[memslot->id];
+	if (!physp)
+		return -EINVAL;
+	i = (gfn - memslot->base_gfn) >> (kvm->arch.ram_porder - PAGE_SHIFT);
+	if (physp[i])
+		return 0;
+
+	page = NULL;
+	start = gfn_to_hva_memslot(memslot, gfn);
+
+	/* Instantiate and get the page we want access to */
+	np = get_user_pages_fast(start, 1, 1, pages);
+	if (np != 1)
+		return -EINVAL;
+	page = pages[0];
+
+	/* Check it's a 16MB page */
+	if (!PageHead(page) ||
+	    compound_order(page) != (kvm->arch.ram_porder - PAGE_SHIFT)) {
+		pr_err("page at %lx isn't 16MB (o=%d)\n",
+		       start, compound_order(page));
+		put_page(page);
+		return -EINVAL;
+	}
+	pfn = page_to_pfn(page);
+
+	spin_lock(&kvm->arch.slot_phys_lock);
+	if (!physp[i])
+		physp[i] = (pfn << PAGE_SHIFT) | KVMPPC_GOT_PAGE;
+	else
+		put_page(page);
+	spin_unlock(&kvm->arch.slot_phys_lock);
+
+	return 0;
+}
+
+/*
+ * We come here on a H_ENTER call from the guest when
+ * we don't have the requested page pinned already.
+ */
+long kvmppc_virtmode_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
+			long pte_index, unsigned long pteh, unsigned long ptel)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long psize, gpa, gfn;
+	struct kvm_memory_slot *memslot;
+	long ret;
+
+	psize = hpte_page_size(pteh, ptel);
+	if (!psize)
+		return H_PARAMETER;
+
+	/* Find the memslot (if any) for this address */
+	gpa = (ptel & HPTE_R_RPN) & ~(psize - 1);
+	gfn = gpa >> PAGE_SHIFT;
+	memslot = gfn_to_memslot(kvm, gfn);
+	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
+		return H_PARAMETER;
+	if (kvmppc_get_guest_page(kvm, gfn, memslot) < 0)
+		return H_PARAMETER;
+
+	preempt_disable();
+	ret = kvmppc_h_enter(vcpu, flags, pte_index, pteh, ptel);
+	preempt_enable();
+	if (ret == H_TOO_HARD) {
+		/* this can't happen */
+		pr_err("KVM: Oops, kvmppc_h_enter returned too hard!\n");
+		ret = H_RESOURCE;	/* or something */
+	}
+	return ret;
+
+}
+
 static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 				struct kvmppc_pte *gpte, bool data)
 {
@@ -203,8 +282,11 @@ void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long gpa,
 	physp += (gfn - memslot->base_gfn) >>
 		(kvm->arch.ram_porder - PAGE_SHIFT);
 	pa = *physp;
-	if (!pa)
-		return NULL;
+	if (!pa) {
+		if (kvmppc_get_guest_page(kvm, gfn, memslot) < 0)
+			return NULL;
+		pa = *physp;
+	}
 	pfn = pa >> PAGE_SHIFT;
 	page = pfn_to_page(pfn);
 	get_page(page);
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index bd82789..767272c 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -49,6 +49,7 @@
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
+#include <linux/hugetlb.h>
 
 #define LARGE_PAGE_ORDER	24	/* 16MB pages */
 
@@ -57,6 +58,7 @@
 /* #define EXIT_DEBUG_INT */
 
 static void kvmppc_end_cede(struct kvm_vcpu *vcpu);
+static int kvmppc_hv_setup_rma(struct kvm_vcpu *vcpu);
 
 void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
@@ -231,6 +233,12 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 	struct kvm_vcpu *tvcpu;
 
 	switch (req) {
+	case H_ENTER:
+		ret = kvmppc_virtmode_h_enter(vcpu, kvmppc_get_gpr(vcpu, 4),
+					      kvmppc_get_gpr(vcpu, 5),
+					      kvmppc_get_gpr(vcpu, 6),
+					      kvmppc_get_gpr(vcpu, 7));
+		break;
 	case H_CEDE:
 		break;
 	case H_PROD:
@@ -884,9 +892,12 @@ int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		return -EINTR;
 	}
 
-	/* On PPC970, check that we have an RMA region */
-	if (!vcpu->kvm->arch.rma && cpu_has_feature(CPU_FTR_ARCH_201))
-		return -EPERM;
+	/* On the first time here, set up VRMA or RMA */
+	if (!vcpu->kvm->arch.rma_setup_done) {
+		r = kvmppc_hv_setup_rma(vcpu);
+		if (r)
+			return r;
+	}
 
 	flush_fp_to_thread(current);
 	flush_altivec_to_thread(current);
@@ -1096,34 +1107,15 @@ long kvm_vm_ioctl_allocate_rma(struct kvm *kvm, struct kvm_allocate_rma *ret)
 	return fd;
 }
 
-static struct page *hva_to_page(unsigned long addr)
-{
-	struct page *page[1];
-	int npages;
-
-	might_sleep();
-
-	npages = get_user_pages_fast(addr, 1, 1, page);
-
-	if (unlikely(npages != 1))
-		return 0;
-
-	return page[0];
-}
-
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem)
 {
-	unsigned long psize, porder;
-	unsigned long i, npages;
-	unsigned long hva;
-	struct kvmppc_rma_info *ri = NULL;
-	struct page *page;
+	unsigned long psize;
+	unsigned long npages;
 	unsigned long *phys;
 
-	/* For now, only allow 16MB pages */
-	porder = LARGE_PAGE_ORDER;
-	psize = 1ul << porder;
+	/* For now, only allow 16MB-aligned slots */
+	psize = kvm->arch.ram_psize;
 	if ((mem->memory_size & (psize - 1)) ||
 	    (mem->guest_phys_addr & (psize - 1))) {
 		pr_err("bad memory_size=%llx @ %llx\n",
@@ -1132,7 +1124,7 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 	}
 
 	/* Allocate a slot_phys array */
-	npages = mem->memory_size >> porder;
+	npages = mem->memory_size >> kvm->arch.ram_porder;
 	phys = kvm->arch.slot_phys[mem->slot];
 	if (!phys) {
 		phys = vzalloc(npages * sizeof(unsigned long));
@@ -1142,39 +1134,110 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 		kvm->arch.slot_npages[mem->slot] = npages;
 	}
 
-	/* Do we already have an RMA registered? */
-	if (mem->guest_phys_addr == 0 && kvm->arch.rma)
-		return -EINVAL;
+	return 0;
+}
 
-	/* Is this one of our preallocated RMAs? */
-	if (mem->guest_phys_addr == 0) {
-		struct vm_area_struct *vma;
-
-		down_read(&current->mm->mmap_sem);
-		vma = find_vma(current->mm, mem->userspace_addr);
-		if (vma && vma->vm_file &&
-		    vma->vm_file->f_op == &kvm_rma_fops &&
-		    mem->userspace_addr == vma->vm_start)
-			ri = vma->vm_file->private_data;
-		up_read(&current->mm->mmap_sem);
-		if (!ri && cpu_has_feature(CPU_FTR_ARCH_201)) {
-			pr_err("CPU requires an RMO\n");
-			return -EINVAL;
+static void unpin_slot(struct kvm *kvm, int slot_id)
+{
+	unsigned long *physp;
+	unsigned long j, npages, pfn;
+	struct page *page;
+
+	physp = kvm->arch.slot_phys[slot_id];
+	npages = kvm->arch.slot_npages[slot_id];
+	if (physp) {
+		spin_lock(&kvm->arch.slot_phys_lock);
+		for (j = 0; j < npages; j++) {
+			if (!(physp[j] & KVMPPC_GOT_PAGE))
+				continue;
+			pfn = physp[j] >> PAGE_SHIFT;
+			page = pfn_to_page(pfn);
+			SetPageDirty(page);
+			put_page(page);
 		}
+		kvm->arch.slot_phys[slot_id] = NULL;
+		spin_unlock(&kvm->arch.slot_phys_lock);
+		vfree(physp);
 	}
+}
+
+void kvmppc_core_commit_memory_region(struct kvm *kvm,
+				struct kvm_userspace_memory_region *mem)
+{
+}
+
+static int kvmppc_hv_setup_rma(struct kvm_vcpu *vcpu)
+{
+	int err = 0;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvmppc_rma_info *ri = NULL;
+	unsigned long hva;
+	struct kvm_memory_slot *memslot;
+	struct vm_area_struct *vma;
+	unsigned long lpcr;
+	unsigned long psize, porder;
+	unsigned long rma_size;
+	unsigned long rmls;
+	unsigned long *physp;
+	unsigned long i, npages, pa;
+
+	mutex_lock(&kvm->lock);
+	if (kvm->arch.rma_setup_done)
+		goto out;	/* another vcpu beat us to it */
 
-	if (ri) {
-		unsigned long rma_size;
-		unsigned long lpcr;
-		long rmls;
+	/* Look up the memslot for guest physical address 0 */
+	memslot = gfn_to_memslot(kvm, 0);
 
-		rma_size = ri->npages << PAGE_SHIFT;
-		if (rma_size > mem->memory_size)
-			rma_size = mem->memory_size;
+	/* We must have some memory at 0 by now */
+	err = -EINVAL;
+	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
+		goto out;
+
+	/* Look up the VMA for the start of this memory slot */
+	hva = memslot->userspace_addr;
+	down_read(&current->mm->mmap_sem);
+	vma = find_vma(current->mm, hva);
+	if (!vma || vma->vm_start > hva || (vma->vm_flags & VM_IO))
+		goto up_out;
+
+	psize = vma_kernel_pagesize(vma);
+	if (psize != kvm->arch.ram_psize)
+		goto up_out;
+
+	/* Is this one of our preallocated RMAs? */
+	if (vma->vm_file && vma->vm_file->f_op == &kvm_rma_fops &&
+	    hva == vma->vm_start)
+		ri = vma->vm_file->private_data;
+
+	up_read(&current->mm->mmap_sem);
+
+	if (!ri) {
+		/* On POWER7, use VRMA; on PPC970, give up */
+		err = -EPERM;
+		if (cpu_has_feature(CPU_FTR_ARCH_201)) {
+			pr_err("KVM: CPU requires an RMO\n");
+			goto out;
+		}
+
+		/* Update VRMASD field in the LPCR */
+		lpcr = kvm->arch.lpcr & ~(0x1fUL << LPCR_VRMASD_SH);
+		lpcr |= LPCR_VRMA_L;
+		kvm->arch.lpcr = lpcr;
+
+		/* Create HPTEs in the hash page table for the VRMA */
+		kvmppc_map_vrma(vcpu, memslot);
+
+	} else {
+		/* Set up to use an RMO region */
+		rma_size = ri->npages;
+		if (rma_size > memslot->npages)
+			rma_size = memslot->npages;
+		rma_size <<= PAGE_SHIFT;
 		rmls = lpcr_rmls(rma_size);
+		err = -EINVAL;
 		if (rmls < 0) {
-			pr_err("Can't use RMA of 0x%lx bytes\n", rma_size);
-			return -EINVAL;
+			pr_err("KVM: Can't use RMA of 0x%lx bytes\n", rma_size);
+			goto out;
 		}
 		atomic_inc(&ri->use_count);
 		kvm->arch.rma = ri;
@@ -1197,65 +1260,31 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 			kvm->arch.rmor = kvm->arch.rma->base_pfn << PAGE_SHIFT;
 		}
 		kvm->arch.lpcr = lpcr;
-		pr_info("Using RMO at %lx size %lx (LPCR = %lx)\n",
+		pr_info("KVM: Using RMO at %lx size %lx (LPCR = %lx)\n",
 			ri->base_pfn << PAGE_SHIFT, rma_size, lpcr);
-	}
 
-	for (i = 0; i < npages; ++i) {
-		if (ri && i < ri->npages) {
-			phys[i] = (ri->base_pfn << PAGE_SHIFT) + (i << porder);
-			continue;
-		}
-		hva = mem->userspace_addr + (i << porder);
-		page = hva_to_page(hva);
-		if (!page) {
-			pr_err("oops, no pfn for hva %lx\n", hva);
-			goto err;
-		}
-		/* Check it's a 16MB page */
-		if (!PageHead(page) ||
-		    compound_order(page) != (LARGE_PAGE_ORDER - PAGE_SHIFT)) {
-			pr_err("page at %lx isn't 16MB (o=%d)\n",
-			       hva, compound_order(page));
-			goto err;
-		}
-		phys[i] = (page_to_pfn(page) << PAGE_SHIFT) | KVMPPC_GOT_PAGE;
+		/* Initialize phys addrs of pages in RMO */
+		porder = kvm->arch.ram_porder;
+		npages = rma_size >> porder;
+		pa = ri->base_pfn << PAGE_SHIFT;
+		physp = kvm->arch.slot_phys[memslot->id];
+		spin_lock(&kvm->arch.slot_phys_lock);
+		for (i = 0; i < npages; ++i)
+			physp[i] = pa + (i << porder);
+		spin_unlock(&kvm->arch.slot_phys_lock);
 	}
 
-	return 0;
-
- err:
-	return -EINVAL;
-}
-
-static void unpin_slot(struct kvm *kvm, int slot_id)
-{
-	unsigned long *physp;
-	unsigned long j, npages, pfn;
-	struct page *page;
-
-	physp = kvm->arch.slot_phys[slot_id];
-	npages = kvm->arch.slot_npages[slot_id];
-	if (physp) {
-		for (j = 0; j < npages; j++) {
-			if (!(physp[j] & KVMPPC_GOT_PAGE))
-				continue;
-			pfn = physp[j] >> PAGE_SHIFT;
-			page = pfn_to_page(pfn);
-			SetPageDirty(page);
-			put_page(page);
-		}
-		vfree(physp);
-		kvm->arch.slot_phys[slot_id] = NULL;
-	}
-}
+	/* Order updates to kvm->arch.lpcr etc. vs. rma_setup_done */
+	smp_wmb();
+	kvm->arch.rma_setup_done = 1;
+	err = 0;
+ out:
+	mutex_unlock(&kvm->lock);
+	return err;
 
-void kvmppc_core_commit_memory_region(struct kvm *kvm,
-				struct kvm_userspace_memory_region *mem)
-{
-	if (mem->guest_phys_addr == 0 && mem->memory_size != 0 &&
-	    !kvm->arch.rma)
-		kvmppc_map_vrma(kvm, mem);
+ up_out:
+	up_read(&current->mm->mmap_sem);
+	goto out;
 }
 
 int kvmppc_core_init_vm(struct kvm *kvm)
@@ -1294,6 +1323,7 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 	}
 	kvm->arch.lpcr = lpcr;
 
+	spin_lock_init(&kvm->arch.slot_phys_lock);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index a28a603..047c5e1 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -11,6 +11,7 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/hugetlb.h>
+#include <linux/module.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -56,56 +57,54 @@ static void *real_vmalloc_addr(void *x)
 long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		    long pte_index, unsigned long pteh, unsigned long ptel)
 {
-	unsigned long porder;
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long i, gfn, lpn, pa;
+	unsigned long i, pa, gpa, gfn, psize;
+	unsigned long slot_fn;
 	unsigned long *hpte;
 	struct revmap_entry *rev;
 	unsigned long g_ptel = ptel;
 	struct kvm_memory_slot *memslot;
-	unsigned long *physp;
+	unsigned long *physp, pte_size;
+	bool realmode = vcpu->arch.vcore->vcore_state == VCORE_RUNNING;
 
-	/* only handle 4k, 64k and 16M pages for now */
-	porder = 12;
-	if (pteh & HPTE_V_LARGE) {
-		if (cpu_has_feature(CPU_FTR_ARCH_206) &&
-		    (ptel & 0xf000) == 0x1000) {
-			/* 64k page */
-			porder = 16;
-		} else if ((ptel & 0xff000) == 0) {
-			/* 16M page */
-			porder = 24;
-			/* lowest AVA bit must be 0 for 16M pages */
-			if (pteh & 0x80)
-				return H_PARAMETER;
-		} else
-			return H_PARAMETER;
-	}
-	if (porder > kvm->arch.ram_porder)
+	psize = hpte_page_size(pteh, ptel);
+	if (!psize)
 		return H_PARAMETER;
 
-	gfn = ((ptel & HPTE_R_RPN) & ~((1ul << porder) - 1)) >> PAGE_SHIFT;
+	/* Find the memslot (if any) for this address */
+	gpa = (ptel & HPTE_R_RPN) & ~(psize - 1);
+	gfn = gpa >> PAGE_SHIFT;
 	memslot = builtin_gfn_to_memslot(kvm, gfn);
 	if (!(memslot && !(memslot->flags & KVM_MEMSLOT_INVALID)))
 		return H_PARAMETER;
+	slot_fn = gfn - memslot->base_gfn;
+
 	physp = kvm->arch.slot_phys[memslot->id];
 	if (!physp)
 		return H_PARAMETER;
-
-	lpn = (gfn - memslot->base_gfn) >> (kvm->arch.ram_porder - PAGE_SHIFT);
-	physp = real_vmalloc_addr(physp + lpn);
+	physp += slot_fn;
+	if (realmode)
+		physp = real_vmalloc_addr(physp);
 	pa = *physp;
 	if (!pa)
-		return H_PARAMETER;
+		return H_TOO_HARD;
 	pa &= PAGE_MASK;
 
+	pte_size = kvm->arch.ram_psize;
+	if (pte_size < psize)
+		return H_PARAMETER;
+	if (pa && pte_size > psize)
+		pa |= gpa & (pte_size - 1);
+
+	ptel &= ~(HPTE_R_PP0 - psize);
+	ptel |= pa;
+
 	/* Check WIMG */
 	if ((ptel & HPTE_R_WIMG) != HPTE_R_M &&
 	    (ptel & HPTE_R_WIMG) != (HPTE_R_W | HPTE_R_I | HPTE_R_M))
 		return H_PARAMETER;
 	pteh &= ~0x60UL;
-	ptel &= ~(HPTE_R_PP0 - kvm->arch.ram_psize);
-	ptel |= pa;
+	pteh |= HPTE_V_VALID;
 
 	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
@@ -162,6 +161,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	vcpu->arch.gpr[4] = pte_index;
 	return H_SUCCESS;
 }
+EXPORT_SYMBOL_GPL(kvmppc_h_enter);
 
 #define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
 
-- 
1.7.7.3
