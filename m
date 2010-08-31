Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1626EB710A
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:21 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 04/35] KVM: PPC: Move pte invalidate debug code to tracepoint
Date: Tue, 31 Aug 2010 04:31:45 +0200
Message-Id: <1283221937-21006-5-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch moves the SPTE flush debug printk over to tracepoints.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_mmu_hpte.c |    3 +--
 arch/powerpc/kvm/trace.h           |   29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_mmu_hpte.c b/arch/powerpc/kvm/book3s_mmu_hpte.c
index ac94bd9..3397152 100644
--- a/arch/powerpc/kvm/book3s_mmu_hpte.c
+++ b/arch/powerpc/kvm/book3s_mmu_hpte.c
@@ -104,8 +104,7 @@ static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 	if (hlist_unhashed(&pte->list_pte))
 		return;
 
-	dprintk_mmu("KVM: Flushing SPT: 0x%lx (0x%llx) -> 0x%llx\n",
-		    pte->pte.eaddr, pte->pte.vpage, pte->host_va);
+	trace_kvm_book3s_mmu_invalidate(pte);
 
 	/* Different for 32 and 64 bit */
 	kvmppc_mmu_invalidate_pte(vcpu, pte);
diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
index 68a8444..06ad93e 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -210,6 +210,35 @@ TRACE_EVENT(kvm_book3s_mmu_map,
 		  __entry->vpage, __entry->raddr, __entry->flags)
 );
 
+TRACE_EVENT(kvm_book3s_mmu_invalidate,
+	TP_PROTO(struct hpte_cache *pte),
+	TP_ARGS(pte),
+
+	TP_STRUCT__entry(
+		__field(	u64,		host_va		)
+		__field(	u64,		pfn		)
+		__field(	ulong,		eaddr		)
+		__field(	u64,		vpage		)
+		__field(	ulong,		raddr		)
+		__field(	int,		flags		)
+	),
+
+	TP_fast_assign(
+		__entry->host_va	= pte->host_va;
+		__entry->pfn		= pte->pfn;
+		__entry->eaddr		= pte->pte.eaddr;
+		__entry->vpage		= pte->pte.vpage;
+		__entry->raddr		= pte->pte.raddr;
+		__entry->flags		= (pte->pte.may_read ? 0x4 : 0) |
+					  (pte->pte.may_write ? 0x2 : 0) |
+					  (pte->pte.may_execute ? 0x1 : 0);
+	),
+
+	TP_printk("Flush: hva=%llx pfn=%llx ea=%lx vp=%llx ra=%lx [%x]",
+		  __entry->host_va, __entry->pfn, __entry->eaddr,
+		  __entry->vpage, __entry->raddr, __entry->flags)
+);
+
 #endif /* CONFIG_PPC_BOOK3S */
 
 #endif /* _TRACE_KVM_H */
-- 
1.6.0.2
