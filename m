Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA96EC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:08:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF635206B2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="vpSJMJrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF635206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PHxt627NzF3Cw
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 09:08:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="vpSJMJrv";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PHny28whzF3Cw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 09:01:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="vpSJMJrv"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1010)
 id 42PHny0s9fz9sBq; Tue,  2 Oct 2018 09:01:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538434870; bh=K5AgXpLFDn9agxRmO/xfpRR427CZS+riAhLFAhKE77s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vpSJMJrv0vm5sSpSDv/JjhiKxrxhhCYGof3kVVY9Cx/qZRG8qBeyc5jYJ5xmC+Nra
 n/09gxBmPW9ac+XeYbhn6kvqkcv+zjcVd0orrsIeKgHCrhbUOJuV1d2W1TVxa+rlVv
 ei5JAWVAjH1o5vPGVZle8FbTmXyB2BR49WrbpqqxFVB/+3VZld7jRju3QQmfYzqOTn
 /QfckkOjuF+mPSC8r4G8mDEsyMbPj6tTQ90703txivSKmRcLEGAEwiqDSLj9hhT/5D
 uzDvH0WTcRIzenm2Rysx4eBgl7BztZlnGuHx1ufre7Cja6PM38wJyejdzqWeEEq/zq
 keoiJeNjZX9wg==
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, mikey@neuling.org, oohall@gmail.com
Subject: [PATCH 2/2] powerpc/time: Add set_state_oneshot_stopped decrementer
 callback
Date: Tue,  2 Oct 2018 09:01:05 +1000
Message-Id: <20181001230105.26040-2-anton@ozlabs.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001230105.26040-1-anton@ozlabs.org>
References: <20181001230105.26040-1-anton@ozlabs.org>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If CONFIG_PPC_WATCHDOG is enabled we always cap the decrementer to
0x7fffffff:

       if (IS_ENABLED(CONFIG_PPC_WATCHDOG))
                set_dec(0x7fffffff);
        else
                set_dec(decrementer_max);

If there are no future events, we don't reprogram the decrementer
after this and we end up with 0x7fffffff even on a large decrementer
capable system.

As suggested by Nick, add a set_state_oneshot_stopped callback
so we program the decrementer with decrementer_max if there are
no future events.

Signed-off-by: Anton Blanchard <anton@ozlabs.org>
---
 arch/powerpc/kernel/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 6a1f0a084ca3..40868f3ee113 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -111,6 +111,7 @@ struct clock_event_device decrementer_clockevent = {
 	.rating			= 200,
 	.irq			= 0,
 	.set_next_event		= decrementer_set_next_event,
+	.set_state_oneshot_stopped = decrementer_shutdown,
 	.set_state_shutdown	= decrementer_shutdown,
 	.tick_resume		= decrementer_shutdown,
 	.features		= CLOCK_EVT_FEAT_ONESHOT |
-- 
2.17.1

