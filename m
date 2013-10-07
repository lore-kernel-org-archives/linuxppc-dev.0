Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C03F2C00EF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:52 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 02:48:51 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D51242CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:48 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r97GmbKj5505326
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:37 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r97GmmHl025074
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:48 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 10/14] kvm: powerpc: booke: Move booke related tracepoints
 to separate header
Date: Mon,  7 Oct 2013 22:17:58 +0530
Message-Id: <1381164482-31001-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/booke.c         |   4 +-
 arch/powerpc/kvm/e500_mmu.c      |   2 +-
 arch/powerpc/kvm/e500_mmu_host.c |   3 +-
 arch/powerpc/kvm/trace.h         | 204 ---------------------------------------
 arch/powerpc/kvm/trace_booke.h   | 177 +++++++++++++++++++++++++++++++++
 5 files changed, 183 insertions(+), 207 deletions(-)
 create mode 100644 arch/powerpc/kvm/trace_booke.h

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index e5f8ba7..1769354 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -40,7 +40,9 @@
 
 #include "timing.h"
 #include "booke.h"
-#include "trace.h"
+
+#define CREATE_TRACE_POINTS
+#include "trace_booke.h"
 
 unsigned long kvmppc_booke_handlers;
 
diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index d25bb75..ebca6b8 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -32,7 +32,7 @@
 #include <asm/kvm_ppc.h>
 
 #include "e500.h"
-#include "trace.h"
+#include "trace_booke.h"
 #include "timing.h"
 #include "e500_mmu_host.h"
 
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 8f0d532..e7dde4b 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -32,10 +32,11 @@
 #include <asm/kvm_ppc.h>
 
 #include "e500.h"
-#include "trace.h"
 #include "timing.h"
 #include "e500_mmu_host.h"
 
+#include "trace_booke.h"
+
 #define to_htlb1_esel(esel) (host_tlb_params[1].entries - (esel) - 1)
 
 static struct kvmppc_e500_tlb_params host_tlb_params[E500_TLB_NUM];
diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
index 80f252a..2e0e67e 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -31,116 +31,6 @@ TRACE_EVENT(kvm_ppc_instr,
 		  __entry->inst, __entry->pc, __entry->emulate)
 );
 
-#ifdef CONFIG_PPC_BOOK3S
-#define kvm_trace_symbol_exit \
-	{0x100, "SYSTEM_RESET"}, \
-	{0x200, "MACHINE_CHECK"}, \
-	{0x300, "DATA_STORAGE"}, \
-	{0x380, "DATA_SEGMENT"}, \
-	{0x400, "INST_STORAGE"}, \
-	{0x480, "INST_SEGMENT"}, \
-	{0x500, "EXTERNAL"}, \
-	{0x501, "EXTERNAL_LEVEL"}, \
-	{0x502, "EXTERNAL_HV"}, \
-	{0x600, "ALIGNMENT"}, \
-	{0x700, "PROGRAM"}, \
-	{0x800, "FP_UNAVAIL"}, \
-	{0x900, "DECREMENTER"}, \
-	{0x980, "HV_DECREMENTER"}, \
-	{0xc00, "SYSCALL"}, \
-	{0xd00, "TRACE"}, \
-	{0xe00, "H_DATA_STORAGE"}, \
-	{0xe20, "H_INST_STORAGE"}, \
-	{0xe40, "H_EMUL_ASSIST"}, \
-	{0xf00, "PERFMON"}, \
-	{0xf20, "ALTIVEC"}, \
-	{0xf40, "VSX"}
-#else
-#define kvm_trace_symbol_exit \
-	{0, "CRITICAL"}, \
-	{1, "MACHINE_CHECK"}, \
-	{2, "DATA_STORAGE"}, \
-	{3, "INST_STORAGE"}, \
-	{4, "EXTERNAL"}, \
-	{5, "ALIGNMENT"}, \
-	{6, "PROGRAM"}, \
-	{7, "FP_UNAVAIL"}, \
-	{8, "SYSCALL"}, \
-	{9, "AP_UNAVAIL"}, \
-	{10, "DECREMENTER"}, \
-	{11, "FIT"}, \
-	{12, "WATCHDOG"}, \
-	{13, "DTLB_MISS"}, \
-	{14, "ITLB_MISS"}, \
-	{15, "DEBUG"}, \
-	{32, "SPE_UNAVAIL"}, \
-	{33, "SPE_FP_DATA"}, \
-	{34, "SPE_FP_ROUND"}, \
-	{35, "PERFORMANCE_MONITOR"}, \
-	{36, "DOORBELL"}, \
-	{37, "DOORBELL_CRITICAL"}, \
-	{38, "GUEST_DBELL"}, \
-	{39, "GUEST_DBELL_CRIT"}, \
-	{40, "HV_SYSCALL"}, \
-	{41, "HV_PRIV"}
-#endif
-
-#ifndef CONFIG_KVM_BOOK3S_PR_POSSIBLE
-/*
- * For pr we define this in trace_pr.h since it pr can be built as
- * a module
- */
-
-TRACE_EVENT(kvm_exit,
-	TP_PROTO(unsigned int exit_nr, struct kvm_vcpu *vcpu),
-	TP_ARGS(exit_nr, vcpu),
-
-	TP_STRUCT__entry(
-		__field(	unsigned int,	exit_nr		)
-		__field(	unsigned long,	pc		)
-		__field(	unsigned long,	msr		)
-		__field(	unsigned long,	dar		)
-		__field(	unsigned long,	last_inst	)
-	),
-
-	TP_fast_assign(
-		__entry->exit_nr	= exit_nr;
-		__entry->pc		= kvmppc_get_pc(vcpu);
-		__entry->dar		= kvmppc_get_fault_dar(vcpu);
-		__entry->msr		= vcpu->arch.shared->msr;
-		__entry->last_inst	= vcpu->arch.last_inst;
-	),
-
-	TP_printk("exit=%s"
-		" | pc=0x%lx"
-		" | msr=0x%lx"
-		" | dar=0x%lx"
-		" | last_inst=0x%lx"
-		,
-		__print_symbolic(__entry->exit_nr, kvm_trace_symbol_exit),
-		__entry->pc,
-		__entry->msr,
-		__entry->dar,
-		__entry->last_inst
-		)
-);
-
-TRACE_EVENT(kvm_unmap_hva,
-	TP_PROTO(unsigned long hva),
-	TP_ARGS(hva),
-
-	TP_STRUCT__entry(
-		__field(	unsigned long,	hva		)
-	),
-
-	TP_fast_assign(
-		__entry->hva		= hva;
-	),
-
-	TP_printk("unmap hva 0x%lx\n", __entry->hva)
-);
-#endif
-
 TRACE_EVENT(kvm_stlb_inval,
 	TP_PROTO(unsigned int stlb_index),
 	TP_ARGS(stlb_index),
@@ -226,100 +116,6 @@ TRACE_EVENT(kvm_check_requests,
 		__entry->cpu_nr, __entry->requests)
 );
 
-/*************************************************************************
- *                         Book3E trace points                           *
- *************************************************************************/
-
-#ifdef CONFIG_BOOKE
-
-TRACE_EVENT(kvm_booke206_stlb_write,
-	TP_PROTO(__u32 mas0, __u32 mas8, __u32 mas1, __u64 mas2, __u64 mas7_3),
-	TP_ARGS(mas0, mas8, mas1, mas2, mas7_3),
-
-	TP_STRUCT__entry(
-		__field(	__u32,	mas0		)
-		__field(	__u32,	mas8		)
-		__field(	__u32,	mas1		)
-		__field(	__u64,	mas2		)
-		__field(	__u64,	mas7_3		)
-	),
-
-	TP_fast_assign(
-		__entry->mas0		= mas0;
-		__entry->mas8		= mas8;
-		__entry->mas1		= mas1;
-		__entry->mas2		= mas2;
-		__entry->mas7_3		= mas7_3;
-	),
-
-	TP_printk("mas0=%x mas8=%x mas1=%x mas2=%llx mas7_3=%llx",
-		__entry->mas0, __entry->mas8, __entry->mas1,
-		__entry->mas2, __entry->mas7_3)
-);
-
-TRACE_EVENT(kvm_booke206_gtlb_write,
-	TP_PROTO(__u32 mas0, __u32 mas1, __u64 mas2, __u64 mas7_3),
-	TP_ARGS(mas0, mas1, mas2, mas7_3),
-
-	TP_STRUCT__entry(
-		__field(	__u32,	mas0		)
-		__field(	__u32,	mas1		)
-		__field(	__u64,	mas2		)
-		__field(	__u64,	mas7_3		)
-	),
-
-	TP_fast_assign(
-		__entry->mas0		= mas0;
-		__entry->mas1		= mas1;
-		__entry->mas2		= mas2;
-		__entry->mas7_3		= mas7_3;
-	),
-
-	TP_printk("mas0=%x mas1=%x mas2=%llx mas7_3=%llx",
-		__entry->mas0, __entry->mas1,
-		__entry->mas2, __entry->mas7_3)
-);
-
-TRACE_EVENT(kvm_booke206_ref_release,
-	TP_PROTO(__u64 pfn, __u32 flags),
-	TP_ARGS(pfn, flags),
-
-	TP_STRUCT__entry(
-		__field(	__u64,	pfn		)
-		__field(	__u32,	flags		)
-	),
-
-	TP_fast_assign(
-		__entry->pfn		= pfn;
-		__entry->flags		= flags;
-	),
-
-	TP_printk("pfn=%llx flags=%x",
-		__entry->pfn, __entry->flags)
-);
-
-TRACE_EVENT(kvm_booke_queue_irqprio,
-	TP_PROTO(struct kvm_vcpu *vcpu, unsigned int priority),
-	TP_ARGS(vcpu, priority),
-
-	TP_STRUCT__entry(
-		__field(	__u32,	cpu_nr		)
-		__field(	__u32,	priority		)
-		__field(	unsigned long,	pending		)
-	),
-
-	TP_fast_assign(
-		__entry->cpu_nr		= vcpu->vcpu_id;
-		__entry->priority	= priority;
-		__entry->pending	= vcpu->arch.pending_exceptions;
-	),
-
-	TP_printk("vcpu=%x prio=%x pending=%lx",
-		__entry->cpu_nr, __entry->priority, __entry->pending)
-);
-
-#endif
-
 #endif /* _TRACE_KVM_H */
 
 /* This part must be outside protection */
diff --git a/arch/powerpc/kvm/trace_booke.h b/arch/powerpc/kvm/trace_booke.h
new file mode 100644
index 0000000..f7537cf
--- /dev/null
+++ b/arch/powerpc/kvm/trace_booke.h
@@ -0,0 +1,177 @@
+#if !defined(_TRACE_KVM_BOOKE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_KVM_BOOKE_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm_booke
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_booke
+
+#define kvm_trace_symbol_exit \
+	{0, "CRITICAL"}, \
+	{1, "MACHINE_CHECK"}, \
+	{2, "DATA_STORAGE"}, \
+	{3, "INST_STORAGE"}, \
+	{4, "EXTERNAL"}, \
+	{5, "ALIGNMENT"}, \
+	{6, "PROGRAM"}, \
+	{7, "FP_UNAVAIL"}, \
+	{8, "SYSCALL"}, \
+	{9, "AP_UNAVAIL"}, \
+	{10, "DECREMENTER"}, \
+	{11, "FIT"}, \
+	{12, "WATCHDOG"}, \
+	{13, "DTLB_MISS"}, \
+	{14, "ITLB_MISS"}, \
+	{15, "DEBUG"}, \
+	{32, "SPE_UNAVAIL"}, \
+	{33, "SPE_FP_DATA"}, \
+	{34, "SPE_FP_ROUND"}, \
+	{35, "PERFORMANCE_MONITOR"}, \
+	{36, "DOORBELL"}, \
+	{37, "DOORBELL_CRITICAL"}, \
+	{38, "GUEST_DBELL"}, \
+	{39, "GUEST_DBELL_CRIT"}, \
+	{40, "HV_SYSCALL"}, \
+	{41, "HV_PRIV"}
+
+TRACE_EVENT(kvm_exit,
+	TP_PROTO(unsigned int exit_nr, struct kvm_vcpu *vcpu),
+	TP_ARGS(exit_nr, vcpu),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,	exit_nr		)
+		__field(	unsigned long,	pc		)
+		__field(	unsigned long,	msr		)
+		__field(	unsigned long,	dar		)
+		__field(	unsigned long,	last_inst	)
+	),
+
+	TP_fast_assign(
+		__entry->exit_nr	= exit_nr;
+		__entry->pc		= kvmppc_get_pc(vcpu);
+		__entry->dar		= kvmppc_get_fault_dar(vcpu);
+		__entry->msr		= vcpu->arch.shared->msr;
+		__entry->last_inst	= vcpu->arch.last_inst;
+	),
+
+	TP_printk("exit=%s"
+		" | pc=0x%lx"
+		" | msr=0x%lx"
+		" | dar=0x%lx"
+		" | last_inst=0x%lx"
+		,
+		__print_symbolic(__entry->exit_nr, kvm_trace_symbol_exit),
+		__entry->pc,
+		__entry->msr,
+		__entry->dar,
+		__entry->last_inst
+		)
+);
+
+TRACE_EVENT(kvm_unmap_hva,
+	TP_PROTO(unsigned long hva),
+	TP_ARGS(hva),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	hva		)
+	),
+
+	TP_fast_assign(
+		__entry->hva		= hva;
+	),
+
+	TP_printk("unmap hva 0x%lx\n", __entry->hva)
+);
+
+TRACE_EVENT(kvm_booke206_stlb_write,
+	TP_PROTO(__u32 mas0, __u32 mas8, __u32 mas1, __u64 mas2, __u64 mas7_3),
+	TP_ARGS(mas0, mas8, mas1, mas2, mas7_3),
+
+	TP_STRUCT__entry(
+		__field(	__u32,	mas0		)
+		__field(	__u32,	mas8		)
+		__field(	__u32,	mas1		)
+		__field(	__u64,	mas2		)
+		__field(	__u64,	mas7_3		)
+	),
+
+	TP_fast_assign(
+		__entry->mas0		= mas0;
+		__entry->mas8		= mas8;
+		__entry->mas1		= mas1;
+		__entry->mas2		= mas2;
+		__entry->mas7_3		= mas7_3;
+	),
+
+	TP_printk("mas0=%x mas8=%x mas1=%x mas2=%llx mas7_3=%llx",
+		__entry->mas0, __entry->mas8, __entry->mas1,
+		__entry->mas2, __entry->mas7_3)
+);
+
+TRACE_EVENT(kvm_booke206_gtlb_write,
+	TP_PROTO(__u32 mas0, __u32 mas1, __u64 mas2, __u64 mas7_3),
+	TP_ARGS(mas0, mas1, mas2, mas7_3),
+
+	TP_STRUCT__entry(
+		__field(	__u32,	mas0		)
+		__field(	__u32,	mas1		)
+		__field(	__u64,	mas2		)
+		__field(	__u64,	mas7_3		)
+	),
+
+	TP_fast_assign(
+		__entry->mas0		= mas0;
+		__entry->mas1		= mas1;
+		__entry->mas2		= mas2;
+		__entry->mas7_3		= mas7_3;
+	),
+
+	TP_printk("mas0=%x mas1=%x mas2=%llx mas7_3=%llx",
+		__entry->mas0, __entry->mas1,
+		__entry->mas2, __entry->mas7_3)
+);
+
+TRACE_EVENT(kvm_booke206_ref_release,
+	TP_PROTO(__u64 pfn, __u32 flags),
+	TP_ARGS(pfn, flags),
+
+	TP_STRUCT__entry(
+		__field(	__u64,	pfn		)
+		__field(	__u32,	flags		)
+	),
+
+	TP_fast_assign(
+		__entry->pfn		= pfn;
+		__entry->flags		= flags;
+	),
+
+	TP_printk("pfn=%llx flags=%x",
+		__entry->pfn, __entry->flags)
+);
+
+TRACE_EVENT(kvm_booke_queue_irqprio,
+	TP_PROTO(struct kvm_vcpu *vcpu, unsigned int priority),
+	TP_ARGS(vcpu, priority),
+
+	TP_STRUCT__entry(
+		__field(	__u32,	cpu_nr		)
+		__field(	__u32,	priority		)
+		__field(	unsigned long,	pending		)
+	),
+
+	TP_fast_assign(
+		__entry->cpu_nr		= vcpu->vcpu_id;
+		__entry->priority	= priority;
+		__entry->pending	= vcpu->arch.pending_exceptions;
+	),
+
+	TP_printk("vcpu=%x prio=%x pending=%lx",
+		__entry->cpu_nr, __entry->priority, __entry->pending)
+);
+
+#endif
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.8.1.2
