Return-Path: <linuxppc-dev+bounces-22629-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1349BCD98DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:40:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4qk1whGz3bwk;
	Mon, 15 Jun 2026 19:40:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781516450;
	cv=none; b=kaV5x2sHfsm8NjF3ia40NNwbC90a8VxRb9JWX4GBHfHYFN1TA0IuVsQBG6aWhVzBAkluMb/rZMduXKjADjCrSSgJrFkkVn0lni2zsqfY+Radc/MgSNTC0qw9ScxFtNCfQ5PQvoO6/rkByAN/cwP/zEXjE922qyjvB0bMP+HgmawknoxQtDK6ivzUMKCjnwpcf/6aWiGF/5Km9+JeJWjoAWu9c2JFzDugCAsM7dteUnxbF+N+DWcIcrL/25q9sv9hOF0Os+/UX29nv7O3v9qeeDrnG83ACt6Jt1nEhUZyPVXnNtg+5LfYYSbGHwgvNinlcYDQKVamuyH1/fa3GRHRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781516450; c=relaxed/relaxed;
	bh=t/AXZy6D5BbhT5x9hx+suwKOnmd8LSBhmzi01ciTQP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F23WB8+VR5qnTtcftXV/52f2Hhg4CKrDUjT0zTNylp+zmQNateOKMG6ZXo8rbIATstNLy+pydh6YSPX9A0r+POQYK7ybKmUKAqWpQCpuHLJEDSbolAfRUxUzancfdUcPhLLf7+O+uLzJTJMuWifhpVd9LtCAMX2zi1FuvWe/DSBBgM4xRwoVPYQsfa0qseYGpM7iFNmKMPif4NNBsZ4Aa+SZfytqf+cKm2Rh11FDsQVBvo7XP1wWZ272xL17avG2oBk3mUvFTbOxq7Fka2SqytnxlVPF8xXJYsUhTxJVoGTR0IGU+jwZeCnt1Hg3YDuuu1pL6pqJFl1HZzafp+78kQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cGT8SnWS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cGT8SnWS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4qj3wmNz3btk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:40:49 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso1795475a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516448; x=1782121248; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/AXZy6D5BbhT5x9hx+suwKOnmd8LSBhmzi01ciTQP4=;
        b=cGT8SnWSKnjPe3Rzh7B1lj+OGjYTn65eRBAt2lCaa1rJ0HORL2rbvyPMf1RvxMSHYb
         8XWtDZWvlU4xvhhC23BBuG2l2kRUcxgqpH/9RkK4qlCH4FK3HJvIJNB+zWD0Ab32RqsP
         QtF0d0eVRar5IWqMDquMtrrwUsAQKcWSsP2bHt6cZ+kqNBN17fv2aDIQnBF4k/fGCgq2
         P7SORqBVT0xdshZDCTz43pIuouCf3BVmfywOMPAkA6/n5visyK9xNVGX09dJeeSEqToJ
         yVzLVQL8oxsSDulkDqcQKLW6rpM5/G+ha4yIKs4IsD1iTB6vRZF4uYkQRhukySLsprnH
         BeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516448; x=1782121248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t/AXZy6D5BbhT5x9hx+suwKOnmd8LSBhmzi01ciTQP4=;
        b=pZBlzKd5iiNnq72XnHW+tGJ5fyHqEPiSJlL3Tlesac6tFBPZ6U+dzZLcwDVcNvFck0
         Ea84LQKcKcPdQaN5Ph8bI02xYSsVFrKsmiecozUmLCpElrVTyFpxoPGQZbU43rRQLj2h
         k1Sm7o3lmiZ7nvLDAGxdfGcSoZQjWl7EBgNWwu/1Sd1zEmleSJ1IstMmcseBxzO6VOmL
         0oIXiswPkd4akwH9StY3DymSrxLebwsKhJahZEdwLtXLaQ0RKV4KvRzVsSAGf6NMTvHK
         PWo77pIsqGg5y7Sjsp9u7KgRriw8lh1lhtfXCWTiZgTJakgZ489FYNjQUBNrspflxLa0
         JuCw==
X-Forwarded-Encrypted: i=1; AFNElJ83/j/OSX4m8hWGCqrk0Hm0HeRJ7B6s8qg1ZI2iaIDhvAbqg7q8vfrLBDSqGcIOp/E+4030bijKRiZOt4c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx3nBv/trkrsJelZ33HGBc4t5mf4Ajbrt6fVJQFrBRb8iv3zAC4
	UyDdthg6OtwmIUoYoJ97mXAgj4TYlpi1m/cz7maati+juwAgZTAEj0qG
X-Gm-Gg: Acq92OE/ozme27nO7r8exbPmNCDutujH/TUqOaeRSBL+Rq1otEuxhAIN7Uspl/Ou8Gz
	8LmcBRSXtjbN6r+xw9cLdqZlu00KQh4bMdLJn/XFoCbLOc9CPIKjW1ovbGSGHakbCe+upjxvRxN
	trIj+xDRcDrw5Ke9IFnv7dR1S1DvzrYUu2qgTu6WQzlt3AMXjw1/lIT6fFFPb+JYYx9jyXOQSp7
	zEACtGdxbR333jugf9niumX5ESjyABbKFisd302I0yIPX8PAfqQivmKL0fi13Md2RkLfLSk49eE
	B2VbyXzidftWm1j02d+CG3YIIu8zxdRz/ql+79Cw/u6gDrXByGZVQwvOoHGh8FVO3j8/tB4Z5Rh
	cHNBuQGTpsn5bg5GlVeYY+NBTgoSMCkzUnMI0KIt62PJnICU6OgjyxGHnh6Y8S45IGt0BUPpp8X
	rl+1QTEwGNXAofHn70yvI/ee4liBxxG3HVxCTItWK4kcxvQsR1Kc8qgfgm6g==
X-Received: by 2002:a17:90b:5583:b0:36d:5d1c:c4ad with SMTP id 98e67ed59e1d1-37a01f2d31emr14079846a91.9.1781516447765;
        Mon, 15 Jun 2026 02:40:47 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm9936290a91.2.2026.06.15.02.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:40:46 -0700 (PDT)
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
Subject: [PATCH v2 08/11] ASoC: imx-audio-rpmsg: Use guard() for spin locks
Date: Mon, 15 Jun 2026 16:38:21 +0700
Message-ID: <20260615093824.115751-9-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615093824.115751-1-phucduc.bui@gmail.com>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
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


