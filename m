Return-Path: <BATV+ef2f77d1cbf736fff7a8+4790+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp33v2VNhzDrFm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 13:37:47 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Andi Kleen <ak@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/22] perf list: Support long jevents descriptions
Date: Mon,  3 Oct 2016 23:37:15 -0300
Message-Id: <1475548641-12182-17-git-send-email-acme@kernel.org>
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

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Previously we were dropping the useful longer descriptions that some
events have in the event list completely. This patch makes them appear with
perf list.

Old perf list:

baclears:
  baclears.all
       [Counts the number of baclears]

vs new:

perf list -v:
...
baclears:
  baclears.all
       [The BACLEARS event counts the number of times the front end is
        resteered, mainly when the Branch Prediction Unit cannot provide
        a correct prediction and this is corrected by the Branch Address
        Calculator at the front end. The BACLEARS.ANY event counts the
        number of baclears for any type of branch]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1473978296-20712-13-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt |  6 +++++-
 tools/perf/builtin-list.c              | 16 +++++++++++-----
 tools/perf/util/parse-events.c         |  5 +++--
 tools/perf/util/parse-events.h         |  3 ++-
 tools/perf/util/pmu.c                  | 15 ++++++++++-----
 tools/perf/util/pmu.h                  |  4 +++-
 6 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 72209bc0f523..41857cce5e86 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -8,7 +8,7 @@ perf-list - List all symbolic event types
 SYNOPSIS
 --------
 [verse]
-'perf list' [--no-desc] [hw|sw|cache|tracepoint|pmu|event_glob]
+'perf list' [--no-desc] [--long-desc] [hw|sw|cache|tracepoint|pmu|event_glob]
 
 DESCRIPTION
 -----------
@@ -20,6 +20,10 @@ OPTIONS
 --no-desc::
 Don't print descriptions.
 
+-v::
+--long-desc::
+Print longer event descriptions.
+
 
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index b14cb162f841..ba9322ff858b 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -22,14 +22,17 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 {
 	int i;
 	bool raw_dump = false;
+	bool long_desc_flag = false;
 	struct option list_options[] = {
 		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
 		OPT_BOOLEAN('d', "desc", &desc_flag,
 			    "Print extra event descriptions. --no-desc to not print."),
+		OPT_BOOLEAN('v', "long-desc", &long_desc_flag,
+			    "Print longer event descriptions."),
 		OPT_END()
 	};
 	const char * const list_usage[] = {
-		"perf list [--no-desc] [hw|sw|cache|tracepoint|pmu|sdt|event_glob]",
+		"perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|event_glob]",
 		NULL
 	};
 
@@ -44,7 +47,7 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 		printf("\nList of pre-defined events (to be used in -e):\n\n");
 
 	if (argc == 0) {
-		print_events(NULL, raw_dump, !desc_flag);
+		print_events(NULL, raw_dump, !desc_flag, long_desc_flag);
 		return 0;
 	}
 
@@ -65,14 +68,16 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(NULL, raw_dump);
 		else if (strcmp(argv[i], "pmu") == 0)
-			print_pmu_events(NULL, raw_dump, !desc_flag);
+			print_pmu_events(NULL, raw_dump, !desc_flag,
+						long_desc_flag);
 		else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(NULL, NULL, raw_dump);
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
 
 			if (sep == NULL) {
-				print_events(argv[i], raw_dump, !desc_flag);
+				print_events(argv[i], raw_dump, !desc_flag,
+							long_desc_flag);
 				continue;
 			}
 			sep_idx = sep - argv[i];
@@ -94,7 +99,8 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 			print_symbol_events(s, PERF_TYPE_SOFTWARE,
 					    event_symbols_sw, PERF_COUNT_SW_MAX, raw_dump);
 			print_hwcache_events(s, raw_dump);
-			print_pmu_events(s, raw_dump, !desc_flag);
+			print_pmu_events(s, raw_dump, !desc_flag,
+						long_desc_flag);
 			print_tracepoint_events(NULL, s, raw_dump);
 			print_sdt_events(NULL, s, raw_dump);
 			free(s);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3966ad79ee8d..8f88f63bf96c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2263,7 +2263,8 @@ out_enomem:
 /*
  * Print the help text for the event symbols:
  */
-void print_events(const char *event_glob, bool name_only, bool quiet_flag)
+void print_events(const char *event_glob, bool name_only, bool quiet_flag,
+			bool long_desc)
 {
 	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
 			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
@@ -2273,7 +2274,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag)
 
 	print_hwcache_events(event_glob, name_only);
 
-	print_pmu_events(event_glob, name_only, quiet_flag);
+	print_pmu_events(event_glob, name_only, quiet_flag, long_desc);
 
 	if (event_glob != NULL)
 		return;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 3bf376b42bf9..da246a3ddb69 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -172,7 +172,8 @@ void parse_events_update_lists(struct list_head *list_event,
 void parse_events_evlist_error(struct parse_events_evlist *data,
 			       int idx, const char *str);
 
-void print_events(const char *event_glob, bool name_only, bool quiet);
+void print_events(const char *event_glob, bool name_only, bool quiet,
+		  bool long_desc);
 
 struct event_symbol {
 	const char	*symbol;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 79242cf9bb79..8ff382cb161d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -223,7 +223,7 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 }
 
 static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
-				 char *desc, char *val)
+				 char *desc, char *val, char *long_desc)
 {
 	struct perf_pmu_alias *alias;
 	int ret;
@@ -257,6 +257,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	}
 
 	alias->desc = desc ? strdup(desc) : NULL;
+	alias->long_desc = long_desc ? strdup(long_desc) :
+				desc ? strdup(desc) : NULL;
 
 	list_add_tail(&alias->list, list);
 
@@ -274,7 +276,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 
 	buf[ret] = 0;
 
-	return __perf_pmu__new_alias(list, dir, name, NULL, buf);
+	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL);
 }
 
 static inline bool pmu_alias_info_file(char *name)
@@ -532,7 +534,8 @@ static void pmu_add_cpu_aliases(struct list_head *head)
 
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
-				(char *)pe->desc, (char *)pe->event);
+				(char *)pe->desc, (char *)pe->event,
+				(char *)pe->long_desc);
 	}
 
 out:
@@ -1090,7 +1093,8 @@ static void wordwrap(char *s, int start, int max, int corr)
 	}
 }
 
-void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
+			bool long_desc)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
@@ -1138,7 +1142,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
 			if (!aliases[j].name)
 				goto out_enomem;
 
-			aliases[j].desc = alias->desc;
+			aliases[j].desc = long_desc ? alias->long_desc :
+						alias->desc;
 			j++;
 		}
 		if (pmu->selectable &&
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 7b47192e03b5..2fb8aa0fb47f 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -41,6 +41,7 @@ struct perf_pmu_info {
 struct perf_pmu_alias {
 	char *name;
 	char *desc;
+	char *long_desc;
 	struct list_head terms; /* HEAD struct parse_events_term -> list */
 	struct list_head list;  /* ELEM */
 	char unit[UNIT_MAX_LEN+1];
@@ -72,7 +73,8 @@ int perf_pmu__format_parse(char *dir, struct list_head *head);
 
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
-void print_pmu_events(const char *event_glob, bool name_only, bool quiet);
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet,
+		      bool long_desc);
 bool pmu_have_event(const char *pname, const char *name);
 
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
-- 
2.7.4
