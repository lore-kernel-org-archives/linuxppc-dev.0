Return-Path: <linuxppc-dev+bounces-22631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898FFCD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:41:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4qz2YZxz3bxH;
	Mon, 15 Jun 2026 19:41:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781516463;
	cv=none; b=GFJa2aiXKVkvyD6OIXVBI4Q5xiAY8WCMwz7cbpSd+M0vIDjO4ny9QB0PUoeTbVh0ryagrY2o9Q6mdHXrkJ/vZhSOelK6fcxHyTkPw/hYej9CxhOXZ5rKgRBx7gmJlkO2m9A0/cT6OlRq7Ek6Ypv3nt9QzKAS/mXA9MAVzFeuEFQRQFWMNlr8G/huYGs3II/356VjGf0AcM5MmaBYpAOQ5Vke+fEksBAn0khp/v1S18Zb0rdXKChzlWFvkjFGahZ1xhByEvPkf0IzV8h9qlpNhtf8d94L14WTwzVcPda8o0n0tyOeNOpnpKgnLq+hJhCNutflj3xDQlY0J0/8GwtqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781516463; c=relaxed/relaxed;
	bh=fixiw6LCSjSy5TCm86A8JjKJ/P+woOFTUDHQjwMDfTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnsSG5bm+2JJlJdfW8IlK9vhc/H+pDhpbNeieTeHXZHbi8vxaM9yEMaT1UzFO2b1eTrmZtsJ6SxNAOj2Z4syyOZRbd1FYdDDX8+GB2pPeqEo/89kCkSrlR1r58dw4S/rqaXLD8I5LOvk1WJt/d/Eh98rssE1D8duqHt6XSsohjSuTTKOpxFmqmv4DaYHiqhto/IyAXX1ijHwqDovHMGBy7Tejb8AMVBJLpZkLfItwom0pT/Rtf9qLVD30SwvZ8Fv5/VF3QpD03wqBzT4zowuAA/CMDHsxPFnL6vTpSOtVkwO4vWcN1Qz7WHB7t4FAAw0fr8+QjeRshrQfUDjERdwWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gEWivWMo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gEWivWMo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4qy4X5nz3bx5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:41:02 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-36b9d265355so1435884a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516460; x=1782121260; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fixiw6LCSjSy5TCm86A8JjKJ/P+woOFTUDHQjwMDfTk=;
        b=gEWivWMoTX4uUuwEldWtYg8KbjZaPm8TJ0ZV7SPaMCWMUYqNFI3wNRxMTTCuf8xsRH
         Pgt/+br+fjvcBI7I0+dufpCghEvrosaUmUM2qtuQTAr6mERyjYIixTAOB8WIAq8wVq+r
         CSbyV1+3MFxoESLcoTKB1W7ZHQpaUnb1+I88FOT5DQSduSfraLvsHbECr423ftCCgcBB
         Ma3dDvpEkyzLg+AFtZ5nA63wwjONTxtjWLRBTpoAAV6yR28Px9Vrwt+jX6x7KRQCOkY3
         D2Vy79qYEfIlKdHbFtowYm7070ZOcd4YNWz8cCn/8a79tIbYdZc4Qz0laQSLrwlm+GBJ
         h6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516460; x=1782121260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fixiw6LCSjSy5TCm86A8JjKJ/P+woOFTUDHQjwMDfTk=;
        b=m/wDsblZRgDrPIwkMTCLVHGGwhbMlKzmKmgCDc4ElUp9HAj6OFvcnZGOqGJTJsrBIW
         UNx8cRbxiyVckAnUUdMxoiuyNbdh3h/H3n2sdd1p96SctmZMYcHKSe/riaGxWKLmGyCe
         8A71dX+VrSSTTnNzmotQsRsBQdSZ+E7GuvHq2rNpU64PuaXAwHuAkgqXnQnbqaHvdk3G
         llrVL3aDtJDaPaZMOU43N4gkjCeBcGJj4ieCBZE0+QrNd4i53o9eWLn93C8PMCxEz8kI
         iLNzYs+HKNVqJZ3Q74TAOMrAlUMyXCZ6Iynhq1sY++cpDoZsbSRjCK8QIdxaEqAWmZ3+
         8bOg==
X-Forwarded-Encrypted: i=1; AFNElJ9TAcbQEV+Kjd2OhAyKtWbtJv/s0at6/Vc3CaKYdcj76xsbcKn6g6HbI4PQgInAdbqp0XUVFJou9X59fi0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwaCHE+zfz3d66Fb461JEF3mniIIWdof0qFV+e4fKPBzOKOLxf/
	/pmmBFleOWsdanYJvWX9p+WcYTTxHXnRjgjztzw+Fz1uy+BA2GMCrI3e
X-Gm-Gg: Acq92OHkDdd2HXlq+wCQtTYkv2fy9tT+WpX4PDa8G2aGNWY1rz91R/KuEGJKIgfedVq
	bba2xQFzys380YscDo5RsSE0+Nzl6dFPM3qS4Mk/IcL+Yb/IfYbq4gupzhNhx8KVBlzDJ9DKZJd
	FvyaWIxc5bP09+N3WtlH92ImERGvL655g5CsJxGLIbL+FNQ+Qxsmy2DWbrFI9+KhFxQ7um/cmKE
	GsAkx9wssC0HnW5fhxfgz9NWu7DoxnWokpQNGN0tL6evflxrv8kDnNgxEksrQsttAFNZcmk98Lz
	vDu2g6EWhWRe231NgbwG2TNQ+Wwr9bQ4L4p8t37CVQBOelArBeumyp5kvayKG6iuQGuIK+fYESp
	GY7muMXuNoTJo9Gft+dhZ5uvjrCrc1vJ2ozB3OOz65pUP9FDomEca4JKBzeZGGWNwbh9ADbQxTI
	MQ1Rr51YTAomSrGfxk1kgFRVp2uwNgZH4QZBrEo2jD1Nj/KA7oAxGWn06EMIYn+jmcT+XL
X-Received: by 2002:a17:90a:d004:b0:36d:81b3:61a1 with SMTP id 98e67ed59e1d1-37a01c34487mr13541493a91.7.1781516460544;
        Mon, 15 Jun 2026 02:41:00 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm9936290a91.2.2026.06.15.02.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:40:59 -0700 (PDT)
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
Subject: [PATCH v2 10/11] ASoC: fsl: mpc5200_dma: Use guard() for spin locks
Date: Mon, 15 Jun 2026 16:38:23 +0700
Message-ID: <20260615093824.115751-11-phucduc.bui@gmail.com>
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


