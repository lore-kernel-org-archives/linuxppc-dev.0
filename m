Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT22t20FWzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 14:52:22 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 michael@ellerman.id.au, David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv3 16/17] powerpc/kvm: HVM-HV HPT resizing, commit path
Date: Mon, 21 Mar 2016 14:53:23 +1100
Message-Id: <1458532404-21258-17-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
References: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds code for the "guts" of an HPT resize operation: rehashing
HPTEs from the current HPT into the new resized HPT, and switching the
guest over to the new HPT.

This is performed by the H_RESIZE_HPT_COMMIT hypercall.  The guest is
prevented from running during this operation, to simplify
synchronization.  the guest is expected to prepare itself for a
potentailly long pause before making the hcall; Linux guests use
stop_machine() for this.

To reduce the amount of stuff we need to do (and thus the latency of the
operation) we only rehash bolted entries, expecting the guest to refault
other HPTEs after the resize is complete.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_book3s.h |   6 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c   | 167 +++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   |  10 +-
 3 files changed, 174 insertions(+), 9 deletions(-)

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
index acc6dd4..b6ec7f3 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -641,7 +641,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		/* don't lose previous R and C bits */
 		r |= be64_to_cpu(hptep[1]) & (HPTE_R_R | HPTE_R_C);
 	} else {
-		kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
+		kvmppc_add_revmap_chain(&kvm->arch.hpt, rev, rmap, index, 0);
 	}
 
 	hptep[1] = cpu_to_be64(r);
@@ -1175,13 +1175,176 @@ static int resize_hpt_allocate(struct kvm_resize_hpt *resize)
 	return H_SUCCESS;
 }
 
+static unsigned long resize_hpt_rehash_hpte(struct kvm_resize_hpt *resize,
+					    unsigned long idx)
+{
+	struct kvm *kvm = resize->kvm;
+	struct kvm_hpt_info *old = &kvm->arch.hpt;
+	struct kvm_hpt_info *new = &resize->hpt;
+	unsigned long old_hash_mask = (1ULL << (old->order - 7)) - 1;
+	unsigned long new_hash_mask = (1ULL << (new->order - 7)) - 1;
+	__be64 *hptep, *new_hptep;
+	unsigned long vpte, rpte, guest_rpte;
+	int ret;
+	struct revmap_entry *rev;
+	unsigned long apsize, psize, avpn, pteg, hash;
+	unsigned long new_idx, new_pteg, replace_vpte;
+
+	hptep = (__be64 *)(old->virt + (idx << 4));
+	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
+		cpu_relax();
+
+	vpte = be64_to_cpu(hptep[0]);
+
+	ret = H_SUCCESS;
+	if (!(vpte & HPTE_V_VALID) && !(vpte & HPTE_V_ABSENT))
+		/* Nothing to do */
+		goto out;
+
+	/* Unmap */
+	rev = &old->rev[idx];
+	guest_rpte = rev->guest_rpte;
+
+	ret = H_HARDWARE;
+	apsize = hpte_page_size(vpte, guest_rpte);
+	if (!apsize)
+		goto out;
+
+	if (vpte & HPTE_V_VALID) {
+		unsigned long gfn = hpte_rpn(guest_rpte, apsize);
+		int srcu_idx = srcu_read_lock(&kvm->srcu);
+		struct kvm_memory_slot *memslot =
+			__gfn_to_memslot(kvm_memslots(kvm), gfn);
+
+		if (memslot) {
+			unsigned long *rmapp;
+			rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
+			
+			lock_rmap(rmapp);
+			kvmppc_unmap_hpte(kvm, idx, rmapp, gfn);
+			unlock_rmap(rmapp);
+		}
+
+		srcu_read_unlock(&kvm->srcu, srcu_idx);
+	}
+
+	/* Reload PTE after unmap */
+	vpte = be64_to_cpu(hptep[0]);
+
+	BUG_ON(vpte & HPTE_V_VALID);
+	BUG_ON(!(vpte & HPTE_V_ABSENT));
+
+	ret = H_SUCCESS;
+	if (!(vpte & HPTE_V_BOLTED))
+		goto out;
+
+	rpte = be64_to_cpu(hptep[1]);
+	psize = hpte_base_page_size(vpte, rpte);
+	avpn = HPTE_V_AVPN_VAL(vpte) & ~((psize - 1) >> 23);
+	pteg = idx / HPTES_PER_GROUP;
+	if (vpte & HPTE_V_SECONDARY)
+		pteg = ~pteg;
+
+	if (!(vpte & HPTE_V_1TB_SEG)) {
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
+	if (vpte & HPTE_V_SECONDARY) {
+		BUG_ON(~pteg != (hash & old_hash_mask));
+		new_pteg = ~new_pteg;
+	} else {
+		BUG_ON(pteg != (hash & old_hash_mask));
+	}
+
+	new_idx = new_pteg * HPTES_PER_GROUP + (idx % HPTES_PER_GROUP);
+	new_hptep = (__be64 *)(new->virt + (new_idx << 4));
+
+	replace_vpte = be64_to_cpu(new_hptep[0]);
+
+	if (replace_vpte & (HPTE_V_VALID | HPTE_V_ABSENT)) {
+		BUG_ON(new->order >= old->order);
+
+		ret = H_PTEG_FULL;
+		if (replace_vpte & HPTE_V_BOLTED) {
+			ret = H_PTEG_FULL;
+			if (vpte & HPTE_V_BOLTED)
+				/* Bolted collision, nothing we can do */
+				ret = H_PTEG_FULL;
+			/* Discard the new HPTE */
+			goto out;
+		}
+
+		/* Discard the previous HPTE */
+	}
+
+	new_hptep[1] = cpu_to_be64(rpte);
+	new->rev[new_idx].guest_rpte = guest_rpte;
+	/* No need for a barrier, since new HPT isn't active */
+	new_hptep[0] = cpu_to_be64(vpte);
+	unlock_hpte(new_hptep, vpte);
+
+out:
+	unlock_hpte(hptep, vpte);
+	return ret;
+}
+
 static int resize_hpt_rehash(struct kvm_resize_hpt *resize)
 {
-	return H_HARDWARE;
+	struct kvm *kvm = resize->kvm;
+	unsigned  long i;
+	int rc;
+
+	for (i = 0; i < kvmppc_hpt_npte(&kvm->arch.hpt); i++) {
+		rc = resize_hpt_rehash_hpte(resize, i);
+		if (rc != H_SUCCESS)
+			return rc;
+	}
+
+	return H_SUCCESS;
 }
 
 static void resize_hpt_pivot(struct kvm_resize_hpt *resize)
 {
+	struct kvm *kvm = resize->kvm;
+	struct kvm_hpt_info hpt_tmp;
+
+	/* Exchange the pending tables in the resize structure with
+	 * the active tables */
+
+	resize_hpt_debug(resize, "resize_hpt_pivot()\n");
+
+	spin_lock(&kvm->mmu_lock);
+	asm volatile("ptesync" : : : "memory");
+
+	hpt_tmp = kvm->arch.hpt;
+	kvmppc_set_hpt(kvm, &resize->hpt);
+	resize->hpt = hpt_tmp;
+
+	spin_unlock(&kvm->mmu_lock);
+
+	synchronize_srcu_expedited(&kvm->srcu);
+
+	resize_hpt_debug(resize, "resize_hpt_pivot() done\n");
 }
 
 static void resize_hpt_release(struct kvm *kvm, struct kvm_resize_hpt *resize)
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 3c9a5f3..5c0c3ca 100644
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
