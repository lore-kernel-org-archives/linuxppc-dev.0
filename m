Return-Path: <paulus@ozlabs.org>
Date: Tue, 13 Dec 2011 09:33:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH v3 10/14] KVM: PPC: Maintain a doubly-linked list of guest
 HPTEs for each gfn
Message-ID: <20111212223307.GK18868@bloggs.ozlabs.ibm.com>
References: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
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
 arch/powerpc/include/asm/kvm_book3s_64.h |   18 ++++++
 arch/powerpc/include/asm/kvm_host.h      |   17 ++++++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |   84 +++++++++++++++++++++++++++++-
 3 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 18b590d..9508c03 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -113,6 +113,11 @@ static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
 	return 0;				/* error */
 }
 
+static inline unsigned long hpte_rpn(unsigned long ptel, unsigned long psize)
+{
+	return ((ptel & HPTE_R_RPN) & ~(psize - 1)) >> PAGE_SHIFT;
+}
+
 static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long io_type)
 {
 	unsigned int wimg = ptel & HPTE_R_WIMG;
@@ -139,6 +144,19 @@ static inline unsigned long hpte_cache_bits(unsigned long pte_val)
 #endif
 }
 
+static inline void lock_rmap(unsigned long *rmap)
+{
+	do {
+		while (test_bit(KVMPPC_RMAP_LOCK_BIT, rmap))
+			cpu_relax();
+	} while (test_and_set_bit_lock(KVMPPC_RMAP_LOCK_BIT, rmap));
+}
+
+static inline void unlock_rmap(unsigned long *rmap)
+{
+	__clear_bit_unlock(KVMPPC_RMAP_LOCK_BIT, rmap);
+}
+
 static inline bool slot_is_aligned(struct kvm_memory_slot *memslot,
 				   unsigned long pagesize)
 {
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 243bc80..97cb2d7 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -170,12 +170,27 @@ struct kvmppc_rma_info {
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
 /* Low-order bits in kvm->arch.slot_phys[][] */
 #define KVMPPC_PAGE_ORDER_MASK	0x1f
 #define KVMPPC_PAGE_NO_CACHE	HPTE_R_I	/* 0x20 */
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 3f5b016..5b31caa 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -54,6 +54,70 @@ static void *real_vmalloc_addr(void *x)
 	return __va(addr);
 }
 
+/*
+ * Add this HPTE into the chain for the real page.
+ * Must be called with the chain locked; it unlocks the chain.
+ */
+static void kvmppc_add_revmap_chain(struct kvm *kvm, struct revmap_entry *rev,
+			     unsigned long *rmap, long pte_index, int realmode)
+{
+	struct revmap_entry *head, *tail;
+	unsigned long i;
+
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
+	unlock_rmap(rmap);
+}
+
 long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		    long pte_index, unsigned long pteh, unsigned long ptel)
 {
@@ -66,6 +130,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	struct kvm_memory_slot *memslot;
 	unsigned long *physp, pte_size;
 	unsigned long is_io;
+	unsigned long *rmap;
 	bool realmode = vcpu->arch.vcore->vcore_state == VCORE_RUNNING;
 
 	psize = hpte_page_size(pteh, ptel);
@@ -83,6 +148,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	if (!slot_is_aligned(memslot, psize))
 		return H_PARAMETER;
 	slot_fn = gfn - memslot->base_gfn;
+	rmap = &memslot->rmap[slot_fn];
 
 	physp = kvm->arch.slot_phys[memslot->id];
 	if (!physp)
@@ -164,13 +230,25 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	}
 
 	/* Save away the guest's idea of the second HPTE dword */
-	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+	rev = &kvm->arch.revmap[pte_index];
+	if (realmode)
+		rev = real_vmalloc_addr(rev);
 	if (rev)
 		rev->guest_rpte = g_ptel;
+
+	/* Link HPTE into reverse-map chain */
+	if (realmode)
+		rmap = real_vmalloc_addr(rmap);
+	lock_rmap(rmap);
+	kvmppc_add_revmap_chain(kvm, rev, rmap, pte_index, realmode);
+
 	hpte[1] = ptel;
+
+	/* Write the first HPTE dword, unlocking the HPTE and making it valid */
 	eieio();
 	hpte[0] = pteh;
 	asm volatile("ptesync" : : : "memory");
+
 	vcpu->arch.gpr[4] = pte_index;
 	return H_SUCCESS;
 }
@@ -220,6 +298,8 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 	vcpu->arch.gpr[4] = v = hpte[0] & ~HPTE_V_HVLOCK;
 	vcpu->arch.gpr[5] = r = hpte[1];
 	rb = compute_tlbie_rb(v, r, pte_index);
+	remove_revmap_chain(kvm, pte_index, v);
+	smp_wmb();
 	hpte[0] = 0;
 	if (!(flags & H_LOCAL)) {
 		while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
@@ -293,6 +373,8 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 		flags |= (hp[1] >> 5) & 0x0c;
 		args[i * 2] = ((0x80 | flags) << 56) + pte_index;
 		tlbrb[n_inval++] = compute_tlbie_rb(hp[0], hp[1], pte_index);
+		remove_revmap_chain(kvm, pte_index, hp[0]);
+		smp_wmb();
 		hp[0] = 0;
 	}
 	if (n_inval == 0)
-- 
1.7.7.3
