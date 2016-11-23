Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNjvx0TgtzDw1r
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 11:32:13 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm-ppc@vger.kernel.org,
	kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v2 01/11] KVM: PPC: Book3S HV: Adapt to new HPTE format on
 POWER9
Date: Wed, 23 Nov 2016 11:31:55 +1100
Message-Id: <1479861125-21394-2-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
References: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adapts the KVM-HV hashed page table (HPT) code to read and write
HPT entries in the new format defined in Power ISA v3.00 on POWER9
machines.  The new format moves the B (segment size) field from the
first doubleword to the second, and trims some bits from the AVA
(abbreviated virtual address) and ARPN (abbreviated real page number)
fields.  As far as possible, the conversion is done when reading or
writing the HPT entries, and the rest of the code continues to use
the old format.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c |  39 ++++++++++----
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 101 +++++++++++++++++++++++++-----------
 2 files changed, 100 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 564ae8a..b795dd1 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -314,7 +314,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	struct kvmppc_slb *slbe;
 	unsigned long slb_v;
 	unsigned long pp, key;
-	unsigned long v, gr;
+	unsigned long v, orig_v, gr;
 	__be64 *hptep;
 	int index;
 	int virtmode = vcpu->arch.shregs.msr & (data ? MSR_DR : MSR_IR);
@@ -339,10 +339,12 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 		return -ENOENT;
 	}
 	hptep = (__be64 *)(kvm->arch.hpt_virt + (index << 4));
-	v = be64_to_cpu(hptep[0]) & ~HPTE_V_HVLOCK;
+	v = orig_v = be64_to_cpu(hptep[0]) & ~HPTE_V_HVLOCK;
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		v = hpte_new_to_old_v(v, be64_to_cpu(hptep[1]));
 	gr = kvm->arch.revmap[index].guest_rpte;
 
-	unlock_hpte(hptep, v);
+	unlock_hpte(hptep, orig_v);
 	preempt_enable();
 
 	gpte->eaddr = eaddr;
@@ -440,6 +442,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 {
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long hpte[3], r;
+	unsigned long hnow_v, hnow_r;
 	__be64 *hptep;
 	unsigned long mmu_seq, psize, pte_size;
 	unsigned long gpa_base, gfn_base;
@@ -488,6 +491,10 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	unlock_hpte(hptep, hpte[0]);
 	preempt_enable();
 
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		hpte[0] = hpte_new_to_old_v(hpte[0], hpte[1]);
+		hpte[1] = hpte_new_to_old_r(hpte[1]);
+	}
 	if (hpte[0] != vcpu->arch.pgfault_hpte[0] ||
 	    hpte[1] != vcpu->arch.pgfault_hpte[1])
 		return RESUME_GUEST;
@@ -599,9 +606,14 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	preempt_disable();
 	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
 		cpu_relax();
-	if ((be64_to_cpu(hptep[0]) & ~HPTE_V_HVLOCK) != hpte[0] ||
-		be64_to_cpu(hptep[1]) != hpte[1] ||
-		rev->guest_rpte != hpte[2])
+	hnow_v = be64_to_cpu(hptep[0]);
+	hnow_r = be64_to_cpu(hptep[1]);
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		hnow_v = hpte_new_to_old_v(hnow_v, hnow_r);
+		hnow_r = hpte_new_to_old_r(hnow_r);
+	}
+	if ((hnow_v & ~HPTE_V_HVLOCK) != hpte[0] || hnow_r != hpte[1] ||
+	    rev->guest_rpte != hpte[2])
 		/* HPTE has been changed under us; let the guest retry */
 		goto out_unlock;
 	hpte[0] = (hpte[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
@@ -632,6 +644,10 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
 	}
 
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		r = hpte_old_to_new_r(hpte[0], r);
+		hpte[0] = hpte_old_to_new_v(hpte[0]);
+	}
 	hptep[1] = cpu_to_be64(r);
 	eieio();
 	__unlock_hpte(hptep, hpte[0]);
@@ -1183,7 +1199,7 @@ static long record_hpte(unsigned long flags, __be64 *hptp,
 			unsigned long *hpte, struct revmap_entry *revp,
 			int want_valid, int first_pass)
 {
-	unsigned long v, r;
+	unsigned long v, r, hr;
 	unsigned long rcbits_unset;
 	int ok = 1;
 	int valid, dirty;
@@ -1210,6 +1226,11 @@ static long record_hpte(unsigned long flags, __be64 *hptp,
 		while (!try_lock_hpte(hptp, HPTE_V_HVLOCK))
 			cpu_relax();
 		v = be64_to_cpu(hptp[0]);
+		hr = be64_to_cpu(hptp[1]);
+		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+			v = hpte_new_to_old_v(v, hr);
+			hr = hpte_new_to_old_r(hr);
+		}
 
 		/* re-evaluate valid and dirty from synchronized HPTE value */
 		valid = !!(v & HPTE_V_VALID);
@@ -1217,8 +1238,8 @@ static long record_hpte(unsigned long flags, __be64 *hptp,
 
 		/* Harvest R and C into guest view if necessary */
 		rcbits_unset = ~revp->guest_rpte & (HPTE_R_R | HPTE_R_C);
-		if (valid && (rcbits_unset & be64_to_cpu(hptp[1]))) {
-			revp->guest_rpte |= (be64_to_cpu(hptp[1]) &
+		if (valid && (rcbits_unset & hr)) {
+			revp->guest_rpte |= (hr &
 				(HPTE_R_R | HPTE_R_C)) | HPTE_GR_MODIFIED;
 			dirty = 1;
 		}
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 0e7fca4..59d3458 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -365,6 +365,11 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		}
 	}
 
+	/* Convert to new format on P9 */
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		ptel = hpte_old_to_new_r(pteh, ptel);
+		pteh = hpte_old_to_new_v(pteh);
+	}
 	hpte[1] = cpu_to_be64(ptel);
 
 	/* Write the first HPTE dword, unlocking the HPTE and making it valid */
@@ -446,27 +451,31 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	__be64 *hpte;
 	unsigned long v, r, rb;
 	struct revmap_entry *rev;
-	u64 pte;
+	u64 pte, orig_pte, pte_r;
 
 	if (pte_index >= kvm->arch.hpt_npte)
 		return H_PARAMETER;
 	hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
-	pte = be64_to_cpu(hpte[0]);
+	pte = orig_pte = be64_to_cpu(hpte[0]);
+	pte_r = be64_to_cpu(hpte[1]);
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		pte = hpte_new_to_old_v(pte, pte_r);
+		pte_r = hpte_new_to_old_r(pte_r);
+	}
 	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn) ||
 	    ((flags & H_ANDCOND) && (pte & avpn) != 0)) {
-		__unlock_hpte(hpte, pte);
+		__unlock_hpte(hpte, orig_pte);
 		return H_NOT_FOUND;
 	}
 
 	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
 	v = pte & ~HPTE_V_HVLOCK;
-	pte = be64_to_cpu(hpte[1]);
 	if (v & HPTE_V_VALID) {
 		hpte[0] &= ~cpu_to_be64(HPTE_V_VALID);
-		rb = compute_tlbie_rb(v, be64_to_cpu(hpte[1]), pte_index);
+		rb = compute_tlbie_rb(v, pte_r, pte_index);
 		do_tlbies(kvm, &rb, 1, global_invalidates(kvm, flags), true);
 		/*
 		 * The reference (R) and change (C) bits in a HPT
@@ -484,7 +493,7 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	note_hpte_modification(kvm, rev);
 	unlock_hpte(hpte, 0);
 
-	if (is_mmio_hpte(v, pte))
+	if (is_mmio_hpte(v, pte_r))
 		atomic64_inc(&kvm->arch.mmio_update);
 
 	if (v & HPTE_V_ABSENT)
@@ -547,6 +556,10 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 			found = 0;
 			hp0 = be64_to_cpu(hp[0]);
 			hp1 = be64_to_cpu(hp[1]);
+			if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+				hp0 = hpte_new_to_old_v(hp0, hp1);
+				hp1 = hpte_new_to_old_r(hp1);
+			}
 			if (hp0 & (HPTE_V_ABSENT | HPTE_V_VALID)) {
 				switch (flags & 3) {
 				case 0:		/* absolute */
@@ -584,8 +597,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 
 			/* leave it locked */
 			hp[0] &= ~cpu_to_be64(HPTE_V_VALID);
-			tlbrb[n] = compute_tlbie_rb(be64_to_cpu(hp[0]),
-				be64_to_cpu(hp[1]), pte_index);
+			tlbrb[n] = compute_tlbie_rb(hp0, hp1, pte_index);
 			indexes[n] = j;
 			hptes[n] = hp;
 			revs[n] = rev;
@@ -623,7 +635,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	__be64 *hpte;
 	struct revmap_entry *rev;
 	unsigned long v, r, rb, mask, bits;
-	u64 pte;
+	u64 pte_v, pte_r;
 
 	if (pte_index >= kvm->arch.hpt_npte)
 		return H_PARAMETER;
@@ -631,15 +643,16 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 		cpu_relax();
-	pte = be64_to_cpu(hpte[0]);
-	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
-	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn)) {
-		__unlock_hpte(hpte, pte);
+	v = pte_v = be64_to_cpu(hpte[0]);
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		v = hpte_new_to_old_v(v, be64_to_cpu(hpte[1]));
+	if ((v & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
+	    ((flags & H_AVPN) && (v & ~0x7fUL) != avpn)) {
+		__unlock_hpte(hpte, pte_v);
 		return H_NOT_FOUND;
 	}
 
-	v = pte;
-	pte = be64_to_cpu(hpte[1]);
+	pte_r = be64_to_cpu(hpte[1]);
 	bits = (flags << 55) & HPTE_R_PP0;
 	bits |= (flags << 48) & HPTE_R_KEY_HI;
 	bits |= flags & (HPTE_R_PP | HPTE_R_N | HPTE_R_KEY_LO);
@@ -661,13 +674,13 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 		 * readonly to writable.  If it should be writable, we'll
 		 * take a trap and let the page fault code sort it out.
 		 */
-		r = (pte & ~mask) | bits;
-		if (hpte_is_writable(r) && !hpte_is_writable(pte))
+		r = (pte_r & ~mask) | bits;
+		if (hpte_is_writable(r) && !hpte_is_writable(pte_r))
 			r = hpte_make_readonly(r);
 		/* If the PTE is changing, invalidate it first */
-		if (r != pte) {
+		if (r != pte_r) {
 			rb = compute_tlbie_rb(v, r, pte_index);
-			hpte[0] = cpu_to_be64((v & ~HPTE_V_VALID) |
+			hpte[0] = cpu_to_be64((pte_v & ~HPTE_V_VALID) |
 					      HPTE_V_ABSENT);
 			do_tlbies(kvm, &rb, 1, global_invalidates(kvm, flags),
 				  true);
@@ -676,9 +689,9 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 			hpte[1] = cpu_to_be64(r);
 		}
 	}
-	unlock_hpte(hpte, v & ~HPTE_V_HVLOCK);
+	unlock_hpte(hpte, pte_v & ~HPTE_V_HVLOCK);
 	asm volatile("ptesync" : : : "memory");
-	if (is_mmio_hpte(v, pte))
+	if (is_mmio_hpte(v, pte_r))
 		atomic64_inc(&kvm->arch.mmio_update);
 
 	return H_SUCCESS;
@@ -704,6 +717,10 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 		hpte = (__be64 *)(kvm->arch.hpt_virt + (pte_index << 4));
 		v = be64_to_cpu(hpte[0]) & ~HPTE_V_HVLOCK;
 		r = be64_to_cpu(hpte[1]);
+		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+			v = hpte_new_to_old_v(v, r);
+			r = hpte_new_to_old_r(r);
+		}
 		if (v & HPTE_V_ABSENT) {
 			v &= ~HPTE_V_ABSENT;
 			v |= HPTE_V_VALID;
@@ -821,10 +838,16 @@ void kvmppc_invalidate_hpte(struct kvm *kvm, __be64 *hptep,
 			unsigned long pte_index)
 {
 	unsigned long rb;
+	u64 hp0, hp1;
 
 	hptep[0] &= ~cpu_to_be64(HPTE_V_VALID);
-	rb = compute_tlbie_rb(be64_to_cpu(hptep[0]), be64_to_cpu(hptep[1]),
-			      pte_index);
+	hp0 = be64_to_cpu(hptep[0]);
+	hp1 = be64_to_cpu(hptep[1]);
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		hp0 = hpte_new_to_old_v(hp0, hp1);
+		hp1 = hpte_new_to_old_r(hp1);
+	}
+	rb = compute_tlbie_rb(hp0, hp1, pte_index);
 	do_tlbies(kvm, &rb, 1, 1, true);
 }
 EXPORT_SYMBOL_GPL(kvmppc_invalidate_hpte);
@@ -834,9 +857,15 @@ void kvmppc_clear_ref_hpte(struct kvm *kvm, __be64 *hptep,
 {
 	unsigned long rb;
 	unsigned char rbyte;
+	u64 hp0, hp1;
 
-	rb = compute_tlbie_rb(be64_to_cpu(hptep[0]), be64_to_cpu(hptep[1]),
-			      pte_index);
+	hp0 = be64_to_cpu(hptep[0]);
+	hp1 = be64_to_cpu(hptep[1]);
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		hp0 = hpte_new_to_old_v(hp0, hp1);
+		hp1 = hpte_new_to_old_r(hp1);
+	}
+	rb = compute_tlbie_rb(hp0, hp1, pte_index);
 	rbyte = (be64_to_cpu(hptep[1]) & ~HPTE_R_R) >> 8;
 	/* modify only the second-last byte, which contains the ref bit */
 	*((char *)hptep + 14) = rbyte;
@@ -896,7 +925,7 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 	unsigned long avpn;
 	__be64 *hpte;
 	unsigned long mask, val;
-	unsigned long v, r;
+	unsigned long v, r, orig_v;
 
 	/* Get page shift, work out hash and AVPN etc. */
 	mask = SLB_VSID_B | HPTE_V_AVPN | HPTE_V_SECONDARY;
@@ -931,6 +960,8 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 		for (i = 0; i < 16; i += 2) {
 			/* Read the PTE racily */
 			v = be64_to_cpu(hpte[i]) & ~HPTE_V_HVLOCK;
+			if (cpu_has_feature(CPU_FTR_ARCH_300))
+				v = hpte_new_to_old_v(v, be64_to_cpu(hpte[i+1]));
 
 			/* Check valid/absent, hash, segment size and AVPN */
 			if (!(v & valid) || (v & mask) != val)
@@ -939,8 +970,12 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 			/* Lock the PTE and read it under the lock */
 			while (!try_lock_hpte(&hpte[i], HPTE_V_HVLOCK))
 				cpu_relax();
-			v = be64_to_cpu(hpte[i]) & ~HPTE_V_HVLOCK;
+			v = orig_v = be64_to_cpu(hpte[i]) & ~HPTE_V_HVLOCK;
 			r = be64_to_cpu(hpte[i+1]);
+			if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+				v = hpte_new_to_old_v(v, r);
+				r = hpte_new_to_old_r(r);
+			}
 
 			/*
 			 * Check the HPTE again, including base page size
@@ -950,7 +985,7 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 				/* Return with the HPTE still locked */
 				return (hash << 3) + (i >> 1);
 
-			__unlock_hpte(&hpte[i], v);
+			__unlock_hpte(&hpte[i], orig_v);
 		}
 
 		if (val & HPTE_V_SECONDARY)
@@ -978,7 +1013,7 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 {
 	struct kvm *kvm = vcpu->kvm;
 	long int index;
-	unsigned long v, r, gr;
+	unsigned long v, r, gr, orig_v;
 	__be64 *hpte;
 	unsigned long valid;
 	struct revmap_entry *rev;
@@ -1006,12 +1041,16 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 			return 0;	/* for prot fault, HPTE disappeared */
 		}
 		hpte = (__be64 *)(kvm->arch.hpt_virt + (index << 4));
-		v = be64_to_cpu(hpte[0]) & ~HPTE_V_HVLOCK;
+		v = orig_v = be64_to_cpu(hpte[0]) & ~HPTE_V_HVLOCK;
 		r = be64_to_cpu(hpte[1]);
+		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+			v = hpte_new_to_old_v(v, r);
+			r = hpte_new_to_old_r(r);
+		}
 		rev = real_vmalloc_addr(&kvm->arch.revmap[index]);
 		gr = rev->guest_rpte;
 
-		unlock_hpte(hpte, v);
+		unlock_hpte(hpte, orig_v);
 	}
 
 	/* For not found, if the HPTE is valid by now, retry the instruction */
-- 
2.7.4
