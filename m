Return-Path: <linuxppc-dev+bounces-29039-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CDCCA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:41:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0ml42kDkz3bV5;
	Thu, 08 Oct 2026 21:41:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456112;
	cv=none; b=jcLwxWjUKEi8Q90koY/TOfItr3nzHQg5MimKyeuKboCcioBLzWK0SnwNuwoUqQriYrzCb6A9L6wIRemhCnusksSfKJylE05sMSI6M1KWiVRMu7tR3d9GL4lZlOkR9qmoasdI4XmVUvX+HhSsyL3vXtITT/pE3UmglDh4/burT5L6at1aEbWP/hyOVl9BfcAel27iRCe4oydokc08h2PgK0BTuJ0R9pvrkN8n+yPzH4lFV0jVCOcfLONqwmPD4Czi8Y6C0cLbWSS1ZM2HMKDprpkHScOYQOJDp2+hPwH3CHeaiTwdfurl++rQLaWw34a6qKbV2lS0Fqh1FrlpMoL3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456112; c=relaxed/relaxed;
	bh=dx+SAHqrRwjwnSaJfYRo4lbib/UhuPNUGHZg46FBeBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBW4bOb9oIsczrTmaJ+LauKQNXd+7ZWXEv+7jBM27u+pL1xafnQ7S4M8sBc0imLicTfPSJWQM5YVMxWTpvGw+UHvgZKF3jl5vkGQeVKjJJDhDb0fBSkmIBuvTViZZiTP0cL/vDCZfquEXl3wniQ/wLeh14MdNXbAi0R1oYrFiKpFq7J+Aa7VPzdhgCI+lZaa8IEYlJv+2nmYIAmkeuqLrnQNZvM/rNMV2qKvYZQ+GHlIxk5O4ko1yoAv+Jkoc5PMcNaZSM54WFEn/CAezMdbCJ7x0cgI0AxpaG9FGY8hzcNyO7HEulxXlJo5HGno+QxqehzD/dn3x6Wo4E+VJDjBfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pF8/E3B3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pF8/E3B3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0ml34f7Zz3bSw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:41:51 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-3115c4451c8so4253992eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456110; x=1792060910; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dx+SAHqrRwjwnSaJfYRo4lbib/UhuPNUGHZg46FBeBY=;
        b=pF8/E3B3b4Y+EKLwTOEQhyReh+M2MWj4YFAGTnopfdnXKTQ/eG1inO28xOuyVRN07h
         kKlT5wihX+f4k3eHGxarT6gVYijm/TrQATzyczFl0M2Qt9Zrdwn/CRUGRHl+VZsKoABc
         vCC8g/gR6Q8PVHGOb89WsBUJ/5LQTokTKMV6NRLo7xFHrWtBbwKQxjv00Vxq6WNaNAND
         j9u9ZxoscjjrVwkgYVk3owkmUitXs++tlLrWuvXS3HkyjKTsnlHUAxA23FmeSZ1+7ShR
         Cr9RYBDwmBq+GVgICY5BIbmvVebVCTddyt0f8gD2JZAQsY7qldkQhmoxNORvYPqc8Caj
         Twtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456110; x=1792060910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dx+SAHqrRwjwnSaJfYRo4lbib/UhuPNUGHZg46FBeBY=;
        b=f1VUan/Ggeqr1TQO4X4XFNswuoTWK3VLV6fsaMmu9tBLOe2ZDCl//OgxA8SslVkktn
         S0gdbjJIU+jsX/or1Misk9aJVfe+yl+s0zWU8kQPPSvqd2jkAIoyVt76/aBgFB1Xa5eN
         auTybZmUEJBo+0lLkAzKlrH44ybzoWqiX6s1og/a4kv32rtSso2gGLS14hSMHDq+/Jzm
         RS4PR1ZpuZbZwt42G/iTMDkrDv7nC0NSHtSP6EwYu7Pdx8UGTQe8+TpEJ4+vmJrxdVlg
         mOJP9lbDLe4vFKjm6YQFAL6S6KU5ahjPgkA25D6mZSxRLdy6nn3ecHgSc8EGTo6kXwGR
         hkpw==
X-Forwarded-Encrypted: i=1; AKwUvByVtOwoznumQP5zblA+HjsDvgIjTNPojmZY3hWrSHb/5EY0gQAYUvb/w5ImkjqZAjiey82xoeVr2ojwfpI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJGC5Oge1bqouvBSczCaCh673D0lyltWFQiikCNm/dcq8UE9Snr
	sshg3k+0Vy2+4IrqClMaRxbNXRNFSs1arImDEPlPp1/hM/VLqkOX091O
X-Gm-Gg: AYBFou39W/o/jr42ovDAMobHM5u/6QTFC4cL4Ilhl66qT0kr7sSkrWOAmllHIIFFK7u
	Jvj3o06UMTrpPtd/+sNwSX9aHfrHlVCTiQIK3PXXdOC7gxmogF8YjCFcEZjofmBhQ3Sef3JU+WY
	URM/hvZzEH7E2iq0XXa+WSmQjulo3a6Y+kGyaTCJ4eM3756M/AikY5nPOAoYvqOrIv5YM/ddKW3
	2XfZr3EuEOX4VKTktbckkkaEIYM+JjVrTYghrgIbLXoxuGMEkz3rhR4RNbFUbC1rcjKZLcj1Zib
	7DDR4gwE+6rQqb8lkOryYAIUHz61OAQlu6lIyyiz7qvbg5VwNxCg1TwckG7Uh1ij2qT4Wp/ZmR6
	fUY+rkDQ9NxSkdsMgF4Qhj9SxtRRmgW/puqgRckPNtStYVOXRkSG2aZT2nI9rqS4PGDuQn/TbP7
	/b5MHkMXMK0C7/864U7aUdauOCRYiZIAzGechy/uHtNg75QOCxN244vGxiKe5iraG83W7YuUpmy
	jrG2iS8dqfBYNMeoR44drtSbJOkXC9d89Bk8lVI79zxoamM21dzSstcV9dEJ5aFd42PSM7Mxhrb
	Ktq/gBNoDtGwGg==
X-Received: by 2002:a05:693c:87dc:10b0:353:58f7:9b41 with SMTP id 5a478bee46e88-35358f79b75mr44405eec.11.1791456109537;
        Thu, 08 Oct 2026 03:41:49 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:41:48 -0700 (PDT)
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
Subject: [PATCH 11/24] ASoC: codecs: nau8325: Ensure the DAI is marked as started on success
Date: Thu,  8 Oct 2026 17:38:18 +0700
Message-ID: <20261008103831.542533-12-phucduc.bui@gmail.com>
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
from nau8325_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as nau8325_dai_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/nau8325.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8325.c b/sound/soc/codecs/nau8325.c
index 2c95ed00a681..0902a7d7730d 100644
--- a/sound/soc/codecs/nau8325.c
+++ b/sound/soc/codecs/nau8325.c
@@ -489,14 +489,19 @@ static int nau8325_dai_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct nau8325 *nau8325 = snd_soc_component_get_drvdata(component);
 	const struct nau8325_osr_attr *osr;
+	int ret;
 
 	osr = nau8325_get_osr(nau8325);
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
+	return 0;
 }
 
 static int nau8325_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0


