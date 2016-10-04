Return-Path: <BATV+c3601ec1c81c7bfd3073+4790+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp33t2XfnzDrLs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 13:37:46 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Andi Kleen <ak@linux.intel.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/22] perf list jevents: Add support for event list topics
Date: Mon,  3 Oct 2016 23:37:16 -0300
Message-Id: <1475548641-12182-18-git-send-email-acme@kernel.org>
In-Reply-To: <1475548641-12182-1-git-send-email-acme@kernel.org>
References: <1475548641-12182-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

Add support to group the output of perf list by the Topic field in the
JSON file.

Example output:

% perf list
...
Cache:
  l1d.replacement
       [L1D data line replacements]
  l1d_pend_miss.pending
       [L1D miss oustandings duration in cycles]
  l1d_pend_miss.pending_cycles
       [Cycles with L1D load Misses outstanding]
  l2_l1d_wb_rqsts.all
       [Not rejected writebacks from L1D to L2 cache lines in any state]
  l2_l1d_wb_rqsts.hit_e
       [Not rejected writebacks from L1D to L2 cache lines in E state]
  l2_l1d_wb_rqsts.hit_m
       [Not rejected writebacks from L1D to L2 cache lines in M state]

...
Pipeline:
  arith.fpu_div
       [Divide operations executed]
  arith.fpu_div_active
       [Cycles when divider is busy executing divide operations]
  baclears.any
       [Counts the total number when the front end is resteered, mainly
       when the BPU cannot provide a correct prediction and this is
       corrected by other branch handling mechanisms at the front end]
  br_inst_exec.all_branches
       [Speculative and retired branches]
  br_inst_exec.all_conditional
       [Speculative and retired macro-conditional branches]
  br_inst_exec.all_direct_jmp
       [Speculative and retired macro-unconditional branches excluding
       calls and indirects]
  br_inst_exec.all_direct_near_call
       [Speculative and retired direct near calls]
  br_inst_exec.all_indirect_jump_non_call_ret

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1473978296-20712-14-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 37 +++++++++++++++++++++++++++----------
 tools/perf/util/pmu.h |  1 +
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8ff382cb161d..b1474dcadfa2 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -223,7 +223,8 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 }
 
 static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
-				 char *desc, char *val, char *long_desc)
+				 char *desc, char *val, char *long_desc,
+				 char *topic)
 {
 	struct perf_pmu_alias *alias;
 	int ret;
@@ -259,6 +260,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	alias->desc = desc ? strdup(desc) : NULL;
 	alias->long_desc = long_desc ? strdup(long_desc) :
 				desc ? strdup(desc) : NULL;
+	alias->topic = topic ? strdup(topic) : NULL;
 
 	list_add_tail(&alias->list, list);
 
@@ -276,7 +278,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 
 	buf[ret] = 0;
 
-	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL);
+	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL);
 }
 
 static inline bool pmu_alias_info_file(char *name)
@@ -535,7 +537,7 @@ static void pmu_add_cpu_aliases(struct list_head *head)
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
 				(char *)pe->desc, (char *)pe->event,
-				(char *)pe->long_desc);
+				(char *)pe->long_desc, (char *)pe->topic);
 	}
 
 out:
@@ -1055,19 +1057,26 @@ static char *format_alias_or(char *buf, int len, struct perf_pmu *pmu,
 	return buf;
 }
 
-struct pair {
+struct sevent {
 	char *name;
 	char *desc;
+	char *topic;
 };
 
-static int cmp_pair(const void *a, const void *b)
+static int cmp_sevent(const void *a, const void *b)
 {
-	const struct pair *as = a;
-	const struct pair *bs = b;
+	const struct sevent *as = a;
+	const struct sevent *bs = b;
 
 	/* Put extra events last */
 	if (!!as->desc != !!bs->desc)
 		return !!as->desc - !!bs->desc;
+	if (as->topic && bs->topic) {
+		int n = strcmp(as->topic, bs->topic);
+
+		if (n)
+			return n;
+	}
 	return strcmp(as->name, bs->name);
 }
 
@@ -1101,9 +1110,10 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 	char buf[1024];
 	int printed = 0;
 	int len, j;
-	struct pair *aliases;
+	struct sevent *aliases;
 	int numdesc = 0;
 	int columns = pager_get_columns();
+	char *topic = NULL;
 
 	pmu = NULL;
 	len = 0;
@@ -1113,7 +1123,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 		if (pmu->selectable)
 			len++;
 	}
-	aliases = zalloc(sizeof(struct pair) * len);
+	aliases = zalloc(sizeof(struct sevent) * len);
 	if (!aliases)
 		goto out_enomem;
 	pmu = NULL;
@@ -1144,6 +1154,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 
 			aliases[j].desc = long_desc ? alias->long_desc :
 						alias->desc;
+			aliases[j].topic = alias->topic;
 			j++;
 		}
 		if (pmu->selectable &&
@@ -1156,7 +1167,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 		}
 	}
 	len = j;
-	qsort(aliases, len, sizeof(struct pair), cmp_pair);
+	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (j = 0; j < len; j++) {
 		if (name_only) {
 			printf("%s ", aliases[j].name);
@@ -1165,6 +1176,12 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 		if (aliases[j].desc && !quiet_flag) {
 			if (numdesc++ == 0)
 				printf("\n");
+			if (aliases[j].topic && (!topic ||
+					strcmp(topic, aliases[j].topic))) {
+				printf("%s%s:\n", topic ? "\n" : "",
+						aliases[j].topic);
+				topic = aliases[j].topic;
+			}
 			printf("  %-50s\n", aliases[j].name);
 			printf("%*s", 8, "[");
 			wordwrap(aliases[j].desc, 8, columns, 0);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 2fb8aa0fb47f..25712034c815 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -42,6 +42,7 @@ struct perf_pmu_alias {
 	char *name;
 	char *desc;
 	char *long_desc;
+	char *topic;
 	struct list_head terms; /* HEAD struct parse_events_term -> list */
 	struct list_head list;  /* ELEM */
 	char unit[UNIT_MAX_LEN+1];
-- 
2.7.4
