Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426E31A014F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:08 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 29 Jun 2014 21:18:06 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 55E4A3578048
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:04 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5TB1bQc40697904
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:01:37 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5TBI3ao004786
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:03 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 4/6] KVM: PPC: BOOK3S: HV: Use new functions for
 mapping/unmapping hpte in host
Date: Sun, 29 Jun 2014 16:47:33 +0530
Message-Id: <1404040655-12076-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We want to use virtual page class key protection mechanism for
indicating a MMIO mapped hpte entry or a guest hpte entry that is swapped out
in the host. Those hptes will be marked valid, but have virtual page
class key set to 30 or 31. These virtual page class numbers are
configured in AMR to deny read/write. To accomodate such a change, add
new functions that map, unmap and check whether a hpte is mapped in the
host. This patch still use HPTE_V_VALID and HPTE_V_ABSENT and don't use
virtual page class keys. But we want to differentiate in the code
where we explicitly check for HPTE_V_VALID with places where we want to
check whether the hpte is host mapped. This patch enables a closer
review for such a change.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 36 ++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 24 +++++++++++----------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      | 30 ++++++++++++++------------
 3 files changed, 66 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 0aa817933e6a..da00b1f05ea1 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -400,6 +400,42 @@ static inline int is_vrma_hpte(unsigned long hpte_v)
 		(HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)));
 }
 
+static inline void __kvmppc_unmap_host_hpte(struct kvm *kvm,
+					    unsigned long *hpte_v,
+					    unsigned long *hpte_r,
+					    bool mmio)
+{
+	*hpte_v |= HPTE_V_ABSENT;
+	if (mmio)
+		*hpte_r |= HPTE_R_KEY_HI | HPTE_R_KEY_LO;
+}
+
+static inline void kvmppc_unmap_host_hpte(struct kvm *kvm, __be64 *hptep)
+{
+	/*
+	 * We will never call this for MMIO
+	 */
+	hptep[0] |= cpu_to_be64(HPTE_V_ABSENT);
+}
+
+static inline void kvmppc_map_host_hpte(struct kvm *kvm, unsigned long *hpte_v,
+					unsigned long *hpte_r)
+{
+	*hpte_v |= HPTE_V_VALID;
+	*hpte_v &= ~HPTE_V_ABSENT;
+}
+
+static inline bool kvmppc_is_host_mapped_hpte(struct kvm *kvm, __be64 *hpte)
+{
+	unsigned long v;
+
+	v = be64_to_cpu(hpte[0]);
+	if (v & HPTE_V_VALID)
+		return true;
+	return false;
+}
+
+
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 /*
  * Note modification of an HPTE; set the HPTE modified bit
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 590e07b1a43f..8ce5e95613f8 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -752,7 +752,8 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	if (be64_to_cpu(hptep[0]) & HPTE_V_VALID) {
 		/* HPTE was previously valid, so we need to invalidate it */
 		unlock_rmap(rmap);
-		hptep[0] |= cpu_to_be64(HPTE_V_ABSENT);
+		/* Always mark HPTE_V_ABSENT before invalidating */
+		kvmppc_unmap_host_hpte(kvm, hptep);
 		kvmppc_invalidate_hpte(kvm, hptep, index);
 		/* don't lose previous R and C bits */
 		r |= be64_to_cpu(hptep[1]) & (HPTE_R_R | HPTE_R_C);
@@ -897,11 +898,12 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 		/* Now check and modify the HPTE */
 		ptel = rev[i].guest_rpte;
 		psize = hpte_page_size(be64_to_cpu(hptep[0]), ptel);
-		if ((be64_to_cpu(hptep[0]) & HPTE_V_VALID) &&
+		if (kvmppc_is_host_mapped_hpte(kvm, hptep) &&
 		    hpte_rpn(ptel, psize) == gfn) {
 			if (kvm->arch.using_mmu_notifiers)
-				hptep[0] |= cpu_to_be64(HPTE_V_ABSENT);
+				kvmppc_unmap_host_hpte(kvm, hptep);
 			kvmppc_invalidate_hpte(kvm, hptep, i);
+
 			/* Harvest R and C */
 			rcbits = be64_to_cpu(hptep[1]) & (HPTE_R_R | HPTE_R_C);
 			*rmapp |= rcbits << KVMPPC_RMAP_RC_SHIFT;
@@ -990,7 +992,7 @@ static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 		}
 
 		/* Now check and modify the HPTE */
-		if ((be64_to_cpu(hptep[0]) & HPTE_V_VALID) &&
+		if (kvmppc_is_host_mapped_hpte(kvm, hptep) &&
 		    (be64_to_cpu(hptep[1]) & HPTE_R_R)) {
 			kvmppc_clear_ref_hpte(kvm, hptep, i);
 			if (!(rev[i].guest_rpte & HPTE_R_R)) {
@@ -1121,11 +1123,12 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 		}
 
 		/* Now check and modify the HPTE */
-		if (!(hptep[0] & cpu_to_be64(HPTE_V_VALID)))
+		if (!kvmppc_is_host_mapped_hpte(kvm, hptep))
 			continue;
-
-		/* need to make it temporarily absent so C is stable */
-		hptep[0] |= cpu_to_be64(HPTE_V_ABSENT);
+		/*
+		 * need to make it temporarily absent so C is stable
+		 */
+		kvmppc_unmap_host_hpte(kvm, hptep);
 		kvmppc_invalidate_hpte(kvm, hptep, i);
 		v = be64_to_cpu(hptep[0]);
 		r = be64_to_cpu(hptep[1]);
@@ -1141,9 +1144,8 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 				npages_dirty = n;
 			eieio();
 		}
-		v &= ~(HPTE_V_ABSENT | HPTE_V_HVLOCK);
-		v |= HPTE_V_VALID;
-		hptep[0] = cpu_to_be64(v);
+		kvmppc_map_host_hpte(kvm, &v, &r);
+		hptep[0] = cpu_to_be64(v & ~HPTE_V_HVLOCK);
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 1884bff3122c..e8458c0d1336 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -177,6 +177,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	unsigned int writing;
 	unsigned long mmu_seq;
 	unsigned long rcbits;
+	unsigned int host_unmapped_hpte = 0;
 
 	psize = hpte_page_size(pteh, ptel);
 	if (!psize)
@@ -199,9 +200,10 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		/* PPC970 can't do emulated MMIO */
 		if (!cpu_has_feature(CPU_FTR_ARCH_206))
 			return H_PARAMETER;
-		/* Emulated MMIO - mark this with key=31 */
-		pteh |= HPTE_V_ABSENT;
-		ptel |= HPTE_R_KEY_HI | HPTE_R_KEY_LO;
+		/*
+		 * Mark the hpte as host unmapped
+		 */
+		host_unmapped_hpte = 2;
 		goto do_insert;
 	}
 
@@ -241,7 +243,8 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 			pa = pte_pfn(pte) << PAGE_SHIFT;
 			pa |= hva & (pte_size - 1);
 			pa |= gpa & ~PAGE_MASK;
-		}
+		} else
+			host_unmapped_hpte = 1;
 	}
 
 	if (pte_size < psize)
@@ -252,8 +255,6 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 	if (pa)
 		pteh |= HPTE_V_VALID;
-	else
-		pteh |= HPTE_V_ABSENT;
 
 	/* Check WIMG */
 	if (is_io != ~0ul && !hpte_cache_flags_ok(ptel, is_io)) {
@@ -330,16 +331,17 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	}
 
 	/* Link HPTE into reverse-map chain */
-	if (pteh & HPTE_V_VALID) {
+	if (!host_unmapped_hpte) {
 		if (realmode)
 			rmap = real_vmalloc_addr(rmap);
 		lock_rmap(rmap);
 		/* Check for pending invalidations under the rmap chain lock */
 		if (kvm->arch.using_mmu_notifiers &&
 		    mmu_notifier_retry(kvm, mmu_seq)) {
-			/* inval in progress, write a non-present HPTE */
-			pteh |= HPTE_V_ABSENT;
-			pteh &= ~HPTE_V_VALID;
+			/*
+			 * inval in progress in host, write host unmapped pte.
+			 */
+			host_unmapped_hpte = 1;
 			unlock_rmap(rmap);
 		} else {
 			kvmppc_add_revmap_chain(kvm, rev, rmap, pte_index,
@@ -350,8 +352,10 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		}
 	}
 
+	if (host_unmapped_hpte)
+		__kvmppc_unmap_host_hpte(kvm, &pteh, &ptel,
+					 (host_unmapped_hpte == 2));
 	hpte[1] = cpu_to_be64(ptel);
-
 	/* Write the first HPTE dword, unlocking the HPTE and making it valid */
 	eieio();
 	hpte[0] = cpu_to_be64(pteh);
@@ -593,7 +597,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 			rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
 			note_hpte_modification(kvm, rev);
 
-			if (!(hp0 & HPTE_V_VALID)) {
+			if (!kvmppc_is_host_mapped_hpte(kvm, hp)) {
 				/* insert R and C bits from PTE */
 				rcbits = rev->guest_rpte & (HPTE_R_R|HPTE_R_C);
 				args[j] |= rcbits << (56 - 5);
@@ -678,7 +682,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	r = (be64_to_cpu(hpte[1]) & ~mask) | bits;
 
 	/* Update HPTE */
-	if (v & HPTE_V_VALID) {
+	if (kvmppc_is_host_mapped_hpte(kvm, hpte)) {
 		rb = compute_tlbie_rb(v, r, pte_index);
 		hpte[0] = cpu_to_be64(v & ~HPTE_V_VALID);
 		do_tlbies(kvm, &rb, 1, global_invalidates(kvm, flags), true);
-- 
1.9.1
