Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25582B7113
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:21 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 03/35] KVM: PPC: Add tracepoint for generic mmu map
Date: Tue, 31 Aug 2010 04:31:44 +0200
Message-Id: <1283221937-21006-4-git-send-email-agraf@suse.de>
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

This patch moves the generic mmu map debugging over to tracepoints.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_mmu_hpte.c |    3 +++
 arch/powerpc/kvm/trace.h           |   29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_mmu_hpte.c b/arch/powerpc/kvm/book3s_mmu_hpte.c
index 02c64ab..ac94bd9 100644
--- a/arch/powerpc/kvm/book3s_mmu_hpte.c
+++ b/arch/powerpc/kvm/book3s_mmu_hpte.c
@@ -21,6 +21,7 @@
 #include <linux/kvm_host.h>
 #include <linux/hash.h>
 #include <linux/slab.h>
+#include "trace.h"
 
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
@@ -66,6 +67,8 @@ void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 {
 	u64 index;
 
+	trace_kvm_book3s_mmu_map(pte);
+
 	spin_lock(&vcpu->arch.mmu_lock);
 
 	/* Add to ePTE list */
diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
index 8ed6f1c..68a8444 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -181,6 +181,35 @@ TRACE_EVENT(kvm_book3s_64_mmu_map,
 
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
+TRACE_EVENT(kvm_book3s_mmu_map,
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
+	TP_printk("Map: hva=%llx pfn=%llx ea=%lx vp=%llx ra=%lx [%x]",
+		  __entry->host_va, __entry->pfn, __entry->eaddr,
+		  __entry->vpage, __entry->raddr, __entry->flags)
+);
+
 #endif /* CONFIG_PPC_BOOK3S */
 
 #endif /* _TRACE_KVM_H */
-- 
1.6.0.2
