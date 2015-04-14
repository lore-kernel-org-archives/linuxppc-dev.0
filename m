Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE7CE1A0CC5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 16:41:34 +1000 (AEST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 02:41:32 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3B6C06E8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:33:18 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E6fSL228573796
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 06:41:28 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E6fRhe022386
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:41:27 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v9 10/11] perf, tools: Add a --no-desc flag to perf list
Date: Mon, 13 Apr 2015 23:41:03 -0700
Message-Id: <1428993665-2133-11-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
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

Before:

% perf list
...
  baclears.any                                       [Counts the total number when the front end is
                                                      resteered, mainly when the BPU cannot provide a
                                                      correct prediction and this is corrected by other
                                                      branch handling mechanisms at the front end]
  br_inst_exec.all_branches                          [Speculative and retired branches]

After:

% perf list --no-desc
...
  baclears.any                                       [Kernel PMU event]
  br_inst_exec.all_branches                          [Kernel PMU event]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v9] by Sukadev Bhattiprolu
	Rebase to 4.0 and fix conflicts in
		tools/perf/builtin-list.c
v2: Rename --quiet to --no-desc. Add option to man page.
---
 tools/perf/Documentation/perf-list.txt |    5 ++++-
 tools/perf/builtin-list.c              |   16 +++++++++++-----
 tools/perf/util/parse-events.c         |    4 ++--
 tools/perf/util/parse-events.h         |    2 +-
 tools/perf/util/pmu.c                  |    4 ++--
 tools/perf/util/pmu.h                  |    2 +-
 6 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 205ac40..7479efe 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -8,7 +8,7 @@ perf-list - List all symbolic event types
 SYNOPSIS
 --------
 [verse]
-'perf list' [hw|sw|cache|tracepoint|pmu|event_glob]
+'perf list' [--no-desc] [hw|sw|cache|tracepoint|pmu|event_glob]
 
 DESCRIPTION
 -----------
@@ -23,6 +23,9 @@ automatically downloaded with perf download.
 The JSON event file can be also specified with the EVENTMAP environment
 variable.
 
+--no-desc::
+Don't print descriptions.
+
 
 [[EVENT_MODIFIERS]] EVENT MODIFIERS
 ---------------
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index fd07cc1..76dc23b 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -16,6 +16,8 @@
 #include "util/pmu.h"
 #include "util/parse-options.h"
 
+static bool desc_flag = true;
+
 int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 {
 	int i;
@@ -24,10 +26,12 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
 		OPT_STRING(0, "events-file", &json_file, "json file",
 			   "Read event json file"),
+		OPT_BOOLEAN('d', "desc", &desc_flag,
+			    "Print extra event descriptions. --no-desc to not print."),
 		OPT_END()
 	};
 	const char * const list_usage[] = {
-		"perf list [hw|sw|cache|tracepoint|pmu|event_glob]",
+		"perf list [--events-file FILE] [--no-desc] [hw|sw|cache|tracepoint|pmu|event_glob]",
 		NULL
 	};
 
@@ -39,12 +43,12 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 	setup_pager();
 
 	if (raw_dump) {
-		print_events(NULL, true);
+		print_events(NULL, true, !desc_flag);
 		return 0;
 	}
 
 	if (argc == 0) {
-		print_events(NULL, false);
+		print_events(NULL, false, !desc_flag);
 		return 0;
 	}
 
@@ -63,13 +67,15 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(NULL, false);
 		else if (strcmp(argv[i], "pmu") == 0)
-			print_pmu_events(NULL, false);
+			print_pmu_events(NULL, false, !desc_flag);
+		else if (strcmp(argv[i], "--raw-dump") == 0)
+			print_events(NULL, true, !desc_flag);
 		else {
 			char *sep = strchr(argv[i], ':'), *s;
 			int sep_idx;
 
 			if (sep == NULL) {
-				print_events(argv[i], false);
+				print_events(argv[i], false, !desc_flag);
 				continue;
 			}
 			sep_idx = sep - argv[i];
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7f8ec6c..039ba78 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1336,7 +1336,7 @@ static void print_symbol_events(const char *event_glob, unsigned type,
 /*
  * Print the help text for the event symbols:
  */
-void print_events(const char *event_glob, bool name_only)
+void print_events(const char *event_glob, bool name_only, bool silent)
 {
 	if (!name_only) {
 		printf("\n");
@@ -1351,7 +1351,7 @@ void print_events(const char *event_glob, bool name_only)
 
 	print_hwcache_events(event_glob, name_only);
 
-	print_pmu_events(event_glob, name_only);
+	print_pmu_events(event_glob, name_only, silent);
 
 	if (event_glob != NULL)
 		return;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index ff6e1fa..202f81b 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -115,7 +115,7 @@ void parse_events_update_lists(struct list_head *list_event,
 			       struct list_head *list_all);
 void parse_events_error(void *data, void *scanner, char const *msg);
 
-void print_events(const char *event_glob, bool name_only);
+void print_events(const char *event_glob, bool name_only, bool quiet);
 void print_events_type(u8 type);
 void print_tracepoint_events(const char *subsys_glob, const char *event_glob,
 			     bool name_only);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 82f7654..b3c1937 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -930,7 +930,7 @@ static void wordwrap(char *s, int start, int max, int corr)
 	}
 }
 
-void print_pmu_events(const char *event_glob, bool name_only)
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
@@ -992,7 +992,7 @@ void print_pmu_events(const char *event_glob, bool name_only)
 			printf("%s ", aliases[j].name);
 			continue;
 		}
-		if (aliases[j].desc) {
+		if (aliases[j].desc && !quiet_flag) {
 			if (numdesc++ == 0 && printed)
 				printf("\n");
 			printf("  %-50s [", aliases[j].name);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 889cadf..5e375d6 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -67,7 +67,7 @@ int perf_pmu__format_parse(char *dir, struct list_head *head);
 
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
-void print_pmu_events(const char *event_glob, bool name_only);
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet);
 bool pmu_have_event(const char *pname, const char *name);
 
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
-- 
1.7.9.5
