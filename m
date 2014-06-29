Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9F421A0010
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:08 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 29 Jun 2014 21:18:08 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1AD5B2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:06 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5TB1cUY43843770
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:01:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5TBI5qF004850
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:05 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 5/6] KVM: PPC: BOOK3S: Use hpte_update_in_progress to track
 invalid hpte during an hpte update
Date: Sun, 29 Jun 2014 16:47:34 +0530
Message-Id: <1404040655-12076-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

As per ISA, we first need to mark hpte invalid (V=0) before we update
the hpte lower half bits. With virtual page class key protection mechanism we want
to send any fault other than key fault to guest directly without
searching the hash page table. But then we can get NO_HPTE fault while
we are updating the hpte. To track that add a vm specific atomic
variable that we check in the fault path to always send the fault
to host.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |  1 +
 arch/powerpc/include/asm/kvm_host.h      |  1 +
 arch/powerpc/kernel/asm-offsets.c        |  1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 19 ++++++----
 arch/powerpc/kvm/book3s_hv.c             |  1 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      | 40 +++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  | 60 +++++++++++++++++++++++++++++---
 7 files changed, 109 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index da00b1f05ea1..a6bf41865a66 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -416,6 +416,7 @@ static inline void kvmppc_unmap_host_hpte(struct kvm *kvm, __be64 *hptep)
 	 * We will never call this for MMIO
 	 */
 	hptep[0] |= cpu_to_be64(HPTE_V_ABSENT);
+	atomic_dec(&kvm->arch.hpte_update_in_progress);
 }
 
 static inline void kvmppc_map_host_hpte(struct kvm *kvm, unsigned long *hpte_v,
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index f9ae69682ce1..0a9ff60fae4c 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -254,6 +254,7 @@ struct kvm_arch {
 	atomic_t hpte_mod_interest;
 	spinlock_t slot_phys_lock;
 	cpumask_t need_tlb_flush;
+	atomic_t hpte_update_in_progress;
 	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
 	int hpt_cma_alloc;
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index f5995a912213..54a36110f8f2 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -496,6 +496,7 @@ int main(void)
 	DEFINE(KVM_LPCR, offsetof(struct kvm, arch.lpcr));
 	DEFINE(KVM_RMOR, offsetof(struct kvm, arch.rmor));
 	DEFINE(KVM_VRMA_SLB_V, offsetof(struct kvm, arch.vrma_slb_v));
+	DEFINE(KVM_HPTE_UPDATE, offsetof(struct kvm, arch.hpte_update_in_progress));
 	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
 	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
 	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa.pinned_addr));
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 8ce5e95613f8..cb7a616aacb1 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -592,6 +592,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	unsigned int writing, write_ok;
 	struct vm_area_struct *vma;
 	unsigned long rcbits;
+	bool hpte_invalidated = false;
 
 	/*
 	 * Real-mode code has already searched the HPT and found the
@@ -750,13 +751,15 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	r &= rcbits | ~(HPTE_R_R | HPTE_R_C);
 
 	if (be64_to_cpu(hptep[0]) & HPTE_V_VALID) {
-		/* HPTE was previously valid, so we need to invalidate it */
+		/*
+		 * If we had mapped this hpte before, we now need to
+		 * invalidate that.
+		 */
 		unlock_rmap(rmap);
-		/* Always mark HPTE_V_ABSENT before invalidating */
-		kvmppc_unmap_host_hpte(kvm, hptep);
 		kvmppc_invalidate_hpte(kvm, hptep, index);
 		/* don't lose previous R and C bits */
 		r |= be64_to_cpu(hptep[1]) & (HPTE_R_R | HPTE_R_C);
+		hpte_invalidated = true;
 	} else {
 		kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
 	}
@@ -765,6 +768,9 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	eieio();
 	hptep[0] = cpu_to_be64(hpte[0]);
 	asm volatile("ptesync" : : : "memory");
+	if (hpte_invalidated)
+		atomic_dec(&kvm->arch.hpte_update_in_progress);
+
 	preempt_enable();
 	if (page && hpte_is_writable(r))
 		SetPageDirty(page);
@@ -1128,10 +1134,9 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 		/*
 		 * need to make it temporarily absent so C is stable
 		 */
-		kvmppc_unmap_host_hpte(kvm, hptep);
-		kvmppc_invalidate_hpte(kvm, hptep, i);
 		v = be64_to_cpu(hptep[0]);
 		r = be64_to_cpu(hptep[1]);
+		kvmppc_invalidate_hpte(kvm, hptep, i);
 		if (r & HPTE_R_C) {
 			hptep[1] = cpu_to_be64(r & ~HPTE_R_C);
 			if (!(rev[i].guest_rpte & HPTE_R_C)) {
@@ -1144,8 +1149,8 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 				npages_dirty = n;
 			eieio();
 		}
-		kvmppc_map_host_hpte(kvm, &v, &r);
-		hptep[0] = cpu_to_be64(v & ~HPTE_V_HVLOCK);
+		hptep[0] = cpu_to_be64(v & ~HPTE_V_LOCK);
+		atomic_dec(&kvm->arch.hpte_update_in_progress);
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 47d3f20ad10f..328416f28a55 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2291,6 +2291,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 
 	kvm->arch.using_mmu_notifiers = !!cpu_has_feature(CPU_FTR_ARCH_206);
 	spin_lock_init(&kvm->arch.slot_phys_lock);
+	atomic_set(&kvm->arch.hpte_update_in_progress, 0);
 
 	/*
 	 * Track that we now have a HV mode VM active. This blocks secondary
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index e8458c0d1336..d628d2810c93 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -647,6 +647,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	struct revmap_entry *rev;
 	unsigned long v, r, rb, mask, bits;
 	u64 pte;
+	bool hpte_invalidated = false;
 
 	if (pte_index >= kvm->arch.hpt_npte)
 		return H_PARAMETER;
@@ -683,8 +684,26 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 
 	/* Update HPTE */
 	if (kvmppc_is_host_mapped_hpte(kvm, hpte)) {
-		rb = compute_tlbie_rb(v, r, pte_index);
+		/*
+		 * We use this in the fault path to check whether a
+		 * NO_HPTE fault should be send to guest. In this
+		 * case we don't want to send it to guest.
+		 */
+		atomic_inc(&kvm->arch.hpte_update_in_progress);
+		/*
+		 * We want to ensure that other cpus see the hpte_update_in_progress
+		 * change before taking a page fault due to us clearing the valid
+		 * bit below
+		 */
+		smp_wmb();
+		hpte_invalidated = true;
+		/*
+		 * We need to mark V = 0 before doing a tlb invalidate.
+		 * Refer Page table entry modifying section in ISA
+		 */
 		hpte[0] = cpu_to_be64(v & ~HPTE_V_VALID);
+
+		rb = compute_tlbie_rb(v, r, pte_index);
 		do_tlbies(kvm, &rb, 1, global_invalidates(kvm, flags), true);
 		/*
 		 * If the host has this page as readonly but the guest
@@ -714,6 +733,8 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	eieio();
 	hpte[0] = cpu_to_be64(v & ~HPTE_V_HVLOCK);
 	asm volatile("ptesync" : : : "memory");
+	if (hpte_invalidated)
+		atomic_dec(&kvm->arch.hpte_update_in_progress);
 	return H_SUCCESS;
 }
 
@@ -755,7 +776,22 @@ void kvmppc_invalidate_hpte(struct kvm *kvm, __be64 *hptep,
 			unsigned long pte_index)
 {
 	unsigned long rb;
-
+	/*
+	 * We use this in the fault path to check whether a
+	 * NO_HPTE fault should be send to guest. In this
+	 * case we don't want to send it to guest.
+	 */
+	atomic_inc(&kvm->arch.hpte_update_in_progress);
+	/*
+	 * We want to ensure that other cpus see the hpte_update_in_progress
+	 * change before taking a page fault due to us clearing the valid
+	 * bit below
+	 */
+	smp_wmb();
+	/*
+	 * We need to mark V = 0 before doing a tlb invalidate.
+	 * Refer Page table entry modifying section in ISA
+	 */
 	hptep[0] &= ~cpu_to_be64(HPTE_V_VALID);
 	rb = compute_tlbie_rb(be64_to_cpu(hptep[0]), be64_to_cpu(hptep[1]),
 			      pte_index);
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 1ff3ebdd2ab0..0b425da9f8db 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1790,11 +1790,33 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 kvmppc_hdsi:
 	mfspr	r4, SPRN_HDAR
 	mfspr	r6, SPRN_HDSISR
+	/*
+	 * first check whether we have an hpte update in progress.
+	 * If so, we go to host directly
+	 */
+	ld	r0, VCPU_KVM(r9)
+	lwz	r0, KVM_HPTE_UPDATE(r0)
+	/*
+	 * If update is in progress go to host directly
+	 */
+	cmpwi	r0, 0
+	bne	5f
+
+	andi.	r0, r11, MSR_DR		/* data relocation enabled? */
+	beq	3f
+
 	/* HPTE not found fault or protection fault? */
 	andis.	r0, r6, (DSISR_NOHPTE | DSISR_PROTFAULT)@h
 	beq	1f			/* if not, send it to the guest */
-	andi.	r0, r11, MSR_DR		/* data relocation enabled? */
-	beq	3f
+	b	8f
+5:
+	/*
+	 * real mode access to be sent to host. because
+	 * of an hpte update in progress
+	 */
+	andi.	r0, r11, MSR_DR
+	beq	7f
+8:
 	clrrdi	r0, r4, 28
 	PPC_SLBFEE_DOT(R5, R0)		/* if so, look up SLB */
 	bne	1f			/* if no SLB entry found */
@@ -1833,7 +1855,14 @@ fast_interrupt_c_return:
 	mr	r4, r9
 	b	fast_guest_return
 
-3:	ld	r5, VCPU_KVM(r9)	/* not relocated, use VRMA */
+3:	/*
+	 * Check whether we can send the fault directly to
+	 * guest.
+	 */
+	andis.	r0, r6, (DSISR_NOHPTE | DSISR_PROTFAULT)@h
+	beq	1b
+7:
+	ld	r5, VCPU_KVM(r9)	/* not relocated, use VRMA */
 	ld	r5, KVM_VRMA_SLB_V(r5)
 	b	4b
 
@@ -1865,10 +1894,27 @@ fast_interrupt_c_return:
  * it is an HPTE not found fault for a page that we have paged out.
  */
 kvmppc_hisi:
+	/* first check whether we have an hpte update in progress.
+	 * If so, we go to host directly
+	 */
+	ld	r0, VCPU_KVM(r9)	/* not relocated, use VRMA */
+	lwz	r0, KVM_HPTE_UPDATE(r0)
+	/*
+	 * If update is in progress go to host directly
+	 */
+	cmpwi	r0, 0
+	bne	5f
+
+	andi.	r0, r11, MSR_IR		/* instruction relocation enabled? */
+	beq	3f
+
 	andis.	r0, r11, SRR1_ISI_NOPT@h
 	beq	1f
+	b	8f
+5:
 	andi.	r0, r11, MSR_IR		/* instruction relocation enabled? */
-	beq	3f
+	beq	7f
+8:
 	clrrdi	r0, r10, 28
 	PPC_SLBFEE_DOT(R5, R0)		/* if so, look up SLB */
 	bne	1f			/* if no SLB entry found */
@@ -1896,7 +1942,11 @@ kvmppc_hisi:
 	bl	kvmppc_msr_interrupt
 	b	fast_interrupt_c_return
 
-3:	ld	r6, VCPU_KVM(r9)	/* not relocated, use VRMA */
+3:	/* Check whether we should send this to guest */
+	andis.	r0, r11, SRR1_ISI_NOPT@h
+	beq	1b
+7:
+	ld	r6, VCPU_KVM(r9)	/* not relocated, use VRMA */
 	ld	r5, KVM_VRMA_SLB_V(r6)
 	b	4b
 
-- 
1.9.1
