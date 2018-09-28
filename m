Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8910DC43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 08:53:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFAF2152A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 08:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFAF2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42M57T5jXlzF3CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 18:53:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=madalin.bucur@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42M4w06FypzF3BW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 18:43:44 +1000 (AEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A2341A0070;
 Fri, 28 Sep 2018 10:43:41 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6DC691A006D;
 Fri, 28 Sep 2018 10:43:41 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net
 (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 09A852039E;
 Fri, 28 Sep 2018 10:43:41 +0200 (CEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: leoyang.li@nxp.com
Subject: [PATCH v2 4/5] soc/fsl/qbman: Use last response to determine valid bit
Date: Fri, 28 Sep 2018 11:43:23 +0300
Message-Id: <1538124204-31406-5-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
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
Reply-To: madalin.bucur@nxp.com
Cc: Madalin Bucur <madalin.bucur@nxp.com>, catalin.marinas@arm.com,
 roy.pledge@nxp.com, linux-kernel@vger.kernel.org, oss@buserror.net,
 claudiu.manoil@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Roy Pledge <roy.pledge@nxp.com>

Use the last valid response when determining what valid bit
to use next for management commands. This is needed in the
case that the portal was previously used by other software
like a bootloader or if the kernel is restarted without a
hardware reset.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 0ffe7a1d0eae..99d0f87889b8 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -850,12 +850,24 @@ static inline void qm_mr_set_ithresh(struct qm_portal *portal, u8 ithresh)
 
 static inline int qm_mc_init(struct qm_portal *portal)
 {
+	u8 rr0, rr1;
 	struct qm_mc *mc = &portal->mc;
 
 	mc->cr = portal->addr.ce + QM_CL_CR;
 	mc->rr = portal->addr.ce + QM_CL_RR0;
-	mc->rridx = (mc->cr->_ncw_verb & QM_MCC_VERB_VBIT)
-		    ? 0 : 1;
+	/*
+	 * The expected valid bit polarity for the next CR command is 0
+	 * if RR1 contains a valid response, and is 1 if RR0 contains a
+	 * valid response. If both RR contain all 0, this indicates either
+	 * that no command has been executed since reset (in which case the
+	 * expected valid bit polarity is 1)
+	 */
+	rr0 = mc->rr->verb;
+	rr1 = (mc->rr+1)->verb;
+	if ((rr0 == 0 && rr1 == 0) || rr0 != 0)
+		mc->rridx = 1;
+	else
+		mc->rridx = 0;
 	mc->vbit = mc->rridx ? QM_MCC_VERB_VBIT : 0;
 #ifdef CONFIG_FSL_DPAA_CHECKING
 	mc->state = qman_mc_idle;
-- 
2.1.0

