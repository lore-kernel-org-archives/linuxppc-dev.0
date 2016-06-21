Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYYxS3T8CzDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:03:40 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L3xos5119454
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:03:38 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23n2fyjkph-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:03:37 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:03:37 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v20 03/20] perf, tools: Use pmu_events table to create aliases
Date: Mon, 20 Jun 2016 21:02:33 -0700
In-Reply-To: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1466481770-25290-4-git-send-email-sukadev@linux.vnet.ibm.com>
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
index d306ca1..d30109b 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -151,4 +151,5 @@ int write_padded(int fd, const void *bf, size_t count, size_t count_aligned);
  */
 int get_cpuid(char *buffer, size_t sz);
 
+char *get_cpuid_str(void);
 #endif /* __PERF_HEADER_H */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ddb0261..eae0de1 100644
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
@@ -464,6 +466,62 @@ static struct cpu_map *pmu_cpumask(const char *name)
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
@@ -488,6 +546,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
+	if (!strcmp(name, "cpu"))
+		(void)pmu_add_cpu_aliases(&aliases);
+
 	if (pmu_type(name, &type))
 		return NULL;
 
-- 
2.5.3
