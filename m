Return-Path: <yao.jin@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzkZg5QLbzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 12:50:03 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 4/5] perf report: Show branch type statistics for stdio mode
Date: Fri,  7 Apr 2017 18:47:45 +0800
Message-Id: <1491562066-7472-5-git-send-email-yao.jin@linux.intel.com>
In-Reply-To: <1491562066-7472-1-git-send-email-yao.jin@linux.intel.com>
References: <1491562066-7472-1-git-send-email-yao.jin@linux.intel.com>
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

 JCC forward:  27.7%
JCC backward:   9.8%
         JMP:   0.0%
     IND_JMP:   6.5%
        CALL:  26.6%
    IND_CALL:   0.0%
         RET:  29.3%
        IRET:   0.0%
    CROSS_4K:   0.0%
    CROSS_2M:  14.3%

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
 tools/perf/builtin-report.c | 212 ++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/event.h     |   4 +-
 tools/perf/util/hist.c      |   5 +-
 3 files changed, 216 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c18158b..1dc1058 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -43,6 +43,24 @@
 #include <linux/bitmap.h>
 #include <linux/stringify.h>
 
+struct branch_type_stat {
+	u64	jcc_fwd;
+	u64	jcc_bwd;
+	u64	jmp;
+	u64	ind_jmp;
+	u64	call;
+	u64	ind_call;
+	u64	ret;
+	u64	syscall;
+	u64	sysret;
+	u64	irq;
+	u64	intr;
+	u64	iret;
+	u64	far_branch;
+	u64	cross_4k;
+	u64	cross_2m;
+};
+
 struct report {
 	struct perf_tool	tool;
 	struct perf_session	*session;
@@ -66,6 +84,7 @@ struct report {
 	u64			queue_size;
 	int			socket_filter;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+	struct branch_type_stat	brtype_stat;
 };
 
 static int report__config(const char *var, const char *value, void *cb)
@@ -144,6 +163,91 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	return err;
 }
 
+static void branch_type_count(struct report *rep, struct branch_info *bi)
+{
+	struct branch_type_stat	*stat = &rep->brtype_stat;
+	struct branch_flags *flags = &bi->flags;
+
+	switch (flags->type) {
+	case PERF_BR_JCC_FWD:
+		stat->jcc_fwd++;
+		break;
+
+	case PERF_BR_JCC_BWD:
+		stat->jcc_bwd++;
+		break;
+
+	case PERF_BR_JMP:
+		stat->jmp++;
+		break;
+
+	case PERF_BR_IND_JMP:
+		stat->ind_jmp++;
+		break;
+
+	case PERF_BR_CALL:
+		stat->call++;
+		break;
+
+	case PERF_BR_IND_CALL:
+		stat->ind_call++;
+		break;
+
+	case PERF_BR_RET:
+		stat->ret++;
+		break;
+
+	case PERF_BR_SYSCALL:
+		stat->syscall++;
+		break;
+
+	case PERF_BR_SYSRET:
+		stat->sysret++;
+		break;
+
+	case PERF_BR_IRQ:
+		stat->irq++;
+		break;
+
+	case PERF_BR_INT:
+		stat->intr++;
+		break;
+
+	case PERF_BR_IRET:
+		stat->iret++;
+		break;
+
+	case PERF_BR_FAR_BRANCH:
+		stat->far_branch++;
+		break;
+
+	default:
+		break;
+	}
+
+	if (flags->cross == PERF_BR_CROSS_2M)
+		stat->cross_2m++;
+	else if (flags->cross == PERF_BR_CROSS_4K)
+		stat->cross_4k++;
+}
+
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
+		branch_type_count(rep, bi);
+	}
+
+	return 0;
+}
+
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -182,6 +286,8 @@ static int process_sample_event(struct perf_tool *tool,
 		 */
 		if (!sample->branch_stack)
 			goto out_put;
+
+		iter.add_entry_cb = hist_iter__branch_callback;
 		iter.ops = &hist_iter_branch;
 	} else if (rep->mem_mode) {
 		iter.ops = &hist_iter_mem;
@@ -369,6 +475,107 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	return ret + fprintf(fp, "\n#\n");
 }
 
+static void branch_type_stat_display(FILE *fp, struct branch_type_stat *stat)
+{
+	u64 total = 0;
+
+	total += stat->jcc_fwd;
+	total += stat->jcc_bwd;
+	total += stat->jmp;
+	total += stat->ind_jmp;
+	total += stat->call;
+	total += stat->ind_call;
+	total += stat->ret;
+	total += stat->syscall;
+	total += stat->sysret;
+	total += stat->irq;
+	total += stat->intr;
+	total += stat->iret;
+	total += stat->far_branch;
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
+	if (stat->jmp > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"JMP",
+			100.0 * (double)stat->jmp / (double)total);
+
+	if (stat->ind_jmp > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"IND_JMP",
+			100.0 * (double)stat->ind_jmp / (double)total);
+
+	if (stat->call > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"CALL",
+			100.0 * (double)stat->call / (double)total);
+
+	if (stat->ind_call > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"IND_CALL",
+			100.0 * (double)stat->ind_call / (double)total);
+
+	if (stat->ret > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"RET",
+			100.0 * (double)stat->ret / (double)total);
+
+	if (stat->syscall > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"SYSCALL",
+			100.0 * (double)stat->syscall / (double)total);
+
+	if (stat->sysret > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"SYSRET",
+			100.0 * (double)stat->sysret / (double)total);
+
+	if (stat->irq > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"IRQ",
+			100.0 * (double)stat->irq / (double)total);
+
+	if (stat->intr > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"INT",
+			100.0 * (double)stat->intr / (double)total);
+
+	if (stat->iret > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"IRET",
+			100.0 * (double)stat->iret / (double)total);
+
+	if (stat->far_branch > 0)
+		fprintf(fp, "\n%12s: %5.1f%%",
+			"FAR_BRANCH",
+			100.0 * (double)stat->far_branch / (double)total);
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
+}
+
 static int perf_evlist__tty_browse_hists(struct perf_evlist *evlist,
 					 struct report *rep,
 					 const char *help)
@@ -404,6 +611,9 @@ static int perf_evlist__tty_browse_hists(struct perf_evlist *evlist,
 		perf_read_values_destroy(&rep->show_threads_values);
 	}
 
+	if (sort__mode == SORT_MODE__BRANCH)
+		branch_type_stat_display(stdout, &rep->brtype_stat);
+
 	return 0;
 }
 
@@ -936,6 +1146,8 @@ int cmd_report(int argc, const char **argv)
 	if (has_br_stack && branch_call_mode)
 		symbol_conf.show_branchflag_count = true;
 
+	memset(&report.brtype_stat, 0, sizeof(struct branch_type_stat));
+
 	/*
 	 * Branch mode is a tristate:
 	 * -1 means default, so decide based on the file having branch data.
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index eb7a7b2..b192a10 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -142,7 +142,9 @@ struct branch_flags {
 	u64 in_tx:1;
 	u64 abort:1;
 	u64 cycles:16;
-	u64 reserved:44;
+	u64 type:4;
+	u64 cross:2;
+	u64 reserved:38;
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
 
-- 
2.7.4
