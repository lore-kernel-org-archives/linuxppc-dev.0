Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8166BC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 12:11:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2AF420672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 12:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AF420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433QkV6M1ZzDqJw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 23:11:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=andrew.murray@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 433PTD3h3GzDqQM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 22:14:55 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16D3F391A;
 Mon, 26 Nov 2018 03:14:55 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F7C33F5AF;
 Mon, 26 Nov 2018 03:14:50 -0800 (PST)
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
Subject: [PATCH v2 18/20] x86: perf/core remove unnecessary checks for
 exclusion
Date: Mon, 26 Nov 2018 11:12:34 +0000
Message-Id: <1543230756-15319-19-git-send-email-andrew.murray@arm.com>
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

For x86 PMUs that do not support context exclusion we do not
advertise the PERF_PMU_CAP_EXCLUDE capability. This ensures
that perf will prevent us from handling events where any
exclusion flags are set. Let's remove the now unnecessary
check for exclusion flags.

This change means that amd/iommu and amd/uncore will now
also indicate that they do not support exclude_{hv|idle} and
intel/uncore that it does not support exclude_{guest|host}.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/x86/events/amd/iommu.c    | 5 -----
 arch/x86/events/amd/uncore.c   | 5 -----
 arch/x86/events/intel/uncore.c | 8 --------
 3 files changed, 18 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 3210fee..eb35fe4 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -223,11 +223,6 @@ static int perf_iommu_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* IOMMU counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 8671de1..d6ade30 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -201,11 +201,6 @@ static int amd_uncore_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* NB and Last level cache counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
-		return -EINVAL;
-
 	/* and we do not enable counter overflow interrupts */
 	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;
 	hwc->idx = -1;
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 27a4614..f1d78d9 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -695,14 +695,6 @@ static int uncore_pmu_event_init(struct perf_event *event)
 	if (pmu->func_id < 0)
 		return -ENOENT;
 
-	/*
-	 * Uncore PMU does measure at all privilege level all the time.
-	 * So it doesn't make sense to specify any exclude bits.
-	 */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-			event->attr.exclude_hv || event->attr.exclude_idle)
-		return -EINVAL;
-
 	/* Sampling not supported yet */
 	if (hwc->sample_period)
 		return -EINVAL;
-- 
2.7.4

