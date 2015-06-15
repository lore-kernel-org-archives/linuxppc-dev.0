Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D6961A0E28
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 14:57:46 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 15 Jun 2015 14:57:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2ABED2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 14:57:41 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5F4vWgq38666394
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 14:57:41 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5F4v7u5002121
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 14:57:08 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, mingo@kernel.org,
 mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org, scottwood@freescale.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH RESEND v4 1/3] kvm/powerpc: Export kvm exit reasons
Date: Mon, 15 Jun 2015 10:26:07 +0530
Message-Id: <1434344169-32438-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To analyze the kvm exits with perf, we will need to map the exit codes
with the exit reasons. Such a mapping exists today in trace_book3s.h.
Currently its not exported to perf.

This patch moves these kvm exit reasons and their mapping from
"arch/powerpc/kvm/trace_book3s.h" to
"arch/powerpc/include/uapi/asm/trace_book3s.h".
Accordingly change the include files in "trace_hv.h" and "trace_pr.h".

Also, add a file kvm_perf_book3s.h which defines the kvm tracepoints to
trace for kvm exit events. This is added to indicate that the
tracepoints are book3s specific. Generic "kvm_perf.h" then can just
include "kvm_perf_book3s.h".

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
Resend :
- Rebased to the latest tip.
- Added few people to cc list.

Changes :
- Moved the uapi related changes from the perf side patchset to this
  patchset.
- Made name space changes to indicate changes specific to book3s
  (Suggested by Scott Wood)

 arch/powerpc/include/uapi/asm/kvm_perf.h        |  6 +++++
 arch/powerpc/include/uapi/asm/kvm_perf_book3s.h | 15 ++++++++++++
 arch/powerpc/include/uapi/asm/trace_book3s.h    | 32 +++++++++++++++++++++++++
 arch/powerpc/kvm/trace_book3s.h                 | 32 -------------------------
 arch/powerpc/kvm/trace_hv.h                     |  2 +-
 arch/powerpc/kvm/trace_pr.h                     |  2 +-
 6 files changed, 55 insertions(+), 34 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
 create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
 create mode 100644 arch/powerpc/include/uapi/asm/trace_book3s.h
 delete mode 100644 arch/powerpc/kvm/trace_book3s.h

diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h b/arch/powerpc/include/uapi/asm/kvm_perf.h
new file mode 100644
index 0000000..5ed2ff3
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_POWERPC_KVM_PERF_H
+#define _ASM_POWERPC_KVM_PERF_H
+
+#include <asm/kvm_perf_book3s.h>
+
+#endif
diff --git a/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
new file mode 100644
index 0000000..735901f
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
@@ -0,0 +1,15 @@
+#ifndef _ASM_POWERPC_KVM_PERF_BOOK3S_H
+#define _ASM_POWERPC_KVM_PERF_BOOK3S_H
+
+#include <asm/trace_book3s.h>
+#include <asm/kvm.h>
+
+#define DECODE_STR_LEN 20
+
+#define VCPU_ID "vcpu_id"
+
+#define KVM_ENTRY_TRACE "kvm_hv:kvm_guest_enter"
+#define KVM_EXIT_TRACE "kvm_hv:kvm_guest_exit"
+#define KVM_EXIT_REASON "trap"
+
+#endif /* _ASM_POWERPC_KVM_PERF_BOOK3S_H */
diff --git a/arch/powerpc/include/uapi/asm/trace_book3s.h b/arch/powerpc/include/uapi/asm/trace_book3s.h
new file mode 100644
index 0000000..f647ce0
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/trace_book3s.h
@@ -0,0 +1,32 @@
+#if !defined(_TRACE_KVM_BOOK3S_H)
+#define _TRACE_KVM_BOOK3S_H
+
+/*
+ * Common defines used by the trace macros in trace_pr.h and trace_hv.h
+ */
+
+#define kvm_trace_symbol_exit \
+	{0x100, "SYSTEM_RESET"}, \
+	{0x200, "MACHINE_CHECK"}, \
+	{0x300, "DATA_STORAGE"}, \
+	{0x380, "DATA_SEGMENT"}, \
+	{0x400, "INST_STORAGE"}, \
+	{0x480, "INST_SEGMENT"}, \
+	{0x500, "EXTERNAL"}, \
+	{0x501, "EXTERNAL_LEVEL"}, \
+	{0x502, "EXTERNAL_HV"}, \
+	{0x600, "ALIGNMENT"}, \
+	{0x700, "PROGRAM"}, \
+	{0x800, "FP_UNAVAIL"}, \
+	{0x900, "DECREMENTER"}, \
+	{0x980, "HV_DECREMENTER"}, \
+	{0xc00, "SYSCALL"}, \
+	{0xd00, "TRACE"}, \
+	{0xe00, "H_DATA_STORAGE"}, \
+	{0xe20, "H_INST_STORAGE"}, \
+	{0xe40, "H_EMUL_ASSIST"}, \
+	{0xf00, "PERFMON"}, \
+	{0xf20, "ALTIVEC"}, \
+	{0xf40, "VSX"}
+
+#endif
diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
deleted file mode 100644
index f647ce0..0000000
--- a/arch/powerpc/kvm/trace_book3s.h
+++ /dev/null
@@ -1,32 +0,0 @@
-#if !defined(_TRACE_KVM_BOOK3S_H)
-#define _TRACE_KVM_BOOK3S_H
-
-/*
- * Common defines used by the trace macros in trace_pr.h and trace_hv.h
- */
-
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
-
-#endif
diff --git a/arch/powerpc/kvm/trace_hv.h b/arch/powerpc/kvm/trace_hv.h
index 33d9daf..02d0a07 100644
--- a/arch/powerpc/kvm/trace_hv.h
+++ b/arch/powerpc/kvm/trace_hv.h
@@ -2,7 +2,7 @@
 #define _TRACE_KVM_HV_H
 
 #include <linux/tracepoint.h>
-#include "trace_book3s.h"
+#include <uapi/asm/trace_book3s.h>
 #include <asm/hvcall.h>
 #include <asm/kvm_asm.h>
 
diff --git a/arch/powerpc/kvm/trace_pr.h b/arch/powerpc/kvm/trace_pr.h
index 810507c..a9850c6 100644
--- a/arch/powerpc/kvm/trace_pr.h
+++ b/arch/powerpc/kvm/trace_pr.h
@@ -3,7 +3,7 @@
 #define _TRACE_KVM_PR_H
 
 #include <linux/tracepoint.h>
-#include "trace_book3s.h"
+#include <uapi/asm/trace_book3s.h>
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm_pr
-- 
1.9.3
