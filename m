Return-Path: <yao.jin@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2BZs2ffKzDqFW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 12:58:45 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 4/5] perf report: Show branch type statistics for stdio mode
Date: Tue, 11 Apr 2017 18:56:32 +0800
Message-Id: <1491908193-25418-5-git-send-email-yao.jin@linux.intel.com>
In-Reply-To: <1491908193-25418-1-git-send-email-yao.jin@linux.intel.com>
References: <1491908193-25418-1-git-send-email-yao.jin@linux.intel.com>
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

 JCC forward:  27.8%
JCC backward:   9.7%
    CROSS_4K:   0.0%
    CROSS_2M:  14.3%
         JCC:  37.6%
         JMP:   0.0%
     IND_JMP:   6.5%
        CALL:  26.6%
         RET:  29.3%
        IRET:   0.0%

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

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/event.h     |  3 +-
 tools/perf/util/hist.c      |  5 +---
 tools/perf/util/util.c      | 59 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/util.h      | 17 +++++++++++
 5 files changed, 149 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c18158b..c2889eb 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -66,6 +66,7 @@ struct report {
 	u64			queue_size;
 	int			socket_filter;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+	struct branch_type_stat	brtype_stat;
 };
 
 static int report__config(const char *var, const char *value, void *cb)
@@ -144,6 +145,24 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
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
+	if (sort__mode == SORT_MODE__BRANCH) {
+		bi = he->branch_info;
+		branch_type_count(&rep->brtype_stat, &bi->flags,
+				  bi->from.addr, bi->to.addr);
+	}
+
+	return 0;
+}
+
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -182,6 +201,8 @@ static int process_sample_event(struct perf_tool *tool,
 		 */
 		if (!sample->branch_stack)
 			goto out_put;
+
+		iter.add_entry_cb = hist_iter__branch_callback;
 		iter.ops = &hist_iter_branch;
 	} else if (rep->mem_mode) {
 		iter.ops = &hist_iter_mem;
@@ -369,6 +390,50 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
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
@@ -404,6 +469,9 @@ static int perf_evlist__tty_browse_hists(struct perf_evlist *evlist,
 		perf_read_values_destroy(&rep->show_threads_values);
 	}
 
+	if (sort__mode == SORT_MODE__BRANCH)
+		branch_type_stat_display(stdout, &rep->brtype_stat);
+
 	return 0;
 }
 
@@ -936,6 +1004,8 @@ int cmd_report(int argc, const char **argv)
 	if (has_br_stack && branch_call_mode)
 		symbol_conf.show_branchflag_count = true;
 
+	memset(&report.brtype_stat, 0, sizeof(struct branch_type_stat));
+
 	/*
 	 * Branch mode is a tristate:
 	 * -1 means default, so decide based on the file having branch data.
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index eb7a7b2..26b4c2e 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -142,7 +142,8 @@ struct branch_flags {
 	u64 in_tx:1;
 	u64 abort:1;
 	u64 cycles:16;
-	u64 reserved:44;
+	u64 type:4;
+	u64 reserved:40;
 };
 
 struct branch_entry {
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
 
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index d8b45ce..a4b54a9 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -802,3 +802,62 @@ int unit_number__scnprintf(char *buf, size_t size, u64 n)
 
 	return scnprintf(buf, size, "%" PRIu64 "%c", n, unit[i]);
 }
+
+static bool cross_area(u64 addr1, u64 addr2, int size)
+{
+	u64 align1, align2;
+
+	align1 = addr1 & ~(size - 1);
+	align2 = addr2 & ~(size - 1);
+
+	return (align1 != align2) ? true : false;
+}
+
+#define AREA_4K		4096
+#define AREA_2M		(2 * 1024 * 1024)
+
+void branch_type_count(struct branch_type_stat *stat,
+		       struct branch_flags *flags,
+		       u64 from, u64 to)
+{
+	if ((flags->type == PERF_BR_NONE) || (from == 0))
+		return;
+
+	stat->counts[flags->type]++;
+
+	if (flags->type == PERF_BR_JCC) {
+		if (to > from)
+			stat->jcc_fwd++;
+		else
+			stat->jcc_bwd++;
+	}
+
+	if (cross_area(from, to, AREA_2M))
+		stat->cross_2m++;
+	else if (cross_area(from, to, AREA_4K))
+		stat->cross_4k++;
+}
+
+const char *branch_type_name(int type)
+{
+	const char *branch_names[PERF_BR_MAX] = {
+		"N/A",
+		"JCC",
+		"JMP",
+		"IND_JMP",
+		"CALL",
+		"IND_CALL",
+		"RET",
+		"SYSCALL",
+		"SYSRET",
+		"IRQ",
+		"INT",
+		"IRET",
+		"FAR_BRANCH",
+	};
+
+	if ((type >= 0) && (type < PERF_BR_MAX))
+		return branch_names[type];
+
+	return NULL;
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 7cf5752..0a5bbcc 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -79,6 +79,7 @@
 #include <linux/bitops.h>
 #include <termios.h>
 #include "strlist.h"
+#include "../perf.h"
 
 extern const char *graph_line;
 extern const char *graph_dotted_line;
@@ -380,4 +381,20 @@ struct inline_node {
 struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr);
 void inline_node__delete(struct inline_node *node);
 
+struct branch_type_stat {
+	u64 counts[PERF_BR_MAX];
+	u64 jcc_fwd;
+	u64 jcc_bwd;
+	u64 cross_4k;
+	u64 cross_2m;
+};
+
+struct branch_flags;
+
+void branch_type_count(struct branch_type_stat *stat,
+		       struct branch_flags *flags,
+		       u64 from, u64 to);
+
+const char *branch_type_name(int type);
+
 #endif /* GIT_COMPAT_UTIL_H */
-- 
2.7.4
