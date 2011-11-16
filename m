Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Nov 2011 10:55:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org
Subject: [RFC PATCH 11/11] KVM: PPC: Eliminate global spinlock in
 kvmppc_h_enter
Message-ID: <20111116235549.GL26985@bloggs.ozlabs.ibm.com>
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From dfd5bcfac841f8a36593edf60d9fb15e0d633287 Mon Sep 17 00:00:00 2001
From: Paul Mackerras <paulus@samba.org>
Date: Mon, 14 Nov 2011 13:30:38 +1100
Subject: 

Currently, kvmppc_h_enter takes a spinlock that is global to the guest,
kvm->mmu_lock, in order to check for pending PTE invalidations safely.
On some workloads, kvmppc_h_enter is called heavily and the use of a
global spinlock could compromise scalability.  We already use a per-
guest page spinlock in the form of the bit spinlock on the rmap chain,
and this gives us synchronization with the PTE invalidation side, which
also takes the bit spinlock on the rmap chain for each page being
invalidated.  Thus it is sufficient to check for pending invalidations
while the rmap chain bit spinlock is held.  However, now we require
barriers in mmu_notifier_retry() and in the places where
mmu_notifier_count and mmu_notifier_seq are updated, since we can now
call mmu_notifier_retry() concurrently with updates to those fields.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Cc'd to kvm@vger.kernel.org for review of the generic kvm changes.

 arch/powerpc/include/asm/kvm_book3s_64.h |   13 +++++
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |   19 ++++----
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |   75 ++++++++++++-----------------
 include/linux/kvm_host.h                 |   13 +++--
 virt/kvm/kvm_main.c                      |    4 ++
 5 files changed, 66 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 3745337..db6cbd5 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -161,4 +161,17 @@ static inline unsigned long kvmppc_read_update_linux_pte(pte_t *p)
 	return pfn;
 }
 
+static inline void lock_rmap(unsigned long *rmap)
+{
+	do {
+		while (test_bit(KVMPPC_RMAP_LOCK_BIT, rmap))
+			cpu_relax();
+	} while (test_and_set_bit_lock(KVMPPC_RMAP_LOCK_BIT, rmap));
+}
+
+static inline void unlock_rmap(unsigned long *rmap)
+{
+	__clear_bit_unlock(KVMPPC_RMAP_LOCK_BIT, rmap);
+}
+
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 8c497b8..bb75bfb 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -611,12 +611,6 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		goto out_put;
 	pfn = page_to_pfn(page);
 
-	/* Check if we might have been invalidated; let the guest retry if so */
-	ret = RESUME_GUEST;
-	spin_lock(&kvm->mmu_lock);
-	if (mmu_notifier_retry(vcpu, mmu_seq))
-		goto out_unlock;
-
 	/* Set the HPTE to point to pfn */
 	ret = RESUME_GUEST;
 	hptep = (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
@@ -627,19 +621,26 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	    rev->guest_rpte != hpte[2]) {
 		/* HPTE has been changed under us; let the guest retry */
 		hptep[0] &= ~HPTE_V_HVLOCK;
-		goto out_unlock;
+		goto out_put;
 	}
 	hpte[0] = (hpte[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
 	hpte[1] = (rev->guest_rpte & ~(HPTE_R_PP0 - pte_size)) |
 		(pfn << PAGE_SHIFT);
 	rmap = &memslot->rmap[gfn - memslot->base_gfn];
+	lock_rmap(rmap);
+
+	/* Check if we might have been invalidated; let the guest retry if so */
+	ret = RESUME_GUEST;
+	if (mmu_notifier_retry(vcpu, mmu_seq)) {
+		unlock_rmap(rmap);
+		hptep[0] &= ~HPTE_V_HVLOCK;
+		goto out_put;
+	}
 	kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
 	kvmppc_modify_hpte(kvm, hptep, hpte, index);
 	if (page)
 		SetPageDirty(page);
 
- out_unlock:
-	spin_unlock(&kvm->mmu_lock);
  out_put:
 	if (page)
 		put_page(page);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 2cadd06..4070920 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -57,22 +57,16 @@ static struct kvm_memory_slot *builtin_gfn_to_memslot(struct kvm *kvm,
 	return NULL;
 }
 
-static void lock_rmap(unsigned long *rmap)
-{
-	do {
-		while (test_bit(KVMPPC_RMAP_LOCK_BIT, rmap))
-			cpu_relax();
-	} while (test_and_set_bit_lock(KVMPPC_RMAP_LOCK_BIT, rmap));
-}
-
-/* Add this HPTE into the chain for the real page */
+/*
+ * Add this HPTE into the chain for the real page.
+ * Must be called with the chain locked; it unlocks the chain.
+ */
 void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
 			     unsigned long *rmap, long pte_index, int realmode)
 {
 	struct revmap_entry *head, *tail;
 	unsigned long i;
 
-	lock_rmap(rmap);
 	if (*rmap & KVMPPC_RMAP_PRESENT) {
 		i = *rmap & KVMPPC_RMAP_INDEX;
 		head = &kvm->arch.revmap[i];
@@ -125,7 +119,7 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
 		else
 			*rmap = (*rmap & ~KVMPPC_RMAP_INDEX) | head;
 	}
-	__clear_bit_unlock(KVMPPC_RMAP_LOCK_BIT, rmap);
+	unlock_rmap(rmap);
 }
 
 long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
@@ -218,38 +212,8 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			return H_PARAMETER;
 	}
 
-	/*
-	 * Now that we're about to write the HPTE and thus give the guest
-	 * access to the page, check for any pending invalidations.
-	 * We don't need to worry about that if this is a non-present page.
-	 * Note that the HPTE bitlock has to nest inside the kvm->mmu_lock.
-	 */
-	spin_lock(&kvm->mmu_lock);
-	if (mmu_notifier_retry(vcpu, mmu_seq))
-		/* inval in progress, write a non-present HPTE */
-		pa = 0;
-
-	err = H_PARAMETER;
-	if (!pa) {
-		/*
-		 * If this is a non-present page for any reason
-		 * and this is a POWER7, set the key to 31 and set N.
-		 * If this is a page which could be accessed in real mode
-		 * using VRMA (which ignores page class keys) we have
-		 * to make it invalid instead.
-		 * On 970 we have to have all pages present.
-		 */
-		if (!cpu_has_feature(CPU_FTR_ARCH_206))
-			goto out;
-		pteh |= HPTE_V_ABSENT;
-		if ((pteh & 0xffffffffff000000ul) ==
-		    (HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16))))
-			pteh &= ~HPTE_V_VALID;
-		else
-			ptel |= HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_R_N;
-	}
-
 	/* Find and lock the HPTEG slot to use */
+	err = H_PARAMETER;
 	if (pte_index >= HPT_NPTE)
 		goto out;
 	err = H_PTEG_FULL;
@@ -281,7 +245,31 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	/* Link HPTE into reverse-map chain */
 	if (pa) {
 		rmap = real_vmalloc_addr(rmap);
-		kvmppc_add_revmap_chain(kvm, rev, rmap, pte_index, 1);
+		lock_rmap(rmap);
+		/* Check for pending invalidations under the rmap chain lock */
+		if (mmu_notifier_retry(vcpu, mmu_seq)) {
+			/* inval in progress, write a non-present HPTE */
+			pa = 0;
+			unlock_rmap(rmap);
+		} else {
+			kvmppc_add_revmap_chain(kvm, rev, rmap, pte_index, 1);
+		}
+	}
+
+	if (!pa) {
+		/*
+		 * If this is a non-present page for any reason
+		 * and this is a POWER7, set the key to 31 and set N.
+		 * If this is a page which could be accessed in real mode
+		 * using VRMA (which ignores page class keys) we have
+		 * to make it invalid instead.
+		 */
+		pteh |= HPTE_V_ABSENT;
+		if ((pteh & 0xffffffffff000000ul) ==
+		    (HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16))))
+			pteh &= ~HPTE_V_VALID;
+		else
+			ptel |= HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_R_N;
 	}
 
 	hpte[1] = ptel;
@@ -295,7 +283,6 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	err = H_SUCCESS;
 
  out:
-	spin_unlock(&kvm->mmu_lock);
 	return err;
 }
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c6a2ec9..9b5e61a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -672,12 +672,15 @@ static inline int mmu_notifier_retry(struct kvm_vcpu *vcpu, unsigned long mmu_se
 	if (unlikely(vcpu->kvm->mmu_notifier_count))
 		return 1;
 	/*
-	 * Both reads happen under the mmu_lock and both values are
-	 * modified under mmu_lock, so there's no need of smb_rmb()
-	 * here in between, otherwise mmu_notifier_count should be
-	 * read before mmu_notifier_seq, see
-	 * mmu_notifier_invalidate_range_end write side.
+	 * Ensure the read of mmu_notifier_count happens before the read
+	 * of mmu_notifier_seq.  This interacts with the smp_wmb() in
+	 * mmu_notifier_invalidate_range_end to make sure that the caller
+	 * either sees the old (non-zero) value of mmu_notifier_count or
+	 * the new (incremented) value of mmu_notifier_seq.
+	 * PowerPC Book3s HV KVM calls this under a per-page lock
+	 * rather than under kvm->mmu_lock, for scalability.
 	 */
+	smp_rmb();
 	if (vcpu->kvm->mmu_notifier_seq != mmu_seq)
 		return 1;
 	return 0;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d9cfb78..95081f5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -290,6 +290,7 @@ static void kvm_mmu_notifier_invalidate_page(struct mmu_notifier *mn,
 	idx = srcu_read_lock(&kvm->srcu);
 	spin_lock(&kvm->mmu_lock);
 	kvm->mmu_notifier_seq++;
+	smp_wmb();
 	need_tlb_flush = kvm_unmap_hva(kvm, address) | kvm->tlbs_dirty;
 	spin_unlock(&kvm->mmu_lock);
 	srcu_read_unlock(&kvm->srcu, idx);
@@ -311,6 +312,7 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 	idx = srcu_read_lock(&kvm->srcu);
 	spin_lock(&kvm->mmu_lock);
 	kvm->mmu_notifier_seq++;
+	smp_wmb();
 	kvm_set_spte_hva(kvm, address, pte);
 	spin_unlock(&kvm->mmu_lock);
 	srcu_read_unlock(&kvm->srcu, idx);
@@ -332,6 +334,7 @@ static void kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	 * count is also read inside the mmu_lock critical section.
 	 */
 	kvm->mmu_notifier_count++;
+	smp_wmb();
 	for (; start < end; start += PAGE_SIZE)
 		need_tlb_flush |= kvm_unmap_hva(kvm, start);
 	need_tlb_flush |= kvm->tlbs_dirty;
@@ -357,6 +360,7 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 	 * been freed.
 	 */
 	kvm->mmu_notifier_seq++;
+	smp_wmb();
 	/*
 	 * The above sequence increase must be visible before the
 	 * below count decrease but both values are read by the kvm
-- 
1.7.7.2
