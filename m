Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00F141A0076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 10:02:44 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:02:42 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 010EFC90042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 19:53:48 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4K02eet54001666
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 00:02:40 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4K02d0Q004504
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:02:39 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/4] perf: Use pmu_events_map table to create event aliases
Date: Tue, 19 May 2015 17:02:09 -0700
Message-Id: <1432080130-6678-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
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
---
 tools/perf/arch/powerpc/util/header.c |   33 +++++++++++
 tools/perf/util/header.h              |    4 +-
 tools/perf/util/pmu.c                 |  104 ++++++++++++++++++++++++++++-----
 3 files changed, 127 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 6c1b8a7..8325012 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -32,3 +32,36 @@ get_cpuid(char *buffer, size_t sz)
 	}
 	return -1;
 }
+
+static char *
+get_cpu_str(void)
+{
+        char *bufp;
+
+        if (asprintf(&bufp, "%.8lx", mfspr(SPRN_PVR)) < 0)
+                bufp = NULL;
+
+        return bufp;
+}
+
+/*
+ * Return TRUE if the CPU identified by @vfm, @version, and @type
+ * matches the current CPU.  vfm refers to [Vendor, Family, Model],
+ *
+ * Return FALSE otherwise.
+ *
+ * For Powerpc, we only compare @version to the processor PVR.
+ */
+bool arch_pmu_events_match_cpu(const char *vfm __maybe_unused,
+				const char *version,
+				const char *type __maybe_unused)
+{
+	char *cpustr;
+	bool rc;
+
+	cpustr = get_cpu_str();
+	rc = !strcmp(version, cpustr);
+	free(cpustr);
+
+	return rc;
+}
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 3bb90ac..207c5b8 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -8,7 +8,6 @@
 #include <linux/types.h>
 #include "event.h"
 
-
 enum {
 	HEADER_RESERVED		= 0,	/* always cleared */
 	HEADER_FIRST_FEATURE	= 1,
@@ -156,4 +155,7 @@ int write_padded(int fd, const void *bf, size_t count, size_t count_aligned);
  */
 int get_cpuid(char *buffer, size_t sz);
 
+bool arch_pmu_events_match_cpu(const char *vfm, const char *version, 
+				const char *type);
+
 #endif /* __PERF_HEADER_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 4841167..7665f0f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -10,7 +10,9 @@
 #include "util.h"
 #include "pmu.h"
 #include "parse-events.h"
+#include "pmu-events/pmu-events.h"	// Move to global file???
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
@@ -435,6 +452,65 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 	return NULL;
 }
 
+/*
+ * Return TRUE if the CPU identified by @vfm, @version, and @type
+ * matches the current CPU.  vfm refers to [Vendor, Family, Model],
+ *
+ * Return FALSE otherwise.
+ *
+ * Each architecture can choose what subset of these attributes they
+ * need to compare/identify a CPU.
+ */
+bool __attribute__((weak))
+arch_pmu_events_match_cpu(const char *vfm __maybe_unused, 
+			const char *version __maybe_unused,
+			const char *type  __maybe_unused)
+{
+	return 0;
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
+
+	i = 0;
+	while(1) {
+		map = &pmu_events_map[i++];
+
+		if (!map->table)
+			return 0;
+
+		if (arch_pmu_events_match_cpu(map->vfm, map->version,
+						map->type))
+			break;
+	}
+
+	/*
+	 * Found a matching PMU events table. Create aliases
+	 */
+	i = 0;
+	while(1) {
+		pe = &map->table[i++];
+		if (!pe->name)
+			break;
+
+		/* need type casts to override 'const' */
+		__perf_pmu__new_alias(head, (char *)pe->name, NULL, 
+				(char *)pe->desc, (char *)pe->event);
+	}
+
+	return 0;
+}
+
+
 static struct perf_pmu *pmu_lookup(const char *name)
 {
 	struct perf_pmu *pmu;
@@ -453,6 +529,8 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
+	if (!strcmp(name, "cpu"))
+		(void)pmu_add_cpu_aliases(&aliases);
 	if (pmu_type(name, &type))
 		return NULL;
 
-- 
1.7.9.5
