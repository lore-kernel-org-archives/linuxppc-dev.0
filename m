Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F5C51A08B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 02:06:04 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 02:06:03 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ED2792CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 02:06:01 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6GG5rFs459234
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 02:06:01 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6GG5Twm018873
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 02:05:29 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, mingo@kernel.org,
 mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org, scottwood@freescale.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v5 2/2] perf/kvm: Support HCALL events
Date: Thu, 16 Jul 2015 21:34:52 +0530
Message-Id: <1437062692-16642-2-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1437062692-16642-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1437062692-16642-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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

Note that this patch has a dependency on 
"perf,kvm/ppc: Add hcall related info to kvm_perf.h" which adds the
hcall related tracepoints to kvm_perf.h to let "perf kvm stat" know
about these tracepoints.

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
This patch has a direct dependency on :
http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg91605.html

Changes:
- Added definitions for hcall code to hcall reason mapping in the userspace side.

 tools/perf/arch/powerpc/util/book3s_hcalls.h | 123 +++++++++++++++++++++++++++
 tools/perf/arch/powerpc/util/kvm-stat.c      |  64 ++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 tools/perf/arch/powerpc/util/book3s_hcalls.h

diff --git a/tools/perf/arch/powerpc/util/book3s_hcalls.h b/tools/perf/arch/powerpc/util/book3s_hcalls.h
new file mode 100644
index 0000000..3d50def
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/book3s_hcalls.h
@@ -0,0 +1,123 @@
+#ifndef ARCH_PERF_BOOK3S_HCALLS_H
+#define ARCH_PERF_BOOK3S_HCALLS_H
+
+/*
+ * PowerPC HCALL codes : hcall name to reason mapping
+ */
+#define kvm_trace_symbol_hcall \
+	{0x4,"H_REMOVE"},				\
+	{0x8,"H_ENTER"},				\
+	{0xc,"H_READ"},					\
+	{0x10,"H_CLEAR_MOD"},				\
+	{0x14,"H_CLEAR_REF"},				\
+	{0x18,"H_PROTECT"},				\
+	{0x1c,"H_GET_TCE"},				\
+	{0x20,"H_PUT_TCE"},				\
+	{0x24,"H_SET_SPRG0"},				\
+	{0x28,"H_SET_DABR"},				\
+	{0x2c,"H_PAGE_INIT"},				\
+	{0x30,"H_SET_ASR"},				\
+	{0x34,"H_ASR_ON"},				\
+	{0x38,"H_ASR_OFF"},				\
+	{0x3c,"H_LOGICAL_CI_LOAD"},			\
+	{0x40,"H_LOGICAL_CI_STORE"},			\
+	{0x44,"H_LOGICAL_CACHE_LOAD"},			\
+	{0x48,"H_LOGICAL_CACHE_STORE"},			\
+	{0x4c,"H_LOGICAL_ICBI"},			\
+	{0x50,"H_LOGICAL_DCBF"},			\
+	{0x54,"H_GET_TERM_CHAR"},			\
+	{0x58,"H_PUT_TERM_CHAR"},			\
+	{0x5c,"H_REAL_TO_LOGICAL"},			\
+	{0x60,"H_HYPERVISOR_DATA"},			\
+	{0x64,"H_EOI"},					\
+	{0x68,"H_CPPR"},				\
+	{0x6c,"H_IPI"},					\
+	{0x70,"H_IPOLL"},				\
+	{0x74,"H_XIRR"},				\
+	{0x78,"H_MIGRATE_DMA"},				\
+	{0x7c,"H_PERFMON"},				\
+	{0xdc,"H_REGISTER_VPA"},			\
+	{0xe0,"H_CEDE"},				\
+	{0xe4,"H_CONFER"},				\
+	{0xe8,"H_PROD"},				\
+	{0xec,"H_GET_PPP"},				\
+	{0xf0,"H_SET_PPP"},				\
+	{0xf4,"H_PURR"},				\
+	{0xf8,"H_PIC"},					\
+	{0xfc,"H_REG_CRQ"},				\
+	{0x100,"H_FREE_CRQ"},				\
+	{0x104,"H_VIO_SIGNAL"},				\
+	{0x108,"H_SEND_CRQ"},				\
+	{0x110,"H_COPY_RDMA"},				\
+	{0x114,"H_REGISTER_LOGICAL_LAN"},		\
+	{0x118,"H_FREE_LOGICAL_LAN"},			\
+	{0x11c,"H_ADD_LOGICAL_LAN_BUFFER"},		\
+	{0x120,"H_SEND_LOGICAL_LAN"},			\
+	{0x124,"H_BULK_REMOVE"},			\
+	{0x130,"H_MULTICAST_CTRL"},			\
+	{0x134,"H_SET_XDABR"},				\
+	{0x138,"H_STUFF_TCE"},				\
+	{0x13c,"H_PUT_TCE_INDIRECT"},			\
+	{0x14c,"H_CHANGE_LOGICAL_LAN_MAC"},		\
+	{0x150,"H_VTERM_PARTNER_INFO"},			\
+	{0x154,"H_REGISTER_VTERM"},			\
+	{0x158,"H_FREE_VTERM"},				\
+	{0x15c,"H_RESET_EVENTS"},			\
+	{0x160,"H_ALLOC_RESOURCE"},			\
+	{0x164,"H_FREE_RESOURCE"},			\
+	{0x168,"H_MODIFY_QP"},				\
+	{0x16c,"H_QUERY_QP"},				\
+	{0x170,"H_REREGISTER_PMR"},			\
+	{0x174,"H_REGISTER_SMR"},			\
+	{0x178,"H_QUERY_MR"},				\
+	{0x17c,"H_QUERY_MW"},				\
+	{0x180,"H_QUERY_HCA"},				\
+	{0x184,"H_QUERY_PORT"},				\
+	{0x188,"H_MODIFY_PORT"},			\
+	{0x18c,"H_DEFINE_AQP1"},			\
+	{0x190,"H_GET_TRACE_BUFFER"},			\
+	{0x194,"H_DEFINE_AQP0"},			\
+	{0x198,"H_RESIZE_MR"},				\
+	{0x19c,"H_ATTACH_MCQP"},			\
+	{0x1a0,"H_DETACH_MCQP"},			\
+	{0x1a4,"H_CREATE_RPT"},				\
+	{0x1a8,"H_REMOVE_RPT"},				\
+	{0x1ac,"H_REGISTER_RPAGES"},			\
+	{0x1b0,"H_DISABLE_AND_GETC"},			\
+	{0x1b4,"H_ERROR_DATA"},				\
+	{0x1b8,"H_GET_HCA_INFO"},			\
+	{0x1bc,"H_GET_PERF_COUNT"},			\
+	{0x1c0,"H_MANAGE_TRACE"},			\
+	{0x1d4,"H_FREE_LOGICAL_LAN_BUFFER"},		\
+	{0x1d8,"H_POLL_PENDING"},			\
+	{0x1e4,"H_QUERY_INT_STATE"},			\
+	{0x244,"H_ILLAN_ATTRIBUTES"},			\
+	{0x250,"H_MODIFY_HEA_QP"},			\
+	{0x254,"H_QUERY_HEA_QP"},			\
+	{0x258,"H_QUERY_HEA"},				\
+	{0x25c,"H_QUERY_HEA_PORT"},			\
+	{0x260,"H_MODIFY_HEA_PORT"},			\
+	{0x264,"H_REG_BCMC"},				\
+	{0x268,"H_DEREG_BCMC"},				\
+	{0x26c,"H_REGISTER_HEA_RPAGES"},		\
+	{0x270,"H_DISABLE_AND_GET_HEA"},		\
+	{0x274,"H_GET_HEA_INFO"},			\
+	{0x278,"H_ALLOC_HEA_RESOURCE"},			\
+	{0x284,"H_ADD_CONN"},				\
+	{0x288,"H_DEL_CONN"},				\
+	{0x298,"H_JOIN"},				\
+	{0x2a4,"H_VASI_STATE"},				\
+	{0x2b0,"H_ENABLE_CRQ"},				\
+	{0x2b8,"H_GET_EM_PARMS"},			\
+	{0x2d0,"H_SET_MPP"},				\
+	{0x2d4,"H_GET_MPP"},				\
+	{0x2ec,"H_HOME_NODE_ASSOCIATIVITY"},		\
+	{0x2f4,"H_BEST_ENERGY"},			\
+	{0x2fc,"H_XIRR_X"},				\
+	{0x300,"H_RANDOM"},				\
+	{0x304,"H_COP"},				\
+	{0x314,"H_GET_MPP_X"},				\
+	{0x31c,"H_SET_MODE"},				\
+	{0xf000,"H_RTAS"}				\
+
+#endif
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index d0e1930..eafa9a0 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -1,7 +1,11 @@
 #include "../../util/kvm-stat.h"
 #include "book3s_exits.h"
+#include "book3s_hcalls.h"
+#include <asm/kvm_perf.h>
+#include "../../util/debug.h"
 
 define_exit_reasons_table(hv_exit_reasons, kvm_trace_symbol_exit);
+define_exit_reasons_table(hcall_reasons, kvm_trace_symbol_hcall);
 
 static struct kvm_events_ops exit_events = {
 	.is_begin_event = exit_event_begin,
@@ -10,14 +14,74 @@ static struct kvm_events_ops exit_events = {
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
