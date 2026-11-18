Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC4606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rve6b5sW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTy336YhPz2xlY;
	Wed, 18 Nov 2026 21:07:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794996479;
	cv=none; b=CNdq4QprOJGrP9rcJBw1NhE4WL5YethAuzs8rLZa42V2gKvc53FoDMRGojVyOPG5izo2J0q/laNwjdSuplwUK3XN5jXGYinYzeJbsUGj21dn6UgpLPU3sKbw0Mvj7zxZ0oHb1tNJenMR5PtsC3lowRbaDODTaAOWUE8cD8DYSYbjQ4NgPR+lKA7WZ0wkfiKK9EatFxfrtaP1cJuCA1tc48ppytIAEoIKTBUwFogNbPqE/Y0Ei4C4HKYiQmzTFbuPlyUbugNBIb6OnzdHoVEyMrmLzAkO/IAQvqpuCaRqNKL7wCNOC4bzdRMZV+fvT23CKr62Seb/iLms6KPRSqWDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794996479; c=relaxed/relaxed;
	bh=4K6+J+FWfITr/tXSH3N65sGYtsLB/T4KBT20GPIXyQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6pqGlMwkn+aRoOoW/cm3OSbznjnHZP57EUbq2eStG9kXek4dVuyutXG0GrsTuYV4hCC18pWPR5h3k4UkcWKl5J6RSvGEV6L8byMvvG+k7vsPionSPTUFZQIV17qghGurv6vAhAiKQLvi0VtXRpwurCJaZdb0pg/Ae1GNNmBDkhyDTOSKOY3GCtg4LjMujcx0HlV17RTlcIqKjibxPfQxaz7BRjZpmJgSnOieyRaNY9Y/GR4viTsuqL0LoV2kAQd8lByCpwuH6vGwn8B/8U3KTQooavy6TlFS2rZ9FkYDG6C8ytCIs5xXq+fk+pFwGh3GtnngTEt92cifGQyIdus4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rve6b5sW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rve6b5sW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTy323fmhz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:07:58 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2e98798cbddso3398695ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 02:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794996476; x=1795601276; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4K6+J+FWfITr/tXSH3N65sGYtsLB/T4KBT20GPIXyQM=;
        b=Rve6b5sWSPuGrS5Q+s2Ur9ibRg6ibrxqLnfYsiaqn4l9uufTvdbcCa4VlTVoRxFMEx
         MjUm4aU0kg+1eEsFV/hjdjK9nQyaf4v278Ap0xpwWTEPcwYfDzXL09QIF+R1vodsLMIt
         5pAvS8D8Nq/oq15RLMBEFgZgPz625Lc/Z55G1kUrQcyhDXUW9KiwOe72D4WLGmR5Z8Vp
         vB0kDxs/heNX6+Zp5ZXDhI1feUL5IOvHLs7D3Jpxkxo6U/a0vex0qCbe6cjVg16fysn0
         zM4oc5avAUVtrJpnpNAYirs0kQVXNqafu7+4/StKz2qgp0ww8rEZA/4sgddftTMwhzvx
         w4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794996476; x=1795601276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4K6+J+FWfITr/tXSH3N65sGYtsLB/T4KBT20GPIXyQM=;
        b=2SvHFQ7Dap35l4o1wiF5hm3Lg8sNs5WyPRmLncoHY1P3SK1XnhUG6ylNU5JZRjXVLB
         9LaWVJpqzjkFRM/bnoUXtSvkKSC539QZjFD9yvWhoHoUBJig06vLcohOYgHRRiaaebg/
         WSliZfH8w3TgkeYeHr9N6podKFVDsADhtFL4wP3KLkym6kVl/NvA1v8UbFHwA7JFeyXB
         5VQYRRN+gPy2qE4VZzju9g9UWyfdyTx78Aps4HAmJej2UmWKWKY7o8bDNNFX+x0Yfqu1
         p0oAyaZDIQoeJe8iYVriNPyuWE/VNbvVYcEL3W/e8nOaZXgiMO/b9W2cS7TwJOvnhJrh
         Nvyw==
X-Forwarded-Encrypted: i=1; AL+hErH4Yz/p/18MQmwCg9q5/k4FwkM0ou5a/JDhFZUHSB0SjIMgaTjypBXpzWFz+2M+kCzO4kP5JZ/cZdA+A5g=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/KyKyY0RA4biO7nLhiJ/iMEZsLC0Ffuq1FwH2T+lHQk2oMWUW8
	Py7oWkQ3qV7tzipCjlMd8Zv6uFvolSDdRW2MDgV8DNvGAHTfosB5SLo7
X-Gm-Gg: AZFdTZdjWok54bccJ6Ih3goDWUsMwmb9zhm38j0U0EImYFL+0705idVGpyc+AUH6nkw
	AtV4UHU3JKvjQjy1bAXA9Uq9/4/UTsMax65HJz36/NJXmA79LWgxsCe380D4W/sRR3oQEQm/wMD
	xBBrrin9XolasY371SoicLCZzGo4XdHm1WMeOjoswjUxStcubkOcZR5Cpq3fRocTp+wWhAkkHvO
	GsO4PP9BIQBXaZDdQJljYEII1kQ5rsFOn0bR5PNnwXa7B6uKyxEoFnLwJ8qCWTpGsFv1AZcxPWB
	3ZSuGKrcLrIXnnjZc3tvu+bTNUFivml0aC8MwvqwvG2v/Y4B7cUfbwHg4MoyBM8Lbi4xaFSLSVB
	VPyTuCddnd6tOvfS4B7CCcccBH+yBm3EPWxKnGjRKeDpgxpthkdLStqAh7Qqiqld2QWU1dl3Xv8
	OmeQZGzxgkS0RB36WKAgR8L0cs6/zMbcBCxqgLz5U7YTHHHHTMeopb+AHl4TwOJzbAwpxNdhZBn
	ahOMYaByTAeaAB5GRNYfz2G8s+17wv4NIwWfk+PLKvQpDcsI9gX97q9+8pKevjxBoLkEeWSUL83
	fbFpw5Te0pTKXOxDg7it/hzd6tmQDn1uOJLob7mQTqwhfLBdRSi99Jkluwv5ZPhtko849OX2af3
	gwCV/s4Qag2eQeBAsyuUbm9pe1zaBsblZnmct30jPM8IG
X-Received: by 2002:a17:903:1ae4:b0:2e9:d0fd:639c with SMTP id d9443c01a7336-2eff7569fd1mr19749265ad.55.1794996476359;
        Wed, 18 Nov 2026 02:07:56 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6215025sm10634145ad.46.2026.11.18.02.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:07:56 -0800 (PST)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	jonathan.downing@nautel.com,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/2] ASoC: fsl: lpc3xxx-i2s: Fix DMA depth configuration
Date: Wed, 18 Nov 2026 17:06:31 +0700
Message-ID: <20261118100631.26658-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118100631.26658-1-phucduc.bui@gmail.com>
References: <20261118100631.26658-1-phucduc.bui@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: bui duc phuc <phucduc.bui@gmail.com>

The transmit and receive paths use the wrong DMA depth macros.
Use the macros corresponding to the DMA registers being configured.

Fixes: 0959de657a10 ("ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/lpc3xxx-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/lpc3xxx-i2s.c b/sound/soc/fsl/lpc3xxx-i2s.c
index 75bd148c1432..67bbc69dc2d2 100644
--- a/sound/soc/fsl/lpc3xxx-i2s.c
+++ b/sound/soc/fsl/lpc3xxx-i2s.c
@@ -198,12 +198,12 @@ static int lpc3xxx_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		regmap_write(regs, LPC3XXX_REG_I2S_DMA1,
-			     LPC3XXX_I2S_DMA1_TX_EN | LPC3XXX_I2S_DMA0_TX_DEPTH(4));
+			     LPC3XXX_I2S_DMA1_TX_EN | LPC3XXX_I2S_DMA1_TX_DEPTH(4));
 		regmap_write(regs, LPC3XXX_REG_I2S_TX_RATE, (clkx << 8) | clky);
 		regmap_write(regs, LPC3XXX_REG_I2S_DAO, tmp);
 	} else {
 		regmap_write(regs, LPC3XXX_REG_I2S_DMA0,
-			     LPC3XXX_I2S_DMA0_RX_EN | LPC3XXX_I2S_DMA1_RX_DEPTH(4));
+			     LPC3XXX_I2S_DMA0_RX_EN | LPC3XXX_I2S_DMA0_RX_DEPTH(4));
 		regmap_write(regs, LPC3XXX_REG_I2S_RX_RATE, (clkx << 8) | clky);
 		regmap_write(regs, LPC3XXX_REG_I2S_DAI, tmp);
 	}
-- 
2.43.0


