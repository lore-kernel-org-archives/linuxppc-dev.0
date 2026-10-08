Return-Path: <linuxppc-dev+bounces-29051-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BFFCA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:44:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mpf0jH1z3bs5;
	Thu, 08 Oct 2026 21:44:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456298;
	cv=none; b=BEVbB4tL7kX+QR4CefugOPTw92yY6rZUNfz13GU3bzVgdVZzOSwRUhAfS/h+F3NvT0ptSDTDkLzBdeICCqb3sIUML+JG+9t7VMeXMTPWVQOp3okz/cix0W7rpCY9stuSMeZSLcFQ5Hiu7LkIUSOAHZ4RaYHCnG4gz/nkRTlTuIjxVeUdrjB9F5ZjoPKpnsFjZjZnejKcQsMVAEt2ZESzGpAY9Q852e332kh38Zxq7RGIxEtVgcX+qI5a51bGXRoVjq0olO25VQhmwyPRSKvKQ7pC+2+JrsaB1RFplvPhq03JKlindb859WhtEDQEgehCGJXQUrTUcvkvMc7f/bEEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456298; c=relaxed/relaxed;
	bh=vuCt8LfoeVxeGP9EXdKyFEToJzhlOF5O+NhVLwPyMgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvjtw6LbgiUrLVTVLthSny2JuwXyZl0ZfHYHeIvwA4oloADQrmAhwA21K1NlOHPb3umcwA9Hfr5zuq/s95Ze30vvaGgegBvVtNR0Wyz9+351QuRbLzgx0aZBU9g/nztk3FAFhxPV6AsJjgRnKK6D6usNv0bvnkoR5P7tnkrMs2P3AvZbtscpHgP14oI9WbrwoJ3NeniXv1VXhd8I7GqKAkR0qaHeaJ5T3XSCbUd9Cut/l0KnrjFbC7M9r/x9quMp5SRa9zXsOt5X4jOzntlfpLvqPzVYGgCvwMaeCS5i+NnLIKIpdHkplkVuSSPfu7krPCMgYISRy0T+byFJ7ffbUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CeC2Yocr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CeC2Yocr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mpd3KQwz30hC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:44:57 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-34ca2d54925so7792310eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456295; x=1792061095; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vuCt8LfoeVxeGP9EXdKyFEToJzhlOF5O+NhVLwPyMgM=;
        b=CeC2YocrQ+SOzK1NIoBizRurXLzwTwMaxsSayjDFh394CihxBBEl6nNDsYEaMrmv7x
         LmIxOUmp1qabkmjfwsOhcnPcT9x14bmM13M1cWImAHPeKfEaq8Gv3d8rr1UDjutjRvA2
         xMVGK8iFiR0kX+X34fnCaoFa5mPjIlpctZsTjsx77ZsHroY3S5v0n+5S2PoSxCnia2nQ
         jhZyP83b7KDdNC7xqXBkjhDBbZDI69q018zviSHHbzY3C7gyHkYBn8TdlufbXOEKxhgM
         rHkeHPBQf2XLBqemG9tipqQQuXDISYzhRGLBgYUZM8Oqfi1QXJvYvBvl6dYF7rRXwJOR
         389A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456295; x=1792061095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vuCt8LfoeVxeGP9EXdKyFEToJzhlOF5O+NhVLwPyMgM=;
        b=Zo3czMId0Ji3fumBmJaVG81PTpJ61YjiMAFunwPspiAEtCvo0r5091sMUWXBn8LcTA
         PhdTQIzuhwGIBivvtwWtFW5IOHTTOK276/O1mHkEYrOu/VYoRWT3Wanf4pnJomwGYl3S
         ndBRVNL/vLo0mIyX88GoSQdvMFfbNIELX/XrOtnjgz4p+jEdZhHbYwf6vLKPqao5z7o6
         DTSc1cdWsB1D+YiZydB24N+kn1vCDSVFgp8/GwpN6Ul+S/Tljbwn9bbc/S8uDGwQDTI8
         OMoY757XDYXBM7hb3aDxWU8GZI5CXlim964DsBH/Q9HWmS6m1d5vtxz6Uh4lzO/akUMz
         xXWA==
X-Forwarded-Encrypted: i=1; AKwUvBxG2OUmV8DkxgmUu0dviTi51LnlakVtJUe7hYCoDIgauENz2P9zFtxdQplCPdgWyBtWjmvNPOc4Ej9/ai0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lMiI0J4u/0gqnyy4xSbxnxMwugazjDwJcEL8txPCdil2t0aT67
	2N8PEmIeFcKO97mcqXSY4eRNLtnbpl3G0gxFzUF/+QvCrEKJsIg9ipA7
X-Gm-Gg: AYBFou2nK2lFgMmQfIMFChSB4l85dHboWVJm64mN1HYKX7nZ5FdP7nMjAOM5oUVGD2L
	BlWILFJa9AN5RSOcBY6pXGrXuptm9sajm1S71nzc4yuPP2yfnTzLaRJMxObh7xVTjEENVQcjd+0
	jefErywRhhPzQivkJGVRNWKW3Wi/Cr1QBywQm88tjpRe0C0srTFk8hFLmFgPne5+GMYZoyEwGw0
	+dvBVyuuIEBcW37RWfzxGx3eWRCTjWh1cbCf/+NBK8LIt+VJAFIlVJ8dhLb/89Lb11Dtp64ul9g
	fmRAlhajgmd56Ztb88bzDK+3EQh772w1n66s/bvnIFPM7GoUngQW83gRR8+7v61KV6AiJ+vRogo
	A2NDjrdsnZMVVY7R7RKAFKYHHRKw62BJwmW257DZSJBUpOB4ogb9nL3t3SGBnu/JSp8l/2jxsXw
	8RU1tcYWbzHvQEm0AAedIvTOvcznfh5qLA9UuOnNmWofvrsFe+GivWbI3lS5wbAYs6LftRYNBNT
	INT2mO5E+VJmiOP41ctSJcEAj/LXfTUvBQycCCIY1Sb6cWf6cFgcSIAs6ICuc5aIChQLzDUAr2U
	XZiBtnZJnYQiIQ==
X-Received: by 2002:a05:693c:88c6:10b0:328:3944:ee53 with SMTP id 5a478bee46e88-3515da28859mr6112721eec.2.1791456295330;
        Thu, 08 Oct 2026 03:44:55 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:44:54 -0700 (PDT)
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
Subject: [PATCH 23/24] ASoC: rockchip: rk3399_gru_sound: Mark the link as started on success
Date: Thu,  8 Oct 2026 17:38:30 +0700
Message-ID: <20261008103831.542533-24-phucduc.bui@gmail.com>
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
from rockchip_sound_startup(). ASoC only marks the DAI link as started
when .startup() returns 0.

This currently has no functional impact, as there is no .shutdown()
callback in the relevant snd_soc_ops. Still, return 0 explicitly on
success to match what ASoC expects and ensure the DAI link is correctly
marked as started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 04e7bed8275d..0ec80a4b8c59 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -258,10 +258,15 @@ static int rockchip_sound_dmic_hw_params(struct snd_pcm_substream *substream,
 static int rockchip_sound_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret;
 
 	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
-	return snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE,
-			8000, 96000);
+	ret = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE,
+					   8000, 96000);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static const struct snd_soc_ops rockchip_sound_max98357a_ops = {
-- 
2.43.0


