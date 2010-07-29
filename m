Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 7B8C81007DD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 23:04:24 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 4/7] KVM: PPC: Add book3s_32 tlbie flush acceleration
Date: Thu, 29 Jul 2010 15:04:19 +0200
Message-Id: <1280408662-10328-5-git-send-email-agraf@suse.de>
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

On Book3s_32 the tlbie instruction flushed effective addresses by the mask
0x0ffff000. This is pretty hard to reflect with a hash that hashes ~0xfff, so
to speed up that target we should also keep a special hash around for it.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_host.h |    4 +++
 arch/powerpc/kvm/book3s_mmu_hpte.c  |   40 ++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index fafc71a..bba3b9b 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -42,9 +42,11 @@
 
 #define HPTEG_CACHE_NUM			(1 << 15)
 #define HPTEG_HASH_BITS_PTE		13
+#define HPTEG_HASH_BITS_PTE_LONG	12
 #define HPTEG_HASH_BITS_VPTE		13
 #define HPTEG_HASH_BITS_VPTE_LONG	5
 #define HPTEG_HASH_NUM_PTE		(1 << HPTEG_HASH_BITS_PTE)
+#define HPTEG_HASH_NUM_PTE_LONG		(1 << HPTEG_HASH_BITS_PTE_LONG)
 #define HPTEG_HASH_NUM_VPTE		(1 << HPTEG_HASH_BITS_VPTE)
 #define HPTEG_HASH_NUM_VPTE_LONG	(1 << HPTEG_HASH_BITS_VPTE_LONG)
 
@@ -163,6 +165,7 @@ struct kvmppc_mmu {
 
 struct hpte_cache {
 	struct hlist_node list_pte;
+	struct hlist_node list_pte_long;
 	struct hlist_node list_vpte;
 	struct hlist_node list_vpte_long;
 	struct rcu_head rcu_head;
@@ -293,6 +296,7 @@ struct kvm_vcpu_arch {
 
 #ifdef CONFIG_PPC_BOOK3S
 	struct hlist_head hpte_hash_pte[HPTEG_HASH_NUM_PTE];
+	struct hlist_head hpte_hash_pte_long[HPTEG_HASH_NUM_PTE_LONG];
 	struct hlist_head hpte_hash_vpte[HPTEG_HASH_NUM_VPTE];
 	struct hlist_head hpte_hash_vpte_long[HPTEG_HASH_NUM_VPTE_LONG];
 	int hpte_cache_count;
diff --git a/arch/powerpc/kvm/book3s_mmu_hpte.c b/arch/powerpc/kvm/book3s_mmu_hpte.c
index b643893..02c64ab 100644
--- a/arch/powerpc/kvm/book3s_mmu_hpte.c
+++ b/arch/powerpc/kvm/book3s_mmu_hpte.c
@@ -45,6 +45,12 @@ static inline u64 kvmppc_mmu_hash_pte(u64 eaddr)
 	return hash_64(eaddr >> PTE_SIZE, HPTEG_HASH_BITS_PTE);
 }
 
+static inline u64 kvmppc_mmu_hash_pte_long(u64 eaddr)
+{
+	return hash_64((eaddr & 0x0ffff000) >> PTE_SIZE,
+		       HPTEG_HASH_BITS_PTE_LONG);
+}
+
 static inline u64 kvmppc_mmu_hash_vpte(u64 vpage)
 {
 	return hash_64(vpage & 0xfffffffffULL, HPTEG_HASH_BITS_VPTE);
@@ -66,6 +72,11 @@ void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 	index = kvmppc_mmu_hash_pte(pte->pte.eaddr);
 	hlist_add_head_rcu(&pte->list_pte, &vcpu->arch.hpte_hash_pte[index]);
 
+	/* Add to ePTE_long list */
+	index = kvmppc_mmu_hash_pte_long(pte->pte.eaddr);
+	hlist_add_head_rcu(&pte->list_pte_long,
+			   &vcpu->arch.hpte_hash_pte_long[index]);
+
 	/* Add to vPTE list */
 	index = kvmppc_mmu_hash_vpte(pte->pte.vpage);
 	hlist_add_head_rcu(&pte->list_vpte, &vcpu->arch.hpte_hash_vpte[index]);
@@ -99,6 +110,7 @@ static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 	spin_lock(&vcpu->arch.mmu_lock);
 
 	hlist_del_init_rcu(&pte->list_pte);
+	hlist_del_init_rcu(&pte->list_pte_long);
 	hlist_del_init_rcu(&pte->list_vpte);
 	hlist_del_init_rcu(&pte->list_vpte_long);
 
@@ -150,10 +162,28 @@ static void kvmppc_mmu_pte_flush_page(struct kvm_vcpu *vcpu, ulong guest_ea)
 	rcu_read_unlock();
 }
 
-void kvmppc_mmu_pte_flush(struct kvm_vcpu *vcpu, ulong guest_ea, ulong ea_mask)
+static void kvmppc_mmu_pte_flush_long(struct kvm_vcpu *vcpu, ulong guest_ea)
 {
-	u64 i;
+	struct hlist_head *list;
+	struct hlist_node *node;
+	struct hpte_cache *pte;
+
+	/* Find the list of entries in the map */
+	list = &vcpu->arch.hpte_hash_pte_long[
+			kvmppc_mmu_hash_pte_long(guest_ea)];
 
+	rcu_read_lock();
+
+	/* Check the list for matching entries and invalidate */
+	hlist_for_each_entry_rcu(pte, node, list, list_pte_long)
+		if ((pte->pte.eaddr & 0x0ffff000UL) == guest_ea)
+			invalidate_pte(vcpu, pte);
+
+	rcu_read_unlock();
+}
+
+void kvmppc_mmu_pte_flush(struct kvm_vcpu *vcpu, ulong guest_ea, ulong ea_mask)
+{
 	dprintk_mmu("KVM: Flushing %d Shadow PTEs: 0x%lx & 0x%lx\n",
 		    vcpu->arch.hpte_cache_count, guest_ea, ea_mask);
 
@@ -164,9 +194,7 @@ void kvmppc_mmu_pte_flush(struct kvm_vcpu *vcpu, ulong guest_ea, ulong ea_mask)
 		kvmppc_mmu_pte_flush_page(vcpu, guest_ea);
 		break;
 	case 0x0ffff000:
-		/* 32-bit flush w/o segment, go through all possible segments */
-		for (i = 0; i < 0x100000000ULL; i += 0x10000000ULL)
-			kvmppc_mmu_pte_flush(vcpu, guest_ea | i, ~0xfffUL);
+		kvmppc_mmu_pte_flush_long(vcpu, guest_ea);
 		break;
 	case 0:
 		/* Doing a complete flush -> start from scratch */
@@ -292,6 +320,8 @@ int kvmppc_mmu_hpte_init(struct kvm_vcpu *vcpu)
 	/* init hpte lookup hashes */
 	kvmppc_mmu_hpte_init_hash(vcpu->arch.hpte_hash_pte,
 				  ARRAY_SIZE(vcpu->arch.hpte_hash_pte));
+	kvmppc_mmu_hpte_init_hash(vcpu->arch.hpte_hash_pte_long,
+				  ARRAY_SIZE(vcpu->arch.hpte_hash_pte_long));
 	kvmppc_mmu_hpte_init_hash(vcpu->arch.hpte_hash_vpte,
 				  ARRAY_SIZE(vcpu->arch.hpte_hash_vpte));
 	kvmppc_mmu_hpte_init_hash(vcpu->arch.hpte_hash_vpte_long,
-- 
1.6.0.2
