Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 992701A08B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:28:11 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 5 Jun 2015 00:28:09 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D2C453E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 00:28:07 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t556S7BZ54657154
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 23:28:07 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556S70Q007841
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 00:28:07 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 04/19] perf, tools: Split perf_pmu__new_alias()
Date: Thu,  4 Jun 2015 23:27:12 -0700
Message-Id: <1433485647-9314-5-git-send-email-sukadev@linux.vnet.ibm.com>
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

Separate the event parsing code in perf_pmu__new_alias() out into
a separate function __perf_pmu__new_alias() so that code can be
called indepdently.

This is based on an earlier patch from Andi Kleen.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/util/pmu.c |   42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c6b16b1..7bcb8c3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -206,17 +206,12 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 	return 0;
 }
 
-static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FILE *file)
+static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
+				 char *desc __maybe_unused, char *val)
 {
 	struct perf_pmu_alias *alias;
-	char buf[256];
 	int ret;
 
-	ret = fread(buf, 1, sizeof(buf), file);
-	if (ret == 0)
-		return -EINVAL;
-	buf[ret] = 0;
-
 	alias = malloc(sizeof(*alias));
 	if (!alias)
 		return -ENOMEM;
@@ -226,26 +221,43 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 	alias->unit[0] = '\0';
 	alias->per_pkg = false;
 
-	ret = parse_events_terms(&alias->terms, buf);
+	ret = parse_events_terms(&alias->terms, val);
 	if (ret) {
+		pr_err("Cannot parse alias %s: %d\n", val, ret);
 		free(alias);
 		return ret;
 	}
 
 	alias->name = strdup(name);
-	/*
-	 * load unit name and scale if available
-	 */
-	perf_pmu__parse_unit(alias, dir, name);
-	perf_pmu__parse_scale(alias, dir, name);
-	perf_pmu__parse_per_pkg(alias, dir, name);
-	perf_pmu__parse_snapshot(alias, dir, name);
+	if (dir) {
+		/*
+		 * load unit name and scale if available
+		 */
+		perf_pmu__parse_unit(alias, dir, name);
+		perf_pmu__parse_scale(alias, dir, name);
+		perf_pmu__parse_per_pkg(alias, dir, name);
+		perf_pmu__parse_snapshot(alias, dir, name);
+	}
 
 	list_add_tail(&alias->list, list);
 
 	return 0;
 }
 
+static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FILE *file)
+{
+	char buf[256];
+	int ret;
+
+	ret = fread(buf, 1, sizeof(buf), file);
+	if (ret == 0)
+		return -EINVAL;
+
+	buf[ret] = 0;
+
+	return __perf_pmu__new_alias(list, dir, name, NULL, buf);
+}
+
 static inline bool pmu_alias_info_file(char *name)
 {
 	size_t len;
-- 
1.7.9.5
