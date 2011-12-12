Return-Path: <paulus@ozlabs.org>
Date: Tue, 13 Dec 2011 09:38:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH v3 13/14] KVM: PPC: Implement MMU notifiers for Book3S HV
 guests
Message-ID: <20111212223804.GN18868@bloggs.ozlabs.ibm.com>
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

This adds the infrastructure to enable us to page out pages underneath
a Book3S HV guest, on processors that support virtualized partition
memory, that is, POWER7.  Instead of pinning all the guest's pages,
we now look in the host userspace Linux page tables to find the
mapping for a given guest page.  Then, if the userspace Linux PTE
gets invalidated, kvm_unmap_hva() gets called for that address, and
we replace all the guest HPTEs that refer to that page with absent
HPTEs, i.e. ones with the valid bit clear and the HPTE_V_ABSENT bit
set, which will cause an HDSI when the guest tries to access them.
Finally, the page fault handler is extended to reinstantiate the
guest HPTE when the guest tries to access a page which has been paged
out.

Since we can't intercept the guest DSI and ISI interrupts on PPC970,
we still have to pin all the guest pages on PPC970.  We have a new flag,
kvm->arch.using_mmu_notifiers, that indicates whether we can page
guest pages out.  If it is not set, the MMU notifier callbacks do
nothing and everything operates as before.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h    |    4 +
 arch/powerpc/include/asm/kvm_book3s_64.h |   31 ++++
 arch/powerpc/include/asm/kvm_host.h      |   16 ++
 arch/powerpc/include/asm/reg.h           |    3 +
 arch/powerpc/kvm/Kconfig                 |    1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  290 +++++++++++++++++++++++++++---
 arch/powerpc/kvm/book3s_hv.c             |   25 ++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  140 +++++++++++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |   49 +++++
 arch/powerpc/kvm/powerpc.c               |    3 +
 arch/powerpc/mm/hugetlbpage.c            |    2 +
 11 files changed, 499 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index f6329bb..ea9539c 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -145,6 +145,10 @@ extern void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat,
 extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
 extern int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu);
 extern pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
+extern void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
+			unsigned long *rmap, long pte_index, int realmode);
+extern void kvmppc_invalidate_hpte(struct kvm *kvm, unsigned long *hptep,
+			unsigned long pte_index);
 extern void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long addr,
 			unsigned long *nb_ret);
 extern void kvmppc_unpin_guest_page(struct kvm *kvm, void *addr);
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 79dc37f..c21e46d 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -136,6 +136,37 @@ static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long io_type)
 	return (wimg & (HPTE_R_W | HPTE_R_I)) == io_type;
 }
 
+/*
+ * Lock and read a linux PTE.  If it's present and writable, atomically
+ * set dirty and referenced bits and return the PTE, otherwise return 0.
+ */
+static inline pte_t kvmppc_read_update_linux_pte(pte_t *p)
+{
+	pte_t pte, tmp;
+
+	/* wait until _PAGE_BUSY is clear then set it atomically */
+	__asm__ __volatile__ (
+		"1:	ldarx	%0,0,%3\n"
+		"	andi.	%1,%0,%4\n"
+		"	bne-	1b\n"
+		"	ori	%1,%0,%4\n"
+		"	stdcx.	%1,0,%3\n"
+		"	bne-	1b"
+		: "=&r" (pte), "=&r" (tmp), "=m" (*p)
+		: "r" (p), "i" (_PAGE_BUSY)
+		: "cc");
+
+	if (pte_present(pte)) {
+		pte = pte_mkyoung(pte);
+		if (pte_write(pte))
+			pte = pte_mkdirty(pte);
+	}
+
+	*p = pte;	/* clears _PAGE_BUSY */
+
+	return pte;
+}
+
 /* Return HPTE cache control bits corresponding to Linux pte bits */
 static inline unsigned long hpte_cache_bits(unsigned long pte_val)
 {
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 937caca..968f3aa 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -32,6 +32,7 @@
 #include <linux/atomic.h>
 #include <asm/kvm_asm.h>
 #include <asm/processor.h>
+#include <asm/page.h>
 
 #define KVM_MAX_VCPUS		NR_CPUS
 #define KVM_MAX_VCORES		NR_CPUS
@@ -44,6 +45,19 @@
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
@@ -212,6 +226,7 @@ struct kvm_arch {
 	struct kvmppc_rma_info *rma;
 	unsigned long vrma_slb_v;
 	int rma_setup_done;
+	int using_mmu_notifiers;
 	struct list_head spapr_tce_tables;
 	spinlock_t slot_phys_lock;
 	unsigned long *slot_phys[KVM_MEM_SLOTS_NUM];
@@ -460,6 +475,7 @@ struct kvm_vcpu_arch {
 	struct list_head run_list;
 	struct task_struct *run_task;
 	struct kvm_run *kvm_run;
+	pgd_t *pgdir;
 #endif
 };
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c74379a..209dc74 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -495,6 +495,9 @@
 #define SPRN_SPRG7	0x117	/* Special Purpose Register General 7 */
 #define SPRN_SRR0	0x01A	/* Save/Restore Register 0 */
 #define SPRN_SRR1	0x01B	/* Save/Restore Register 1 */
+#define   SRR1_ISI_NOPT		0x40000000 /* ISI: Not found in hash */
+#define   SRR1_ISI_N_OR_G	0x10000000 /* ISI: Access is no-exec or G */
+#define   SRR1_ISI_PROT		0x08000000 /* ISI: Other protection fault */
 #define   SRR1_WAKEMASK		0x00380000 /* reason for wakeup */
 #define   SRR1_WAKESYSERR	0x00300000 /* System error */
 #define   SRR1_WAKEEE		0x00200000 /* External interrupt */
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
index 2d31519..83761dd 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -281,8 +281,9 @@ static long kvmppc_get_guest_page(struct kvm *kvm, unsigned long gfn,
 }
 
 /*
- * We come here on a H_ENTER call from the guest when
- * we don't have the requested page pinned already.
+ * We come here on a H_ENTER call from the guest when we are not
+ * using mmu notifiers and we don't have the requested page pinned
+ * already.
  */
 long kvmppc_virtmode_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			long pte_index, unsigned long pteh, unsigned long ptel)
@@ -292,6 +293,9 @@ long kvmppc_virtmode_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	struct kvm_memory_slot *memslot;
 	long ret;
 
+	if (kvm->arch.using_mmu_notifiers)
+		goto do_insert;
+
 	psize = hpte_page_size(pteh, ptel);
 	if (!psize)
 		return H_PARAMETER;
@@ -309,9 +313,12 @@ long kvmppc_virtmode_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			return H_PARAMETER;
 	}
 
-	preempt_disable();
+ do_insert:
+	/* Protect linux PTE lookup from page table destruction */
+	rcu_read_lock_sched();	/* this disables preemption too */
+	vcpu->arch.pgdir = current->mm->pgd;
 	ret = kvmppc_h_enter(vcpu, flags, pte_index, pteh, ptel);
-	preempt_enable();
+	rcu_read_unlock_sched();
 	if (ret == H_TOO_HARD) {
 		/* this can't happen */
 		pr_err("KVM: Oops, kvmppc_h_enter returned too hard!\n");
@@ -487,12 +494,16 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				unsigned long ea, unsigned long dsisr)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long *hptep, hpte[3];
-	unsigned long psize;
-	unsigned long gfn;
+	unsigned long *hptep, hpte[3], r;
+	unsigned long mmu_seq, psize, pte_size;
+	unsigned long gfn, hva, pfn;
 	struct kvm_memory_slot *memslot;
+	unsigned long *rmap;
 	struct revmap_entry *rev;
-	long index;
+	struct page *page, *pages[1];
+	long index, ret, npages;
+	unsigned long is_io;
+	struct vm_area_struct *vma;
 
 	/*
 	 * Real-mode code has already searched the HPT and found the
@@ -510,7 +521,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		cpu_relax();
 	hpte[0] = hptep[0] & ~HPTE_V_HVLOCK;
 	hpte[1] = hptep[1];
-	hpte[2] = rev->guest_rpte;
+	hpte[2] = r = rev->guest_rpte;
 	asm volatile("lwsync" : : : "memory");
 	hptep[0] = hpte[0];
 	preempt_enable();
@@ -520,8 +531,8 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		return RESUME_GUEST;
 
 	/* Translate the logical address and get the page */
-	psize = hpte_page_size(hpte[0], hpte[1]);
-	gfn = hpte_rpn(hpte[2], psize);
+	psize = hpte_page_size(hpte[0], r);
+	gfn = hpte_rpn(r, psize);
 	memslot = gfn_to_memslot(kvm, gfn);
 
 	/* No memslot means it's an emulated MMIO region */
@@ -531,8 +542,228 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 					      dsisr & DSISR_ISSTORE);
 	}
 
-	/* should never get here otherwise */
-	return -EFAULT;
+	if (!kvm->arch.using_mmu_notifiers)
+		return -EFAULT;		/* should never get here */
+
+	/* used to check for invalidations in progress */
+	mmu_seq = kvm->mmu_notifier_seq;
+	smp_rmb();
+
+	is_io = 0;
+	pfn = 0;
+	page = NULL;
+	pte_size = PAGE_SIZE;
+	hva = gfn_to_hva_memslot(memslot, gfn);
+	npages = get_user_pages_fast(hva, 1, 1, pages);
+	if (npages < 1) {
+		/* Check if it's an I/O mapping */
+		down_read(&current->mm->mmap_sem);
+		vma = find_vma(current->mm, hva);
+		if (vma && vma->vm_start <= hva && hva + psize <= vma->vm_end &&
+		    (vma->vm_flags & VM_PFNMAP)) {
+			pfn = vma->vm_pgoff +
+				((hva - vma->vm_start) >> PAGE_SHIFT);
+			pte_size = psize;
+			is_io = hpte_cache_bits(pgprot_val(vma->vm_page_prot));
+		}
+		up_read(&current->mm->mmap_sem);
+		if (!pfn)
+			return -EFAULT;
+	} else {
+		page = pages[0];
+		if (PageHuge(page)) {
+			page = compound_head(page);
+			pte_size <<= compound_order(page);
+		}
+		pfn = page_to_pfn(page);
+	}
+
+	ret = -EFAULT;
+	if (psize > pte_size)
+		goto out_put;
+
+	/* Check WIMG vs. the actual page we're accessing */
+	if (!hpte_cache_flags_ok(r, is_io)) {
+		if (is_io)
+			return -EFAULT;
+		/*
+		 * Allow guest to map emulated device memory as
+		 * uncacheable, but actually make it cacheable.
+		 */
+		r = (r & ~(HPTE_R_W|HPTE_R_I|HPTE_R_G)) | HPTE_R_M;
+	}
+
+	/* Set the HPTE to point to pfn */
+	r = (r & ~(HPTE_R_PP0 - pte_size)) | (pfn << PAGE_SHIFT);
+	ret = RESUME_GUEST;
+	preempt_disable();
+	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
+		cpu_relax();
+	if ((hptep[0] & ~HPTE_V_HVLOCK) != hpte[0] || hptep[1] != hpte[1] ||
+	    rev->guest_rpte != hpte[2])
+		/* HPTE has been changed under us; let the guest retry */
+		goto out_unlock;
+	hpte[0] = (hpte[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
+
+	rmap = &memslot->rmap[gfn - memslot->base_gfn];
+	lock_rmap(rmap);
+
+	/* Check if we might have been invalidated; let the guest retry if so */
+	ret = RESUME_GUEST;
+	if (mmu_notifier_retry(vcpu, mmu_seq)) {
+		unlock_rmap(rmap);
+		goto out_unlock;
+	}
+	kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
+
+	hptep[1] = r;
+	eieio();
+	hptep[0] = hpte[0];
+	asm volatile("ptesync" : : : "memory");
+	preempt_enable();
+	if (page)
+		SetPageDirty(page);
+
+ out_put:
+	if (page)
+		put_page(page);
+	return ret;
+
+ out_unlock:
+	hptep[0] &= ~HPTE_V_HVLOCK;
+	preempt_enable();
+	goto out_put;
+}
+
+static int kvm_handle_hva(struct kvm *kvm, unsigned long hva,
+			  int (*handler)(struct kvm *kvm, unsigned long *rmapp,
+					 unsigned long gfn))
+{
+	int ret;
+	int retval = 0;
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *memslot;
+
+	slots = kvm_memslots(kvm);
+	kvm_for_each_memslot(memslot, slots) {
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
+	unsigned long *hptep;
+	unsigned long ptel, psize;
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
+			kvmppc_invalidate_hpte(kvm, hptep, i);
+			hptep[0] |= HPTE_V_ABSENT;
+		}
+		hptep[0] &= ~HPTE_V_HVLOCK;
+	}
+	return 0;
+}
+
+int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
+{
+	if (kvm->arch.using_mmu_notifiers)
+		kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
+	return 0;
+}
+
+static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
+			 unsigned long gfn)
+{
+	if (!kvm->arch.using_mmu_notifiers)
+		return 0;
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
+	if (!kvm->arch.using_mmu_notifiers)
+		return 0;
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
+	if (!kvm->arch.using_mmu_notifiers)
+		return 0;
+	return kvm_handle_hva(kvm, hva, kvm_test_age_rmapp);
+}
+
+void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+{
+	if (!kvm->arch.using_mmu_notifiers)
+		return;
+	kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
 }
 
 void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long gpa,
@@ -540,31 +771,42 @@ void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long gpa,
 {
 	struct kvm_memory_slot *memslot;
 	unsigned long gfn = gpa >> PAGE_SHIFT;
-	struct page *page;
-	unsigned long psize, offset;
+	struct page *page, *pages[1];
+	int npages;
+	unsigned long hva, psize, offset;
 	unsigned long pa;
 	unsigned long *physp;
 
 	memslot = gfn_to_memslot(kvm, gfn);
 	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
 		return NULL;
-	physp = kvm->arch.slot_phys[memslot->id];
-	if (!physp)
-		return NULL;
-	physp += gfn - memslot->base_gfn;
-	pa = *physp;
-	if (!pa) {
-		if (kvmppc_get_guest_page(kvm, gfn, memslot, PAGE_SIZE) < 0)
+	if (!kvm->arch.using_mmu_notifiers) {
+		physp = kvm->arch.slot_phys[memslot->id];
+		if (!physp)
 			return NULL;
+		physp += gfn - memslot->base_gfn;
 		pa = *physp;
+		if (!pa) {
+			if (kvmppc_get_guest_page(kvm, gfn, memslot,
+						  PAGE_SIZE) < 0)
+				return NULL;
+			pa = *physp;
+		}
+		page = pfn_to_page(pa >> PAGE_SHIFT);
+	} else {
+		hva = gfn_to_hva_memslot(memslot, gfn);
+		npages = get_user_pages_fast(hva, 1, 1, pages);
+		if (npages < 1)
+			return NULL;
+		page = pages[0];
 	}
-	page = pfn_to_page(pa >> PAGE_SHIFT);
 	psize = PAGE_SIZE;
 	if (PageHuge(page)) {
 		page = compound_head(page);
 		psize <<= compound_order(page);
 	}
-	get_page(page);
+	if (!kvm->arch.using_mmu_notifiers)
+		get_page(page);
 	offset = gpa & (psize - 1);
 	if (nb_ret)
 		*nb_ret = psize - offset;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5ba84e1..cb8e15f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -326,19 +326,19 @@ static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 	}
 	/*
-	 * We get this if the guest accesses a page which it thinks
-	 * it has mapped but which is not actually present, because
-	 * it is for an emulated I/O device.
-	 * Any other HDSI interrupt has been handled already.
+	 * We get these next two if the guest accesses a page which it thinks
+	 * it has mapped but which is not actually present, either because
+	 * it is for an emulated I/O device or because the corresonding
+	 * host page has been paged out.  Any other HDSI/HISI interrupts
+	 * have been handled already.
 	 */
 	case BOOK3S_INTERRUPT_H_DATA_STORAGE:
 		r = kvmppc_book3s_hv_page_fault(run, vcpu,
 				vcpu->arch.fault_dar, vcpu->arch.fault_dsisr);
 		break;
 	case BOOK3S_INTERRUPT_H_INST_STORAGE:
-		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_INST_STORAGE,
-					vcpu->arch.shregs.msr & 0x58000000);
-		r = RESUME_GUEST;
+		r = kvmppc_book3s_hv_page_fault(run, vcpu,
+				kvmppc_get_pc(vcpu), 0);
 		break;
 	/*
 	 * This occurs if the guest executes an illegal instruction.
@@ -900,6 +900,7 @@ int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	flush_altivec_to_thread(current);
 	flush_vsx_to_thread(current);
 	vcpu->arch.wqp = &vcpu->arch.vcore->wq;
+	vcpu->arch.pgdir = current->mm->pgd;
 
 	do {
 		r = kvmppc_run_vcpu(run, vcpu);
@@ -1123,9 +1124,9 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 	unsigned long *phys;
 
 	/* Allocate a slot_phys array */
-	npages = mem->memory_size >> PAGE_SHIFT;
 	phys = kvm->arch.slot_phys[mem->slot];
-	if (!phys) {
+	if (!kvm->arch.using_mmu_notifiers && !phys) {
+		npages = mem->memory_size >> PAGE_SHIFT;
 		phys = vzalloc(npages * sizeof(unsigned long));
 		if (!phys)
 			return -ENOMEM;
@@ -1331,6 +1332,7 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 	}
 	kvm->arch.lpcr = lpcr;
 
+	kvm->arch.using_mmu_notifiers = !!cpu_has_feature(CPU_FTR_ARCH_206);
 	spin_lock_init(&kvm->arch.slot_phys_lock);
 	return 0;
 }
@@ -1339,8 +1341,9 @@ void kvmppc_core_destroy_vm(struct kvm *kvm)
 {
 	unsigned long i;
 
-	for (i = 0; i < KVM_MEM_SLOTS_NUM; i++)
-		unpin_slot(kvm, i);
+	if (!kvm->arch.using_mmu_notifiers)
+		for (i = 0; i < KVM_MEM_SLOTS_NUM; i++)
+			unpin_slot(kvm, i);
 
 	if (kvm->arch.rma) {
 		kvm_release_rma(kvm->arch.rma);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 00813ce..d9c636a 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -58,7 +58,7 @@ static void *real_vmalloc_addr(void *x)
  * Add this HPTE into the chain for the real page.
  * Must be called with the chain locked; it unlocks the chain.
  */
-static void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
+void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
 			     unsigned long *rmap, long pte_index, int realmode)
 {
 	struct revmap_entry *head, *tail;
@@ -83,6 +83,7 @@ static void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
 	smp_wmb();
 	*rmap = i | KVMPPC_RMAP_REFERENCED | KVMPPC_RMAP_PRESENT; /* unlock */
 }
+EXPORT_SYMBOL_GPL(kvmppc_add_revmap_chain);
 
 /* Remove this HPTE from the chain for a real page */
 static void remove_revmap_chain(struct kvm *kvm, long pte_index,
@@ -118,12 +119,33 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
 	unlock_rmap(rmap);
 }
 
+static pte_t lookup_linux_pte(struct kvm_vcpu *vcpu, unsigned long hva,
+			      unsigned long *pte_sizep)
+{
+	pte_t *ptep;
+	unsigned long ps = *pte_sizep;
+	unsigned int shift;
+
+	ptep = find_linux_pte_or_hugepte(vcpu->arch.pgdir, hva, &shift);
+	if (!ptep)
+		return __pte(0);
+	if (shift)
+		*pte_sizep = 1ul << shift;
+	else
+		*pte_sizep = PAGE_SIZE;
+	if (ps > *pte_sizep)
+		return __pte(0);
+	if (!pte_present(*ptep))
+		return __pte(0);
+	return kvmppc_read_update_linux_pte(ptep);
+}
+
 long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		    long pte_index, unsigned long pteh, unsigned long ptel)
 {
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long i, pa, gpa, gfn, psize;
-	unsigned long slot_fn;
+	unsigned long slot_fn, hva;
 	unsigned long *hpte;
 	struct revmap_entry *rev;
 	unsigned long g_ptel = ptel;
@@ -131,6 +153,8 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long *physp, pte_size;
 	unsigned long is_io;
 	unsigned long *rmap;
+	pte_t pte;
+	unsigned long mmu_seq;
 	bool realmode = vcpu->arch.vcore->vcore_state == VCORE_RUNNING;
 
 	psize = hpte_page_size(pteh, ptel);
@@ -138,11 +162,16 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		return H_PARAMETER;
 	pteh &= ~(HPTE_V_HVLOCK | HPTE_V_ABSENT | HPTE_V_VALID);
 
+	/* used later to detect if we might have been invalidated */
+	mmu_seq = kvm->mmu_notifier_seq;
+	smp_rmb();
+
 	/* Find the memslot (if any) for this address */
 	gpa = (ptel & HPTE_R_RPN) & ~(psize - 1);
 	gfn = gpa >> PAGE_SHIFT;
 	memslot = builtin_gfn_to_memslot(kvm, gfn);
 	pa = 0;
+	is_io = ~0ul;
 	rmap = NULL;
 	if (!(memslot && !(memslot->flags & KVM_MEMSLOT_INVALID))) {
 		/* PPC970 can't do emulated MMIO */
@@ -160,19 +189,31 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	slot_fn = gfn - memslot->base_gfn;
 	rmap = &memslot->rmap[slot_fn];
 
-	physp = kvm->arch.slot_phys[memslot->id];
-	if (!physp)
-		return H_PARAMETER;
-	physp += slot_fn;
-	if (realmode)
-		physp = real_vmalloc_addr(physp);
-	pa = *physp;
-	if (!pa)
-		return H_TOO_HARD;
-	is_io = pa & (HPTE_R_I | HPTE_R_W);
-	pte_size = PAGE_SIZE << (pa & KVMPPC_PAGE_ORDER_MASK);
-	pa &= PAGE_MASK;
-
+	if (!kvm->arch.using_mmu_notifiers) {
+		physp = kvm->arch.slot_phys[memslot->id];
+		if (!physp)
+			return H_PARAMETER;
+		physp += slot_fn;
+		if (realmode)
+			physp = real_vmalloc_addr(physp);
+		pa = *physp;
+		if (!pa)
+			return H_TOO_HARD;
+		is_io = pa & (HPTE_R_I | HPTE_R_W);
+		pte_size = PAGE_SIZE << (pa & KVMPPC_PAGE_ORDER_MASK);
+		pa &= PAGE_MASK;
+	} else {
+		/* Translate to host virtual address */
+		hva = gfn_to_hva_memslot(memslot, gfn);
+
+		/* Look up the Linux PTE for the backing page */
+		pte_size = psize;
+		pte = lookup_linux_pte(vcpu, hva, &pte_size);
+		if (pte_present(pte)) {
+			is_io = hpte_cache_bits(pte_val(pte));
+			pa = pte_pfn(pte) << PAGE_SHIFT;
+		}
+	}
 	if (pte_size < psize)
 		return H_PARAMETER;
 	if (pa && pte_size > psize)
@@ -180,10 +221,14 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 
 	ptel &= ~(HPTE_R_PP0 - psize);
 	ptel |= pa;
-	pteh |= HPTE_V_VALID;
+
+	if (pa)
+		pteh |= HPTE_V_VALID;
+	else
+		pteh |= HPTE_V_ABSENT;
 
 	/* Check WIMG */
-	if (!hpte_cache_flags_ok(ptel, is_io)) {
+	if (is_io != ~0ul && !hpte_cache_flags_ok(ptel, is_io)) {
 		if (is_io)
 			return H_PARAMETER;
 		/*
@@ -194,6 +239,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		ptel |= HPTE_R_M;
 	}
 
+	/* Find and lock the HPTEG slot to use */
  do_insert:
 	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
@@ -253,7 +299,17 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		if (realmode)
 			rmap = real_vmalloc_addr(rmap);
 		lock_rmap(rmap);
-		kvmppc_add_revmap_chain(kvm, rev, rmap, pte_index, realmode);
+		/* Check for pending invalidations under the rmap chain lock */
+		if (kvm->arch.using_mmu_notifiers &&
+		    mmu_notifier_retry(vcpu, mmu_seq)) {
+			/* inval in progress, write a non-present HPTE */
+			pteh |= HPTE_V_ABSENT;
+			pteh &= ~HPTE_V_VALID;
+			unlock_rmap(rmap);
+		} else {
+			kvmppc_add_revmap_chain(kvm, rev, rmap, pte_index,
+						realmode);
+		}
 	}
 
 	hpte[1] = ptel;
@@ -516,6 +572,23 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 	return H_SUCCESS;
 }
 
+void kvmppc_invalidate_hpte(struct kvm *kvm, unsigned long *hptep,
+			unsigned long pte_index)
+{
+	unsigned long rb;
+
+	hptep[0] &= ~HPTE_V_VALID;
+	rb = compute_tlbie_rb(hptep[0], hptep[1], pte_index);
+	while (!try_lock_tlbie(&kvm->arch.tlbie_lock))
+		cpu_relax();
+	asm volatile("ptesync" : : : "memory");
+	asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
+		     : : "r" (rb), "r" (kvm->arch.lpid));
+	asm volatile("ptesync" : : : "memory");
+	kvm->arch.tlbie_lock = 0;
+}
+EXPORT_SYMBOL_GPL(kvmppc_invalidate_hpte);
+
 static int slb_base_page_shift[4] = {
 	24,	/* 16M */
 	16,	/* 64k */
@@ -605,15 +678,15 @@ EXPORT_SYMBOL(kvmppc_hv_find_lock_hpte);
 
 /*
  * Called in real mode to check whether an HPTE not found fault
- * is due to accessing an emulated MMIO page.
+ * is due to accessing a paged-out page or an emulated MMIO page.
  * Returns a possibly modified status (DSISR) value if not
  * (i.e. pass the interrupt to the guest),
  * -1 to pass the fault up to host kernel mode code, -2 to do that
- * and also load the instruction word,
+ * and also load the instruction word (for MMIO emulation),
  * or 0 if we should make the guest retry the access.
  */
 long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
-			  unsigned long slb_v, unsigned int status)
+			  unsigned long slb_v, unsigned int status, bool data)
 {
 	struct kvm *kvm = vcpu->kvm;
 	long int index;
@@ -624,6 +697,7 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 	unsigned long pp, key;
 
 	valid = HPTE_V_VALID | HPTE_V_ABSENT;
+
 	index = kvmppc_hv_find_lock_hpte(kvm, addr, slb_v, valid);
 	if (index < 0)
 		return status;		/* there really was no HPTE */
@@ -645,22 +719,28 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 	/* Check access permissions to the page */
 	pp = gr & (HPTE_R_PP0 | HPTE_R_PP);
 	key = (vcpu->arch.shregs.msr & MSR_PR) ? SLB_VSID_KP : SLB_VSID_KS;
-	if (status & DSISR_ISSTORE) {
+	status &= ~DSISR_NOHPTE;	/* DSISR_NOHPTE == SRR1_ISI_NOPT */
+	if (!data) {
+		if (gr & (HPTE_R_N | HPTE_R_G))
+			return status | SRR1_ISI_N_OR_G;
+		if (!hpte_read_permission(pp, slb_v & key))
+			return status | SRR1_ISI_PROT;
+	} else if (status & DSISR_ISSTORE) {
 		/* check write permission */
 		if (!hpte_write_permission(pp, slb_v & key))
-			goto protfault;
+			return status | DSISR_PROTFAULT;
 	} else {
 		if (!hpte_read_permission(pp, slb_v & key))
-			goto protfault;
+			return status | DSISR_PROTFAULT;
 	}
 
 	/* Check storage key, if applicable */
-	if (vcpu->arch.shregs.msr & MSR_DR) {
+	if (data && (vcpu->arch.shregs.msr & MSR_DR)) {
 		unsigned int perm = hpte_get_skey_perm(gr, vcpu->arch.amr);
 		if (status & DSISR_ISSTORE)
 			perm >>= 1;
 		if (perm & 1)
-			return (status & ~DSISR_NOHPTE) | DSISR_KEYFAULT;
+			return status | DSISR_KEYFAULT;
 	}
 
 	/* Save HPTE info for virtual-mode handler */
@@ -669,11 +749,11 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 	vcpu->arch.pgfault_hpte[0] = v;
 	vcpu->arch.pgfault_hpte[1] = r;
 
-	if (vcpu->arch.shregs.msr & MSR_IR)
+	/* Check the storage key to see if it is possibly emulated MMIO */
+	if (data && (vcpu->arch.shregs.msr & MSR_IR) &&
+	    (r & (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) ==
+	    (HPTE_R_KEY_HI | HPTE_R_KEY_LO))
 		return -2;	/* MMIO emulation - load instr word */
 
 	return -1;		/* send fault up to host kernel mode */
-
- protfault:
-	return (status & ~DSISR_NOHPTE) | DSISR_PROTFAULT;
 }
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 3a04550..930e09e 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -618,6 +618,8 @@ BEGIN_FTR_SECTION
 	/* If this is a page table miss then see if it's theirs or ours */
 	cmpwi	r12, BOOK3S_INTERRUPT_H_DATA_STORAGE
 	beq	kvmppc_hdsi
+	cmpwi	r12, BOOK3S_INTERRUPT_H_INST_STORAGE
+	beq	kvmppc_hisi
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 
 	/* See if this is a leftover HDEC interrupt */
@@ -1122,6 +1124,7 @@ kvmppc_hdsi:
 
 	/* Search the hash table. */
 	mr	r3, r9			/* vcpu pointer */
+	li	r7, 1			/* data fault */
 	bl	.kvmppc_hpte_hv_fault
 	ld	r9, HSTATE_KVM_VCPU(r13)
 	ld	r10, VCPU_PC(r9)
@@ -1179,6 +1182,52 @@ kvmppc_hdsi:
 	b	nohpte_cont
 
 /*
+ * Similarly for an HISI, reflect it to the guest as an ISI unless
+ * it is an HPTE not found fault for a page that we have paged out.
+ */
+kvmppc_hisi:
+	andis.	r0, r11, SRR1_ISI_NOPT@h
+	beq	1f
+	andi.	r0, r11, MSR_IR		/* instruction relocation enabled? */
+	beq	3f
+	clrrdi	r0, r10, 28
+	PPC_SLBFEE_DOT(r5, r0)		/* if so, look up SLB */
+	bne	1f			/* if no SLB entry found */
+4:
+	/* Search the hash table. */
+	mr	r3, r9			/* vcpu pointer */
+	mr	r4, r10
+	mr	r6, r11
+	li	r7, 0			/* instruction fault */
+	bl	.kvmppc_hpte_hv_fault
+	ld	r9, HSTATE_KVM_VCPU(r13)
+	ld	r10, VCPU_PC(r9)
+	ld	r11, VCPU_MSR(r9)
+	li	r12, BOOK3S_INTERRUPT_H_INST_STORAGE
+	cmpdi	r3, 0			/* retry the instruction */
+	beq	6f
+	cmpdi	r3, -1			/* handle in kernel mode */
+	beq	nohpte_cont
+
+	/* Synthesize an ISI for the guest */
+	mr	r11, r3
+1:	mtspr	SPRN_SRR0, r10
+	mtspr	SPRN_SRR1, r11
+	li	r10, BOOK3S_INTERRUPT_INST_STORAGE
+	li	r11, (MSR_ME << 1) | 1	/* synthesize MSR_SF | MSR_ME */
+	rotldi	r11, r11, 63
+6:	ld	r7, VCPU_CTR(r9)
+	lwz	r8, VCPU_XER(r9)
+	mtctr	r7
+	mtxer	r8
+	mr	r4, r9
+	b	fast_guest_return
+
+3:	ld	r6, VCPU_KVM(r9)	/* not relocated, use VRMA */
+	ld	r5, KVM_VRMA_SLB_V(r6)
+	b	4b
+
+/*
  * Try to handle an hcall in real mode.
  * Returns to the guest if we handle it, or continues on up to
  * the kernel if we can't (i.e. if we don't have a handler for
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 69367ac..bc09c39 100644
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
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 5964371..1127e17 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
+#include <linux/export.h>
 #include <linux/of_fdt.h>
 #include <linux/memblock.h>
 #include <linux/bootmem.h>
@@ -102,6 +103,7 @@ pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift
 		*shift = hugepd_shift(*hpdp);
 	return hugepte_offset(hpdp, ea, pdshift);
 }
+EXPORT_SYMBOL_GPL(find_linux_pte_or_hugepte);
 
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
-- 
1.7.7.3
