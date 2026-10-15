Return-Path: <linuxppc-dev+bounces-29529-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64163CC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:47:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rYP6WQBz3btl;
	Thu, 15 Oct 2026 12:47:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028857;
	cv=none; b=fr4O4m6wWog93pjqhYDSC1tZh/KU/lyuPrf6uxFpfiYGX6zGQZlp2flnq+deQ20qecdylKIuLYR9GB4RvagNnmqmgTmvuiJeNj06MLXzTnCGWIn1XXivbAmvyVkHXJhtJz0LQiQbDe++saeuoaDl2FLH2K8mLYjcxXm+qHc2/DJlrt9bqN7cuh0cQSnn1Eq7NcHWsBhvSRmZbOTvrxJO6WyEPA9rNKcdi6FCgOG+mNWW4mgDRVd+/tJalJ4X9e2W0ubgadbtyKA3o2rOeOjVGRlqo72wNs6HTnlZ5xYjgp+D/y3XJyTQ/9hR9Aw59htbcRA+SfjiHUVBCztgslW8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028857; c=relaxed/relaxed;
	bh=qvYpMSlsoaD702JqdWz6T2bQ1dialbnMpsVm+cSYlj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWXWl6A+PnhZNmUd6KyCvNTAdsNw0iWa8DlRJSlK1nJ586igc1pvEhas2XGpAPOkotYGRVIadK3RMP9pA+6WP4f75qISmgqByWDwDoTGtK54w79mdhZtGAYVP3c6m5c3yyKmEGQ9xNQeIgVp2wKdZscuxKJm7tMw4hV/9/ZjwruqiwWdHI4A8Of+z5k35lRUPdoi2GABELFzekByZtwmfUZuUtRqUp/3UWPT6icSi1wpAiAtMURxRXrfYRCgSmEgVnW0hLojJODKDidwSTSBFzCjE7wHFt/3mnDW6DFOD134mVcT1awu/MYJDlgEJMEMxQOYEuiUYrgC/I0jM8abjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M6Sm0GXD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M6Sm0GXD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rYP1yZCz3btZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:47:37 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2e86dce4510so24249395ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028855; x=1792633655; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qvYpMSlsoaD702JqdWz6T2bQ1dialbnMpsVm+cSYlj4=;
        b=M6Sm0GXDQMW3R5i21DG5N5xPazSTekhwnqRiAgld3s33K8B0YdCIdico/rHaqxydsP
         jU0G1Vzw5LlzD1ocs2Z+yJ2ZKa2b2pnZd6fpFk6JqCn9HVv5oNxZ/LaxCNRVUA3BFXHJ
         CL/UDrq01PnoG1MbNYSzNtVl6Y9xxD9QEJY+RvtJeNBYdJ0sbaB7eeZa54/947khItAe
         Ixr+3z2WtBTypGX53V2IIVPsd+LrcwZhDN52FlvLAcE1MGslC/MDyBA9PFEfN46sbHJQ
         Jph8yb9dOcB0KIaFZ/6pEacpsKgpjAUN9f57CFjoB8ut43Ij61u1CLf4F+6Ptj52Aver
         tkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028855; x=1792633655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qvYpMSlsoaD702JqdWz6T2bQ1dialbnMpsVm+cSYlj4=;
        b=zqF7ZbSuwPcQw/EJ+c8uTz99ZgPTdsfkpd2qyKPM8uhc8tzYfXvAZBsxJGQ+pJZjeX
         oHFFJNW6KHiqRBgMAQs3PYbueRSTLjlorMQ4TttFj6E+mTDBLa+wx5Lh21Egli0ewxUS
         ITPweiURx9wPMotnaAYLmuyDKvzxtOmrqNPcQf1PF5cdbkIC+Aam/J4dETB4pmGRvRYY
         95ff1L9huRgbRWYPUvsWTjsWRlkgjYVOgbRSr12KPWMUOjfHVqHK0ocZhwbrkSpzKdTh
         fTXu35LW0OoD8B8xZbFgGgP2XbICUIpOqvvB3uJ8wZEmdEWI+oppKevQY8Um+NYgdgSQ
         pRsg==
X-Forwarded-Encrypted: i=1; AKwUvByI66lM/rWiORydwWRZV+uMvX8cTM2iyVzOYSRbmIbEB+W+kpaTYEtxo81cTduPGty5MjAwH99o+XkqKpw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIDeZSfCUAGF9szM+YbWiZwwxnfAeZWSdO7p//ohFFPFvdS2Zrx
	YsCtCfTBZZLZdfJaGO/yWjmHSszBBshtZf0jn25VS+Mz7oADel2X/D+e
X-Gm-Gg: AYBFou1hn08Jsc8U8D/s5/htmNKSqaAVNwYfU8xdxFJesK2J+vcQMN3or/W9uMR9mG1
	tbNjJ0mXvrnYFLAGwXdSx53TPKNpoOAAep7utV6ljmyJUmnMYS0QoieMz4/hlxAb9u5ZbH31dJ0
	CPIRyim6dupUIFHEiVAjw4MLg7h1lvanLHXwkW2WPApxPdWnVWHgCOn0EA/baFxTx6/+KVat2FO
	DvgvJHHQybbW25D0yhOExszWun/K5y9sQsu5bJDghi/6BLOwKGcg1JEhzcYMspQH4703C27cMEo
	4WI2wWhMxwT0WaEwhNXzU5WUydYEMoUYoKPfIoIZWNeOLXIMJuAOktsfgVbddgsushA6d6q+6je
	419k4DxKtL9PajgmkaabONo0piQ3qitgSWAxtl+zdDKiWPih3HndJlyWdiLBvNiPs0SyKt2SURP
	az7Y+Ynu2pOel28X1DWZnS0zPHQWOMXi73DeNP9ZzECBKTnkyvLRyEPS/xGEKL9JGhaxa1cqGG5
	F6UL12UFKcGx38y7eynviXsD/FkYbXgcTUMgnzxqrlKrV1DlGozouAt8FR/SGINCPQfmh+t/J9y
	4ZHhtQtTGaDbBw==
X-Received: by 2002:a17:903:2442:b0:2e8:422e:19c5 with SMTP id d9443c01a7336-2e842dfd28emr133980465ad.55.1792028855139;
        Wed, 14 Oct 2026 18:47:35 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:47:34 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	povik+lin@cutebit.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrei Simion <andrei.simion@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Kees Cook <kees@kernel.org>,
	Syed Saba Kareem <syed.sabakareem@amd.com>,
	wangdicheng <wangdicheng@kylinos.cn>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Neo Chang <YLCHANG2@nuvoton.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	u.kleine-koenig@baylibre.com,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Md Shofiqul Islam <shofiqtest@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Zain Aboobacker <zainaboobacker33@gmail.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Bo Shen <voice.shen@atmel.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-sound@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	patches@opensource.cirrus.com,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 13/25] ASoC: codecs: nau8821: Ensure the DAI is marked as started on success
Date: Thu, 15 Oct 2026 08:43:12 +0700
Message-ID: <20261015014324.5569-14-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015014324.5569-1-phucduc.bui@gmail.com>
References: <20261015014324.5569-1-phucduc.bui@gmail.com>
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

snd_pcm_hw_constraint_minmax() may return 1, which is then returned
from nau8821_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as nau8821_dai_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/nau8821.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index ecadbaee1037..7b88ee3159d1 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -829,14 +829,24 @@ static int nau8821_dai_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct nau8821 *nau8821 = snd_soc_component_get_drvdata(component);
 	const struct nau8821_osr_attr *osr;
+	int ret;
 
 	osr = nau8821_get_osr(nau8821, substream->stream);
 	if (!osr || !osr->osr)
 		return -EINVAL;
 
-	return snd_pcm_hw_constraint_minmax(substream->runtime,
-					    SNDRV_PCM_HW_PARAM_RATE,
-					    0, CLK_DA_AD_MAX / osr->osr);
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_RATE,
+					   0, CLK_DA_AD_MAX / osr->osr);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
+	return 0;
 }
 
 static int nau8821_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0


