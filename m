Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZtKQ3J4NzDsZR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 08:25:46 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FMN2CU038203
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:25:44 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25fv62qe99-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:25:44 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 16:25:43 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v21 06/19] perf, tools: Support alias descriptions
Date: Thu, 15 Sep 2016 15:24:43 -0700
In-Reply-To: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1473978296-20712-7-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

Add support to print alias descriptions in perf list, which
are taken from the generated event files.

The sorting code is changed to put the events with descriptions
at the end. The descriptions are printed as possibly multiple word
wrapped lines.

Example output:

% perf list
...
  arith.fpu_div
       [Divide operations executed]
  arith.fpu_div_active
       [Cycles when divider is busy executing divide operations]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
---

Changelog
	- Delete a redundant free()

Changelog[v14]
	- [Jiri Olsa] Fail, rather than continue if strdup() returns NULL;
	  remove unnecessary __maybe_unused.
---
 tools/perf/util/pmu.c | 83 +++++++++++++++++++++++++++++++++++++++++----------
 tools/perf/util/pmu.h |  1 +
 2 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c842886..af1a612 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -222,7 +222,7 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 }
 
 static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
-				 char *desc __maybe_unused, char *val)
+				 char *desc, char *val)
 {
 	struct perf_pmu_alias *alias;
 	int ret;
@@ -255,6 +255,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 		perf_pmu__parse_snapshot(alias, dir, name);
 	}
 
+	alias->desc = desc ? strdup(desc) : NULL;
+
 	list_add_tail(&alias->list, list);
 
 	return 0;
@@ -1044,11 +1046,42 @@ static char *format_alias_or(char *buf, int len, struct perf_pmu *pmu,
 	return buf;
 }
 
-static int cmp_string(const void *a, const void *b)
+struct pair {
+	char *name;
+	char *desc;
+};
+
+static int cmp_pair(const void *a, const void *b)
+{
+	const struct pair *as = a;
+	const struct pair *bs = b;
+
+	/* Put extra events last */
+	if (!!as->desc != !!bs->desc)
+		return !!as->desc - !!bs->desc;
+	return strcmp(as->name, bs->name);
+}
+
+static void wordwrap(char *s, int start, int max, int corr)
 {
-	const char * const *as = a;
-	const char * const *bs = b;
-	return strcmp(*as, *bs);
+	int column = start;
+	int n;
+
+	while (*s) {
+		int wlen = strcspn(s, " \t");
+
+		if (column + wlen >= max && column > start) {
+			printf("\n%*s", start, "");
+			column = start + corr;
+		}
+		n = printf("%s%.*s", column > start ? " " : "", wlen, s);
+		if (n <= 0)
+			break;
+		s += wlen;
+		column += n;
+		while (isspace(*s))
+			s++;
+	}
 }
 
 void print_pmu_events(const char *event_glob, bool name_only)
@@ -1058,7 +1091,9 @@ void print_pmu_events(const char *event_glob, bool name_only)
 	char buf[1024];
 	int printed = 0;
 	int len, j;
-	char **aliases;
+	struct pair *aliases;
+	int numdesc = 0;
+	int columns = 78;
 
 	pmu = NULL;
 	len = 0;
@@ -1068,14 +1103,15 @@ void print_pmu_events(const char *event_glob, bool name_only)
 		if (pmu->selectable)
 			len++;
 	}
-	aliases = zalloc(sizeof(char *) * len);
+	aliases = zalloc(sizeof(struct pair) * len);
 	if (!aliases)
 		goto out_enomem;
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		list_for_each_entry(alias, &pmu->aliases, list) {
-			char *name = format_alias(buf, sizeof(buf), pmu, alias);
+			char *name = alias->desc ? alias->name :
+				format_alias(buf, sizeof(buf), pmu, alias);
 			bool is_cpu = !strcmp(pmu->name, "cpu");
 
 			if (event_glob != NULL &&
@@ -1084,12 +1120,19 @@ void print_pmu_events(const char *event_glob, bool name_only)
 						       event_glob))))
 				continue;
 
-			if (is_cpu && !name_only)
+			if (is_cpu && !name_only && !alias->desc)
 				name = format_alias_or(buf, sizeof(buf), pmu, alias);
 
-			aliases[j] = strdup(name);
-			if (aliases[j] == NULL)
+			aliases[j].name = name;
+			if (is_cpu && !name_only && !alias->desc)
+				aliases[j].name = format_alias_or(buf,
+								  sizeof(buf),
+								  pmu, alias);
+			aliases[j].name = strdup(aliases[j].name);
+			if (!aliases[j].name)
 				goto out_enomem;
+
+			aliases[j].desc = alias->desc;
 			j++;
 		}
 		if (pmu->selectable &&
@@ -1097,25 +1140,33 @@ void print_pmu_events(const char *event_glob, bool name_only)
 			char *s;
 			if (asprintf(&s, "%s//", pmu->name) < 0)
 				goto out_enomem;
-			aliases[j] = s;
+			aliases[j].name = s;
 			j++;
 		}
 	}
 	len = j;
-	qsort(aliases, len, sizeof(char *), cmp_string);
+	qsort(aliases, len, sizeof(struct pair), cmp_pair);
 	for (j = 0; j < len; j++) {
 		if (name_only) {
-			printf("%s ", aliases[j]);
+			printf("%s ", aliases[j].name);
 			continue;
 		}
-		printf("  %-50s [Kernel PMU event]\n", aliases[j]);
+		if (aliases[j].desc) {
+			if (numdesc++ == 0)
+				printf("\n");
+			printf("  %-50s\n", aliases[j].name);
+			printf("%*s", 8, "[");
+			wordwrap(aliases[j].desc, 8, columns, 0);
+			printf("]\n");
+		} else
+			printf("  %-50s [Kernel PMU event]\n", aliases[j].name);
 		printed++;
 	}
 	if (printed && pager_in_use())
 		printf("\n");
 out_free:
 	for (j = 0; j < len; j++)
-		zfree(&aliases[j]);
+		zfree(&aliases[j].name);
 	zfree(&aliases);
 	return;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5d7e844..11bda57 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -38,6 +38,7 @@ struct perf_pmu_info {
 
 struct perf_pmu_alias {
 	char *name;
+	char *desc;
 	struct list_head terms; /* HEAD struct parse_events_term -> list */
 	struct list_head list;  /* ELEM */
 	char unit[UNIT_MAX_LEN+1];
-- 
1.8.3.1
