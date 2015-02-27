Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7ECD11A0214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 20:44:05 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 27 Feb 2015 15:14:03 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 12115E004C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 15:15:50 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1R9hxKG58392694
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 15:13:59 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1R9hwVm014314
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 15:13:59 +0530
Subject: [PATCH v1 1/2] perf/kvm: Enable perf-kvm-stat record/report on powerpc
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 27 Feb 2015 15:13:58 +0530
Message-ID: <20150227094332.6367.67316.stgit@localhost.localdomain>
In-Reply-To: <20150227093649.6367.15679.stgit@localhost.localdomain>
References: <20150227093649.6367.15679.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, anton@au1.ibm.com,
 linux-kernel@vger.kernel.org, agraf@suse.de, paulus@samba.org,
 warrier@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

perf kvm stat record/report isn't supported on powerpc.
This patch enables perf to record kvm events (kvm_hv:kvm_guest_entry and exit)
and to display the stats related to the events.
When "perf kvm stat record -a" is invoked, the kvm_hv related tracepoints
kvm_hv:kvm_guest_enter (defined as KVM_ENTRY_TRACE) and kvm_hv:kvm_guest_exit
(defined as KVM_EXIT_TRACE) are enabled. All these data are dumped to
perf.data.guest file.
After recording, use "perf kvm stat report" to view the vm exit related
stats which shows how many times, the VM exited from guest to host/hypervisor mode.
All these exits are grouped as per their reasons to exit. The exit reasons
are defined in "kvm_trace_symbol_exit".

The reasons related to kvm_exits, hcalls, etc were previously defined in
arch/powerpc/kvm/trace_book3s.h. To reuse all the reasons defined there, this patch
moves the exit_reasons arch/powerpc/include/uapi/asm/trace_book3s.h.

This patch defines the tracepoint events "kvm_hv:kvm_guest_exit" and
"kvm_hv:kvm_guest_enter" to be sampled and registers the exit events' operations.

Here is a sample o/p:

# pgrep qemu
19378
60515

# perf kvm stat record -a
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.153 MB perf.data.guest (39624 samples) ]

# perf kvm stat report -p 60515


Analyze events for pid(s) 60515, all VCPUs:

             VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time

      H_DATA_STORAGE       5006    35.30%     0.13%      1.94us     49.46us     12.37us ( +-   0.52% )
      HV_DECREMENTER       4457    31.43%     0.02%      0.72us     16.14us      1.91us ( +-   0.96% )
             SYSCALL       2690    18.97%     0.10%      2.84us    528.24us     18.29us ( +-   3.75% )
      RETURN_TO_HOST       1789    12.61%    99.76%      1.58us 672791.91us  27470.23us ( +-   3.00% )
            EXTERNAL        240     1.69%     0.00%      0.69us     10.67us      1.33us ( +-   5.34% )

Total Samples:14182, Total events handled time:49264158.30us.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/kvm_perf.h     |   15 ++++++++++++
 arch/powerpc/include/uapi/asm/trace_book3s.h |   33 ++++++++++++++++++++++++++
 arch/powerpc/kvm/trace_book3s.h              |   32 -------------------------
 arch/powerpc/kvm/trace_hv.h                  |    2 +-
 arch/powerpc/kvm/trace_pr.h                  |    2 +-
 tools/perf/arch/powerpc/Makefile             |    1 +
 tools/perf/arch/powerpc/util/Build           |    1 +
 tools/perf/arch/powerpc/util/kvm-stat.c      |   33 ++++++++++++++++++++++++++
 8 files changed, 85 insertions(+), 34 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
 create mode 100644 arch/powerpc/include/uapi/asm/trace_book3s.h
 delete mode 100644 arch/powerpc/kvm/trace_book3s.h
 create mode 100644 tools/perf/arch/powerpc/util/kvm-stat.c

diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h b/arch/powerpc/include/uapi/asm/kvm_perf.h
new file mode 100644
index 0000000..30fa670
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
@@ -0,0 +1,15 @@
+#ifndef _ASM_POWERPC_KVM_PERF_H
+#define _ASM_POWERPC_KVM_PERF_H
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
+#endif /* _ASM_POWERPC_KVM_PERF_H */
diff --git a/arch/powerpc/include/uapi/asm/trace_book3s.h b/arch/powerpc/include/uapi/asm/trace_book3s.h
new file mode 100644
index 0000000..1e79e0e
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/trace_book3s.h
@@ -0,0 +1,33 @@
+#if !defined(_TRACE_KVM_BOOK3S_H)
+#define _TRACE_KVM_BOOK3S_H
+
+/*
+ * Common defines used by the trace macros in trace_pr.h and trace_hv.h
+ */
+
+#define kvm_trace_symbol_exit					\
+	{0x0, "RETURN_TO_HOST"},				\
+	{0x100, "SYSTEM_RESET"},				\
+	{0x200, "MACHINE_CHECK"},				\
+	{0x300, "DATA_STORAGE"},				\
+	{0x380, "DATA_SEGMENT"},				\
+	{0x400, "INST_STORAGE"},				\
+	{0x480, "INST_SEGMENT"},				\
+	{0x500, "EXTERNAL"},					\
+	{0x501, "EXTERNAL_LEVEL"},				\
+	{0x502, "EXTERNAL_HV"},					\
+	{0x600, "ALIGNMENT"},					\
+	{0x700, "PROGRAM"},					\
+	{0x800, "FP_UNAVAIL"},					\
+	{0x900, "DECREMENTER"},					\
+	{0x980, "HV_DECREMENTER"},				\
+	{0xc00, "SYSCALL"},					\
+	{0xd00, "TRACE"},					\
+	{0xe00, "H_DATA_STORAGE"},				\
+	{0xe20, "H_INST_STORAGE"},				\
+	{0xe40, "H_EMUL_ASSIST"},				\
+	{0xf00, "PERFMON"},					\
+	{0xf20, "ALTIVEC"},					\
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
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 7fbca17..21322e0 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -1,3 +1,4 @@
 ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
+HAVE_KVM_STAT_SUPPORT := 1
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 0af6e9b..dd47b5e 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,4 +1,5 @@
 libperf-y += header.o
+libperf-y += kvm-stat.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
new file mode 100644
index 0000000..62cdcc1
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -0,0 +1,33 @@
+#include "../../util/kvm-stat.h"
+#include <asm/kvm_perf.h>
+
+define_exit_reasons_table(hv_exit_reasons, kvm_trace_symbol_exit);
+
+static struct kvm_events_ops exit_events = {
+	.is_begin_event = exit_event_begin,
+	.is_end_event = exit_event_end,
+	.decode_key = exit_event_decode_key,
+	.name = "VM-EXIT"
+};
+
+const char *const kvm_events_tp[] = {
+	"kvm_hv:kvm_guest_exit",
+	"kvm_hv:kvm_guest_enter",
+	NULL,
+};
+
+struct kvm_reg_events_ops kvm_reg_events_ops[] = {
+	{ .name = "vmexit", .ops = &exit_events },
+	{ NULL, NULL },
+};
+
+const char * const kvm_skip_events[] = {
+	NULL,
+};
+
+int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+{
+	kvm->exit_reasons = hv_exit_reasons;
+	kvm->exit_reasons_isa = "HV";
+	return 0;
+}
