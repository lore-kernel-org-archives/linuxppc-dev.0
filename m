Return-Path: <paulus@ozlabs.org>
Date: Thu, 15 Dec 2011 23:01:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH 1/5] KVM: PPC: Book3S HV: Keep HPTE locked when invalidating
Message-ID: <20111215120110.GB20629@bloggs.ozlabs.ibm.com>
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

This reworks the implementations of the H_REMOVE and H_BULK_REMOVE
hcalls to make sure that we keep the HPTE locked and in the reverse-
mapping chain until we have finished invalidating it.  Previously
we would remove it from the chain and unlock it before invalidating
it, leaving a tiny window when the guest could access the page even
though we believe we have removed it from the guest (e.g.,
kvm_unmap_hva() has been called for the page and has found no HPTEs
in the chain).  In addition, we'll need this for future patches where
we will need to read the R and C bits in the HPTE after invalidating
it.

Doing this required restructuring kvmppc_h_bulk_remove() substantially.
Since we want to batch up the tlbies, we now need to keep several
HPTEs locked simultaneously.  In order to avoid possible deadlocks,
we don't spin on the HPTE bitlock for any except the first HPTE in
a batch.  If we can't acquire the HPTE bitlock for the second or
subsequent HPTE, we terminate the batch at that point, do the tlbies
that we have accumulated so far, unlock those HPTEs, and then start
a new batch to do the remaining invalidations.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c |  212 ++++++++++++++++++++--------------
 1 files changed, 125 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 7c0fc99..823348d 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -140,6 +140,12 @@ static pte_t lookup_linux_pte(struct kvm_vcpu *vcpu, unsigned long hva,
 	return kvmppc_read_update_linux_pte(ptep, writing);
 }
 
+static inline void unlock_hpte(unsigned long *hpte, unsigned long hpte_v)
+{
+	asm volatile(PPC_RELEASE_BARRIER "" : : : "memory");
+	hpte[0] = hpte_v;
+}
+
 long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		    long pte_index, unsigned long pteh, unsigned long ptel)
 {
@@ -356,6 +362,7 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long *hpte;
 	unsigned long v, r, rb;
+	struct revmap_entry *rev;
 
 	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
@@ -368,30 +375,32 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 		hpte[0] &= ~HPTE_V_HVLOCK;
 		return H_NOT_FOUND;
 	}
-	if (atomic_read(&kvm->online_vcpus) == 1)
-		flags |= H_LOCAL;
-	vcpu->arch.gpr[4] = v = hpte[0] & ~HPTE_V_HVLOCK;
-	vcpu->arch.gpr[5] = r = hpte[1];
-	rb = compute_tlbie_rb(v, r, pte_index);
-	if (v & HPTE_V_VALID)
+
+	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+	v = hpte[0] & ~HPTE_V_HVLOCK;
+	if (v & HPTE_V_VALID) {
+		hpte[0] &= ~HPTE_V_VALID;
+		rb = compute_tlbie_rb(v, hpte[1], pte_index);
+		if (!(flags & H_LOCAL) && atomic_read(&kvm->online_vcpus) > 1) {
+			while (!try_lock_tlbie(&kvm->arch.tlbie_lock))
+				cpu_relax();
+			asm volatile("ptesync" : : : "memory");
+			asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
+				     : : "r" (rb), "r" (kvm->arch.lpid));
+			asm volatile("ptesync" : : : "memory");
+			kvm->arch.tlbie_lock = 0;
+		} else {
+			asm volatile("ptesync" : : : "memory");
+			asm volatile("tlbiel %0" : : "r" (rb));
+			asm volatile("ptesync" : : : "memory");
+		}
 		remove_revmap_chain(kvm, pte_index, v);
-	smp_wmb();
-	hpte[0] = 0;
-	if (!(v & HPTE_V_VALID))
-		return H_SUCCESS;
-	if (!(flags & H_LOCAL)) {
-		while (!try_lock_tlbie(&kvm->arch.tlbie_lock))
-			cpu_relax();
-		asm volatile("ptesync" : : : "memory");
-		asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
-			     : : "r" (rb), "r" (kvm->arch.lpid));
-		asm volatile("ptesync" : : : "memory");
-		kvm->arch.tlbie_lock = 0;
-	} else {
-		asm volatile("ptesync" : : : "memory");
-		asm volatile("tlbiel %0" : : "r" (rb));
-		asm volatile("ptesync" : : : "memory");
 	}
+	r = rev->guest_rpte;
+	unlock_hpte(hpte, 0);
+
+	vcpu->arch.gpr[4] = v;
+	vcpu->arch.gpr[5] = r;
 	return H_SUCCESS;
 }
 
@@ -399,82 +408,113 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long *args = &vcpu->arch.gpr[4];
-	unsigned long *hp, tlbrb[4];
-	long int i, found;
-	long int n_inval = 0;
-	unsigned long flags, req, pte_index;
+	unsigned long *hp, *hptes[4], tlbrb[4];
+	long int i, j, k, n, found, indexes[4];
+	unsigned long flags, req, pte_index, rcbits;
 	long int local = 0;
 	long int ret = H_SUCCESS;
+	struct revmap_entry *rev, *revs[4];
 
 	if (atomic_read(&kvm->online_vcpus) == 1)
 		local = 1;
-	for (i = 0; i < 4; ++i) {
-		pte_index = args[i * 2];
-		flags = pte_index >> 56;
-		pte_index &= ((1ul << 56) - 1);
-		req = flags >> 6;
-		flags &= 3;
-		if (req == 3)
-			break;
-		if (req != 1 || flags == 3 ||
-		    pte_index >= HPT_NPTE) {
-			/* parameter error */
-			args[i * 2] = ((0xa0 | flags) << 56) + pte_index;
-			ret = H_PARAMETER;
-			break;
-		}
-		hp = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
-		while (!try_lock_hpte(hp, HPTE_V_HVLOCK))
-			cpu_relax();
-		found = 0;
-		if (hp[0] & (HPTE_V_ABSENT | HPTE_V_VALID)) {
-			switch (flags & 3) {
-			case 0:		/* absolute */
-				found = 1;
+	for (i = 0; i < 4 && ret == H_SUCCESS; ) {
+		n = 0;
+		for (; i < 4; ++i) {
+			j = i * 2;
+			pte_index = args[j];
+			flags = pte_index >> 56;
+			pte_index &= ((1ul << 56) - 1);
+			req = flags >> 6;
+			flags &= 3;
+			if (req == 3) {		/* no more requests */
+				i = 4;
 				break;
-			case 1:		/* andcond */
-				if (!(hp[0] & args[i * 2 + 1]))
-					found = 1;
+			}
+			if (req != 1 || flags == 3 || pte_index >= HPT_NPTE) {
+				/* parameter error */
+				args[j] = ((0xa0 | flags) << 56) + pte_index;
+				ret = H_PARAMETER;
 				break;
-			case 2:		/* AVPN */
-				if ((hp[0] & ~0x7fUL) == args[i * 2 + 1])
+			}
+			hp = (unsigned long *)
+				(kvm->arch.hpt_virt + (pte_index << 4));
+			/* to avoid deadlock, don't spin except for first */
+			if (!try_lock_hpte(hp, HPTE_V_HVLOCK)) {
+				if (n)
+					break;
+				while (!try_lock_hpte(hp, HPTE_V_HVLOCK))
+					cpu_relax();
+			}
+			found = 0;
+			if (hp[0] & (HPTE_V_ABSENT | HPTE_V_VALID)) {
+				switch (flags & 3) {
+				case 0:		/* absolute */
 					found = 1;
-				break;
+					break;
+				case 1:		/* andcond */
+					if (!(hp[0] & args[j + 1]))
+						found = 1;
+					break;
+				case 2:		/* AVPN */
+					if ((hp[0] & ~0x7fUL) == args[j + 1])
+						found = 1;
+					break;
+				}
+			}
+			if (!found) {
+				hp[0] &= ~HPTE_V_HVLOCK;
+				args[j] = ((0x90 | flags) << 56) + pte_index;
+				continue;
 			}
+
+			args[j] = ((0x80 | flags) << 56) + pte_index;
+			rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+			/* insert R and C bits from guest PTE */
+			rcbits = rev->guest_rpte & (HPTE_R_R|HPTE_R_C);
+			args[j] |= rcbits << (56 - 5);
+
+			if (!(hp[0] & HPTE_V_VALID))
+				continue;
+
+			hp[0] &= ~HPTE_V_VALID;		/* leave it locked */
+			tlbrb[n] = compute_tlbie_rb(hp[0], hp[1], pte_index);
+			indexes[n] = j;
+			hptes[n] = hp;
+			revs[n] = rev;
+			++n;
 		}
-		if (!found) {
-			hp[0] &= ~HPTE_V_HVLOCK;
-			args[i * 2] = ((0x90 | flags) << 56) + pte_index;
-			continue;
+
+		if (!n)
+			break;
+
+		/* Now that we've collected a batch, do the tlbies */
+		if (!local) {
+			while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
+				cpu_relax();
+			asm volatile("ptesync" : : : "memory");
+			for (k = 0; k < n; ++k)
+				asm volatile(PPC_TLBIE(%1,%0) : :
+					     "r" (tlbrb[k]),
+					     "r" (kvm->arch.lpid));
+			asm volatile("eieio; tlbsync; ptesync" : : : "memory");
+			kvm->arch.tlbie_lock = 0;
+		} else {
+			asm volatile("ptesync" : : : "memory");
+			for (k = 0; k < n; ++k)
+				asm volatile("tlbiel %0" : : "r" (tlbrb[k]));
+			asm volatile("ptesync" : : : "memory");
 		}
-		/* insert R and C bits from PTE */
-		flags |= (hp[1] >> 5) & 0x0c;
-		args[i * 2] = ((0x80 | flags) << 56) + pte_index;
-		if (hp[0] & HPTE_V_VALID) {
-			tlbrb[n_inval++] = compute_tlbie_rb(hp[0], hp[1], pte_index);
+
+		for (k = 0; k < n; ++k) {
+			j = indexes[k];
+			pte_index = args[j] & ((1ul << 56) - 1);
+			hp = hptes[k];
+			rev = revs[k];
 			remove_revmap_chain(kvm, pte_index, hp[0]);
+			unlock_hpte(hp, 0);
 		}
-		smp_wmb();
-		hp[0] = 0;
-	}
-	if (n_inval == 0)
-		return ret;
-
-	if (!local) {
-		while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
-			cpu_relax();
-		asm volatile("ptesync" : : : "memory");
-		for (i = 0; i < n_inval; ++i)
-			asm volatile(PPC_TLBIE(%1,%0)
-				     : : "r" (tlbrb[i]), "r" (kvm->arch.lpid));
-		asm volatile("eieio; tlbsync; ptesync" : : : "memory");
-		kvm->arch.tlbie_lock = 0;
-	} else {
-		asm volatile("ptesync" : : : "memory");
-		for (i = 0; i < n_inval; ++i)
-			asm volatile("tlbiel %0" : : "r" (tlbrb[i]));
-		asm volatile("ptesync" : : : "memory");
 	}
+
 	return ret;
 }
 
@@ -720,9 +760,7 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 	rev = real_vmalloc_addr(&kvm->arch.revmap[index]);
 	gr = rev->guest_rpte;
 
-	/* Unlock the HPTE */
-	asm volatile("lwsync" : : : "memory");
-	hpte[0] = v;
+	unlock_hpte(hpte, v);
 
 	/* For not found, if the HPTE is valid by now, retry the instruction */
 	if ((status & DSISR_NOHPTE) && (v & HPTE_V_VALID))
-- 
1.7.7.3
