Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 581B01A0D16
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 03:13:03 +1000 (AEST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 11:13:01 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B8A8F19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 11:03:59 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52HCQC333554432
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 10:12:26 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52HCtHv025884
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 11:12:57 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 06/14] perf, tools: Support alias descriptions
Date: Tue,  2 Jun 2015 10:12:06 -0700
Message-Id: <1433265135-20426-7-git-send-email-sukadev@linux.vnet.ibm.com>
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

Changelog
	- Delete a redundant free()
---
 tools/perf/util/pmu.c |   83 +++++++++++++++++++++++++++++++++++++------------
 tools/perf/util/pmu.h |    1 +
 2 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0932323..77b6801 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -239,10 +239,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *name, char *dir,
 		perf_pmu__parse_snapshot(alias, dir, name);
 	}
 
-	/*
-	 * TODO: pickup description from Andi's patchset
-	 */
-	//alias->desc = desc ? strdpu(desc) : NULL;
+	alias->desc = desc ? strdup(desc) : NULL;
 
 	list_add_tail(&alias->list, list);
 
@@ -993,11 +990,42 @@ static char *format_alias_or(char *buf, int len, struct perf_pmu *pmu,
 	return buf;
 }
 
-static int cmp_string(const void *a, const void *b)
+struct pair {
+	char *name;
+	char *desc;
+};
+
+static int cmp_pair(const void *a, const void *b)
 {
-	const char * const *as = a;
-	const char * const *bs = b;
-	return strcmp(*as, *bs);
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
+{
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
@@ -1007,7 +1035,9 @@ void print_pmu_events(const char *event_glob, bool name_only)
 	char buf[1024];
 	int printed = 0;
 	int len, j;
-	char **aliases;
+	struct pair *aliases;
+	int numdesc = 0;
+	int columns = 78;
 
 	pmu = NULL;
 	len = 0;
@@ -1017,14 +1047,15 @@ void print_pmu_events(const char *event_glob, bool name_only)
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
@@ -1033,37 +1064,49 @@ void print_pmu_events(const char *event_glob, bool name_only)
 						       event_glob))))
 				continue;
 
-			if (is_cpu && !name_only)
+			if (is_cpu && !name_only && !alias->desc)
 				name = format_alias_or(buf, sizeof(buf), pmu, alias);
 
-			aliases[j] = strdup(name);
-			if (aliases[j] == NULL)
-				goto out_enomem;
+			aliases[j].name = name;
+			if (is_cpu && !name_only && !alias->desc)
+				aliases[j].name = format_alias_or(buf, sizeof(buf),
+								  pmu, alias);
+			aliases[j].name = strdup(aliases[j].name);
+			/* failure harmless */
+			aliases[j].desc = alias->desc;
 			j++;
 		}
 		if (pmu->selectable) {
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
 	if (printed)
 		printf("\n");
 out_free:
 	for (j = 0; j < len; j++)
-		zfree(&aliases[j]);
+		zfree(&aliases[j].name);
 	zfree(&aliases);
 	return;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 7b9c8cf..e7b1010 100644
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
1.7.9.5
