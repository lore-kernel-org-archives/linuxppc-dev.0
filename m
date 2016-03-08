Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 353F21A011E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:09:16 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 23/25] powerpc/kvm: Rehashing for HPT resizing
Date: Tue,  8 Mar 2016 14:09:00 +1100
Message-Id: <1457406542-6210-24-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
References: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds code for the "guts" of an HPT resize operation: rehashing HPTEs
from the current HPT into the new resized HPT.

This is performed by the HPT resize work thread, but is gated to occur only
while the guest is executing the H_RESIZE_HPT_COMMIT hypercall.  The guest
is expected not to modify or use the hash table during this period which
simplifies things somewhat (Linux guests do this with stop_machine()).
However, there are still host processes active which could affect the guest
so there's still some hairy synchronization.

To reduce the amount of stuff we need to do (and thus the latency of the
operation) we only rehash bolted entries, expecting the guest to refault
other HPTEs after the resize is complete.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_book3s.h |   6 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c   | 166 +++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   |  10 +-
 3 files changed, 173 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 81f2b77..935fbba 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -156,8 +156,10 @@ extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
 extern int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu);
 extern kvm_pfn_t kvmppc_gpa_to_pfn(struct kvm_vcpu *vcpu, gpa_t gpa,
 			bool writing, bool *writable);
-extern void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
-			unsigned long *rmap, long pte_index, int realmode);
+extern void kvmppc_add_revmap_chain(struct kvm_hpt_info *hpt,
+				    struct revmap_entry *rev,
+				    unsigned long *rmap,
+				    long pte_index, int realmode);
 extern void kvmppc_update_rmap_change(unsigned long *rmap, unsigned long psize);
 extern void kvmppc_invalidate_hpte(struct kvm *kvm, __be64 *hptep,
 			unsigned long pte_index);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index c4c1814..d06aef6 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -681,7 +681,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		/* don't lose previous R and C bits */
 		r |= be64_to_cpu(hptep[1]) & (HPTE_R_R | HPTE_R_C);
 	} else {
-		kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
+		kvmppc_add_revmap_chain(&kvm->arch.hpt, rev, rmap, index, 0);
 	}
 
 	hptep[1] = cpu_to_be64(r);
@@ -1249,9 +1249,171 @@ static int resize_hpt_allocate(struct kvm_resize_hpt *resize,
 	return H_SUCCESS;
 }
 
+static unsigned long resize_hpt_rehash_hpte(struct kvm *kvm,
+					    struct kvm_resize_hpt *resize,
+					    unsigned long pteg, int slot)
+{
+
+	struct kvm_hpt_info *old = &kvm->arch.hpt;
+	struct kvm_hpt_info *new = &resize->hpt;
+	unsigned long old_idx = pteg * HPTES_PER_GROUP + slot;
+	unsigned long new_idx;
+	__be64 *hptep, *new_hptep;
+	unsigned long old_hash_mask = (1ULL << (old->order - 7)) - 1;
+	unsigned long new_hash_mask = (1ULL << (new->order - 7)) - 1;
+	unsigned long pte0, pte1, guest_pte1;
+	unsigned long avpn;
+	unsigned long psize, a_psize;
+	unsigned long hash, new_pteg, replace_pte0;
+	unsigned long gpa, gfn;
+	struct kvm_memory_slot *memslot;
+	struct revmap_entry *new_rev;
+	unsigned long mmu_seq;
+
+	mmu_seq = kvm->mmu_notifier_seq;
+	smp_rmb();
+
+	hptep = (__be64 *)(old->virt + (old_idx << 4));
+	if (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
+		return H_HARDWARE;
+
+	pte0 = be64_to_cpu(hptep[0]);
+	pte1 = be64_to_cpu(hptep[1]);
+	guest_pte1 = old->rev[old_idx].guest_rpte;
+
+	unlock_hpte(hptep, pte0);
+
+	if (!(pte0 & HPTE_V_VALID) && !(pte0 & HPTE_V_ABSENT))
+		/* Nothing to do */
+		return H_SUCCESS;
+
+	if (!(pte0 & HPTE_V_BOLTED))
+		/* Don't bother rehashing non-bolted HPTEs */
+		return H_SUCCESS;
+
+	pte1 = be64_to_cpu(hptep[1]);
+	psize = hpte_base_page_size(pte0, pte1);
+	if (WARN_ON(!psize))
+		return H_HARDWARE;
+
+	avpn = HPTE_V_AVPN_VAL(pte0) & ~((psize - 1) >> 23);
+
+	if (pte0 & HPTE_V_SECONDARY)
+		pteg = ~pteg;
+
+	if (!(pte0 & HPTE_V_1TB_SEG)) {
+		unsigned long offset, vsid;
+
+		/* We only have 28 - 23 bits of offset in avpn */
+		offset = (avpn & 0x1f) << 23;
+		vsid = avpn >> 5;
+		/* We can find more bits from the pteg value */
+		if (psize < (1ULL << 23))
+			offset |= ((vsid ^ pteg) & old_hash_mask) * psize;
+
+		hash = vsid ^ (offset / psize);
+	} else {
+		unsigned long offset, vsid;
+
+		/* We only have 40 - 23 bits of seg_off in avpn */
+		offset = (avpn & 0x1ffff) << 23;
+		vsid = avpn >> 17;
+		if (psize < (1ULL << 23))
+			offset |= ((vsid ^ (vsid << 25) ^ pteg) & old_hash_mask) * psize;
+
+		hash = vsid ^ (vsid << 25) ^ (offset / psize);
+	}
+
+	new_pteg = hash & new_hash_mask;
+	if (pte0 & HPTE_V_SECONDARY) {
+		BUG_ON(~pteg != (hash & old_hash_mask));
+		new_pteg = ~new_pteg;
+	} else {
+		BUG_ON(pteg != (hash & old_hash_mask));
+	}
+
+	new_idx = new_pteg * HPTES_PER_GROUP + slot;
+	new_hptep = (__be64 *)(new->virt + (new_idx << 4));
+	replace_pte0 = be64_to_cpu(new_hptep[0]);
+
+	if (replace_pte0 & HPTE_V_VALID) {
+		BUG_ON(new->order >= old->order);
+
+		if (replace_pte0 & HPTE_V_BOLTED) {
+			if (pte0 & HPTE_V_BOLTED)
+				/* Bolted collision, nothing we can do */
+				return H_PTEG_FULL;
+			else
+				/* Discard this hpte */
+				return H_SUCCESS;
+		}
+		// FIXME: clean up old HPTE
+		BUG();
+	}
+
+	/* Update the rmap */
+	new_rev = &new->rev[new_idx];
+	new_rev->guest_rpte = guest_pte1;
+
+	a_psize = hpte_page_size(pte0, pte1);
+	gpa = (guest_pte1 & HPTE_R_RPN) & ~(a_psize - 1);
+	gfn = gpa >> PAGE_SHIFT;
+	memslot = __gfn_to_memslot(kvm_memslots_raw(kvm), gfn);
+	if (memslot && !(memslot->flags & KVM_MEMSLOT_INVALID)) {
+		unsigned long *old_rmap =
+			&memslot->arch.rmap[gfn - memslot->base_gfn];
+		unsigned long *new_rmap =
+			&resize->rmap[memslot->id][gfn - memslot->base_gfn];
+
+		lock_rmap(old_rmap);
+		lock_rmap(new_rmap);
+		/* Check for pending invalidations under the rmap chain lock */
+		if (mmu_notifier_retry(kvm, mmu_seq)) {
+			/* inval in progress, write a non-present HPTE */
+			pte0 |= HPTE_V_ABSENT;
+			pte0 &= ~HPTE_V_VALID;
+			unlock_rmap(new_rmap);
+			unlock_rmap(old_rmap);
+		} else {
+			unsigned long rcbits;
+
+			kvmppc_add_revmap_chain(&resize->hpt, new_rev,
+						new_rmap, new_idx, false);
+			/* Only set R/C in real HPTE if already set in *rmap */
+			rcbits = *old_rmap >> KVMPPC_RMAP_RC_SHIFT;
+			rcbits |= *new_rmap >> KVMPPC_RMAP_RC_SHIFT;
+			unlock_rmap(old_rmap);
+			pte1 &= rcbits | ~(HPTE_R_R | HPTE_R_C);
+		}
+	} else {
+		/* Emulated MMIO, no rmap */
+	}
+
+	new_hptep[1] = cpu_to_be64(pte1);
+	/* Don't need a barrier here, because the hpt isn't in use yet */
+	new_hptep[0] = cpu_to_be64(replace_pte0);
+	unlock_hpte(new_hptep, pte0);
+	
+	return H_SUCCESS;
+}
+
 static int resize_hpt_rehash(struct kvm_resize_hpt *resize)
 {
-	return H_HARDWARE;
+	struct kvm *kvm = resize->kvm;
+	uint64_t n_ptegs = 1ULL << (kvm->arch.hpt.order - 7);
+	uint64_t pteg;
+	int slot;
+	int rc;
+
+	for (pteg = 0; pteg < n_ptegs; pteg++) {
+		for (slot = 0; slot < HPTES_PER_GROUP; slot++) {
+			rc = resize_hpt_rehash_hpte(kvm, resize, pteg, slot);
+			if (rc != H_SUCCESS)
+				return rc;
+		}
+	}
+
+	return H_SUCCESS;
 }
 
 static void resize_hpt_pivot(struct kvm_resize_hpt *resize,
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 347ed0e..48e74ac 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -71,7 +71,7 @@ static int global_invalidates(struct kvm *kvm, unsigned long flags)
  * Add this HPTE into the chain for the real page.
  * Must be called with the chain locked; it unlocks the chain.
  */
-void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
+void kvmppc_add_revmap_chain(struct kvm_hpt_info *hpt, struct revmap_entry *rev,
 			     unsigned long *rmap, long pte_index, int realmode)
 {
 	struct revmap_entry *head, *tail;
@@ -79,10 +79,10 @@ void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
 
 	if (*rmap & KVMPPC_RMAP_PRESENT) {
 		i = *rmap & KVMPPC_RMAP_INDEX;
-		head = &kvm->arch.hpt.rev[i];
+		head = &hpt->rev[i];
 		if (realmode)
 			head = real_vmalloc_addr(head);
-		tail = &kvm->arch.hpt.rev[head->back];
+		tail = &hpt->rev[head->back];
 		if (realmode)
 			tail = real_vmalloc_addr(tail);
 		rev->forw = i;
@@ -353,8 +353,8 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 			pteh &= ~HPTE_V_VALID;
 			unlock_rmap(rmap);
 		} else {
-			kvmppc_add_revmap_chain(kvm, rev, rmap, pte_index,
-						realmode);
+			kvmppc_add_revmap_chain(&kvm->arch.hpt, rev, rmap,
+						pte_index, realmode);
 			/* Only set R/C in real HPTE if already set in *rmap */
 			rcbits = *rmap >> KVMPPC_RMAP_RC_SHIFT;
 			ptel &= rcbits | ~(HPTE_R_R | HPTE_R_C);
-- 
2.5.0
