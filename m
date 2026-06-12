Return-Path: <linuxppc-dev+bounces-22570-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DD8CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:50:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMrF1sRqz3bvX;
	Sat, 13 Jun 2026 00:50:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781270874;
	cv=none; b=WQvDFzvGV+yH/zv5qSeziwXNWdDU48PhsBsHNBWMRjQfqJnRvvP1aZ6O96btoXboc+ZDPBsSsFQ+SfQxus9U5jvqoZyZbQCTuZY0SmmvD0eHCSVHOSqXQuLtgK8d6FGnnkjtXeDGj6pLWzszW5zJKB1B8mbQnvJrDcpT+8DkYUfQEkmypSi6C7MLxATJgQcPalSE/ANmS1ugEB7y/7BhxT4BanNfDiJCH/ICrHFyiPYuiRtUb7QaQ+ytZKB/kgKm4GG2oEL8vNsb4Uf/j1vUtHz7atknAwjjp2IqP0tltYY9NTttY+XLvq/uOLYwdK4k1mAIfgLSKJvNBvq6t69BKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781270874; c=relaxed/relaxed;
	bh=fixiw6LCSjSy5TCm86A8JjKJ/P+woOFTUDHQjwMDfTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADwclRAmid2FGyBHacmAkg58Nc04DyT3yt8edAhvl+m+bLppxEsvTyjcQuKBKs6xW4RWrf+PII1xrMabLTLkEJ0jmcpdZ/9dpQXDm3Sw5bjsZmDZVTLN2DocW13r9I8EpNthHA81NkZk29N8wIXWfACnZWiM7yD7BNYo7VIRCWe4zVRVAdfFQeNo66I1IbAYw2gK8Vf86f6bv4Alny/YvLuZ2QC/GcK0GDvQAxF16qFXg6hF4GlrG2kH7WQqRnJTQhTnd3ZBAaBEUxHCzUtGWML2gKx2V+qTJN0CZpVsS/eGq/f7wihWZr27wYIe3DIDWLPgGzZz6pJArh+LPpiGiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J76vUlDi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J76vUlDi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcL154QKCz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 23:27:53 +1000 (AEST)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-307d0405e07so1469532eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270872; x=1781875672; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fixiw6LCSjSy5TCm86A8JjKJ/P+woOFTUDHQjwMDfTk=;
        b=J76vUlDia9SCF4SUr6s7coEEUbrk57yOHJtFc6dFYQVgXHWw2q5Hov5SEBBoUJZSV/
         hwawCwH90ajLt7TDTD+OJCD945DuvfHGWkclBZ3PGWmlyZMymskMpde3nyQ1SBgNo5kq
         DE3W2RQacr1zqHeZrYNs53wBZMQ3wOezCNwo/oK8snXlRLa+OSmA1QlTylSGqIEmiJux
         QLA9dkn32poJXjxrmQHPKQSLT49x6RDskECoEBBKr8V/93FxDmgdhVdF0qh3fXkQcOjI
         uhivfl1UoY365NLndl/1aB8d44zp1Wc3IKymXkOX95a15dbcfgA9iJOuiwiqEBb7+I7V
         cCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270872; x=1781875672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fixiw6LCSjSy5TCm86A8JjKJ/P+woOFTUDHQjwMDfTk=;
        b=Mu9MCIuzNTAT0y5G4TDnGoyI8skBgeB+7xtOi2wbi6zIYkOKr0HBKAq6ECnCqT4t9K
         GlwtJfv5gvHGKP6CJ6rIEf91GhCDSFa1kQKO3YFC8h96nQv0QjW7rTu/ciPqUOjX94u6
         Et3s7JFui1FoMjN2bJfuBXreL5vj5rln1putmACWEwV0XeAm/MaVmUVAMcQrUqxRLjnb
         II4Ay5iDpOA6N/6dhs6lUiAkG6bPPF4Vq432SxWCCRpUFvnwF7lRZyvVPmNeq7udUPKv
         MRj6hix8Wi2ipySbeKNiJQM/Uo97qglQ/gzydWv8xleSakAK/6t8njFTNyXXNkeiOIAX
         //2w==
X-Forwarded-Encrypted: i=1; AFNElJ90WWPSssm7gyl3zdDkkZ+KTQ9xXh+0/jghznAy04JaSdSjXMjVrsDKr+o/9uaUbv+AMNsRrbzKeyqLjpY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz5B1H6XaXxA8SZMdv/aDpDxCjkAL0dtOcqLcgzv9DDUDY7ZRH2
	AcyCYtY5YZwltWC3XsxurEKK4TJAZ+pcKvjx6d3PXRlsvWu2W4QmzErA
X-Gm-Gg: Acq92OFTITUMVcNLfURsQOiZPjnKa36qpjn7nOhK8TKen419J0un/ObDITHw6mG8vRJ
	WOaNoQXIUNnopuy/gtDx7PfrA6bpisdK1Md07FkiFyuUw3XQvTdG9dTqMmltqRzsdiFBQXeRdkk
	qhs018ysjQEXNawfenTRtilEi5dq0z53jEbB6MFkCiW5V0Xcj99NdydDjHTjlGmy7044k9EvWre
	9L8rfa9tkuGpsy90D4WGRlkp6MwPQEV/4Ctw7kGgG17JML2JtgTmQ1ZF6d2alLpP7GdbHopU6iZ
	yPUTybLgS4I/BTM+4ZWAvZke0atmUcRxLwH1GL+1MgvEudcRFvD4tAxKlF2kIS2wgKZSNLh+p1b
	yZ00UPHB5TAs9mtWNvueUzEXEGt+Gi2GuifYzhnVvUPiJspiYeB7pSHTprjlVgcL0hc5oaD0i7N
	tFV6HlP8fIY1tg4c1q4o0qfPCO0W3QNNEuNqzReMETk+CsL/RTGA6q4TbvRQ==
X-Received: by 2002:a05:7300:c8c:b0:304:8364:e95c with SMTP id 5a478bee46e88-3081ffb2789mr1848291eec.15.1781270871669;
        Fri, 12 Jun 2026 06:27:51 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm3302343eec.19.2026.06.12.06.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:27:51 -0700 (PDT)
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
Subject: [PATCH 10/11] ASoC: fsl: mpc5200_dma: Use guard() for spin locks
Date: Fri, 12 Jun 2026 20:26:38 +0700
Message-ID: <20260612132639.78086-11-phucduc.bui@gmail.com>
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
 sound/soc/fsl/mpc5200_dma.c | 56 ++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 56e2cf2f727b..bfedb2dea0b3 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -77,18 +77,20 @@ static irqreturn_t psc_dma_bcom_irq(int irq, void *_psc_dma_stream)
 {
 	struct psc_dma_stream *s = _psc_dma_stream;
 
-	spin_lock(&s->psc_dma->lock);
-	/* For each finished period, dequeue the completed period buffer
-	 * and enqueue a new one in it's place. */
-	while (bcom_buffer_done(s->bcom_task)) {
-		bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
+	scoped_guard(spinlock, &s->psc_dma->lock) {
+		/*
+		 * For each finished period, dequeue the completed period buffer
+		 * and enqueue a new one in its place
+		 */
+		while (bcom_buffer_done(s->bcom_task)) {
+			bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
 
-		s->period_current = (s->period_current+1) % s->runtime->periods;
-		s->period_count++;
+			s->period_current = (s->period_current+1) % s->runtime->periods;
+			s->period_count++;
 
-		psc_dma_bcom_enqueue_next_buffer(s);
+			psc_dma_bcom_enqueue_next_buffer(s);
+		}
 	}
-	spin_unlock(&s->psc_dma->lock);
 
 	/* If the stream is active, then also inform the PCM middle layer
 	 * of the period finished event. */
@@ -116,7 +118,6 @@ static int psc_dma_trigger(struct snd_soc_component *component,
 	struct psc_dma_stream *s = to_psc_dma_stream(substream, psc_dma);
 	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
 	u16 imr;
-	unsigned long flags;
 	int i;
 
 	switch (cmd) {
@@ -135,19 +136,18 @@ static int psc_dma_trigger(struct snd_soc_component *component,
 		/* Fill up the bestcomm bd queue and enable DMA.
 		 * This will begin filling the PSC's fifo.
 		 */
-		spin_lock_irqsave(&psc_dma->lock, flags);
-
-		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
-			bcom_gen_bd_rx_reset(s->bcom_task);
-		else
-			bcom_gen_bd_tx_reset(s->bcom_task);
+		scoped_guard(spinlock_irqsave, &psc_dma->lock) {
+			if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
+				bcom_gen_bd_rx_reset(s->bcom_task);
+			else
+				bcom_gen_bd_tx_reset(s->bcom_task);
 
-		for (i = 0; i < runtime->periods; i++)
-			if (!bcom_queue_full(s->bcom_task))
-				psc_dma_bcom_enqueue_next_buffer(s);
+			for (i = 0; i < runtime->periods; i++)
+				if (!bcom_queue_full(s->bcom_task))
+					psc_dma_bcom_enqueue_next_buffer(s);
 
-		bcom_enable(s->bcom_task);
-		spin_unlock_irqrestore(&psc_dma->lock, flags);
+			bcom_enable(s->bcom_task);
+		}
 
 		out_8(&regs->command, MPC52xx_PSC_RST_ERR_STAT);
 
@@ -158,13 +158,13 @@ static int psc_dma_trigger(struct snd_soc_component *component,
 			substream->pstr->stream, s->period_count);
 		s->active = 0;
 
-		spin_lock_irqsave(&psc_dma->lock, flags);
-		bcom_disable(s->bcom_task);
-		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
-			bcom_gen_bd_rx_reset(s->bcom_task);
-		else
-			bcom_gen_bd_tx_reset(s->bcom_task);
-		spin_unlock_irqrestore(&psc_dma->lock, flags);
+		scoped_guard(spinlock_irqsave, &psc_dma->lock) {
+			bcom_disable(s->bcom_task);
+			if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
+				bcom_gen_bd_rx_reset(s->bcom_task);
+			else
+				bcom_gen_bd_tx_reset(s->bcom_task);
+		}
 
 		break;
 
-- 
2.43.0


