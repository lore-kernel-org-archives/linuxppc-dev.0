Return-Path: <linuxppc-dev+bounces-22567-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C55CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:49:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMql6PJgz3bsM;
	Sat, 13 Jun 2026 00:49:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781270858;
	cv=none; b=PegnH1XHQ30JzHxe21iETzsbSYmRDjRnlhdmPD9+8cAfgNhnv5oQbOzWonv/1jua5Josj2+AFyvYSDJg4ecnfmhUOAOyh+d5OxSBVyHDToziIdrfR89k2WhSYVEJAz8Q6m4pS8dbmzLgTFEFcL0VI8hqlPsEF+5/uteL7s7HADPLJ9DOJxIL/RruWBn8Yc2NeLND6yrc46FIuGHSXpfy6hb3KcvbrmAmGhaURvfLdv5e6ueNPCUddLNXrFGFOYoVNUWxD6ssbmlVF/0wLK45SkJbCE+n7UJO5U90IV0Gmls0Luzy2Ns/q0oYj2kgKCY/6lohRnm1UMa7WszqSBWCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781270858; c=relaxed/relaxed;
	bh=MVq+Lu3avSLljn1bjHDwqj7k0Y9nxoC/mnINOIpcocM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbIkQ/KgOd8Femg4RG3STNDvYbbZZMYZwizo0H8d3ac5Gy0xZcY94mZtMypPT5zngqph79WILNfcAMW0HP8k0Cqt2WQneTJeuvSRGli0wSDq7K+hq/W93MW26xYPIXTiZPA+TRwLktmKsUoTyixIVuiGichzWGeHHIeVLmyw1nlyNdSMljxmU8wlIT4UgJBGKz0T7kSrk1Sbaw0FhFRpt7DwXPis4mz8jKKVYP1jVWO2kAcgKMNK3qlgCTySs1S0t+IpnEkXG49uzGZ5JQJEpbOQeulVq65or0Hd1hMhsERJ4608SIECOKjOaL7TH3KtXnhrdsYPaKPmqLhF8kp5yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wu9l06X8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wu9l06X8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcL0n6mYCz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 23:27:37 +1000 (AEST)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-30759632453so2066495eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270856; x=1781875656; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVq+Lu3avSLljn1bjHDwqj7k0Y9nxoC/mnINOIpcocM=;
        b=Wu9l06X83mUljYvTQR0+/nc21pxwif6+s6M8K9F/Mq2KxTGb7zEFYHa2M271XNAx5O
         Zxi8USz3hN2V6zgXp4BLuPCOapYMPZO1bydvFgf3ACmMWM4zmHoXMWF6SGf/8u66mee2
         GOPaiqhEIjDVw9eA4zp/Vf8f9PNM9oyozPHHHYy9Bo098m1MYwI9qBcvmt2dHdYAuw6p
         Ia4m/cUrhIbzH9vvO7oBddaavPgz627aK+Xqn7JmBfVjwzBj4JsfBB4Bkqt/i5KkrBGG
         6iH+FW8iqjzcJsP+rdhDH2l/ILZDmfmYfFrVgFILidqREHdiq3UEKnk76eXwVWFgDd5N
         D/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270856; x=1781875656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MVq+Lu3avSLljn1bjHDwqj7k0Y9nxoC/mnINOIpcocM=;
        b=fYtzLLDoRD+5UWVpjwpYzLFGQCSsoJ7RAz2CYrAa4WT9rQxBBiRiNILCCnqItzdJTK
         6B9DTNKKFJxZNP33B5N2hvvQ8kEWi0YZa23K9a5dHuQZY5/1NK/Z4P0XPGWsU4nqBMON
         vQ9wHSQ9bTcv+1fWqjFy5O9I+inzx7Oc9ogvvlSY73xCmELZRWbPGlJKf3izHytMBjYH
         szuuszHvKle2lLVtzO7l9cKGItTrfRc90sNCEF2Hqqce8yMQfYVTsbvuRrElgnEGVJEQ
         /ItXknTQAXbTBRNsdtXvXNr26IGS6ZkjL+dCi5ZML/7wp05dqnAS0f8qEjX2KK8cULlX
         k6WA==
X-Forwarded-Encrypted: i=1; AFNElJ9hi/KxIQi4xRJMV//PYqpU84OrLnDd3iAO1vo2v6TJNdxZ/Iu7TFcZXoDuioM8iqUC+ZrRoQK1yFL6UNg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyrsK9u7LClctgLKam917Dvt2bv9bv+KFut3bAiD5FH1U11a2Cz
	4SviXZztSQavpxnJHmnzTbaAXjAFmW/h8oiU1tyex+D++vsv3b/ZRDJO
X-Gm-Gg: Acq92OF55EGm6kxQ8PJNSALSKP/FIAW+7RTaKrVS4hHhYBvzGYxvBqkX9zUrrmF7M76
	LnsDdIae+m962swEvE70f4E3lMBskj75ivapXHpGY7vUx1/RLzm8oqhkT/7Cukt95kLrmV/u/8u
	V/u/PxOtKu5wpMJpcqJQ1jZUC5Rz+GvX7KUsqyamDbfaZl3cYYrYf9sNoJkHUyRlnal80i0NnrA
	IeX1IxbFucO0Ogu5Jo3kn4GmeBw3M3su4CDLO5euKvwjYkppgA7JdPFksnnA6oqsfiAsmAg9O6i
	1EZfw0Xm5CsfBihnqt65Hi/OpGLKdexJ8Onoh6sw29RHzzdBckGZCIKnu0XmKiUDGrQH1EXzVRg
	aQB9bCaOsmwXnLhkB2vXptL1gHdLvdxLXbpu+3z4a1ToW4yrlZBtYBlOU7PD4pR7W8XWQ5qF3Kw
	5OF5CSXibGjYvEuTwnE0RE0TQ/2n/e0Poe9lEHPHgg7LgapT8daLYppExmRA==
X-Received: by 2002:a05:7300:f082:b0:2ed:7e1:975 with SMTP id 5a478bee46e88-3081ff64a8emr1866575eec.1.1781270855805;
        Fri, 12 Jun 2026 06:27:35 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm3302343eec.19.2026.06.12.06.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:27:35 -0700 (PDT)
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
Subject: [PATCH 07/11] ASoC: fsl_xcvr: Use guard() for spin locks
Date: Fri, 12 Jun 2026 20:26:35 +0700
Message-ID: <20260612132639.78086-8-phucduc.bui@gmail.com>
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
 sound/soc/fsl/fsl_xcvr.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 6677d3bf36ec..41d100500534 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -797,10 +797,9 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct fsl_xcvr *xcvr = snd_soc_dai_get_drvdata(dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-	unsigned long lock_flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&xcvr->lock, lock_flags);
+	guard(spinlock_irqsave)(&xcvr->lock);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -812,7 +811,7 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
 					 FSL_XCVR_EXT_CTRL_DPTH_RESET(tx));
 		if (ret < 0) {
 			dev_err(dai->dev, "Failed to set DPATH RESET: %d\n", ret);
-			goto release_lock;
+			return ret;
 		}
 
 		if (tx) {
@@ -824,7 +823,7 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
 						   FSL_XCVR_ISR_CMDC_TX_EN);
 				if (ret < 0) {
 					dev_err(dai->dev, "err updating isr %d\n", ret);
-					goto release_lock;
+					return ret;
 				}
 				fallthrough;
 			case FSL_XCVR_MODE_SPDIF:
@@ -833,7 +832,7 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
 						      FSL_XCVR_TX_DPTH_CTRL_STRT_DATA_TX);
 				if (ret < 0) {
 					dev_err(dai->dev, "Failed to start DATA_TX: %d\n", ret);
-					goto release_lock;
+					return ret;
 				}
 				break;
 			}
@@ -844,14 +843,14 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
 					 FSL_XCVR_EXT_CTRL_DMA_DIS(tx), 0);
 		if (ret < 0) {
 			dev_err(dai->dev, "Failed to enable DMA: %d\n", ret);
-			goto release_lock;
+			return ret;
 		}
 
 		ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
 					 FSL_XCVR_IRQ_EARC_ALL, FSL_XCVR_IRQ_EARC_ALL);
 		if (ret < 0) {
 			dev_err(dai->dev, "Error while setting IER0: %d\n", ret);
-			goto release_lock;
+			return ret;
 		}
 
 		/* clear DPATH RESET */
@@ -860,7 +859,7 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
 					 0);
 		if (ret < 0) {
 			dev_err(dai->dev, "Failed to clear DPATH RESET: %d\n", ret);
-			goto release_lock;
+			return ret;
 		}
 
 		break;
@@ -873,14 +872,14 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
 					 FSL_XCVR_EXT_CTRL_DMA_DIS(tx));
 		if (ret < 0) {
 			dev_err(dai->dev, "Failed to disable DMA: %d\n", ret);
-			goto release_lock;
+			return ret;
 		}
 
 		ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
 					 FSL_XCVR_IRQ_EARC_ALL, 0);
 		if (ret < 0) {
 			dev_err(dai->dev, "Failed to clear IER0: %d\n", ret);
-			goto release_lock;
+			return ret;
 		}
 
 		if (tx) {
@@ -891,7 +890,7 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
 							FSL_XCVR_TX_DPTH_CTRL_STRT_DATA_TX);
 				if (ret < 0) {
 					dev_err(dai->dev, "Failed to stop DATA_TX: %d\n", ret);
-					goto release_lock;
+					return ret;
 				}
 				if (xcvr->soc_data->spdif_only)
 					break;
@@ -905,7 +904,7 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
 				if (ret < 0) {
 					dev_err(dai->dev,
 						"Err updating ISR %d\n", ret);
-					goto release_lock;
+					return ret;
 				}
 				break;
 			}
@@ -916,8 +915,6 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
 		break;
 	}
 
-release_lock:
-	spin_unlock_irqrestore(&xcvr->lock, lock_flags);
 	return ret;
 }
 
@@ -1448,11 +1445,10 @@ static void reset_rx_work(struct work_struct *work)
 {
 	struct fsl_xcvr *xcvr = container_of(work, struct fsl_xcvr, work_rst);
 	struct device *dev = &xcvr->pdev->dev;
-	unsigned long lock_flags;
 	u32 ext_ctrl;
 
 	dev_dbg(dev, "reset rx path\n");
-	spin_lock_irqsave(&xcvr->lock, lock_flags);
+	guard(spinlock_irqsave)(&xcvr->lock);
 	regmap_read(xcvr->regmap, FSL_XCVR_EXT_CTRL, &ext_ctrl);
 
 	if (!(ext_ctrl & FSL_XCVR_EXT_CTRL_DMA_RD_DIS)) {
@@ -1469,7 +1465,6 @@ static void reset_rx_work(struct work_struct *work)
 				   FSL_XCVR_EXT_CTRL_RX_DPTH_RESET,
 				   0);
 	}
-	spin_unlock_irqrestore(&xcvr->lock, lock_flags);
 }
 
 static irqreturn_t irq0_isr(int irq, void *devid)
-- 
2.43.0


