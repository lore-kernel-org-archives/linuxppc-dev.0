Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 573061A0CEF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 03:12:58 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 11:12:56 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1DF301FF004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 11:04:04 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52HCcbE39387172
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 10:12:38 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52HCr8a025606
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 11:12:53 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 03/14] perf,
 tools: Use pmu_events_map table to create event aliases
Date: Tue,  2 Jun 2015 10:12:03 -0700
Message-Id: <1433265135-20426-4-git-send-email-sukadev@linux.vnet.ibm.com>
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

At run time, (i.e when perf is starting up), locate the specific events
table for the current CPU and create event aliases for each of the events.

Use these aliases to parse user's specified perf event.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Changelog[v3]
	[Jiri Olsa] Fix a memory leak with cpuid.

Changelog[v2]
	[Andi Kleen] Replace the pmu_events_map->vfm field with a simple
		generic "cpuid" string and use that string to find the
		matching mapfile entry.
---
 tools/perf/arch/powerpc/util/header.c |   11 ++++
 tools/perf/util/header.h              |    3 +-
 tools/perf/util/pmu.c                 |  104 ++++++++++++++++++++++++++++-----
 3 files changed, 104 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 6c1b8a7..65f9391 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -32,3 +32,14 @@ get_cpuid(char *buffer, size_t sz)
 	}
 	return -1;
 }
+
+char *
+get_cpuid_str(void)
+{
+	char *bufp;
+
+	if (asprintf(&bufp, "%.8lx", mfspr(SPRN_PVR)) < 0)
+		bufp = NULL;
+
+	return bufp;
+}
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index d4d5796..bb2ef5e 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -8,7 +8,6 @@
 #include <linux/types.h>
 #include "event.h"
 
-
 enum {
 	HEADER_RESERVED		= 0,	/* always cleared */
 	HEADER_FIRST_FEATURE	= 1,
@@ -157,4 +156,6 @@ int write_padded(int fd, const void *bf, size_t count, size_t count_aligned);
  */
 int get_cpuid(char *buffer, size_t sz);
 
+char *get_cpuid_str(void);
+
 #endif /* __PERF_HEADER_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0fcc624..0932323 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -10,7 +10,9 @@
 #include "util.h"
 #include "pmu.h"
 #include "parse-events.h"
+#include "pmu-events/pmu-events.h"
 #include "cpumap.h"
+#include "header.h"
 
 struct perf_pmu_format {
 	char *name;
@@ -205,17 +207,11 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 	return 0;
 }
 
-static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FILE *file)
+static int __perf_pmu__new_alias(struct list_head *list, char *name, char *dir, char *desc __maybe_unused, char *val)
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
@@ -225,26 +221,47 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
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
+	if (dir) {
+		/*
+		 * load unit name and scale if available
+		 */
+		perf_pmu__parse_unit(alias, dir, name);
+		perf_pmu__parse_scale(alias, dir, name);
+		perf_pmu__parse_per_pkg(alias, dir, name);
+		perf_pmu__parse_snapshot(alias, dir, name);
+	}
+
 	/*
-	 * load unit name and scale if available
+	 * TODO: pickup description from Andi's patchset
 	 */
-	perf_pmu__parse_unit(alias, dir, name);
-	perf_pmu__parse_scale(alias, dir, name);
-	perf_pmu__parse_per_pkg(alias, dir, name);
-	perf_pmu__parse_snapshot(alias, dir, name);
+	//alias->desc = desc ? strdpu(desc) : NULL;
 
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
+	buf[ret] = 0;
+
+	return __perf_pmu__new_alias(list, name, dir, NULL, buf);
+}
+
 static inline bool pmu_alias_info_file(char *name)
 {
 	size_t len;
@@ -442,6 +459,65 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 	return NULL;
 }
 
+/*
+ * Return the CPU id as a raw string.
+ *
+ * Each architecture should provide a more precise id string that
+ * can be use to match the architecture's "mapfile".
+ */
+char *__attribute__((weak))get_cpuid_str(void)
+{
+	return NULL;
+}
+
+/*
+ * From the pmu_events_map, find the table of PMU events that corresponds
+ * to the current running CPU. Then, add all PMU events from that table
+ * as aliases.
+ */
+static int pmu_add_cpu_aliases(void *data)
+{
+	struct list_head *head = (struct list_head *)data;
+	int i;
+	struct pmu_events_map *map;
+	struct pmu_event *pe;
+	char *cpuid;
+
+	cpuid = get_cpuid_str();
+	if (!cpuid)
+		return 0;
+
+	i = 0;
+	while (1) {
+		map = &pmu_events_map[i++];
+		if (!map->table) {
+			goto out;
+		}
+
+		if (!strcmp(map->cpuid, cpuid))
+			break;
+	}
+
+	/*
+	 * Found a matching PMU events table. Create aliases
+	 */
+	i = 0;
+	while (1) {
+		pe = &map->table[i++];
+		if (!pe->name)
+			break;
+
+		/* need type casts to override 'const' */
+		__perf_pmu__new_alias(head, (char *)pe->name, NULL,
+				(char *)pe->desc, (char *)pe->event);
+	}
+
+out:
+	free(cpuid);
+	return 0;
+}
+
+
 static struct perf_pmu *pmu_lookup(const char *name)
 {
 	struct perf_pmu *pmu;
@@ -464,6 +540,8 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
+	if (!strcmp(name, "cpu"))
+		(void)pmu_add_cpu_aliases(&aliases);
 	if (pmu_type(name, &type))
 		return NULL;
 
-- 
1.7.9.5
