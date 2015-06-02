Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 575121A0E5D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 05:17:25 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 15:17:22 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 03767C90048
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 15:08:26 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52JHIM960489848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 19:17:18 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52JHHpp007714
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 15:17:18 -0400
Date: Tue, 2 Jun 2015 12:16:41 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 12/14] perf, tools: Add support for event list topics
Message-ID: <20150602191641.GA3978@us.ibm.com>
References: <1433265135-20426-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433265135-20426-13-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433265135-20426-13-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
| From: Andi Kleen <ak@linux.intel.com>
| 
| Add support to group the output of perf list by the Topic field
| in the JSON file.

[PATCH 9/14] has been dropped from this set. This alters the current,
patch [PATCH 12/14], slightly, which is included below.

The branch 'json-v13.1' on github has the updated set of patches:

	https://github.com/sukadev/linux/tree/json-v13.1

>From 0d8fe0d46423ee1e2dcf7d92014b693a3ab14086 Mon Sep 17 00:00:00 2001
From: Andi Kleen <ak@linux.intel.com>
Date: Sun, 31 May 2015 21:19:20 -0400
Subject: [PATCH 12/14] perf, tools: Add support for event list topics

Add support to group the output of perf list by the Topic field
in the JSON file.

Example output:

% perf list
...
Cache:
  l1d.replacement
       [L1D data line replacements]
  l1d_pend_miss.pending
       [L1D miss oustandings duration in cycles]
  l1d_pend_miss.pending_cycles
       [Cycles with L1D load Misses outstanding]
  l2_l1d_wb_rqsts.all
       [Not rejected writebacks from L1D to L2 cache lines in any state]
  l2_l1d_wb_rqsts.hit_e
       [Not rejected writebacks from L1D to L2 cache lines in E state]
  l2_l1d_wb_rqsts.hit_m
       [Not rejected writebacks from L1D to L2 cache lines in M state]

...
Pipeline:
  arith.fpu_div
       [Divide operations executed]
  arith.fpu_div_active
       [Cycles when divider is busy executing divide operations]
  baclears.any
       [Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by
        other branch handling mechanisms at the front end]
  br_inst_exec.all_branches
       [Speculative and retired branches]
  br_inst_exec.all_conditional
       [Speculative and retired macro-conditional branches]
  br_inst_exec.all_direct_jmp
       [Speculative and retired macro-unconditional branches excluding calls and indirects]
  br_inst_exec.all_direct_near_call
       [Speculative and retired direct near calls]
  br_inst_exec.all_indirect_jump_non_call_ret

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Changelog[v2]
	Dropped an unnecessary patch before this and fixed resulting
	conflicts in tools/perf/util/pmu.c
---
 tools/perf/pmu-events/jevents.c    | 16 +++++++++++-----
 tools/perf/pmu-events/jevents.h    |  3 ++-
 tools/perf/pmu-events/pmu-events.h |  1 +
 tools/perf/util/pmu.c              | 34 ++++++++++++++++++++++++----------
 tools/perf/util/pmu.h              |  1 +
 5 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 8990d71..14707fb 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -203,7 +203,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 }
 
 static int print_events_table_entry(void *data, char *name, char *event,
-				    char *desc, char *long_desc)
+				    char *desc, char *long_desc, char *topic)
 {
 	FILE *outfp = data;
 	/*
@@ -216,7 +216,9 @@ static int print_events_table_entry(void *data, char *name, char *event,
 	fprintf(outfp, "\t.event = \"%s\",\n", event);
 	fprintf(outfp, "\t.desc = \"%s\",\n", desc);
 	if (long_desc && long_desc[0])
-		fprintf(outfp, "\t.long_desc = \"%s\"", long_desc);
+		fprintf(outfp, "\t.long_desc = \"%s\",\n", long_desc);
+	if (topic)
+		fprintf(outfp, "\t.topic = \"%s\",\n", topic);
 	fprintf(outfp, "},\n");
 
 	return 0;
@@ -236,7 +238,8 @@ static void print_events_table_suffix(FILE *outfp)
 
 /* Call func with each event in the json file */
 int json_events(const char *fn,
-	  int (*func)(void *data, char *name, char *event, char *desc, char *long_desc),
+	  int (*func)(void *data, char *name, char *event, char *desc,
+		      char *long_desc, char *topic),
 	  void *data)
 {
 	int err = -EIO;
@@ -255,7 +258,7 @@ int json_events(const char *fn,
 	tok = tokens + 1;
 	for (i = 0; i < tokens->size; i++) {
 		char *event = NULL, *desc = NULL, *name = NULL, *long_desc = NULL;
-		char *extra_desc = NULL;
+		char *extra_desc = NULL, *topic = NULL;
 		struct msrmap *msr = NULL;
 		jsmntok_t *msrval = NULL;
 		jsmntok_t *precise = NULL;
@@ -294,6 +297,8 @@ int json_events(const char *fn,
 				   !json_streq(map, val, "null")) {
 				addfield(map, &extra_desc, ". ",
 					" Spec update: ", val);
+			} else if (json_streq(map, field, "Topic")) {
+				addfield(map, &topic, "", "", val);
 			} else if (json_streq(map, field, "Data_LA") && nz) {
 				addfield(map, &extra_desc, ". ",
 					" Supports address when precise",
@@ -316,12 +321,13 @@ int json_events(const char *fn,
 		if (msr != NULL)
 			addfield(map, &event, ",", msr->pname, msrval);
 		fixname(name);
-		err = func(data, name, event, desc, long_desc);
+		err = func(data, name, event, desc, long_desc, topic);
 		free(event);
 		free(desc);
 		free(name);
 		free(extra_desc);
 		free(long_desc);
+		free(topic);
 		if (err)
 			break;
 		tok += j;
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 2168ad4..a556ab1 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -2,7 +2,8 @@
 #define JEVENTS_H 1
 
 int json_events(const char *fn,
-		int (*func)(void *data, char *name, char *event, char *desc, char *long_desc),
+		int (*func)(void *data, char *name, char *event, char *desc,
+			    char *long_desc, char *topic),
 		void *data);
 char *get_cpu_str(void);
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 711f049..6b69f4b 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -9,6 +9,7 @@ struct pmu_event {
 	const char *event;
 	const char *desc;
 	const char *long_desc;
+	const char *topic;
 };
 
 /*
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a4e49c5..8170dce 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -209,7 +209,7 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 }
 
 static int __perf_pmu__new_alias(struct list_head *list, char *name, char *dir, char *desc __maybe_unused, char *val,
-				 char *long_desc)
+				 char *long_desc, char *topic)
 {
 	struct perf_pmu_alias *alias;
 	int ret;
@@ -245,6 +245,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *name, char *dir,
 	alias->long_desc = long_desc ?
 			strdup(long_desc) :
 			desc ? strdup(desc) : NULL;
+	alias->topic = topic ? strdup(topic) : NULL;
 
 	list_add_tail(&alias->list, list);
 
@@ -261,7 +262,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 		return -EINVAL;
 	buf[ret] = 0;
 
-	return __perf_pmu__new_alias(list, name, dir, NULL, buf, NULL);
+	return __perf_pmu__new_alias(list, name, dir, NULL, buf, NULL, NULL);
 }
 
 static inline bool pmu_alias_info_file(char *name)
@@ -518,7 +519,8 @@ static int pmu_add_cpu_aliases(void *data)
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, (char *)pe->name, NULL,
 				(char *)pe->desc, (char *)pe->event,
-				(char *)pe->long_desc);
+				(char *)pe->long_desc,
+				(char *)pe->topic);
 	}
 
 out:
@@ -1002,19 +1004,25 @@ static char *format_alias_or(char *buf, int len, struct perf_pmu *pmu,
 	return buf;
 }
 
-struct pair {
+struct sevent {
 	char *name;
 	char *desc;
+	char *topic;
 };
 
-static int cmp_pair(const void *a, const void *b)
+static int cmp_sevent(const void *a, const void *b)
 {
-	const struct pair *as = a;
-	const struct pair *bs = b;
+	const struct sevent *as = a;
+	const struct sevent *bs = b;
 
 	/* Put extra events last */
 	if (!!as->desc != !!bs->desc)
 		return !!as->desc - !!bs->desc;
+	if (as->topic && bs->topic) {
+		int n = strcmp(as->topic, bs->topic);
+		if (n)
+			return n;
+	}
 	return strcmp(as->name, bs->name);
 }
 
@@ -1048,9 +1056,10 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 	char buf[1024];
 	int printed = 0;
 	int len, j;
-	struct pair *aliases;
+	struct sevent *aliases;
 	int numdesc = 0;
 	int columns = pager_get_columns();
+	char *topic = NULL;
 
 	pmu = NULL;
 	len = 0;
@@ -1060,7 +1069,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 		if (pmu->selectable)
 			len++;
 	}
-	aliases = zalloc(sizeof(struct pair) * len);
+	aliases = zalloc(sizeof(struct sevent) * len);
 	if (!aliases)
 		goto out_enomem;
 	pmu = NULL;
@@ -1088,6 +1097,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 			/* failure harmless */
 			aliases[j].desc = long_desc ? alias->long_desc :
 						      alias->desc;
+			aliases[j].topic = alias->topic;
 			j++;
 		}
 		if (pmu->selectable) {
@@ -1099,7 +1109,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 		}
 	}
 	len = j;
-	qsort(aliases, len, sizeof(struct pair), cmp_pair);
+	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (j = 0; j < len; j++) {
 		if (name_only) {
 			printf("%s ", aliases[j].name);
@@ -1108,6 +1118,10 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 		if (aliases[j].desc && !quiet_flag) {
 			if (numdesc++ == 0)
 				printf("\n");
+			if (aliases[j].topic && (!topic || strcmp(topic, aliases[j].topic))) {
+				printf("%s%s:\n", topic ? "\n" : "", aliases[j].topic);
+				topic = aliases[j].topic;
+			}
 			printf("  %-50s\n", aliases[j].name);
 			printf("%*s", 8, "[");
 			wordwrap(aliases[j].desc, 8, columns, 0);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 1c95477..2d0aab3 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -40,6 +40,7 @@ struct perf_pmu_alias {
 	char *name;
 	char *desc;
 	char *long_desc;
+	char *topic;
 	struct list_head terms; /* HEAD struct parse_events_term -> list */
 	struct list_head list;  /* ELEM */
 	char unit[UNIT_MAX_LEN+1];
-- 
1.8.3.1
