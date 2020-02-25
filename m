Return-Path: <SRS0=ugyh=4N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4B4C35E04
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 19:07:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D512082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 19:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D512082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RpMT4gKMzDqHY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 06:07:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=the-dreams.de (client-ip=88.99.104.3; helo=pokefinder.org;
 envelope-from=wsa@the-dreams.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=the-dreams.de
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 48RmwN3H1BzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2020 05:01:56 +1100 (AEDT)
Received: from localhost (p5486CE6D.dip0.t-ipconnect.de [84.134.206.109])
 by pokefinder.org (Postfix) with ESMTPSA id 08CF62C1F2E;
 Tue, 25 Feb 2020 15:26:18 +0100 (CET)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: powermac: correct comment about custom handling
Date: Tue, 25 Feb 2020 15:26:13 +0100
Message-Id: <20200225142613.7169-1-wsa@the-dreams.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: linuxppc-dev@lists.ozlabs.org, Wolfram Sang <wsa@the-dreams.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The comment had some flaws which are now fixed:
- the prefix is 'MAC' not 'AAPL'
- no kernel coding style and too short length
- 'we do' instead of 'we to'

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-powermac.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 973e5339033c..d565714c1f13 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -279,14 +279,13 @@ static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 {
 	char tmp[16];
 
-	/* Note: we to _NOT_ want the standard
-	 * i2c drivers to match with any of our powermac stuff
-	 * unless they have been specifically modified to handle
-	 * it on a case by case basis. For example, for thermal
-	 * control, things like lm75 etc... shall match with their
-	 * corresponding windfarm drivers, _NOT_ the generic ones,
-	 * so we force a prefix of AAPL, onto the modalias to
-	 * make that happen
+	/*
+	 * Note: we do _NOT_ want the standard i2c drivers to match with any of
+	 * our powermac stuff unless they have been specifically modified to
+	 * handle it on a case by case basis. For example, for thermal control,
+	 * things like lm75 etc... shall match with their corresponding
+	 * windfarm drivers, _NOT_ the generic ones, so we force a prefix of
+	 * 'MAC', onto the modalias to make that happen
 	 */
 
 	/* First try proper modalias */
-- 
2.20.1

