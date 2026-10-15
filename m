Return-Path: <linuxppc-dev+bounces-29518-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38989CC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:44:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rVF4B8Gz2yqT;
	Thu, 15 Oct 2026 12:44:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028693;
	cv=none; b=GSQT1IrmaO+k5sp1OXEfZk8UVjF6a7hCot26KjZj3rQEKiioaRHsyIHCHlH39/1CAOBChTWey2Bdqu5VQtEyKxSpb1K/Zvxu0WIJiTlDzJUlnYJ0enGKR/eNqm3vDbVVMj+bt9BnDnT16n+xJVFaEkWGYDYCbHL8wTyONyUjvsAsmLBt2JjUJUJ945vGUBHmfP6UMXQXYldnskcH95HdzOzPAxQuceuUcyjed2tG+OyLwKalfN3qzU2WFeUCcwN1KRF2sKiMxWcczVagHbGSOl/qPN8T0OqJs8g8qa+1SDT2ybvxOWcTNdY0q2FJtTBXwKOSZOhMv63O0QMXuhAzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028693; c=relaxed/relaxed;
	bh=YmTMAPFx5up6qhPC8f6eIWZ+fqRc0pF4DtGB7TtfWew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngYGvO/+D+V9swqQW0tmjL9R2OxQWu9rvaDxjpvb+1empiafTbDiBWrKJEBEm6DDw+Pxs/Cc3x/AGP5RIm7otHeHa77yIAsQJrlKzkoD7hCBrjx91DdNK13i4PxkWBYMxKiEkf0uknYxydg+rmQZ37KP+nbL4K0uZbZFMJRX9dftwBCMrliHZW6lnqIRZECBd5PPgW+PrIj3Me46FRRgnFUGo+7JZrLGwU95PFMUaJWjysJ2CA//5DBZcN9tNxrvYFfXFfZppkCMZS7FTmYtUMwNh6dSuSEPTRy7a5A+kAyHvxa4xe23J+k9UAoywxziauyOaDGgyyk9UAF3GAJ6Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JbeY3F87; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JbeY3F87;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rVD5wZGz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:44:52 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2e7e742a2c7so32161785ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028690; x=1792633490; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YmTMAPFx5up6qhPC8f6eIWZ+fqRc0pF4DtGB7TtfWew=;
        b=JbeY3F87nav7mAlvRulEmmcwum7VIq1Jibkjlj+r/O40+3q/LvGGmCXtcWmWRRUZ6I
         F4Qu3g1to/SkT8uUnHQLlezq3trXl5bzidWDlpO6qfcOtC3Avq1KM15IIe1w2MefAkZr
         klVTqDsTYuo45kwKM9K+eHmcNAKgNlIRWc5QK6qC4ERNeqazpkUa0VgL1/FQAzaPiVPi
         z50P3C+RgQDZ3ISDMMrcY9CGQX7x9v9R8+4Dxz4KWkyOkjpybMfHKM2av6h5uxA9zLN5
         TUUhbytl6VBCguC5CRjwr4cN5CrJ+6x19EnFhOvkau0MLFXNgMdQ6iw7zVYPhSp6cOCz
         aYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028690; x=1792633490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YmTMAPFx5up6qhPC8f6eIWZ+fqRc0pF4DtGB7TtfWew=;
        b=YBUKrP/LfCEJtcSLH1RSfuWKvkialDxKQlXh4TqsjIc9ME7q+oTO7QQR6adF6f0U5i
         7ZraFOjfRHsiv7Zf9xdEc+r0eULhJRMmYn6tvxxPzoh3TtEibYFJTVhBT/yDFjED3A/Y
         zSYLfXQrH++8aBFKgcJIzOfXzIp1D/pnMkQSjkeijPmXGoZ+2jaMEIWS1KkieUVcjT/Y
         JONKkxaNutg/BFuJHPBLPSnmJ7oA/I2b0ilrN8bEifrdIskztpxv5KLf+B6KT8YXDsEC
         I/8Q6QnGsQlJrvAIv7pEEfyncFZIW+SxMsoodLTFeEBiM8DEHwBDdhdqkR0VErDOc1HN
         ga9Q==
X-Forwarded-Encrypted: i=1; AKwUvBw+TKgPXX3dByVRzGyerlQfiA8XQN8aXWTZF6dlaUUAYnc46D6jtSkU1TzxU+xLQetzzbCGI1hMA1LIBMY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKYjHRZ5XaJmQ7HppvM9VmXo3Oh1WffvI1/gp+BTF4uFbupTKwt
	1efDTW/FaBLOBvh8tPtio0QLX2iMSsOdHTGqYq8Oq3VvLi8dErVX+g9z
X-Gm-Gg: AYBFou3/Cxt4y1y1BXjrVPIs2kSVLGuN/U7G9eBMaIBd+/qY0SZs+RND+iLXS9X/qX3
	ZY6mzmx/jPNSZF6ejWkBzFqs7ceBvn0O9hhUltwnULQSQt/z7CV4hjGqsflhqBWrIeRFFkSSiHZ
	1qXrRY0aTkOoCf5e/1R8VPmc6G41u3Dpu4W0vYAqRHN7vzNP5MkLThtV+MHhQE4/IYOAXQRkoX1
	OJBY5YcSQBVSk0wH7olCsF49YfmiqZUJEJqbkrxgugUkd3E1i3RORuOSPiOA8dEQ2ltjf39IZE8
	O8ymwErpFsgRUcvLMy0fgOtXT3RBxIu8fNvrSNsAyXz4Kq2kDR5ML63IczN778liFMc38OfhZE8
	dyfQkU4462HtagWKgwWSKSqJ/q5+R+rtXU0G8RmEHk4aU+8xZx11v+AaiPDiApUakEc/x7QbF1g
	DNsN0gZYSPMXf8YzAgTPFK+aoXy3Ka662cqJkbijXyjOHWNnC4dPBJzQp8LSJyfjTsJoNIAl3Yd
	Walng7tqpeDl0Bl8JeF21rptrUDWSFcadvtBtVrZNwsbhX9dPb5Qp0N0xzbM+oipT+V7E91+OxN
	LMbV6nikfl7JMg==
X-Received: by 2002:a17:903:3295:b0:2e8:dd9c:99e0 with SMTP id d9443c01a7336-2e8dd9ca60cmr47644535ad.40.1792028690053;
        Wed, 14 Oct 2026 18:44:50 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:44:49 -0700 (PDT)
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
Subject: [PATCH v2 02/25] ASoC: amd: ps: Fix acp63_pdm_dma_close() being skipped on rollback
Date: Thu, 15 Oct 2026 08:43:01 +0700
Message-ID: <20261015014324.5569-3-phucduc.bui@gmail.com>
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

snd_pcm_hw_constraint_integer() may return 1, which is then returned
from acp63_pdm_dma_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 5137305662ef ("ASoC: amd: add acp6.2 pdm driver dma ops")
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/ps/ps-pdm-dma.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index 04c014349347..12c341e89bce 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -211,7 +211,13 @@ static int acp63_pdm_dma_open(struct snd_soc_component *component,
 
 	pdm_data->acp63_base = adata->acp63_base;
 	runtime->private_data = pdm_data;
-	return ret;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
+	return 0;
 }
 
 static int acp63_pdm_dma_hw_params(struct snd_soc_component *component,
-- 
2.43.0


