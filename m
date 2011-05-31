Return-Path: <paulus@ozlabs.org>
Date: Tue, 31 May 2011 16:42:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH v2 01/12] kvm/powerpc: Move fields between struct
	kvm_vcpu_arch and kvmppc_vcpu_book3s
Message-ID: <20110531064237.GB2533@brick.ozlabs.ibm.com>
References: <20110531064028.GA2533@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110531064028.GA2533@brick.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the slb field, which represents the state of the emulated
SLB, from the kvmppc_vcpu_book3s struct to the kvm_vcpu_arch, and the
hpte_hash_[v]pte[_long] fields from kvm_vcpu_arch to kvmppc_vcpu_book3s.
This is in accord with the principle that the kvm_vcpu_arch struct
represents the state of the emulated CPU, and the kvmppc_vcpu_book3s
struct holds the auxiliary data structures used in the emulation.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s.h |   35 +++++++++-------
 arch/powerpc/include/asm/kvm_host.h   |   34 +++++++---------
 arch/powerpc/kvm/book3s.c             |    9 ++--
 arch/powerpc/kvm/book3s_64_mmu.c      |   54 +++++++++++-------------
 arch/powerpc/kvm/book3s_mmu_hpte.c    |   71 +++++++++++++++++++-------------
 arch/powerpc/kvm/trace.h              |    2 +-
 6 files changed, 107 insertions(+), 98 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index d62e703..e1e8d43 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -24,20 +24,6 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_book3s_asm.h>
 
-struct kvmppc_slb {
-	u64 esid;
-	u64 vsid;
-	u64 orige;
-	u64 origv;
-	bool valid	: 1;
-	bool Ks		: 1;
-	bool Kp		: 1;
-	bool nx		: 1;
-	bool large	: 1;	/* PTEs are 16MB */
-	bool tb		: 1;	/* 1TB segment */
-	bool class	: 1;
-};
-
 struct kvmppc_bat {
 	u64 raw;
 	u32 bepi;
@@ -67,11 +53,22 @@ struct kvmppc_sid_map {
 #define VSID_POOL_SIZE	(SID_CONTEXTS * 16)
 #endif
 
+struct hpte_cache {
+	struct hlist_node list_pte;
+	struct hlist_node list_pte_long;
+	struct hlist_node list_vpte;
+	struct hlist_node list_vpte_long;
+	struct rcu_head rcu_head;
+	u64 host_va;
+	u64 pfn;
+	ulong slot;
+	struct kvmppc_pte pte;
+};
+
 struct kvmppc_vcpu_book3s {
 	struct kvm_vcpu vcpu;
 	struct kvmppc_book3s_shadow_vcpu *shadow_vcpu;
 	struct kvmppc_sid_map sid_map[SID_MAP_NUM];
-	struct kvmppc_slb slb[64];
 	struct {
 		u64 esid;
 		u64 vsid;
@@ -81,7 +78,6 @@ struct kvmppc_vcpu_book3s {
 	struct kvmppc_bat dbat[8];
 	u64 hid[6];
 	u64 gqr[8];
-	int slb_nr;
 	u64 sdr1;
 	u64 hior;
 	u64 msr_mask;
@@ -94,6 +90,13 @@ struct kvmppc_vcpu_book3s {
 #endif
 	int context_id[SID_CONTEXTS];
 	ulong prog_flags; /* flags to inject when giving a 700 trap */
+
+	struct hlist_head hpte_hash_pte[HPTEG_HASH_NUM_PTE];
+	struct hlist_head hpte_hash_pte_long[HPTEG_HASH_NUM_PTE_LONG];
+	struct hlist_head hpte_hash_vpte[HPTEG_HASH_NUM_VPTE];
+	struct hlist_head hpte_hash_vpte_long[HPTEG_HASH_NUM_VPTE_LONG];
+	int hpte_cache_count;
+	spinlock_t mmu_lock;
 };
 
 #define CONTEXT_HOST		0
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 186f150..8bb47e0 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -163,16 +163,18 @@ struct kvmppc_mmu {
 	bool (*is_dcbz32)(struct kvm_vcpu *vcpu);
 };
 
-struct hpte_cache {
-	struct hlist_node list_pte;
-	struct hlist_node list_pte_long;
-	struct hlist_node list_vpte;
-	struct hlist_node list_vpte_long;
-	struct rcu_head rcu_head;
-	u64 host_va;
-	u64 pfn;
-	ulong slot;
-	struct kvmppc_pte pte;
+struct kvmppc_slb {
+	u64 esid;
+	u64 vsid;
+	u64 orige;
+	u64 origv;
+	bool valid	: 1;
+	bool Ks		: 1;
+	bool Kp		: 1;
+	bool nx		: 1;
+	bool large	: 1;	/* PTEs are 16MB */
+	bool tb		: 1;	/* 1TB segment */
+	bool class	: 1;
 };
 
 struct kvm_vcpu_arch {
@@ -187,6 +189,9 @@ struct kvm_vcpu_arch {
 	ulong highmem_handler;
 	ulong rmcall;
 	ulong host_paca_phys;
+	struct kvmppc_slb slb[64];
+	int slb_max;		/* # valid entries in slb[] */
+	int slb_nr;		/* total number of entries in SLB */
 	struct kvmppc_mmu mmu;
 #endif
 
@@ -298,15 +303,6 @@ struct kvm_vcpu_arch {
 	struct kvm_vcpu_arch_shared *shared;
 	unsigned long magic_page_pa; /* phys addr to map the magic page to */
 	unsigned long magic_page_ea; /* effect. addr to map the magic page to */
-
-#ifdef CONFIG_PPC_BOOK3S
-	struct hlist_head hpte_hash_pte[HPTEG_HASH_NUM_PTE];
-	struct hlist_head hpte_hash_pte_long[HPTEG_HASH_NUM_PTE_LONG];
-	struct hlist_head hpte_hash_vpte[HPTEG_HASH_NUM_VPTE];
-	struct hlist_head hpte_hash_vpte_long[HPTEG_HASH_NUM_VPTE_LONG];
-	int hpte_cache_count;
-	spinlock_t mmu_lock;
-#endif
 };
 
 #endif /* __POWERPC_KVM_HOST_H__ */
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 0f95b5c..0c3820e 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -17,7 +17,6 @@
 #include <linux/kvm_host.h>
 #include <linux/err.h>
 #include <linux/slab.h>
-#include "trace.h"
 
 #include <asm/reg.h>
 #include <asm/cputable.h>
@@ -33,6 +32,8 @@
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
 
+#include "trace.h"
+
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
 
 /* #define EXIT_DEBUG */
@@ -1190,8 +1191,8 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 	sregs->u.s.sdr1 = to_book3s(vcpu)->sdr1;
 	if (vcpu->arch.hflags & BOOK3S_HFLAG_SLB) {
 		for (i = 0; i < 64; i++) {
-			sregs->u.s.ppc64.slb[i].slbe = vcpu3s->slb[i].orige | i;
-			sregs->u.s.ppc64.slb[i].slbv = vcpu3s->slb[i].origv;
+			sregs->u.s.ppc64.slb[i].slbe = vcpu->arch.slb[i].orige | i;
+			sregs->u.s.ppc64.slb[i].slbv = vcpu->arch.slb[i].origv;
 		}
 	} else {
 		for (i = 0; i < 16; i++)
@@ -1339,7 +1340,7 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	vcpu->arch.pvr = 0x84202;
 #endif
 	kvmppc_set_pvr(vcpu, vcpu->arch.pvr);
-	vcpu_book3s->slb_nr = 64;
+	vcpu->arch.slb_nr = 64;
 
 	/* remember where some real-mode handlers are */
 	vcpu->arch.trampoline_lowmem = kvmppc_trampoline_lowmem;
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index d7889ef..c6d3e19 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -41,36 +41,36 @@ static void kvmppc_mmu_book3s_64_reset_msr(struct kvm_vcpu *vcpu)
 }
 
 static struct kvmppc_slb *kvmppc_mmu_book3s_64_find_slbe(
-				struct kvmppc_vcpu_book3s *vcpu_book3s,
+				struct kvm_vcpu *vcpu,
 				gva_t eaddr)
 {
 	int i;
 	u64 esid = GET_ESID(eaddr);
 	u64 esid_1t = GET_ESID_1T(eaddr);
 
-	for (i = 0; i < vcpu_book3s->slb_nr; i++) {
+	for (i = 0; i < vcpu->arch.slb_nr; i++) {
 		u64 cmp_esid = esid;
 
-		if (!vcpu_book3s->slb[i].valid)
+		if (!vcpu->arch.slb[i].valid)
 			continue;
 
-		if (vcpu_book3s->slb[i].tb)
+		if (vcpu->arch.slb[i].tb)
 			cmp_esid = esid_1t;
 
-		if (vcpu_book3s->slb[i].esid == cmp_esid)
-			return &vcpu_book3s->slb[i];
+		if (vcpu->arch.slb[i].esid == cmp_esid)
+			return &vcpu->arch.slb[i];
 	}
 
 	dprintk("KVM: No SLB entry found for 0x%lx [%llx | %llx]\n",
 		eaddr, esid, esid_1t);
-	for (i = 0; i < vcpu_book3s->slb_nr; i++) {
-	    if (vcpu_book3s->slb[i].vsid)
+	for (i = 0; i < vcpu->arch.slb_nr; i++) {
+	    if (vcpu->arch.slb[i].vsid)
 		dprintk("  %d: %c%c%c %llx %llx\n", i,
-			vcpu_book3s->slb[i].valid ? 'v' : ' ',
-			vcpu_book3s->slb[i].large ? 'l' : ' ',
-			vcpu_book3s->slb[i].tb    ? 't' : ' ',
-			vcpu_book3s->slb[i].esid,
-			vcpu_book3s->slb[i].vsid);
+			vcpu->arch.slb[i].valid ? 'v' : ' ',
+			vcpu->arch.slb[i].large ? 'l' : ' ',
+			vcpu->arch.slb[i].tb    ? 't' : ' ',
+			vcpu->arch.slb[i].esid,
+			vcpu->arch.slb[i].vsid);
 	}
 
 	return NULL;
@@ -81,7 +81,7 @@ static u64 kvmppc_mmu_book3s_64_ea_to_vp(struct kvm_vcpu *vcpu, gva_t eaddr,
 {
 	struct kvmppc_slb *slb;
 
-	slb = kvmppc_mmu_book3s_64_find_slbe(to_book3s(vcpu), eaddr);
+	slb = kvmppc_mmu_book3s_64_find_slbe(vcpu, eaddr);
 	if (!slb)
 		return 0;
 
@@ -180,7 +180,7 @@ static int kvmppc_mmu_book3s_64_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 		return 0;
 	}
 
-	slbe = kvmppc_mmu_book3s_64_find_slbe(vcpu_book3s, eaddr);
+	slbe = kvmppc_mmu_book3s_64_find_slbe(vcpu, eaddr);
 	if (!slbe)
 		goto no_seg_found;
 
@@ -320,10 +320,10 @@ static void kvmppc_mmu_book3s_64_slbmte(struct kvm_vcpu *vcpu, u64 rs, u64 rb)
 	esid_1t = GET_ESID_1T(rb);
 	slb_nr = rb & 0xfff;
 
-	if (slb_nr > vcpu_book3s->slb_nr)
+	if (slb_nr > vcpu->arch.slb_nr)
 		return;
 
-	slbe = &vcpu_book3s->slb[slb_nr];
+	slbe = &vcpu->arch.slb[slb_nr];
 
 	slbe->large = (rs & SLB_VSID_L) ? 1 : 0;
 	slbe->tb    = (rs & SLB_VSID_B_1T) ? 1 : 0;
@@ -344,38 +344,35 @@ static void kvmppc_mmu_book3s_64_slbmte(struct kvm_vcpu *vcpu, u64 rs, u64 rb)
 
 static u64 kvmppc_mmu_book3s_64_slbmfee(struct kvm_vcpu *vcpu, u64 slb_nr)
 {
-	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
 	struct kvmppc_slb *slbe;
 
-	if (slb_nr > vcpu_book3s->slb_nr)
+	if (slb_nr > vcpu->arch.slb_nr)
 		return 0;
 
-	slbe = &vcpu_book3s->slb[slb_nr];
+	slbe = &vcpu->arch.slb[slb_nr];
 
 	return slbe->orige;
 }
 
 static u64 kvmppc_mmu_book3s_64_slbmfev(struct kvm_vcpu *vcpu, u64 slb_nr)
 {
-	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
 	struct kvmppc_slb *slbe;
 
-	if (slb_nr > vcpu_book3s->slb_nr)
+	if (slb_nr > vcpu->arch.slb_nr)
 		return 0;
 
-	slbe = &vcpu_book3s->slb[slb_nr];
+	slbe = &vcpu->arch.slb[slb_nr];
 
 	return slbe->origv;
 }
 
 static void kvmppc_mmu_book3s_64_slbie(struct kvm_vcpu *vcpu, u64 ea)
 {
-	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
 	struct kvmppc_slb *slbe;
 
 	dprintk("KVM MMU: slbie(0x%llx)\n", ea);
 
-	slbe = kvmppc_mmu_book3s_64_find_slbe(vcpu_book3s, ea);
+	slbe = kvmppc_mmu_book3s_64_find_slbe(vcpu, ea);
 
 	if (!slbe)
 		return;
@@ -389,13 +386,12 @@ static void kvmppc_mmu_book3s_64_slbie(struct kvm_vcpu *vcpu, u64 ea)
 
 static void kvmppc_mmu_book3s_64_slbia(struct kvm_vcpu *vcpu)
 {
-	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
 	int i;
 
 	dprintk("KVM MMU: slbia()\n");
 
-	for (i = 1; i < vcpu_book3s->slb_nr; i++)
-		vcpu_book3s->slb[i].valid = false;
+	for (i = 1; i < vcpu->arch.slb_nr; i++)
+		vcpu->arch.slb[i].valid = false;
 
 	if (vcpu->arch.shared->msr & MSR_IR) {
 		kvmppc_mmu_flush_segments(vcpu);
@@ -464,7 +460,7 @@ static int kvmppc_mmu_book3s_64_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 	ulong mp_ea = vcpu->arch.magic_page_ea;
 
 	if (vcpu->arch.shared->msr & (MSR_DR|MSR_IR)) {
-		slb = kvmppc_mmu_book3s_64_find_slbe(to_book3s(vcpu), ea);
+		slb = kvmppc_mmu_book3s_64_find_slbe(vcpu, ea);
 		if (slb)
 			gvsid = slb->vsid;
 	}
diff --git a/arch/powerpc/kvm/book3s_mmu_hpte.c b/arch/powerpc/kvm/book3s_mmu_hpte.c
index 79751d8..41cb001 100644
--- a/arch/powerpc/kvm/book3s_mmu_hpte.c
+++ b/arch/powerpc/kvm/book3s_mmu_hpte.c
@@ -21,7 +21,6 @@
 #include <linux/kvm_host.h>
 #include <linux/hash.h>
 #include <linux/slab.h>
-#include "trace.h"
 
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
@@ -29,6 +28,8 @@
 #include <asm/mmu_context.h>
 #include <asm/hw_irq.h>
 
+#include "trace.h"
+
 #define PTE_SIZE	12
 
 static struct kmem_cache *hpte_cache;
@@ -58,30 +59,31 @@ static inline u64 kvmppc_mmu_hash_vpte_long(u64 vpage)
 void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 {
 	u64 index;
+	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 
 	trace_kvm_book3s_mmu_map(pte);
 
-	spin_lock(&vcpu->arch.mmu_lock);
+	spin_lock(&vcpu3s->mmu_lock);
 
 	/* Add to ePTE list */
 	index = kvmppc_mmu_hash_pte(pte->pte.eaddr);
-	hlist_add_head_rcu(&pte->list_pte, &vcpu->arch.hpte_hash_pte[index]);
+	hlist_add_head_rcu(&pte->list_pte, &vcpu3s->hpte_hash_pte[index]);
 
 	/* Add to ePTE_long list */
 	index = kvmppc_mmu_hash_pte_long(pte->pte.eaddr);
 	hlist_add_head_rcu(&pte->list_pte_long,
-			   &vcpu->arch.hpte_hash_pte_long[index]);
+			   &vcpu3s->hpte_hash_pte_long[index]);
 
 	/* Add to vPTE list */
 	index = kvmppc_mmu_hash_vpte(pte->pte.vpage);
-	hlist_add_head_rcu(&pte->list_vpte, &vcpu->arch.hpte_hash_vpte[index]);
+	hlist_add_head_rcu(&pte->list_vpte, &vcpu3s->hpte_hash_vpte[index]);
 
 	/* Add to vPTE_long list */
 	index = kvmppc_mmu_hash_vpte_long(pte->pte.vpage);
 	hlist_add_head_rcu(&pte->list_vpte_long,
-			   &vcpu->arch.hpte_hash_vpte_long[index]);
+			   &vcpu3s->hpte_hash_vpte_long[index]);
 
-	spin_unlock(&vcpu->arch.mmu_lock);
+	spin_unlock(&vcpu3s->mmu_lock);
 }
 
 static void free_pte_rcu(struct rcu_head *head)
@@ -92,16 +94,18 @@ static void free_pte_rcu(struct rcu_head *head)
 
 static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 {
+	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
+
 	trace_kvm_book3s_mmu_invalidate(pte);
 
 	/* Different for 32 and 64 bit */
 	kvmppc_mmu_invalidate_pte(vcpu, pte);
 
-	spin_lock(&vcpu->arch.mmu_lock);
+	spin_lock(&vcpu3s->mmu_lock);
 
 	/* pte already invalidated in between? */
 	if (hlist_unhashed(&pte->list_pte)) {
-		spin_unlock(&vcpu->arch.mmu_lock);
+		spin_unlock(&vcpu3s->mmu_lock);
 		return;
 	}
 
@@ -115,14 +119,15 @@ static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 	else
 		kvm_release_pfn_clean(pte->pfn);
 
-	spin_unlock(&vcpu->arch.mmu_lock);
+	spin_unlock(&vcpu3s->mmu_lock);
 
-	vcpu->arch.hpte_cache_count--;
+	vcpu3s->hpte_cache_count--;
 	call_rcu(&pte->rcu_head, free_pte_rcu);
 }
 
 static void kvmppc_mmu_pte_flush_all(struct kvm_vcpu *vcpu)
 {
+	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 	struct hpte_cache *pte;
 	struct hlist_node *node;
 	int i;
@@ -130,7 +135,7 @@ static void kvmppc_mmu_pte_flush_all(struct kvm_vcpu *vcpu)
 	rcu_read_lock();
 
 	for (i = 0; i < HPTEG_HASH_NUM_VPTE_LONG; i++) {
-		struct hlist_head *list = &vcpu->arch.hpte_hash_vpte_long[i];
+		struct hlist_head *list = &vcpu3s->hpte_hash_vpte_long[i];
 
 		hlist_for_each_entry_rcu(pte, node, list, list_vpte_long)
 			invalidate_pte(vcpu, pte);
@@ -141,12 +146,13 @@ static void kvmppc_mmu_pte_flush_all(struct kvm_vcpu *vcpu)
 
 static void kvmppc_mmu_pte_flush_page(struct kvm_vcpu *vcpu, ulong guest_ea)
 {
+	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 	struct hlist_head *list;
 	struct hlist_node *node;
 	struct hpte_cache *pte;
 
 	/* Find the list of entries in the map */
-	list = &vcpu->arch.hpte_hash_pte[kvmppc_mmu_hash_pte(guest_ea)];
+	list = &vcpu3s->hpte_hash_pte[kvmppc_mmu_hash_pte(guest_ea)];
 
 	rcu_read_lock();
 
@@ -160,12 +166,13 @@ static void kvmppc_mmu_pte_flush_page(struct kvm_vcpu *vcpu, ulong guest_ea)
 
 static void kvmppc_mmu_pte_flush_long(struct kvm_vcpu *vcpu, ulong guest_ea)
 {
+	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 	struct hlist_head *list;
 	struct hlist_node *node;
 	struct hpte_cache *pte;
 
 	/* Find the list of entries in the map */
-	list = &vcpu->arch.hpte_hash_pte_long[
+	list = &vcpu3s->hpte_hash_pte_long[
 			kvmppc_mmu_hash_pte_long(guest_ea)];
 
 	rcu_read_lock();
@@ -203,12 +210,13 @@ void kvmppc_mmu_pte_flush(struct kvm_vcpu *vcpu, ulong guest_ea, ulong ea_mask)
 /* Flush with mask 0xfffffffff */
 static void kvmppc_mmu_pte_vflush_short(struct kvm_vcpu *vcpu, u64 guest_vp)
 {
+	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 	struct hlist_head *list;
 	struct hlist_node *node;
 	struct hpte_cache *pte;
 	u64 vp_mask = 0xfffffffffULL;
 
-	list = &vcpu->arch.hpte_hash_vpte[kvmppc_mmu_hash_vpte(guest_vp)];
+	list = &vcpu3s->hpte_hash_vpte[kvmppc_mmu_hash_vpte(guest_vp)];
 
 	rcu_read_lock();
 
@@ -223,12 +231,13 @@ static void kvmppc_mmu_pte_vflush_short(struct kvm_vcpu *vcpu, u64 guest_vp)
 /* Flush with mask 0xffffff000 */
 static void kvmppc_mmu_pte_vflush_long(struct kvm_vcpu *vcpu, u64 guest_vp)
 {
+	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 	struct hlist_head *list;
 	struct hlist_node *node;
 	struct hpte_cache *pte;
 	u64 vp_mask = 0xffffff000ULL;
 
-	list = &vcpu->arch.hpte_hash_vpte_long[
+	list = &vcpu3s->hpte_hash_vpte_long[
 		kvmppc_mmu_hash_vpte_long(guest_vp)];
 
 	rcu_read_lock();
@@ -261,6 +270,7 @@ void kvmppc_mmu_pte_vflush(struct kvm_vcpu *vcpu, u64 guest_vp, u64 vp_mask)
 
 void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end)
 {
+	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 	struct hlist_node *node;
 	struct hpte_cache *pte;
 	int i;
@@ -270,7 +280,7 @@ void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end)
 	rcu_read_lock();
 
 	for (i = 0; i < HPTEG_HASH_NUM_VPTE_LONG; i++) {
-		struct hlist_head *list = &vcpu->arch.hpte_hash_vpte_long[i];
+		struct hlist_head *list = &vcpu3s->hpte_hash_vpte_long[i];
 
 		hlist_for_each_entry_rcu(pte, node, list, list_vpte_long)
 			if ((pte->pte.raddr >= pa_start) &&
@@ -283,12 +293,13 @@ void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end)
 
 struct hpte_cache *kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu)
 {
+	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 	struct hpte_cache *pte;
 
 	pte = kmem_cache_zalloc(hpte_cache, GFP_KERNEL);
-	vcpu->arch.hpte_cache_count++;
+	vcpu3s->hpte_cache_count++;
 
-	if (vcpu->arch.hpte_cache_count == HPTEG_CACHE_NUM)
+	if (vcpu3s->hpte_cache_count == HPTEG_CACHE_NUM)
 		kvmppc_mmu_pte_flush_all(vcpu);
 
 	return pte;
@@ -309,17 +320,19 @@ static void kvmppc_mmu_hpte_init_hash(struct hlist_head *hash_list, int len)
 
 int kvmppc_mmu_hpte_init(struct kvm_vcpu *vcpu)
 {
+	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
+
 	/* init hpte lookup hashes */
-	kvmppc_mmu_hpte_init_hash(vcpu->arch.hpte_hash_pte,
-				  ARRAY_SIZE(vcpu->arch.hpte_hash_pte));
-	kvmppc_mmu_hpte_init_hash(vcpu->arch.hpte_hash_pte_long,
-				  ARRAY_SIZE(vcpu->arch.hpte_hash_pte_long));
-	kvmppc_mmu_hpte_init_hash(vcpu->arch.hpte_hash_vpte,
-				  ARRAY_SIZE(vcpu->arch.hpte_hash_vpte));
-	kvmppc_mmu_hpte_init_hash(vcpu->arch.hpte_hash_vpte_long,
-				  ARRAY_SIZE(vcpu->arch.hpte_hash_vpte_long));
-
-	spin_lock_init(&vcpu->arch.mmu_lock);
+	kvmppc_mmu_hpte_init_hash(vcpu3s->hpte_hash_pte,
+				  ARRAY_SIZE(vcpu3s->hpte_hash_pte));
+	kvmppc_mmu_hpte_init_hash(vcpu3s->hpte_hash_pte_long,
+				  ARRAY_SIZE(vcpu3s->hpte_hash_pte_long));
+	kvmppc_mmu_hpte_init_hash(vcpu3s->hpte_hash_vpte,
+				  ARRAY_SIZE(vcpu3s->hpte_hash_vpte));
+	kvmppc_mmu_hpte_init_hash(vcpu3s->hpte_hash_vpte_long,
+				  ARRAY_SIZE(vcpu3s->hpte_hash_vpte_long));
+
+	spin_lock_init(&vcpu3s->mmu_lock);
 
 	return 0;
 }
diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
index 3aca1b0..d62a14b 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -252,7 +252,7 @@ TRACE_EVENT(kvm_book3s_mmu_flush,
 	),
 
 	TP_fast_assign(
-		__entry->count		= vcpu->arch.hpte_cache_count;
+		__entry->count		= to_book3s(vcpu)->hpte_cache_count;
 		__entry->p1		= p1;
 		__entry->p2		= p2;
 		__entry->type		= type;
-- 
1.7.5.3
