Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfN6Z56bmzDvjw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 16:58:46 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 thuth@redhat.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 10/11] powerpc/kvm: KVM-HV HPT resizing implementation
Date: Thu, 15 Dec 2016 16:54:03 +1100
Message-Id: <20161215055404.29351-11-david@gibson.dropbear.id.au>
In-Reply-To: <20161215055404.29351-1-david@gibson.dropbear.id.au>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds the "guts" of the implementation for the HPT resizing PAPR
extension.  It has the code to allocate and clear a new HPT, rehash an
existing HPT's entries into it, and accomplish the switchover for a
KVM guest from the old HPT to the new one.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 188 +++++++++++++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index a2ac749..2a86c07 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -66,6 +66,10 @@ struct kvm_resize_hpt {
 	/* These fields protected by kvm->lock */
 	int error;
 	bool prepare_done;
+
+	/* Private to the work thread, until prepare_done is true,
+	 * then protected by kvm->resize_hpt_sem */
+	struct kvm_hpt_info hpt;
 };
 
 static void kvmppc_rmap_reset(struct kvm *kvm);
@@ -1189,21 +1193,203 @@ void kvmppc_unpin_guest_page(struct kvm *kvm, void *va, unsigned long gpa,
  */
 static int resize_hpt_allocate(struct kvm_resize_hpt *resize)
 {
+	int rc;
+
+	rc = kvmppc_allocate_hpt(&resize->hpt, resize->order);
+	if (rc < 0)
+		return rc;
+
+	resize_hpt_debug(resize, "resize_hpt_allocate(): HPT @ 0x%lx\n",
+			 resize->hpt.virt);
+
 	return 0;
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
+
+	/* Guest is stopped, so new HPTEs can't be added or faulted
+	 * in, only unmapped or altered by host actions.  So, it's
+	 * safe to check this before we take the HPTE lock */
+	vpte = be64_to_cpu(hptep[0]);
+	if (!(vpte & HPTE_V_VALID) && !(vpte & HPTE_V_ABSENT))
+		return 0; /* nothing to do */
+
+	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
+		cpu_relax();
+
+	vpte = be64_to_cpu(hptep[0]);
+
+	ret = 0;
+	if (!(vpte & HPTE_V_VALID) && !(vpte & HPTE_V_ABSENT))
+		/* Nothing to do */
+		goto out;
+
+	/* Unmap */
+	rev = &old->rev[idx];
+	guest_rpte = rev->guest_rpte;
+
+	ret = -EIO;
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
+	ret = 0;
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
+		if (replace_vpte & HPTE_V_BOLTED) {
+			if (vpte & HPTE_V_BOLTED)
+				/* Bolted collision, nothing we can do */
+				ret = -ENOSPC;
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
-	return -EIO;
+	struct kvm *kvm = resize->kvm;
+	unsigned  long i;
+	int rc;
+
+	for (i = 0; i < kvmppc_hpt_npte(&kvm->arch.hpt); i++) {
+		rc = resize_hpt_rehash_hpte(resize, i);
+		if (rc != 0)
+			return rc;
+	}
+
+	return 0;
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
 {
 	BUG_ON(kvm->arch.resize_hpt != resize);
+
+	if (resize->hpt.virt)
+		kvmppc_free_hpt(&resize->hpt);
+
 	kvm->arch.resize_hpt = NULL;
 	kfree(resize);
 }
-- 
2.9.3
