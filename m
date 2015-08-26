Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1C781A0179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 16:07:54 +1000 (AEST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 26 Aug 2015 00:07:52 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8FDFD1FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 23:58:59 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t7Q676eC48234562
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 23:07:06 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7Q67nOF029797
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 00:07:49 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v16 08/16] perf, tools: Add a --no-desc flag to perf list
Date: Tue, 25 Aug 2015 23:05:58 -0700
Message-Id: <1440569166-22169-9-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1440569166-22169-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1440569166-22169-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
---
 tools/perf/Documentation/perf-list.txt |    8 +++++++-
 tools/perf/builtin-list.c              |   12 ++++++++----
 tools/perf/util/parse-events.c         |    4 ++--
 tools/perf/util/parse-events.h         |    2 +-
 tools/perf/util/pmu.c                  |    4 ++--
 tools/perf/util/pmu.h                  |    2 +-
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index bada893..9507552 100644
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
index af5bd05..3f058f7 100644
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
 
@@ -59,13 +63,13 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(NULL, raw_dump);
 		else if (strcmp(argv[i], "pmu") == 0)
-			print_pmu_events(NULL, raw_dump);
+			print_pmu_events(NULL, raw_dump, !desc_flag);
 		else {
 			char *sep = strchr(argv[i], ':'), *s;
 			int sep_idx;
 
 			if (sep == NULL) {
-				print_events(argv[i], raw_dump);
+				print_events(argv[i], raw_dump, !desc_flag);
 				continue;
 			}
 			sep_idx = sep - argv[i];
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d826e6f..5a4aed7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1668,7 +1668,7 @@ out_enomem:
 /*
  * Print the help text for the event symbols:
  */
-void print_events(const char *event_glob, bool name_only)
+void print_events(const char *event_glob, bool name_only, bool quiet_flag)
 {
 	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
 			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
@@ -1678,7 +1678,7 @@ void print_events(const char *event_glob, bool name_only)
 
 	print_hwcache_events(event_glob, name_only);
 
-	print_pmu_events(event_glob, name_only);
+	print_pmu_events(event_glob, name_only, quiet_flag);
 
 	if (event_glob != NULL)
 		return;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index a09b0e2..c0ee03b 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -138,7 +138,7 @@ void parse_events_update_lists(struct list_head *list_event,
 void parse_events_evlist_error(struct parse_events_evlist *data,
 			       int idx, const char *str);
 
-void print_events(const char *event_glob, bool name_only);
+void print_events(const char *event_glob, bool name_only, bool quiet);
 
 struct event_symbol {
 	const char	*symbol;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0f10fa3..e4cb21e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1071,7 +1071,7 @@ static void wordwrap(char *s, int start, int max, int corr)
 	}
 }
 
-void print_pmu_events(const char *event_glob, bool name_only)
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
@@ -1136,7 +1136,7 @@ void print_pmu_events(const char *event_glob, bool name_only)
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
1.7.9.5
