Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA4CC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 14:11:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5C220660
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 14:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5C220660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b7Fd4N2JzDqcD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 01:11:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=andrew.murray@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43b6tT0wknzDqVS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 00:54:24 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CA021682;
 Thu, 10 Jan 2019 05:54:23 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A1953F5AF;
 Thu, 10 Jan 2019 05:54:18 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Russell King <linux@armlinux.org.uk>,
 suzuki.poulose@arm.com, robin.murphy@arm.com,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v5 08/12] drivers/perf: perf/core: strengthen exclude checks
 with PERF_PMU_CAP_NO_EXCLUDE
Date: Thu, 10 Jan 2019 13:53:30 +0000
Message-Id: <1547128414-50693-9-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547128414-50693-1-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-1-git-send-email-andrew.murray@arm.com>
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
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

For drivers that do not support context exclusion let's advertise the
PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will
prevent us from handling events where any exclusion flags are set.
Let's also remove the now unnecessary check for exclusion flags.

This change means that qcom_{l2|l3}_pmu will now also indicate that
they do not support exclude_{host|guest} and that xgene_pmu does
not also support exclude_idle and exclude_hv.

Note that for qcom_l2_pmu we now implictly return -EINVAL instead
of -EOPNOTSUPP. This change will result in the perf userspace
utility retrying the perf_event_open system call with fallback
event attributes that do not fail.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/qcom_l2_pmu.c | 9 +--------
 drivers/perf/qcom_l3_pmu.c | 8 +-------
 drivers/perf/xgene_pmu.c   | 6 +-----
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 842135c..091b4d7 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -509,14 +509,6 @@ static int l2_cache_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
-	/* We cannot filter accurately so we just don't allow it. */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_hv || event->attr.exclude_idle) {
-		dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
-				    "Can't exclude execution levels\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (((L2_EVT_GROUP(event->attr.config) > L2_EVT_GROUP_MAX) ||
 	     ((event->attr.config & ~L2_EVT_MASK) != 0)) &&
 	    (event->attr.config != L2CYCLE_CTR_RAW_CODE)) {
@@ -982,6 +974,7 @@ static int l2_cache_pmu_probe(struct platform_device *pdev)
 		.stop		= l2_cache_event_stop,
 		.read		= l2_cache_event_read,
 		.attr_groups	= l2_cache_pmu_attr_grps,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	l2cache_pmu->num_counters = get_num_counters();
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 2dc63d6..5d70646 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -495,13 +495,6 @@ static int qcom_l3_cache__event_init(struct perf_event *event)
 		return -ENOENT;
 
 	/*
-	 * There are no per-counter mode filters in the PMU.
-	 */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_hv || event->attr.exclude_idle)
-		return -EINVAL;
-
-	/*
 	 * Sampling not supported since these events are not core-attributable.
 	 */
 	if (hwc->sample_period)
@@ -777,6 +770,7 @@ static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
 		.read		= qcom_l3_cache__event_read,
 
 		.attr_groups	= qcom_l3_cache_pmu_attr_grps,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	memrc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 0dc9ff0..d4ec048 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -917,11 +917,6 @@ static int xgene_perf_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* SOC counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 	/*
@@ -1136,6 +1131,7 @@ static int xgene_init_perf(struct xgene_pmu_dev *pmu_dev, char *name)
 		.start		= xgene_perf_start,
 		.stop		= xgene_perf_stop,
 		.read		= xgene_perf_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	/* Hardware counter init */
-- 
2.7.4

