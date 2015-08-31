Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77F611A1F41
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 16:55:32 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 31 Aug 2015 16:55:31 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 28BDF3578047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 16:55:28 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7V6tCIw66912472
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 16:55:20 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7V6stVX026156
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 16:54:55 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, scottwood@freescale.com, acme@kernel.org,
 mingo@kernel.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v6 2/3] perf,kvm/powerpc: Port perf kvm stat to powerpc
Date: Mon, 31 Aug 2015 12:24:27 +0530
Message-Id: <1441004068-11306-2-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1441004068-11306-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1441004068-11306-1-git-send-email-hemant@linux.vnet.ibm.com>
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
patch discovers the machine type dynamically from /proc/cpuinfo's
"machine" tag  and accordingly sets kvm tracepoints. Right now, it only
supports Book3S_HV tracepoints.

To analyze the different exits, group them and present them (in a slight
descriptive way) to the user, we need a mapping between the "exit
code" (dumped in the kvm_guest_exit tracepoint data) and to its related
Interrupt vector description (exit reason). This patch adds this mapping
in book3s_hv_exits.h.

It records on two available KVM tracepoints :
"kvm_hv:kvm_guest_exit" and "kvm_hv:kvm_guest_enter" exported through
arch/powerpc/include/uapi/asm/kvm_perf.h.

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
This patch has a direct dependency on :
http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg93620.html

Changes since v5 :
- Added a dynamic discovery check for machine type.
- Made the kvm tracepoints recording/reporting conditional on machine type.
  (Suggested by Scott Wood)

 tools/perf/arch/powerpc/Makefile               |   2 +
 tools/perf/arch/powerpc/util/Build             |   1 +
 tools/perf/arch/powerpc/util/book3s_hv_exits.h |  33 ++++++
 tools/perf/arch/powerpc/util/kvm-stat.c        | 151 +++++++++++++++++++++++++
 tools/perf/builtin-kvm.c                       |  16 ++-
 tools/perf/util/kvm-stat.h                     |   1 +
 6 files changed, 201 insertions(+), 3 deletions(-)
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
index 0000000..448bc51
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -0,0 +1,151 @@
+#include "../../util/kvm-stat.h"
+#include "book3s_hv_exits.h"
+#include <asm/kvm_perf.h>
+
+#define PPC_HV "PowerNV"
+#define KEY "machine"
+#define VM_ENTRY 0
+#define VM_EXIT 1
+#define NR_TPS 2
+
+/* Currently only supported on Book3S_HV machines */
+enum {
+	UNSUPPORTED = -1,
+	BOOK3S_HV = 0,
+} ppc_machine;
+
+define_exit_reasons_table(hv_exit_reasons, kvm_trace_symbol_exit);
+
+int ppc_type = UNSUPPORTED;
+const char *exit_reason;
+
+static struct kvm_events_ops exit_events = {
+	.is_begin_event = exit_event_begin,
+	.is_end_event = exit_event_end,
+	.decode_key = exit_event_decode_key,
+	.name = "VM-EXIT"
+};
+
+/* 1 extra placeholder for NULL */
+const char *kvm_events_tp[NR_TPS + 1];
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
+bool kvm_exit_event(struct perf_evsel *evsel)
+{
+	return !strncmp(evsel->name, kvm_events_tp[VM_EXIT],
+			strlen(kvm_events_tp[VM_EXIT]));
+}
+
+bool kvm_entry_event(struct perf_evsel *evsel)
+{
+	return !strncmp(evsel->name, kvm_events_tp[VM_ENTRY],
+			strlen(kvm_events_tp[VM_ENTRY]));
+}
+
+void exit_event_get_key(struct perf_evsel *evsel,
+			struct perf_sample *sample,
+			struct event_key *key)
+{
+	key->info = 0;
+	key->key = perf_evsel__intval(evsel, sample, exit_reason);
+}
+
+/*
+ * Read the /proc/cpuinfo and find out the machine type
+ */
+static int find_ppc_type(void)
+{
+	FILE *file;
+	char *s, *p, *buf = NULL;
+	size_t len;
+	int ret = UNSUPPORTED;
+
+	file = fopen("/proc/cpuinfo", "r");
+	if (!file)
+		return -1;
+
+	while (getline(&buf, &len, file) > 0) {
+		ret = strncmp(buf, KEY, strlen(KEY));
+		if (!ret)
+			break;
+	}
+
+	if (ret) {
+		ret = -1;
+		goto done;
+	}
+
+	s = buf;
+	p = strchr(buf, ':');
+	if (p && *(p + 1) == ' ' && *(p + 2))
+		s = p + 2;
+
+	p = strchr(s, '\n');
+	if (p)
+		*p = '\0';
+
+	/* s has the machine type now */
+	if (!strncmp(s, PPC_HV, strlen(PPC_HV))) {
+		ret = BOOK3S_HV;
+		ppc_type = ret;
+	}
+
+done:
+	free(buf);
+	fclose(file);
+	return ret;
+}
+
+/*
+ * Depending on the machine type, setup the KVM tracepoints
+ */
+static int setup_kvm_tp(void)
+{
+	int ret;
+
+	ret = find_ppc_type();
+	switch (ret) {
+	case BOOK3S_HV:
+		/* Tracepoints related to Book3S_HV machines */
+		kvm_events_tp[VM_ENTRY] = KVM_ENTRY_TRACE_HV;
+		kvm_events_tp[VM_EXIT] = KVM_EXIT_TRACE_HV;
+		kvm_events_tp[NR_TPS] = NULL;
+		exit_reason = KVM_EXIT_REASON_HV;
+		break;
+	default:
+		kvm_events_tp[0] = NULL;
+		ret = UNSUPPORTED;
+		exit_reason = NULL;
+	}
+	return ret;
+}
+
+int setup_kvm_events_tp(void)
+{
+	return setup_kvm_tp();
+}
+
+int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+{
+	int ret = 0;
+
+	ret = setup_kvm_tp();
+	if (ret == BOOK3S_HV) {
+		kvm->exit_reasons = hv_exit_reasons;
+		kvm->exit_reasons_isa = "HV";
+		ret = 0;
+	} else {
+		kvm->exit_reasons = NULL;
+		kvm->exit_reasons_isa = NULL;
+	}
+
+	return ret;
+}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index fc1cffb..87db36a 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -34,7 +34,7 @@
 #include <asm/kvm_perf.h>
 #include "util/kvm-stat.h"
 
-void exit_event_get_key(struct perf_evsel *evsel,
+void __weak exit_event_get_key(struct perf_evsel *evsel,
 			struct perf_sample *sample,
 			struct event_key *key)
 {
@@ -42,7 +42,7 @@ void exit_event_get_key(struct perf_evsel *evsel,
 	key->key = perf_evsel__intval(evsel, sample, KVM_EXIT_REASON);
 }
 
-bool kvm_exit_event(struct perf_evsel *evsel)
+bool __weak kvm_exit_event(struct perf_evsel *evsel)
 {
 	return !strcmp(evsel->name, KVM_EXIT_TRACE);
 }
@@ -58,7 +58,7 @@ bool exit_event_begin(struct perf_evsel *evsel,
 	return false;
 }
 
-bool kvm_entry_event(struct perf_evsel *evsel)
+bool __weak kvm_entry_event(struct perf_evsel *evsel)
 {
 	return !strcmp(evsel->name, KVM_ENTRY_TRACE);
 }
@@ -1125,6 +1125,11 @@ exit:
 	return ret;
 }
 
+int  __weak setup_kvm_events_tp(void)
+{
+	return 0;
+}
+
 #define STRDUP_FAIL_EXIT(s)		\
 	({	char *_p;		\
 	_p = strdup(s);		\
@@ -1149,7 +1154,12 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		NULL
 	};
 	const char * const *events_tp;
+	int ret;
+
 	events_tp_size = 0;
+	ret = setup_kvm_events_tp();
+	if (ret < 0)
+		return -EINVAL;
 
 	for (events_tp = kvm_events_tp; *events_tp; events_tp++)
 		events_tp_size++;
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 6384672..f8f778b 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -136,5 +136,6 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid);
 extern const char *kvm_events_tp[];
 extern struct kvm_reg_events_ops kvm_reg_events_ops[];
 extern const char * const kvm_skip_events[];
+int setup_kvm_events_tp(void);
 
 #endif /* __PERF_KVM_STAT_H */
-- 
1.9.3
