Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C849C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:07:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077FF20660
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB5ED/dF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077FF20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Z3Fq47VZzDqYh
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 07:07:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="WB5ED/dF"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Z2WT1BlhzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 06:34:13 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C409D205C9;
 Tue,  8 Jan 2019 19:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546976051;
 bh=UGsAZMkOeiD/tT+lLjJ+E9m2QYDZPRdZ1P3jM8rypUw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WB5ED/dFNyxhvnX4Uz0WiaXMjlJ6qQGSdN/MQ/IKd2GnxRBgH/+RL4lo8M9Ur+8pJ
 JfASLjr7RiadZhz9kfVcTXgX3JlCA+T4bvPMNLiwLXxFZUv+5O2M0b27+VcPdYNK6x
 t3srdYWcg7Tkzv/rmdtGxb/ED9ccq74RGlyZvShM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 14/36] powerpc/xmon: Fix invocation inside lock
 region
Date: Tue,  8 Jan 2019 14:33:26 -0500
Message-Id: <20190108193348.123880-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193348.123880-1-sashal@kernel.org>
References: <20190108193348.123880-1-sashal@kernel.org>
MIME-Version: 1.0
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
Cc: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org,
 Sasha Levin <sashal@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 8d4a862276a9c30a269d368d324fb56529e6d5fd ]

Currently xmon needs to get devtree_lock (through rtas_token()) during its
invocation (at crash time). If there is a crash while devtree_lock is being
held, then xmon tries to get the lock but spins forever and never get into
the interactive debugger, as in the following case:

	int *ptr = NULL;
	raw_spin_lock_irqsave(&devtree_lock, flags);
	*ptr = 0xdeadbeef;

This patch avoids calling rtas_token(), thus trying to get the same lock,
at crash time. This new mechanism proposes getting the token at
initialization time (xmon_init()) and just consuming it at crash time.

This would allow xmon to be possible invoked independent of devtree_lock
being held or not.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/xmon/xmon.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 760545519a0b..687e8b8bf5c6 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -73,6 +73,9 @@ static int xmon_gate;
 #define xmon_owner 0
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_PPC_PSERIES
+static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
+#endif
 static unsigned long in_xmon __read_mostly = 0;
 
 static unsigned long adrs;
@@ -340,7 +343,6 @@ static inline void disable_surveillance(void)
 #ifdef CONFIG_PPC_PSERIES
 	/* Since this can't be a module, args should end up below 4GB. */
 	static struct rtas_args args;
-	int token;
 
 	/*
 	 * At this point we have got all the cpus we can into
@@ -349,11 +351,11 @@ static inline void disable_surveillance(void)
 	 * If we did try to take rtas.lock there would be a
 	 * real possibility of deadlock.
 	 */
-	token = rtas_token("set-indicator");
-	if (token == RTAS_UNKNOWN_SERVICE)
+	if (set_indicator_token == RTAS_UNKNOWN_SERVICE)
 		return;
 
-	rtas_call_unlocked(&args, token, 3, 1, NULL, SURVEILLANCE_TOKEN, 0, 0);
+	rtas_call_unlocked(&args, set_indicator_token, 3, 1, NULL,
+			   SURVEILLANCE_TOKEN, 0, 0);
 
 #endif /* CONFIG_PPC_PSERIES */
 }
@@ -3227,6 +3229,14 @@ static void xmon_init(int enable)
 		__debugger_iabr_match = xmon_iabr_match;
 		__debugger_break_match = xmon_break_match;
 		__debugger_fault_handler = xmon_fault_handler;
+
+#ifdef CONFIG_PPC_PSERIES
+		/*
+		 * Get the token here to avoid trying to get a lock
+		 * during the crash, causing a deadlock.
+		 */
+		set_indicator_token = rtas_token("set-indicator");
+#endif
 	} else {
 		__debugger = NULL;
 		__debugger_ipi = NULL;
-- 
2.19.1

