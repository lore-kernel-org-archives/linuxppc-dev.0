Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66033C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 10:48:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80B02086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 10:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80B02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xFLr15G2zF3Hy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 21:48:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=andrew.murray@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42xDr66t9hzF3gV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 21:24:54 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3355EBD;
 Fri, 16 Nov 2018 02:24:53 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCCD93F5BD;
 Fri, 16 Nov 2018 02:24:50 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org
Subject: [PATCH 09/10] drivers/perf: perf/core: generalise event exclusion
 checking with perf macro
Date: Fri, 16 Nov 2018 10:24:12 +0000
Message-Id: <1542363853-13849-10-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Replace checking of perf event exclusion flags with perf macro.

This is a functional change as exclude_host and exclude_guest are added
in the following files:

 - drivers/perf/qcom_l2_pmu.c
 - drivers/perf/qcom_l3_pmu.c
 - drivers/perf/arm_pmu.c

And exclude_idle and exclude_hv are added in these files:

 - drivers/perf/xgene_pmu.c

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 drivers/perf/arm-cci.c                   | 7 +------
 drivers/perf/arm-ccn.c                   | 5 +----
 drivers/perf/arm_dsu_pmu.c               | 7 +------
 drivers/perf/arm_pmu.c                   | 9 +--------
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 7 +------
 drivers/perf/qcom_l2_pmu.c               | 3 +--
 drivers/perf/qcom_l3_pmu.c               | 3 +--
 drivers/perf/xgene_pmu.c                 | 3 +--
 8 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 1bfeb16..d749f19 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1328,12 +1328,7 @@ static int cci_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 
 	/* We have no filtering of any kind */
-	if (event->attr.exclude_user	||
-	    event->attr.exclude_kernel	||
-	    event->attr.exclude_hv	||
-	    event->attr.exclude_idle	||
-	    event->attr.exclude_host	||
-	    event->attr.exclude_guest)
+	if (event_has_exclude_flags(event))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 7dd850e..9a22a95 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -741,10 +741,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
-	if (has_branch_stack(event) || event->attr.exclude_user ||
-			event->attr.exclude_kernel || event->attr.exclude_hv ||
-			event->attr.exclude_idle || event->attr.exclude_host ||
-			event->attr.exclude_guest) {
+	if (has_branch_stack(event) || event_has_exclude_flags(event)) {
 		dev_dbg(ccn->dev, "Can't exclude execution levels!\n");
 		return -EINVAL;
 	}
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 660cb8a..300ff3d 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -563,12 +563,7 @@ static int dsu_pmu_event_init(struct perf_event *event)
 	}
 
 	if (has_branch_stack(event) ||
-	    event->attr.exclude_user ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv ||
-	    event->attr.exclude_idle ||
-	    event->attr.exclude_host ||
-	    event->attr.exclude_guest) {
+	    event_has_exclude_flags(event)) {
 		dev_dbg(dsu_pmu->pmu.dev, "Can't support filtering\n");
 		return -EINVAL;
 	}
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 7f01f6f..a03634f 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -357,13 +357,6 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 }
 
 static int
-event_requires_mode_exclusion(struct perf_event_attr *attr)
-{
-	return attr->exclude_idle || attr->exclude_user ||
-	       attr->exclude_kernel || attr->exclude_hv;
-}
-
-static int
 __hw_perf_event_init(struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
@@ -395,7 +388,7 @@ __hw_perf_event_init(struct perf_event *event)
 	 */
 	if ((!armpmu->set_event_filter ||
 	     armpmu->set_event_filter(hwc, &event->attr)) &&
-	     event_requires_mode_exclusion(&event->attr)) {
+	     event_has_exclude_flags(event)) {
 		pr_debug("ARM performance counters do not support "
 			 "mode exclusion\n");
 		return -EOPNOTSUPP;
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 9efd241..d3edff9 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -143,12 +143,7 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 
 	/* counters do not have these bits */
-	if (event->attr.exclude_user	||
-	    event->attr.exclude_kernel	||
-	    event->attr.exclude_host	||
-	    event->attr.exclude_guest	||
-	    event->attr.exclude_hv	||
-	    event->attr.exclude_idle)
+	if (event_has_exclude_flags(event))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 842135c..d7d85a2 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -510,8 +510,7 @@ static int l2_cache_event_init(struct perf_event *event)
 	}
 
 	/* We cannot filter accurately so we just don't allow it. */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_hv || event->attr.exclude_idle) {
+	if (event_has_exclude_flags(event)) {
 		dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
 				    "Can't exclude execution levels\n");
 		return -EOPNOTSUPP;
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 2dc63d6..f27af67 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -497,8 +497,7 @@ static int qcom_l3_cache__event_init(struct perf_event *event)
 	/*
 	 * There are no per-counter mode filters in the PMU.
 	 */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_hv || event->attr.exclude_idle)
+	if (event_has_exclude_flags(event))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 0e31f13..1fcd5a0 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -915,8 +915,7 @@ static int xgene_perf_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* SOC counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
+	if (event_has_exclude_flags(event))
 		return -EINVAL;
 
 	if (event->cpu < 0)
-- 
2.7.4

