Return-Path: <linuxppc-dev+bounces-22626-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9251CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:40:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4qN2b0Dz3bwJ;
	Mon, 15 Jun 2026 19:40:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781516432;
	cv=none; b=KmNQtCC3CEFmfE4ZnuYGKn4Y+NGlZGj8/FGHcqvMu2o04apnfx5T6kagIpkATMaSvCGhddkkxZ7VUo1vhArG0gl9G779nkxWE0LuIJHMzFoPsCGywlQMBR0dkw7rry61V5lUGaJsnNUQYK3OfnM/TKHXaSf4BgCJRVnCKNq2Lp71ZENdHh33FcuS1nFhqxFQp1eWiQXdMDoGOMvfK41h0g94u+195RvY1+o9rxjKOev+lnpUUgOMF2rbO98cTN0bfRf0QoM9Z3yHCrFW20SRr5tG43KYNunqdZJcoeFHNemSGXj7XAzG1aQZ2qQ0TnJ9tEDDk6zM/S1Z2xoZ636dPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781516432; c=relaxed/relaxed;
	bh=jOhKduHvhhi1//fmQnUUQw/ZgnpHeWjfQ6tgKhPwSdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PndPR5XKAT+a0wUel8Vca+1N9OqiC8miIS2NJMgQ22njGgFF/S4I+xYW3uYABK/sC3KqG2gU8CNlAe0FqrMB4VXFBs4IgMsL3U0NtMRsZMH8Vzyx7wgXyoLFjBwK4Rb1wY3iQr3eXNubY4iP/dqJjwEtu+7SZ2z6xRwllpLS9lV9DAC3wKNxgr3Uf0c1wBFmAKbBsf2/PHqFC9ffY8WCXKLPUrFaK77TnU2vV2dhyaI1OnpaG4Pdsk9xeQNmQGndPtFBnCcr3ZiNfEHZ42OkccJW9en45q6nQ24M1Rvj5lrRUkD9x5ZlGp5XebtkGCtLjT34Xh3r3mYrfxYMkweYtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CRRpWuj0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CRRpWuj0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4qM4YRFz3c01
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:40:31 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-36c68964315so1640246a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781516429; x=1782121229; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOhKduHvhhi1//fmQnUUQw/ZgnpHeWjfQ6tgKhPwSdc=;
        b=CRRpWuj0WP1OSwOjha7GeGJJoPki7JRaYjFBMmrZUV95EGGjTfXAnkRiUNMPaHolMQ
         O9tiyhYfJwyCpHnyISr173xpIAzrjRVvi00rbDKJW5oLjN9ywQrrzrRP/aZTG6AAa8GZ
         kQX0QUCbCErm8bMxZbbOySEDAP9LAaGgE3UVqH9Y6tX9btw8+n/Nufa9I8mhVvLfLSBA
         oMcWehc3hhNs095zOHnb3WYbTMvvrdgSwCz2D8+KE65/xqKIWCOpu1EO4rxsDPR3KACM
         nIoc5vN5srD7sKfdfecRuDcAHa9ramufgzlWh69YgMINgAXxnCga3g6AlL9D4SxmqYIX
         HmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781516429; x=1782121229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOhKduHvhhi1//fmQnUUQw/ZgnpHeWjfQ6tgKhPwSdc=;
        b=W6mPEZWkY58ja8FF4R08X+M9RZEaJQKZxh06M70kWsZxgZViPOUB3QJd+zKi+AYDdK
         nNghTHr4VQlb/aLUA0EVFdypbyEGP3hxJtUo3eiyfn0x5F/Es9Xrl8wUchDlKq0g0+MM
         cEp2CY0YgNSGURIMUus/6iMwRASFBgz1/JwPjD8iFqQENqrJTB0FVsqjjBAM2GG8OvLl
         0ZDQIITcSEaHn5emJg93ZFzGQziDXJquwc1jQOdSQWUh9gSE7lmC0pyeCJWftxklQMzX
         fOsHYLVKy579+sR54VpHFERbPRiuczqtABDEs6mP3PVYiA0YnYst4GdaXqIOpTR1tTu0
         9lDA==
X-Forwarded-Encrypted: i=1; AFNElJ+A0Pq/9dexUQ3tQnhJC2gvOVQtJJ4C+kX1qK+qusKw21vEGFEB2b5eBPcX96mv7KSHX3UHr1Cut9od3S0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxi9m01sOhcgbabsoTiOX436ErRx3N9SMdnnql3zniH9uKY2o8P
	5SMe/LyA2na6KNMfnPW/W/oAuafnV9n9s4FMEr3GR6m2fZzH0bgHx11b
X-Gm-Gg: Acq92OGm/IGa+hPTPU+H2Uazajvj0VZgwN79ppGJapBM4erR1eGEpSJMKdeeyTT+gri
	QBeRs4kyzR/iLQbKAgfs4X3HhU7f6oDvFaMWgP4YlJijY/8enYoCw5fxCTKiYd8d+z5o1zYc7rs
	w5aoB/2Kpm8CRzRHujgI8QoN0PDZ9oyH2zj4PJxr0nWNUK0g+ulgAB0rt6RmBoG3RaQG9dYhEI0
	0Bwrn4bIQ9jE5A0xXbq5mMv+d2XKSwOcnzSZ7JYUYKc9kT2N1fRxU/1j05TyFyVguTgErdxGsbq
	hXxN0al4CA5+wWq7cXwLLLsDckdT7Pem+rSNaPPE2VO+H913uyifFpxQqaFSaCPHrvOTV2zxgvx
	HhUwDyz/lhWlip43oG8Cldnk8wB/KtgUMMcqloAc9D4Z8pHC0J7yLbIFLOCzTUjlnElhfkg6gw0
	U3avNdjVBaTqJdVBYW3mqKfqcoW2OACnyze4NadJVbmC34o+o8s95P6cNwow==
X-Received: by 2002:a17:90a:c890:b0:36d:b680:3029 with SMTP id 98e67ed59e1d1-37a01847858mr14328244a91.1.1781516429578;
        Mon, 15 Jun 2026 02:40:29 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm9936290a91.2.2026.06.15.02.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:40:28 -0700 (PDT)
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
Subject: [PATCH v2 05/11] ASoC: fsl_spdif: Use guard() for spin locks
Date: Mon, 15 Jun 2026 16:38:18 +0700
Message-ID: <20260615093824.115751-6-phucduc.bui@gmail.com>
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
 sound/soc/fsl/fsl_spdif.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 1b9be85b34c2..ad1206ed9882 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -853,17 +853,15 @@ static int fsl_spdif_subcode_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
 	struct fsl_spdif_priv *spdif_priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct spdif_mixer_control *ctrl = &spdif_priv->fsl_spdif_control;
-	unsigned long flags;
 	int ret = -EAGAIN;
 
-	spin_lock_irqsave(&ctrl->ctl_lock, flags);
+	guard(spinlock_irqsave)(&ctrl->ctl_lock);
 	if (ctrl->ready_buf) {
 		int idx = (ctrl->ready_buf - 1) * SPDIF_UBITS_SIZE;
 		memcpy(&ucontrol->value.iec958.subcode[0],
 				&ctrl->subcode[idx], SPDIF_UBITS_SIZE);
 		ret = 0;
 	}
-	spin_unlock_irqrestore(&ctrl->ctl_lock, flags);
 
 	return ret;
 }
@@ -885,17 +883,15 @@ static int fsl_spdif_qget(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
 	struct fsl_spdif_priv *spdif_priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct spdif_mixer_control *ctrl = &spdif_priv->fsl_spdif_control;
-	unsigned long flags;
 	int ret = -EAGAIN;
 
-	spin_lock_irqsave(&ctrl->ctl_lock, flags);
+	guard(spinlock_irqsave)(&ctrl->ctl_lock);
 	if (ctrl->ready_buf) {
 		int idx = (ctrl->ready_buf - 1) * SPDIF_QSUB_SIZE;
 		memcpy(&ucontrol->value.bytes.data[0],
 				&ctrl->qsub[idx], SPDIF_QSUB_SIZE);
 		ret = 0;
 	}
-	spin_unlock_irqrestore(&ctrl->ctl_lock, flags);
 
 	return ret;
 }
-- 
2.43.0


