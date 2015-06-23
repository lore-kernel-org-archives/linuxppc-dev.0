Return-Path: <BATV+0c9ede0e67424e6567cb+4321+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413071A0F99
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 07:48:44 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Andi Kleen <ak@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/13] perf pmu: Split perf_pmu__new_alias()
Date: Tue, 23 Jun 2015 18:47:20 -0300
Message-Id: <1435096047-32088-7-git-send-email-acme@kernel.org>
In-Reply-To: <1435096047-32088-1-git-send-email-acme@kernel.org>
References: <1435096047-32088-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Separate the event parsing code in perf_pmu__new_alias() out into a
separate function __perf_pmu__new_alias() so that code can be called
indepdently.

This is based on an earlier patch from Andi Kleen.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1433921123-25327-5-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c6b16b1db6d0..7bcb8c315615 100644
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
2.1.0
