Return-Path: <linuxppc-dev+bounces-22568-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914CFCD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:50:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMqv1x5gz3bsR;
	Sat, 13 Jun 2026 00:50:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781270863;
	cv=none; b=ZttS4r0xwxFg44p+mWuBRPrmN9u8GkhROwMMp8e8zIroGWKdx+kReAWWmix3oahql9GjXbWiQIBH+p4zpX82THfJ4EoxLpuzrVZHD6CZKljTQH56shPLBPvRuo1k5Dg3iFGifbvvBplVMgaQjVgJtV8kaze/WzFifbQZ/BsT223ViYNDSVKjC6LDUOcEF5evZ8O5rzPj7SmptLJ7SqsQf9gwWFxVabqClGlLE36rOPU2fsRpIu5lGgtjDjFp685USMa4oUJQruFtzSES53GnvKUaGq313rf3vrhTl3vfqrR4qZSuo2nhi9EJKFgGbEg1Pps40BIATQz8uojx0UGNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781270863; c=relaxed/relaxed;
	bh=t/AXZy6D5BbhT5x9hx+suwKOnmd8LSBhmzi01ciTQP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RC8okAlqEzbGxSyJz7foSbKCbWlmuvVpULfxDKqOH47k3l1qENv712sqlpFnP3kTZkWskMNfPmT87OzrbvCOQKsaBCbYWlLrLgCLTGu0aMhCnxIuOZlLaoS/pjncGnaxn9qc1Yn9ZMma8jbqK1c5n476ngglmL0oiVMx/p3eLFfN6nXCBnEsC2r8ulqYVib1H17loUz6+ccCOj1EAWD2TTNFh62qU5kkk+WVbneOoIQMWnx55EALVJRN77sJX+sszs35WO8nXakjTkm7kVvwUuWEd+YTc/cf5aXOIQaEvs20w92ebleK8uz0rxgcPFR2poNN8KcQIf510HPxJ4ZLAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gxrgNZR+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gxrgNZR+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcL0v0qQtz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 23:27:43 +1000 (AEST)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-30749947917so2925036eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 06:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270861; x=1781875661; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/AXZy6D5BbhT5x9hx+suwKOnmd8LSBhmzi01ciTQP4=;
        b=gxrgNZR+tZj7Mz7XyFGAexmB8B3SrLP1MBS5Oyq0AOLH/6NL1R0MS1+hpI7RZ40IdM
         92tJBqZAWFow80HGTR0Hn0iJNQ6qte8MBLeuPlYECF0v3ng3NHobsutNRUkDmy17O/yJ
         3Q76sHiQb8LN3cHZ4PucwZP+0FPdUIBfQ4aPzTCx8H2aa5GistmXzrxIt+MNbH9WlaLe
         VVLlsij5tdGbqNZ0Q8qeWxluw2NXpneejGdQX3WixYThKKee0lOzHH2k0C6QBFoNVfzJ
         aN0aiFiSkkfgXoP4c8Lv8Av+//2cYqCHIJ0zxAUXFoPsPpDP2v1Oauk1IOnS0Bo+VlkI
         ToiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270861; x=1781875661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t/AXZy6D5BbhT5x9hx+suwKOnmd8LSBhmzi01ciTQP4=;
        b=J4X/Sgs5GyNHn8IqViBS2zuCc1TJv3waAD6CDUAQi+zGstJ5muq/qua1g78mXSvo8Z
         qAwczFMbzeRA1I3h2QFNU5pZbRJCPUXh66YqKgzlrHh3H9rgOrG1Ju+6Roi0r4vywF1F
         k9GR//B1Evxq8Ni4GwvayZdTQZx1Gn3sYkH8/ofAg3BrRHGEuEoSpjTnenPScQKfeduS
         UInowfBIL9V8EZrb67FSHJD/XSK7PXVMWnLFfwgij0zF+aPI0IBD8qSRw+NQDuSjq6lA
         n05PGPyYmGaczwzvOxCHsxX8MqvQz/cxrCXX81zfwDc53ke2XXrfSbe/KE7JCevTtr9t
         eqRw==
X-Forwarded-Encrypted: i=1; AFNElJ9Q53MH/hc0+YszbMJHGe9WQvsaBSpg1eeuQSJwMYj6sEKrKQvJ+3ImwWntWIRJxMBx3izwUHORKDhVj7g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz/5xLlivYdrNyB+UKHvPefaJ+NzKKnwHiAkQ88edOjxZiL8nah
	2WMSiDmySVVttNlK2H3sGy1AYxvTzdWv83jLQEOvdv+swI639h/MSPJa
X-Gm-Gg: Acq92OH/RNKGD8TZ3T2nlF4RqTbebYQrdlVva2dWJiVHb0mJjVALNfxKi1qfjxlv3h5
	WR0/b5mE5zS45mFuBozI58IJKEUAwBGzTgg8sQiCNe4YouUXhA5zmeFLK1L0ZBc5dBSniBknEr8
	SBAbsMR90Q4k/EZz3GNNlDCSIgaByPNZFiaE8bQOUqjwzMdgrLyLFvrSIcOX4s13OXpwPkNvn8A
	DTQNBs+86ySd4uAIv2Ch1CCjUdzsreBhERrLHdZDw3a2GYE08sRomVA7rT/Onms99/vpJhdtg/A
	sAiUKPyb+E90BxxZ1CYkEBS0ZfR9re+b5zDKUiOa9gznhe7Q/zORYw0Xo/k7yZn/gsKSLOdR7vG
	u2aab3IxNUeG5sJ2ZbkJkgTZ2OkPQF4v/6uG3eb3PDXbSAB+Y3lQW1rvH5MOgJwp9EJDKK996pC
	R/LNu6SmLFxdrP913IeIFN8v74KYWfZOnYWidoYD0OKlg0b8luauZxYjYXew==
X-Received: by 2002:a05:7301:60d:b0:2be:2cfe:68b7 with SMTP id 5a478bee46e88-3081ff9ae90mr1661153eec.11.1781270861204;
        Fri, 12 Jun 2026 06:27:41 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm3302343eec.19.2026.06.12.06.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:27:40 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 08/11] ASoC: imx-audio-rpmsg: Use guard() for spin locks
Date: Fri, 12 Jun 2026 20:26:36 +0700
Message-ID: <20260612132639.78086-9-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612132639.78086-1-phucduc.bui@gmail.com>
References: <20260612132639.78086-1-phucduc.bui@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Clean up the code using guard() for spin locks.
Merely code refactoring, and no behavior change.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/imx-audio-rpmsg.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/imx-audio-rpmsg.c b/sound/soc/fsl/imx-audio-rpmsg.c
index 38aafb8954c7..b55dfbdb4502 100644
--- a/sound/soc/fsl/imx-audio-rpmsg.c
+++ b/sound/soc/fsl/imx-audio-rpmsg.c
@@ -22,7 +22,6 @@ static int imx_audio_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 	struct rpmsg_r_msg *r_msg = (struct rpmsg_r_msg *)data;
 	struct rpmsg_info *info;
 	struct rpmsg_msg *msg;
-	unsigned long flags;
 
 	if (!rpmsg->rpmsg_pdev)
 		return 0;
@@ -37,21 +36,21 @@ static int imx_audio_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 		/* TYPE C is notification from M core */
 		switch (r_msg->header.cmd) {
 		case TX_PERIOD_DONE:
-			spin_lock_irqsave(&info->lock[TX], flags);
-			msg = &info->msg[TX_PERIOD_DONE + MSG_TYPE_A_NUM];
-			msg->r_msg.param.buffer_tail =
-						r_msg->param.buffer_tail;
-			msg->r_msg.param.buffer_tail %= info->num_period[TX];
-			spin_unlock_irqrestore(&info->lock[TX], flags);
+			scoped_guard(spinlock_irqsave, &info->lock[TX]) {
+				msg = &info->msg[TX_PERIOD_DONE + MSG_TYPE_A_NUM];
+				msg->r_msg.param.buffer_tail =
+							r_msg->param.buffer_tail;
+				msg->r_msg.param.buffer_tail %= info->num_period[TX];
+			}
 			info->callback[TX](info->callback_param[TX]);
 			break;
 		case RX_PERIOD_DONE:
-			spin_lock_irqsave(&info->lock[RX], flags);
-			msg = &info->msg[RX_PERIOD_DONE + MSG_TYPE_A_NUM];
-			msg->r_msg.param.buffer_tail =
-						r_msg->param.buffer_tail;
-			msg->r_msg.param.buffer_tail %= info->num_period[1];
-			spin_unlock_irqrestore(&info->lock[RX], flags);
+			scoped_guard(spinlock_irqsave, &info->lock[RX]) {
+				msg = &info->msg[RX_PERIOD_DONE + MSG_TYPE_A_NUM];
+				msg->r_msg.param.buffer_tail =
+							r_msg->param.buffer_tail;
+				msg->r_msg.param.buffer_tail %= info->num_period[1];
+			}
 			info->callback[RX](info->callback_param[RX]);
 			break;
 		default:
-- 
2.43.0


