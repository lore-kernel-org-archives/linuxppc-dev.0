Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 92E0B1A09BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 18:43:59 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 14:13:57 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CFC8D3940053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:13:53 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B8hnFu3932370
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:13:49 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B8hnnT015561
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:13:49 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 khandual@linux.vnet.ibm.com, rusty@rustcorp.com.au,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 2/8]powerpc/perf: Export Power8 generic events in sysfs
Date: Thu, 11 Jun 2015 14:13:31 +0530
Message-Id: <1434012217-9776-3-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Export generic perf events for Power8 in sysfs.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-events-list.h | 20 ++++++++++++++++
 arch/powerpc/perf/power8-pmu.c         | 43 +++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/perf/power8-events-list.h

diff --git a/arch/powerpc/perf/power8-events-list.h b/arch/powerpc/perf/power8-events-list.h
new file mode 100644
index 0000000..1368547
--- /dev/null
+++ b/arch/powerpc/perf/power8-events-list.h
@@ -0,0 +1,20 @@
+/*
+ * Performance counter support for POWER8 processors.
+ *
+ * Copyright 2013 Sukadev Bhattiprolu, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * Some power8 event codes.
+ */
+EVENT(PM_CYC,				0x0001e)
+EVENT(PM_GCT_NOSLOT_CYC,		0x100f8)
+EVENT(PM_CMPLU_STALL,			0x4000a)
+EVENT(PM_INST_CMPL,			0x00002)
+EVENT(PM_BRU_FIN,			0x10068)
+EVENT(PM_BR_MPRED_CMPL,			0x400f6)
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 396351d..a542310 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -21,12 +21,11 @@
 /*
  * Some power8 event codes.
  */
-#define PM_CYC				0x0001e
-#define PM_GCT_NOSLOT_CYC		0x100f8
-#define PM_CMPLU_STALL			0x4000a
-#define PM_INST_CMPL			0x00002
-#define PM_BRU_FIN			0x10068
-#define PM_BR_MPRED_CMPL		0x400f6
+enum {
+#include "power8-events-list.h"
+};
+
+#undef EVENT
 
 /* All L1 D cache load references counted at finish, gated by reject */
 #define PM_LD_REF_L1			0x100ee
@@ -604,6 +603,37 @@ static void power8_disable_pmc(unsigned int pmc, unsigned long mmcr[])
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
@@ -640,6 +670,7 @@ struct attribute_group power8_pmu_format_group = {
 
 static const struct attribute_group *power8_pmu_attr_groups[] = {
 	&power8_pmu_format_group,
+	&power8_pmu_events_group,
 	NULL,
 };
 
-- 
1.9.1
