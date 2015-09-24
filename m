Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61F6A1A0437
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 05:04:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 25 Sep 2015 05:04:35 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D0DE62CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 05:04:31 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8OJ4NnR53739766
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 05:04:31 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8OJ3wbC012646
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 05:03:59 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, acme@kernel.org, scottwood@freescale.com,
 sukadev@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 mpe@ellerman.id.au, paulus@samba.org, mingo@redhat.com,
 hemant@linux.vnet.ibm.com
Subject: [PATCH v7 3/4] perf,kvm/powerpc: Port perf kvm stat to powerpc
Date: Fri, 25 Sep 2015 00:33:00 +0530
Message-Id: <1443121381-24553-3-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1443121381-24553-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1443121381-24553-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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

Since, different powerpc machines have different KVM tracepoints, this
patch discovers the available tracepoints dynamically and accordingly
looks for them. If any single tracepoint is not present, this support
won't be enabled for reporting. To record, this will fail if any of the
events we are looking to record isn't available.
Right now, its only supported on PowerPC Book3S_HV architectures.

To analyze the different exits, group them and present them (in a slight
descriptive way) to the user, we need a mapping between the "exit
code" (dumped in the kvm_guest_exit tracepoint data) and to its related
Interrupt vector description (exit reason). This patch adds this mapping
in book3s_hv_exits.h.

It records on two available KVM tracepoints for book3s_hv:
"kvm_hv:kvm_guest_exit" and "kvm_hv:kvm_guest_enter".

Here is a sample o/p:
 # pgrep qemu
19378
60515

2 Guests are running on the host.

 # perf kvm stat record -a
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.153 MB perf.data.guest (39624
samples) ]

 # perf kvm stat report -p 60515

Analyze events for pid(s) 60515, all VCPUs:

       VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time

       SYSCALL       9141    63.67%     7.49%      1.26us   5782.39us      9.87us ( +-   6.46% )
H_DATA_STORAGE       4114    28.66%     5.07%      1.72us   4597.68us     14.84us ( +-  20.06% )
HV_DECREMENTER        418     2.91%     4.26%      0.70us  30002.22us    122.58us ( +-  70.29% )
      EXTERNAL        392     2.73%     0.06%      0.64us    104.10us      1.94us ( +-  18.83% )
RETURN_TO_HOST        287     2.00%    83.11%      1.53us 124240.15us   3486.52us ( +-  16.81% )
H_INST_STORAGE          5     0.03%     0.00%      1.88us      3.73us      2.39us ( +-  14.20% )

Total Samples:14357, Total events handled time:1203918.42us.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
Changes :
- Remooved dependency on arch/uapi

 tools/perf/arch/powerpc/Makefile               |   2 +
 tools/perf/arch/powerpc/util/Build             |   1 +
 tools/perf/arch/powerpc/util/book3s_hv_exits.h |  33 ++++++++
 tools/perf/arch/powerpc/util/kvm-stat.c        | 105 +++++++++++++++++++++++++
 tools/perf/builtin-kvm.c                       |  12 +++
 tools/perf/util/kvm-stat.h                     |   1 +
 6 files changed, 154 insertions(+)
 create mode 100644 tools/perf/arch/powerpc/util/book3s_hv_exits.h
 create mode 100644 tools/perf/arch/powerpc/util/kvm-stat.c

diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 7fbca17..9f9cea3 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -1,3 +1,5 @@
 ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
+
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
diff --git a/tools/perf/arch/powerpc/util/book3s_hv_exits.h b/tools/perf/arch/powerpc/util/book3s_hv_exits.h
new file mode 100644
index 0000000..e68ba2d
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/book3s_hv_exits.h
@@ -0,0 +1,33 @@
+#ifndef ARCH_PERF_BOOK3S_HV_EXITS_H
+#define ARCH_PERF_BOOK3S_HV_EXITS_H
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
index 0000000..34d4b21
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -0,0 +1,105 @@
+#include "util/kvm-stat.h"
+#include "util/parse-events.h"
+
+#include "book3s_hv_exits.h"
+
+#define NR_TPS 2
+#define DECODE_STR_LEN 40
+#define VCPU_ID "vcpu_id"
+#define KVM_EXIT_REASON_HV "trap"
+
+define_exit_reasons_table(hv_exit_reasons, kvm_trace_symbol_exit);
+
+/* Tracepoints specific to ppc_book3s_hv */
+const char *ppc_book3s_hv_kvm_tp[] = {
+	"kvm_hv:kvm_guest_enter",
+	"kvm_hv:kvm_guest_exit",
+};
+
+const char *vcpu_id_str = VCPU_ID;
+const int decode_str_len = DECODE_STR_LEN;
+
+/* 1 extra placeholder for NULL */
+const char *kvm_events_tp[NR_TPS + 1];
+const char *exit_reason_code = NULL;
+
+static struct kvm_events_ops exit_events = {
+	.is_begin_event = exit_event_begin,
+	.is_end_event = exit_event_end,
+	.decode_key = exit_event_decode_key,
+	.name = "VM-EXIT"
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
+
+static int is_tracepoint_available(const char *str)
+{
+	struct perf_evlist *evlist = perf_evlist__new();
+
+	return parse_events(evlist, str, NULL);
+}
+
+static void ppc__setup_book3s_hv(struct perf_kvm_stat *kvm, int nr_tp)
+{
+	int i;
+
+	for (i = 0; i < nr_tp; i++)
+		kvm_events_tp[i] = ppc_book3s_hv_kvm_tp[i];
+
+	exit_reason_code = KVM_EXIT_REASON_HV;
+	kvm->exit_reasons = hv_exit_reasons;
+	kvm->exit_reasons_isa = "HV";
+	kvm_events_tp[i] = NULL;
+}
+
+static int ppc__setup_kvm_tp(struct perf_kvm_stat *kvm)
+{
+	int err = -1, nr_tp = 0;
+	struct perf_evlist *evlist = perf_evlist__new();
+	const char **events_ptr;
+
+	if (evlist == NULL)
+		return -ENOMEM;
+
+	/* Check for book3s_hv tracepoints */
+	for (events_ptr = ppc_book3s_hv_kvm_tp; *events_ptr; events_ptr++) {
+		err = is_tracepoint_available(*events_ptr);
+		if (err)
+			return -1;
+		nr_tp++;
+	}
+
+	/* Right now, only supported on book3s_hv */
+	if (nr_tp > 0) {
+		ppc__setup_book3s_hv(kvm, nr_tp);
+		err = 0;
+	}
+
+	return err;
+}
+
+int setup_kvm_events_tp(struct perf_kvm_stat *kvm)
+{
+	return ppc__setup_kvm_tp(kvm);
+}
+
+int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+{
+	int ret;
+
+	ret = ppc__setup_kvm_tp(kvm);
+	if (ret) {
+		kvm->exit_reasons = NULL;
+		kvm->exit_reasons_isa = NULL;
+	}
+
+	return ret;
+}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index dbb1b1e..fb85ce3 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1143,6 +1143,11 @@ exit:
 		_p;			\
 	})
 
+int __weak setup_kvm_events_tp(struct perf_kvm_stat *kvm __maybe_unused)
+{
+	return 0;
+}
+
 static int
 kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 {
@@ -1159,7 +1164,14 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		NULL
 	};
 	const char * const *events_tp;
+	int ret;
+
 	events_tp_size = 0;
+	ret = setup_kvm_events_tp(kvm);
+	if (ret < 0) {
+		pr_err("Unable to setup the kvm tracepoints\n");
+		return ret;
+	}
 
 	for (events_tp = kvm_events_tp; *events_tp; events_tp++)
 		events_tp_size++;
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index fd9f40f..356a8a8 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -122,6 +122,7 @@ void exit_event_decode_key(struct perf_kvm_stat *kvm,
 
 bool kvm_exit_event(struct perf_evsel *evsel);
 bool kvm_entry_event(struct perf_evsel *evsel);
+int setup_kvm_events_tp(struct perf_kvm_stat *kvm);
 
 #define define_exit_reasons_table(name, symbols)	\
 	static struct exit_reasons_table name[] = {	\
-- 
1.9.3
