Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1498D1A0078
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:12 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 29 Jun 2014 21:18:11 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2244B2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:08 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5TAtjxo4063662
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 20:55:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5TBI7QX004900
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:07 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 6/6] KVM: PPC: BOOK3S: HV: Use virtual page class protection
 mechanism for host fault and mmio
Date: Sun, 29 Jun 2014 16:47:35 +0530
Message-Id: <1404040655-12076-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With this patch we use AMR class 30 and 31 for indicating a page
fault that should be handled by host. This includes the MMIO access and
the page fault resulting from guest RAM swapout in the host. This
enables us to forward the fault to guest without doing the expensive
hash page table search for finding the hpte entry. With this patch, we
mark hash pte always valid and use class index 30 and 31 for key based
fault. These virtual class index are configured in AMR to deny
read/write. Since access class protection mechanism doesn't work with
VRMA region, we need to handle them separately. We mark those HPTEs
invalid and use the software defined bit, HPTE_V_VRMA, to differentiate
them.

NOTE: We still need to handle protection fault in host so that a
write to KSM shared page is handled in the host.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 80 +++++++++++++++++++++++++++-----
 arch/powerpc/include/asm/reg.h           |  1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 48 ++++++++++++++-----
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      | 69 ++++++++++++++++++---------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  | 52 ++++++++++++++++-----
 5 files changed, 194 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index a6bf41865a66..4aa9c3601fe8 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -48,7 +48,18 @@ extern unsigned long kvm_rma_pages;
  * HPTEs.
  */
 #define HPTE_V_HVLOCK	0x40UL
-#define HPTE_V_ABSENT	0x20UL
+/*
+ * VRMA mapping
+ */
+#define HPTE_V_VRMA	0x20UL
+
+#define HPTE_R_HOST_UNMAP_KEY	0x3000000000000e00UL
+/*
+ * We use this to differentiate between an MMIO key fault and
+ * and a key fault resulting from host swapping out the page.
+ */
+#define HPTE_R_MMIO_UNMAP_KEY	0x3000000000000c00UL
+
 
 /*
  * We use this bit in the guest_rpte field of the revmap entry
@@ -405,35 +416,82 @@ static inline void __kvmppc_unmap_host_hpte(struct kvm *kvm,
 					    unsigned long *hpte_r,
 					    bool mmio)
 {
-	*hpte_v |= HPTE_V_ABSENT;
-	if (mmio)
-		*hpte_r |= HPTE_R_KEY_HI | HPTE_R_KEY_LO;
+	/*
+	 * We unmap on host by adding the page to AMR class 31
+	 * which have both read/write access denied.
+	 *
+	 * For VRMA area we mark them invalid.
+	 *
+	 * If we are not using mmu_notifiers we don't use Access
+	 * class protection.
+	 *
+	 * Since we are not changing the hpt directly we don't
+	 * Worry about update ordering.
+	 */
+	if ((*hpte_v & HPTE_V_VRMA) || !kvm->arch.using_mmu_notifiers)
+		*hpte_v &= ~HPTE_V_VALID;
+	else if (!mmio) {
+		*hpte_r |= HPTE_R_HOST_UNMAP_KEY;
+		*hpte_v |= HPTE_V_VALID;
+	} else {
+		*hpte_r |= HPTE_R_MMIO_UNMAP_KEY;
+		*hpte_v |= HPTE_V_VALID;
+	}
 }
 
 static inline void kvmppc_unmap_host_hpte(struct kvm *kvm, __be64 *hptep)
 {
+	unsigned long pte_v, pte_r;
+
+	pte_v = be64_to_cpu(hptep[0]);
+	pte_r = be64_to_cpu(hptep[1]);
 	/*
 	 * We will never call this for MMIO
 	 */
-	hptep[0] |= cpu_to_be64(HPTE_V_ABSENT);
+	__kvmppc_unmap_host_hpte(kvm, &pte_v, &pte_r, 0);
+	hptep[1] = cpu_to_be64(pte_r);
+	eieio();
+	hptep[0] = cpu_to_be64(pte_v);
+	asm volatile("ptesync" : : : "memory");
+	/*
+	 * we have now successfully marked the hpte using key bits
+	 */
 	atomic_dec(&kvm->arch.hpte_update_in_progress);
 }
 
 static inline void kvmppc_map_host_hpte(struct kvm *kvm, unsigned long *hpte_v,
 					unsigned long *hpte_r)
 {
-	*hpte_v |= HPTE_V_VALID;
-	*hpte_v &= ~HPTE_V_ABSENT;
+	/*
+	 * We will never try to map an MMIO region
+	 */
+	if ((*hpte_v & HPTE_V_VRMA) || !kvm->arch.using_mmu_notifiers)
+		*hpte_v |= HPTE_V_VALID;
+	else {
+		/*
+		 * When we allow guest keys we should set this with key
+		 * for this page.
+		 */
+		*hpte_r &= ~(HPTE_R_KEY_HI | HPTE_R_KEY_LO);
+	}
 }
 
 static inline bool kvmppc_is_host_mapped_hpte(struct kvm *kvm, __be64 *hpte)
 {
-	unsigned long v;
+	unsigned long v, r;
 
 	v = be64_to_cpu(hpte[0]);
-	if (v & HPTE_V_VALID)
-		return true;
-	return false;
+	if ((v & HPTE_V_VRMA) || !kvm->arch.using_mmu_notifiers)
+		return v & HPTE_V_VALID;
+
+	r = be64_to_cpu(hpte[1]);
+	if (!(v & HPTE_V_VALID))
+		return false;
+	if ((r & (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) == HPTE_R_HOST_UNMAP_KEY)
+		return false;
+	if ((r & (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) == HPTE_R_MMIO_UNMAP_KEY)
+		return false;
+	return true;
 }
 
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1f34ef7ec4a8..ca9a7aebc9ce 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -605,6 +605,7 @@
 #define   SRR1_ISI_NOPT		0x40000000 /* ISI: Not found in hash */
 #define   SRR1_ISI_N_OR_G	0x10000000 /* ISI: Access is no-exec or G */
 #define   SRR1_ISI_PROT		0x08000000 /* ISI: Other protection fault */
+#define   SRR1_ISI_KEYFAULT	0x00200000	/* Key fault */
 #define   SRR1_WAKEMASK		0x00380000 /* reason for wakeup */
 #define   SRR1_WAKESYSERR	0x00300000 /* System error */
 #define   SRR1_WAKEEE		0x00200000 /* External interrupt */
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index cb7a616aacb1..06f860d84d69 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -214,6 +214,11 @@ void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		hash = (hash << 3) + 7;
 		hp_v = hp0 | ((addr >> 16) & ~0x7fUL);
 		hp_r = hp1 | addr;
+		/*
+		 * VRMA mapping doesn't work with access class protection
+		 * mechanism, hence don't use keys for them
+		 */
+		hp_v |= HPTE_V_VRMA;
 		ret = kvmppc_virtmode_do_h_enter(kvm, H_EXACT, hash, hp_v, hp_r,
 						 &idx_ret);
 		if (ret != H_SUCCESS) {
@@ -409,7 +414,7 @@ long kvmppc_virtmode_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	/*
 	 * Clear few bits, when called via hcall
 	 */
-	pteh &= ~(HPTE_V_HVLOCK | HPTE_V_ABSENT | HPTE_V_VALID);
+	pteh &= ~(HPTE_V_HVLOCK | HPTE_V_VRMA | HPTE_V_VALID);
 	ptel &= ~(HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_GR_RESERVED);
 
 	return kvmppc_virtmode_do_h_enter(vcpu->kvm, flags, pte_index,
@@ -472,7 +477,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	preempt_disable();
 	/* Find the HPTE in the hash table */
 	index = kvmppc_hv_find_lock_hpte(kvm, eaddr, slb_v,
-					 HPTE_V_VALID | HPTE_V_ABSENT);
+					 HPTE_V_VALID | HPTE_V_VRMA);
 	if (index < 0) {
 		preempt_enable();
 		return -ENOENT;
@@ -733,7 +738,13 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		rev->guest_rpte != hpte[2])
 		/* HPTE has been changed under us; let the guest retry */
 		goto out_unlock;
-	hpte[0] = (hpte[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
+	/*
+	 * mark this hpte host mapped. We will use this value
+	 * to update actual hpte later. We don't need to clear
+	 * clear key bits, because we use rev->guest_rpte values
+	 * for the lower half.
+	 */
+	hpte[0] |= HPTE_V_VALID;
 
 	/* Always put the HPTE in the rmap chain for the page base address */
 	rmap = &memslot->arch.rmap[gfn_base - memslot->base_gfn];
@@ -906,8 +917,9 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 		psize = hpte_page_size(be64_to_cpu(hptep[0]), ptel);
 		if (kvmppc_is_host_mapped_hpte(kvm, hptep) &&
 		    hpte_rpn(ptel, psize) == gfn) {
-			if (kvm->arch.using_mmu_notifiers)
-				kvmppc_unmap_host_hpte(kvm, hptep);
+			/*
+			 * For hpte update always invalidate first
+			 */
 			kvmppc_invalidate_hpte(kvm, hptep, i);
 
 			/* Harvest R and C */
@@ -917,6 +929,11 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 				rev[i].guest_rpte = ptel | rcbits;
 				note_hpte_modification(kvm, &rev[i]);
 			}
+			/*
+			 * Mark the hpte umapped so that host can
+			 * handle the faults.
+			 */
+			kvmppc_unmap_host_hpte(kvm, hptep);
 		}
 		unlock_rmap(rmapp);
 		hptep[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
@@ -1345,7 +1362,7 @@ static long record_hpte(unsigned long flags, __be64 *hptp,
 		return 0;
 
 	valid = 0;
-	if (be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_ABSENT)) {
+	if (be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_VRMA)) {
 		valid = 1;
 		if ((flags & KVM_GET_HTAB_BOLTED_ONLY) &&
 		    !(be64_to_cpu(hptp[0]) & HPTE_V_BOLTED))
@@ -1362,7 +1379,11 @@ static long record_hpte(unsigned long flags, __be64 *hptp,
 			cpu_relax();
 		v = be64_to_cpu(hptp[0]);
 
-		/* re-evaluate valid and dirty from synchronized HPTE value */
+		/*
+		 * re-evaluate valid and dirty from synchronized HPTE value
+		 * We don't need to worry of host unmapped. We keep the valid
+		 * bit set even if we move the hpte to class 31.
+		 */
 		valid = !!(v & HPTE_V_VALID);
 		dirty = !!(revp->guest_rpte & HPTE_GR_MODIFIED);
 
@@ -1374,8 +1395,11 @@ static long record_hpte(unsigned long flags, __be64 *hptp,
 			dirty = 1;
 		}
 
-		if (v & HPTE_V_ABSENT) {
-			v &= ~HPTE_V_ABSENT;
+		if (v & HPTE_V_VRMA) {
+			/*
+			 * unmapped vrma consider them mapped and also
+			 * retain the HPTE_V_VRMA bit.
+			 */
 			v |= HPTE_V_VALID;
 			valid = 1;
 		}
@@ -1559,14 +1583,14 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 			lbuf += 2;
 			nb += HPTE_SIZE;
 
-			if (be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_ABSENT))
+			if (be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_VRMA))
 				kvmppc_do_h_remove(kvm, 0, i, 0, tmp);
 			err = -EIO;
 			/*
 			 * Clear few bits we got via read_htab which we
 			 * don't need to carry forward.
 			 */
-			v &= ~(HPTE_V_HVLOCK | HPTE_V_ABSENT | HPTE_V_VALID);
+			v &= ~(HPTE_V_HVLOCK | HPTE_V_VALID);
 			r &= ~(HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_GR_RESERVED);
 
 			ret = kvmppc_virtmode_do_h_enter(kvm, H_EXACT, i, v, r,
@@ -1592,7 +1616,7 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 		}
 
 		for (j = 0; j < hdr.n_invalid; ++j) {
-			if (be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_ABSENT))
+			if (be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_VRMA))
 				kvmppc_do_h_remove(kvm, 0, i, 0, tmp);
 			++i;
 			hptp += 2;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index d628d2810c93..f907be908b28 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -252,7 +252,13 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 	ptel &= ~(HPTE_R_PP0 - psize);
 	ptel |= pa;
-
+	/*
+	 * We mark the pte valid, if it is valid from guest point of view
+	 * For VRMA area we need to mark it still invalid, because access
+	 * class protection mechanism doesn't work with guest real mode
+	 * access.
+	 * Non vrma area is always valid, and vram is valid only if pa is set.
+	 */
 	if (pa)
 		pteh |= HPTE_V_VALID;
 
@@ -278,7 +284,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		for (i = 0; i < 8; ++i) {
 			if ((be64_to_cpu(*hpte) & HPTE_V_VALID) == 0 &&
 			    try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID |
-					  HPTE_V_ABSENT))
+					  HPTE_V_VRMA))
 				break;
 			hpte += 2;
 		}
@@ -295,7 +301,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 				while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 					cpu_relax();
 				pte = be64_to_cpu(*hpte);
-				if (!(pte & (HPTE_V_VALID | HPTE_V_ABSENT)))
+				if (!(pte & (HPTE_V_VALID | HPTE_V_VRMA)))
 					break;
 				*hpte &= ~cpu_to_be64(HPTE_V_HVLOCK);
 				hpte += 2;
@@ -307,14 +313,14 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	} else {
 		hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
 		if (!try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID |
-				   HPTE_V_ABSENT)) {
+				   HPTE_V_VRMA)) {
 			/* Lock the slot and check again */
 			u64 pte;
 
 			while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 				cpu_relax();
 			pte = be64_to_cpu(*hpte);
-			if (pte & (HPTE_V_VALID | HPTE_V_ABSENT)) {
+			if (pte & (HPTE_V_VALID | HPTE_V_VRMA)) {
 				*hpte &= ~cpu_to_be64(HPTE_V_HVLOCK);
 				return H_PTEG_FULL;
 			}
@@ -372,7 +378,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	/*
 	 * Clear few bits. when called via hcall.
 	 */
-	pteh &= ~(HPTE_V_HVLOCK | HPTE_V_ABSENT | HPTE_V_VALID);
+	pteh &= ~(HPTE_V_HVLOCK | HPTE_V_VRMA | HPTE_V_VALID);
 	ptel &= ~(HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_GR_RESERVED);
 
 	return kvmppc_do_h_enter(vcpu->kvm, flags, pte_index, pteh, ptel,
@@ -492,7 +498,7 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
 	pte = be64_to_cpu(hpte[0]);
-	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
+	if ((pte & (HPTE_V_VRMA | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn) ||
 	    ((flags & H_ANDCOND) && (pte & avpn) != 0)) {
 		hpte[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
@@ -503,9 +509,12 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	v = pte & ~HPTE_V_HVLOCK;
 	if (v & HPTE_V_VALID) {
 		u64 pte1;
-
 		pte1 = be64_to_cpu(hpte[1]);
-		hpte[0] &= ~cpu_to_be64(HPTE_V_VALID);
+		/*
+		 * Remove the valid and VRMA bits
+		 */
+		hpte[0] &= ~cpu_to_be64(HPTE_V_VALID | HPTE_V_VRMA);
+
 		rb = compute_tlbie_rb(v, pte1, pte_index);
 		do_tlbies(kvm, &rb, 1, global_invalidates(kvm, flags), true);
 		/* Read PTE low word after tlbie to get final R/C values */
@@ -572,7 +581,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 			}
 			found = 0;
 			hp0 = be64_to_cpu(hp[0]);
-			if (hp0 & (HPTE_V_ABSENT | HPTE_V_VALID)) {
+			if (hp0 & (HPTE_V_VRMA | HPTE_V_VALID)) {
 				switch (flags & 3) {
 				case 0:		/* absolute */
 					found = 1;
@@ -606,7 +615,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 			}
 
 			/* leave it locked */
-			hp[0] &= ~cpu_to_be64(HPTE_V_VALID);
+			hp[0] &= ~cpu_to_be64(HPTE_V_VALID | HPTE_V_VRMA);
 			tlbrb[n] = compute_tlbie_rb(be64_to_cpu(hp[0]),
 				be64_to_cpu(hp[1]), pte_index);
 			indexes[n] = j;
@@ -656,7 +665,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
 	pte = be64_to_cpu(hpte[0]);
-	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
+	if ((pte & (HPTE_V_VRMA | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn)) {
 		hpte[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
 		return H_NOT_FOUND;
@@ -758,10 +767,17 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 		hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
 		v = be64_to_cpu(hpte[0]) & ~HPTE_V_HVLOCK;
 		r = be64_to_cpu(hpte[1]);
-		if (v & HPTE_V_ABSENT) {
-			v &= ~HPTE_V_ABSENT;
+		if (v & HPTE_V_VRMA) {
+			/*
+			 * don't share vrma bits back to guest
+			 */
+			v &= ~HPTE_V_VRMA;
 			v |= HPTE_V_VALID;
 		}
+		/*
+		 * Clear the AMR class bits
+		 */
+		r &= ~(HPTE_R_KEY_HI | HPTE_R_KEY_LO);
 		if (v & HPTE_V_VALID) {
 			r = rev[i].guest_rpte | (r & (HPTE_R_R | HPTE_R_C));
 			r &= ~HPTE_GR_RESERVED;
@@ -871,8 +887,13 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 			/* Read the PTE racily */
 			v = be64_to_cpu(hpte[i]) & ~HPTE_V_HVLOCK;
 
-			/* Check valid/absent, hash, segment size and AVPN */
-			if (!(v & valid) || (v & mask) != val)
+			/*
+			 * Check hash, segment size and AVPN.
+			 * We can't check for valid here without lock. We do
+			 * mark the hpte not valid while an hpte update is
+			 * in progress.
+			 */
+			if ((v & mask) != val)
 				continue;
 
 			/* Lock the PTE and read it under the lock */
@@ -927,7 +948,7 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 	/* For protection fault, expect to find a valid HPTE */
 	valid = HPTE_V_VALID;
 	if (status & DSISR_NOHPTE)
-		valid |= HPTE_V_ABSENT;
+		valid |= HPTE_V_VRMA;
 
 	index = kvmppc_hv_find_lock_hpte(kvm, addr, slb_v, valid);
 	if (index < 0) {
@@ -942,10 +963,17 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 	gr = rev->guest_rpte;
 
 	unlock_hpte(hpte, v);
-
-	/* For not found, if the HPTE is valid by now, retry the instruction */
+	/*
+	 * For not found, if the HPTE is valid by now, retry the instruction
+	 */
 	if ((status & DSISR_NOHPTE) && (v & HPTE_V_VALID))
 		return 0;
+	/*
+	 * For key fault if HPTE is host mapped by now retry the instruction
+	 */
+	if ((status & DSISR_KEYFAULT) &&
+	    kvmppc_is_host_mapped_hpte(kvm, hpte))
+		return 0;
 
 	/* Check access permissions to the page */
 	pp = gr & (HPTE_R_PP0 | HPTE_R_PP);
@@ -973,8 +1001,7 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 
 	/* Check the storage key to see if it is possibly emulated MMIO */
 	if (data && (vcpu->arch.shregs.msr & MSR_IR) &&
-	    (r & (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) ==
-	    (HPTE_R_KEY_HI | HPTE_R_KEY_LO))
+	    ((r & HPTE_R_MMIO_UNMAP_KEY) == HPTE_R_MMIO_UNMAP_KEY))
 		return -2;	/* MMIO emulation - load instr word */
 
 	return -1;		/* send fault up to host kernel mode */
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 0b425da9f8db..f1af0d24e2b5 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -834,7 +834,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	mtmsrd	r8
 
 	/* Load up POWER8-specific registers */
+	/*
+	 * Always disable read/write w.r.t to class index 31
+	 */
 	ld	r5, VCPU_IAMR(r4)
+	ori	r5, r5, 0x3
 	lwz	r6, VCPU_PSPB(r4)
 	ld	r7, VCPU_FSCR(r4)
 	mtspr	SPRN_IAMR, r5
@@ -901,10 +905,25 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	mtspr	SPRN_DSISR, r6
 
 BEGIN_FTR_SECTION
-	/* Restore AMR and UAMOR, set AMOR to all 1s */
-	ld	r5,VCPU_AMR(r4)
+	/* Restore AMR and UAMOR */
+	/*
+	 * Always disable read/write wr.t. to class index
+	 * 30 and 31
+	 */
+	ld	r5, VCPU_AMR(r4)
+	ori	r5, r5, 0xf
+	/*
+	 * UAMOR set so that mask bits for class index 30
+	 * and 31 cannot be updated
+	 */
+
 	ld	r6,VCPU_UAMOR(r4)
-	li	r7,-1
+	rldicr  r6, r6, 0, 59
+	/*
+	 * AMOR set so that mask bits for class index 30
+	 * and 31 cannot be updated
+	 */
+	li	r7, ~0xf
 	mtspr	SPRN_AMR,r5
 	mtspr	SPRN_UAMOR,r6
 	mtspr	SPRN_AMOR,r7
@@ -1801,13 +1820,22 @@ kvmppc_hdsi:
 	 */
 	cmpwi	r0, 0
 	bne	5f
-
-	andi.	r0, r11, MSR_DR		/* data relocation enabled? */
+	/*
+	 * If data relocation is disabled, virtual page class
+	 * key protection mechanis does not apply.
+	 */
+	andi.	r0, r11, MSR_DR
 	beq	3f
-
-	/* HPTE not found fault or protection fault? */
-	andis.	r0, r6, (DSISR_NOHPTE | DSISR_PROTFAULT)@h
-	beq	1f			/* if not, send it to the guest */
+	/*
+	 * If access is not permitted by virtual page class
+	 * key protection, handle it in the host. If not
+	 * send it to the guest.
+	 */
+	andis.	r0, r6, (DSISR_KEYFAULT | DSISR_PROTFAULT)@h
+	beq	1f
+	/*
+	 * skip the real mode check below
+	 */
 	b	8f
 5:
 	/*
@@ -1857,7 +1885,8 @@ fast_interrupt_c_return:
 
 3:	/*
 	 * Check whether we can send the fault directly to
-	 * guest.
+	 * guest. We don't need to worry about keyfault if
+	 * the fault happens in real mode.
 	 */
 	andis.	r0, r6, (DSISR_NOHPTE | DSISR_PROTFAULT)@h
 	beq	1b
@@ -1907,8 +1936,7 @@ kvmppc_hisi:
 
 	andi.	r0, r11, MSR_IR		/* instruction relocation enabled? */
 	beq	3f
-
-	andis.	r0, r11, SRR1_ISI_NOPT@h
+	andis.	r0, r11, SRR1_ISI_KEYFAULT@h
 	beq	1f
 	b	8f
 5:
-- 
1.9.1
