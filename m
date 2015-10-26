Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2429E1A0443
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 07:17:14 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 26 Oct 2015 14:17:13 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 3FC1E19D8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:05:21 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9QKFmwx4456758
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:15:48 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9QKHAVp016511
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:17:11 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v18 12/19] perf,
 tools: Support long descriptions with perf list
Date: Mon, 26 Oct 2015 13:14:26 -0700
Message-Id: <1445890473-22877-13-git-send-email-sukadev@linux.vnet.ibm.com>
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
Acked-by: Jiri Olsa <jolsa@redhat.com>
---

Changelog[v15]
	- [Jir Olsa, Andi Kleen] Fix usage strings; update man page.

Changelog[v14]
	- [Jiri Olsa] Break up independent parts of the patch into
	  separate patches.

Changelog[v18]:
	- Fix minor conflict in tools/perf/builtin-list.c; add long_desc_flag
	  parameter to new print_pmu_events() call site.
---
 tools/perf/Documentation/perf-list.txt |  6 +++++-
 tools/perf/builtin-list.c              | 16 +++++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 13aeb09..4664643 100644
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
index 43b375d..6b5d0a4 100644
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
-		"perf list [--no-desc] [hw|sw|cache|tracepoint|pmu|event_glob]",
+		"perf list [<options>] [hw|sw|cache|tracepoint|pmu|event_glob]",
 		NULL
 	};
 
@@ -44,7 +47,7 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 		printf("\nList of pre-defined events (to be used in -e):\n\n");
 
 	if (argc == 0) {
-		print_events(NULL, raw_dump, !desc_flag);
+		print_events(NULL, raw_dump, !desc_flag, long_desc_flag);
 		return 0;
 	}
 
@@ -65,12 +68,14 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(NULL, raw_dump);
 		else if (strcmp(argv[i], "pmu") == 0)
-			print_pmu_events(NULL, raw_dump, !desc_flag);
+			print_pmu_events(NULL, raw_dump, !desc_flag,
+						long_desc_flag);
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
 
 			if (sep == NULL) {
-				print_events(argv[i], raw_dump, !desc_flag);
+				print_events(argv[i], raw_dump, !desc_flag,
+							long_desc_flag);
 				continue;
 			}
 			sep_idx = sep - argv[i];
@@ -91,7 +96,8 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 			print_symbol_events(s, PERF_TYPE_SOFTWARE,
 					    event_symbols_sw, PERF_COUNT_SW_MAX, raw_dump);
 			print_hwcache_events(s, raw_dump);
-			print_pmu_events(s, raw_dump, !desc_flag);
+			print_pmu_events(s, raw_dump, !desc_flag,
+						long_desc_flag);
 			print_tracepoint_events(NULL, s, raw_dump);
 			free(s);
 		}
-- 
2.5.3
