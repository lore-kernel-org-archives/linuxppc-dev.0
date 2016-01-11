Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 043D71A0050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 09:56:02 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 11 Jan 2016 15:56:01 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D3AA33E40048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 15:55:57 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0BMtvSr29949982
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 15:55:57 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0BMtvCO026939
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 15:55:57 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] powerpc/perf: Export Power8 generic and cache events to
 sysfs
Date: Mon, 11 Jan 2016 14:55:26 -0800
Message-Id: <1452552926-17494-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1452552926-17494-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1452552926-17494-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power8 supports a large number of events in each susbystem so when a
user runs:

	perf stat -e branch-instructions sleep 1
	perf stat -e L1-dcache-loads sleep 1

it is not clear as to which PMU events were monitored.

Export the generic hardware and cache perf events for Power8 to sysfs,
so users can precisely determine the PMU event monitored by the generic
event.

Eg:
	cat /sys/bus/event_source/devices/cpu/events/branch-instructions
	event=0x10068

	$ cat /sys/bus/event_source/devices/cpu/events/L1-dcache-loads
	event=0x100ee

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |   8 ++
 arch/powerpc/perf/power8-events-list.h       |  51 +++++++++++++
 arch/powerpc/perf/power8-pmu.c               | 110 ++++++++++++++++++---------
 3 files changed, 131 insertions(+), 38 deletions(-)
 create mode 100644 arch/powerpc/perf/power8-events-list.h

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 0691087..e157489 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -136,6 +136,11 @@ extern ssize_t power_events_sysfs_show(struct device *dev,
  * event 'cpu-cycles' can have two entries in sysfs: 'cpu-cycles' and
  * 'PM_CYC' where the latter is the name by which the event is known in
  * POWER CPU specification.
+ *
+ * Similarly, some hardware and cache events use the same event code. Eg.
+ * on POWER8, both "cache-references" and "L1-dcache-loads" events refer
+ * to the same event, PM_LD_REF_L1.  The suffix, allows us to have two
+ * sysfs objects for the same event and thus two entries/aliases in sysfs.
  */
 #define	EVENT_VAR(_id, _suffix)		event_attr_##_id##_suffix
 #define	EVENT_PTR(_id, _suffix)		&EVENT_VAR(_id, _suffix).attr.attr
@@ -147,5 +152,8 @@ extern ssize_t power_events_sysfs_show(struct device *dev,
 #define	GENERIC_EVENT_ATTR(_name, _id)	EVENT_ATTR(_name, _id, _g)
 #define	GENERIC_EVENT_PTR(_id)		EVENT_PTR(_id, _g)
 
+#define	CACHE_EVENT_ATTR(_name, _id)	EVENT_ATTR(_name, _id, _c)
+#define	CACHE_EVENT_PTR(_id)		EVENT_PTR(_id, _c)
+
 #define	POWER_EVENT_ATTR(_name, _id)	EVENT_ATTR(_name, _id, _p)
 #define	POWER_EVENT_PTR(_id)		EVENT_PTR(_id, _p)
diff --git a/arch/powerpc/perf/power8-events-list.h b/arch/powerpc/perf/power8-events-list.h
new file mode 100644
index 0000000..741b77e
--- /dev/null
+++ b/arch/powerpc/perf/power8-events-list.h
@@ -0,0 +1,51 @@
+/*
+ * Performance counter support for POWER8 processors.
+ *
+ * Copyright 2014 Sukadev Bhattiprolu, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * Power8 event codes.
+ */
+EVENT(PM_CYC,					0x0001e)
+EVENT(PM_GCT_NOSLOT_CYC,			0x100f8)
+EVENT(PM_CMPLU_STALL,				0x4000a)
+EVENT(PM_INST_CMPL,				0x00002)
+EVENT(PM_BRU_FIN,				0x10068)
+EVENT(PM_BR_MPRED_CMPL,				0x400f6)
+
+/* All L1 D cache load references counted at finish, gated by reject */
+EVENT(PM_LD_REF_L1,				0x100ee)
+/* Load Missed L1 */
+EVENT(PM_LD_MISS_L1,				0x3e054)
+/* Store Missed L1 */
+EVENT(PM_ST_MISS_L1,				0x300f0)
+/* L1 cache data prefetches */
+EVENT(PM_L1_PREF,				0x0d8b8)
+/* Instruction fetches from L1 */
+EVENT(PM_INST_FROM_L1,				0x04080)
+/* Demand iCache Miss */
+EVENT(PM_L1_ICACHE_MISS,			0x200fd)
+/* Instruction Demand sectors wriittent into IL1 */
+EVENT(PM_L1_DEMAND_WRITE,			0x0408c)
+/* Instruction prefetch written into IL1 */
+EVENT(PM_IC_PREF_WRITE,				0x0408e)
+/* The data cache was reloaded from local core's L3 due to a demand load */
+EVENT(PM_DATA_FROM_L3,				0x4c042)
+/* Demand LD - L3 Miss (not L2 hit and not L3 hit) */
+EVENT(PM_DATA_FROM_L3MISS,			0x300fe)
+/* All successful D-side store dispatches for this thread */
+EVENT(PM_L2_ST,					0x17080)
+/* All successful D-side store dispatches for this thread that were L2 Miss */
+EVENT(PM_L2_ST_MISS,				0x17082)
+/* Total HW L3 prefetches(Load+store) */
+EVENT(PM_L3_PREF_ALL,				0x4e052)
+/* Data PTEG reload */
+EVENT(PM_DTLB_MISS,				0x300fc)
+/* ITLB Reloaded */
+EVENT(PM_ITLB_MISS,				0x400fc)
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 7d5e295..08ab998 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -17,48 +17,16 @@
 #include <asm/firmware.h>
 #include <asm/cputable.h>
 
-
 /*
  * Some power8 event codes.
  */
-#define PM_CYC				0x0001e
-#define PM_GCT_NOSLOT_CYC		0x100f8
-#define PM_CMPLU_STALL			0x4000a
-#define PM_INST_CMPL			0x00002
-#define PM_BRU_FIN			0x10068
-#define PM_BR_MPRED_CMPL		0x400f6
-
-/* All L1 D cache load references counted at finish, gated by reject */
-#define PM_LD_REF_L1			0x100ee
-/* Load Missed L1 */
-#define PM_LD_MISS_L1			0x3e054
-/* Store Missed L1 */
-#define PM_ST_MISS_L1			0x300f0
-/* L1 cache data prefetches */
-#define PM_L1_PREF			0x0d8b8
-/* Instruction fetches from L1 */
-#define PM_INST_FROM_L1			0x04080
-/* Demand iCache Miss */
-#define PM_L1_ICACHE_MISS		0x200fd
-/* Instruction Demand sectors wriittent into IL1 */
-#define PM_L1_DEMAND_WRITE		0x0408c
-/* Instruction prefetch written into IL1 */
-#define PM_IC_PREF_WRITE		0x0408e
-/* The data cache was reloaded from local core's L3 due to a demand load */
-#define PM_DATA_FROM_L3			0x4c042
-/* Demand LD - L3 Miss (not L2 hit and not L3 hit) */
-#define PM_DATA_FROM_L3MISS		0x300fe
-/* All successful D-side store dispatches for this thread */
-#define PM_L2_ST			0x17080
-/* All successful D-side store dispatches for this thread that were L2 Miss */
-#define PM_L2_ST_MISS			0x17082
-/* Total HW L3 prefetches(Load+store) */
-#define PM_L3_PREF_ALL			0x4e052
-/* Data PTEG reload */
-#define PM_DTLB_MISS			0x300fc
-/* ITLB Reloaded */
-#define PM_ITLB_MISS			0x400fc
+#define EVENT(_name, _code)	_name = _code,
+
+enum {
+#include "power8-events-list.h"
+};
 
+#undef EVENT
 
 /*
  * Raw event encoding for POWER8:
@@ -604,6 +572,71 @@ static void power8_disable_pmc(unsigned int pmc, unsigned long mmcr[])
 		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SHIFT(pmc + 1));
 }
 
+GENERIC_EVENT_ATTR(cpu-cycles,			PM_CYC);
+GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_GCT_NOSLOT_CYC);
+GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
+GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
+GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_FIN);
+GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED_CMPL);
+GENERIC_EVENT_ATTR(cache-references,		PM_LD_REF_L1);
+GENERIC_EVENT_ATTR(cache-misses,		PM_LD_MISS_L1);
+
+CACHE_EVENT_ATTR(L1-dcache-load-misses,		PM_LD_MISS_L1);
+CACHE_EVENT_ATTR(L1-dcache-loads,		PM_LD_REF_L1);
+
+CACHE_EVENT_ATTR(L1-dcache-prefetches,		PM_L1_PREF);
+CACHE_EVENT_ATTR(L1-dcache-store-misses,	PM_ST_MISS_L1);
+CACHE_EVENT_ATTR(L1-icache-load-misses,		PM_L1_ICACHE_MISS);
+CACHE_EVENT_ATTR(L1-icache-loads,		PM_INST_FROM_L1);
+CACHE_EVENT_ATTR(L1-icache-prefetches,		PM_IC_PREF_WRITE);
+
+CACHE_EVENT_ATTR(LLC-load-misses,		PM_DATA_FROM_L3MISS);
+CACHE_EVENT_ATTR(LLC-loads,			PM_DATA_FROM_L3);
+CACHE_EVENT_ATTR(LLC-prefetches,		PM_L3_PREF_ALL);
+CACHE_EVENT_ATTR(LLC-store-misses,		PM_L2_ST_MISS);
+CACHE_EVENT_ATTR(LLC-stores,			PM_L2_ST);
+
+CACHE_EVENT_ATTR(branch-load-misses,		PM_BR_MPRED_CMPL);
+CACHE_EVENT_ATTR(branch-loads,			PM_BRU_FIN);
+CACHE_EVENT_ATTR(dTLB-load-misses,		PM_DTLB_MISS);
+CACHE_EVENT_ATTR(iTLB-load-misses,		PM_ITLB_MISS);
+
+static struct attribute *power8_events_attr[] = {
+	GENERIC_EVENT_PTR(PM_CYC),
+	GENERIC_EVENT_PTR(PM_GCT_NOSLOT_CYC),
+	GENERIC_EVENT_PTR(PM_CMPLU_STALL),
+	GENERIC_EVENT_PTR(PM_INST_CMPL),
+	GENERIC_EVENT_PTR(PM_BRU_FIN),
+	GENERIC_EVENT_PTR(PM_BR_MPRED_CMPL),
+	GENERIC_EVENT_PTR(PM_LD_REF_L1),
+	GENERIC_EVENT_PTR(PM_LD_MISS_L1),
+
+	CACHE_EVENT_PTR(PM_LD_MISS_L1),
+	CACHE_EVENT_PTR(PM_LD_REF_L1),
+	CACHE_EVENT_PTR(PM_L1_PREF),
+	CACHE_EVENT_PTR(PM_ST_MISS_L1),
+	CACHE_EVENT_PTR(PM_L1_ICACHE_MISS),
+	CACHE_EVENT_PTR(PM_INST_FROM_L1),
+	CACHE_EVENT_PTR(PM_IC_PREF_WRITE),
+	CACHE_EVENT_PTR(PM_DATA_FROM_L3MISS),
+	CACHE_EVENT_PTR(PM_DATA_FROM_L3),
+	CACHE_EVENT_PTR(PM_L3_PREF_ALL),
+	CACHE_EVENT_PTR(PM_L2_ST_MISS),
+	CACHE_EVENT_PTR(PM_L2_ST),
+
+	CACHE_EVENT_PTR(PM_BR_MPRED_CMPL),
+	CACHE_EVENT_PTR(PM_BRU_FIN),
+
+	CACHE_EVENT_PTR(PM_DTLB_MISS),
+	CACHE_EVENT_PTR(PM_ITLB_MISS),
+	NULL
+};
+
+static struct attribute_group power8_pmu_events_group = {
+	.name = "events",
+	.attrs = power8_events_attr,
+};
+
 PMU_FORMAT_ATTR(event,		"config:0-49");
 PMU_FORMAT_ATTR(pmcxsel,	"config:0-7");
 PMU_FORMAT_ATTR(mark,		"config:8");
@@ -640,6 +673,7 @@ struct attribute_group power8_pmu_format_group = {
 
 static const struct attribute_group *power8_pmu_attr_groups[] = {
 	&power8_pmu_format_group,
+	&power8_pmu_events_group,
 	NULL,
 };
 
-- 
2.5.3
