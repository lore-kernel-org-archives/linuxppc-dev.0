Return-Path: <linuxppc-dev+bounces-22565-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AAFCD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:49:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMqN3Hrzz3btP;
	Sat, 13 Jun 2026 00:49:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781270848;
	cv=none; b=PJ0vG8FvMHRW+y4b7UO9prZLe8D3lM9LsJr8jHP2a76NyHsLuuHM24QKMi0JgI8HvGE+rITlffe9G3fTzOZnN8wpAEMzbaoeJ0yVVns11Dkmoo2fntc+dNWHGN9/fzcujZTOmBhZDUVHhZZNxYf+XTG2YkqHbNYY3NHvzSYRks3kZz2l9pb6ZMDNixaIbMFylNGTHN5llyhF+KWTNRAzNo3Kaoxig+8vyVoNWsnHjgkn8KnlHuKkbU7525x79wXuv+T8i2lGx+uXiAQFIHcv/s5KSFpLGo621BUtOQvH4PMuurnNmAx4+sbIScCN7wI6ot7COpJ0jAKaw0nr9o+USQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781270848; c=relaxed/relaxed;
	bh=jOhKduHvhhi1//fmQnUUQw/ZgnpHeWjfQ6tgKhPwSdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0+YsMCW7PJE6QAs0qjlsuUQeHk7EylITldm+oTyk6Nv2W6g4nxAc2b6Na7NwHL7GKi5cU0DSYWMriXMjXTosS3d48ETTwYqX0SJnsquLMN4XaiGLBZbuUUfXQA483DFbvAkYUCze+NcihbsZVGOUDj/3ObBrpR/GB+Uj9YWh1hyYAV0W0J/Dy44pn7FvkCtmlH8L9F5RSYaFDvglPrnG2aLAi1UIKLOg3yfCUlCcj5uWzUhvWwkRcT4iPRuuSa1L5QbUXCel0Z3O6T+0mqIONadw6fBikjsVr5xbom1fEY8QygSFjd1AGJyVqpGa3MxlMtogmzt0UA6n6Vk9LjsxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=llpXYqxj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=llpXYqxj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcL0b0r5Lz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 23:27:27 +1000 (AEST)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-30759632453so2066211eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270845; x=1781875645; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOhKduHvhhi1//fmQnUUQw/ZgnpHeWjfQ6tgKhPwSdc=;
        b=llpXYqxjySm727APEi/1nXRDMmvwXYcVUti7QRB0E4sY8wfa7LV55mappw9bjJ0gfs
         vWHGeJpNIZ4PIfB2xPN57x2hyLxCLdUyW02buW14St8zjFYjdOaFAnp514xC+mblSUiC
         YKZ0Cusvx052CLDPyUl7EpPXllEgAq0EpDw9iX1FYodsAQ6qso3S/R65V26BBbkknafI
         eByXazpH4F3UWJRU2xAbciWANe9UXG5PVJxLaYlS7bWqxoLsK5e8MebL92TLxjxb7Eyp
         dfLOKMLNc7qnFs3qOFf4UL6xgG1l98aSgN9BR/fogpdoVvmheTM6I3wy3ylVKJFMv7qb
         WUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270845; x=1781875645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOhKduHvhhi1//fmQnUUQw/ZgnpHeWjfQ6tgKhPwSdc=;
        b=Ew+VcrmzuogII8geUYx/NrOVp+XA05A6sLRwyvUxUe9SAH5epDalWCD647D6mvzc5T
         t0llAeePSYJFxSk6Ld00sILQqs5m9OzmVtvV74NRfq7y/ncLwzP2/FkaZUSrTvuSlqS8
         XdTRbEFCK5mTs5utshb7PiG5RFrFQb0dqnWD2edYVY7roCLrT1uwGGv5XGZkecVDGB42
         FGRmXwMcd0SspZqFNm0d6FDGkQ9G57+qcEj/G6wEZfBbljXtvhScbzQZ2w1FJIGPf4SV
         oxbpHIH7h8M0O/vDn/LiYDxiysAeSRJEYYiirjEnkqSzRmi9cyARpnFa3t7kcKfm8Ny9
         SRxA==
X-Forwarded-Encrypted: i=1; AFNElJ8dEBYOFur8yBpOEptB6WdVh4gm27kIx1w4LSUgWMhB1TZLzFz7cqZ66udKcpi+Ingn0p8kL1Hf9jlK5Ls=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy8D5wOPEI3TX5RZN3RHCG0F4jFALasU+Sci4n1AzAZOgwD83nE
	WtdchLSBQUS5HOZ1pzwuGDmw3lHtAS8ISILVs5jCDfS4H/llOssDPDIX
X-Gm-Gg: Acq92OHD+GSsc26IySe/9CpcdjB33iQxDf62r4bhMYyvt0tNyFqOMOmOzhgoy1SDCvT
	eJpD2jjj0G0oQBZk13OHbSz3Jv7FbEXMUZQyaB+UK2i7Aqtq6juytniSMuIaeHPQCAn0WagEty/
	2kXlOkC3jgVX6k2R/RD/CtWK+o7g9eexxL2FBdRkeccVd3q0DP+A309g5zGYFkyTvrKQlPyxF/y
	+Np/i65g2r5AmLlvCf+ZCAu6oaDuRddx8zJSvOlKSG2wtk3lQduJYHLYsjVRdfJ1C5K+XlChH7x
	R6xlfJYN5dM2K5XFweuh8MhLye1xObApXQjZWazx26Z4pmBWq0xdiiyzYl3tR58A+yQL3TAAUeS
	d4q1kcLjwHjSE6HPZG2jNAahhchSpjSxUZDjzt5xSytI2lNXbUPrVMpUT2UTJ3zVcUvVCYNQWUy
	iQX1rXyGrwXWk2BlnV0Hyh+lmSwi5LQJx7YZbkD1OERdFcdvin0fxQo5QgrDjhjvUB3Itl
X-Received: by 2002:a05:7300:2148:b0:2f5:5dd3:1fcf with SMTP id 5a478bee46e88-3081ff97b78mr1839542eec.10.1781270845378;
        Fri, 12 Jun 2026 06:27:25 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm3302343eec.19.2026.06.12.06.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:27:25 -0700 (PDT)
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
Subject: [PATCH 05/11] ASoC: fsl_spdif: Use guard() for spin locks
Date: Fri, 12 Jun 2026 20:26:33 +0700
Message-ID: <20260612132639.78086-6-phucduc.bui@gmail.com>
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


