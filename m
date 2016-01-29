Return-Path: <BATV+32fd6bae951f336d06c5+4541+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C8E161A0445
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 08:18:22 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Alexander Yarygin <yarygin@linux.vnet.ibm.com>,
 David Ahern <dsahern@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Scott  Wood <scottwood@freescale.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/16] perf kvm/powerpc: Add support for HCALL reasons
Date: Fri, 29 Jan 2016 18:17:52 -0300
Message-Id: <1454102273-16431-16-git-send-email-acme@kernel.org>
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

Powerpc provides hcall events that also provides insights into guest
behaviour. Enhance perf kvm stat to record and analyze hcall events.

 - To trace hcall events :
  perf kvm stat record

 - To show the results :
  perf kvm stat report --event=hcall

The result shows the number of hypervisor calls from the guest grouped
by their respective reasons displayed with the frequency.

This patch makes use of two additional tracepoints
"kvm_hv:kvm_hcall_enter" and "kvm_hv:kvm_hcall_exit". To map the hcall
codes to their respective names, it needs a mapping. Such mapping is
added in this patch in book3s_hcalls.h.

 # pgrep qemu
A sample output :
19378
60515

2 VMs running.

 # perf kvm stat record -a
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.153 MB perf.data.guest (39624
samples) ]

 # perf kvm stat report -p 60515 --event=hcall

Analyze events for all VMs, all VCPUs:

    HCALL-EVENT Samples Samples% Time% MinTime MaxTime  AvgTime

          H_IPI     822  66.08% 88.10% 0.63us  11.38us 2.05us (+- 1.42%)
     H_SEND_CRQ     144  11.58%  3.77% 0.41us   0.88us 0.50us (+- 1.47%)
   H_VIO_SIGNAL     118   9.49%  2.86% 0.37us   0.83us 0.47us (+- 1.43%)
H_PUT_TERM_CHAR      76   6.11%  2.07% 0.37us   0.90us 0.52us (+- 2.43%)
H_GET_TERM_CHAR      74   5.95%  2.23% 0.37us   1.70us 0.58us (+- 4.77%)
         H_RTAS       6   0.48%  0.85% 1.10us   9.25us 2.70us (+-48.57%)
      H_PERFMON       4   0.32%  0.12% 0.41us   0.96us 0.59us (+-20.92%)

Total Samples:1244, Total events handled time:1916.69us.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Scott  Wood <scottwood@freescale.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1453962787-15376-4-git-send-email-hemant@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/book3s_hcalls.h | 123 +++++++++++++++++++++++++++
 tools/perf/arch/powerpc/util/kvm-stat.c      |  65 +++++++++++++-
 2 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/powerpc/util/book3s_hcalls.h

diff --git a/tools/perf/arch/powerpc/util/book3s_hcalls.h b/tools/perf/arch/powerpc/util/book3s_hcalls.h
new file mode 100644
index 000000000000..0dd6b7f2d44f
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/book3s_hcalls.h
@@ -0,0 +1,123 @@
+#ifndef ARCH_PERF_BOOK3S_HV_HCALLS_H
+#define ARCH_PERF_BOOK3S_HV_HCALLS_H
+
+/*
+ * PowerPC HCALL codes : hcall code to name mapping
+ */
+#define kvm_trace_symbol_hcall \
+	{0x4, "H_REMOVE"},					\
+	{0x8, "H_ENTER"},					\
+	{0xc, "H_READ"},					\
+	{0x10, "H_CLEAR_MOD"},					\
+	{0x14, "H_CLEAR_REF"},					\
+	{0x18, "H_PROTECT"},					\
+	{0x1c, "H_GET_TCE"},					\
+	{0x20, "H_PUT_TCE"},					\
+	{0x24, "H_SET_SPRG0"},					\
+	{0x28, "H_SET_DABR"},					\
+	{0x2c, "H_PAGE_INIT"},					\
+	{0x30, "H_SET_ASR"},					\
+	{0x34, "H_ASR_ON"},					\
+	{0x38, "H_ASR_OFF"},					\
+	{0x3c, "H_LOGICAL_CI_LOAD"},				\
+	{0x40, "H_LOGICAL_CI_STORE"},				\
+	{0x44, "H_LOGICAL_CACHE_LOAD"},				\
+	{0x48, "H_LOGICAL_CACHE_STORE"},			\
+	{0x4c, "H_LOGICAL_ICBI"},				\
+	{0x50, "H_LOGICAL_DCBF"},				\
+	{0x54, "H_GET_TERM_CHAR"},				\
+	{0x58, "H_PUT_TERM_CHAR"},				\
+	{0x5c, "H_REAL_TO_LOGICAL"},				\
+	{0x60, "H_HYPERVISOR_DATA"},				\
+	{0x64, "H_EOI"},					\
+	{0x68, "H_CPPR"},					\
+	{0x6c, "H_IPI"},					\
+	{0x70, "H_IPOLL"},					\
+	{0x74, "H_XIRR"},					\
+	{0x78, "H_MIGRATE_DMA"},				\
+	{0x7c, "H_PERFMON"},					\
+	{0xdc, "H_REGISTER_VPA"},				\
+	{0xe0, "H_CEDE"},					\
+	{0xe4, "H_CONFER"},					\
+	{0xe8, "H_PROD"},					\
+	{0xec, "H_GET_PPP"},					\
+	{0xf0, "H_SET_PPP"},					\
+	{0xf4, "H_PURR"},					\
+	{0xf8, "H_PIC"},					\
+	{0xfc, "H_REG_CRQ"},					\
+	{0x100, "H_FREE_CRQ"},					\
+	{0x104, "H_VIO_SIGNAL"},				\
+	{0x108, "H_SEND_CRQ"},					\
+	{0x110, "H_COPY_RDMA"},					\
+	{0x114, "H_REGISTER_LOGICAL_LAN"},			\
+	{0x118, "H_FREE_LOGICAL_LAN"},				\
+	{0x11c, "H_ADD_LOGICAL_LAN_BUFFER"},			\
+	{0x120, "H_SEND_LOGICAL_LAN"},				\
+	{0x124, "H_BULK_REMOVE"},				\
+	{0x130, "H_MULTICAST_CTRL"},				\
+	{0x134, "H_SET_XDABR"},					\
+	{0x138, "H_STUFF_TCE"},					\
+	{0x13c, "H_PUT_TCE_INDIRECT"},				\
+	{0x14c, "H_CHANGE_LOGICAL_LAN_MAC"},			\
+	{0x150, "H_VTERM_PARTNER_INFO"},			\
+	{0x154, "H_REGISTER_VTERM"},				\
+	{0x158, "H_FREE_VTERM"},				\
+	{0x15c, "H_RESET_EVENTS"},				\
+	{0x160, "H_ALLOC_RESOURCE"},				\
+	{0x164, "H_FREE_RESOURCE"},				\
+	{0x168, "H_MODIFY_QP"},					\
+	{0x16c, "H_QUERY_QP"},					\
+	{0x170, "H_REREGISTER_PMR"},				\
+	{0x174, "H_REGISTER_SMR"},				\
+	{0x178, "H_QUERY_MR"},					\
+	{0x17c, "H_QUERY_MW"},					\
+	{0x180, "H_QUERY_HCA"},					\
+	{0x184, "H_QUERY_PORT"},				\
+	{0x188, "H_MODIFY_PORT"},				\
+	{0x18c, "H_DEFINE_AQP1"},				\
+	{0x190, "H_GET_TRACE_BUFFER"},				\
+	{0x194, "H_DEFINE_AQP0"},				\
+	{0x198, "H_RESIZE_MR"},					\
+	{0x19c, "H_ATTACH_MCQP"},				\
+	{0x1a0, "H_DETACH_MCQP"},				\
+	{0x1a4, "H_CREATE_RPT"},				\
+	{0x1a8, "H_REMOVE_RPT"},				\
+	{0x1ac, "H_REGISTER_RPAGES"},				\
+	{0x1b0, "H_DISABLE_AND_GETC"},				\
+	{0x1b4, "H_ERROR_DATA"},				\
+	{0x1b8, "H_GET_HCA_INFO"},				\
+	{0x1bc, "H_GET_PERF_COUNT"},				\
+	{0x1c0, "H_MANAGE_TRACE"},				\
+	{0x1d4, "H_FREE_LOGICAL_LAN_BUFFER"},			\
+	{0x1d8, "H_POLL_PENDING"},				\
+	{0x1e4, "H_QUERY_INT_STATE"},				\
+	{0x244, "H_ILLAN_ATTRIBUTES"},				\
+	{0x250, "H_MODIFY_HEA_QP"},				\
+	{0x254, "H_QUERY_HEA_QP"},				\
+	{0x258, "H_QUERY_HEA"},					\
+	{0x25c, "H_QUERY_HEA_PORT"},				\
+	{0x260, "H_MODIFY_HEA_PORT"},				\
+	{0x264, "H_REG_BCMC"},					\
+	{0x268, "H_DEREG_BCMC"},				\
+	{0x26c, "H_REGISTER_HEA_RPAGES"},			\
+	{0x270, "H_DISABLE_AND_GET_HEA"},			\
+	{0x274, "H_GET_HEA_INFO"},				\
+	{0x278, "H_ALLOC_HEA_RESOURCE"},			\
+	{0x284, "H_ADD_CONN"},					\
+	{0x288, "H_DEL_CONN"},					\
+	{0x298, "H_JOIN"},					\
+	{0x2a4, "H_VASI_STATE"},				\
+	{0x2b0, "H_ENABLE_CRQ"},				\
+	{0x2b8, "H_GET_EM_PARMS"},				\
+	{0x2d0, "H_SET_MPP"},					\
+	{0x2d4, "H_GET_MPP"},					\
+	{0x2ec, "H_HOME_NODE_ASSOCIATIVITY"},			\
+	{0x2f4, "H_BEST_ENERGY"},				\
+	{0x2fc, "H_XIRR_X"},					\
+	{0x300, "H_RANDOM"},					\
+	{0x304, "H_COP"},					\
+	{0x314, "H_GET_MPP_X"},					\
+	{0x31c, "H_SET_MODE"},					\
+	{0xf000, "H_RTAS"}					\
+
+#endif
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 27bc559b8b3a..74eee30398f8 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -1,9 +1,11 @@
 #include "util/kvm-stat.h"
 #include "util/parse-events.h"
+#include "util/debug.h"
 
 #include "book3s_hv_exits.h"
+#include "book3s_hcalls.h"
 
-#define NR_TPS 2
+#define NR_TPS 4
 
 const char *vcpu_id_str = "vcpu_id";
 const int decode_str_len = 40;
@@ -11,17 +13,77 @@ const char *kvm_entry_trace = "kvm_hv:kvm_guest_enter";
 const char *kvm_exit_trace = "kvm_hv:kvm_guest_exit";
 
 define_exit_reasons_table(hv_exit_reasons, kvm_trace_symbol_exit);
+define_exit_reasons_table(hcall_reasons, kvm_trace_symbol_hcall);
 
 /* Tracepoints specific to ppc_book3s_hv */
 const char *ppc_book3s_hv_kvm_tp[] = {
 	"kvm_hv:kvm_guest_enter",
 	"kvm_hv:kvm_guest_exit",
+	"kvm_hv:kvm_hcall_enter",
+	"kvm_hv:kvm_hcall_exit",
+	NULL,
 };
 
 /* 1 extra placeholder for NULL */
 const char *kvm_events_tp[NR_TPS + 1];
 const char *kvm_exit_reason;
 
+static void hcall_event_get_key(struct perf_evsel *evsel,
+				struct perf_sample *sample,
+				struct event_key *key)
+{
+	key->info = 0;
+	key->key = perf_evsel__intval(evsel, sample, "req");
+}
+
+static const char *get_hcall_exit_reason(u64 exit_code)
+{
+	struct exit_reasons_table *tbl = hcall_reasons;
+
+	while (tbl->reason != NULL) {
+		if (tbl->exit_code == exit_code)
+			return tbl->reason;
+		tbl++;
+	}
+
+	pr_debug("Unknown hcall code: %lld\n",
+	       (unsigned long long)exit_code);
+	return "UNKNOWN";
+}
+
+static bool hcall_event_end(struct perf_evsel *evsel,
+			    struct perf_sample *sample __maybe_unused,
+			    struct event_key *key __maybe_unused)
+{
+	return (!strcmp(evsel->name, kvm_events_tp[3]));
+}
+
+static bool hcall_event_begin(struct perf_evsel *evsel,
+			      struct perf_sample *sample, struct event_key *key)
+{
+	if (!strcmp(evsel->name, kvm_events_tp[2])) {
+		hcall_event_get_key(evsel, sample, key);
+		return true;
+	}
+
+	return false;
+}
+static void hcall_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
+				   struct event_key *key,
+				   char *decode)
+{
+	const char *hcall_reason = get_hcall_exit_reason(key->key);
+
+	scnprintf(decode, decode_str_len, "%s", hcall_reason);
+}
+
+static struct kvm_events_ops hcall_events = {
+	.is_begin_event = hcall_event_begin,
+	.is_end_event = hcall_event_end,
+	.decode_key = hcall_event_decode_key,
+	.name = "HCALL-EVENT",
+};
+
 static struct kvm_events_ops exit_events = {
 	.is_begin_event = exit_event_begin,
 	.is_end_event = exit_event_end,
@@ -31,6 +93,7 @@ static struct kvm_events_ops exit_events = {
 
 struct kvm_reg_events_ops kvm_reg_events_ops[] = {
 	{ .name = "vmexit", .ops = &exit_events },
+	{ .name = "hcall", .ops = &hcall_events },
 	{ NULL, NULL },
 };
 
-- 
2.5.0
