Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2F87B7107
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:20 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 01/35] KVM: PPC: Move EXIT_DEBUG partially to tracepoints
Date: Tue, 31 Aug 2010 04:31:42 +0200
Message-Id: <1283221937-21006-2-git-send-email-agraf@suse.de>
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

We have a debug printk on every exit that is usually #ifdef'ed out. Using
tracepoints makes a lot more sense here though, as they can be dynamically
enabled.

This patch converts the most commonly used debug printks of EXIT_DEBUG to
tracepoints.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s.c |   26 +++-------------------
 arch/powerpc/kvm/trace.h  |   51 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 7656b6d..37db61d 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -17,6 +17,7 @@
 #include <linux/kvm_host.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include "trace.h"
 
 #include <asm/reg.h>
 #include <asm/cputable.h>
@@ -35,7 +36,6 @@
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
 
 /* #define EXIT_DEBUG */
-/* #define EXIT_DEBUG_SIMPLE */
 /* #define DEBUG_EXT */
 
 static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
@@ -105,14 +105,6 @@ void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
 	kvmppc_giveup_ext(vcpu, MSR_VSX);
 }
 
-#if defined(EXIT_DEBUG)
-static u32 kvmppc_get_dec(struct kvm_vcpu *vcpu)
-{
-	u64 jd = mftb() - vcpu->arch.dec_jiffies;
-	return vcpu->arch.dec - jd;
-}
-#endif
-
 static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
 {
 	ulong smsr = vcpu->arch.shared->msr;
@@ -850,16 +842,8 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	run->exit_reason = KVM_EXIT_UNKNOWN;
 	run->ready_for_interrupt_injection = 1;
-#ifdef EXIT_DEBUG
-	printk(KERN_EMERG "exit_nr=0x%x | pc=0x%lx | dar=0x%lx | dec=0x%x | msr=0x%lx\n",
-		exit_nr, kvmppc_get_pc(vcpu), kvmppc_get_fault_dar(vcpu),
-		kvmppc_get_dec(vcpu), to_svcpu(vcpu)->shadow_srr1);
-#elif defined (EXIT_DEBUG_SIMPLE)
-	if ((exit_nr != 0x900) && (exit_nr != 0x500))
-		printk(KERN_EMERG "exit_nr=0x%x | pc=0x%lx | dar=0x%lx | msr=0x%lx\n",
-			exit_nr, kvmppc_get_pc(vcpu), kvmppc_get_fault_dar(vcpu),
-			vcpu->arch.shared->msr);
-#endif
+
+	trace_kvm_book3s_exit(exit_nr, vcpu);
 	kvm_resched(vcpu);
 	switch (exit_nr) {
 	case BOOK3S_INTERRUPT_INST_STORAGE:
@@ -1091,9 +1075,7 @@ program_interrupt:
 		}
 	}
 
-#ifdef EXIT_DEBUG
-	printk(KERN_EMERG "KVM exit: vcpu=0x%p pc=0x%lx r=0x%x\n", vcpu, kvmppc_get_pc(vcpu), r);
-#endif
+	trace_kvm_book3s_reenter(r, vcpu);
 
 	return r;
 }
diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
index a8e8400..b5e9d81 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -98,6 +98,57 @@ TRACE_EVENT(kvm_gtlb_write,
 		__entry->word1, __entry->word2)
 );
 
+
+/*************************************************************************
+ *                         Book3S trace points                           *
+ *************************************************************************/
+
+#ifdef CONFIG_PPC_BOOK3S
+
+TRACE_EVENT(kvm_book3s_exit,
+	TP_PROTO(unsigned int exit_nr, struct kvm_vcpu *vcpu),
+	TP_ARGS(exit_nr, vcpu),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,	exit_nr		)
+		__field(	unsigned long,	pc		)
+		__field(	unsigned long,	msr		)
+		__field(	unsigned long,	dar		)
+		__field(	unsigned long,	srr1		)
+	),
+
+	TP_fast_assign(
+		__entry->exit_nr	= exit_nr;
+		__entry->pc		= kvmppc_get_pc(vcpu);
+		__entry->dar		= kvmppc_get_fault_dar(vcpu);
+		__entry->msr		= vcpu->arch.shared->msr;
+		__entry->srr1		= to_svcpu(vcpu)->shadow_srr1;
+	),
+
+	TP_printk("exit=0x%x | pc=0x%lx | msr=0x%lx | dar=0x%lx | srr1=0x%lx",
+		  __entry->exit_nr, __entry->pc, __entry->msr, __entry->dar,
+		  __entry->srr1)
+);
+
+TRACE_EVENT(kvm_book3s_reenter,
+	TP_PROTO(int r, struct kvm_vcpu *vcpu),
+	TP_ARGS(r, vcpu),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,	r		)
+		__field(	unsigned long,	pc		)
+	),
+
+	TP_fast_assign(
+		__entry->r		= r;
+		__entry->pc		= kvmppc_get_pc(vcpu);
+	),
+
+	TP_printk("reentry r=%d | pc=0x%lx", __entry->r, __entry->pc)
+);
+
+#endif /* CONFIG_PPC_BOOK3S */
+
 #endif /* _TRACE_KVM_H */
 
 /* This part must be outside protection */
-- 
1.6.0.2
