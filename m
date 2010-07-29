Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 774F51007DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 23:04:24 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 2/7] KVM: PPC: RCU'ify the Book3s MMU
Date: Thu, 29 Jul 2010 15:04:17 +0200
Message-Id: <1280408662-10328-3-git-send-email-agraf@suse.de>
In-Reply-To: <1280408662-10328-1-git-send-email-agraf@suse.de>
References: <1280408662-10328-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So far we've been running all code without locking of any sort. This wasn't
really an issue because I didn't see any parallel access to the shadow MMU
code coming.

But then I started to implement dirty bitmapping to MOL which has the video
code in its own thread, so suddenly we had the dirty bitmap code run in
parallel to the shadow mmu code. And with that came trouble.

So I went ahead and made the MMU modifying functions as parallelizable as
I could think of. I hope I didn't screw up too much RCU logic :-). If you
know your way around RCU and locking and what needs to be done when, please
take a look at this patch.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_host.h |    2 +
 arch/powerpc/kvm/book3s_mmu_hpte.c  |   78 ++++++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index e1da775..fafc71a 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -165,6 +165,7 @@ struct hpte_cache {
 	struct hlist_node list_pte;
 	struct hlist_node list_vpte;
 	struct hlist_node list_vpte_long;
+	struct rcu_head rcu_head;
 	u64 host_va;
 	u64 pfn;
 	ulong slot;
@@ -295,6 +296,7 @@ struct kvm_vcpu_arch {
 	struct hlist_head hpte_hash_vpte[HPTEG_HASH_NUM_VPTE];
 	struct hlist_head hpte_hash_vpte_long[HPTEG_HASH_NUM_VPTE_LONG];
 	int hpte_cache_count;
+	spinlock_t mmu_lock;
 #endif
 };
 
diff --git a/arch/powerpc/kvm/book3s_mmu_hpte.c b/arch/powerpc/kvm/book3s_mmu_hpte.c
index 4868d4a..b643893 100644
--- a/arch/powerpc/kvm/book3s_mmu_hpte.c
+++ b/arch/powerpc/kvm/book3s_mmu_hpte.c
@@ -60,68 +60,94 @@ void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 {
 	u64 index;
 
+	spin_lock(&vcpu->arch.mmu_lock);
+
 	/* Add to ePTE list */
 	index = kvmppc_mmu_hash_pte(pte->pte.eaddr);
-	hlist_add_head(&pte->list_pte, &vcpu->arch.hpte_hash_pte[index]);
+	hlist_add_head_rcu(&pte->list_pte, &vcpu->arch.hpte_hash_pte[index]);
 
 	/* Add to vPTE list */
 	index = kvmppc_mmu_hash_vpte(pte->pte.vpage);
-	hlist_add_head(&pte->list_vpte, &vcpu->arch.hpte_hash_vpte[index]);
+	hlist_add_head_rcu(&pte->list_vpte, &vcpu->arch.hpte_hash_vpte[index]);
 
 	/* Add to vPTE_long list */
 	index = kvmppc_mmu_hash_vpte_long(pte->pte.vpage);
-	hlist_add_head(&pte->list_vpte_long,
-		       &vcpu->arch.hpte_hash_vpte_long[index]);
+	hlist_add_head_rcu(&pte->list_vpte_long,
+			   &vcpu->arch.hpte_hash_vpte_long[index]);
+
+	spin_unlock(&vcpu->arch.mmu_lock);
+}
+
+static void free_pte_rcu(struct rcu_head *head)
+{
+	struct hpte_cache *pte = container_of(head, struct hpte_cache, rcu_head);
+	kmem_cache_free(hpte_cache, pte);
 }
 
 static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 {
+	/* pte already invalidated? */
+	if (hlist_unhashed(&pte->list_pte))
+		return;
+
 	dprintk_mmu("KVM: Flushing SPT: 0x%lx (0x%llx) -> 0x%llx\n",
 		    pte->pte.eaddr, pte->pte.vpage, pte->host_va);
 
 	/* Different for 32 and 64 bit */
 	kvmppc_mmu_invalidate_pte(vcpu, pte);
 
+	spin_lock(&vcpu->arch.mmu_lock);
+
+	hlist_del_init_rcu(&pte->list_pte);
+	hlist_del_init_rcu(&pte->list_vpte);
+	hlist_del_init_rcu(&pte->list_vpte_long);
+
+	spin_unlock(&vcpu->arch.mmu_lock);
+
 	if (pte->pte.may_write)
 		kvm_release_pfn_dirty(pte->pfn);
 	else
 		kvm_release_pfn_clean(pte->pfn);
 
-	hlist_del(&pte->list_pte);
-	hlist_del(&pte->list_vpte);
-	hlist_del(&pte->list_vpte_long);
-
 	vcpu->arch.hpte_cache_count--;
-	kmem_cache_free(hpte_cache, pte);
+	call_rcu(&pte->rcu_head, free_pte_rcu);
 }
 
 static void kvmppc_mmu_pte_flush_all(struct kvm_vcpu *vcpu)
 {
 	struct hpte_cache *pte;
-	struct hlist_node *node, *tmp;
+	struct hlist_node *node;
 	int i;
 
+	rcu_read_lock();
+
 	for (i = 0; i < HPTEG_HASH_NUM_VPTE_LONG; i++) {
 		struct hlist_head *list = &vcpu->arch.hpte_hash_vpte_long[i];
 
-		hlist_for_each_entry_safe(pte, node, tmp, list, list_vpte_long)
+		hlist_for_each_entry_rcu(pte, node, list, list_vpte_long)
 			invalidate_pte(vcpu, pte);
 	}
+
+	rcu_read_unlock();
 }
 
 static void kvmppc_mmu_pte_flush_page(struct kvm_vcpu *vcpu, ulong guest_ea)
 {
 	struct hlist_head *list;
-	struct hlist_node *node, *tmp;
+	struct hlist_node *node;
 	struct hpte_cache *pte;
 
 	/* Find the list of entries in the map */
 	list = &vcpu->arch.hpte_hash_pte[kvmppc_mmu_hash_pte(guest_ea)];
 
+	rcu_read_lock();
+
 	/* Check the list for matching entries and invalidate */
-	hlist_for_each_entry_safe(pte, node, tmp, list, list_pte)
+	hlist_for_each_entry_rcu(pte, node, list, list_pte)
 		if ((pte->pte.eaddr & ~0xfffUL) == guest_ea)
 			invalidate_pte(vcpu, pte);
+
+	rcu_read_unlock();
 }
 
 void kvmppc_mmu_pte_flush(struct kvm_vcpu *vcpu, ulong guest_ea, ulong ea_mask)
@@ -156,33 +182,41 @@ void kvmppc_mmu_pte_flush(struct kvm_vcpu *vcpu, ulong guest_ea, ulong ea_mask)
 static void kvmppc_mmu_pte_vflush_short(struct kvm_vcpu *vcpu, u64 guest_vp)
 {
 	struct hlist_head *list;
-	struct hlist_node *node, *tmp;
+	struct hlist_node *node;
 	struct hpte_cache *pte;
 	u64 vp_mask = 0xfffffffffULL;
 
 	list = &vcpu->arch.hpte_hash_vpte[kvmppc_mmu_hash_vpte(guest_vp)];
 
+	rcu_read_lock();
+
 	/* Check the list for matching entries and invalidate */
-	hlist_for_each_entry_safe(pte, node, tmp, list, list_vpte)
+	hlist_for_each_entry_rcu(pte, node, list, list_vpte)
 		if ((pte->pte.vpage & vp_mask) == guest_vp)
 			invalidate_pte(vcpu, pte);
+
+	rcu_read_unlock();
 }
 
 /* Flush with mask 0xffffff000 */
 static void kvmppc_mmu_pte_vflush_long(struct kvm_vcpu *vcpu, u64 guest_vp)
 {
 	struct hlist_head *list;
-	struct hlist_node *node, *tmp;
+	struct hlist_node *node;
 	struct hpte_cache *pte;
 	u64 vp_mask = 0xffffff000ULL;
 
 	list = &vcpu->arch.hpte_hash_vpte_long[
 		kvmppc_mmu_hash_vpte_long(guest_vp)];
 
+	rcu_read_lock();
+
 	/* Check the list for matching entries and invalidate */
-	hlist_for_each_entry_safe(pte, node, tmp, list, list_vpte_long)
+	hlist_for_each_entry_rcu(pte, node, list, list_vpte_long)
 		if ((pte->pte.vpage & vp_mask) == guest_vp)
 			invalidate_pte(vcpu, pte);
+
+	rcu_read_unlock();
 }
 
 void kvmppc_mmu_pte_vflush(struct kvm_vcpu *vcpu, u64 guest_vp, u64 vp_mask)
@@ -206,21 +240,25 @@ void kvmppc_mmu_pte_vflush(struct kvm_vcpu *vcpu, u64 guest_vp, u64 vp_mask)
 
 void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end)
 {
-	struct hlist_node *node, *tmp;
+	struct hlist_node *node;
 	struct hpte_cache *pte;
 	int i;
 
 	dprintk_mmu("KVM: Flushing %d Shadow pPTEs: 0x%lx - 0x%lx\n",
 		    vcpu->arch.hpte_cache_count, pa_start, pa_end);
 
+	rcu_read_lock();
+
 	for (i = 0; i < HPTEG_HASH_NUM_VPTE_LONG; i++) {
 		struct hlist_head *list = &vcpu->arch.hpte_hash_vpte_long[i];
 
-		hlist_for_each_entry_safe(pte, node, tmp, list, list_vpte_long)
+		hlist_for_each_entry_rcu(pte, node, list, list_vpte_long)
 			if ((pte->pte.raddr >= pa_start) &&
 			    (pte->pte.raddr < pa_end))
 				invalidate_pte(vcpu, pte);
 	}
+
+	rcu_read_unlock();
 }
 
 struct hpte_cache *kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu)
@@ -259,6 +297,8 @@ int kvmppc_mmu_hpte_init(struct kvm_vcpu *vcpu)
 	kvmppc_mmu_hpte_init_hash(vcpu->arch.hpte_hash_vpte_long,
 				  ARRAY_SIZE(vcpu->arch.hpte_hash_vpte_long));
 
+	spin_lock_init(&vcpu->arch.mmu_lock);
+
 	return 0;
 }
 
-- 
1.6.0.2
