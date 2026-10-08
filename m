Return-Path: <linuxppc-dev+bounces-29043-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2DBCA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:42:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mmF5WRsz30WX;
	Thu, 08 Oct 2026 21:42:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456173;
	cv=none; b=UHqwckjCUK9cO1RM+lEpcfXailZiW9oLTHW7VA+hMz0hB6w0I81fm6Njja5kdzOnh6ePPYIsePmkANv8OQIuJ8V4UPre/JmAqD3vsu0Q9WbmBHIzTFW0TpovfkgBK/orLR4T/o1Aceqow7LwJ7gG5ZkueMzUVM6CrfX2J7/iUGceRrvrBjpOU1ccXMbly8roodrERS0gDAz/Ga/hSFOTRhP+R770dfrLU/lsJewnccRmkJNb7zmehMlnmtq2y5k6C/DaUa7Elx/jQKvD9Q2Zwlv23asFyzlpKHIjbT7rVErtCG2XBL9/4GYsmXrmZj+0HsMi/N+yKorLFiJbeDaXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456173; c=relaxed/relaxed;
	bh=xzYVoHEdz3P+bsZXHKAJVN1yBKjLyzB0nPd+jwADmvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/nDdZePeSNqco2jrSN0o9ok79JXEIviXvvKo+p2waFwxhwAOS+SbkfXVMPQ8rA8E5Hucaa8umrXeFQ88fmiHDvXGPJc8YnuydPfmTWjw1nVEboIyYRi7VQR0wOV2KiK7v1DwS3JGcg6oThlaA6SVvguREgjmx//xRBHKTnuBAqtGjW1D4+rUylO0ob6j7Cv+lcFCxoNvDNw084sDqusH+o/FVAeA2Bjfo2BJWPABSuZEGXVt9WwrUbR7nhzmt4lDP4Hdu9cPaGxwv6YmXmgmWce+tm2ykFQAibv4UF/bb36oXu5KpJjqNA/HxxjXaiZPjwj13RQsNJPdQf9/EVIyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iWKl1gLT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iWKl1gLT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mmF18Lhz30WS
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:42:53 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-3515f9a5d25so4191772eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456171; x=1792060971; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xzYVoHEdz3P+bsZXHKAJVN1yBKjLyzB0nPd+jwADmvw=;
        b=iWKl1gLT/Kse/Nu+ts65P8Io1BjOu+B7uPD6Ic1Rm8RBbOERUUnF8AMvYxPKGYWYju
         g9G7p5Z8fwH72j/t2+fkuiuKK513mfIFOfv7CJHqzGRAB7q3jb11ux3yIyfQFs2DOf1a
         U8FK1xRiIBMolZfiuNnktkB5sSjZSrDdOLsX0BXR+4+04sa8rarsbkp5L/hrS7AFVY9t
         xnsa6Kg24FNfMi8mtFQ9y+PHx7236FQ82GANtRO06jxoWqmC8FJIviiB5OjraXJMvDjj
         CRPG46t/Tx1i5USN9No1vaeCXdHHCJnmBz8bLJJQxnlG4VBlP1DVducXm5q3S0Sy0atW
         7mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456171; x=1792060971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xzYVoHEdz3P+bsZXHKAJVN1yBKjLyzB0nPd+jwADmvw=;
        b=L1tc9MAYMpnmaju7/QL57Q3WhrUKRHebfqAalPh+iSfnaYsLFaxqVWKhxaIbIDMJUq
         jZFKdJyp66IPHbfR92P/+fmxG66BPXLDw9vKSowVp8WHe8f8zD0cqzFeLIJEAA4EbPUP
         6onN28plPUawmS0KgUYjG6BslALHgA3BlSs7DYWNkAiHr6nWcIepaS6zDUNa5cb2yFed
         rPjJUQW8SiH/n3zMQKTLLGFUtsfwQn8Y+B0kw7iaj9xLon+FA2yGd8YmdHsb+rz92v2g
         NGBQUV8DSKgrS0z3lcRZ1T2IMwXEqNY7sb0Od8c43ib1faR8CvrVm5374hYoDLETFD3D
         x6/A==
X-Forwarded-Encrypted: i=1; AKwUvBz6fZuPg3K8zs9LQ6Z7iZCW/0P9xa0Xmaeh+dIK65F/88KoLYWw/Boyzt8gr6SD7o+RPY/9ZnRb625nTkU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nOfVOSPc54putXCskQuZFk1uS7hHtC5pLkwS2oQTaSNA6KJ+7+
	+GffvLz2TJT+FUS7zWAFfs3OJ4/mwRs9Df0XhFZTu3y8Vl9Fynlk0Qil
X-Gm-Gg: AYBFou2KSbTbdGu8zedlb9vy28SCMJZieErDDLkfHx/j9STOnTYGZ31r30kXW7RAH8G
	MV0KDx6xUgweA3IxoPqp/yH+Jyzqjn05N5BX9CGkgi/HO0/d5avPEelJoVBcykVTj8IcQTH9rL8
	9El837dHhsGio+4fBJ4NCPBIKYOSBHpHRGDsb/655uXkSscU8jwrPaovgBPZn7fOpOIieUxhiAH
	htwfqMyJL1WBvg1Fm82HcAWKYvPNX0pxSZxf+SskQOjMcRAL327kDsMHJ7XbXYy6iUMuRTIuR3z
	TVAQR6VOzKu24d8nC7JIX0lbNMv4NnEChPkcrihX/xl9/bwQwkFHPebqC+iCfMTl2EyvPGEmRrM
	55wZVgYfcW4AFtkXRncY9sOsQXiu9VAO1B/tspwnWIPiizszQuGLpQCmdEDu8DVOe71tFhnTw9s
	WKWgRrm7gcRZDwNNUWJH8NqgOyjrxi/U8EH0iLW1Vf3fQvMmp6o8syROncoOrZcr18W7n3sD3zK
	KRIxKQawx51ot8F10zH2esoPWhLYUlBH/MakEnFZtjcH9uKHSKU9ae127i6LfND4p4HRJlSVx3A
	qwVS+Um4S+JDqA==
X-Received: by 2002:a05:7301:8617:b0:351:11aa:5d5b with SMTP id 5a478bee46e88-3515dde8bbbmr5895512eec.19.1791456170565;
        Thu, 08 Oct 2026 03:42:50 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:42:50 -0700 (PDT)
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
Subject: [PATCH 15/24] ASoC: codecs: nau8825: Ensure the DAI is marked as started on success
Date: Thu,  8 Oct 2026 17:38:22 +0700
Message-ID: <20261008103831.542533-16-phucduc.bui@gmail.com>
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
from nau8825_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as nau8825_dai_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/nau8825.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 63d927f31409..10bbfbb460b1 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1261,14 +1261,19 @@ static int nau8825_dai_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct nau8825 *nau8825 = snd_soc_component_get_drvdata(component);
 	const struct nau8825_osr_attr *osr;
+	int ret;
 
 	osr = nau8825_get_osr(nau8825, substream->stream);
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
 
 static int nau8825_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0


