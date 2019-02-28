Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B7CC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 15:17:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDB520C01
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 15:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR3dqa0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDB520C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449GQ51MmCzDqPP
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 02:17:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="NR3dqa0e"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449GKQ2HVgzDq74
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 02:13:46 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E9584218D9;
 Thu, 28 Feb 2019 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551366823;
 bh=rRf1IRLMCQHalE+dOAAtlPgCX1dyqfL3hN5cLsFXFWw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NR3dqa0eMxtA8eCUyoPgCJ004bu5k4nmyAS8zKMfIDCmrzc/wtV4Py0G8+hxP3/IQ
 X0yrVhOhQ5tk2yczDN94DF9NdGYwn81d/+qRggy+8KWw8Hh1EnCesYkaI5vBzzjr9P
 lUoi0/OXRKJVbhyLp3eLk9ekITlBNbrj1jzhzN/w=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/36] soc: fsl: qbman: avoid race in clearing
 QMan interrupt
Date: Thu, 28 Feb 2019 10:13:04 -0500
Message-Id: <20190228151337.12176-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Madalin Bucur <madalin.bucur@nxp.com>

[ Upstream commit 89857a8a5c89a406b967ab2be7bd2ccdbe75e73d ]

By clearing all interrupt sources, not only those that
already occurred, the existing code may acknowledge by
mistake interrupts that occurred after the code checks
for them.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qbman/qman.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 4f27e95efcdd3..90892a360c61c 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1048,18 +1048,19 @@ static void qm_mr_process_task(struct work_struct *work);
 static irqreturn_t portal_isr(int irq, void *ptr)
 {
 	struct qman_portal *p = ptr;
-
-	u32 clear = QM_DQAVAIL_MASK | p->irq_sources;
 	u32 is = qm_in(&p->p, QM_REG_ISR) & p->irq_sources;
+	u32 clear = 0;
 
 	if (unlikely(!is))
 		return IRQ_NONE;
 
 	/* DQRR-handling if it's interrupt-driven */
-	if (is & QM_PIRQ_DQRI)
+	if (is & QM_PIRQ_DQRI) {
 		__poll_portal_fast(p, QMAN_POLL_LIMIT);
+		clear = QM_DQAVAIL_MASK | QM_PIRQ_DQRI;
+	}
 	/* Handling of anything else that's interrupt-driven */
-	clear |= __poll_portal_slow(p, is);
+	clear |= __poll_portal_slow(p, is) & QM_PIRQ_SLOW;
 	qm_out(&p->p, QM_REG_ISR, clear);
 	return IRQ_HANDLED;
 }
-- 
2.19.1

