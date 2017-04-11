Return-Path: <yao.jin@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2BZv74T0zDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 12:58:47 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 5/5] perf report: Show branch type in callchain entry
Date: Tue, 11 Apr 2017 18:56:33 +0800
Message-Id: <1491908193-25418-6-git-send-email-yao.jin@linux.intel.com>
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

Show branch type in callchain entry. The branch type is printed
with other LBR information (such as cycles/abort/...).

One example:
perf report --branch-history --stdio --no-children

--23.54%--main div.c:42 (CROSS_2M RET cycles:2)
          compute_flag div.c:28 (RET cycles:2)
          compute_flag div.c:27 (CROSS_2M RET cycles:1)
          rand rand.c:28 (CROSS_4K RET cycles:1)
          rand rand.c:28 (CROSS_2M RET cycles:1)
          __random random.c:298 (CROSS_4K RET cycles:1)
          __random random.c:297 (JCC backward CROSS_2M cycles:1)
          __random random.c:295 (JCC forward CROSS_4K cycles:1)
          __random random.c:295 (JCC backward CROSS_2M cycles:1)
          __random random.c:295 (JCC forward CROSS_4K cycles:1)
          __random random.c:295 (CROSS_2M RET cycles:9)

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/callchain.c | 195 ++++++++++++++++++++++++++++++--------------
 tools/perf/util/callchain.h |   4 +-
 tools/perf/util/machine.c   |  26 ++++--
 3 files changed, 152 insertions(+), 73 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 2e5eff5..3c875b1 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -467,6 +467,11 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
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
@@ -579,6 +584,11 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
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
@@ -813,7 +823,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 	list_for_each_entry_safe(list, next_list, &src->val, list) {
 		callchain_cursor_append(cursor, list->ip,
 					list->ms.map, list->ms.sym,
-					false, NULL, 0, 0);
+					false, NULL, 0, 0, 0);
 		list_del(&list->list);
 		map__zput(list->ms.map);
 		free(list);
@@ -853,7 +863,7 @@ int callchain_merge(struct callchain_cursor *cursor,
 int callchain_cursor_append(struct callchain_cursor *cursor,
 			    u64 ip, struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, int samples)
+			    int nr_loop_iter, int samples, u64 branch_from)
 {
 	struct callchain_cursor_node *node = *cursor->last;
 
@@ -877,6 +887,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 		memcpy(&node->branch_flags, flags,
 			sizeof(struct branch_flags));
 
+	node->branch_from = branch_from;
 	cursor->nr++;
 
 	cursor->last = &node->next;
@@ -1105,95 +1116,151 @@ int callchain_branch_counts(struct callchain_root *root,
 						  cycles_count);
 }
 
+static int branch_type_str(struct branch_type_stat *stat,
+			   char *bf, int bfsize)
+{
+	int i, j = 0, printed = 0;
+	u64 total = 0;
+
+	for (i = 0; i < PERF_BR_MAX; i++)
+		total += stat->counts[i];
+
+	if (total == 0)
+		return 0;
+
+	printed += scnprintf(bf + printed, bfsize - printed, " (");
+
+	if (stat->jcc_fwd > 0) {
+		j++;
+		printed += scnprintf(bf + printed, bfsize - printed,
+				     "JCC forward");
+	}
+
+	if (stat->jcc_bwd > 0) {
+		if (j++)
+			printed += scnprintf(bf + printed, bfsize - printed,
+					     " JCC backward");
+		else
+			printed += scnprintf(bf + printed, bfsize - printed,
+					     "JCC backward");
+	}
+
+	if (stat->cross_4k > 0) {
+		if (j++)
+			printed += scnprintf(bf + printed, bfsize - printed,
+					     " CROSS_4K");
+		else
+			printed += scnprintf(bf + printed, bfsize - printed,
+					     "CROSS_4K");
+	}
+
+	if (stat->cross_2m > 0) {
+		if (j++)
+			printed += scnprintf(bf + printed, bfsize - printed,
+					     " CROSS_2M");
+		else
+			printed += scnprintf(bf + printed, bfsize - printed,
+					     "CROSS_2M");
+	}
+
+	for (i = 0; i < PERF_BR_MAX; i++) {
+		if (i == PERF_BR_JCC)
+			continue;
+
+		if (stat->counts[i] > 0) {
+			if (j++)
+				printed += scnprintf(bf + printed,
+						     bfsize - printed,
+						     " %s",
+						     branch_type_name(i));
+			else
+				printed += scnprintf(bf + printed,
+						     bfsize - printed,
+						     "%s",
+						     branch_type_name(i));
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
+			     struct branch_type_stat *brtype_stat)
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
 
+	printed = branch_type_str(brtype_stat, bf, bfsize);
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
@@ -1225,7 +1292,8 @@ int callchain_list_counts__printf_value(struct callchain_node *node,
 
 	return callchain_counts_printf(fp, bf, bfsize, branch_count,
 				       predicted_count, abort_count,
-				       cycles_count, iter_count, samples_count);
+				       cycles_count, iter_count, samples_count,
+				       &clist->brtype_stat);
 }
 
 static void free_callchain_node(struct callchain_node *node)
@@ -1350,7 +1418,8 @@ int callchain_cursor__copy(struct callchain_cursor *dst,
 
 		rc = callchain_cursor_append(dst, node->ip, node->map, node->sym,
 					     node->branch, &node->branch_flags,
-					     node->nr_loop_iter, node->samples);
+					     node->nr_loop_iter, node->samples,
+					     node->branch_from);
 		if (rc)
 			break;
 
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index c56c23d..b93897a 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -119,6 +119,7 @@ struct callchain_list {
 	u64			cycles_count;
 	u64			iter_count;
 	u64			samples_count;
+	struct branch_type_stat brtype_stat;
 	char		       *srcline;
 	struct list_head	list;
 };
@@ -135,6 +136,7 @@ struct callchain_cursor_node {
 	struct symbol			*sym;
 	bool				branch;
 	struct branch_flags		branch_flags;
+	u64				branch_from;
 	int				nr_loop_iter;
 	int				samples;
 	struct callchain_cursor_node	*next;
@@ -198,7 +200,7 @@ static inline void callchain_cursor_reset(struct callchain_cursor *cursor)
 int callchain_cursor_append(struct callchain_cursor *cursor, u64 ip,
 			    struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, int samples);
+			    int nr_loop_iter, int samples, u64 branch_from);
 
 /* Close a cursor writing session. Initialize for the reader */
 static inline void callchain_cursor_commit(struct callchain_cursor *cursor)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index dfc6004..2309614 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1673,7 +1673,8 @@ static int add_callchain_ip(struct thread *thread,
 			    bool branch,
 			    struct branch_flags *flags,
 			    int nr_loop_iter,
-			    int samples)
+			    int samples,
+			    u64 branch_from)
 {
 	struct addr_location al;
 
@@ -1726,7 +1727,8 @@ static int add_callchain_ip(struct thread *thread,
 	if (symbol_conf.hide_unresolved && al.sym == NULL)
 		return 0;
 	return callchain_cursor_append(cursor, al.addr, al.map, al.sym,
-				       branch, flags, nr_loop_iter, samples);
+				       branch, flags, nr_loop_iter, samples,
+				       branch_from);
 }
 
 struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
@@ -1805,7 +1807,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = min(max_stack, (int)chain->nr), i;
 	u8 cpumode = PERF_RECORD_MISC_USER;
-	u64 ip;
+	u64 ip, branch_from = 0;
 
 	for (i = 0; i < chain_nr; i++) {
 		if (chain->ips[i] == PERF_CONTEXT_USER)
@@ -1847,6 +1849,8 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					ip = lbr_stack->entries[0].to;
 					branch = true;
 					flags = &lbr_stack->entries[0].flags;
+					branch_from =
+						lbr_stack->entries[0].from;
 				}
 			} else {
 				if (j < lbr_nr) {
@@ -1861,12 +1865,15 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
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
@@ -1965,19 +1972,20 @@ static int thread__resolve_callchain_sample(struct thread *thread,
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
@@ -2007,7 +2015,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
-				       false, NULL, 0, 0);
+				       false, NULL, 0, 0, 0);
 
 		if (err)
 			return (err < 0) ? err : 0;
@@ -2024,7 +2032,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 		return 0;
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
-				       false, NULL, 0, 0);
+				       false, NULL, 0, 0, 0);
 }
 
 static int thread__resolve_callchain_unwind(struct thread *thread,
-- 
2.7.4
