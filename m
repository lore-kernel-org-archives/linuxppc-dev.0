Return-Path: <yao.jin@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7llH4zzSzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 14:10:19 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 7/7] perf report: Show branch type in callchain entry
Date: Thu, 20 Apr 2017 20:07:55 +0800
Message-Id: <1492690075-17243-8-git-send-email-yao.jin@linux.intel.com>
In-Reply-To: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
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

For example:
perf report --branch-history --stdio --no-children

--24.21%--main div.c:42 (RET CROSS_2M cycles:2)
          compute_flag div.c:28 (cycles:2)
          compute_flag div.c:27 (RET CROSS_2M cycles:1)
          rand rand.c:28 (cycles:1)
          rand rand.c:28 (RET CROSS_2M cycles:1)
          __random random.c:298 (cycles:1)
          __random random.c:297 (JCC backward CROSS_2M cycles:1)
          __random random.c:295 (cycles:1)
          __random random.c:295 (JCC backward CROSS_2M cycles:1)
          __random random.c:295 (cycles:1)
          __random random.c:295 (RET CROSS_2M cycles:9)

Change log
----------

v6: Remove the branch_type_str() since it's moved to branch.c.

v5: Rewrite the branch info print code in util/callchain.c.

v4: Comparing to previous version, the major changes are:

Since we have to compute the JCC forward/JCC backward and cross
page checking in user space by from and to addresses, while each
callchain entry only contains one ip (either from or to), so
this patch will append a branch from address to the callchain
entry which just contains the to ip.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/callchain.c | 38 +++++++++++++++++++++++++++++---------
 tools/perf/util/callchain.h |  5 ++++-
 tools/perf/util/machine.c   | 26 +++++++++++++++++---------
 3 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d44b5ed..cfae50d 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -23,6 +23,7 @@
 #include "sort.h"
 #include "machine.h"
 #include "callchain.h"
+#include "branch.h"
 
 __thread struct callchain_cursor callchain_cursor;
 
@@ -468,6 +469,11 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 			call->cycles_count = cursor_node->branch_flags.cycles;
 			call->iter_count = cursor_node->nr_loop_iter;
 			call->samples_count = cursor_node->samples;
+
+			branch_type_count(&call->brtype_stat,
+					  &cursor_node->branch_flags,
+					  cursor_node->branch_from,
+					  cursor_node->ip);
 		}
 
 		list_add_tail(&call->list, &node->val);
@@ -580,6 +586,11 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			cnode->cycles_count += node->branch_flags.cycles;
 			cnode->iter_count += node->nr_loop_iter;
 			cnode->samples_count += node->samples;
+
+			branch_type_count(&cnode->brtype_stat,
+					  &node->branch_flags,
+					  node->branch_from,
+					  node->ip);
 		}
 
 		return MATCH_EQ;
@@ -814,7 +825,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 	list_for_each_entry_safe(list, next_list, &src->val, list) {
 		callchain_cursor_append(cursor, list->ip,
 					list->ms.map, list->ms.sym,
-					false, NULL, 0, 0);
+					false, NULL, 0, 0, 0);
 		list_del(&list->list);
 		map__zput(list->ms.map);
 		free(list);
@@ -854,7 +865,7 @@ int callchain_merge(struct callchain_cursor *cursor,
 int callchain_cursor_append(struct callchain_cursor *cursor,
 			    u64 ip, struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, int samples)
+			    int nr_loop_iter, int samples, u64 branch_from)
 {
 	struct callchain_cursor_node *node = *cursor->last;
 
@@ -878,6 +889,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 		memcpy(&node->branch_flags, flags,
 			sizeof(struct branch_flags));
 
+	node->branch_from = branch_from;
 	cursor->nr++;
 
 	cursor->last = &node->next;
@@ -1133,14 +1145,19 @@ static int count_float_printf(int index, const char *str, float value,
 static int counts_str_build(char *bf, int bfsize,
 			     u64 branch_count, u64 predicted_count,
 			     u64 abort_count, u64 cycles_count,
-			     u64 iter_count, u64 samples_count)
+			     u64 iter_count, u64 samples_count,
+			     struct branch_type_stat *brtype_stat)
 {
 	u64 cycles;
-	int printed = 0, i = 0;
+	int printed, i = 0;
 
 	if (branch_count == 0)
 		return scnprintf(bf, bfsize, " (calltrace)");
 
+	printed = branch_type_str(brtype_stat, bf, bfsize);
+	if (printed)
+		i++;
+
 	if (predicted_count < branch_count) {
 		printed += count_float_printf(i++, "predicted",
 				predicted_count * 100.0 / branch_count,
@@ -1176,13 +1193,14 @@ static int counts_str_build(char *bf, int bfsize,
 static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
 				   u64 branch_count, u64 predicted_count,
 				   u64 abort_count, u64 cycles_count,
-				   u64 iter_count, u64 samples_count)
+				   u64 iter_count, u64 samples_count,
+				   struct branch_type_stat *brtype_stat)
 {
-	char str[128];
+	char str[256];
 
 	counts_str_build(str, sizeof(str), branch_count,
 			 predicted_count, abort_count, cycles_count,
-			 iter_count, samples_count);
+			 iter_count, samples_count, brtype_stat);
 
 	if (fp)
 		return fprintf(fp, "%s", str);
@@ -1214,7 +1232,8 @@ int callchain_list_counts__printf_value(struct callchain_node *node,
 
 	return callchain_counts_printf(fp, bf, bfsize, branch_count,
 				       predicted_count, abort_count,
-				       cycles_count, iter_count, samples_count);
+				       cycles_count, iter_count, samples_count,
+				       &clist->brtype_stat);
 }
 
 static void free_callchain_node(struct callchain_node *node)
@@ -1339,7 +1358,8 @@ int callchain_cursor__copy(struct callchain_cursor *dst,
 
 		rc = callchain_cursor_append(dst, node->ip, node->map, node->sym,
 					     node->branch, &node->branch_flags,
-					     node->nr_loop_iter, node->samples);
+					     node->nr_loop_iter, node->samples,
+					     node->branch_from);
 		if (rc)
 			break;
 
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index c56c23d..9773820 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -7,6 +7,7 @@
 #include "event.h"
 #include "map.h"
 #include "symbol.h"
+#include "branch.h"
 
 #define HELP_PAD "\t\t\t\t"
 
@@ -119,6 +120,7 @@ struct callchain_list {
 	u64			cycles_count;
 	u64			iter_count;
 	u64			samples_count;
+	struct branch_type_stat brtype_stat;
 	char		       *srcline;
 	struct list_head	list;
 };
@@ -135,6 +137,7 @@ struct callchain_cursor_node {
 	struct symbol			*sym;
 	bool				branch;
 	struct branch_flags		branch_flags;
+	u64				branch_from;
 	int				nr_loop_iter;
 	int				samples;
 	struct callchain_cursor_node	*next;
@@ -198,7 +201,7 @@ static inline void callchain_cursor_reset(struct callchain_cursor *cursor)
 int callchain_cursor_append(struct callchain_cursor *cursor, u64 ip,
 			    struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, int samples);
+			    int nr_loop_iter, int samples, u64 branch_from);
 
 /* Close a cursor writing session. Initialize for the reader */
 static inline void callchain_cursor_commit(struct callchain_cursor *cursor)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 988e84c..096451f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1679,7 +1679,8 @@ static int add_callchain_ip(struct thread *thread,
 			    bool branch,
 			    struct branch_flags *flags,
 			    int nr_loop_iter,
-			    int samples)
+			    int samples,
+			    u64 branch_from)
 {
 	struct addr_location al;
 
@@ -1732,7 +1733,8 @@ static int add_callchain_ip(struct thread *thread,
 	if (symbol_conf.hide_unresolved && al.sym == NULL)
 		return 0;
 	return callchain_cursor_append(cursor, al.addr, al.map, al.sym,
-				       branch, flags, nr_loop_iter, samples);
+				       branch, flags, nr_loop_iter, samples,
+				       branch_from);
 }
 
 struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
@@ -1811,7 +1813,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = min(max_stack, (int)chain->nr), i;
 	u8 cpumode = PERF_RECORD_MISC_USER;
-	u64 ip;
+	u64 ip, branch_from = 0;
 
 	for (i = 0; i < chain_nr; i++) {
 		if (chain->ips[i] == PERF_CONTEXT_USER)
@@ -1853,6 +1855,8 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					ip = lbr_stack->entries[0].to;
 					branch = true;
 					flags = &lbr_stack->entries[0].flags;
+					branch_from =
+						lbr_stack->entries[0].from;
 				}
 			} else {
 				if (j < lbr_nr) {
@@ -1867,12 +1871,15 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					ip = lbr_stack->entries[0].to;
 					branch = true;
 					flags = &lbr_stack->entries[0].flags;
+					branch_from =
+						lbr_stack->entries[0].from;
 				}
 			}
 
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, ip,
-					       branch, flags, 0, 0);
+					       branch, flags, 0, 0,
+					       branch_from);
 			if (err)
 				return (err < 0) ? err : 0;
 		}
@@ -1971,19 +1978,20 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 						       root_al,
 						       NULL, be[i].to,
 						       true, &be[i].flags,
-						       nr_loop_iter, 1);
+						       nr_loop_iter, 1,
+						       be[i].from);
 			else
 				err = add_callchain_ip(thread, cursor, parent,
 						       root_al,
 						       NULL, be[i].to,
 						       true, &be[i].flags,
-						       0, 0);
+						       0, 0, be[i].from);
 
 			if (!err)
 				err = add_callchain_ip(thread, cursor, parent, root_al,
 						       NULL, be[i].from,
 						       true, &be[i].flags,
-						       0, 0);
+						       0, 0, 0);
 			if (err == -EINVAL)
 				break;
 			if (err)
@@ -2013,7 +2021,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
-				       false, NULL, 0, 0);
+				       false, NULL, 0, 0, 0);
 
 		if (err)
 			return (err < 0) ? err : 0;
@@ -2030,7 +2038,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 		return 0;
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
-				       false, NULL, 0, 0);
+				       false, NULL, 0, 0, 0);
 }
 
 static int thread__resolve_callchain_unwind(struct thread *thread,
-- 
2.7.4
