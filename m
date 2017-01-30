Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBlnG4Dh1zDqF3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:10 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 14/20] KVM: PPC: Book3S HV: MMU notifier callbacks for
 radix guests
Date: Mon, 30 Jan 2017 21:21:47 +1100
Message-Id: <1485771713-24801-15-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adapts our implementations of the MMU notifier callbacks
(unmap_hva, unmap_hva_range, age_hva, test_age_hva, set_spte_hva)
to call radix functions when the guest is using radix.  These
implementations are much simpler than for HPT guests because we
have only one PTE to deal with, so we don't need to traverse
rmap chains.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s.h  |  6 ++++
 arch/powerpc/kvm/book3s_64_mmu_hv.c    | 64 +++++++++++++++++++++++-----------
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 54 ++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index ff5cd5c..952cc4b 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -192,6 +192,12 @@ extern int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 extern void kvmppc_free_radix(struct kvm *kvm);
 extern int kvmppc_radix_init(void);
 extern void kvmppc_radix_exit(void);
+extern int kvm_unmap_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
+			unsigned long gfn);
+extern int kvm_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
+			unsigned long gfn);
+extern int kvm_test_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
+			unsigned long gfn);
 
 /* XXX remove this export when load_last_inst() is generic */
 extern int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr, bool data);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 57690c2..088c82b 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -701,12 +701,13 @@ static void kvmppc_rmap_reset(struct kvm *kvm)
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 }
 
+typedef int (*hva_handler_fn)(struct kvm *kvm, struct kvm_memory_slot *memslot,
+			      unsigned long gfn);
+
 static int kvm_handle_hva_range(struct kvm *kvm,
 				unsigned long start,
 				unsigned long end,
-				int (*handler)(struct kvm *kvm,
-					       unsigned long *rmapp,
-					       unsigned long gfn))
+				hva_handler_fn handler)
 {
 	int ret;
 	int retval = 0;
@@ -731,9 +732,7 @@ static int kvm_handle_hva_range(struct kvm *kvm,
 		gfn_end = hva_to_gfn_memslot(hva_end + PAGE_SIZE - 1, memslot);
 
 		for (; gfn < gfn_end; ++gfn) {
-			gfn_t gfn_offset = gfn - memslot->base_gfn;
-
-			ret = handler(kvm, &memslot->arch.rmap[gfn_offset], gfn);
+			ret = handler(kvm, memslot, gfn);
 			retval |= ret;
 		}
 	}
@@ -742,20 +741,21 @@ static int kvm_handle_hva_range(struct kvm *kvm,
 }
 
 static int kvm_handle_hva(struct kvm *kvm, unsigned long hva,
-			  int (*handler)(struct kvm *kvm, unsigned long *rmapp,
-					 unsigned long gfn))
+			  hva_handler_fn handler)
 {
 	return kvm_handle_hva_range(kvm, hva, hva + 1, handler);
 }
 
-static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
+static int kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			   unsigned long gfn)
 {
 	struct revmap_entry *rev = kvm->arch.revmap;
 	unsigned long h, i, j;
 	__be64 *hptep;
 	unsigned long ptel, psize, rcbits;
+	unsigned long *rmapp;
 
+	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
 	for (;;) {
 		lock_rmap(rmapp);
 		if (!(*rmapp & KVMPPC_RMAP_PRESENT)) {
@@ -816,26 +816,36 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 
 int kvm_unmap_hva_hv(struct kvm *kvm, unsigned long hva)
 {
-	kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
+	hva_handler_fn handler;
+
+	handler = kvm_is_radix(kvm) ? kvm_unmap_radix : kvm_unmap_rmapp;
+	kvm_handle_hva(kvm, hva, handler);
 	return 0;
 }
 
 int kvm_unmap_hva_range_hv(struct kvm *kvm, unsigned long start, unsigned long end)
 {
-	kvm_handle_hva_range(kvm, start, end, kvm_unmap_rmapp);
+	hva_handler_fn handler;
+
+	handler = kvm_is_radix(kvm) ? kvm_unmap_radix : kvm_unmap_rmapp;
+	kvm_handle_hva_range(kvm, start, end, handler);
 	return 0;
 }
 
 void kvmppc_core_flush_memslot_hv(struct kvm *kvm,
 				  struct kvm_memory_slot *memslot)
 {
-	unsigned long *rmapp;
 	unsigned long gfn;
 	unsigned long n;
+	unsigned long *rmapp;
 
-	rmapp = memslot->arch.rmap;
 	gfn = memslot->base_gfn;
-	for (n = memslot->npages; n; --n) {
+	rmapp = memslot->arch.rmap;
+	for (n = memslot->npages; n; --n, ++gfn) {
+		if (kvm_is_radix(kvm)) {
+			kvm_unmap_radix(kvm, memslot, gfn);
+			continue;
+		}
 		/*
 		 * Testing the present bit without locking is OK because
 		 * the memslot has been marked invalid already, and hence
@@ -843,20 +853,21 @@ void kvmppc_core_flush_memslot_hv(struct kvm *kvm,
 		 * thus the present bit can't go from 0 to 1.
 		 */
 		if (*rmapp & KVMPPC_RMAP_PRESENT)
-			kvm_unmap_rmapp(kvm, rmapp, gfn);
+			kvm_unmap_rmapp(kvm, memslot, gfn);
 		++rmapp;
-		++gfn;
 	}
 }
 
-static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
+static int kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			 unsigned long gfn)
 {
 	struct revmap_entry *rev = kvm->arch.revmap;
 	unsigned long head, i, j;
 	__be64 *hptep;
 	int ret = 0;
+	unsigned long *rmapp;
 
+	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
  retry:
 	lock_rmap(rmapp);
 	if (*rmapp & KVMPPC_RMAP_REFERENCED) {
@@ -904,17 +915,22 @@ static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 
 int kvm_age_hva_hv(struct kvm *kvm, unsigned long start, unsigned long end)
 {
-	return kvm_handle_hva_range(kvm, start, end, kvm_age_rmapp);
+	hva_handler_fn handler;
+
+	handler = kvm_is_radix(kvm) ? kvm_age_radix : kvm_age_rmapp;
+	return kvm_handle_hva_range(kvm, start, end, handler);
 }
 
-static int kvm_test_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
+static int kvm_test_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			      unsigned long gfn)
 {
 	struct revmap_entry *rev = kvm->arch.revmap;
 	unsigned long head, i, j;
 	unsigned long *hp;
 	int ret = 1;
+	unsigned long *rmapp;
 
+	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
 	if (*rmapp & KVMPPC_RMAP_REFERENCED)
 		return 1;
 
@@ -940,12 +956,18 @@ static int kvm_test_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 
 int kvm_test_age_hva_hv(struct kvm *kvm, unsigned long hva)
 {
-	return kvm_handle_hva(kvm, hva, kvm_test_age_rmapp);
+	hva_handler_fn handler;
+
+	handler = kvm_is_radix(kvm) ? kvm_test_age_radix : kvm_test_age_rmapp;
+	return kvm_handle_hva(kvm, hva, handler);
 }
 
 void kvm_set_spte_hva_hv(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
-	kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
+	hva_handler_fn handler;
+
+	handler = kvm_is_radix(kvm) ? kvm_unmap_radix : kvm_unmap_rmapp;
+	kvm_handle_hva(kvm, hva, handler);
 }
 
 static int vcpus_running(struct kvm *kvm)
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 865ea9b..69cabad 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -463,6 +463,60 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+/* Called with kvm->lock held */
+int kvm_unmap_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
+		    unsigned long gfn)
+{
+	pte_t *ptep;
+	unsigned long gpa = gfn << PAGE_SHIFT;
+	unsigned int shift;
+
+	ptep = __find_linux_pte_or_hugepte(kvm->arch.pgtable, gpa,
+					   NULL, &shift);
+	if (ptep && pte_present(*ptep)) {
+		kvmppc_radix_update_pte(kvm, ptep, _PAGE_PRESENT, 0,
+					gpa, shift);
+		kvmppc_radix_tlbie_page(kvm, gpa, shift);
+	}
+	return 0;				
+}
+
+/* Called with kvm->lock held */
+int kvm_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
+		  unsigned long gfn)
+{
+	pte_t *ptep;
+	unsigned long gpa = gfn << PAGE_SHIFT;
+	unsigned int shift;
+	int ref = 0;
+
+	ptep = __find_linux_pte_or_hugepte(kvm->arch.pgtable, gpa,
+					   NULL, &shift);
+	if (ptep && pte_present(*ptep) && pte_young(*ptep)) {
+		kvmppc_radix_update_pte(kvm, ptep, _PAGE_ACCESSED, 0,
+					gpa, shift);
+		/* XXX need to flush tlb here? */
+		ref = 1;
+	}
+	return ref;
+}
+
+/* Called with kvm->lock held */
+int kvm_test_age_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
+		       unsigned long gfn)
+{
+	pte_t *ptep;
+	unsigned long gpa = gfn << PAGE_SHIFT;
+	unsigned int shift;
+	int ref = 0;
+
+	ptep = __find_linux_pte_or_hugepte(kvm->arch.pgtable, gpa,
+					   NULL, &shift);
+	if (ptep && pte_present(*ptep) && pte_young(*ptep))
+		ref = 1;
+	return ref;
+}
+
 void kvmppc_free_radix(struct kvm *kvm)
 {
 	unsigned long ig, iu, im;
-- 
2.7.4
