Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9685E1A0D29
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 03:13:09 +1000 (AEST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 11:13:07 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1F4CF19D8048
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 11:04:05 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52HD3ju53936376
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 10:13:03 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52HD1GM026475
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 11:13:02 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 11/14] perf,
 tools: Support long descriptions with perf list -v
Date: Tue,  2 Jun 2015 10:12:11 -0700
Message-Id: <1433265135-20426-12-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

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
       [The BACLEARS event counts the number of times the front end is resteered, mainly when
        the Branch Prediction Unit cannot provide a correct prediction and this is corrected
        by the Branch Address Calculator at the front end. The BACLEARS.ANY event counts the
        number of baclears for any type of branch]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/builtin-list.c          |    9 ++++++---
 tools/perf/pmu-events/jevents.c    |   29 ++++++++++++++++++++---------
 tools/perf/pmu-events/jevents.h    |    2 +-
 tools/perf/pmu-events/pmu-events.h |    1 +
 tools/perf/util/parse-events.c     |    4 ++--
 tools/perf/util/parse-events.h     |    2 +-
 tools/perf/util/pmu.c              |   17 ++++++++++++-----
 tools/perf/util/pmu.h              |    4 +++-
 8 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 3f058f7..c912368 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -22,10 +22,13 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
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
@@ -44,7 +47,7 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 		printf("\nList of pre-defined events (to be used in -e):\n\n");
 
 	if (argc == 0) {
-		print_events(NULL, raw_dump, !desc_flag);
+		print_events(NULL, raw_dump, !desc_flag, long_desc_flag);
 		return 0;
 	}
 
@@ -63,13 +66,13 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(NULL, raw_dump);
 		else if (strcmp(argv[i], "pmu") == 0)
-			print_pmu_events(NULL, raw_dump, !desc_flag);
+			print_pmu_events(NULL, raw_dump, !desc_flag, long_desc_flag);
 		else {
 			char *sep = strchr(argv[i], ':'), *s;
 			int sep_idx;
 
 			if (sep == NULL) {
-				print_events(argv[i], raw_dump, !desc_flag);
+				print_events(argv[i], raw_dump, !desc_flag, long_desc_flag);
 				continue;
 			}
 			sep_idx = sep - argv[i];
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index ab83d85..8990d71 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -203,7 +203,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 }
 
 static int print_events_table_entry(void *data, char *name, char *event,
-				    char *desc)
+				    char *desc, char *long_desc)
 {
 	FILE *outfp = data;
 	/*
@@ -215,7 +215,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 	fprintf(outfp, "\t.name = \"%s\",\n", name);
 	fprintf(outfp, "\t.event = \"%s\",\n", event);
 	fprintf(outfp, "\t.desc = \"%s\",\n", desc);
-
+	if (long_desc && long_desc[0])
+		fprintf(outfp, "\t.long_desc = \"%s\"", long_desc);
 	fprintf(outfp, "},\n");
 
 	return 0;
@@ -235,7 +236,7 @@ static void print_events_table_suffix(FILE *outfp)
 
 /* Call func with each event in the json file */
 int json_events(const char *fn,
-	  int (*func)(void *data, char *name, char *event, char *desc),
+	  int (*func)(void *data, char *name, char *event, char *desc, char *long_desc),
 	  void *data)
 {
 	int err = -EIO;
@@ -253,7 +254,8 @@ int json_events(const char *fn,
 	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
 	tok = tokens + 1;
 	for (i = 0; i < tokens->size; i++) {
-		char *event = NULL, *desc = NULL, *name = NULL;
+		char *event = NULL, *desc = NULL, *name = NULL, *long_desc = NULL;
+		char *extra_desc = NULL;
 		struct msrmap *msr = NULL;
 		jsmntok_t *msrval = NULL;
 		jsmntok_t *precise = NULL;
@@ -279,6 +281,9 @@ int json_events(const char *fn,
 			} else if (json_streq(map, field, "BriefDescription")) {
 				addfield(map, &desc, "", "", val);
 				fixdesc(desc);
+			} else if (json_streq(map, field, "PublicDescription")) {
+				addfield(map, &long_desc, "", "", val);
+				fixdesc(long_desc);
 			} else if (json_streq(map, field, "PEBS") && nz) {
 				precise = val;
 			} else if (json_streq(map, field, "MSRIndex") && nz) {
@@ -287,10 +292,10 @@ int json_events(const char *fn,
 				msrval = val;
 			} else if (json_streq(map, field, "Errata") &&
 				   !json_streq(map, val, "null")) {
-				addfield(map, &desc, ". ",
+				addfield(map, &extra_desc, ". ",
 					" Spec update: ", val);
 			} else if (json_streq(map, field, "Data_LA") && nz) {
-				addfield(map, &desc, ". ",
+				addfield(map, &extra_desc, ". ",
 					" Supports address when precise",
 					NULL);
 			}
@@ -298,19 +303,25 @@ int json_events(const char *fn,
 		}
 		if (precise && !strstr(desc, "(Precise Event)")) {
 			if (json_streq(map, precise, "2"))
-				addfield(map, &desc, " ", "(Must be precise)",
+				addfield(map, &extra_desc, " ", "(Must be precise)",
 						NULL);
 			else
-				addfield(map, &desc, " ",
+				addfield(map, &extra_desc, " ",
 						"(Precise event)", NULL);
 		}
+		if (desc && extra_desc)
+			addfield(map, &desc, " ", extra_desc, NULL);
+		if (long_desc && extra_desc)
+			addfield(map, &long_desc, " ", extra_desc, NULL);
 		if (msr != NULL)
 			addfield(map, &event, ",", msr->pname, msrval);
 		fixname(name);
-		err = func(data, name, event, desc);
+		err = func(data, name, event, desc, long_desc);
 		free(event);
 		free(desc);
 		free(name);
+		free(extra_desc);
+		free(long_desc);
 		if (err)
 			break;
 		tok += j;
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 996601f..2168ad4 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -2,7 +2,7 @@
 #define JEVENTS_H 1
 
 int json_events(const char *fn,
-		int (*func)(void *data, char *name, char *event, char *desc),
+		int (*func)(void *data, char *name, char *event, char *desc, char *long_desc),
 		void *data);
 char *get_cpu_str(void);
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 39fec04..711f049 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -8,6 +8,7 @@ struct pmu_event {
 	const char *name;
 	const char *event;
 	const char *desc;
+	const char *long_desc;
 };
 
 /*
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 65f7572..819e7a5 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1521,7 +1521,7 @@ out_enomem:
 /*
  * Print the help text for the event symbols:
  */
-void print_events(const char *event_glob, bool name_only, bool quiet_flag)
+void print_events(const char *event_glob, bool name_only, bool quiet_flag, bool long_desc)
 {
 	print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
 			    event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
@@ -1531,7 +1531,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag)
 
 	print_hwcache_events(event_glob, name_only);
 
-	print_pmu_events(event_glob, name_only, quiet_flag);
+	print_pmu_events(event_glob, name_only, quiet_flag, long_desc);
 
 	if (event_glob != NULL)
 		return;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index d11f854..d0b640d 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -133,7 +133,7 @@ void parse_events_update_lists(struct list_head *list_event,
 void parse_events_evlist_error(struct parse_events_evlist *data,
 			       int idx, const char *str);
 
-void print_events(const char *event_glob, bool name_only, bool quiet);
+void print_events(const char *event_glob, bool name_only, bool quiet, bool long_desc);
 
 struct event_symbol {
 	const char	*symbol;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2cf03a7..96bf8c7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -208,7 +208,8 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 	return 0;
 }
 
-static int __perf_pmu__new_alias(struct list_head *list, char *name, char *dir, char *desc __maybe_unused, char *val)
+static int __perf_pmu__new_alias(struct list_head *list, char *name, char *dir, char *desc __maybe_unused, char *val,
+				 char *long_desc)
 {
 	struct perf_pmu_alias *alias;
 	int ret;
@@ -241,6 +242,9 @@ static int __perf_pmu__new_alias(struct list_head *list, char *name, char *dir,
 	}
 
 	alias->desc = desc ? strdup(desc) : NULL;
+	alias->long_desc = long_desc ?
+			strdup(long_desc) :
+			desc ? strdup(desc) : NULL;
 
 	list_add_tail(&alias->list, list);
 
@@ -257,7 +261,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 		return -EINVAL;
 	buf[ret] = 0;
 
-	return __perf_pmu__new_alias(list, name, dir, NULL, buf);
+	return __perf_pmu__new_alias(list, name, dir, NULL, buf, NULL);
 }
 
 static inline bool pmu_alias_info_file(char *name)
@@ -513,7 +517,8 @@ static int pmu_add_cpu_aliases(void *data)
 
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, (char *)pe->name, NULL,
-				(char *)pe->desc, (char *)pe->event);
+				(char *)pe->desc, (char *)pe->event,
+				(char *)pe->long_desc);
 	}
 
 out:
@@ -1035,7 +1040,8 @@ static void wordwrap(char *s, int start, int max, int corr)
 	}
 }
 
-void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
+void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
+		      bool long_desc)
 {
 	struct perf_pmu *pmu;
 	struct perf_pmu_alias *alias;
@@ -1082,7 +1088,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag)
 								  pmu, alias);
 			aliases[j].name = strdup(aliases[j].name);
 			/* failure harmless */
-			aliases[j].desc = alias->desc;
+			aliases[j].desc = long_desc ? alias->long_desc :
+						      alias->desc;
 			j++;
 		}
 		if (pmu->selectable) {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 9966c1a..1c95477 100644
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
+			bool long_desc);
 bool pmu_have_event(const char *pname, const char *name);
 
 int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
-- 
1.7.9.5
