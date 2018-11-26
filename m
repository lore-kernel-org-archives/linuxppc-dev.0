Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196A1C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 11:45:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9286C20663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 11:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9286C20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433Q7s4pZmzDqDc
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 22:44:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=andrew.murray@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 433PSM06g4zDqQY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 22:14:10 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0AD2356D;
 Mon, 26 Nov 2018 03:14:09 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 147B33F5AF;
 Mon, 26 Nov 2018 03:14:04 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 09/20] drivers/perf: perf/core: remove unnecessary checks
 for exclusion
Date: Mon, 26 Nov 2018 11:12:25 +0000
Message-Id: <1543230756-15319-10-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
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
Cc: linux-s390@vger.kernel.org, linux-mips@linux-mips.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

For drivers that do not support context exclusion we do not
advertise the PERF_PMU_CAP_EXCLUDE capability. This ensures
that perf will prevent us from handling events where any exclusion
flags are set. Let's remove the now unnecessary check for
exclusion flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 drivers/perf/arm-cci.c                   | 9 ---------
 drivers/perf/arm-ccn.c                   | 5 +----
 drivers/perf/arm_dsu_pmu.c               | 8 +-------
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 9 ---------
 4 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 1bfeb16..501b497 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1327,15 +1327,6 @@ static int cci_pmu_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
-	/* We have no filtering of any kind */
-	if (event->attr.exclude_user	||
-	    event->attr.exclude_kernel	||
-	    event->attr.exclude_hv	||
-	    event->attr.exclude_idle	||
-	    event->attr.exclude_host	||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	/*
 	 * Following the example set by other "uncore" PMUs, we accept any CPU
 	 * and rewrite its affinity dynamically rather than having perf core
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 7dd850e..decf881 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -741,10 +741,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
-	if (has_branch_stack(event) || event->attr.exclude_user ||
-			event->attr.exclude_kernel || event->attr.exclude_hv ||
-			event->attr.exclude_idle || event->attr.exclude_host ||
-			event->attr.exclude_guest) {
+	if (has_branch_stack(event)) {
 		dev_dbg(ccn->dev, "Can't exclude execution levels!\n");
 		return -EINVAL;
 	}
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 660cb8a..036414c 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -562,13 +562,7 @@ static int dsu_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	if (has_branch_stack(event) ||
-	    event->attr.exclude_user ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv ||
-	    event->attr.exclude_idle ||
-	    event->attr.exclude_host ||
-	    event->attr.exclude_guest) {
+	if (has_branch_stack(event)) {
 		dev_dbg(dsu_pmu->pmu.dev, "Can't support filtering\n");
 		return -EINVAL;
 	}
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 9efd241..f028cbc 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -142,15 +142,6 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
-	/* counters do not have these bits */
-	if (event->attr.exclude_user	||
-	    event->attr.exclude_kernel	||
-	    event->attr.exclude_host	||
-	    event->attr.exclude_guest	||
-	    event->attr.exclude_hv	||
-	    event->attr.exclude_idle)
-		return -EINVAL;
-
 	/*
 	 *  The uncore counters not specific to any CPU, so cannot
 	 *  support per-task
-- 
2.7.4

