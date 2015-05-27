Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EA9E1A0DED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 07:24:08 +1000 (AEST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 27 May 2015 15:24:06 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6789119D8026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 15:15:06 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4RLNogG49479776
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 14:23:50 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4RLO3RJ012132
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 15:24:03 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/10] Use pmu_events_map table to create event aliases
Date: Wed, 27 May 2015 14:23:22 -0700
Message-Id: <1432761809-4344-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

Changelog[v2]
	[Andi Kleen] Replace the pmu_events_map->vfm field with a simple
		generic "cpuid" string and use that string to find the
		matching mapfile entry.
---
 tools/perf/arch/powerpc/util/header.c |   11 ++++
 tools/perf/util/header.h              |    3 +-
 tools/perf/util/pmu.c                 |  103 ++++++++++++++++++++++++++++-----
 3 files changed, 103 insertions(+), 14 deletions(-)

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
index 3bb90ac..86aee07 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -8,7 +8,6 @@
 #include <linux/types.h>
 #include "event.h"
 
-
 enum {
 	HEADER_RESERVED		= 0,	/* always cleared */
 	HEADER_FIRST_FEATURE	= 1,
@@ -156,4 +155,6 @@ int write_padded(int fd, const void *bf, size_t count, size_t count_aligned);
  */
 int get_cpuid(char *buffer, size_t sz);
 
+char *get_cpuid_str(void);
+
 #endif /* __PERF_HEADER_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 4841167..6f652a1 100644
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
@@ -198,17 +200,11 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
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
@@ -218,26 +214,47 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
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
@@ -435,6 +452,64 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
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
+		if (!map->table)
+			return 0;
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
+	free(cpuid);
+
+	return 0;
+}
+
+
 static struct perf_pmu *pmu_lookup(const char *name)
 {
 	struct perf_pmu *pmu;
@@ -453,6 +528,8 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
+	if (!strcmp(name, "cpu"))
+		(void)pmu_add_cpu_aliases(&aliases);
 	if (pmu_type(name, &type))
 		return NULL;
 
-- 
1.7.9.5
