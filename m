Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6A6A1A08B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:28:15 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 5 Jun 2015 00:28:14 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B2C423E40030
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 00:28:11 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t556SBoL33554558
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 23:28:11 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556SBCv008090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 00:28:11 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 11/19] perf, tools: Add a --no-desc flag to perf list
Date: Thu,  4 Jun 2015 23:27:19 -0700
Message-Id: <1433485647-9314-12-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
index 2a4d1ec..65f7572 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1521,7 +1521,7 @@ out_enomem:
 /*
  * Print the help text for the event symbols:
  */
-void print_events(const char *event_glob, bool name_only)
+void print_events(const char *event_glob, bool name_only, bool quiet_flag)
 {
 	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
 			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
@@ -1531,7 +1531,7 @@ void print_events(const char *event_glob, bool name_only)
 
 	print_hwcache_events(event_glob, name_only);
 
-	print_pmu_events(event_glob, name_only);
+	print_pmu_events(event_glob, name_only, quiet_flag);
 
 	if (event_glob != NULL)
 		return;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 131f29b..d11f854 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -133,7 +133,7 @@ void parse_events_update_lists(struct list_head *list_event,
 void parse_events_evlist_error(struct parse_events_evlist *data,
 			       int idx, const char *str);
 
-void print_events(const char *event_glob, bool name_only);
+void print_events(const char *event_glob, bool name_only, bool quiet);
 
 struct event_symbol {
 	const char	*symbol;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 443086e..790c64f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1030,7 +1030,7 @@ static void wordwrap(char *s, int start, int max, int corr)
 	}
 }
 
-void print_pmu_events(const char *event_glob, bool name_only)
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
@@ -1095,7 +1095,7 @@ void print_pmu_events(const char *event_glob, bool name_only)
 			printf("%s ", aliases[j].name);
 			continue;
 		}
-		if (aliases[j].desc) {
+		if (aliases[j].desc && !quiet_flag) {
 			if (numdesc++ == 0)
 				printf("\n");
 			printf("  %-50s\n", aliases[j].name);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index e7b1010..9966c1a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -69,7 +69,7 @@ int perf_pmu__format_parse(char *dir, struct list_head *head);
 
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
-void print_pmu_events(const char *event_glob, bool name_only);
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet);
 bool pmu_have_event(const char *pname, const char *name);
 
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
-- 
1.7.9.5
