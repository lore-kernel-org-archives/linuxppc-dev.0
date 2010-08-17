Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 215C6B7231
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:13 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 10/26] KVM: PPC: Move slb debugging to tracepoints
Date: Tue, 17 Aug 2010 15:57:45 +0200
Message-Id: <1282053481-18787-11-git-send-email-agraf@suse.de>
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

This patch moves debugging printks for shadow SLB debugging over to tracepoints.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_64_mmu_host.c |   22 ++--------
 arch/powerpc/kvm/trace.h              |   73 +++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index ebb1b5d..321c931 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -33,14 +33,6 @@
 #define PTE_SIZE 12
 #define VSID_ALL 0
 
-/* #define DEBUG_SLB */
-
-#ifdef DEBUG_SLB
-#define dprintk_slb(a, ...) printk(KERN_INFO a, __VA_ARGS__)
-#else
-#define dprintk_slb(a, ...) do { } while(0)
-#endif
-
 void kvmppc_mmu_invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 {
 	ppc_md.hpte_invalidate(pte->slot, pte->host_va,
@@ -66,20 +58,17 @@ static struct kvmppc_sid_map *find_sid_vsid(struct kvm_vcpu *vcpu, u64 gvsid)
 	sid_map_mask = kvmppc_sid_hash(vcpu, gvsid);
 	map = &to_book3s(vcpu)->sid_map[sid_map_mask];
 	if (map->valid && (map->guest_vsid == gvsid)) {
-		dprintk_slb("SLB: Searching: 0x%llx -> 0x%llx\n",
-			    gvsid, map->host_vsid);
+		trace_kvm_book3s_slb_found(gvsid, map->host_vsid);
 		return map;
 	}
 
 	map = &to_book3s(vcpu)->sid_map[SID_MAP_MASK - sid_map_mask];
 	if (map->valid && (map->guest_vsid == gvsid)) {
-		dprintk_slb("SLB: Searching 0x%llx -> 0x%llx\n",
-			    gvsid, map->host_vsid);
+		trace_kvm_book3s_slb_found(gvsid, map->host_vsid);
 		return map;
 	}
 
-	dprintk_slb("SLB: Searching %d/%d: 0x%llx -> not found\n",
-		    sid_map_mask, SID_MAP_MASK - sid_map_mask, gvsid);
+	trace_kvm_book3s_slb_fail(sid_map_mask, gvsid);
 	return NULL;
 }
 
@@ -205,8 +194,7 @@ static struct kvmppc_sid_map *create_sid_map(struct kvm_vcpu *vcpu, u64 gvsid)
 	map->guest_vsid = gvsid;
 	map->valid = true;
 
-	dprintk_slb("SLB: New mapping at %d: 0x%llx -> 0x%llx\n",
-		    sid_map_mask, gvsid, map->host_vsid);
+	trace_kvm_book3s_slb_map(sid_map_mask, gvsid, map->host_vsid);
 
 	return map;
 }
@@ -278,7 +266,7 @@ int kvmppc_mmu_map_segment(struct kvm_vcpu *vcpu, ulong eaddr)
 	to_svcpu(vcpu)->slb[slb_index].esid = slb_esid;
 	to_svcpu(vcpu)->slb[slb_index].vsid = slb_vsid;
 
-	dprintk_slb("slbmte %#llx, %#llx\n", slb_vsid, slb_esid);
+	trace_kvm_book3s_slbmte(slb_vsid, slb_esid);
 
 	return 0;
 }
diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
index df15d02..705c63d 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -255,6 +255,79 @@ TRACE_EVENT(kvm_book3s_mmu_flush,
 		  __entry->count, __entry->type, __entry->p1, __entry->p2)
 );
 
+TRACE_EVENT(kvm_book3s_slb_found,
+	TP_PROTO(unsigned long long gvsid, unsigned long long hvsid),
+	TP_ARGS(gvsid, hvsid),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long long,	gvsid		)
+		__field(	unsigned long long,	hvsid		)
+	),
+
+	TP_fast_assign(
+		__entry->gvsid		= gvsid;
+		__entry->hvsid		= hvsid;
+	),
+
+	TP_printk("%llx -> %llx", __entry->gvsid, __entry->hvsid)
+);
+
+TRACE_EVENT(kvm_book3s_slb_fail,
+	TP_PROTO(u16 sid_map_mask, unsigned long long gvsid),
+	TP_ARGS(sid_map_mask, gvsid),
+
+	TP_STRUCT__entry(
+		__field(	unsigned short,		sid_map_mask	)
+		__field(	unsigned long long,	gvsid		)
+	),
+
+	TP_fast_assign(
+		__entry->sid_map_mask	= sid_map_mask;
+		__entry->gvsid		= gvsid;
+	),
+
+	TP_printk("%x/%x: %llx", __entry->sid_map_mask,
+		  SID_MAP_MASK - __entry->sid_map_mask, __entry->gvsid)
+);
+
+TRACE_EVENT(kvm_book3s_slb_map,
+	TP_PROTO(u16 sid_map_mask, unsigned long long gvsid,
+		 unsigned long long hvsid),
+	TP_ARGS(sid_map_mask, gvsid, hvsid),
+
+	TP_STRUCT__entry(
+		__field(	unsigned short,		sid_map_mask	)
+		__field(	unsigned long long,	guest_vsid	)
+		__field(	unsigned long long,	host_vsid	)
+	),
+
+	TP_fast_assign(
+		__entry->sid_map_mask	= sid_map_mask;
+		__entry->guest_vsid	= gvsid;
+		__entry->host_vsid	= hvsid;
+	),
+
+	TP_printk("%x: %llx -> %llx", __entry->sid_map_mask,
+		  __entry->guest_vsid, __entry->host_vsid)
+);
+
+TRACE_EVENT(kvm_book3s_slbmte,
+	TP_PROTO(u64 slb_vsid, u64 slb_esid),
+	TP_ARGS(slb_vsid, slb_esid),
+
+	TP_STRUCT__entry(
+		__field(	u64,	slb_vsid	)
+		__field(	u64,	slb_esid	)
+	),
+
+	TP_fast_assign(
+		__entry->slb_vsid	= slb_vsid;
+		__entry->slb_esid	= slb_esid;
+	),
+
+	TP_printk("%llx, %llx", __entry->slb_vsid, __entry->slb_esid)
+);
+
 #endif /* _TRACE_KVM_H */
 
 /* This part must be outside protection */
-- 
1.6.0.2
