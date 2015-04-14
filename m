Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F3CD1A0CAE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 16:41:26 +1000 (AEST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 02:41:24 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 603A66E804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:33:10 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E6fK9e19529864
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 06:41:20 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E6fJmY021815
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:41:19 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v9 03/11] perf, tools,
 list: Update perf list to output descriptions
Date: Mon, 13 Apr 2015 23:40:56 -0700
Message-Id: <1428993665-2133-4-git-send-email-sukadev@linux.vnet.ibm.com>
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

Add support to perf list to print aliases with descriptions.
Support word wrapping for descriptions.
Fix up the sorting code to put aliases with descriptions
last.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

Changelov[v9] by Sukadev Bhattiprolu
	Rebase to 4.0 and fix conflicts in tools/perf/util/pmu.c
---
 tools/perf/util/pmu.c |   86 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 527da74..623b107 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -877,11 +877,51 @@ static char *format_alias_or(char *buf, int len, struct perf_pmu *pmu,
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
+	/* Put downloaded event list last */
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
+}
+
+static int get_columns(void)
+{
+	/*
+	 * Should ask the terminal with TIOCGWINSZ here, but we
+	 * need the original fd before the pager.
+	 */
+	return 79;
 }
 
 void print_pmu_events(const char *event_glob, bool name_only)
@@ -891,7 +931,9 @@ void print_pmu_events(const char *event_glob, bool name_only)
 	char buf[1024];
 	int printed = 0;
 	int len, j;
-	char **aliases;
+	struct pair *aliases;
+	int numdesc = 0;
+	int columns = get_columns();
 
 	pmu = NULL;
 	len = 0;
@@ -901,14 +943,15 @@ void print_pmu_events(const char *event_glob, bool name_only)
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
@@ -917,11 +960,14 @@ void print_pmu_events(const char *event_glob, bool name_only)
 						       event_glob))))
 				continue;
 
-			if (is_cpu && !name_only)
-				name = format_alias_or(buf, sizeof(buf), pmu, alias);
+			aliases[j].name = name;
+			if (is_cpu && !name_only && !alias->desc)
+				aliases[j].name = format_alias_or(buf,
+						sizeof(buf), pmu, alias);
 
-			aliases[j] = strdup(name);
-			if (aliases[j] == NULL)
+			aliases[j].name = strdup(aliases[j].name);
+			aliases[j].desc = alias->desc;
+			if (aliases[j].name == NULL)
 				goto out_enomem;
 			j++;
 		}
@@ -929,25 +975,33 @@ void print_pmu_events(const char *event_glob, bool name_only)
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
+			if (numdesc++ == 0 && printed)
+				printf("\n");
+			printf("  %-50s [", aliases[j].name);
+			wordwrap(aliases[j].desc, 53, columns, 1);
+			printf("]\n");
+		} else
+			printf("  %-50s [Kernel PMU event]\n", aliases[j].name);
+		zfree(&aliases[j].name);
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
 
-- 
1.7.9.5
