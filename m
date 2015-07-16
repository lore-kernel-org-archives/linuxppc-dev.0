Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8098A1A075F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 02:05:54 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 02:05:54 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 35B4A2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 02:05:52 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6GG5fiX54984886
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 02:05:49 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6GG5JRK018551
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 02:05:19 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, mingo@kernel.org,
 mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org, scottwood@freescale.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v5 1/2] perf/kvm: Port perf kvm stat to powerpc
Date: Thu, 16 Jul 2015 21:34:51 +0530
Message-Id: <1437062692-16642-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

perf kvm can be used to analyze guest exit reasons. This support already
exists in x86. Hence, porting it to powerpc.

 - To trace KVM events :
  perf kvm stat record
  If many guests are running, we can track for a specific guest by using
  --pid as in : perf kvm stat record --pid <pid>

 - To see the results :
  perf kvm stat report

The result shows the number of exits (from the guest context to
host/hypervisor context) grouped by their respective exit reasons with
their frequency.

To analyze the different exits, group them and present them (in a
slightly descriptive way) to the user, we need a mapping between the
"exit code" (dumped in the kvm_guest_exit tracepoint data) and to its
related Interrupt vector description (exit reason). This patch adds this
mapping in book3s_exits.h.

It records on two available KVM tracepoints :
"kvm_hv:kvm_guest_exit" and "kvm_hv:kvm_guest_enter".

Note that this patch has a direct dependency on
"perf,kvm/ppc: Add kvm_perf.h for powerpc" which adds kvm_perf.h, where
the required kvm tracpoints are defined for "perf kvm stat" to be used.

Here is a sample o/p:
 # pgrep qemu
19378
60515

2 Guests are running on the host.

 # perf kvm stat record -a
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.153 MB perf.data.guest (39624 samples) ]

 # perf kvm stat report -p 60515
Analyze events for pid(s) 60515, all VCPUs:

       VM-EXIT    Samples  Samples%     Time%    Min Time         Max        Time         Avg time

H_DATA_STORAGE       5006    35.30%     0.13%      1.94us     49.46us     12.37us ( +-   0.52% )
HV_DECREMENTER       4457    31.43%     0.02%      0.72us     16.14us      1.91us ( +-   0.96% )
       SYSCALL       2690    18.97%     0.10%      2.84us    528.24us     18.29us ( +-   3.75% )
RETURN_TO_HOST       1789    12.61%    99.76%      1.58us 672791.91us  27470.23us ( +-   3.00% )
      EXTERNAL        240     1.69%     0.00%      0.69us     10.67us      1.33us ( +-   5.34% )

Total Samples:14182, Total events handled time:49264158.30us.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
This patch has a direct dependency on:
http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg91603.html

Changes :
- Added exit reasons definitions(unlikely to change) in the userspace side.

 tools/perf/arch/powerpc/Makefile            |  1 +
 tools/perf/arch/powerpc/util/Build          |  1 +
 tools/perf/arch/powerpc/util/book3s_exits.h | 33 +++++++++++++++++++++++++++++
 tools/perf/arch/powerpc/util/kvm-stat.c     | 33 +++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)
 create mode 100644 tools/perf/arch/powerpc/util/book3s_exits.h
 create mode 100644 tools/perf/arch/powerpc/util/kvm-stat.c

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
index 7b8b0d1..c8fe207 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,5 +1,6 @@
 libperf-y += header.o
 libperf-y += sym-handling.o
+libperf-y += kvm-stat.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
diff --git a/tools/perf/arch/powerpc/util/book3s_exits.h b/tools/perf/arch/powerpc/util/book3s_exits.h
new file mode 100644
index 0000000..94c58f4
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/book3s_exits.h
@@ -0,0 +1,33 @@
+#ifndef ARCH_PERF_BOOK3S_EXITS_H
+#define ARCH_PERF_BOOK3S_EXITS_H
+
+/*
+ * PowerPC Interrupt vectors : exit code to name mapping
+ */
+
+#define kvm_trace_symbol_exit \
+	{0x0,	"RETURN_TO_HOST"}, \
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
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
new file mode 100644
index 0000000..d0e1930
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -0,0 +1,33 @@
+#include "../../util/kvm-stat.h"
+#include "book3s_exits.h"
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
-- 
1.9.3
