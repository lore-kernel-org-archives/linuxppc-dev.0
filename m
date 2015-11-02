Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4D751A03D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 07:25:04 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 2 Nov 2015 15:25:02 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id BE74BC90057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 15:13:10 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA2KOxxX61800536
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 20:24:59 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA2KOw2Z027310
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 15:24:59 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 Jiri Olsa <jolsa@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] powerpc/perf: Export Power8 generic and cache events in
 sysfs
Date: Mon,  2 Nov 2015 12:22:23 -0800
Message-Id: <1446495745-24001-3-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1446495745-24001-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1446495745-24001-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export generic and cache perf events for Power8 in sysfs.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-events-list.h | 35 ++++++++++++++++
 arch/powerpc/perf/power8-pmu.c         | 76 +++++++++++++++++-----------------
 2 files changed, 73 insertions(+), 38 deletions(-)
 create mode 100644 arch/powerpc/perf/power8-events-list.h

diff --git a/arch/powerpc/perf/power8-events-list.h b/arch/powerpc/perf/power8-events-list.h
new file mode 100644
index 0000000..3262e26
--- /dev/null
+++ b/arch/powerpc/perf/power8-events-list.h
@@ -0,0 +1,35 @@
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
+EVENT(PM_LD_REF_L1,				0x100ee)
+EVENT(PM_LD_MISS_L1,				0x3e054)
+EVENT(PM_ST_MISS_L1,				0x300f0)
+EVENT(PM_L1_PREF,				0x0d8b8)
+EVENT(PM_INST_FROM_L1,				0x04080)
+EVENT(PM_L1_ICACHE_MISS,			0x200fd)
+EVENT(PM_L1_DEMAND_WRITE,			0x0408c)
+EVENT(PM_IC_PREF_WRITE,				0x0408e)
+EVENT(PM_DATA_FROM_L3,				0x4c042)
+EVENT(PM_DATA_FROM_L3MISS,			0x300fe)
+EVENT(PM_L2_ST,					0x17080)
+EVENT(PM_L2_ST_MISS,				0x17082)
+EVENT(PM_L3_PREF_ALL,				0x4e052)
+EVENT(PM_DTLB_MISS,				0x300fc)
+EVENT(PM_ITLB_MISS,				0x400fc)
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 396351d..11848af 100644
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
@@ -604,6 +572,37 @@ static void power8_disable_pmc(unsigned int pmc, unsigned long mmcr[])
 		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SHIFT(pmc + 1));
 }
 
+GENERIC_EVENT_ATTR(cpu-cyles,			PM_CYC);
+GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_GCT_NOSLOT_CYC);
+GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
+GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
+GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_FIN);
+GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED_CMPL);
+
+#define EVENT(_name, _code)	POWER_EVENT_ATTR(_name, _name);
+#include "power8-events-list.h"
+#undef EVENT
+
+#define EVENT(_name, _code)	POWER_EVENT_PTR(_name),
+
+static struct attribute *power8_events_attr[] = {
+	GENERIC_EVENT_PTR(PM_CYC),
+	GENERIC_EVENT_PTR(PM_GCT_NOSLOT_CYC),
+	GENERIC_EVENT_PTR(PM_CMPLU_STALL),
+	GENERIC_EVENT_PTR(PM_INST_CMPL),
+	GENERIC_EVENT_PTR(PM_BRU_FIN),
+	GENERIC_EVENT_PTR(PM_BR_MPRED_CMPL),
+
+	#include "power8-events-list.h"
+	#undef EVENT
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
@@ -640,6 +639,7 @@ struct attribute_group power8_pmu_format_group = {
 
 static const struct attribute_group *power8_pmu_attr_groups[] = {
 	&power8_pmu_format_group,
+	&power8_pmu_events_group,
 	NULL,
 };
 
-- 
2.5.3
