Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DCBEB2C0397
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 13:07:16 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 15 Oct 2013 22:07:14 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id BC3726E8040
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 22:07:10 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G27Bsc5439944
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 02:07:11 GMT
Received: from d03av04.boulder.ibm.com (localhost [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G27ARd022797
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:11 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 06/10][v6] powerpc/perf: Export Power8 generic events in sysfs
Date: Tue, 15 Oct 2013 19:06:38 -0700
Message-Id: <1381889202-16826-7-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export generic perf events for Power8 in sysfs.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v6]:
	[Michael Ellerman] Drop PME_ prefix in macros

 arch/powerpc/perf/power8-events-list.h |   20 +++++++++++++++
 arch/powerpc/perf/power8-pmu.c         |   44 +++++++++++++++++++++++++++-----
 2 files changed, 58 insertions(+), 6 deletions(-)
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
index 2ee4a70..5141d97 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -18,13 +18,13 @@
 /*
  * Some power8 event codes.
  */
-#define PM_CYC				0x0001e
-#define PM_GCT_NOSLOT_CYC		0x100f8
-#define PM_CMPLU_STALL			0x4000a
-#define PM_INST_CMPL			0x00002
-#define PM_BRU_FIN			0x10068
-#define PM_BR_MPRED_CMPL		0x400f6
+#define EVENT(_name, _code)	_name = _code,
 
+enum {
+#include "power8-events-list.h"
+};
+
+#undef EVENT
 
 /*
  * Raw event encoding for POWER8:
@@ -510,6 +510,37 @@ static void power8_disable_pmc(unsigned int pmc, unsigned long mmcr[])
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
@@ -546,6 +577,7 @@ struct attribute_group power8_pmu_format_group = {
 
 static const struct attribute_group *power8_pmu_attr_groups[] = {
 	&power8_pmu_format_group,
+	&power8_pmu_events_group,
 	NULL,
 };
 
-- 
1.7.9.5
