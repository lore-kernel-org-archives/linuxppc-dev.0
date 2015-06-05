Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C58761A0923
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:28:16 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 5 Jun 2015 00:28:14 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DB4BF19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 00:19:14 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t556SDEx52363324
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 23:28:13 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556SCnG008175
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 00:28:13 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 14/19] perf, tools: Add alias support for long descriptions
Date: Thu,  4 Jun 2015 23:27:22 -0700
Message-Id: <1433485647-9314-15-git-send-email-sukadev@linux.vnet.ibm.com>
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

Previously we were dropping the useful longer descriptions that some
events have in the event list completely. Now that jevents provides
support for longer descriptions (see previous patch), add support for
parsing the long descriptions

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Changelog[v14]
	- [Jiri Olsa] Break up independent parts of the patch into
	  separate patches.
---
 tools/perf/util/parse-events.c |    5 +++--
 tools/perf/util/parse-events.h |    3 ++-
 tools/perf/util/pmu.c          |   16 +++++++++++-----
 tools/perf/util/pmu.h          |    4 +++-
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 65f7572..c4ee41d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1521,7 +1521,8 @@ out_enomem:
 /*
  * Print the help text for the event symbols:
  */
-void print_events(const char *event_glob, bool name_only, bool quiet_flag)
+void print_events(const char *event_glob, bool name_only, bool quiet_flag,
+			bool long_desc)
 {
 	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
 			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
@@ -1531,7 +1532,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag)
 
 	print_hwcache_events(event_glob, name_only);
 
-	print_pmu_events(event_glob, name_only, quiet_flag);
+	print_pmu_events(event_glob, name_only, quiet_flag, long_desc);
 
 	if (event_glob != NULL)
 		return;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index d11f854..5c93814 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -133,7 +133,8 @@ void parse_events_update_lists(struct list_head *list_event,
 void parse_events_evlist_error(struct parse_events_evlist *data,
 			       int idx, const char *str);
 
-void print_events(const char *event_glob, bool name_only, bool quiet);
+void print_events(const char *event_glob, bool name_only, bool quiet,
+		  bool long_desc);
 
 struct event_symbol {
 	const char	*symbol;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 300975e..05653ec 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -210,7 +210,8 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 }
 
 static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
-				 char *desc __maybe_unused, char *val)
+				 char *desc __maybe_unused, char *val,
+				 char *long_desc)
 {
 	struct perf_pmu_alias *alias;
 	int ret;
@@ -243,6 +244,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	}
 
 	alias->desc = desc ? strdup(desc) : NULL;
+	alias->long_desc = long_desc ? strdup(long_desc) :
+				desc ? strdup(desc) : NULL;
 
 	list_add_tail(&alias->list, list);
 
@@ -260,7 +263,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 
 	buf[ret] = 0;
 
-	return __perf_pmu__new_alias(list, dir, name, NULL, buf);
+	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL);
 }
 
 static inline bool pmu_alias_info_file(char *name)
@@ -508,7 +511,8 @@ static int pmu_add_cpu_aliases(struct list_head *head)
 
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
-				(char *)pe->desc, (char *)pe->event);
+				(char *)pe->desc, (char *)pe->event,
+				(char *)pe->long_desc);
 	}
 
 out:
@@ -1036,7 +1040,8 @@ static void wordwrap(char *s, int start, int max, int corr)
 	}
 }
 
-void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
+			bool long_desc)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
@@ -1083,7 +1088,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
 			if (!aliases[j].name)
 				goto out_enomem;
 
-			aliases[j].desc = alias->desc;
+			aliases[j].desc = long_desc ? alias->long_desc :
+						alias->desc;
 			j++;
 		}
 		if (pmu->selectable) {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 9966c1a..10e981c 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -39,6 +39,7 @@ struct perf_pmu_info {
 struct perf_pmu_alias {
 	char *name;
 	char *desc;
+	char *long_desc;
 	struct list_head terms; /* HEAD struct parse_events_term -> list */
 	struct list_head list;  /* ELEM */
 	char unit[UNIT_MAX_LEN+1];
@@ -69,7 +70,8 @@ int perf_pmu__format_parse(char *dir, struct list_head *head);
 
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
-void print_pmu_events(const char *event_glob, bool name_only, bool quiet);
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet,
+		      bool long_desc);
 bool pmu_have_event(const char *pname, const char *name);
 
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
-- 
1.7.9.5
