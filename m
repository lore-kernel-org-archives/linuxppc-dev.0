Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Nov 2011 10:52:20 +1100
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org
Subject: [RFC PATCH 10/11] KVM: PPC: Implement MMU notifiers
Message-ID: <20111116235220.GK26985@bloggs.ozlabs.ibm.com>
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

This implements the low-level functions called by the MMU notifiers in
the generic KVM code, and defines KVM_ARCH_WANT_MMU_NOTIFIER if
CONFIG_KVM_BOOK3S_64_HV so that the generic KVM MMU notifiers get
included.

That means we also have to take notice of when PTE invalidations are
in progress, as indicated by mmu_notifier_retry().  In kvmppc_h_enter,
if any invalidation is in progress we just install a non-present HPTE.
In kvmppc_book3s_hv_page_fault, if an invalidation is in progress we
just return without resolving the guest, causing it to encounter another
page fault immediately.  This is better than spinning inside
kvmppc_book3s_hv_page_fault because this way the guest can get preempted
by a hypervisor decrementer interrupt without us having to do any
special checks.

We currently maintain a referenced bit in the rmap array, and when we
clear it, we make all the HPTEs that map the corresponding page be
non-present, as if the page were invalidated.  In future we could use
the hardware reference bit in the guest HPT instead.

The kvm_set_spte_hva function is implemented as kvm_unmap_hva.  The
former appears to be unused anyway.

This all means that on processors that support virtual partition
memory (POWER7), we can claim support for the KVM_CAP_SYNC_MMU
capability, and we no longer have to pin all the guest memory.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_host.h |   13 +++
 arch/powerpc/kvm/Kconfig            |    1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c |  160 ++++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv.c        |   25 +++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c |   34 ++++++-
 arch/powerpc/kvm/powerpc.c          |    3 +
 6 files changed, 218 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 3dfac3d..79bfc69 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -44,6 +44,19 @@
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #endif
 
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+#include <linux/mmu_notifier.h>
+
+#define KVM_ARCH_WANT_MMU_NOTIFIER
+
+struct kvm;
+extern int kvm_unmap_hva(struct kvm *kvm, unsigned long hva);
+extern int kvm_age_hva(struct kvm *kvm, unsigned long hva);
+extern int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
+extern void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+
+#endif
+
 /* We don't currently support large pages. */
 #define KVM_HPAGE_GFN_SHIFT(x)	0
 #define KVM_NR_PAGE_SIZES	1
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 78133de..8f64709 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -69,6 +69,7 @@ config KVM_BOOK3S_64
 config KVM_BOOK3S_64_HV
 	bool "KVM support for POWER7 and PPC970 using hypervisor mode in host"
 	depends on KVM_BOOK3S_64
+	select MMU_NOTIFIER
 	---help---
 	  Support running unmodified book3s_64 guest kernels in
 	  virtual machines on POWER7 and PPC970 processors that have
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index e93c789..8c497b8 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -138,6 +138,15 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 	hp1 = hpte1_pgsize_encoding(psize) |
 		HPTE_R_R | HPTE_R_C | HPTE_R_M | PP_RWXX;
 
+	spin_lock(&kvm->mmu_lock);
+	/* wait until no invalidations are in progress */
+	while (kvm->mmu_notifier_count) {
+		spin_unlock(&kvm->mmu_lock);
+		while (kvm->mmu_notifier_count)
+			cpu_relax();
+		spin_lock(&kvm->mmu_lock);
+	}
+		
 	for (i = 0; i < npages; ++i) {
 		addr = i << porder;
 		if (pfns) {
@@ -185,6 +194,7 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 				KVMPPC_RMAP_REFERENCED | KVMPPC_RMAP_PRESENT;
 		}
 	}
+	spin_unlock(&kvm->mmu_lock);
 }
 
 int kvmppc_mmu_hv_init(void)
@@ -506,7 +516,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	struct kvm *kvm = vcpu->kvm;
 	struct kvmppc_slb *slbe;
 	unsigned long *hptep, hpte[3];
-	unsigned long psize, pte_size;
+	unsigned long mmu_seq, psize, pte_size;
 	unsigned long gfn, hva, pfn, amr;
 	struct kvm_memory_slot *memslot;
 	unsigned long *rmap;
@@ -581,6 +591,11 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	if (kvm->arch.slot_pfns[memslot->id])
 		return -EFAULT;		/* should never get here */
 	hva = gfn_to_hva_memslot(memslot, gfn);
+
+	/* used to check for invalidations in progress */
+	mmu_seq = kvm->mmu_notifier_seq;
+	smp_rmb();
+
 	npages = get_user_pages_fast(hva, 1, 1, pages);
 	if (npages < 1)
 		return -EFAULT;
@@ -596,9 +611,15 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		goto out_put;
 	pfn = page_to_pfn(page);
 
+	/* Check if we might have been invalidated; let the guest retry if so */
+	ret = RESUME_GUEST;
+	spin_lock(&kvm->mmu_lock);
+	if (mmu_notifier_retry(vcpu, mmu_seq))
+		goto out_unlock;
+
 	/* Set the HPTE to point to pfn */
 	ret = RESUME_GUEST;
-	hptep = (unsigned long *)kvm->arch.hpt_virt + (index << 1);
+	hptep = (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
 	rev = &kvm->arch.revmap[index];
 	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
 		cpu_relax();
@@ -606,7 +627,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	    rev->guest_rpte != hpte[2]) {
 		/* HPTE has been changed under us; let the guest retry */
 		hptep[0] &= ~HPTE_V_HVLOCK;
-		goto out_put;
+		goto out_unlock;
 	}
 	hpte[0] = (hpte[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
 	hpte[1] = (rev->guest_rpte & ~(HPTE_R_PP0 - pte_size)) |
@@ -617,6 +638,8 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	if (page)
 		SetPageDirty(page);
 
+ out_unlock:
+	spin_unlock(&kvm->mmu_lock);
  out_put:
 	if (page)
 		put_page(page);
@@ -635,6 +658,137 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return RESUME_GUEST;
 }
 
+static int kvm_handle_hva(struct kvm *kvm, unsigned long hva,
+			  int (*handler)(struct kvm *kvm, unsigned long *rmapp,
+					 unsigned long gfn))
+{
+	int i;
+	int ret;
+	int retval = 0;
+	struct kvm_memslots *slots;
+
+	slots = kvm_memslots(kvm);
+	for (i = 0; i < slots->nmemslots; i++) {
+		struct kvm_memory_slot *memslot = &slots->memslots[i];
+		unsigned long start = memslot->userspace_addr;
+		unsigned long end;
+
+		end = start + (memslot->npages << PAGE_SHIFT);
+		if (hva >= start && hva < end) {
+			gfn_t gfn_offset = (hva - start) >> PAGE_SHIFT;
+
+			ret = handler(kvm, &memslot->rmap[gfn_offset],
+				      memslot->base_gfn + gfn_offset);
+			retval |= ret;
+		}
+	}
+
+	return retval;
+}
+
+static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
+			   unsigned long gfn)
+{
+	struct revmap_entry *rev = kvm->arch.revmap;
+	unsigned long h, i, j;
+	unsigned long *hptep, new_hpte[2];
+	unsigned long ptel, psize;
+	int n = 0;
+
+	for (;;) {
+		while (test_and_set_bit_lock(KVMPPC_RMAP_LOCK_BIT, rmapp))
+			cpu_relax();
+		if (!(*rmapp & KVMPPC_RMAP_PRESENT)) {
+			__clear_bit_unlock(KVMPPC_RMAP_LOCK_BIT, rmapp);
+			break;
+		}
+
+		/*
+		 * To avoid an ABBA deadlock with the HPTE lock bit,
+		 * we have to unlock the rmap chain before locking the HPTE.
+		 * Thus we remove the first entry, unlock the rmap chain,
+		 * lock the HPTE and then check that it is for the
+		 * page we're unmapping before changing it to non-present.
+		 */
+		i = *rmapp & KVMPPC_RMAP_INDEX;
+		j = rev[i].forw;
+		if (j == i) {
+			/* chain is now empty */
+			j = 0;
+		} else {
+			/* remove i from chain */
+			h = rev[i].back;
+			rev[h].forw = j;
+			rev[j].back = h;
+			rev[i].forw = rev[i].back = i;
+			j |= KVMPPC_RMAP_PRESENT;
+		}
+		smp_wmb();
+		*rmapp = j | (1ul << KVMPPC_RMAP_REF_BIT);
+
+		/* Now lock, check and modify the HPTE */
+		hptep = (unsigned long *) (kvm->arch.hpt_virt + (i << 4));
+		while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
+			cpu_relax();
+		ptel = rev[i].guest_rpte;
+		psize = hpte_page_size(hptep[0], ptel);
+		if ((hptep[0] & HPTE_V_VALID) &&
+		    hpte_rpn(ptel, psize) == gfn) {
+			new_hpte[0] = hptep[0] | HPTE_V_ABSENT;
+			if ((new_hpte[0] & 0xffffffffff000000ul) ==
+			    (HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16))))
+				new_hpte[0] &= ~HPTE_V_VALID;
+			new_hpte[1] = (ptel & ~(HPTE_R_PP0 - psize)) |
+				HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_R_N;
+			kvmppc_modify_hpte(kvm, hptep, new_hpte, i);
+			++n;
+		} else {
+			hptep[0] &= ~HPTE_V_HVLOCK;
+		}
+	}
+	return 0;
+}
+
+int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
+{
+	kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
+	return 0;
+}
+
+static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
+			 unsigned long gfn)
+{
+	if (!(*rmapp & KVMPPC_RMAP_REFERENCED))
+		return 0;
+	kvm_unmap_rmapp(kvm, rmapp, gfn);
+	while (test_and_set_bit_lock(KVMPPC_RMAP_LOCK_BIT, rmapp))
+		cpu_relax();
+	__clear_bit(KVMPPC_RMAP_REF_BIT, rmapp);
+	__clear_bit_unlock(KVMPPC_RMAP_LOCK_BIT, rmapp);
+	return 1;
+}
+
+int kvm_age_hva(struct kvm *kvm, unsigned long hva)
+{
+	return kvm_handle_hva(kvm, hva, kvm_age_rmapp);
+}
+
+static int kvm_test_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
+			      unsigned long gfn)
+{
+	return !!(*rmapp & KVMPPC_RMAP_REFERENCED);
+}
+
+int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
+{
+	return kvm_handle_hva(kvm, hva, kvm_test_age_rmapp);
+}
+
+void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+{
+	kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
+}
+
 void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long gpa,
 			    unsigned long *nb_ret)
 {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 47053e9..9e67320 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1278,10 +1278,12 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 			ri->base_pfn << PAGE_SHIFT, rma_size, lpcr);
 	}
 
-	pfns = vzalloc(npages * sizeof(unsigned long));
-	if (!pfns)
-		return -ENOMEM;
-	kvm->arch.slot_pfns[mem->slot] = pfns;
+	if (!cpu_has_feature(CPU_FTR_ARCH_206)) {
+		pfns = vzalloc(npages * sizeof(unsigned long));
+		if (!pfns)
+			return -ENOMEM;
+		kvm->arch.slot_pfns[mem->slot] = pfns;
+	}
 
 	return 0;
 
@@ -1305,12 +1307,14 @@ void kvmppc_core_commit_memory_region(struct kvm *kvm,
 		return;
 
 	pfns = kvm->arch.slot_pfns[mem->slot];
-	npages = mem->memory_size >> porder;
-	for (i = 0; i < npages; ++i) {
-		hva = mem->userspace_addr + (i << porder);
-		page = hva_to_page(hva);
-		if (page)
-			pfns[i] = page_to_pfn(page);
+	if (pfns) {
+		npages = mem->memory_size >> porder;
+		for (i = 0; i < npages; ++i) {
+			hva = mem->userspace_addr + (i << porder);
+			page = hva_to_page(hva);
+			if (page)
+				pfns[i] = page_to_pfn(page);
+		}
 	}
 
 	if (mem->guest_phys_addr == 0 && mem->memory_size != 0 &&
@@ -1384,6 +1388,7 @@ void kvmppc_core_destroy_vm(struct kvm *kvm)
 				page = pfn_to_page(pfns[j]);
 				if (PageHuge(page))
 					page = compound_head(page);
+				SetPageDirty(page);
 				put_page(page);
 			}
 		}
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 622bfcd..2cadd06 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -143,11 +143,17 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long *rmap;
 	pte_t *ptep;
 	unsigned int shift;
+	unsigned long mmu_seq;
+	long err;
 
 	psize = hpte_page_size(pteh, ptel);
 	if (!psize)
 		return H_PARAMETER;
 
+	/* used later to detect if we might have been invalidated */
+	mmu_seq = kvm->mmu_notifier_seq;
+	smp_rmb();
+
 	/* Find the memslot (if any) for this address */
 	gpa = (ptel & HPTE_R_RPN) & ~(psize - 1);
 	gfn = gpa >> PAGE_SHIFT;
@@ -212,6 +218,18 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			return H_PARAMETER;
 	}
 
+	/*
+	 * Now that we're about to write the HPTE and thus give the guest
+	 * access to the page, check for any pending invalidations.
+	 * We don't need to worry about that if this is a non-present page.
+	 * Note that the HPTE bitlock has to nest inside the kvm->mmu_lock.
+	 */
+	spin_lock(&kvm->mmu_lock);
+	if (mmu_notifier_retry(vcpu, mmu_seq))
+		/* inval in progress, write a non-present HPTE */
+		pa = 0;
+
+	err = H_PARAMETER;
 	if (!pa) {
 		/*
 		 * If this is a non-present page for any reason
@@ -222,7 +240,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		 * On 970 we have to have all pages present.
 		 */
 		if (!cpu_has_feature(CPU_FTR_ARCH_206))
-			return H_PARAMETER;
+			goto out;
 		pteh |= HPTE_V_ABSENT;
 		if ((pteh & 0xffffffffff000000ul) ==
 		    (HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16))))
@@ -231,14 +249,16 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			ptel |= HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_R_N;
 	}
 
+	/* Find and lock the HPTEG slot to use */
 	if (pte_index >= HPT_NPTE)
-		return H_PARAMETER;
+		goto out;
+	err = H_PTEG_FULL;
 	if (likely((flags & H_EXACT) == 0)) {
 		pte_index &= ~7UL;
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 		for (i = 0; ; ++i) {
 			if (i == 8)
-				return H_PTEG_FULL;
+				goto out;
 			if ((*hpte & HPTE_V_VALID) == 0 &&
 			    try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID |
 					  HPTE_V_ABSENT))
@@ -250,7 +270,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 		if (!try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID |
 				   HPTE_V_ABSENT))
-			return H_PTEG_FULL;
+			goto out;
 	}
 
 	/* Save away the guest's idea of the second HPTE dword */
@@ -272,7 +292,11 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	asm volatile("ptesync" : : : "memory");
 
 	vcpu->arch.gpr[4] = pte_index;
-	return H_SUCCESS;
+	err = H_SUCCESS;
+
+ out:
+	spin_unlock(&kvm->mmu_lock);
+	return err;
 }
 
 #define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 084d1c5..0f10a04 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -244,6 +244,9 @@ int kvm_dev_ioctl_check_extension(long ext)
 		if (cpu_has_feature(CPU_FTR_ARCH_201))
 			r = 2;
 		break;
+	case KVM_CAP_SYNC_MMU:
+		r = cpu_has_feature(CPU_FTR_ARCH_206) ? 1 : 0;
+		break;
 #endif
 	default:
 		r = 0;
-- 
1.7.7.2
