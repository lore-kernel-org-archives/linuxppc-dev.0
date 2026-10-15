Return-Path: <linuxppc-dev+bounces-29531-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559CACC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:48:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rZ16B9Lz3btt;
	Thu, 15 Oct 2026 12:48:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028889;
	cv=none; b=THcBgKqzUKcBfrpZeCI/2LdHBZdAhmTyXkoeCP8DE9mb/IuUuDE8lq9g43HaZG53RF0JKcstnurcRBJZdg2qgq17DP7bvN8yM3dlgXpZNizl7BWGCNst07w2wnwx6wgCwlMvNRxFHrwT9m/hnRj58ujfnTUw1Adug4ESAP99dvNBqvjqETG4VI/XnmdenUn1hE+CkeyGk3FQGaHLW838Tk4RKVFxooAtaBEs32Qh8vNBmtNyB5GuDfgjBAiUU/+CVSTPG++GXjlJ8rLaLT3hia0MpWfGsSdr9+kJBs3iiBfsZ8YUsrK0P4m0v5lzXpjtV6/VxOC1BYR4hrRc/cR+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028889; c=relaxed/relaxed;
	bh=E8bdFAa8/cOYz7HxAYkPZAcubK8qZlAfIypauJAM7ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4V2citWhSo6rZTfALeBDMkV5+2sqraikNLEi3PYp0K0hM9cIHw1DQqGnvT63Ld4+gNonVtNO0TQtKvmeHiNG08xuSex7n3pV/SZCa2jSUIHT/QtFmYzVhHI/mgOCU6QT8P+Fq36+El+Rg7iaACyG5iLzP7RAGfuqTg6oyr14xAAIv5m89SC90sygEYFio0YjdUeTo0olcQpvu4RMrUwc0uUZKYe9xnEhHbbunM/Q9DPKdS+Rn1Fayj3exbzqB+R58pF3Z53We/WpUxsB3anPOzl89MQ6zVzC/oCgXvslkXAzELBtOew4D7Si1kD3pXjy5CVTsDkO3gABRADYr7m8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QMeqY9MK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QMeqY9MK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rZ10SwFz3bs2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:48:09 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so25405455ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028887; x=1792633687; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E8bdFAa8/cOYz7HxAYkPZAcubK8qZlAfIypauJAM7ak=;
        b=QMeqY9MK/pV8dKDnPMpr0tSIET+Of9v4QUyjoB5uZvL7+Bj8zB+cwOndkG6KURHFLO
         MMHjW4OMeDEy5ydsKYfTzCYRY23N6bs8tLxCPNCGMXjhGEM2ea69PN0ptsI5XWvFWMd2
         h9rAN5d5Emkdh1X47N533T5tuIgmGqM+Xt2zCCmhcOCi7WHB2oMygl5xqmV1+tY+3xUQ
         bvVbdtunFiemALDNAkdNrgKU7kStoZC73SqSZEaNaj9XdMVmmNcxqY/rmGMoBp6+djaO
         HGbdrhsTIecGwrzTKe2RPbcXQOH0JnA8dmuR5owjuWU1Q6+83+ipmqvLpVl6vidVjAZ+
         yxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028887; x=1792633687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E8bdFAa8/cOYz7HxAYkPZAcubK8qZlAfIypauJAM7ak=;
        b=nGcMMWMJKngLlEC55jLYPqh0tNb7UyxVizAThJRfMxB6cAwgxHrE/+Xm6mksEnOrVM
         253wIuyws0vzn0tKYylzJUsREaEtUuoPMwOqs1wGFmInE8yhTk9g2hx47ne1OyQAew1A
         IeyCygZZRTk7fKGuTifVbkHo0rIv5Gs6bElJNA/N8oecY4jnvJDRPXeJDnAt9IfkObiL
         AN1YVDLoHTFpZxEuFxKtBkDHH7tQubKbzGSFIR+GEfisXbxypylcrQusWUZJRypQcbeo
         QaWHRNVch6FCKqnSn8kR9VNKUJg2JODcrhObrvzfPEQxYR5djgZL04IJ26LHI/W+gcDd
         rKyw==
X-Forwarded-Encrypted: i=1; AKwUvBwwo5nO9fTLKpSxozAWnVvCCXp1gJcPxOYDgrJ201vgmK3zgdV53ITHdVSPtekKwYHV6fMiGJDOvseEv9M=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJAYIz5Izrx2xcT1Z4qZS9W9VJ8ciW/kekJfGpddwwmt/MscyMs
	lacOQrP1wrNC0wb+OUJhgzzvT6zlXDe68PCXLyoNlfuMjNVIKtbwRa3O
X-Gm-Gg: AYBFou11ll3kby5hsOnAtYFSS0rqjQJTVPXYFph+SUKwC+5eOFU6ntBdnqjgHj7mLVb
	DNywtjZpigbZRNOgoSUpbWmqZdeUIt94vNX0HOODLZRISBeJFx5ebYSis5RsXUioOVFB/6fjR+9
	1svJkJdgfpxrJNKW2uCOuGNi/UbdpBPyiYgMk8FNKz2vmQd3q7BnVA74Ts3epi6ytDs9k65WtOL
	K5cT2wxoku19Qvvwrv5t3quh1I/7V88bm0nHqYV9GaWNahfInJ/AEUp6IfO6tPqLgoFYt8Yrctq
	x7zaBM9IQgqg2YuD1iOzgTaD9WGnGgsYB1Z4G9XsFB0icwPD9lkYb4tO99n+/YPnuHNw87R66jq
	9dvW/vRTf1aEfIuAX/n3jkIlDVXqzPiTfvcJudGGZAAZBiyKP5cjReNQwH3yFZSPZ+nYyvUvK7T
	6ARDTxI3HIJsmFnJK5hn7rhdjb7ClC/MMEikIMTf7Qr/1/jrAw3OL7jDTS9A2x8Eu0Ztt6AISiN
	Wo4Y/WHd0kvn0u6Fu0hHhLEQBDm3hJPz9h/8uvPgEJWefTHidDfCdxQ1MjpmIFIwjEGWcLpUFUa
	bjkc3sYPQ1T/JA==
X-Received: by 2002:a17:903:15c7:b0:2e6:1a6c:abd4 with SMTP id d9443c01a7336-2e84280e026mr162256675ad.2.1792028887036;
        Wed, 14 Oct 2026 18:48:07 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:48:05 -0700 (PDT)
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
Subject: [PATCH v2 15/25] ASoC: codecs: nau8825: Ensure the DAI is marked as started on success
Date: Thu, 15 Oct 2026 08:43:14 +0700
Message-ID: <20261015014324.5569-16-phucduc.bui@gmail.com>
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
from nau8825_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as nau8825_dai_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/nau8825.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 63d927f31409..af2a49c893d3 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1261,14 +1261,24 @@ static int nau8825_dai_startup(struct snd_pcm_substream *substream,
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
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
+	return 0;
 }
 
 static int nau8825_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0


