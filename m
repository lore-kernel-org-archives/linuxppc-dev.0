Return-Path: <BATV+32fd6bae951f336d06c5+4541+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6A701A031E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 08:18:22 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Scott  Wood <scottwood@freescale.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/16] perf kvm/{x86,
 s390}: Remove dependency on uapi/kvm_perf.h
Date: Fri, 29 Jan 2016 18:17:49 -0300
Message-Id: <1454102273-16431-13-git-send-email-acme@kernel.org>
In-Reply-To: <1454102273-16431-1-git-send-email-acme@kernel.org>
References: <1454102273-16431-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hemant Kumar <hemant@linux.vnet.ibm.com>

Its better to remove the dependency on uapi/kvm_perf.h to allow dynamic
discovery of kvm events (if its needed). To do this, some extern
variables have been introduced with which we can keep the generic
functions generic.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Acked-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Acked-by: David Ahern <dsahern@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Scott  Wood <scottwood@freescale.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1453962787-15376-1-git-send-email-hemant@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/kvm-stat.c |  8 +++++++-
 tools/perf/arch/x86/util/kvm-stat.c  | 14 +++++++++++---
 tools/perf/builtin-kvm.c             | 20 ++++++++++----------
 tools/perf/util/kvm-stat.h           |  5 +++++
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index a5dbc07ec9dc..b85a94b19c25 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -10,7 +10,7 @@
  */
 
 #include "../../util/kvm-stat.h"
-#include <asm/kvm_perf.h>
+#include <asm/sie.h>
 
 define_exit_reasons_table(sie_exit_reasons, sie_intercept_code);
 define_exit_reasons_table(sie_icpt_insn_codes, icpt_insn_codes);
@@ -18,6 +18,12 @@ define_exit_reasons_table(sie_sigp_order_codes, sigp_order_codes);
 define_exit_reasons_table(sie_diagnose_codes, diagnose_codes);
 define_exit_reasons_table(sie_icpt_prog_codes, icpt_prog_codes);
 
+const char *vcpu_id_str = "id";
+const int decode_str_len = 40;
+const char *kvm_exit_reason = "icptcode";
+const char *kvm_entry_trace = "kvm:kvm_s390_sie_enter";
+const char *kvm_exit_trace = "kvm:kvm_s390_sie_exit";
+
 static void event_icpt_insn_get_key(struct perf_evsel *evsel,
 				    struct perf_sample *sample,
 				    struct event_key *key)
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 14e4e668fad7..babefda4c862 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -1,5 +1,7 @@
 #include "../../util/kvm-stat.h"
-#include <asm/kvm_perf.h>
+#include <asm/svm.h>
+#include <asm/vmx.h>
+#include <asm/kvm.h>
 
 define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);
 define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
@@ -11,6 +13,12 @@ static struct kvm_events_ops exit_events = {
 	.name = "VM-EXIT"
 };
 
+const char *vcpu_id_str = "vcpu_id";
+const int decode_str_len = 20;
+const char *kvm_exit_reason = "exit_reason";
+const char *kvm_entry_trace = "kvm:kvm_entry";
+const char *kvm_exit_trace = "kvm:kvm_exit";
+
 /*
  * For the mmio events, we treat:
  * the time of MMIO write: kvm_mmio(KVM_TRACE_MMIO_WRITE...) -> kvm_entry
@@ -65,7 +73,7 @@ static void mmio_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
 				  struct event_key *key,
 				  char *decode)
 {
-	scnprintf(decode, DECODE_STR_LEN, "%#lx:%s",
+	scnprintf(decode, decode_str_len, "%#lx:%s",
 		  (unsigned long)key->key,
 		  key->info == KVM_TRACE_MMIO_WRITE ? "W" : "R");
 }
@@ -109,7 +117,7 @@ static void ioport_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
 				    struct event_key *key,
 				    char *decode)
 {
-	scnprintf(decode, DECODE_STR_LEN, "%#llx:%s",
+	scnprintf(decode, decode_str_len, "%#llx:%s",
 		  (unsigned long long)key->key,
 		  key->info ? "POUT" : "PIN");
 }
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 4418d9214872..ab5645cf39d2 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -30,7 +30,6 @@
 #include <math.h>
 
 #ifdef HAVE_KVM_STAT_SUPPORT
-#include <asm/kvm_perf.h>
 #include "util/kvm-stat.h"
 
 void exit_event_get_key(struct perf_evsel *evsel,
@@ -38,12 +37,12 @@ void exit_event_get_key(struct perf_evsel *evsel,
 			struct event_key *key)
 {
 	key->info = 0;
-	key->key = perf_evsel__intval(evsel, sample, KVM_EXIT_REASON);
+	key->key = perf_evsel__intval(evsel, sample, kvm_exit_reason);
 }
 
 bool kvm_exit_event(struct perf_evsel *evsel)
 {
-	return !strcmp(evsel->name, KVM_EXIT_TRACE);
+	return !strcmp(evsel->name, kvm_exit_trace);
 }
 
 bool exit_event_begin(struct perf_evsel *evsel,
@@ -59,7 +58,7 @@ bool exit_event_begin(struct perf_evsel *evsel,
 
 bool kvm_entry_event(struct perf_evsel *evsel)
 {
-	return !strcmp(evsel->name, KVM_ENTRY_TRACE);
+	return !strcmp(evsel->name, kvm_entry_trace);
 }
 
 bool exit_event_end(struct perf_evsel *evsel,
@@ -91,7 +90,7 @@ void exit_event_decode_key(struct perf_kvm_stat *kvm,
 	const char *exit_reason = get_exit_reason(kvm, key->exit_reasons,
 						  key->key);
 
-	scnprintf(decode, DECODE_STR_LEN, "%s", exit_reason);
+	scnprintf(decode, decode_str_len, "%s", exit_reason);
 }
 
 static bool register_kvm_events_ops(struct perf_kvm_stat *kvm)
@@ -357,7 +356,7 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
 	time_diff = sample->time - time_begin;
 
 	if (kvm->duration && time_diff > kvm->duration) {
-		char decode[DECODE_STR_LEN];
+		char decode[decode_str_len];
 
 		kvm->events_ops->decode_key(kvm, &event->key, decode);
 		if (!skip_event(decode)) {
@@ -385,7 +384,8 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
 			return NULL;
 		}
 
-		vcpu_record->vcpu_id = perf_evsel__intval(evsel, sample, VCPU_ID);
+		vcpu_record->vcpu_id = perf_evsel__intval(evsel, sample,
+							  vcpu_id_str);
 		thread__set_priv(thread, vcpu_record);
 	}
 
@@ -574,7 +574,7 @@ static void show_timeofday(void)
 
 static void print_result(struct perf_kvm_stat *kvm)
 {
-	char decode[DECODE_STR_LEN];
+	char decode[decode_str_len];
 	struct kvm_event *event;
 	int vcpu = kvm->trace_vcpu;
 
@@ -585,7 +585,7 @@ static void print_result(struct perf_kvm_stat *kvm)
 
 	pr_info("\n\n");
 	print_vcpu_info(kvm);
-	pr_info("%*s ", DECODE_STR_LEN, kvm->events_ops->name);
+	pr_info("%*s ", decode_str_len, kvm->events_ops->name);
 	pr_info("%10s ", "Samples");
 	pr_info("%9s ", "Samples%");
 
@@ -604,7 +604,7 @@ static void print_result(struct perf_kvm_stat *kvm)
 		min = get_event_min(event, vcpu);
 
 		kvm->events_ops->decode_key(kvm, &event->key, decode);
-		pr_info("%*s ", DECODE_STR_LEN, decode);
+		pr_info("%*s ", decode_str_len, decode);
 		pr_info("%10llu ", (unsigned long long)ecount);
 		pr_info("%8.2f%% ", (double)ecount / kvm->total_count * 100);
 		pr_info("%8.2f%% ", (double)etime / kvm->total_time * 100);
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index ae825d4ec110..dd55548ef66a 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -136,5 +136,10 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid);
 extern const char * const kvm_events_tp[];
 extern struct kvm_reg_events_ops kvm_reg_events_ops[];
 extern const char * const kvm_skip_events[];
+extern const char *vcpu_id_str;
+extern const int decode_str_len;
+extern const char *kvm_exit_reason;
+extern const char *kvm_entry_trace;
+extern const char *kvm_exit_trace;
 
 #endif /* __PERF_KVM_STAT_H */
-- 
2.5.0
