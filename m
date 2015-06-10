Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 500201A0E4A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 17:26:30 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 03:26:28 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 7EE4CC90068
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 03:17:31 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5A7QOEU61538510
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 07:26:24 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5A7QNh2015126
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 03:26:24 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v15 15/19] perf,
 tools: Support long descriptions with perf list
Date: Wed, 10 Jun 2015 00:25:19 -0700
Message-Id: <1433921123-25327-16-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433921123-25327-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433921123-25327-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
---
 tools/perf/Documentation/perf-list.txt |  6 +++++-
 tools/perf/builtin-list.c              | 13 +++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 9507552..48202f2 100644
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
index 3f058f7..f800927 100644
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
 
@@ -63,13 +66,15 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(NULL, raw_dump);
 		else if (strcmp(argv[i], "pmu") == 0)
-			print_pmu_events(NULL, raw_dump, !desc_flag);
+			print_pmu_events(NULL, raw_dump, !desc_flag,
+						long_desc_flag);
 		else {
 			char *sep = strchr(argv[i], ':'), *s;
 			int sep_idx;
 
 			if (sep == NULL) {
-				print_events(argv[i], raw_dump, !desc_flag);
+				print_events(argv[i], raw_dump, !desc_flag,
+							long_desc_flag);
 				continue;
 			}
 			sep_idx = sep - argv[i];
-- 
1.8.3.1
