Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B478C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 16:52:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B4C2087F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 16:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B4C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YLzM5gmZzDqNX
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 03:52:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=andrew.murray@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43YLRw5lSdzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 03:28:44 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1380174E;
 Mon,  7 Jan 2019 08:28:43 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BD733F5A0;
 Mon,  7 Jan 2019 08:28:39 -0800 (PST)
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
Subject: [PATCH v4 13/13] drivers/perf: use PERF_PMU_CAP_NO_EXCLUDE for Cavium
 TX2 PMU
Date: Mon,  7 Jan 2019 16:27:30 +0000
Message-Id: <1546878450-20341-14-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
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

The Cavium ThunderX2 UNCORE PMU driver doesn't support any event
filtering. Let's advertise the PERF_PMU_CAP_NO_EXCLUDE capability to
simplify the code.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 drivers/perf/thunderx2_pmu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index c9a1701..43d76c8 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -424,15 +424,6 @@ static int tx2_uncore_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* We have no filtering of any kind */
-	if (event->attr.exclude_user	||
-	    event->attr.exclude_kernel	||
-	    event->attr.exclude_hv	||
-	    event->attr.exclude_idle	||
-	    event->attr.exclude_host	||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -572,6 +563,7 @@ static int tx2_uncore_pmu_register(
 		.start		= tx2_uncore_event_start,
 		.stop		= tx2_uncore_event_stop,
 		.read		= tx2_uncore_event_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
 	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
-- 
2.7.4

