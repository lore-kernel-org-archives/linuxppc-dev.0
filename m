Return-Path: <yao.jin@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzkZk2GhTzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 12:50:06 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 5/5] perf report: Show branch type in callchain entry
Date: Fri,  7 Apr 2017 18:47:46 +0800
Message-Id: <1491562066-7472-6-git-send-email-yao.jin@linux.intel.com>
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

Show branch type in callchain entry. The branch type is printed
with other LBR information (such as cycles/abort/...).

One example:
perf report --branch-history --stdio --no-children

-23.60%--main div.c:42 (RET cycles:2)
         compute_flag div.c:28 (RET cycles:2)
         compute_flag div.c:27 (RET CROSS_2M cycles:1)
         rand rand.c:28 (RET CROSS_2M cycles:1)
         rand rand.c:28 (RET cycles:1)
         __random random.c:298 (RET cycles:1)
         __random random.c:297 (JCC forward cycles:1)
         __random random.c:295 (JCC forward cycles:1)
         __random random.c:295 (JCC forward cycles:1)
         __random random.c:295 (JCC forward cycles:1)
         __random random.c:295 (RET cycles:9)

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/callchain.c | 221 ++++++++++++++++++++++++++++++++------------
 tools/perf/util/callchain.h |  20 ++++
 2 files changed, 182 insertions(+), 59 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 3cea1fb..ca040a0 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -428,6 +428,89 @@ create_child(struct callchain_node *parent, bool inherit_children)
 	return new;
 }
 
+static const char *br_tag[BR_IDX_MAX] = {
+	"JCC forward",
+	"JCC backward",
+	"JMP",
+	"IND_JMP",
+	"CALL",
+	"IND_CALL",
+	"RET",
+	"SYSCALL",
+	"SYSRET",
+	"IRQ",
+	"INT",
+	"IRET",
+	"FAR_BRANCH",
+	"CROSS_4K",
+	"CROSS_2M",
+};
+
+static void
+branch_type_count(int *counts, struct branch_flags *flags)
+{
+	switch (flags->type) {
+	case PERF_BR_JCC_FWD:
+		counts[BR_IDX_JCC_FWD]++;
+		break;
+
+	case PERF_BR_JCC_BWD:
+		counts[BR_IDX_JCC_BWD]++;
+		break;
+
+	case PERF_BR_JMP:
+		counts[BR_IDX_JMP]++;
+		break;
+
+	case PERF_BR_IND_JMP:
+		counts[BR_IDX_IND_JMP]++;
+		break;
+
+	case PERF_BR_CALL:
+		counts[BR_IDX_CALL]++;
+		break;
+
+	case PERF_BR_IND_CALL:
+		counts[BR_IDX_IND_CALL]++;
+		break;
+
+	case PERF_BR_RET:
+		counts[BR_IDX_RET]++;
+		break;
+
+	case PERF_BR_SYSCALL:
+		counts[BR_IDX_SYSCALL]++;
+		break;
+
+	case PERF_BR_SYSRET:
+		counts[BR_IDX_SYSRET]++;
+		break;
+
+	case PERF_BR_IRQ:
+		counts[BR_IDX_IRQ]++;
+		break;
+
+	case PERF_BR_INT:
+		counts[BR_IDX_INT]++;
+		break;
+
+	case PERF_BR_IRET:
+		counts[BR_IDX_IRET]++;
+		break;
+
+	case PERF_BR_FAR_BRANCH:
+		counts[BR_IDX_FAR_BRANCH]++;
+		break;
+
+	default:
+		break;
+	}
+
+	if (flags->cross == PERF_BR_CROSS_2M)
+		counts[BR_IDX_CROSS_2M]++;
+	else if (flags->cross == PERF_BR_CROSS_4K)
+		counts[BR_IDX_CROSS_4K]++;
+}
 
 /*
  * Fill the node with callchain values
@@ -467,6 +550,9 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 			call->cycles_count = cursor_node->branch_flags.cycles;
 			call->iter_count = cursor_node->nr_loop_iter;
 			call->samples_count = cursor_node->samples;
+
+			branch_type_count(call->brtype_count,
+					  &cursor_node->branch_flags);
 		}
 
 		list_add_tail(&call->list, &node->val);
@@ -579,6 +665,9 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			cnode->cycles_count += node->branch_flags.cycles;
 			cnode->iter_count += node->nr_loop_iter;
 			cnode->samples_count += node->samples;
+
+			branch_type_count(cnode->brtype_count,
+					  &node->branch_flags);
 		}
 
 		return MATCH_EQ;
@@ -1105,95 +1194,108 @@ int callchain_branch_counts(struct callchain_root *root,
 						  cycles_count);
 }
 
+static int branch_type_str(int *counts, char *bf, int bfsize)
+{
+	int i, printed = 0;
+	bool brace = false;
+
+	for (i = 0; i < BR_IDX_MAX; i++) {
+		if (printed == bfsize - 1)
+			return printed;
+
+		if (counts[i] > 0) {
+			if (!brace) {
+				brace = true;
+				printed += scnprintf(bf + printed,
+						bfsize - printed,
+						" (%s", br_tag[i]);
+			} else
+				printed += scnprintf(bf + printed,
+						bfsize - printed,
+						" %s", br_tag[i]);
+		}
+	}
+
+	return printed;
+}
+
 static int counts_str_build(char *bf, int bfsize,
 			     u64 branch_count, u64 predicted_count,
 			     u64 abort_count, u64 cycles_count,
-			     u64 iter_count, u64 samples_count)
+			     u64 iter_count, u64 samples_count,
+			     int *brtype_count)
 {
-	double predicted_percent = 0.0;
-	const char *null_str = "";
-	char iter_str[32];
-	char cycle_str[32];
-	char *istr, *cstr;
 	u64 cycles;
+	int printed, i = 0;
 
 	if (branch_count == 0)
 		return scnprintf(bf, bfsize, " (calltrace)");
 
+	printed = branch_type_str(brtype_count, bf, bfsize);
+	if (printed)
+		i++;
+
 	cycles = cycles_count / branch_count;
+	if (cycles) {
+		if (i++)
+			printed += scnprintf(bf + printed, bfsize - printed,
+				" cycles:%" PRId64 "", cycles);
+		else
+			printed += scnprintf(bf + printed, bfsize - printed,
+				" (cycles:%" PRId64 "", cycles);
+	}
 
 	if (iter_count && samples_count) {
-		if (cycles > 0)
-			scnprintf(iter_str, sizeof(iter_str),
-				 " iterations:%" PRId64 "",
-				 iter_count / samples_count);
+		if (i++)
+			printed += scnprintf(bf + printed, bfsize - printed,
+				" iterations:%" PRId64 "",
+				iter_count / samples_count);
 		else
-			scnprintf(iter_str, sizeof(iter_str),
-				 "iterations:%" PRId64 "",
-				 iter_count / samples_count);
-		istr = iter_str;
-	} else
-		istr = (char *)null_str;
-
-	if (cycles > 0) {
-		scnprintf(cycle_str, sizeof(cycle_str),
-			  "cycles:%" PRId64 "", cycles);
-		cstr = cycle_str;
-	} else
-		cstr = (char *)null_str;
-
-	predicted_percent = predicted_count * 100.0 / branch_count;
+			printed += scnprintf(bf + printed, bfsize - printed,
+				" (iterations:%" PRId64 "",
+				iter_count / samples_count);
+	}
 
-	if ((predicted_count == branch_count) && (abort_count == 0)) {
-		if ((cycles > 0) || (istr != (char *)null_str))
-			return scnprintf(bf, bfsize, " (%s%s)", cstr, istr);
+	if (predicted_count < branch_count) {
+		if (i++)
+			printed += scnprintf(bf + printed, bfsize - printed,
+				" predicted:%.1f%%",
+				predicted_count * 100.0 / branch_count);
 		else
-			return scnprintf(bf, bfsize, "%s", (char *)null_str);
-	}
-
-	if ((predicted_count < branch_count) && (abort_count == 0)) {
-		if ((cycles > 0) || (istr != (char *)null_str))
-			return scnprintf(bf, bfsize,
-				" (predicted:%.1f%% %s%s)",
-				predicted_percent, cstr, istr);
-		else {
-			return scnprintf(bf, bfsize,
-				" (predicted:%.1f%%)",
-				predicted_percent);
-		}
+			printed += scnprintf(bf + printed, bfsize - printed,
+				" (predicted:%.1f%%",
+				predicted_count * 100.0 / branch_count);
 	}
 
-	if ((predicted_count == branch_count) && (abort_count > 0)) {
-		if ((cycles > 0) || (istr != (char *)null_str))
-			return scnprintf(bf, bfsize,
-				" (abort:%" PRId64 " %s%s)",
-				abort_count, cstr, istr);
+	if (abort_count) {
+		if (i++)
+			printed += scnprintf(bf + printed, bfsize - printed,
+				" abort:%.1f%%",
+				abort_count * 100.0 / branch_count);
 		else
-			return scnprintf(bf, bfsize,
-				" (abort:%" PRId64 ")",
-				abort_count);
+			printed += scnprintf(bf + printed, bfsize - printed,
+				" (abort:%.1f%%",
+				abort_count * 100.0 / branch_count);
 	}
 
-	if ((cycles > 0) || (istr != (char *)null_str))
-		return scnprintf(bf, bfsize,
-			" (predicted:%.1f%% abort:%" PRId64 " %s%s)",
-			predicted_percent, abort_count, cstr, istr);
+	if (i)
+		return scnprintf(bf + printed, bfsize - printed, ")");
 
-	return scnprintf(bf, bfsize,
-			" (predicted:%.1f%% abort:%" PRId64 ")",
-			predicted_percent, abort_count);
+	bf[0] = 0;
+	return 0;
 }
 
 static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
 				   u64 branch_count, u64 predicted_count,
 				   u64 abort_count, u64 cycles_count,
-				   u64 iter_count, u64 samples_count)
+				   u64 iter_count, u64 samples_count,
+				   int *brtype_count)
 {
 	char str[128];
 
 	counts_str_build(str, sizeof(str), branch_count,
 			 predicted_count, abort_count, cycles_count,
-			 iter_count, samples_count);
+			 iter_count, samples_count, brtype_count);
 
 	if (fp)
 		return fprintf(fp, "%s", str);
@@ -1225,7 +1327,8 @@ int callchain_list_counts__printf_value(struct callchain_node *node,
 
 	return callchain_counts_printf(fp, bf, bfsize, branch_count,
 				       predicted_count, abort_count,
-				       cycles_count, iter_count, samples_count);
+				       cycles_count, iter_count, samples_count,
+				       clist->brtype_count);
 }
 
 static void free_callchain_node(struct callchain_node *node)
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index c56c23d..564a485 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -106,6 +106,25 @@ struct callchain_param {
 extern struct callchain_param callchain_param;
 extern struct callchain_param callchain_param_default;
 
+enum {
+	BR_IDX_JCC_FWD		= 0,
+	BR_IDX_JCC_BWD		= 1,
+	BR_IDX_JMP		= 2,
+	BR_IDX_IND_JMP		= 3,
+	BR_IDX_CALL		= 4,
+	BR_IDX_IND_CALL		= 5,
+	BR_IDX_RET		= 6,
+	BR_IDX_SYSCALL		= 7,
+	BR_IDX_SYSRET		= 8,
+	BR_IDX_IRQ		= 9,
+	BR_IDX_INT		= 10,
+	BR_IDX_IRET		= 11,
+	BR_IDX_FAR_BRANCH	= 12,
+	BR_IDX_CROSS_4K		= 13,
+	BR_IDX_CROSS_2M		= 14,
+	BR_IDX_MAX,
+};
+
 struct callchain_list {
 	u64			ip;
 	struct map_symbol	ms;
@@ -119,6 +138,7 @@ struct callchain_list {
 	u64			cycles_count;
 	u64			iter_count;
 	u64			samples_count;
+	int			brtype_count[BR_IDX_MAX];
 	char		       *srcline;
 	struct list_head	list;
 };
-- 
2.7.4
