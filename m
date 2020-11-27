Return-Path: <SRS0=TXb4=FB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A49DC3E8C5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2020 21:31:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E570E21534
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2020 21:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E570E21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjSVY3GNxzDsTS
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 08:31:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=pengutronix.de (client-ip=2001:67c:670:201:290:27ff:fe1d:cc33;
 helo=metis.ext.pengutronix.de; envelope-from=lgo@pengutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
X-Greylist: delayed 1178 seconds by postgrey-1.36 at bilbo;
 Sat, 28 Nov 2020 02:44:03 AEDT
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjJnv2TGWzDrfM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2020 02:44:03 +1100 (AEDT)
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <lgo@pengutronix.de>)
 id 1kifb3-0002Iv-2c; Fri, 27 Nov 2020 16:23:41 +0100
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.92)
 (envelope-from <lgo@dude03.red.stw.pengutronix.de>)
 id 1kifax-006ATZ-FC; Fri, 27 Nov 2020 16:23:35 +0100
From: Leonard Goehrs <l.goehrs@pengutronix.de>
To: u.kleine-koenig@pengutronix.de, geoff@infradead.org, perex@perex.cz,
 tiwai@suse.com, mpe@ellerman.id.au
Date: Fri, 27 Nov 2020 16:22:59 +0100
Message-Id: <20201127152259.1470079-1-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201127094547.4zcyeycfrriitkqx@pengutronix.de>
References: <20201127094547.4zcyeycfrriitkqx@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: lgo@pengutronix.de
Subject: [PATCH] ALSA: ppc: remove redundant checks in PS3 driver probe
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: linuxppc-dev@lists.ozlabs.org
X-Mailman-Approved-At: Sat, 28 Nov 2020 08:29:37 +1100
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
Cc: alsa-devel@alsa-project.org, paulus@samba.org, kernel@pengutronix.de,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Leonard Goehrs <l.goehrs@pengutronix.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The check for the FW_FEATURE_PS3_LV1 firmware feature is already performed
in ps3_system_bus_init() before registering the driver. So if the probe
function is actually used, this feature is already known to be available.

The check for the match id is also superfluous; the condition is always
true because the bus' match function (ps3_system_bus_match()) only
considers this driver for devices having:
dev->match_id == snd_ps3_bus_driver_info.match_id.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Leonard Goehrs <l.goehrs@pengutronix.de>
---
 sound/ppc/snd_ps3.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 58bb49fff184..b6e4aa3df870 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -896,11 +896,6 @@ static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 	u64 lpar_addr, lpar_size;
 	static u64 dummy_mask;
 
-	if (WARN_ON(!firmware_has_feature(FW_FEATURE_PS3_LV1)))
-		return -ENODEV;
-	if (WARN_ON(dev->match_id != PS3_MATCH_ID_SOUND))
-		return -ENODEV;
-
 	the_card.ps3_dev = dev;
 
 	ret = ps3_open_hv_device(dev);
-- 
2.20.1

