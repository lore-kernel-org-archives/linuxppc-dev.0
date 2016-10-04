Return-Path: <BATV+c3601ec1c81c7bfd3073+4790+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp33s4b7QzDrLw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 13:37:45 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Andi Kleen <ak@linux.intel.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/22] perf list: Add a --no-desc flag
Date: Mon,  3 Oct 2016 23:37:12 -0300
Message-Id: <1475548641-12182-14-git-send-email-acme@kernel.org>
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

Add a --no-desc flag to 'perf list' to not print the event descriptions
that were earlier added for JSON events. This may be useful to get a
less crowded listing.

It's still default to print descriptions as that is the more useful
default for most users.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1473978296-20712-9-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt |  8 +++++++-
 tools/perf/builtin-list.c              | 14 +++++++++-----
 tools/perf/util/parse-events.c         |  4 ++--
 tools/perf/util/parse-events.h         |  2 +-
 tools/perf/util/pmu.c                  |  4 ++--
 tools/perf/util/pmu.h                  |  2 +-
 6 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index a126e97a8114..72209bc0f523 100644
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
index 88ee419e5189..b14cb162f841 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -16,16 +16,20 @@
 #include "util/pmu.h"
 #include <subcmd/parse-options.h>
 
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
-		"perf list [hw|sw|cache|tracepoint|pmu|sdt|event_glob]",
+		"perf list [--no-desc] [hw|sw|cache|tracepoint|pmu|sdt|event_glob]",
 		NULL
 	};
 
@@ -40,7 +44,7 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 		printf("\nList of pre-defined events (to be used in -e):\n\n");
 
 	if (argc == 0) {
-		print_events(NULL, raw_dump);
+		print_events(NULL, raw_dump, !desc_flag);
 		return 0;
 	}
 
@@ -61,14 +65,14 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(NULL, raw_dump);
 		else if (strcmp(argv[i], "pmu") == 0)
-			print_pmu_events(NULL, raw_dump);
+			print_pmu_events(NULL, raw_dump, !desc_flag);
 		else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(NULL, NULL, raw_dump);
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
 
 			if (sep == NULL) {
-				print_events(argv[i], raw_dump);
+				print_events(argv[i], raw_dump, !desc_flag);
 				continue;
 			}
 			sep_idx = sep - argv[i];
@@ -90,7 +94,7 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 			print_symbol_events(s, PERF_TYPE_SOFTWARE,
 					    event_symbols_sw, PERF_COUNT_SW_MAX, raw_dump);
 			print_hwcache_events(s, raw_dump);
-			print_pmu_events(s, raw_dump);
+			print_pmu_events(s, raw_dump, !desc_flag);
 			print_tracepoint_events(NULL, s, raw_dump);
 			print_sdt_events(NULL, s, raw_dump);
 			free(s);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 33546c3ac1fe..3966ad79ee8d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2263,7 +2263,7 @@ out_enomem:
 /*
  * Print the help text for the event symbols:
  */
-void print_events(const char *event_glob, bool name_only)
+void print_events(const char *event_glob, bool name_only, bool quiet_flag)
 {
 	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
 			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
@@ -2273,7 +2273,7 @@ void print_events(const char *event_glob, bool name_only)
 
 	print_hwcache_events(event_glob, name_only);
 
-	print_pmu_events(event_glob, name_only);
+	print_pmu_events(event_glob, name_only, quiet_flag);
 
 	if (event_glob != NULL)
 		return;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 8d09a976fca8..3bf376b42bf9 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -172,7 +172,7 @@ void parse_events_update_lists(struct list_head *list_event,
 void parse_events_evlist_error(struct parse_events_evlist *data,
 			       int idx, const char *str);
 
-void print_events(const char *event_glob, bool name_only);
+void print_events(const char *event_glob, bool name_only, bool quiet);
 
 struct event_symbol {
 	const char	*symbol;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7b46e772f5f9..9dc3506d23fc 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1084,7 +1084,7 @@ static void wordwrap(char *s, int start, int max, int corr)
 	}
 }
 
-void print_pmu_events(const char *event_glob, bool name_only)
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
@@ -1151,7 +1151,7 @@ void print_pmu_events(const char *event_glob, bool name_only)
 			printf("%s ", aliases[j].name);
 			continue;
 		}
-		if (aliases[j].desc) {
+		if (aliases[j].desc && !quiet_flag) {
 			if (numdesc++ == 0)
 				printf("\n");
 			printf("  %-50s\n", aliases[j].name);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 51d8d0d35e63..7b47192e03b5 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -72,7 +72,7 @@ int perf_pmu__format_parse(char *dir, struct list_head *head);
 
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
-void print_pmu_events(const char *event_glob, bool name_only);
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet);
 bool pmu_have_event(const char *pname, const char *name);
 
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
-- 
2.7.4
