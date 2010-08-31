Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 91F75B7104
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:18 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 02/35] KVM: PPC: Move book3s_64 mmu map debug print to trace
	point
Date: Tue, 31 Aug 2010 04:31:43 +0200
Message-Id: <1283221937-21006-3-git-send-email-agraf@suse.de>
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

This patch moves Book3s MMU debugging over to tracepoints.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_64_mmu_host.c |   13 +----------
 arch/powerpc/kvm/trace.h              |   34 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 672b149..aa516ad 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -28,19 +28,13 @@
 #include <asm/machdep.h>
 #include <asm/mmu_context.h>
 #include <asm/hw_irq.h>
+#include "trace.h"
 
 #define PTE_SIZE 12
 #define VSID_ALL 0
 
-/* #define DEBUG_MMU */
 /* #define DEBUG_SLB */
 
-#ifdef DEBUG_MMU
-#define dprintk_mmu(a, ...) printk(KERN_INFO a, __VA_ARGS__)
-#else
-#define dprintk_mmu(a, ...) do { } while(0)
-#endif
-
 #ifdef DEBUG_SLB
 #define dprintk_slb(a, ...) printk(KERN_INFO a, __VA_ARGS__)
 #else
@@ -156,10 +150,7 @@ map_again:
 	} else {
 		struct hpte_cache *pte = kvmppc_mmu_hpte_cache_next(vcpu);
 
-		dprintk_mmu("KVM: %c%c Map 0x%lx: [%lx] 0x%lx (0x%llx) -> %lx\n",
-			    ((rflags & HPTE_R_PP) == 3) ? '-' : 'w',
-			    (rflags & HPTE_R_N) ? '-' : 'x',
-			    orig_pte->eaddr, hpteg, va, orig_pte->vpage, hpaddr);
+		trace_kvm_book3s_64_mmu_map(rflags, hpteg, va, hpaddr, orig_pte);
 
 		/* The ppc_md code may give us a secondary entry even though we
 		   asked for a primary. Fix up. */
diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
index b5e9d81..8ed6f1c 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -147,6 +147,40 @@ TRACE_EVENT(kvm_book3s_reenter,
 	TP_printk("reentry r=%d | pc=0x%lx", __entry->r, __entry->pc)
 );
 
+#ifdef CONFIG_PPC_BOOK3S_64
+
+TRACE_EVENT(kvm_book3s_64_mmu_map,
+	TP_PROTO(int rflags, ulong hpteg, ulong va, pfn_t hpaddr,
+		 struct kvmppc_pte *orig_pte),
+	TP_ARGS(rflags, hpteg, va, hpaddr, orig_pte),
+
+	TP_STRUCT__entry(
+		__field(	unsigned char,		flag_w		)
+		__field(	unsigned char,		flag_x		)
+		__field(	unsigned long,		eaddr		)
+		__field(	unsigned long,		hpteg		)
+		__field(	unsigned long,		va		)
+		__field(	unsigned long long,	vpage		)
+		__field(	unsigned long,		hpaddr		)
+	),
+
+	TP_fast_assign(
+		__entry->flag_w	= ((rflags & HPTE_R_PP) == 3) ? '-' : 'w';
+		__entry->flag_x	= (rflags & HPTE_R_N) ? '-' : 'x';
+		__entry->eaddr	= orig_pte->eaddr;
+		__entry->hpteg	= hpteg;
+		__entry->va	= va;
+		__entry->vpage	= orig_pte->vpage;
+		__entry->hpaddr	= hpaddr;
+	),
+
+	TP_printk("KVM: %c%c Map 0x%lx: [%lx] 0x%lx (0x%llx) -> %lx",
+		  __entry->flag_w, __entry->flag_x, __entry->eaddr,
+		  __entry->hpteg, __entry->va, __entry->vpage, __entry->hpaddr)
+);
+
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
 #endif /* CONFIG_PPC_BOOK3S */
 
 #endif /* _TRACE_KVM_H */
-- 
1.6.0.2
