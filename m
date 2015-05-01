Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9B391A1A83
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 17:06:03 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 1 May 2015 03:06:01 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4F0C3C90043
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 02:57:07 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4175wl350004012
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 07:05:58 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4175vKj027658
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 03:05:57 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [RFC][PATCH 4/4] perf: Create aliases for PMU events
Date: Fri,  1 May 2015 00:05:41 -0700
Message-Id: <1430463941-26109-5-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1430463941-26109-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1430463941-26109-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using the tables of Power7 and Power8 events, create aliases for the
Power PMU events. This would allow us to specify all Power events by
name rather than by raw code:

	$ /tmp/perf stat -e PM_1PLUS_PPC_CMPL sleep 1

	 Performance counter stats for 'sleep 1':

		   757,661      PM_1PLUS_PPC_CMPL

	       1.001620145 seconds time elapsed

The perf binary built on Power8 can be copied to Power7 and it will use
the Power7 events (if arch/powerpc/util/pmu-events.h knows the CPU string).

Hopefully other architecutres can also implement arch_get_events_table()
and take advantage of this.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/Build        |    2 +-
 tools/perf/arch/powerpc/util/pmu-events.c |   52 +++++++++++++++++++
 tools/perf/arch/powerpc/util/pmu-events.h |   17 +++++++
 tools/perf/util/pmu.c                     |   77 +++++++++++++++++++++++++++++
 tools/perf/util/pmu.h                     |   10 ++++
 5 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/powerpc/util/pmu-events.c
 create mode 100644 tools/perf/arch/powerpc/util/pmu-events.h

diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 0af6e9b..52fbc7f 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,4 +1,4 @@
-libperf-y += header.o
+libperf-y += header.o pmu-events.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
diff --git a/tools/perf/arch/powerpc/util/pmu-events.c b/tools/perf/arch/powerpc/util/pmu-events.c
new file mode 100644
index 0000000..7036f6d
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/pmu-events.c
@@ -0,0 +1,52 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include "pmu.h"
+#include "pmu-events.h"
+#include "../../util/debug.h"			/* verbose */
+#include "header.h"				/* mfspr */
+
+static char *get_cpu_str(void)
+{
+	char *bufp;
+
+	if (asprintf(&bufp, "%.8lx-core", mfspr(SPRN_PVR)) < 0)
+		bufp = NULL;
+
+	return bufp;
+}
+
+struct perf_pmu_event *arch_get_events_table(char *cpustr)
+{
+	int i, nmaps, must_free;
+	struct  perf_pmu_event *table;
+
+	must_free = 0;
+	if (!cpustr) {
+		cpustr = get_cpu_str();
+		if (!cpustr)
+			return NULL;
+		must_free = 1;
+	}
+
+	nmaps = sizeof(pvr_events_map) / sizeof(struct pvr_events_map_entry);
+
+	for (i = 0; i < nmaps; i++) {
+		if (!strcmp(pvr_events_map[i].pvr, cpustr))
+			break;
+	}
+
+	table = NULL;
+	if (i < nmaps) {
+		/* pvr_events_map is a const; cast to override */
+		table = (struct perf_pmu_event *)pvr_events_map[i].pmu_events;
+	} else if (verbose) {
+		printf("Unknown CPU %s, ignoring aliases\n", cpustr);
+	}
+
+	if (must_free)
+		free(cpustr);
+
+	return table;
+}
+
diff --git a/tools/perf/arch/powerpc/util/pmu-events.h b/tools/perf/arch/powerpc/util/pmu-events.h
new file mode 100644
index 0000000..1daf8e5
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/pmu-events.h
@@ -0,0 +1,17 @@
+/*
+ * Include all Power processor tables that we care about.
+ */
+#include "power7-events.h"
+#include "power8-events.h"
+
+/*
+ * Map a processor version (PVR) to its table of events.
+ */
+struct pvr_events_map_entry {
+	const char *pvr;
+	const struct perf_pmu_event *pmu_events;
+} pvr_events_map[] = {
+	{ .pvr = "004d0100-core",	.pmu_events = power8_pmu_events },
+	{ .pvr = "003f0201-core",	.pmu_events = power7_pmu_events }
+};
+
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 4841167..f998d91 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -435,6 +435,80 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 	return NULL;
 }
 
+/*
+ * Default arch_get_events_table() is empty.
+ *
+ * Actual implementation is in arch/$(ARCH)/util/pmu-events.c. This
+ * allows architectures could choose what set(s) of events to a) include
+ * in perf binary b) consider for _this_ invocation of perf.
+ *
+ * Eg: For Power, we include both Power7 and Power8 event tables in the
+ * 	perf binary. But depending on the processor where perf is executed,
+ * 	either the Power7 or Power8 table is returned.
+ */
+struct perf_pmu_event * __attribute__ ((weak))
+arch_get_events_table(char *cpustr __maybe_unused)
+{
+	return NULL;
+}
+
+static int pmu_add_cpu_aliases(char *cpustr, void *data)
+{
+	struct list_head *head = (struct list_head *)data;
+	struct perf_pmu_alias *alias;
+	int i;
+	struct perf_pmu_event *events_table, *event;
+	struct parse_events_term *term;
+
+	events_table = arch_get_events_table(cpustr);
+	if (!events_table)
+		return 0;
+
+	for (i = 0; events_table[i].name != NULL; i++) {
+		event = &events_table[i];
+
+		alias = malloc(sizeof(*alias));
+		if (!alias)
+			return -ENOMEM;
+
+		term = malloc(sizeof(*term));
+		if (!term) {
+			/*
+			 * TODO: cleanup aliases allocated so far?
+			 */
+			free(alias);
+			return -ENOMEM;
+		}
+
+		/* ->config is not const; cast to override */
+		term->config = (char *)"event";
+		term->val.num = event->code;
+		term->type_val = PARSE_EVENTS__TERM_TYPE_NUM;
+		term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
+		INIT_LIST_HEAD(&term->list);
+		term->used = 0;
+
+		INIT_LIST_HEAD(&alias->terms);
+		list_add_tail(&alias->terms, &term->list);
+
+		alias->scale = 1.0;
+		alias->unit[0] = '\0';
+		alias->per_pkg = false;
+
+		alias->name = strdup(event->name);
+#if 0
+		/*
+		 * TODO: Need Andi Kleen's patch for ->desc
+		 */
+		alias->desc = event->short_desc ?
+					strdup(event->short_desc) : NULL;
+#endif
+		list_add_tail(&alias->list, head);
+	}
+
+	return 0;
+}
+
 static struct perf_pmu *pmu_lookup(const char *name)
 {
 	struct perf_pmu *pmu;
@@ -453,6 +527,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	if (pmu_aliases(name, &aliases))
 		return NULL;
 
+	if (!strcmp(name, "cpu"))
+		(void)pmu_add_cpu_aliases(NULL, &aliases);
+
 	if (pmu_type(name, &type))
 		return NULL;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 6b1249f..ca3e7a0 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -45,6 +45,14 @@ struct perf_pmu_alias {
 	bool snapshot;
 };
 
+struct perf_pmu_event {
+	const char *name;
+	const unsigned long code;
+	const char *short_desc;
+	const char *long_desc;
+	/* add unit, mask etc as needed here */
+};
+
 struct perf_pmu *perf_pmu__find(const char *name);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct list_head *head_terms);
@@ -76,4 +84,6 @@ int perf_pmu__test(void);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
 
+struct perf_pmu_event *arch_get_events_table(char *cpustr);
+
 #endif /* __PMU_H */
-- 
1.7.9.5
