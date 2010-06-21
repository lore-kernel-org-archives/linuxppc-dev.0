Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2227F1007F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Jun 2010 23:44:06 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 2/2] KVM: PPC: Make use of hash based Shadow MMU
Date: Mon, 21 Jun 2010 15:44:01 +0200
Message-Id: <1277127841-32704-2-git-send-email-agraf@suse.de>
In-Reply-To: <1277127841-32704-1-git-send-email-agraf@suse.de>
References: <1277127841-32704-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We just introduced generic functions to handle shadow pages on PPC.
This patch makes the respective backends make use of them, getting
rid of a lot of duplicate code along the way.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_book3s.h |    7 ++
 arch/powerpc/include/asm/kvm_host.h   |   16 ++++-
 arch/powerpc/kvm/Makefile             |    2 +
 arch/powerpc/kvm/book3s_32_mmu_host.c |  104 +++-----------------------------
 arch/powerpc/kvm/book3s_64_mmu_host.c |   98 ++----------------------------
 5 files changed, 39 insertions(+), 188 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 4e99559..a96e405 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -115,6 +115,13 @@ extern void kvmppc_mmu_book3s_32_init(struct kvm_vcpu *vcpu);
 extern int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte);
 extern int kvmppc_mmu_map_segment(struct kvm_vcpu *vcpu, ulong eaddr);
 extern void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu);
+
+extern void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte);
+extern struct hpte_cache *kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu);
+extern void kvmppc_mmu_hpte_destroy(struct kvm_vcpu *vcpu);
+extern int kvmppc_mmu_hpte_init(struct kvm_vcpu *vcpu);
+extern void kvmppc_mmu_invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte);
+
 extern int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr, bool data);
 extern int kvmppc_st(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr, bool data);
 extern void kvmppc_book3s_queue_irqprio(struct kvm_vcpu *vcpu, unsigned int vec);
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 0c9ad86..0e3fc82 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -38,7 +38,9 @@
 #define KVM_NR_PAGE_SIZES	1
 #define KVM_PAGES_PER_HPAGE(x)	(1UL<<31)
 
-#define HPTEG_CACHE_NUM 1024
+#define HPTEG_CACHE_NUM		(1 << 15)
+#define HPTEG_HASH_BITS		13
+#define HPTEG_HASH_NUM		(1 << HPTEG_HASH_BITS)
 
 struct kvm;
 struct kvm_run;
@@ -151,6 +153,10 @@ struct kvmppc_mmu {
 };
 
 struct hpte_cache {
+	struct list_head list_all;
+	struct list_head list_pte;
+	struct list_head list_vpte;
+	struct list_head list_vpte_long;
 	u64 host_va;
 	u64 pfn;
 	ulong slot;
@@ -282,8 +288,12 @@ struct kvm_vcpu_arch {
 	unsigned long pending_exceptions;
 
 #ifdef CONFIG_PPC_BOOK3S
-	struct hpte_cache hpte_cache[HPTEG_CACHE_NUM];
-	int hpte_cache_offset;
+	struct kmem_cache *hpte_cache;
+	struct list_head hpte_hash_pte[HPTEG_HASH_NUM];
+	struct list_head hpte_hash_vpte[HPTEG_HASH_NUM];
+	struct list_head hpte_hash_vpte_long[HPTEG_HASH_NUM];
+	struct list_head hpte_all;
+	int hpte_cache_count;
 #endif
 };
 
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index ff43606..d45c818 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -45,6 +45,7 @@ kvm-book3s_64-objs := \
 	book3s.o \
 	book3s_emulate.o \
 	book3s_interrupts.o \
+	book3s_mmu_hpte.o \
 	book3s_64_mmu_host.o \
 	book3s_64_mmu.o \
 	book3s_32_mmu.o
@@ -57,6 +58,7 @@ kvm-book3s_32-objs := \
 	book3s.o \
 	book3s_emulate.o \
 	book3s_interrupts.o \
+	book3s_mmu_hpte.o \
 	book3s_32_mmu_host.o \
 	book3s_32_mmu.o
 kvm-objs-$(CONFIG_KVM_BOOK3S_32) := $(kvm-book3s_32-objs)
diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 904f5ac..0b51ef8 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -58,105 +58,19 @@
 static ulong htab;
 static u32 htabmask;
 
-static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
+void kvmppc_mmu_invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 {
 	volatile u32 *pteg;
 
-	dprintk_mmu("KVM: Flushing SPTE: 0x%llx (0x%llx) -> 0x%llx\n",
-		    pte->pte.eaddr, pte->pte.vpage, pte->host_va);
-
+	/* Remove from host HTAB */
 	pteg = (u32*)pte->slot;
-
 	pteg[0] = 0;
+
+	/* And make sure it's gone from the TLB too */
 	asm volatile ("sync");
 	asm volatile ("tlbie %0" : : "r" (pte->pte.eaddr) : "memory");
 	asm volatile ("sync");
 	asm volatile ("tlbsync");
-
-	pte->host_va = 0;
-
-	if (pte->pte.may_write)
-		kvm_release_pfn_dirty(pte->pfn);
-	else
-		kvm_release_pfn_clean(pte->pfn);
-}
-
-void kvmppc_mmu_pte_flush(struct kvm_vcpu *vcpu, ulong guest_ea, ulong ea_mask)
-{
-	int i;
-
-	dprintk_mmu("KVM: Flushing %d Shadow PTEs: 0x%x & 0x%x\n",
-		    vcpu->arch.hpte_cache_offset, guest_ea, ea_mask);
-	BUG_ON(vcpu->arch.hpte_cache_offset > HPTEG_CACHE_NUM);
-
-	guest_ea &= ea_mask;
-	for (i = 0; i < vcpu->arch.hpte_cache_offset; i++) {
-		struct hpte_cache *pte;
-
-		pte = &vcpu->arch.hpte_cache[i];
-		if (!pte->host_va)
-			continue;
-
-		if ((pte->pte.eaddr & ea_mask) == guest_ea) {
-			invalidate_pte(vcpu, pte);
-		}
-	}
-
-	/* Doing a complete flush -> start from scratch */
-	if (!ea_mask)
-		vcpu->arch.hpte_cache_offset = 0;
-}
-
-void kvmppc_mmu_pte_vflush(struct kvm_vcpu *vcpu, u64 guest_vp, u64 vp_mask)
-{
-	int i;
-
-	dprintk_mmu("KVM: Flushing %d Shadow vPTEs: 0x%llx & 0x%llx\n",
-		    vcpu->arch.hpte_cache_offset, guest_vp, vp_mask);
-	BUG_ON(vcpu->arch.hpte_cache_offset > HPTEG_CACHE_NUM);
-
-	guest_vp &= vp_mask;
-	for (i = 0; i < vcpu->arch.hpte_cache_offset; i++) {
-		struct hpte_cache *pte;
-
-		pte = &vcpu->arch.hpte_cache[i];
-		if (!pte->host_va)
-			continue;
-
-		if ((pte->pte.vpage & vp_mask) == guest_vp) {
-			invalidate_pte(vcpu, pte);
-		}
-	}
-}
-
-void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end)
-{
-	int i;
-
-	dprintk_mmu("KVM: Flushing %d Shadow pPTEs: 0x%llx & 0x%llx\n",
-		    vcpu->arch.hpte_cache_offset, pa_start, pa_end);
-	BUG_ON(vcpu->arch.hpte_cache_offset > HPTEG_CACHE_NUM);
-
-	for (i = 0; i < vcpu->arch.hpte_cache_offset; i++) {
-		struct hpte_cache *pte;
-
-		pte = &vcpu->arch.hpte_cache[i];
-		if (!pte->host_va)
-			continue;
-
-		if ((pte->pte.raddr >= pa_start) &&
-		    (pte->pte.raddr < pa_end)) {
-			invalidate_pte(vcpu, pte);
-		}
-	}
-}
-
-static int kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu)
-{
-	if (vcpu->arch.hpte_cache_offset == HPTEG_CACHE_NUM)
-		kvmppc_mmu_pte_flush(vcpu, 0, 0);
-
-	return vcpu->arch.hpte_cache_offset++;
 }
 
 /* We keep 512 gvsid->hvsid entries, mapping the guest ones to the array using
@@ -230,7 +144,6 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 	register int rr = 0;
 	bool primary = false;
 	bool evict = false;
-	int hpte_id;
 	struct hpte_cache *pte;
 
 	/* Get host physical address for gpa */
@@ -315,8 +228,7 @@ next_pteg:
 
 	/* Now tell our Shadow PTE code about the new page */
 
-	hpte_id = kvmppc_mmu_hpte_cache_next(vcpu);
-	pte = &vcpu->arch.hpte_cache[hpte_id];
+	pte = kvmppc_mmu_hpte_cache_next(vcpu);
 
 	dprintk_mmu("KVM: %c%c Map 0x%llx: [%lx] 0x%llx (0x%llx) -> %lx\n",
 		    orig_pte->may_write ? 'w' : '-',
@@ -329,6 +241,8 @@ next_pteg:
 	pte->pte = *orig_pte;
 	pte->pfn = hpaddr >> PAGE_SHIFT;
 
+	kvmppc_mmu_hpte_cache_map(vcpu, pte);
+
 	return 0;
 }
 
@@ -413,7 +327,7 @@ void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu)
 
 void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
 {
-	kvmppc_mmu_pte_flush(vcpu, 0, 0);
+	kvmppc_mmu_hpte_destroy(vcpu);
 	preempt_disable();
 	__destroy_context(to_book3s(vcpu)->context_id);
 	preempt_enable();
@@ -453,5 +367,7 @@ int kvmppc_mmu_init(struct kvm_vcpu *vcpu)
 	htabmask = ((sdr1 & 0x1FF) << 16) | 0xFFC0;
 	htab = (ulong)__va(sdr1 & 0xffff0000);
 
+	kvmppc_mmu_hpte_init(vcpu);
+
 	return 0;
 }
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 4ccdde1..384179a 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -47,98 +47,11 @@
 #define dprintk_slb(a, ...) do { } while(0)
 #endif
 
-static void invalidate_pte(struct hpte_cache *pte)
+void kvmppc_mmu_invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 {
-	dprintk_mmu("KVM: Flushing SPT: 0x%lx (0x%llx) -> 0x%llx\n",
-		    pte->pte.eaddr, pte->pte.vpage, pte->host_va);
-
 	ppc_md.hpte_invalidate(pte->slot, pte->host_va,
 			       MMU_PAGE_4K, MMU_SEGSIZE_256M,
 			       false);
-	pte->host_va = 0;
-
-	if (pte->pte.may_write)
-		kvm_release_pfn_dirty(pte->pfn);
-	else
-		kvm_release_pfn_clean(pte->pfn);
-}
-
-void kvmppc_mmu_pte_flush(struct kvm_vcpu *vcpu, ulong guest_ea, ulong ea_mask)
-{
-	int i;
-
-	dprintk_mmu("KVM: Flushing %d Shadow PTEs: 0x%lx & 0x%lx\n",
-		    vcpu->arch.hpte_cache_offset, guest_ea, ea_mask);
-	BUG_ON(vcpu->arch.hpte_cache_offset > HPTEG_CACHE_NUM);
-
-	guest_ea &= ea_mask;
-	for (i = 0; i < vcpu->arch.hpte_cache_offset; i++) {
-		struct hpte_cache *pte;
-
-		pte = &vcpu->arch.hpte_cache[i];
-		if (!pte->host_va)
-			continue;
-
-		if ((pte->pte.eaddr & ea_mask) == guest_ea) {
-			invalidate_pte(pte);
-		}
-	}
-
-	/* Doing a complete flush -> start from scratch */
-	if (!ea_mask)
-		vcpu->arch.hpte_cache_offset = 0;
-}
-
-void kvmppc_mmu_pte_vflush(struct kvm_vcpu *vcpu, u64 guest_vp, u64 vp_mask)
-{
-	int i;
-
-	dprintk_mmu("KVM: Flushing %d Shadow vPTEs: 0x%llx & 0x%llx\n",
-		    vcpu->arch.hpte_cache_offset, guest_vp, vp_mask);
-	BUG_ON(vcpu->arch.hpte_cache_offset > HPTEG_CACHE_NUM);
-
-	guest_vp &= vp_mask;
-	for (i = 0; i < vcpu->arch.hpte_cache_offset; i++) {
-		struct hpte_cache *pte;
-
-		pte = &vcpu->arch.hpte_cache[i];
-		if (!pte->host_va)
-			continue;
-
-		if ((pte->pte.vpage & vp_mask) == guest_vp) {
-			invalidate_pte(pte);
-		}
-	}
-}
-
-void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end)
-{
-	int i;
-
-	dprintk_mmu("KVM: Flushing %d Shadow pPTEs: 0x%lx & 0x%lx\n",
-		    vcpu->arch.hpte_cache_offset, pa_start, pa_end);
-	BUG_ON(vcpu->arch.hpte_cache_offset > HPTEG_CACHE_NUM);
-
-	for (i = 0; i < vcpu->arch.hpte_cache_offset; i++) {
-		struct hpte_cache *pte;
-
-		pte = &vcpu->arch.hpte_cache[i];
-		if (!pte->host_va)
-			continue;
-
-		if ((pte->pte.raddr >= pa_start) &&
-		    (pte->pte.raddr < pa_end)) {
-			invalidate_pte(pte);
-		}
-	}
-}
-
-static int kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu)
-{
-	if (vcpu->arch.hpte_cache_offset == HPTEG_CACHE_NUM)
-		kvmppc_mmu_pte_flush(vcpu, 0, 0);
-
-	return vcpu->arch.hpte_cache_offset++;
 }
 
 /* We keep 512 gvsid->hvsid entries, mapping the guest ones to the array using
@@ -246,8 +159,7 @@ map_again:
 		attempt++;
 		goto map_again;
 	} else {
-		int hpte_id = kvmppc_mmu_hpte_cache_next(vcpu);
-		struct hpte_cache *pte = &vcpu->arch.hpte_cache[hpte_id];
+		struct hpte_cache *pte = kvmppc_mmu_hpte_cache_next(vcpu);
 
 		dprintk_mmu("KVM: %c%c Map 0x%lx: [%lx] 0x%lx (0x%llx) -> %lx\n",
 			    ((rflags & HPTE_R_PP) == 3) ? '-' : 'w',
@@ -265,6 +177,8 @@ map_again:
 		pte->host_va = va;
 		pte->pte = *orig_pte;
 		pte->pfn = hpaddr >> PAGE_SHIFT;
+
+		kvmppc_mmu_hpte_cache_map(vcpu, pte);
 	}
 
 	return 0;
@@ -391,7 +305,7 @@ void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu)
 
 void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
 {
-	kvmppc_mmu_pte_flush(vcpu, 0, 0);
+	kvmppc_mmu_hpte_destroy(vcpu);
 	__destroy_context(to_book3s(vcpu)->context_id);
 }
 
@@ -409,5 +323,7 @@ int kvmppc_mmu_init(struct kvm_vcpu *vcpu)
 	vcpu3s->vsid_first = vcpu3s->context_id << USER_ESID_BITS;
 	vcpu3s->vsid_next = vcpu3s->vsid_first;
 
+	kvmppc_mmu_hpte_init(vcpu);
+
 	return 0;
 }
-- 
1.6.0.2
