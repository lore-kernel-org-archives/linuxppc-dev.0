Return-Path: <paulus@ozlabs.org>
Date: Tue, 6 Dec 2011 17:09:09 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH 07/13] KVM: PPC: Allow use of small pages to back Book3S HV
 guests
Message-ID: <20111206060908.GK12389@drongo>
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

This relaxes the requirement that the guest memory be provided as
16MB huge pages, allowing it to be provided as normal memory, i.e.
in pages of PAGE_SIZE bytes (4k or 64k).  To allow this, we index
the kvm->arch.slot_phys[] arrays with a small page index, even if
huge pages are being used, and use the low-order 5 bits of each
entry to store the order of the enclosing page with respect to
normal pages, i.e. log_2(enclosing_page_size / PAGE_SIZE).

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |    8 ++
 arch/powerpc/include/asm/kvm_host.h      |    3 +-
 arch/powerpc/include/asm/kvm_ppc.h       |    2 +-
 arch/powerpc/include/asm/reg.h           |    1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  122 ++++++++++++++++++++----------
 arch/powerpc/kvm/book3s_hv.c             |   57 ++++++++------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |    6 +-
 7 files changed, 130 insertions(+), 69 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index ab6772e..d55e6b4 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -107,4 +107,12 @@ static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
 	return 0;				/* error */
 }
 
+static inline bool slot_is_aligned(struct kvm_memory_slot *memslot,
+				   unsigned long pagesize)
+{
+	unsigned long mask = (pagesize >> PAGE_SHIFT) - 1;
+
+	return !(memslot->base_gfn & mask) && !(memslot->npages & mask);
+}
+
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2a52bdb..ba1da85 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -176,14 +176,13 @@ struct revmap_entry {
 };
 
 /* Low-order bits in kvm->arch.slot_phys[][] */
+#define KVMPPC_PAGE_ORDER_MASK	0x1f
 #define KVMPPC_GOT_PAGE		0x80
 
 struct kvm_arch {
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	unsigned long hpt_virt;
 	struct revmap_entry *revmap;
-	unsigned long ram_psize;
-	unsigned long ram_porder;
 	unsigned int lpid;
 	unsigned int host_lpid;
 	unsigned long host_lpcr;
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 111e1b4..a61b5b5 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -122,7 +122,7 @@ extern void kvmppc_free_hpt(struct kvm *kvm);
 extern long kvmppc_prepare_vrma(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem);
 extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
-			    struct kvm_memory_slot *memslot);
+			struct kvm_memory_slot *memslot, unsigned long porder);
 extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce *args);
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 559da19..4599d12 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -237,6 +237,7 @@
 #define   LPCR_ISL	(1ul << (63-2))
 #define   LPCR_VC_SH	(63-2)
 #define   LPCR_DPFD_SH	(63-11)
+#define   LPCR_VRMASD	(0x1ful << (63-16))
 #define   LPCR_VRMA_L	(1ul << (63-12))
 #define   LPCR_VRMA_LP0	(1ul << (63-15))
 #define   LPCR_VRMA_LP1	(1ul << (63-16))
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 87016cc..cc18f3d 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -34,8 +34,6 @@
 #include <asm/ppc-opcode.h>
 #include <asm/cputable.h>
 
-/* Pages in the VRMA are 16MB pages */
-#define VRMA_PAGE_ORDER	24
 #define VRMA_VSID	0x1ffffffUL	/* 1TB VSID reserved for VRMA */
 
 /* POWER7 has 10-bit LPIDs, PPC970 has 6-bit LPIDs */
@@ -95,17 +93,31 @@ void kvmppc_free_hpt(struct kvm *kvm)
 	free_pages(kvm->arch.hpt_virt, HPT_ORDER - PAGE_SHIFT);
 }
 
-void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot)
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
+void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
+		     unsigned long porder)
 {
-	struct kvm *kvm = vcpu->kvm;
 	unsigned long i;
 	unsigned long npages;
 	unsigned long hp_v, hp_r;
 	unsigned long addr, hash;
-	unsigned long porder = kvm->arch.ram_porder;
+	unsigned long psize;
+	unsigned long hp0, hp1;
 	long ret;
 
-	npages = kvm->arch.slot_npages[memslot->id];
+	psize = 1ul << porder;
+	npages = memslot->npages >> (porder - PAGE_SHIFT);
 
 	/* VRMA can't be > 1TB */
 	if (npages > 1ul << (40 - porder))
@@ -114,6 +126,11 @@ void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot)
 	if (npages > HPT_NPTEG)
 		npages = HPT_NPTEG;
 
+	hp0 = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
+		HPTE_V_BOLTED | hpte0_pgsize_encoding(psize);
+	hp1 = hpte1_pgsize_encoding(psize) |
+		HPTE_R_R | HPTE_R_C | HPTE_R_M | PP_RWXX;
+
 	for (i = 0; i < npages; ++i) {
 		addr = i << porder;
 		/* can't use hpt_hash since va > 64 bits */
@@ -125,10 +142,8 @@ void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot)
 		 * is available and use it.
 		 */
 		hash = (hash << 3) + 7;
-		hp_v = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
-			(i << (VRMA_PAGE_ORDER - 16)) | HPTE_V_BOLTED |
-			HPTE_V_LARGE | HPTE_V_VALID;
-		hp_r = addr | HPTE_R_R | HPTE_R_C | HPTE_R_M | PP_RWXX;
+		hp_v = hp0 | ((addr >> 16) & ~0x7fUL);
+		hp_r = hp1 | addr;
 		ret = kvmppc_virtmode_h_enter(vcpu, H_EXACT, hash, hp_v, hp_r);
 		if (ret != H_SUCCESS) {
 			pr_err("KVM: map_vrma at %lx failed, ret=%ld\n",
@@ -176,22 +191,25 @@ static void kvmppc_mmu_book3s_64_hv_reset_msr(struct kvm_vcpu *vcpu)
  * one already in the kvm->arch.slot_phys[][] arrays.
  */
 static long kvmppc_get_guest_page(struct kvm *kvm, unsigned long gfn,
-				  struct kvm_memory_slot *memslot)
+				  struct kvm_memory_slot *memslot,
+				  unsigned long psize)
 {
 	unsigned long start;
-	long np;
-	struct page *page, *pages[1];
+	long np, err;
+	struct page *page, *hpage, *pages[1];
+	unsigned long s, pgsize;
 	unsigned long *physp;
-	unsigned long pfn, i;
+	unsigned int got, pgorder;
+	unsigned long pfn, i, npages;
 
 	physp = kvm->arch.slot_phys[memslot->id];
 	if (!physp)
 		return -EINVAL;
-	i = (gfn - memslot->base_gfn) >> (kvm->arch.ram_porder - PAGE_SHIFT);
-	if (physp[i])
+	if (physp[gfn - memslot->base_gfn])
 		return 0;
 
 	page = NULL;
+	pgsize = psize;
 	start = gfn_to_hva_memslot(memslot, gfn);
 
 	/* Instantiate and get the page we want access to */
@@ -199,25 +217,46 @@ static long kvmppc_get_guest_page(struct kvm *kvm, unsigned long gfn,
 	if (np != 1)
 		return -EINVAL;
 	page = pages[0];
-
-	/* Check it's a 16MB page */
-	if (!PageHead(page) ||
-	    compound_order(page) != (kvm->arch.ram_porder - PAGE_SHIFT)) {
-		pr_err("page at %lx isn't 16MB (o=%d)\n",
-		       start, compound_order(page));
-		put_page(page);
-		return -EINVAL;
+	got = KVMPPC_GOT_PAGE;
+
+	/* See if this is a large page */
+	s = PAGE_SIZE;
+	if (PageHuge(page)) {
+		hpage = compound_head(page);
+		s <<= compound_order(hpage);
+		/* Get the whole large page if slot alignment is ok */
+		if (s > psize && slot_is_aligned(memslot, s) &&
+		    !(memslot->userspace_addr & (s - 1))) {
+			start &= ~(s - 1);
+			pgsize = s;
+			page = hpage;
+		}
 	}
+	err = -EINVAL;
+	if (s < psize)
+		goto out;
 	pfn = page_to_pfn(page);
 
+	npages = pgsize >> PAGE_SHIFT;
+	pgorder = __ilog2(npages);
+	physp += (gfn - memslot->base_gfn) & ~(npages - 1);
 	spin_lock(&kvm->arch.slot_phys_lock);
-	if (!physp[i])
-		physp[i] = (pfn << PAGE_SHIFT) | KVMPPC_GOT_PAGE;
-	else
-		put_page(page);
+	for (i = 0; i < npages; ++i) {
+		if (!physp[i]) {
+			physp[i] = ((pfn + i) << PAGE_SHIFT) + got + pgorder;
+			got = 0;
+		}
+	}
 	spin_unlock(&kvm->arch.slot_phys_lock);
+	err = 0;
 
-	return 0;
+ out:
+	if (got) {
+		if (PageHuge(page))
+			page = compound_head(page);
+		put_page(page);
+	}
+	return err;
 }
 
 /*
@@ -242,7 +281,9 @@ long kvmppc_virtmode_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	memslot = gfn_to_memslot(kvm, gfn);
 	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
 		return H_PARAMETER;
-	if (kvmppc_get_guest_page(kvm, gfn, memslot) < 0)
+	if (!slot_is_aligned(memslot, psize))
+		return H_PARAMETER;
+	if (kvmppc_get_guest_page(kvm, gfn, memslot, psize) < 0)
 		return H_PARAMETER;
 
 	preempt_disable();
@@ -269,8 +310,8 @@ void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long gpa,
 	struct kvm_memory_slot *memslot;
 	unsigned long gfn = gpa >> PAGE_SHIFT;
 	struct page *page;
-	unsigned long offset;
-	unsigned long pfn, pa;
+	unsigned long psize, offset;
+	unsigned long pa;
 	unsigned long *physp;
 
 	memslot = gfn_to_memslot(kvm, gfn);
@@ -279,20 +320,23 @@ void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long gpa,
 	physp = kvm->arch.slot_phys[memslot->id];
 	if (!physp)
 		return NULL;
-	physp += (gfn - memslot->base_gfn) >>
-		(kvm->arch.ram_porder - PAGE_SHIFT);
+	physp += gfn - memslot->base_gfn;
 	pa = *physp;
 	if (!pa) {
-		if (kvmppc_get_guest_page(kvm, gfn, memslot) < 0)
+		if (kvmppc_get_guest_page(kvm, gfn, memslot, PAGE_SIZE) < 0)
 			return NULL;
 		pa = *physp;
 	}
-	pfn = pa >> PAGE_SHIFT;
-	page = pfn_to_page(pfn);
+	page = pfn_to_page(pa >> PAGE_SHIFT);
+	psize = PAGE_SIZE;
+	if (PageHuge(page)) {
+		page = compound_head(page);
+		psize <<= compound_order(page);
+	}
 	get_page(page);
-	offset = gpa & (kvm->arch.ram_psize - 1);
+	offset = gpa & (psize - 1);
 	if (nb_ret)
-		*nb_ret = kvm->arch.ram_psize - offset;
+		*nb_ret = psize - offset;
 	return page_address(page) + offset;
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5d3590c..150f527 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -49,8 +49,6 @@
 #include <linux/highmem.h>
 #include <linux/hugetlb.h>
 
-#define LARGE_PAGE_ORDER	24	/* 16MB pages */
-
 /* #define EXIT_DEBUG */
 /* #define EXIT_DEBUG_SIMPLE */
 /* #define EXIT_DEBUG_INT */
@@ -1105,24 +1103,26 @@ long kvm_vm_ioctl_allocate_rma(struct kvm *kvm, struct kvm_allocate_rma *ret)
 	return fd;
 }
 
+static unsigned long slb_pgsize_encoding(unsigned long psize)
+{
+	unsigned long senc = 0;
+
+	if (psize > 0x1000) {
+		senc = SLB_VSID_L;
+		if (psize == 0x10000)
+			senc |= SLB_VSID_LP_01;
+	}
+	return senc;
+}
+
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem)
 {
-	unsigned long psize;
 	unsigned long npages;
 	unsigned long *phys;
 
-	/* For now, only allow 16MB-aligned slots */
-	psize = kvm->arch.ram_psize;
-	if ((mem->memory_size & (psize - 1)) ||
-	    (mem->guest_phys_addr & (psize - 1))) {
-		pr_err("bad memory_size=%llx @ %llx\n",
-		       mem->memory_size, mem->guest_phys_addr);
-		return -EINVAL;
-	}
-
 	/* Allocate a slot_phys array */
-	npages = mem->memory_size >> kvm->arch.ram_porder;
+	npages = mem->memory_size >> PAGE_SHIFT;
 	phys = kvm->arch.slot_phys[mem->slot];
 	if (!phys) {
 		phys = vzalloc(npages * sizeof(unsigned long));
@@ -1150,6 +1150,8 @@ static void unpin_slot(struct kvm *kvm, int slot_id)
 				continue;
 			pfn = physp[j] >> PAGE_SHIFT;
 			page = pfn_to_page(pfn);
+			if (PageHuge(page))
+				page = compound_head(page);
 			SetPageDirty(page);
 			put_page(page);
 		}
@@ -1172,12 +1174,12 @@ static int kvmppc_hv_setup_rma(struct kvm_vcpu *vcpu)
 	unsigned long hva;
 	struct kvm_memory_slot *memslot;
 	struct vm_area_struct *vma;
-	unsigned long lpcr;
+	unsigned long lpcr, senc;
 	unsigned long psize, porder;
 	unsigned long rma_size;
 	unsigned long rmls;
 	unsigned long *physp;
-	unsigned long i, npages, pa;
+	unsigned long i, npages;
 
 	mutex_lock(&kvm->lock);
 	if (kvm->arch.rma_setup_done)
@@ -1199,8 +1201,7 @@ static int kvmppc_hv_setup_rma(struct kvm_vcpu *vcpu)
 		goto up_out;
 
 	psize = vma_kernel_pagesize(vma);
-	if (psize != kvm->arch.ram_psize)
-		goto up_out;
+	porder = __ilog2(psize);
 
 	/* Is this one of our preallocated RMAs? */
 	if (vma->vm_file && vma->vm_file->f_op == &kvm_rma_fops &&
@@ -1217,13 +1218,20 @@ static int kvmppc_hv_setup_rma(struct kvm_vcpu *vcpu)
 			goto out;
 		}
 
+		/* We can handle 4k, 64k or 16M pages in the VRMA */
+		err = -EINVAL;
+		if (!(psize == 0x1000 || psize == 0x10000 ||
+		      psize == 0x1000000))
+			goto out;
+
 		/* Update VRMASD field in the LPCR */
-		lpcr = kvm->arch.lpcr & ~(0x1fUL << LPCR_VRMASD_SH);
-		lpcr |= LPCR_VRMA_L;
+		senc = slb_pgsize_encoding(psize);
+		lpcr = kvm->arch.lpcr & ~LPCR_VRMASD;
+		lpcr |= senc << (LPCR_VRMASD_SH - 4);
 		kvm->arch.lpcr = lpcr;
 
 		/* Create HPTEs in the hash page table for the VRMA */
-		kvmppc_map_vrma(vcpu, memslot);
+		kvmppc_map_vrma(vcpu, memslot, porder);
 
 	} else {
 		/* Set up to use an RMO region */
@@ -1262,13 +1270,12 @@ static int kvmppc_hv_setup_rma(struct kvm_vcpu *vcpu)
 			ri->base_pfn << PAGE_SHIFT, rma_size, lpcr);
 
 		/* Initialize phys addrs of pages in RMO */
-		porder = kvm->arch.ram_porder;
-		npages = rma_size >> porder;
-		pa = ri->base_pfn << PAGE_SHIFT;
+		npages = ri->npages;
+		porder = __ilog2(npages);
 		physp = kvm->arch.slot_phys[memslot->id];
 		spin_lock(&kvm->arch.slot_phys_lock);
 		for (i = 0; i < npages; ++i)
-			physp[i] = pa + (i << porder);
+			physp[i] = ((ri->base_pfn + i) << PAGE_SHIFT) + porder;
 		spin_unlock(&kvm->arch.slot_phys_lock);
 	}
 
@@ -1297,8 +1304,6 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 
 	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
 
-	kvm->arch.ram_psize = 1ul << LARGE_PAGE_ORDER;
-	kvm->arch.ram_porder = LARGE_PAGE_ORDER;
 	kvm->arch.rma = NULL;
 
 	kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index d2eb8ac..c76305c 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -80,6 +80,10 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	memslot = builtin_gfn_to_memslot(kvm, gfn);
 	if (!(memslot && !(memslot->flags & KVM_MEMSLOT_INVALID)))
 		return H_PARAMETER;
+
+	/* Check if the requested page fits entirely in the memslot. */
+	if (!slot_is_aligned(memslot, psize))
+		return H_PARAMETER;
 	slot_fn = gfn - memslot->base_gfn;
 
 	physp = kvm->arch.slot_phys[memslot->id];
@@ -91,9 +95,9 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	pa = *physp;
 	if (!pa)
 		return H_TOO_HARD;
+	pte_size = PAGE_SIZE << (pa & KVMPPC_PAGE_ORDER_MASK);
 	pa &= PAGE_MASK;
 
-	pte_size = kvm->arch.ram_psize;
 	if (pte_size < psize)
 		return H_PARAMETER;
 	if (pa && pte_size > psize)
-- 
1.7.5.4
