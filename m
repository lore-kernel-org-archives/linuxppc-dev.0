Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 4160CB70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:05 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 06/26] KVM: PPC: Add tracepoints for generic spte flushes
Date: Tue, 17 Aug 2010 15:57:41 +0200
Message-Id: <1282053481-18787-7-git-send-email-agraf@suse.de>
In-Reply-To: <1282053481-18787-1-git-send-email-agraf@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
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

The different ways of flusing shadow ptes have their own debug prints which use
stupid old printk.

Let's move them to tracepoints, making them easier available, faster and
possible to activate on demand

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_mmu_hpte.c |   18 +++---------------
 arch/powerpc/kvm/trace.h           |   23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_mmu_hpte.c b/arch/powerpc/kvm/book3s_mmu_hpte.c
index 3397152..bd6a767 100644
--- a/arch/powerpc/kvm/book3s_mmu_hpte.c
+++ b/arch/powerpc/kvm/book3s_mmu_hpte.c
@@ -31,14 +31,6 @@
 
 #define PTE_SIZE	12
 
-/* #define DEBUG_MMU */
-
-#ifdef DEBUG_MMU
-#define dprintk_mmu(a, ...) printk(KERN_INFO a, __VA_ARGS__)
-#else
-#define dprintk_mmu(a, ...) do { } while(0)
-#endif
-
 static struct kmem_cache *hpte_cache;
 
 static inline u64 kvmppc_mmu_hash_pte(u64 eaddr)
@@ -186,9 +178,7 @@ static void kvmppc_mmu_pte_flush_long(struct kvm_vcpu *vcpu, ulong guest_ea)
 
 void kvmppc_mmu_pte_flush(struct kvm_vcpu *vcpu, ulong guest_ea, ulong ea_mask)
 {
-	dprintk_mmu("KVM: Flushing %d Shadow PTEs: 0x%lx & 0x%lx\n",
-		    vcpu->arch.hpte_cache_count, guest_ea, ea_mask);
-
+	trace_kvm_book3s_mmu_flush("", vcpu, guest_ea, ea_mask);
 	guest_ea &= ea_mask;
 
 	switch (ea_mask) {
@@ -251,8 +241,7 @@ static void kvmppc_mmu_pte_vflush_long(struct kvm_vcpu *vcpu, u64 guest_vp)
 
 void kvmppc_mmu_pte_vflush(struct kvm_vcpu *vcpu, u64 guest_vp, u64 vp_mask)
 {
-	dprintk_mmu("KVM: Flushing %d Shadow vPTEs: 0x%llx & 0x%llx\n",
-		    vcpu->arch.hpte_cache_count, guest_vp, vp_mask);
+	trace_kvm_book3s_mmu_flush("v", vcpu, guest_vp, vp_mask);
 	guest_vp &= vp_mask;
 
 	switch(vp_mask) {
@@ -274,8 +263,7 @@ void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end)
 	struct hpte_cache *pte;
 	int i;
 
-	dprintk_mmu("KVM: Flushing %d Shadow pPTEs: 0x%lx - 0x%lx\n",
-		    vcpu->arch.hpte_cache_count, pa_start, pa_end);
+	trace_kvm_book3s_mmu_flush("p", vcpu, pa_start, pa_end);
 
 	rcu_read_lock();
 
diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
index 4ab1c72..df15d02 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -232,6 +232,29 @@ TRACE_EVENT(kvm_book3s_mmu_invalidate,
 		  __entry->vpage, __entry->raddr, __entry->flags)
 );
 
+TRACE_EVENT(kvm_book3s_mmu_flush,
+	TP_PROTO(const char *type, struct kvm_vcpu *vcpu, unsigned long long p1,
+		 unsigned long long p2),
+	TP_ARGS(type, vcpu, p1, p2),
+
+	TP_STRUCT__entry(
+		__field(	int,			count		)
+		__field(	unsigned long long,	p1		)
+		__field(	unsigned long long,	p2		)
+		__field(	const char *,		type		)
+	),
+
+	TP_fast_assign(
+		__entry->count		= vcpu->arch.hpte_cache_count;
+		__entry->p1		= p1;
+		__entry->p2		= p2;
+		__entry->type		= type;
+	),
+
+	TP_printk("Flush %d %sPTEs: %llx - %llx",
+		  __entry->count, __entry->type, __entry->p1, __entry->p2)
+);
+
 #endif /* _TRACE_KVM_H */
 
 /* This part must be outside protection */
-- 
1.6.0.2
