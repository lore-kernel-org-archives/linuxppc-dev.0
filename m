Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B1451A06F5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 10:53:15 +1000 (AEST)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 28 Sep 2015 18:53:14 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4A00119D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 18:44:04 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8T0q0QJ5308898
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 17:52:00 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8T0rBkM027748
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 18:53:11 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v17 11/19] perf, tools: Add alias support for long descriptions
Date: Mon, 28 Sep 2015 17:50:49 -0700
Message-Id: <1443487857-26281-12-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1443487857-26281-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1443487857-26281-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
Acked-by: Jiri Olsa <jolsa@redhat.com>
---

Changelog[v14]
	- [Jiri Olsa] Break up independent parts of the patch into
	  separate patches.
---
 tools/perf/util/parse-events.c |  5 +++--
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/pmu.c          | 15 ++++++++++-----
 tools/perf/util/pmu.h          |  4 +++-
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e9563a0..b23baa5 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1717,7 +1717,8 @@ out_enomem:
 /*
  * Print the help text for the event symbols:
  */
-void print_events(const char *event_glob, bool name_only, bool quiet_flag)
+void print_events(const char *event_glob, bool name_only, bool quiet_flag,
+			bool long_desc)
 {
 	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
 			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
@@ -1727,7 +1728,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag)
 
 	print_hwcache_events(event_glob, name_only);
 
-	print_pmu_events(event_glob, name_only, quiet_flag);
+	print_pmu_events(event_glob, name_only, quiet_flag, long_desc);
 
 	if (event_glob != NULL)
 		return;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 37857e7..d081b73 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -139,7 +139,8 @@ void parse_events_update_lists(struct list_head *list_event,
 void parse_events_evlist_error(struct parse_events_evlist *data,
 			       int idx, const char *str);
 
-void print_events(const char *event_glob, bool name_only, bool quiet);
+void print_events(const char *event_glob, bool name_only, bool quiet,
+		  bool long_desc);
 
 struct event_symbol {
 	const char	*symbol;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ca01aea..e608ccc 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -210,7 +210,7 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 }
 
 static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
-				 char *desc, char *val)
+				 char *desc, char *val, char *long_desc)
 {
 	struct perf_pmu_alias *alias;
 	int ret;
@@ -243,6 +243,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	}
 
 	alias->desc = desc ? strdup(desc) : NULL;
+	alias->long_desc = long_desc ? strdup(long_desc) :
+				desc ? strdup(desc) : NULL;
 
 	list_add_tail(&alias->list, list);
 
@@ -260,7 +262,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 
 	buf[ret] = 0;
 
-	return __perf_pmu__new_alias(list, dir, name, NULL, buf);
+	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL);
 }
 
 static inline bool pmu_alias_info_file(char *name)
@@ -508,7 +510,8 @@ static int pmu_add_cpu_aliases(struct list_head *head)
 
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
-				(char *)pe->desc, (char *)pe->event);
+				(char *)pe->desc, (char *)pe->event,
+				(char *)pe->long_desc);
 	}
 
 out:
@@ -1077,7 +1080,8 @@ static void wordwrap(char *s, int start, int max, int corr)
 	}
 }
 
-void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
+			bool long_desc)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
@@ -1124,7 +1128,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
 			if (!aliases[j].name)
 				goto out_enomem;
 
-			aliases[j].desc = alias->desc;
+			aliases[j].desc = long_desc ? alias->long_desc :
+						alias->desc;
 			j++;
 		}
 		if (pmu->selectable) {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 42999c7..1aa614e 100644
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
@@ -70,7 +71,8 @@ int perf_pmu__format_parse(char *dir, struct list_head *head);
 
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
-void print_pmu_events(const char *event_glob, bool name_only, bool quiet);
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet,
+		      bool long_desc);
 bool pmu_have_event(const char *pname, const char *name);
 
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
-- 
2.5.3
