Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96BFE1A044F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 07:17:18 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 26 Oct 2015 14:17:16 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 078113E4004C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:17:15 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9QKHEqB10420580
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:17:15 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9QKHCrO016748
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:17:14 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v18 14/19] perf, tools: Add support for event list topics
Date: Mon, 26 Oct 2015 13:14:28 -0700
Message-Id: <1445890473-22877-15-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1445890473-22877-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1445890473-22877-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

Add support to group the output of perf list by the Topic field
in the JSON file.

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
Acked-by: Jiri Olsa <jolsa@redhat.com>
---

Changelog[v14]
	- [Jiri Olsa] Move jevents support for Topic to a separate patch.
---
 tools/perf/util/pmu.c | 37 +++++++++++++++++++++++++++----------
 tools/perf/util/pmu.h |  1 +
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 1e3b3bf1..5745139 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -210,7 +210,8 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 }
 
 static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
-				 char *desc, char *val, char *long_desc)
+				 char *desc, char *val, char *long_desc,
+				 char *topic)
 {
 	struct perf_pmu_alias *alias;
 	int ret;
@@ -245,6 +246,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	alias->desc = desc ? strdup(desc) : NULL;
 	alias->long_desc = long_desc ? strdup(long_desc) :
 				desc ? strdup(desc) : NULL;
+	alias->topic = topic ? strdup(topic) : NULL;
 
 	list_add_tail(&alias->list, list);
 
@@ -262,7 +264,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 
 	buf[ret] = 0;
 
-	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL);
+	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL);
 }
 
 static inline bool pmu_alias_info_file(char *name)
@@ -511,7 +513,7 @@ static int pmu_add_cpu_aliases(struct list_head *head)
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
 				(char *)pe->desc, (char *)pe->event,
-				(char *)pe->long_desc);
+				(char *)pe->long_desc, (char *)pe->topic);
 	}
 
 out:
@@ -1033,19 +1035,26 @@ static char *format_alias_or(char *buf, int len, struct perf_pmu *pmu,
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
 
@@ -1079,9 +1088,10 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
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
@@ -1091,7 +1101,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 		if (pmu->selectable)
 			len++;
 	}
-	aliases = zalloc(sizeof(struct pair) * len);
+	aliases = zalloc(sizeof(struct sevent) * len);
 	if (!aliases)
 		goto out_enomem;
 	pmu = NULL;
@@ -1121,6 +1131,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 
 			aliases[j].desc = long_desc ? alias->long_desc :
 						alias->desc;
+			aliases[j].topic = alias->topic;
 			j++;
 		}
 		if (pmu->selectable &&
@@ -1133,7 +1144,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 		}
 	}
 	len = j;
-	qsort(aliases, len, sizeof(struct pair), cmp_pair);
+	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (j = 0; j < len; j++) {
 		if (name_only) {
 			printf("%s ", aliases[j].name);
@@ -1142,6 +1153,12 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
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
index 1aa614e..de26919 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -40,6 +40,7 @@ struct perf_pmu_alias {
 	char *name;
 	char *desc;
 	char *long_desc;
+	char *topic;
 	struct list_head terms; /* HEAD struct parse_events_term -> list */
 	struct list_head list;  /* ELEM */
 	char unit[UNIT_MAX_LEN+1];
-- 
2.5.3
