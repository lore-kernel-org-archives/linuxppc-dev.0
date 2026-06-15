Return-Path: <linuxppc-dev+bounces-22632-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F4CCD98DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:41:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4r53QLNz3bsy;
	Mon, 15 Jun 2026 19:41:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781516469;
	cv=none; b=Y8oSMOYDpmzkM0GsRTThkDBXrFHtG3eY7Ugk0AiJ0bTU+BKtsy6x6aRBOozs2I6qo7yL2HwbpfMQolAj/T2ITlxKg56rzwT22LwqHz+1Km47YzmWbXzj/9ovQdzLcvq8lTpAGJUewBFnVA/MuINaFPJvfw/ke0l02TYgo0/v5r+3RtbfdbtLyU959tLhCtdDjd1wEz4WtFQF8ZmpelPTLfweib71nEmIs8XrmpIYEU91hD3w4UTT90W5GhRgBx3aLAtTsrepCDCvsLXjgkH7FcyV6dY6qvH8lvomlA/Qb0H7Umrcvf/PFXqCXRhni8tDYLBZSC0Q1b1WFqzuRFT3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781516469; c=relaxed/relaxed;
	bh=NnE4Srd5uTTyhfuQp5PAjqJfajCDEXq0juLBDGnU9sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM5YD9j2V/TTBp2z3f0TObYhoynPh3ZoFGtI2h8afXUaEPk2TSVzuvE1/ERL4mUu/tp3HRkNECJBvlXrERLyiNKjOLejnvVm0o1W5ZMqAWRdhza5j1F5sWo+ilaNlPtXznxOzNFVl4MsYu6Lc2mZY1UtPYd1ZNTBkS40m8V29BpBuQ4pTDVF5/H5JHLPTxY71Zo33x1EJoH78Ybu2+o9Tkl/7bUoYlAjqnFK0De8mdTNRKSmsQu4wpU/lWQg1iNuWIY/Y61SKEdXm7aapavoDvnHzcYvVxYasLOHqM0ip7Xa/KkwwVokehG9P0Ds9L7vKbVZAahrXBi7nqnBcBnovA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QKYUH/yU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QKYUH/yU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4r450DJz3c86
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:41:08 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-36bdb11bf8bso1631570a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516467; x=1782121267; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnE4Srd5uTTyhfuQp5PAjqJfajCDEXq0juLBDGnU9sg=;
        b=QKYUH/yUOUtdGS6rVWiK+or9MEho6HVQ8qRI67UnfsKX0vuEEIWQdoNSgYlPDeIjm+
         r/YA/18FP5sljvzXfBoe7BAkoMyP9HSAkOycKHa6pp9fZ+cJ5IN64uWb6ANUWiUm6Xb8
         7C8c+RS9PaFnvQv44yT0kU/RUdW5bUhlxUfUmZvMXiQAGr1+VVf/Mm5pmyRfvI+Vlxp6
         Q/T1dqndMFfsXbTfvyXpnaanw+Zdqci6rY9x3X3b+rvaNj9fI0Y6H+a63uQLBi5HRMW8
         LnCK+TKPCP2frwxuGua8UxNxn0zWvhcSDL/UJj5q+NHXEGxok3zACoFaRuaRQDIU9fyd
         bbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516467; x=1782121267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnE4Srd5uTTyhfuQp5PAjqJfajCDEXq0juLBDGnU9sg=;
        b=Ga9je/vGjnbBLoFuy/EogdiedXL6D4FVe7UWop0SUUmvF5AKB3okOrbMy3oMNwlPxo
         nXQ6VNMwTpqM2knzefowoQJx59K1n/6PDq585htByV/AaXUcFshvGBw49TSgAioGMWm+
         vlf7kgLR8fP8bdL7k1Vi8LZSFR1lj2EKlYxATmBhrkvMRx1RJ8cf/Ez9w8iDTGHJvAF7
         FrdUUya8Rf8b+AjXKtFVsTRyQT9vJkJp6SvjTdzV4ky7YQu2AzvTe4gyc3hkikkGERCi
         e8FmEMRxv/3rpMdDjevjac/sdmU1/e44gXjXKkR6Uv7hdtr4cyvgSzKutnyutX908l7j
         97rw==
X-Forwarded-Encrypted: i=1; AFNElJ/o1FW35V3EfezDQNOzZZQGZXR5r4X0lTIWnzQv5oO9C7hVR+0RwiYJOVXxe/2VcbFr7FTJ8BYQiLtwCL0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwVJmASPtwiYIaMr2Tu6RNn885MVapPcDByFe0cntzayb1tQz9/
	2aHU+zJ9DAIO21XJPQJX9tIC84+unf9wG8TXVsylzHLikBFuS1I5l2QH
X-Gm-Gg: Acq92OE+07/c2CQtlOa2LZ9v5dBy00pS5tA1MTWfF25+4lrT+Ozz6M4LAdhz6Mfubso
	GqOXy1kO+1WKGb/WKAi6Du+FaJPVWaxoTIfE3DGU/ISXIRX5K2o7pqkuO5vQ1baIvrnmoN3dwF1
	41t8K7xME1iQAXXAkkKES6NK58QTNFPet0XJKqAZdTS3m855ONnr0gdRZ5HePy9iSKQl5EdlJwF
	eeg0SzhdYXnyaspDh0AOt365f2H8Cxuv61ypHufDH+n9IdTyQRROnS77wGgBdBDlIymqH76G76F
	Mt4WFXdJwKyDqD8BM2MXzSgwiHKzVYf6V5bz3VHMFkTBD36UwgpstrZLSJ4wmrMBdgch5TkcUWZ
	wukyWXXQUXBQsrRE7yInneIQO2LLQoIr39fTJHumRQ/BolRV2IiVNYfqCihitSUb2O22QzTyUMr
	tEVI2FExELTy1svMxwLNcpPmoC0grZmaOWPA6UoQJW8enk4yGZ4AD6XW1goA==
X-Received: by 2002:a17:90b:4a11:b0:36a:4074:9aa6 with SMTP id 98e67ed59e1d1-37a01b3f8b6mr13135815a91.6.1781516466932;
        Mon, 15 Jun 2026 02:41:06 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm9936290a91.2.2026.06.15.02.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:41:05 -0700 (PDT)
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
Subject: [PATCH v2 11/11] ASoC: fsl: mpc5200_psc_ac97: Use guard() for mutex locks
Date: Mon, 15 Jun 2026 16:38:24 +0700
Message-ID: <20260615093824.115751-12-phucduc.bui@gmail.com>
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

Clean up the code using guard() for mutex locks.
Merely code refactoring, and no behavior change.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - psc_ac97_cold_reset(): Fix scoped_guard() usage by replacing
   scoped_guard(mutex_lock, ...) with scoped_guard(mutex, ...).

 sound/soc/fsl/mpc5200_psc_ac97.c | 34 +++++++++++---------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 8554fb690772..d4d9f5b6bc07 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -31,14 +31,13 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 	int status;
 	unsigned int val;
 
-	mutex_lock(&psc_dma->mutex);
+	guard(mutex)(&psc_dma->mutex);
 
 	/* Wait for command send status zero = ready */
 	status = spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
 				MPC52xx_PSC_SR_CMDSEND), 100, 0);
 	if (status == 0) {
 		pr_err("timeout on ac97 bus (rdy)\n");
-		mutex_unlock(&psc_dma->mutex);
 		return -ENODEV;
 	}
 
@@ -54,19 +53,16 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 	if (status == 0) {
 		pr_err("timeout on ac97 read (val) %x\n",
 				in_be16(&psc_dma->psc_regs->sr_csr.status));
-		mutex_unlock(&psc_dma->mutex);
 		return -ENODEV;
 	}
 	/* Get the data */
 	val = in_be32(&psc_dma->psc_regs->ac97_data);
 	if (((val >> 24) & 0x7f) != reg) {
 		pr_err("reg echo error on ac97 read\n");
-		mutex_unlock(&psc_dma->mutex);
 		return -ENODEV;
 	}
 	val = (val >> 8) & 0xffff;
 
-	mutex_unlock(&psc_dma->mutex);
 	return (unsigned short) val;
 }
 
@@ -75,52 +71,46 @@ static void psc_ac97_write(struct snd_ac97 *ac97,
 {
 	int status;
 
-	mutex_lock(&psc_dma->mutex);
+	guard(mutex)(&psc_dma->mutex);
 
 	/* Wait for command status zero = ready */
 	status = spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
 				MPC52xx_PSC_SR_CMDSEND), 100, 0);
 	if (status == 0) {
 		pr_err("timeout on ac97 bus (write)\n");
-		goto out;
+		return;
 	}
 	/* Write data */
 	out_be32(&psc_dma->psc_regs->ac97_cmd,
 			((reg & 0x7f) << 24) | (val << 8));
-
- out:
-	mutex_unlock(&psc_dma->mutex);
 }
 
 static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
 {
 	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
 
-	mutex_lock(&psc_dma->mutex);
+	guard(mutex)(&psc_dma->mutex);
 
 	out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_AWR);
 	udelay(3);
 	out_be32(&regs->sicr, psc_dma->sicr);
-
-	mutex_unlock(&psc_dma->mutex);
 }
 
 static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
 {
 	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
 
-	mutex_lock(&psc_dma->mutex);
-	dev_dbg(psc_dma->dev, "cold reset\n");
+	scoped_guard(mutex, &psc_dma->mutex) {
+		dev_dbg(psc_dma->dev, "cold reset\n");
 
-	mpc5200_psc_ac97_gpio_reset(psc_dma->id);
+		mpc5200_psc_ac97_gpio_reset(psc_dma->id);
 
-	/* Notify the PSC that a reset has occurred */
-	out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_ACRB);
+		/* Notify the PSC that a reset has occurred */
+		out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_ACRB);
 
-	/* Re-enable RX and TX */
-	out_8(&regs->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
-
-	mutex_unlock(&psc_dma->mutex);
+		/* Re-enable RX and TX */
+		out_8(&regs->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
+	}
 
 	usleep_range(1000, 2000);
 	psc_ac97_warm_reset(ac97);
-- 
2.43.0


