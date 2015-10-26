Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C5A61A0AA2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 07:17:12 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 26 Oct 2015 14:17:11 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 381C519D8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:05:18 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9QKFjE94456744
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:15:45 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9QKH7BW016207
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:17:08 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v18 08/19] perf, tools: Add a --no-desc flag to perf list
Date: Mon, 26 Oct 2015 13:14:22 -0700
Message-Id: <1445890473-22877-9-git-send-email-sukadev@linux.vnet.ibm.com>
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

Add a --no-desc flag to perf list to not print the event descriptions
that were earlier added for JSON events. This may be useful to
get a less crowded listing.

It's still default to print descriptions as that is the more useful
default for most users.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---

v2: Rename --quiet to --no-desc. Add option to man page.

v18: Fix minor conflict in tools/perf/builtin-list.c; Add !desc_flag
	to the newly introduced print_pmu_events() call site.
---
 tools/perf/Documentation/perf-list.txt |  8 +++++++-
 tools/perf/builtin-list.c              | 14 +++++++++-----
 tools/perf/util/parse-events.c         |  4 ++--
 tools/perf/util/parse-events.h         |  2 +-
 tools/perf/util/pmu.c                  |  4 ++--
 tools/perf/util/pmu.h                  |  2 +-
 6 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 79483f4..13aeb09 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -8,13 +8,19 @@ perf-list - List all symbolic event types
 SYNOPSIS
 --------
 [verse]
-'perf list' [hw|sw|cache|tracepoint|pmu|event_glob]
+'perf list' [--no-desc] [hw|sw|cache|tracepoint|pmu|event_glob]
 
 DESCRIPTION
 -----------
 This command displays the symbolic event types which can be selected in the
 various perf commands with the -e option.
 
+OPTIONS
+-------
+--no-desc::
+Don't print descriptions.
+
+
 [[EVENT_MODIFIERS]]
 EVENT MODIFIERS
 ---------------
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index bf679e2..43b375d 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -16,16 +16,20 @@
 #include "util/pmu.h"
 #include "util/parse-options.h"
 
+static bool desc_flag = true;
+
 int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 {
 	int i;
 	bool raw_dump = false;
 	struct option list_options[] = {
 		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
+		OPT_BOOLEAN('d', "desc", &desc_flag,
+			    "Print extra event descriptions. --no-desc to not print."),
 		OPT_END()
 	};
 	const char * const list_usage[] = {
-		"perf list [hw|sw|cache|tracepoint|pmu|event_glob]",
+		"perf list [--no-desc] [hw|sw|cache|tracepoint|pmu|event_glob]",
 		NULL
 	};
 
@@ -40,7 +44,7 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 		printf("\nList of pre-defined events (to be used in -e):\n\n");
 
 	if (argc == 0) {
-		print_events(NULL, raw_dump);
+		print_events(NULL, raw_dump, !desc_flag);
 		return 0;
 	}
 
@@ -61,12 +65,12 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(NULL, raw_dump);
 		else if (strcmp(argv[i], "pmu") == 0)
-			print_pmu_events(NULL, raw_dump);
+			print_pmu_events(NULL, raw_dump, !desc_flag);
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
 
 			if (sep == NULL) {
-				print_events(argv[i], raw_dump);
+				print_events(argv[i], raw_dump, !desc_flag);
 				continue;
 			}
 			sep_idx = sep - argv[i];
@@ -87,7 +91,7 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 			print_symbol_events(s, PERF_TYPE_SOFTWARE,
 					    event_symbols_sw, PERF_COUNT_SW_MAX, raw_dump);
 			print_hwcache_events(s, raw_dump);
-			print_pmu_events(s, raw_dump);
+			print_pmu_events(s, raw_dump, !desc_flag);
 			print_tracepoint_events(NULL, s, raw_dump);
 			free(s);
 		}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 991bbd4..8ec909e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1795,7 +1795,7 @@ out_enomem:
 /*
  * Print the help text for the event symbols:
  */
-void print_events(const char *event_glob, bool name_only)
+void print_events(const char *event_glob, bool name_only, bool quiet_flag)
 {
 	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
 			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
@@ -1805,7 +1805,7 @@ void print_events(const char *event_glob, bool name_only)
 
 	print_hwcache_events(event_glob, name_only);
 
-	print_pmu_events(event_glob, name_only);
+	print_pmu_events(event_glob, name_only, quiet_flag);
 
 	if (event_glob != NULL)
 		return;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index f13d3cc..d78d34a 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -140,7 +140,7 @@ void parse_events_update_lists(struct list_head *list_event,
 void parse_events_evlist_error(struct parse_events_evlist *data,
 			       int idx, const char *str);
 
-void print_events(const char *event_glob, bool name_only);
+void print_events(const char *event_glob, bool name_only, bool quiet);
 
 struct event_symbol {
 	const char	*symbol;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index fcab857..a209246 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1062,7 +1062,7 @@ static void wordwrap(char *s, int start, int max, int corr)
 	}
 }
 
-void print_pmu_events(const char *event_glob, bool name_only)
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
@@ -1128,7 +1128,7 @@ void print_pmu_events(const char *event_glob, bool name_only)
 			printf("%s ", aliases[j].name);
 			continue;
 		}
-		if (aliases[j].desc) {
+		if (aliases[j].desc && !quiet_flag) {
 			if (numdesc++ == 0)
 				printf("\n");
 			printf("  %-50s\n", aliases[j].name);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 11bda57..42999c7 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -70,7 +70,7 @@ int perf_pmu__format_parse(char *dir, struct list_head *head);
 
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
-void print_pmu_events(const char *event_glob, bool name_only);
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet);
 bool pmu_have_event(const char *pname, const char *name);
 
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
-- 
2.5.3
