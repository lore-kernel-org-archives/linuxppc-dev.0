Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 90CB71A0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 11:08:51 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 8 May 2015 11:08:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1ED003578048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 11:08:47 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4818d7P9240680
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 May 2015 11:08:47 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4818EOL003181
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 May 2015 11:08:14 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] perf/kvm: Port perf kvm to powerpc
Date: Fri,  8 May 2015 06:37:45 +0530
Message-Id: <1431047266-6206-1-git-send-email-hemant@linux.vnet.ibm.com>
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>, mingo@redhat.com, paulus@samba.org,
 acme@kernel.org, warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
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

This patch makes use of the guest exit reasons available in
"trace_book3s.h". It records on two already available tracepoints :
"kvm_hv:kvm_guest_exit" and "kvm_hv:kvm_guest_enter".

Note : This patch has a dependency on the patch "kvm/powerpc: Export
kvm exit reasons" which exports the KVM exit reasons through the uapi.

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
      EXTERNAL        240     1.69%     0.00%        0.69us     10.67us      1.33us ( +-   5.34% )

Total Samples:14182, Total events handled time:49264158.30us.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
Patch has a dependency on : https://patchwork.ozlabs.org/patch/469839/
which exports the exit reasons to perf through uapi.

Changes:
- Original series split into two patchsets now : perf and powerpc
  side changes.

 arch/powerpc/include/uapi/asm/kvm_perf.h | 15 +++++++++++++++
 tools/perf/arch/powerpc/Makefile         |  1 +
 tools/perf/arch/powerpc/util/Build       |  1 +
 tools/perf/arch/powerpc/util/kvm-stat.c  | 33 ++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+)
 create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
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
-- 
1.9.3
