Return-Path: <SRS0=q/i5=ZA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D136C17440
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Nov 2019 22:42:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EED4214DA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Nov 2019 22:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EED4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 478wJw1LmszF3G9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Nov 2019 09:42:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=leoyang.li@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 478wGt488pzF6p5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Nov 2019 09:41:05 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 436B91A03DF;
 Fri,  8 Nov 2019 23:41:01 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com
 [134.27.49.11])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A32A1A03CA;
 Fri,  8 Nov 2019 23:41:01 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
 by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id
 2D4F140CB6; Fri,  8 Nov 2019 15:41:00 -0700 (MST)
From: Li Yang <leoyang.li@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] rtc: fsl-ftm-alarm: remove select FSL_RCPM and default y from
 Kconfig
Date: Fri,  8 Nov 2019 16:40:56 -0600
Message-Id: <1573252856-11759-1-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
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
Cc: Biwen Li <biwen.li@nxp.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 Li Yang <leoyang.li@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The Flextimer alarm is primarily used as a wakeup source for system
power management.  But it shouldn't select the power management driver
as they don't really have dependency of each other.

Also remove the default y as it is not a critical feature for the
systems.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/rtc/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 1adf9f815652..b33b80243143 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1337,8 +1337,6 @@ config RTC_DRV_IMXDI
 config RTC_DRV_FSL_FTM_ALARM
 	tristate "Freescale FlexTimer alarm timer"
 	depends on ARCH_LAYERSCAPE || SOC_LS1021A
-	select FSL_RCPM
-	default y
 	help
 	   For the FlexTimer in LS1012A, LS1021A, LS1028A, LS1043A, LS1046A,
 	   LS1088A, LS208xA, we can use FTM as the wakeup source.
-- 
2.17.1

