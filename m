Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D27431A0CC8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 01:04:20 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 20 Apr 2015 20:34:17 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 02D8FE0059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 20:36:52 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3KF4EQg63307948
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 20:34:14 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3KEf6hS018998
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 20:11:06 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/5] perf/kvm: HCALL events analysis
Date: Mon, 20 Apr 2015 20:32:15 +0530
Message-Id: <1429542135-10632-6-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1429542135-10632-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1429542135-10632-1-git-send-email-hemant@linux.vnet.ibm.com>
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, acme@kernel.org, paulus@samba.org,
 warrier@linux.vnet.ibm.com, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds KVM hypervisor call analysis to perf for powerpc.
 - Trace hcall events :
  perf kvm stat record

 - Show the results :
  perf kvm stat report --event=hcall

The results show the number of hypervisor calls from the guest grouped
into their respective reasons displayed with the frequency.

This patch makes use of two additional tracepoints "kvm_hv:kvm_hcall_enter"
and "kvm_hv:kvm_hcall_exit". It uses the pSeries hypervisor codes
exported through uapi to classify the hcalls into their respective reasons.

 # pgrep qemu
A sample output :
19378
60515

2 VMs running.

 # perf kvm stat record -a
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.153 MB perf.data.guest (39624 samples) ]

 # perf kvm stat report -p 60515 --event=hcall
Analyze events for pid(s) 60515, all VCPUs:

         HCALL-EVENT    Samples  Samples%     Time%    Min Time    Max Time         Avg time

        H_VIO_SIGNAL       1034    38.44%    15.77%      0.36us      1.59us      0.44us ( +-   0.66% )
          H_SEND_CRQ        652    24.24%    10.97%      0.39us      1.84us      0.49us ( +-   1.20% )
               H_IPI        523    19.44%    62.05%      1.35us     19.70us      3.44us ( +-   2.88% )
     H_PUT_TERM_CHAR        411    15.28%     8.03%      0.38us      3.77us      0.57us ( +-   1.61% )
     H_GET_TERM_CHAR         50     1.86%     0.99%      0.40us      0.98us      0.57us ( +-   3.37% )
               H_EOI         20     0.74%     2.19%      2.22us      4.72us      3.17us ( +-   5.96% )

Total Samples:2690, Total events handled time:2896.94us.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/kvm_perf.h |  4 +++
 tools/perf/arch/powerpc/util/kvm-stat.c  | 61 ++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h b/arch/powerpc/include/uapi/asm/kvm_perf.h
index 30fa670..440902e 100644
--- a/arch/powerpc/include/uapi/asm/kvm_perf.h
+++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
@@ -3,6 +3,7 @@
 
 #include <asm/trace_book3s.h>
 #include <asm/kvm.h>
+#include <asm/trace_hcall.h>
 
 #define DECODE_STR_LEN 20
 
@@ -11,5 +12,8 @@
 #define KVM_ENTRY_TRACE "kvm_hv:kvm_guest_enter"
 #define KVM_EXIT_TRACE "kvm_hv:kvm_guest_exit"
 #define KVM_EXIT_REASON "trap"
+#define KVM_HCALL_ENTRY_TRACE "kvm_hv:kvm_hcall_enter"
+#define KVM_HCALL_EXIT_TRACE "kvm_hv:kvm_hcall_exit"
+#define KVM_HCALL_REASON "req"
 
 #endif /* _ASM_POWERPC_KVM_PERF_H */
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 62cdcc1..685201c 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -1,7 +1,9 @@
 #include "../../util/kvm-stat.h"
 #include <asm/kvm_perf.h>
+#include "../../util/debug.h"
 
 define_exit_reasons_table(hv_exit_reasons, kvm_trace_symbol_exit);
+define_exit_reasons_table(hcall_reasons, kvm_trace_symbol_hcall);
 
 static struct kvm_events_ops exit_events = {
 	.is_begin_event = exit_event_begin,
@@ -10,14 +12,73 @@ static struct kvm_events_ops exit_events = {
 	.name = "VM-EXIT"
 };
 
+static void hcall_event_get_key(struct perf_evsel *evsel,
+				struct perf_sample *sample,
+				struct event_key *key)
+{
+	key->info = 0;
+	key->key = perf_evsel__intval(evsel, sample, KVM_HCALL_REASON);
+}
+
+static const char *get_exit_reason(u64 exit_code)
+{
+	struct exit_reasons_table *tbl = hcall_reasons;
+
+	while (tbl->reason != NULL) {
+		if (tbl->exit_code == exit_code)
+			return tbl->reason;
+		tbl++;
+	}
+
+	pr_err("Unknown kvm hcall exit code: %lld\n",
+	       (unsigned long long)exit_code);
+	return "UNKNOWN";
+}
+
+static bool hcall_event_end(struct perf_evsel *evsel,
+			    struct perf_sample *sample __maybe_unused,
+			    struct event_key *key __maybe_unused)
+{
+	return (!strcmp(evsel->name, KVM_HCALL_EXIT_TRACE));
+}
+
+static bool hcall_event_begin(struct perf_evsel *evsel,
+			      struct perf_sample *sample, struct event_key *key)
+{
+	if (!strcmp(evsel->name, KVM_HCALL_ENTRY_TRACE)) {
+		hcall_event_get_key(evsel, sample, key);
+		return true;
+	}
+
+        return false;
+}
+static void hcall_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
+				   struct event_key *key,
+				   char *decode)
+{
+	const char *hcall_reason = get_exit_reason(key->key);
+
+	scnprintf(decode, DECODE_STR_LEN, "%s", hcall_reason);
+}
+
+static struct kvm_events_ops hcall_events = {
+	.is_begin_event = hcall_event_begin,
+	.is_end_event = hcall_event_end,
+	.decode_key = hcall_event_decode_key,
+	.name = "HCALL-EVENT",
+};
+
 const char *const kvm_events_tp[] = {
 	"kvm_hv:kvm_guest_exit",
 	"kvm_hv:kvm_guest_enter",
+	"kvm_hv:kvm_hcall_enter",
+	"kvm_hv:kvm_hcall_exit",
 	NULL,
 };
 
 struct kvm_reg_events_ops kvm_reg_events_ops[] = {
 	{ .name = "vmexit", .ops = &exit_events },
+	{ .name = "hcall", .ops = &hcall_events },
 	{ NULL, NULL },
 };
 
-- 
1.9.3
