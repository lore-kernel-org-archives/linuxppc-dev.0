Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0911C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 16:46:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D432183F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 16:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D432183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YLqz2M38zDqJK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 03:46:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=andrew.murray@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43YLRY72KzzDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 03:28:25 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77E8B1684;
 Mon,  7 Jan 2019 08:28:24 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034A03F5A0;
 Mon,  7 Jan 2019 08:28:19 -0800 (PST)
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
Subject: [PATCH v4 09/13] powerpc: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for
 exclude incapable PMUs
Date: Mon,  7 Jan 2019 16:27:26 +0000
Message-Id: <1546878450-20341-10-git-send-email-andrew.murray@arm.com>
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

For PowerPC PMUs that do not support context exclusion let's
advertise the PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that
perf will prevent us from handling events where any exclusion flags
are set. Let's also remove the now unnecessary check for exclusion
flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/hv-24x7.c | 10 +---------
 arch/powerpc/perf/hv-gpci.c | 10 +---------
 arch/powerpc/perf/imc-pmu.c | 19 +------------------
 3 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 72238ee..d2b8e60 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1306,15 +1306,6 @@ static int h_24x7_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	/* no branch sampling */
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
@@ -1577,6 +1568,7 @@ static struct pmu h_24x7_pmu = {
 	.start_txn   = h_24x7_event_start_txn,
 	.commit_txn  = h_24x7_event_commit_txn,
 	.cancel_txn  = h_24x7_event_cancel_txn,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static int hv_24x7_init(void)
diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 43fabb3..735e77b 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -232,15 +232,6 @@ static int h_gpci_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	/* no branch sampling */
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
@@ -285,6 +276,7 @@ static struct pmu h_gpci_pmu = {
 	.start       = h_gpci_event_start,
 	.stop        = h_gpci_event_stop,
 	.read        = h_gpci_event_update,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static int hv_gpci_init(void)
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index f292a3f..b1c37cc 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -473,15 +473,6 @@ static int nest_imc_event_init(struct perf_event *event)
 	if (event->hw.sample_period)
 		return -EINVAL;
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -748,15 +739,6 @@ static int core_imc_event_init(struct perf_event *event)
 	if (event->hw.sample_period)
 		return -EINVAL;
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -1069,6 +1051,7 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 	pmu->pmu.stop = imc_event_stop;
 	pmu->pmu.read = imc_event_update;
 	pmu->pmu.attr_groups = pmu->attr_groups;
+	pmu->pmu.capabilities = PERF_PMU_CAP_NO_EXCLUDE;
 	pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
 
 	switch (pmu->domain) {
-- 
2.7.4

