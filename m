Return-Path: <BATV+ef2f77d1cbf736fff7a8+4790+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp33p5MKPzDrLS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 13:37:42 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/22] perf pmu: Use pmu_events table to create aliases
Date: Mon,  3 Oct 2016 23:37:06 -0300
Message-Id: <1475548641-12182-8-git-send-email-acme@kernel.org>
In-Reply-To: <1475548641-12182-1-git-send-email-acme@kernel.org>
References: <1475548641-12182-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

At run time (when 'perf' is starting up), locate the specific table of
PMU events that corresponds to the current CPU. Using that table, create
aliases for the each of the PMU events in the CPU. The use these aliases
to parse the user specified perf event.

In short this would allow the user to specify events using their aliases
rather than raw event codes.

Based on input and some earlier patches from Andi Kleen, Jiri Olsa.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1473978296-20712-4-git-send-email-sukadev@linux.vnet.ibm.com
[ Make pmu_add_cpu_aliases() return void, since it was returning just '0' and
  furthermore, even that was being discarded via an explicit (void) cast ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.h |  1 +
 tools/perf/util/pmu.c    | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index d306ca118449..d30109b421ee 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -151,4 +151,5 @@ int write_padded(int fd, const void *bf, size_t count, size_t count_aligned);
  */
 int get_cpuid(char *buffer, size_t sz);
 
+char *get_cpuid_str(void);
 #endif /* __PERF_HEADER_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2babcdf62839..10668b7f5272 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -12,6 +12,8 @@
 #include "pmu.h"
 #include "parse-events.h"
 #include "cpumap.h"
+#include "header.h"
+#include "pmu-events/pmu-events.h"
 
 struct perf_pmu_format {
 	char *name;
@@ -473,6 +475,61 @@ static struct cpu_map *pmu_cpumask(const char *name)
 	return cpus;
 }
 
+/*
+ * Return the CPU id as a raw string.
+ *
+ * Each architecture should provide a more precise id string that
+ * can be use to match the architecture's "mapfile".
+ */
+char * __weak get_cpuid_str(void)
+{
+	return NULL;
+}
+
+/*
+ * From the pmu_events_map, find the table of PMU events that corresponds
+ * to the current running CPU. Then, add all PMU events from that table
+ * as aliases.
+ */
+static void pmu_add_cpu_aliases(struct list_head *head)
+{
+	int i;
+	struct pmu_events_map *map;
+	struct pmu_event *pe;
+	char *cpuid;
+
+	cpuid = get_cpuid_str();
+	if (!cpuid)
+		return;
+
+	i = 0;
+	while (1) {
+		map = &pmu_events_map[i++];
+		if (!map->table)
+			goto out;
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
+		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
+				(char *)pe->desc, (char *)pe->event);
+	}
+
+out:
+	free(cpuid);
+}
+
 struct perf_event_attr * __weak
 perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
@@ -497,6 +554,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
+	if (!strcmp(name, "cpu"))
+		pmu_add_cpu_aliases(&aliases);
+
 	if (pmu_type(name, &type))
 		return NULL;
 
-- 
2.7.4
