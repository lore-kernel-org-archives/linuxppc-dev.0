Return-Path: <linuxppc-dev+bounces-29533-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B9ACC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:48:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rZq4K8Hz3c2Z;
	Thu, 15 Oct 2026 12:48:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028931;
	cv=none; b=IhkZ3boNQPiueJY+qnsW0Xlk+K5E9TjqkpY0T4g5xKwwyJvnKpMMR7wscB+0DHtGQD3Gn0sdB19TB2vcubUmvyLejtXTnAHuGS2CLiO8msT7D+XvwjHW3P94LLTNefABmhq2h1hiZpAq2Bfj/NgXF5yxUr0KfPgV73aC7VnoT1j66nmlxtWdmHqQIvV+qBNKG+BlAoJ7L54zx1JOOJ6Hz6J6XGGs6MiHClzm4ly4ZpUI2hPDa8T8vMLqzMHG6q4y3tMFOhtcS6YyuVGEMw/7HweVPZKg7CDDzcS9/6OXlzeG53vs3NPXf/7XfhPQz0x+hwLMuoTHaWqAb34k34dGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028931; c=relaxed/relaxed;
	bh=yU/tI1b3Chy6tvjhfXj60ZgAk9bekyFoLKnVljFmz1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ajh0VPW1A5RhwAQxJM/tUmnaK/snSNW8wZLvZf97so/yZH7xNh1V69g5F2B1j6Hj9eygqSFkw49Kka1WuUlGYVg+xFHbZtE/yPXECoqKevQEz6o7w3olTchSWvA96ERRuB5gqUH8qf3JZiFuFcruW1WJCtK4Z2shcD8TRfNPzHHeR3db9WilHncHn/qKFIwJ3ws3Oy7nnnMeFtHxMwpdbaRFNucld/eX/eB9pue1Ss71HzZv4pMaC4/PIMtZ8AcAfw3Jx+y5RZljgC8dECKTNPmZ5RTG+ZYZvFKYhe5/d1vrzFRVUP+QqRF8ZmifDtiNxsPpL5t/hqyUWPQrsh+dRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DZx+9dRA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DZx+9dRA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rZp6qKdz3c2W
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:48:50 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2e82462a3f1so9150505ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028929; x=1792633729; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yU/tI1b3Chy6tvjhfXj60ZgAk9bekyFoLKnVljFmz1M=;
        b=DZx+9dRAv3kCv0vZ8rItaLjyrKFp/O7Szmfy4vYUA7+1fvLEZs0ACkMOwZ9hxXprNU
         Ugv481opAFGJLPmuNc2TT/SQ0ktlf/oha6dvBP59wRGfbS578IVnApnrjgHlUteJyW80
         F4x2esWqM6b/+s9EyHI/ILOhISD01JOURP9u0b7NvwdHWSrEXsz0ooPxnilKK7oPHDck
         9qsMpPuIcuKWOQXL6ZQXk5Ij5IS3E9Jo9blE+ZSTrwO8H5c0YVl9VJkZsMnoYYf9Rf88
         c1df12EmePEhoCy9+t4qZwf/cMLqFi6ccqJ3McH95qPrjB6QzzwLRiousOLQ5UlYOjWD
         qcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028929; x=1792633729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yU/tI1b3Chy6tvjhfXj60ZgAk9bekyFoLKnVljFmz1M=;
        b=NKr9PwuGQcSK63rz1na9gkdJ4trXWH9xwUtDhFR1BOyNXFHGi5nK2Y6NY8aH9Dda1f
         oIIQPBTFnMd0UlUfmIHuxNQJRRE1Xym4KQvHZ88QQNjfycwyOPXe9P1hknu61jU9QxkK
         O6VvHNF8l08huO6fFsHlVfzip48O5UQnquCYVpLMIKArpS/2gCEmEjozjEpOR/ehOTRz
         xTtfoBj4xGVyqzKH25cA6qkHwKPm9yVoYkeTKTjgDyGTVO4MVoC2A9/Pg4BiiiZz9hOx
         37Vu+Puo8Wl/vPcjPNW6YzoN9EFEBJ9qJtfFm3D/V+aPFDr41lJSBGsOgIjo3u3PBx5u
         zV6A==
X-Forwarded-Encrypted: i=1; AKwUvByCyUobN/RqX2YrhftvTyTAIXMLYtGid95HoLCo5hRq0pxorDR4kQjSBst1VcEbGJxVClk3IJXV6MHGzmU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI9TyF6wwJOdL5AwyjFPUxNq+YARgOSjQErDlhlSk7Gx5D/lX+k
	fS2yudLKLjSxuyVkUo8qu+ye13KASLcwMexJC8gIIRpgkrhUbLHdhwne
X-Gm-Gg: AYBFou0oz8UCiO3T0XK0BF6v13ZAlf0ueJI5vWw4Xh0uXeDkr15Hw0vKtfcgPqQNShH
	qcQIiMzbYAnxOWTnrJrm1TE+nQrvdP4DZQUl6yKdsUpIlGyIrVW/5fDRpt63MX7bXPhLTjcieKV
	x8YZS5/WlOQOweuUBa/JeTLfVgM90MxszhPt40PK0nL04YuI3ZuexYw7tKExrYyZA5LryfDjJW9
	R7xfse3GvmOSlFClPCPql5fngpGLnCUO6bIwMEIV4rqqFanM7g4abYrPPSO8fNXvUxzqiYcVfev
	TMAhFDSAMmoWjpP3MIeGis6iAnfS2OaQMKp5WG+VG/dEOr6NwOVrkuYLdsBVUOaQNOZh4MbkTjl
	EY4IGlU8XT2hrQNLIFz6x60wHiIdp04JRjmv7SU0z5Fqi7cqSJme2CdTADA/uydzePhHKIxK5BF
	+MIyMfwwWGYULHANqxwl4iY3zyFpfMio3pn5P1Zx17pdFlu9sd+Fx6p9WRXL4HRPewd3knYpFnX
	x82BHx0iRiZhIu1J7oyy4kr+EyzUn1hSXjxE5pctAHOaQUVTdTQqgmkjWX84yuvbYLjUA5MdQsC
	9MOsjxy8jIyEhA==
X-Received: by 2002:a17:902:f786:b0:2e9:3215:c458 with SMTP id d9443c01a7336-2e93215c642mr37739115ad.25.1792028928882;
        Wed, 14 Oct 2026 18:48:48 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:48:47 -0700 (PDT)
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
Subject: [PATCH v2 17/25] ASoC: codecs: wm8782: Ensure the DAI is marked as started on success
Date: Thu, 15 Oct 2026 08:43:16 +0700
Message-ID: <20261015014324.5569-18-phucduc.bui@gmail.com>
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
from wm8782_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as wm8782_dai_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/wm8782.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 3a2acdfa9b85..cbf0c823c022 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -39,9 +39,19 @@ static int wm8782_dai_startup(struct snd_pcm_substream *sub, struct snd_soc_dai
 	struct snd_pcm_runtime *runtime = sub->runtime;
 	struct wm8782_priv *priv =
 		snd_soc_component_get_drvdata(dai->component);
+	int ret;
 
-	return snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE,
+	ret = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE,
 					   8000, priv->max_rate);
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
 
 static const struct snd_soc_dapm_widget wm8782_dapm_widgets[] = {
-- 
2.43.0


