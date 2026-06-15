Return-Path: <linuxppc-dev+bounces-22628-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12342CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:40:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4qc3gL4z3c3s;
	Mon, 15 Jun 2026 19:40:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781516444;
	cv=none; b=lWKo1moyl/dxItb5pLYm5ezUGTa41Y2Em9/R7mAJfUKsXUBIF/n5M3isf+TIlcinbBLwgvqICI1cfG4oHC8b4haSBAQ47DCg7GPrl0hXUp1Q+DO3OiN8hqdNByprRgH4NM+ALi9GJ/jAyKg5gXlT68GGKkvWs0pN4UnbCmTcqnQE0cCp316PZLNjSnSnRw9YMP+2z2k8gHQZy0HtBVF33ChKsLESPUz8NJPyLf5woXrRInEdI3ciXFBqKw37BsaQbnhKD2vSm1bNZW0WbGHvR8odeEB4ymI6acdZVemukaSuKOC9v+ibVhQedGprItr3mtI6QNx2n9hXL6Mjth/hEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781516444; c=relaxed/relaxed;
	bh=MVq+Lu3avSLljn1bjHDwqj7k0Y9nxoC/mnINOIpcocM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIfgqsv+iRJnqS3KupkK7RMpGkV2YGB3olJtBYMTHkwcwzCVhk6IjNVLSsBlbVhjUiw+Nvwrf69bN6ssVJ3AxjbsV5qBaA8dNiDTQqoEww42aVrp+FiowvK+w0qDEdvap+gTiphHJe3VLlqCKGUSSYbh14HUB5EFqLJuPtqh0ererfV4MEfqyRdbjop0tXbksbUucszTBQqcTAqkSiaFf37HWn8Z1F9iYkmfokvFYh7Yx561iz4k8bNgN+PeiZIRMN36UYQ6L/UW1PpcE15/VB57GEDWurjjYpAF48hAvG7CRMU2qruqhTlMDJxjed3LD3tsBgRfGXP7aIU+HSF03A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f6Oi+XSW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f6Oi+XSW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4qb5zlHz3btk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:40:43 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-372b4330deeso1960251a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516442; x=1782121242; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVq+Lu3avSLljn1bjHDwqj7k0Y9nxoC/mnINOIpcocM=;
        b=f6Oi+XSWPgSCkW7QF715BXFozrUlHg54Yga2d2KqpqxMY/zUeQd6Fl3HE3m7EJFf3n
         Kl17Ysy81UTQHUAwcYxXzAClX4JpYa6/wND3mJxmxSiZno8jYZJOe26qoBH9dutJ/cHe
         JuJ4i/MlnDNpum/0L/4FCwRGxTUgHlxy5vcda7t5xoCxquMtj1PVezk+JOqaabIckqrh
         1C2Ku96NgzApwZHdspzhKQfqWDX0xB29aFy+zmXMw7fWOlwd4yf4M69JRutDnD+u9WRE
         ZepOmzCQfa/+A4Tl/15YsM5ib+lcDBO3yX5/rYirH56Bd1/yJ//hJ1JKOAZJ8hPM0UNv
         PK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516442; x=1782121242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MVq+Lu3avSLljn1bjHDwqj7k0Y9nxoC/mnINOIpcocM=;
        b=Lt+m+iQwsD9jS861Y5axTkBrTuMopSgSD2AA9GU1Te6tc+HbUCM24F1kHTGq8xWzF3
         0XwpI6QTWv+/McocWp7EsQqZKp4hLULTCJwuYAFES58cX68KnIU2b4QRyrVnEa+trkc2
         T/slFZymQJLQEWLVNgUhje2Cu6pDfqk4ovKBGspV+BEo/zYgtPvBs/H6PRBhs7XyCZVM
         i44Q6S/OBoQFbAcrDoSKvVqaBmec5mOBK9LnH3wd0+291YVPRrGdteplLRcW4a8FB9wX
         SDzWNjmsSeZwONFERclG3Ns1w5Uf/bsFiGGJQSm+LiIqdoRnM1zUKXf77fQl2zLmMMt6
         p47w==
X-Forwarded-Encrypted: i=1; AFNElJ94oQU69LXyVxQwF1suPVI7KSJkHC9Kmu8dpj5/pnKoXOvFNtCzAf9RFzdc96fpIjNzpkI+1Nw1Q6zMal4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzLstC7Ibh+1Lt00zCAdPcaCPFKBUoEbmPHPV5r1Whe2FFJ+d0f
	xcSIdHV7Sp2D05Wd1GWV0ygCVHF5H4ZTJ6yFeZhUQm0fmSBKXGhBSpzP
X-Gm-Gg: Acq92OFzcApZoHmFXBs0pPu2U2qzg26kCWnODVH8QDm5okvS68iPTFkViJ+vxZNGtyh
	iBcir/wxI967yL2bsVhmJI4Mb3Y7lP4uh8XeElBlkaHe+vKlxVqeynGfPJ7inWBJxmoIsWP/Qhv
	XGreKhWW+QuRhllmwxG3vVrMI+0R+OhEzAg0rISmMQ3R9M//ndkXtVZ+PBduP7ZJGMKd1CTOO3G
	byjqvAAK4vJtzyAJiOwmZf1Qa+Vd898IPqfVQtcAwJPToBaD6cGFeALDVcmo7Dlf6mNH9gfH6Uq
	EtsbVO3ev5a6b5kSzXvjSMzE4ZWT6vVJBg3xjeNgOTVO8UuIoeykJx4/kl8wM7RO+LED3uJ92vY
	U+o3oCgae8IKi9bpTTYQoFrIBA2Z7xhI6BzW0bT2AeGzucPkyIKTHe5u6WTMV4YCqnsU4gSv5ea
	/JviYQAXdpH5TjNe3fTdWIHpHElAl8Lz2pCfg4DUAU+9Y/NOsXNFUN0pnPhA==
X-Received: by 2002:a17:90b:2781:b0:365:a5f6:4a5c with SMTP id 98e67ed59e1d1-37c2bc5d202mr10797246a91.1.1781516441891;
        Mon, 15 Jun 2026 02:40:41 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm9936290a91.2.2026.06.15.02.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:40:40 -0700 (PDT)
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
Subject: [PATCH v2 07/11] ASoC: fsl_xcvr: Use guard() for spin locks
Date: Mon, 15 Jun 2026 16:38:20 +0700
Message-ID: <20260615093824.115751-8-phucduc.bui@gmail.com>
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


