Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F27DC433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Sep 2021 00:17:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26B4611C5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Sep 2021 00:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C26B4611C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H5Gfp0NlTz2yS1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Sep 2021 10:17:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Kf5ZmtzK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Kf5ZmtzK; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H5GdT47T4z2xrT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Sep 2021 10:16:45 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2790611CC;
 Fri, 10 Sep 2021 00:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631233002;
 bh=bFudKSCOtqCJSbzerv9YL80dTH1IVwrlA8bgY8TI2qs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kf5ZmtzKnNNAfOkrH40cAPuU28NoJKEbK5H2O+Hqd0Rt5y0QHH7ZAxhuMy9p/47w1
 To7lSby4asKtpSGOOQiaaqVnXq12B0eCnlghEAXrjaicD9RaG0p8fH0QGwUz4LbAw7
 JjY4umt+v/5SpRi81NPZqXWUX8ypOnJ4JPPPzOMFR2r0SU7lvTB+1Pm34Nzp84/zKQ
 I+2srZcodOCA4NWaqjdX50Ees2c5bkUW6kBAqsreJjamC5AlGArLafk09mFMkCdalr
 l8HskieXtEBhNk4NIaC4yeqzbXKP7t64UCxogzw8jzRyT2VDsGZgq81iky3ETrMarg
 hkV8HHvdt8PVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 31/99] cpuidle: pseries: Do not cap the CEDE0
 latency in fixup_cede0_latency()
Date: Thu,  9 Sep 2021 20:14:50 -0400
Message-Id: <20210910001558.173296-31-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910001558.173296-1-sashal@kernel.org>
References: <20210910001558.173296-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
Cc: Sasha Levin <sashal@kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

[ Upstream commit 71737a6c2a8f801622d2b71567d1ec1e4c5b40b8 ]

Currently in fixup_cede0_latency() code, we perform the fixup the
CEDE(0) exit latency value only if minimum advertized extended CEDE
latency values are less than 10us. This was done so as to not break
the expected behaviour on POWER8 platforms where the advertised
latency was higher than the default 10us, which would delay the SMT
folding on the core.

However, after the earlier patch "cpuidle/pseries: Fixup CEDE0 latency
only for POWER10 onwards", we can be sure that the fixup of CEDE0
latency is going to happen only from POWER10 onwards. Hence
unconditionally use the minimum exit latency provided by the platform.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1626676399-15975-3-git-send-email-ego@linux.vnet.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/cpuidle-pseries.c | 59 ++++++++++++++++---------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index a2b5c6f60cf0..18747e5287c8 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -346,11 +346,9 @@ static int pseries_cpuidle_driver_init(void)
 static void __init fixup_cede0_latency(void)
 {
 	struct xcede_latency_payload *payload;
-	u64 min_latency_us;
+	u64 min_xcede_latency_us = UINT_MAX;
 	int i;
 
-	min_latency_us = dedicated_states[1].exit_latency; // CEDE latency
-
 	if (parse_cede_parameters())
 		return;
 
@@ -358,42 +356,45 @@ static void __init fixup_cede0_latency(void)
 		nr_xcede_records);
 
 	payload = &xcede_latency_parameter.payload;
+
+	/*
+	 * The CEDE idle state maps to CEDE(0). While the hypervisor
+	 * does not advertise CEDE(0) exit latency values, it does
+	 * advertise the latency values of the extended CEDE states.
+	 * We use the lowest advertised exit latency value as a proxy
+	 * for the exit latency of CEDE(0).
+	 */
 	for (i = 0; i < nr_xcede_records; i++) {
 		struct xcede_latency_record *record = &payload->records[i];
+		u8 hint = record->hint;
 		u64 latency_tb = be64_to_cpu(record->latency_ticks);
 		u64 latency_us = DIV_ROUND_UP_ULL(tb_to_ns(latency_tb), NSEC_PER_USEC);
 
-		if (latency_us == 0)
-			pr_warn("cpuidle: xcede record %d has an unrealistic latency of 0us.\n", i);
-
-		if (latency_us < min_latency_us)
-			min_latency_us = latency_us;
-	}
-
-	/*
-	 * By default, we assume that CEDE(0) has exit latency 10us,
-	 * since there is no way for us to query from the platform.
-	 *
-	 * However, if the wakeup latency of an Extended CEDE state is
-	 * smaller than 10us, then we can be sure that CEDE(0)
-	 * requires no more than that.
-	 *
-	 * Perform the fix-up.
-	 */
-	if (min_latency_us < dedicated_states[1].exit_latency) {
 		/*
-		 * We set a minimum of 1us wakeup latency for cede0 to
-		 * distinguish it from snooze
+		 * We expect the exit latency of an extended CEDE
+		 * state to be non-zero, it to since it takes at least
+		 * a few nanoseconds to wakeup the idle CPU and
+		 * dispatch the virtual processor into the Linux
+		 * Guest.
+		 *
+		 * So we consider only non-zero value for performing
+		 * the fixup of CEDE(0) latency.
 		 */
-		u64 cede0_latency = 1;
+		if (latency_us == 0) {
+			pr_warn("cpuidle: Skipping xcede record %d [hint=%d]. Exit latency = 0us\n",
+				i, hint);
+			continue;
+		}
 
-		if (min_latency_us > cede0_latency)
-			cede0_latency = min_latency_us - 1;
+		if (latency_us < min_xcede_latency_us)
+			min_xcede_latency_us = latency_us;
+	}
 
-		dedicated_states[1].exit_latency = cede0_latency;
-		dedicated_states[1].target_residency = 10 * (cede0_latency);
+	if (min_xcede_latency_us != UINT_MAX) {
+		dedicated_states[1].exit_latency = min_xcede_latency_us;
+		dedicated_states[1].target_residency = 10 * (min_xcede_latency_us);
 		pr_info("cpuidle: Fixed up CEDE exit latency to %llu us\n",
-			cede0_latency);
+			min_xcede_latency_us);
 	}
 
 }
-- 
2.30.2

