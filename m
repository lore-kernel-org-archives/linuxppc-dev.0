Return-Path: <paulus@ozlabs.org>
Date: Tue, 20 Dec 2011 20:21:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH] KVM: Move gfn_to_memslot() to kvm_host.h
Message-ID: <20111220092102.GA5626@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves gfn_to_memslot(), and the functions it calls, that is,
search_memslots() and __gfn_to_memslot(), from kvm_main.c to kvm_host.h
so that gfn_to_memslot() can be called from non-modular code even
when KVM is a module.  On powerpc, the Book3S HV style of KVM has
code that is called from real mode which needs to call gfn_to_memslot()
and thus needs this.  (Module code is allocated in the vmalloc region,
which can't be accessed in real mode.)

With this, we can remove builtin_gfn_to_memslot() from book3s_hv_rm_mmu.c
and thus eliminate a little bit of duplication.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c |   23 ++---------------------
 include/linux/kvm_host.h            |   25 ++++++++++++++++++++++++-
 virt/kvm/kvm_main.c                 |   25 -------------------------
 3 files changed, 26 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index d3e36fc..063b00c 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -21,25 +21,6 @@
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
 
-/*
- * Since this file is built in even if KVM is a module, we need
- * a local copy of this function for the case where kvm_main.c is
- * modular.
- */
-static struct kvm_memory_slot *builtin_gfn_to_memslot(struct kvm *kvm,
-						gfn_t gfn)
-{
-	struct kvm_memslots *slots;
-	struct kvm_memory_slot *memslot;
-
-	slots = kvm_memslots(kvm);
-	kvm_for_each_memslot(memslot, slots)
-		if (gfn >= memslot->base_gfn &&
-		      gfn < memslot->base_gfn + memslot->npages)
-			return memslot;
-	return NULL;
-}
-
 /* Translate address of a vmalloc'd thing to a linear map address */
 static void *real_vmalloc_addr(void *x)
 {
@@ -97,7 +78,7 @@ static void remove_revmap_chain(struct kvm *kvm, long pte_index,
 	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
 	ptel = rev->guest_rpte;
 	gfn = hpte_rpn(ptel, hpte_page_size(hpte_v, ptel));
-	memslot = builtin_gfn_to_memslot(kvm, gfn);
+	memslot = gfn_to_memslot(kvm, gfn);
 	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
 		return;
 
@@ -171,7 +152,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	/* Find the memslot (if any) for this address */
 	gpa = (ptel & HPTE_R_RPN) & ~(psize - 1);
 	gfn = gpa >> PAGE_SHIFT;
-	memslot = builtin_gfn_to_memslot(kvm, gfn);
+	memslot = gfn_to_memslot(kvm, gfn);
 	pa = 0;
 	is_io = ~0ul;
 	rmap = NULL;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ec79a45..109828f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -429,7 +429,6 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			      gpa_t gpa);
 int kvm_clear_guest_page(struct kvm *kvm, gfn_t gfn, int offset, int len);
 int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len);
-struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn);
 int kvm_is_visible_gfn(struct kvm *kvm, gfn_t gfn);
 unsigned long kvm_host_page_size(struct kvm *kvm, gfn_t gfn);
 void mark_page_dirty(struct kvm *kvm, gfn_t gfn);
@@ -649,6 +648,30 @@ static inline void kvm_guest_exit(void)
 	current->flags &= ~PF_VCPU;
 }
 
+static inline struct kvm_memory_slot *
+search_memslots(struct kvm_memslots *slots, gfn_t gfn)
+{
+	struct kvm_memory_slot *memslot;
+
+	kvm_for_each_memslot(memslot, slots)
+		if (gfn >= memslot->base_gfn &&
+		      gfn < memslot->base_gfn + memslot->npages)
+			return memslot;
+
+	return NULL;
+}
+
+static inline struct kvm_memory_slot *
+__gfn_to_memslot(struct kvm_memslots *slots, gfn_t gfn)
+{
+	return search_memslots(slots, gfn);
+}
+
+static inline struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
+{
+	return __gfn_to_memslot(kvm_memslots(kvm), gfn);
+}
+
 static inline int memslot_id(struct kvm *kvm, gfn_t gfn)
 {
 	return gfn_to_memslot(kvm, gfn)->id;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c144132..ef11529 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -640,19 +640,6 @@ static int kvm_create_dirty_bitmap(struct kvm_memory_slot *memslot)
 }
 #endif /* !CONFIG_S390 */
 
-static struct kvm_memory_slot *
-search_memslots(struct kvm_memslots *slots, gfn_t gfn)
-{
-	struct kvm_memory_slot *memslot;
-
-	kvm_for_each_memslot(memslot, slots)
-		if (gfn >= memslot->base_gfn &&
-		      gfn < memslot->base_gfn + memslot->npages)
-			return memslot;
-
-	return NULL;
-}
-
 static int cmp_memslot(const void *slot1, const void *slot2)
 {
 	struct kvm_memory_slot *s1, *s2;
@@ -1031,18 +1018,6 @@ int kvm_is_error_hva(unsigned long addr)
 }
 EXPORT_SYMBOL_GPL(kvm_is_error_hva);
 
-static struct kvm_memory_slot *__gfn_to_memslot(struct kvm_memslots *slots,
-						gfn_t gfn)
-{
-	return search_memslots(slots, gfn);
-}
-
-struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
-{
-	return __gfn_to_memslot(kvm_memslots(kvm), gfn);
-}
-EXPORT_SYMBOL_GPL(gfn_to_memslot);
-
 int kvm_is_visible_gfn(struct kvm *kvm, gfn_t gfn)
 {
 	struct kvm_memory_slot *memslot = gfn_to_memslot(kvm, gfn);
-- 
1.7.5.4
