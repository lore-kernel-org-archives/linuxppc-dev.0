Return-Path: <linuxppc-dev+bounces-22571-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF49ACD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:50:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMrP3NTLz3bsj;
	Sat, 13 Jun 2026 00:50:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781270879;
	cv=none; b=KYLMXYRWj4aUCEP8ZuvTRjoXJsGV6HY+K1gnVkgtOQR/SPDnhgKhETfNoCXVJ+BjPvdDPUt7A2CpJ39K7BJ09/LodvFgRbjumnmkZmVvXZSkPsjK/bxhV28iVRUKXTXLegVrNXDgMSH/nSJskLVeOCILLVK0HJPj5JR9x4Wd4RwQnzAUedwnHGVAXyLXAUEwQk/ek5AF77qAzxeuJwvJf7V5yLJ9E9Y3/Oen27+RbHzH9Q1tlZ+aqd4ilbxjVrfPfYZu9Dy3iPs5Ap14Vza/MHr/ycrP7/8XXg2I+C1gzFfueFSgpGMrdApfsYbXxrpowpdh0KSJHroYmuEBAaUv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781270879; c=relaxed/relaxed;
	bh=n5EcAgUJr/miZOm5euArTUYqCmQuAK60NFxSW5E+pw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQR6M0xdFjZmDqxxZ4Ewo6oQFyGVDUnNxYWlPrDUZ2cd7r54zHII3N7MfkmpqToEKUiXuS4Ee+uJebKpiWAuQqszhpF9SMC30vrITJzS1JoaUT17TcG0SsMscw+zJ0N4OY/QJW0To8KvvO955z638NsM48JF2jF/xL7qj2mbiyhd07r5FuGyy6CjcR9EcfCJUdPXS2UPfPkBYj1ARYF9ZSkY+bqdfg/yUIpUBF/A5WZayi5MBy/qkZFgMOXal768nZqiaSxtuMrZVjFXOLyOt2sCy8N7HcnpcFUmuCX2ihyCpO8jgOs+Oep7CIJbBW0zg86qynSE8Qi08Xk1uhQ4Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qmATI9wv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qmATI9wv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com [IPv6:2607:f8b0:4864:20::1334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcL1C03C7z2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 23:27:58 +1000 (AEST)
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-304ddfcf72cso1217707eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270877; x=1781875677; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5EcAgUJr/miZOm5euArTUYqCmQuAK60NFxSW5E+pw0=;
        b=qmATI9wvi98WkWMma6dIoUpki2rRJZHMLIufuFtaFsXVO3a2uejsED6+fh7ko4DuB+
         RF0CTxOlS1ZYEGJg6iUu5zVbsBXUik+QQeHjeRogxHwc/sXwLM8Biyc3OkN98P1PhkXh
         7IgBUqJz3cDBQ2OCEQBB0dDJyIQjkPTPOwNYWLObX5kosaKMX5p9O3x//FJDAdsmoYXJ
         G85r3dGMrNUY8oIL0rSnQvkIWTwIeqMQHAYQKNLWW87dbzmZIIAU6Gux04SDphrFzz+S
         YbCuKLJAfM5GBTkbG3MuYQA78IuwRJEmIikZimMLRKYU0gRYWbmYqzmoh4oZyZgn4AwZ
         ue+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270877; x=1781875677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5EcAgUJr/miZOm5euArTUYqCmQuAK60NFxSW5E+pw0=;
        b=WA6nGF/NdnY/7WEOpZw0M74TsQw2FjF+nSevkVHJJw0mZAnTdYRaHb9Ji/I1eg0qyS
         NS52WAj24biAiN8Lm8BAY+DHq3olDk/LKjAQQG3nlYVzXjF3Hq7FHGOf2n7SEluPdKNK
         k2R2iIZZz8BlNOZD9Ooa5c1G2t0KdNCJXFCtyfpqzN+3ClTHKEYVWJgU2/yjBY9mQFfV
         sCs8mEkTqW0Y0fDtYgO+aIvd3jgJB/N77UwLb0RbpDGiB6mO9kD4EnHUwAfhoGIYmh2V
         qqYcih6QWnWqhWgDLL4xX3gYq865Fu1BdA0TL8/DPUE6o/XyI/2eBSjIiwEWEodn3qHr
         px4g==
X-Forwarded-Encrypted: i=1; AFNElJ+FWt+Gx1/X5eaDS+03yyIBxvWYWWpjBLUYgjG9UIThVepqdy/v701kXJS3+kCE42oBbqyK/ymhU9Dnjik=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzjEM72Vdzju4/jjAf3V4VfsqCK5edQ5wd3J1O7oRDVJePDxt9P
	SelxREYQ0usBzzgpxJyN5u4l12Q3CypND5QUfR8zltfvMxfCbBOOfwGG
X-Gm-Gg: Acq92OFFW3uZ1CLFktNWWeDms+rQ4IrwI1En8vF5D2EDOuCfKI8nsK1o7bl9ufdNcqj
	CyeLd4fQ/UE/K/x0HhW0yNZxuEC40MS+ZLzVjvrgcUtpC5hVrShFMT/fYfIXVUi4snlIchnk9zp
	7Rdn973aDE8MI1X3V4jnz4efPV3UZmYNK1CmFlvgGf84YpjTxrSRgMah88rezyc6T5O5QlCbdII
	jaaRtn7eQ+EIaXaoiL2THmfQ7V2jp+p0krttplr/ikturywh5inlW0Zv18BdV+UMx/omuW6sCia
	Mikx6CvPBtjODsLf0IuHi91B5EgPChtZet5u3xymuVZa1oO4B4v28WRB8g0foYK1ePPt+EL9cMl
	A5PSuwgyExtHG2aFT+wRTYj3A6bjEy1VaL2p3fqlQosVZqvxElYEd2DGOKeuopvht8ARXMbOxOR
	XBjIv3m+P+W25VmpvY0N+45vV+V1ffAxxeqFCeEk51TBl569coAr5tY8JqhQ==
X-Received: by 2002:a05:7301:6083:b0:304:2eb0:2726 with SMTP id 5a478bee46e88-308200a883dmr1707604eec.25.1781270876974;
        Fri, 12 Jun 2026 06:27:56 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm3302343eec.19.2026.06.12.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:27:56 -0700 (PDT)
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
Subject: [PATCH 11/11] ASoC: fsl: mpc5200_psc_ac97: Use guard() for mutex locks
Date: Fri, 12 Jun 2026 20:26:39 +0700
Message-ID: <20260612132639.78086-12-phucduc.bui@gmail.com>
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

Clean up the code using guard() for mutex locks.
Merely code refactoring, and no behavior change.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/mpc5200_psc_ac97.c | 34 +++++++++++---------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 8554fb690772..80666da923d0 100644
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
+	scoped_guard(mutex_lock, &psc_dma->mutex) {
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


