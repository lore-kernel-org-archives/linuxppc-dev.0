Return-Path: <paulus@ozlabs.org>
Date: Thu, 15 Dec 2011 23:02:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH 2/5] KVM: PPC: Book3s HV: Maintain separate guest and host
 views of R and C bits
Message-ID: <20111215120201.GC20629@bloggs.ozlabs.ibm.com>
References: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows both the guest and the host to use the referenced (R) and
changed (C) bits in the guest hashed page table.  The guest has a view
of R and C that is maintained in the guest_rpte field of the revmap
entry for the HPTE, and the host has a view that is maintained in the
rmap entry for the associated gfn.

Both view are updated from the guest HPT.  If a bit (R or C) is zero
in either view, it will be initially set to zero in the HPTE (or HPTEs),
until set to 1 by hardware.  When an HPTE is removed for any reason,
the R and C bits from the HPTE are ORed into both views.  We have to
be careful to read the R and C bits from the HPTE after invalidating
it, but before unlocking it, in case of any late updates by the hardware.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_host.h |    5 ++-
 arch/powerpc/kvm/book3s_64_mmu_hv.c |   48 +++++++++++++++++++++-------------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c |   45 +++++++++++++++++++--------------
 3 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 968f3aa..1cb6e52 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -200,8 +200,9 @@ struct revmap_entry {
  * index in the guest HPT of a HPTE that points to the page.
  */
 #define KVMPPC_RMAP_LOCK_BIT	63
-#define KVMPPC_RMAP_REF_BIT	33
-#define KVMPPC_RMAP_REFERENCED	(1ul << KVMPPC_RMAP_REF_BIT)
+#define KVMPPC_RMAP_RC_SHIFT	32
+#define KVMPPC_RMAP_REFERENCED	(HPTE_R_R << KVMPPC_RMAP_RC_SHIFT)
+#define KVMPPC_RMAP_CHANGED	(HPTE_R_C << KVMPPC_RMAP_RC_SHIFT)
 #define KVMPPC_RMAP_PRESENT	0x100000000ul
 #define KVMPPC_RMAP_INDEX	0xfffffffful
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 66d6452..aa51dde 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -505,6 +505,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	unsigned long is_io;
 	unsigned int writing, write_ok;
 	struct vm_area_struct *vma;
+	unsigned long rcbits;
 
 	/*
 	 * Real-mode code has already searched the HPT and found the
@@ -640,11 +641,17 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		goto out_unlock;
 	}
 
+	/* Only set R/C in real HPTE if set in both *rmap and guest_rpte */
+	rcbits = *rmap >> KVMPPC_RMAP_RC_SHIFT;
+	r &= rcbits | ~(HPTE_R_R | HPTE_R_C);
+
 	if (hptep[0] & HPTE_V_VALID) {
 		/* HPTE was previously valid, so we need to invalidate it */
 		unlock_rmap(rmap);
 		hptep[0] |= HPTE_V_ABSENT;
 		kvmppc_invalidate_hpte(kvm, hptep, index);
+		/* don't lose previous R and C bits */
+		r |= hptep[1] & (HPTE_R_R | HPTE_R_C);
 	} else {
 		kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
 	}
@@ -701,50 +708,55 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 	struct revmap_entry *rev = kvm->arch.revmap;
 	unsigned long h, i, j;
 	unsigned long *hptep;
-	unsigned long ptel, psize;
+	unsigned long ptel, psize, rcbits;
 
 	for (;;) {
-		while (test_and_set_bit_lock(KVMPPC_RMAP_LOCK_BIT, rmapp))
-			cpu_relax();
+		lock_rmap(rmapp);
 		if (!(*rmapp & KVMPPC_RMAP_PRESENT)) {
-			__clear_bit_unlock(KVMPPC_RMAP_LOCK_BIT, rmapp);
+			unlock_rmap(rmapp);
 			break;
 		}
 
 		/*
 		 * To avoid an ABBA deadlock with the HPTE lock bit,
-		 * we have to unlock the rmap chain before locking the HPTE.
-		 * Thus we remove the first entry, unlock the rmap chain,
-		 * lock the HPTE and then check that it is for the
-		 * page we're unmapping before changing it to non-present.
+		 * we can't spin on the HPTE lock while holding the
+		 * rmap chain lock.
 		 */
 		i = *rmapp & KVMPPC_RMAP_INDEX;
+		hptep = (unsigned long *) (kvm->arch.hpt_virt + (i << 4));
+		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
+			/* unlock rmap before spinning on the HPTE lock */
+			unlock_rmap(rmapp);
+			while (hptep[0] & HPTE_V_HVLOCK)
+				cpu_relax();
+			continue;
+		}
 		j = rev[i].forw;
 		if (j == i) {
 			/* chain is now empty */
-			j = 0;
+			*rmapp &= ~(KVMPPC_RMAP_PRESENT | KVMPPC_RMAP_INDEX);
 		} else {
 			/* remove i from chain */
 			h = rev[i].back;
 			rev[h].forw = j;
 			rev[j].back = h;
 			rev[i].forw = rev[i].back = i;
-			j |= KVMPPC_RMAP_PRESENT;
+			*rmapp = (*rmapp & ~KVMPPC_RMAP_INDEX) | j;
 		}
-		smp_wmb();
-		*rmapp = j | (1ul << KVMPPC_RMAP_REF_BIT);
 
-		/* Now lock, check and modify the HPTE */
-		hptep = (unsigned long *) (kvm->arch.hpt_virt + (i << 4));
-		while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
-			cpu_relax();
+		/* Now check and modify the HPTE */
 		ptel = rev[i].guest_rpte;
 		psize = hpte_page_size(hptep[0], ptel);
 		if ((hptep[0] & HPTE_V_VALID) &&
 		    hpte_rpn(ptel, psize) == gfn) {
-			kvmppc_invalidate_hpte(kvm, hptep, i);
 			hptep[0] |= HPTE_V_ABSENT;
+			kvmppc_invalidate_hpte(kvm, hptep, i);
+			/* Harvest R and C */
+			rcbits = hptep[1] & (HPTE_R_R | HPTE_R_C);
+			*rmapp |= rcbits << KVMPPC_RMAP_RC_SHIFT;
+			rev[i].guest_rpte = ptel | rcbits;
 		}
+		unlock_rmap(rmapp);
 		hptep[0] &= ~HPTE_V_HVLOCK;
 	}
 	return 0;
@@ -767,7 +779,7 @@ static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 	kvm_unmap_rmapp(kvm, rmapp, gfn);
 	while (test_and_set_bit_lock(KVMPPC_RMAP_LOCK_BIT, rmapp))
 		cpu_relax();
-	__clear_bit(KVMPPC_RMAP_REF_BIT, rmapp);
+	*rmapp &= ~KVMPPC_RMAP_REFERENCED;
 	__clear_bit_unlock(KVMPPC_RMAP_LOCK_BIT, rmapp);
 	return 1;
 }
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 823348d..bcf6f92 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -87,15 +87,17 @@ EXPORT_SYMBOL_GPL(kvmppc_add_revmap_chain);
 
 /* Remove this HPTE from the chain for a real page */
 static void remove_revmap_chain(struct kvm *kvm, long pte_index,
-				unsigned long hpte_v)
+				struct revmap_entry *rev,
+				unsigned long hpte_v, unsigned long hpte_r)
 {
-	struct revmap_entry *rev, *next, *prev;
+	struct revmap_entry *next, *prev;
 	unsigned long gfn, ptel, head;
 	struct kvm_memory_slot *memslot;
 	unsigned long *rmap;
+	unsigned long rcbits;
 
-	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
-	ptel = rev->guest_rpte;
+	rcbits = hpte_r & (HPTE_R_R | HPTE_R_C);
+	ptel = rev->guest_rpte |= rcbits;
 	gfn = hpte_rpn(ptel, hpte_page_size(hpte_v, ptel));
 	memslot = builtin_gfn_to_memslot(kvm, gfn);
 	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
@@ -116,6 +118,7 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
 		else
 			*rmap = (*rmap & ~KVMPPC_RMAP_INDEX) | head;
 	}
+	*rmap |= rcbits << KVMPPC_RMAP_RC_SHIFT;
 	unlock_rmap(rmap);
 }
 
@@ -162,6 +165,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	pte_t pte;
 	unsigned int writing;
 	unsigned long mmu_seq;
+	unsigned long rcbits;
 	bool realmode = vcpu->arch.vcore->vcore_state == VCORE_RUNNING;
 
 	psize = hpte_page_size(pteh, ptel);
@@ -320,6 +324,9 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		} else {
 			kvmppc_add_revmap_chain(kvm, rev, rmap, pte_index,
 						realmode);
+			/* Only set R/C in real HPTE if already set in *rmap */
+			rcbits = *rmap >> KVMPPC_RMAP_RC_SHIFT;
+			ptel &= rcbits | ~(HPTE_R_R | HPTE_R_C);
 		}
 	}
 
@@ -394,7 +401,8 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 			asm volatile("tlbiel %0" : : "r" (rb));
 			asm volatile("ptesync" : : : "memory");
 		}
-		remove_revmap_chain(kvm, pte_index, v);
+		/* Read PTE low word after tlbie to get final R/C values */
+		remove_revmap_chain(kvm, pte_index, rev, v, hpte[1]);
 	}
 	r = rev->guest_rpte;
 	unlock_hpte(hpte, 0);
@@ -469,12 +477,13 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 
 			args[j] = ((0x80 | flags) << 56) + pte_index;
 			rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
-			/* insert R and C bits from guest PTE */
-			rcbits = rev->guest_rpte & (HPTE_R_R|HPTE_R_C);
-			args[j] |= rcbits << (56 - 5);
 
-			if (!(hp[0] & HPTE_V_VALID))
+			if (!(hp[0] & HPTE_V_VALID)) {
+				/* insert R and C bits from PTE */
+				rcbits = rev->guest_rpte & (HPTE_R_R|HPTE_R_C);
+				args[j] |= rcbits << (56 - 5);
 				continue;
+			}
 
 			hp[0] &= ~HPTE_V_VALID;		/* leave it locked */
 			tlbrb[n] = compute_tlbie_rb(hp[0], hp[1], pte_index);
@@ -505,13 +514,16 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 			asm volatile("ptesync" : : : "memory");
 		}
 
+		/* Read PTE low words after tlbie to get final R/C values */
 		for (k = 0; k < n; ++k) {
 			j = indexes[k];
 			pte_index = args[j] & ((1ul << 56) - 1);
 			hp = hptes[k];
 			rev = revs[k];
-			remove_revmap_chain(kvm, pte_index, hp[0]);
-			unlock_hpte(hp, 0);
+			remove_revmap_chain(kvm, pte_index, rev, hp[0], hp[1]);
+			rcbits = rev->guest_rpte & (HPTE_R_R|HPTE_R_C);
+			args[j] |= rcbits << (56 - 5);
+			hp[0] = 0;
 		}
 	}
 
@@ -595,8 +607,7 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 		pte_index &= ~3;
 		n = 4;
 	}
-	if (flags & H_R_XLATE)
-		rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
 	for (i = 0; i < n; ++i, ++pte_index) {
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 		v = hpte[0] & ~HPTE_V_HVLOCK;
@@ -605,12 +616,8 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 			v &= ~HPTE_V_ABSENT;
 			v |= HPTE_V_VALID;
 		}
-		if (v & HPTE_V_VALID) {
-			if (rev)
-				r = rev[i].guest_rpte;
-			else
-				r = hpte[1] | HPTE_R_RPN;
-		}
+		if (v & HPTE_V_VALID)
+			r = rev[i].guest_rpte | (r & (HPTE_R_R | HPTE_R_C));
 		vcpu->arch.gpr[4 + i * 2] = v;
 		vcpu->arch.gpr[5 + i * 2] = r;
 	}
-- 
1.7.7.3
