Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Nov 2011 10:51:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org
Subject: [RFC PATCH 09/11] KVM: PPC: Maintain a doubly-linked list of guest
 HPTEs for each gfn
Message-ID: <20111116235126.GJ26985@bloggs.ozlabs.ibm.com>
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This expands the reverse mapping array to contain two links for each
HPTE which are used to link together HPTEs that correspond to the
same guest logical page.  Each circular list of HPTEs is pointed to
by the rmap array entry for the guest logical page, pointed to by
the relevant memslot.  Links are 32-bit HPT entry indexes rather than
full 64-bit pointers, to save space.  We use 3 of the remaining 32
bits in the rmap array entries as a lock bit, a referenced bit and
a present bit (the present bit is needed since HPTE index 0 is valid).
The bit lock for the rmap chain nests inside the HPTE lock bit.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h |    2 +
 arch/powerpc/include/asm/kvm_host.h   |   17 ++++++-
 arch/powerpc/kvm/book3s_64_mmu_hv.c   |    8 +++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   |   88 ++++++++++++++++++++++++++++++++-
 4 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index ac48438..8454a82 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -143,6 +143,8 @@ extern void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat,
 extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
 extern int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu);
 extern pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
+extern void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
+			unsigned long *rmap, long pte_index, int realmode);
 extern void kvmppc_modify_hpte(struct kvm *kvm, unsigned long *hptep,
 			unsigned long new_hpte[2], unsigned long pte_index);
 extern void *kvmppc_pin_guest_page(struct kvm *kvm, unsigned long addr,
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ababf17..3dfac3d 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -179,12 +179,27 @@ struct kvmppc_slb {
 /*
  * The reverse mapping array has one entry for each HPTE,
  * which stores the guest's view of the second word of the HPTE
- * (including the guest physical address of the mapping).
+ * (including the guest physical address of the mapping),
+ * plus forward and backward pointers in a doubly-linked ring
+ * of HPTEs that map the same host page.  The pointers in this
+ * ring are 32-bit HPTE indexes, to save space.
  */
 struct revmap_entry {
 	unsigned long guest_rpte;
+	unsigned int forw, back;
 };
 
+/*
+ * We use the top bit of each memslot->rmap entry as a lock bit,
+ * and bit 32 as a present flag.  The bottom 32 bits are the
+ * index in the guest HPT of a HPTE that points to the page.
+ */
+#define KVMPPC_RMAP_LOCK_BIT	63
+#define KVMPPC_RMAP_REF_BIT	33
+#define KVMPPC_RMAP_REFERENCED	(1ul << KVMPPC_RMAP_REF_BIT)
+#define KVMPPC_RMAP_PRESENT	0x100000000ul
+#define KVMPPC_RMAP_INDEX	0xfffffffful
+
 struct kvm_arch {
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	unsigned long hpt_virt;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 32c7d8c..e93c789 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -179,6 +179,11 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 		/* Reverse map info */
 		rev = &kvm->arch.revmap[hash];
 		rev->guest_rpte = hp1 | addr;
+		if (pfn) {
+			rev->forw = rev->back = hash;
+			memslot->rmap[i << (porder - PAGE_SHIFT)] = hash |
+				KVMPPC_RMAP_REFERENCED | KVMPPC_RMAP_PRESENT;
+		}
 	}
 }
 
@@ -504,6 +509,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	unsigned long psize, pte_size;
 	unsigned long gfn, hva, pfn, amr;
 	struct kvm_memory_slot *memslot;
+	unsigned long *rmap;
 	struct revmap_entry *rev;
 	struct page *page, *pages[1];
 	unsigned int pp, ok;
@@ -605,6 +611,8 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	hpte[0] = (hpte[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
 	hpte[1] = (rev->guest_rpte & ~(HPTE_R_PP0 - pte_size)) |
 		(pfn << PAGE_SHIFT);
+	rmap = &memslot->rmap[gfn - memslot->base_gfn];
+	kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
 	kvmppc_modify_hpte(kvm, hptep, hpte, index);
 	if (page)
 		SetPageDirty(page);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index b477e68..622bfcd 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -57,6 +57,77 @@ static struct kvm_memory_slot *builtin_gfn_to_memslot(struct kvm *kvm,
 	return NULL;
 }
 
+static void lock_rmap(unsigned long *rmap)
+{
+	do {
+		while (test_bit(KVMPPC_RMAP_LOCK_BIT, rmap))
+			cpu_relax();
+	} while (test_and_set_bit_lock(KVMPPC_RMAP_LOCK_BIT, rmap));
+}
+
+/* Add this HPTE into the chain for the real page */
+void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
+			     unsigned long *rmap, long pte_index, int realmode)
+{
+	struct revmap_entry *head, *tail;
+	unsigned long i;
+
+	lock_rmap(rmap);
+	if (*rmap & KVMPPC_RMAP_PRESENT) {
+		i = *rmap & KVMPPC_RMAP_INDEX;
+		head = &kvm->arch.revmap[i];
+		if (realmode)
+			head = real_vmalloc_addr(head);
+		tail = &kvm->arch.revmap[head->back];
+		if (realmode)
+			tail = real_vmalloc_addr(tail);
+		rev->forw = i;
+		rev->back = head->back;
+		tail->forw = pte_index;
+		head->back = pte_index;
+	} else {
+		rev->forw = rev->back = pte_index;
+		i = pte_index;
+	}
+	smp_wmb();
+	*rmap = i | KVMPPC_RMAP_REFERENCED | KVMPPC_RMAP_PRESENT; /* unlock */
+}
+EXPORT_SYMBOL_GPL(kvmppc_add_revmap_chain);
+
+/* Remove this HPTE from the chain for a real page */
+static void remove_revmap_chain(struct kvm *kvm, long pte_index,
+				unsigned long hpte_v)
+{
+	struct revmap_entry *rev, *next, *prev;
+	unsigned long gfn, ptel, head;
+	struct kvm_memory_slot *memslot;
+	unsigned long *rmap;
+
+	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+	ptel = rev->guest_rpte;
+	gfn = hpte_rpn(ptel, hpte_page_size(hpte_v, ptel));
+	memslot = builtin_gfn_to_memslot(kvm, gfn);
+	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
+		return;
+
+	rmap = real_vmalloc_addr(&memslot->rmap[gfn - memslot->base_gfn]);
+	lock_rmap(rmap);
+
+	head = *rmap & KVMPPC_RMAP_INDEX;
+	next = real_vmalloc_addr(&kvm->arch.revmap[rev->forw]);
+	prev = real_vmalloc_addr(&kvm->arch.revmap[rev->back]);
+	next->back = rev->back;
+	prev->forw = rev->forw;
+	if (head == pte_index) {
+		head = rev->forw;
+		if (head == pte_index)
+			*rmap &= ~(KVMPPC_RMAP_PRESENT | KVMPPC_RMAP_INDEX);
+		else
+			*rmap = (*rmap & ~KVMPPC_RMAP_INDEX) | head;
+	}
+	__clear_bit_unlock(KVMPPC_RMAP_LOCK_BIT, rmap);
+}
+
 long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		    long pte_index, unsigned long pteh, unsigned long ptel)
 {
@@ -69,6 +140,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	struct kvm_memory_slot *memslot;
 	unsigned long *pfnp, pte_size;
 	unsigned long is_io;
+	unsigned long *rmap;
 	pte_t *ptep;
 	unsigned int shift;
 
@@ -82,12 +154,14 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	memslot = builtin_gfn_to_memslot(kvm, gfn);
 	pa = 0;
 	is_io = 1;
+	rmap = NULL;
 	if (memslot && !(memslot->flags & KVM_MEMSLOT_INVALID)) {
 		/* Check if the requested page fits entirely in the memslot. */
 		slot_fn = gfn - memslot->base_gfn;
 		if (slot_fn + (psize >> PAGE_SHIFT) > memslot->npages) 
 			return H_PARAMETER;
 		is_io = memslot->flags & KVM_MEMSLOT_IO;
+		rmap = &memslot->rmap[slot_fn];
 
 		pfnp = kvmppc_pfn_entry(kvm, memslot, gfn);
 		if (pfnp) {
@@ -184,6 +258,12 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	if (rev)
 		rev->guest_rpte = g_ptel;
 
+	/* Link HPTE into reverse-map chain */
+	if (pa) {
+		rmap = real_vmalloc_addr(rmap);
+		kvmppc_add_revmap_chain(kvm, rev, rmap, pte_index, 1);
+	}
+
 	hpte[1] = ptel;
 
 	/* Write the first HPTE dword, unlocking the HPTE and making it valid */
@@ -239,11 +319,14 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 	vcpu->arch.gpr[4] = v = hpte[0] & ~HPTE_V_HVLOCK;
 	vcpu->arch.gpr[5] = r = hpte[1];
 	rb = compute_tlbie_rb(v, r, pte_index);
+	if (!(v & HPTE_V_ABSENT))
+		remove_revmap_chain(kvm, pte_index, v);
+	smp_wmb();
 	hpte[0] = 0;
 	if (!(v & HPTE_V_VALID))
 		return H_SUCCESS;
 	if (!(flags & H_LOCAL)) {
-		while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
+		while (!try_lock_tlbie(&kvm->arch.tlbie_lock))
 			cpu_relax();
 		asm volatile("ptesync" : : : "memory");
 		asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
@@ -315,6 +398,9 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 		args[i * 2] = ((0x80 | flags) << 56) + pte_index;
 		if (hp[0] & HPTE_V_VALID)
 			tlbrb[n_inval++] = compute_tlbie_rb(hp[0], hp[1], pte_index);
+		if (!(hp[0] & HPTE_V_ABSENT))
+			remove_revmap_chain(kvm, pte_index, hp[0]);
+		smp_wmb();
 		hp[0] = 0;
 	}
 	if (n_inval == 0)
-- 
1.7.7.2
