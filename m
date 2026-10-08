Return-Path: <linuxppc-dev+bounces-29052-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3187CA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:45:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mpz1RmYz3c2P;
	Thu, 08 Oct 2026 21:45:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456315;
	cv=none; b=VMeFaQKKE8t4tZIV5Xg/PWZ+tMEOZI4errWW/TQOpncIQ51uWYvSkT/ytg+f5RRM9ayhNWIdQ3GBmKZCKPP8K5h68NTpk41yRrxTyXP/xc1puwzol7D2zNRgLA7s+2zib6rJsNWyE7e9D5yKw+9a7oezqTHVUkZxA424cg93jfcMWbXtJtL9+ngoirrNiCbQe6lv/U9bCTFDubatdu0vL/UN2D7n+gAUiRGpSrqutAE7Q+yz8Z4zKwOgLM0l7KllkFpl+mxR9tBgsHZDJOxeSFXBuO01rYFrKrnKg35RqktrFhHRVlrwmKFSLa2wRjgMiq0Kc2VF07OOcFQTAs3M6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456315; c=relaxed/relaxed;
	bh=ew3yWeVvT9O5tBkIFDkvF2j0W+vU1/CnrAg2Miccmy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/53qrNgES8vTdT/8Q30dB7Te4JA3y7AxgHjFRpF9nLXU9S+ub4sC7iUrK00YL1+o0TYXZg+BPCAagUrnSvVgjpNJ+xaZcVNAT5pDkIVPVQYp/D9jDvUb7yIyne0o6hh86XjaT/huZptaj1SQwQ597Cgjj14Uu2hpKzBAmYOs+6GniTJaWnCfpVzhqxyLwJyFiyetIYzoFT2fKKKpYj7gAXmcT+OdCUx/fwLfg4OMVFNEO88chDPxNoIyB5lW1hWcYHSjmwS8j3PvhgeRWKG9nVEOVTmHFjsjHtOGjJrCyscDGsJtCAU14ZsZ9PAWld35Lgy1Znyp2IJdXJWwgW0gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VsOJvIsv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VsOJvIsv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mpy37XCz3c2L
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:45:14 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-3518cbe59b0so252747eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456313; x=1792061113; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ew3yWeVvT9O5tBkIFDkvF2j0W+vU1/CnrAg2Miccmy4=;
        b=VsOJvIsvQ75GSeW1m4BaGqa3e5CRQsXvXpZqyib+kay90Z0frO9kC2xNAMvxVbZnhZ
         neDac4R9G5v++wko5V62xtt8knVQeDktSYzbmjwl0g1w6kT68GjYSkJeRTCOLojDRR9q
         jX7JeUkK9ibo0NLz+szWKjMB0+KmffoqO2MQDxWaSbsBxtdBrLBJGcNhn6hakraKyw0K
         A8MOsQY/LjLBgFFg3vvwhDke5iq2+MXXscWP8umazrexhQTIItxb1nGfFy31RNtXSSEr
         g2YEgKEGQWIR/AddwHrxGCu+YLO4n3dIpdfmfWUArDqDzbyJLkSERngBG1L+sItjYFUs
         WSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456313; x=1792061113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ew3yWeVvT9O5tBkIFDkvF2j0W+vU1/CnrAg2Miccmy4=;
        b=OrYrc/VY4GNUxxiZw1JxkniY2cGLwdo/lPQvx5xeSfubh8oHCN9IWUjkvap2puL6GM
         mCoVuAa9Xfe3m6PT+wE2Nxz+6wytLMJ2G4BM1iJtFPHaGrI/FGmNDT7RNgj5haka3tOB
         ZMBVqNPVPRE2/AYnkDJJBOwesV5pvXO5t3UcxQf1txzWO45dcCSN8VgHvHpuAjouRvEY
         kIUbGSqqWc4egy0wfmdQeo/Eq4yX0qp5A9lYwfETb1cxV/yqsXEjJ2f/UXLzAEBzRvXw
         5Fy/ZHdxMKxfnCTXVLWV1X0DCXaiWbSwj2TUtSG92LDoGueuvUDENLyYRs8Qn/Mc44tT
         7iSQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1exE5K4bGehMi6luoNnI2XbxkiTSK0AqiUCjFm7uy9QIYw5xHh+vUp7icVMw5iguJRhALxUo2WC+z1L4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lWra/ESo8Vl0ItFZJmTcNSKK61j/tT7HrQ+myoE34TthUEjkTu
	WyXWOxApZpdMjcuqT0Fg93whDhTd3L16qA3Ek65t5THu3D5o/AzJ5EOE
X-Gm-Gg: AYBFou0GlZSoIydl+bFQ4vxPO9JR9nXGixKMNCqfs2pedtKiJiBC9eTuHcCjmKQ3gLQ
	/H2BCib6rZd1KEjyO8g+V9p42pk855xhFaQg8xYPK4p+AX82PNs5u86fvZEfSrkSYGK4jZ326QM
	7wL0oi+VEjP+TqdIFBriuWbnoXYLUj8ctr1s4fYtQ/9nPuTQK3TRLYrySyr9lGvM6jRNVoc2syL
	wrmwYL0OybsmsTMSWQIsYm/aYnqTsjCRQpMrdh/2EDQDwuSrwoQFid0F2fbFbnJbcCKGoBvLJI2
	VdfbkGXlivxC2AuMTdtQxqlZKqyJAyhv0t6p2b8zxk8L1WrmtYF/cUnFcmP2AjEse4B/vYhm7kj
	7FJjgWNh560IGtzTMaYbTGuQ6tWYdnK1Z249AYQSnbAt4opqZtC7J9/p9oYIHZO51fBaF+AZzKT
	2sxmmS8h6NptT0iIIXqB4yTUZ2IOu24PpVewxvzy0ktt/CeLL/b4+HIocKw+Z73zUOLRoTliPtX
	NBV1MGNsLj6PjCni32LlVEUtszprYW5Q0mevOveCXAJonXcPSJaOjbm0mlVeJ/PHpDD+C4WfMgC
	wTd9wGswd7W83g==
X-Received: by 2002:a05:7300:e9cf:20b0:339:851c:4c1 with SMTP id 5a478bee46e88-3517788c303mr2800571eec.18.1791456312416;
        Thu, 08 Oct 2026 03:45:12 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:45:11 -0700 (PDT)
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
	Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
	Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
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
Subject: [PATCH 24/24] ASoC: rockchip: rockchip_max98090: Mark the link as started on success
Date: Thu,  8 Oct 2026 17:38:31 +0700
Message-ID: <20261008103831.542533-25-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008103831.542533-1-phucduc.bui@gmail.com>
References: <20261008103831.542533-1-phucduc.bui@gmail.com>
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
from rk_aif1_startup(). ASoC only marks the DAI link as started
when .startup() returns 0.

This currently has no functional impact, as there is no .shutdown()
callback in the relevant snd_soc_ops. Still, return 0 explicitly on
success to match what ASoC expects and ensure the DAI link is correctly
marked as started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/rockchip/rockchip_max98090.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 426506a8e18e..d54c36682415 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -191,12 +191,18 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 
 static int rk_aif1_startup(struct snd_pcm_substream *substream)
 {
+	int ret;
 	/*
 	 * Set period size to 240 because pl330 has issue
 	 * dealing with larger period in stress testing.
 	 */
-	return snd_pcm_hw_constraint_minmax(substream->runtime,
-			SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 240, 240);
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   240, 240);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static const struct snd_soc_ops rk_aif1_ops = {
-- 
2.43.0


