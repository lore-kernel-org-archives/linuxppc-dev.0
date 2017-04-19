Return-Path: <yao.jin@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Dgv6H7vzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 17:50:35 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 6/7] perf report: Show branch type statistics for stdio mode
Date: Wed, 19 Apr 2017 23:48:13 +0800
Message-Id: <1492616894-3635-7-git-send-email-yao.jin@linux.intel.com>
In-Reply-To: <1492616894-3635-1-git-send-email-yao.jin@linux.intel.com>
References: <1492616894-3635-1-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Show the branch type statistics at the end of perf report --stdio.

For example:
perf report --stdio

 JCC forward:  27.6%
JCC backward:  10.0%
    CROSS_4K:   0.0%
    CROSS_2M:  14.3%
         JCC:  37.6%
         JMP:   0.0%
     IND_JMP:   6.5%
        CALL:  26.6%
    IND_CALL:   0.0%
         RET:  29.3%

The branch types are:
---------------------
 JCC forward: Conditional forward jump
JCC backward: Conditional backward jump
         JMP: Jump imm
     IND_JMP: Jump reg/mem
        CALL: Call imm
    IND_CALL: Call reg/mem
         RET: Ret
     SYSCALL: Syscall
      SYSRET: Syscall return
         IRQ: HW interrupt/trap/fault
         INT: SW interrupt
        IRET: Return from interrupt
  FAR_BRANCH: Others not generic branch type

CROSS_4K and CROSS_2M:
----------------------
They are the metrics checking for branches cross 4K or 2MB pages.
It's an approximate computing. We don't know if the area is 4K or
2MB, so always compute both.

To make the output simple, if a branch crosses 2M area, CROSS_4K
will not be incremented.

Change log
----------

v5: Remove the unnecessary sort__mode checking in
    hist_iter__branch_callback().

v4: Comparing to previous version, the major changes are:

Add the computing of JCC forward/JCC backward and cross page checking
by using the from and to addresses.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/hist.c      |  5 +---
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c18158b..0050b13 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -38,6 +38,7 @@
 #include "arch/common.h"
 #include "util/time-utils.h"
 #include "util/auxtrace.h"
+#include "util/branch.h"
 
 #include <dlfcn.h>
 #include <linux/bitmap.h>
@@ -66,6 +67,7 @@ struct report {
 	u64			queue_size;
 	int			socket_filter;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+	struct branch_type_stat	brtype_stat;
 };
 
 static int report__config(const char *var, const char *value, void *cb)
@@ -144,6 +146,22 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	return err;
 }
 
+static int hist_iter__branch_callback(struct hist_entry_iter *iter,
+				      struct addr_location *al __maybe_unused,
+				      bool single __maybe_unused,
+				      void *arg)
+{
+	struct hist_entry *he = iter->he;
+	struct report *rep = arg;
+	struct branch_info *bi;
+
+	bi = he->branch_info;
+	branch_type_count(&rep->brtype_stat, &bi->flags,
+			  bi->from.addr, bi->to.addr);
+
+	return 0;
+}
+
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -182,6 +200,8 @@ static int process_sample_event(struct perf_tool *tool,
 		 */
 		if (!sample->branch_stack)
 			goto out_put;
+
+		iter.add_entry_cb = hist_iter__branch_callback;
 		iter.ops = &hist_iter_branch;
 	} else if (rep->mem_mode) {
 		iter.ops = &hist_iter_mem;
@@ -369,6 +389,50 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	return ret + fprintf(fp, "\n#\n");
 }
 
+static void branch_type_stat_display(FILE *fp, struct branch_type_stat *stat)
+{
+	u64 total = 0;
+	int i;
+
+	for (i = 0; i < PERF_BR_MAX; i++)
+		total += stat->counts[i];
+
+	if (total == 0)
+		return;
+
+	fprintf(fp, "\n#");
+	fprintf(fp, "\n# Branch Statistics:");
+	fprintf(fp, "\n#");
+
+	if (stat->jcc_fwd > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"JCC forward",
+			100.0 * (double)stat->jcc_fwd / (double)total);
+
+	if (stat->jcc_bwd > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"JCC backward",
+			100.0 * (double)stat->jcc_bwd / (double)total);
+
+	if (stat->cross_4k > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"CROSS_4K",
+			100.0 * (double)stat->cross_4k / (double)total);
+
+	if (stat->cross_2m > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"CROSS_2M",
+			100.0 * (double)stat->cross_2m / (double)total);
+
+	for (i = 0; i < PERF_BR_MAX; i++) {
+		if (stat->counts[i] > 0)
+			fprintf(fp, "\n%12s: %5.1f%%",
+				branch_type_name(i),
+				100.0 *
+				(double)stat->counts[i] / (double)total);
+	}
+}
+
 static int perf_evlist__tty_browse_hists(struct perf_evlist *evlist,
 					 struct report *rep,
 					 const char *help)
@@ -404,6 +468,9 @@ static int perf_evlist__tty_browse_hists(struct perf_evlist *evlist,
 		perf_read_values_destroy(&rep->show_threads_values);
 	}
 
+	if (sort__mode == SORT_MODE__BRANCH)
+		branch_type_stat_display(stdout, &rep->brtype_stat);
+
 	return 0;
 }
 
@@ -936,6 +1003,8 @@ int cmd_report(int argc, const char **argv)
 	if (has_br_stack && branch_call_mode)
 		symbol_conf.show_branchflag_count = true;
 
+	memset(&report.brtype_stat, 0, sizeof(struct branch_type_stat));
+
 	/*
 	 * Branch mode is a tristate:
 	 * -1 means default, so decide based on the file having branch data.
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 61bf304..c8aee25 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -745,12 +745,9 @@ iter_prepare_branch_entry(struct hist_entry_iter *iter, struct addr_location *al
 }
 
 static int
-iter_add_single_branch_entry(struct hist_entry_iter *iter,
+iter_add_single_branch_entry(struct hist_entry_iter *iter __maybe_unused,
 			     struct addr_location *al __maybe_unused)
 {
-	/* to avoid calling callback function */
-	iter->he = NULL;
-
 	return 0;
 }
 
-- 
2.7.4
