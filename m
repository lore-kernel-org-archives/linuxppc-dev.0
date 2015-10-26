Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76E3D1A040E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 07:17:18 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 26 Oct 2015 14:17:16 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id ABB0319D8045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:05:13 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9QKFwEI4325840
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:15:58 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9QKH3Tx015741
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:17:03 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v18 03/19] perf, tools: Use pmu_events table to create aliases
Date: Mon, 26 Oct 2015 13:14:17 -0700
Message-Id: <1445890473-22877-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1445890473-22877-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1445890473-22877-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At run time (when 'perf' is starting up), locate the specific table
of PMU events that corresponds to the current CPU. Using that table,
create aliases for the each of the PMU events in the CPU. The use
these aliases to parse the user specified perf event.

In short this would allow the user to specify events using their
aliases rather than raw event codes.

Based on input and some earlier patches from Andi Kleen, Jiri Olsa.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---

Changelog[v4]
	- Split off unrelated code into separate patches.
Changelog[v3]
	- [Jiri Olsa] Fix memory leak in cpuid
Changelog[v2]
	- [Andi Kleen] Replace pmu_events_map->vfm with a generic "cpuid".
---
 tools/perf/util/header.h |  1 +
 tools/perf/util/pmu.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 05f27cb..d02b2f9 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -133,4 +133,5 @@ int write_padded(int fd, const void *bf, size_t count, size_t count_aligned);
  */
 int get_cpuid(char *buffer, size_t sz);
 
+char *get_cpuid_str(void);
 #endif /* __PERF_HEADER_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e4b173d..57059ea 100644
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
@@ -449,6 +451,62 @@ static struct cpu_map *pmu_cpumask(const char *name)
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
+static int pmu_add_cpu_aliases(struct list_head *head)
+{
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
+	return 0;
+}
+
 struct perf_event_attr * __weak
 perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
@@ -473,6 +531,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
+	if (!strcmp(name, "cpu"))
+		(void)pmu_add_cpu_aliases(&aliases);
+
 	if (pmu_type(name, &type))
 		return NULL;
 
-- 
2.5.3
