Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tRpmm29dxzDvk5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 12:21:44 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAS1Ih5o122245
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 20:21:40 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27016y8yxr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 20:21:40 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 28 Nov 2016 11:21:37 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6D1732BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 12:21:35 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAS1LZmD52822084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 12:21:35 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAS1LYEl010070
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 12:21:35 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v3 1/4] powerpc/perf: factor out the event format field
Date: Mon, 28 Nov 2016 06:51:13 +0530
In-Reply-To: <1480296076-28880-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1480296076-28880-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1480296076-28880-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Factor out the format field structure for PowerISA v2.07.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/isa207-common.c | 34 ++++++++++++++++++++++++++++++++++
 arch/powerpc/perf/power8-pmu.c    | 39 ++++-----------------------------------
 arch/powerpc/perf/power9-pmu.c    | 39 ++++-----------------------------------
 3 files changed, 42 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 6143c99f3ec5..2a2040ea5f99 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -12,6 +12,40 @@
  */
 #include "isa207-common.h"
 
+PMU_FORMAT_ATTR(event,		"config:0-49");
+PMU_FORMAT_ATTR(pmcxsel,	"config:0-7");
+PMU_FORMAT_ATTR(mark,		"config:8");
+PMU_FORMAT_ATTR(combine,	"config:11");
+PMU_FORMAT_ATTR(unit,		"config:12-15");
+PMU_FORMAT_ATTR(pmc,		"config:16-19");
+PMU_FORMAT_ATTR(cache_sel,	"config:20-23");
+PMU_FORMAT_ATTR(sample_mode,	"config:24-28");
+PMU_FORMAT_ATTR(thresh_sel,	"config:29-31");
+PMU_FORMAT_ATTR(thresh_stop,	"config:32-35");
+PMU_FORMAT_ATTR(thresh_start,	"config:36-39");
+PMU_FORMAT_ATTR(thresh_cmp,	"config:40-49");
+
+struct attribute *isa207_pmu_format_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_pmcxsel.attr,
+	&format_attr_mark.attr,
+	&format_attr_combine.attr,
+	&format_attr_unit.attr,
+	&format_attr_pmc.attr,
+	&format_attr_cache_sel.attr,
+	&format_attr_sample_mode.attr,
+	&format_attr_thresh_sel.attr,
+	&format_attr_thresh_stop.attr,
+	&format_attr_thresh_start.attr,
+	&format_attr_thresh_cmp.attr,
+	NULL,
+};
+
+struct attribute_group isa207_pmu_format_group = {
+	.name = "format",
+	.attrs = isa207_pmu_format_attr,
+};
+
 static inline bool event_is_fab_match(u64 event)
 {
 	/* Only check pmc, unit and pmcxsel, ignore the edge bit (0) */
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index ab830d106ec5..d07186382f3a 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -30,6 +30,9 @@ enum {
 #define	POWER8_MMCRA_IFM2		0x0000000080000000UL
 #define	POWER8_MMCRA_IFM3		0x00000000C0000000UL
 
+/* PowerISA v2.07 format attribute structure*/
+extern struct attribute_group isa207_pmu_format_group;
+
 /* Table of alternatives, sorted by column 0 */
 static const unsigned int event_alternatives[][MAX_ALT] = {
 	{ PM_MRK_ST_CMPL,		PM_MRK_ST_CMPL_ALT },
@@ -175,42 +178,8 @@ static struct attribute_group power8_pmu_events_group = {
 	.attrs = power8_events_attr,
 };
 
-PMU_FORMAT_ATTR(event,		"config:0-49");
-PMU_FORMAT_ATTR(pmcxsel,	"config:0-7");
-PMU_FORMAT_ATTR(mark,		"config:8");
-PMU_FORMAT_ATTR(combine,	"config:11");
-PMU_FORMAT_ATTR(unit,		"config:12-15");
-PMU_FORMAT_ATTR(pmc,		"config:16-19");
-PMU_FORMAT_ATTR(cache_sel,	"config:20-23");
-PMU_FORMAT_ATTR(sample_mode,	"config:24-28");
-PMU_FORMAT_ATTR(thresh_sel,	"config:29-31");
-PMU_FORMAT_ATTR(thresh_stop,	"config:32-35");
-PMU_FORMAT_ATTR(thresh_start,	"config:36-39");
-PMU_FORMAT_ATTR(thresh_cmp,	"config:40-49");
-
-static struct attribute *power8_pmu_format_attr[] = {
-	&format_attr_event.attr,
-	&format_attr_pmcxsel.attr,
-	&format_attr_mark.attr,
-	&format_attr_combine.attr,
-	&format_attr_unit.attr,
-	&format_attr_pmc.attr,
-	&format_attr_cache_sel.attr,
-	&format_attr_sample_mode.attr,
-	&format_attr_thresh_sel.attr,
-	&format_attr_thresh_stop.attr,
-	&format_attr_thresh_start.attr,
-	&format_attr_thresh_cmp.attr,
-	NULL,
-};
-
-static struct attribute_group power8_pmu_format_group = {
-	.name = "format",
-	.attrs = power8_pmu_format_attr,
-};
-
 static const struct attribute_group *power8_pmu_attr_groups[] = {
-	&power8_pmu_format_group,
+	&isa207_pmu_format_group,
 	&power8_pmu_events_group,
 	NULL,
 };
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 8e9a81967ff8..443511b18bc5 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -31,6 +31,9 @@ enum {
 #define POWER9_MMCRA_IFM2		0x0000000080000000UL
 #define POWER9_MMCRA_IFM3		0x00000000C0000000UL
 
+/* PowerISA v2.07 format attribute structure*/
+extern struct attribute_group isa207_pmu_format_group;
+
 GENERIC_EVENT_ATTR(cpu-cycles,			PM_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_ICT_NOSLOT_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
@@ -90,42 +93,8 @@ static struct attribute_group power9_pmu_events_group = {
 	.attrs = power9_events_attr,
 };
 
-PMU_FORMAT_ATTR(event,		"config:0-49");
-PMU_FORMAT_ATTR(pmcxsel,	"config:0-7");
-PMU_FORMAT_ATTR(mark,		"config:8");
-PMU_FORMAT_ATTR(combine,	"config:11");
-PMU_FORMAT_ATTR(unit,		"config:12-15");
-PMU_FORMAT_ATTR(pmc,		"config:16-19");
-PMU_FORMAT_ATTR(cache_sel,	"config:20-23");
-PMU_FORMAT_ATTR(sample_mode,	"config:24-28");
-PMU_FORMAT_ATTR(thresh_sel,	"config:29-31");
-PMU_FORMAT_ATTR(thresh_stop,	"config:32-35");
-PMU_FORMAT_ATTR(thresh_start,	"config:36-39");
-PMU_FORMAT_ATTR(thresh_cmp,	"config:40-49");
-
-static struct attribute *power9_pmu_format_attr[] = {
-	&format_attr_event.attr,
-	&format_attr_pmcxsel.attr,
-	&format_attr_mark.attr,
-	&format_attr_combine.attr,
-	&format_attr_unit.attr,
-	&format_attr_pmc.attr,
-	&format_attr_cache_sel.attr,
-	&format_attr_sample_mode.attr,
-	&format_attr_thresh_sel.attr,
-	&format_attr_thresh_stop.attr,
-	&format_attr_thresh_start.attr,
-	&format_attr_thresh_cmp.attr,
-	NULL,
-};
-
-static struct attribute_group power9_pmu_format_group = {
-	.name = "format",
-	.attrs = power9_pmu_format_attr,
-};
-
 static const struct attribute_group *power9_pmu_attr_groups[] = {
-	&power9_pmu_format_group,
+	&isa207_pmu_format_group,
 	&power9_pmu_events_group,
 	NULL,
 };
-- 
2.7.4
