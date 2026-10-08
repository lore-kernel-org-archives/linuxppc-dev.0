Return-Path: <linuxppc-dev+bounces-29044-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AE2CA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:43:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mmY0qvSz3bwp;
	Thu, 08 Oct 2026 21:43:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456189;
	cv=none; b=l1E5TPVnjsQ5O8PnCTPfMfTZcMpLyLhnG5islbu3tKohCatfMkH42C+Ob5SCoZQEiZlfJUxRZCus65E3xIEBAsQ6XYXiC1OkKPiHaXNt+iGsflNwEc+HEm9qis6NbXKq7w6Sf8SLWFucia6P6lo5vUbdX4Ya9QKTHrhPbU/5m7/cApUeWWlrbVgIryCUyS1CEH1D3n5YZGzw7aYxIRPo1isikGyUMhlj4XGlwNuExtZEh1aNgAPcmTLqNQVZ5HolOaybwAFij7+nFOf3XoQEkRUoC0xoG/3BUndbUWFQiggNpp3ZsxLO0sI7mEglzCLtVF53A46gomC8Qk1KKLxPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456189; c=relaxed/relaxed;
	bh=T/ErUb+BYhJoBzVefBGuzS4rmfVbIr3TqgsBxZ+R3Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfU9BXyaT0Ha9XjUflGqZEtxfzbucA6Q1jOyBt2aPsGynQ2tjEdR7dj27pcUiEq0TMzJK1P1zQ24D8rb34CQf7102aDco14IRW4wjoDFpa8JkDG6SWQP4eCZ3n/vH5RiRtsWrt/lZQr8iPU3dpZRjGyZYMjA83F164y934Urb178sWavgMxsKbvkduNZqpu7686tkl1HIcyJK+H/7Q40ks+eQo3COkttBmB+7/s4KRW2k1Q8faZzJ6HvC/gYjEwiAdOkJ4JxZCuj4bjFhIfreUmeoHJStnKqfLPwXOOJh1a1aSNW0KwhS06ODpIvbmUF3Wng6ufkblJVvXHNqCrF6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YXQmdFYv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YXQmdFYv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mmX2bWgz3bwk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:43:08 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-34ca2d54925so7790498eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456186; x=1792060986; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/ErUb+BYhJoBzVefBGuzS4rmfVbIr3TqgsBxZ+R3Yg=;
        b=YXQmdFYv50xLrkYBBCdCjFCUg6Bs4CZR2bQYMs3OJ7DSgSCf0fNdYwXsgZexDhMgXo
         FBbs2IDETbERXXKE3tp/CoFUVz8CYWAQLIMRPSOisWdO1is7IqC52j26nZ/1zDEZFh2m
         P3WCz7YDiNAHE25auGWV0Nct62UpGiSz/oSdMvjJqolE8ussGrZLyq4SshHSDe8wc3rI
         6NslgCbVDfSmYtXJIWByiAg26fpQl0Avixh++MJp5+nBSVWZk/rsnqD6OcJ2GvxSr6Me
         sLJejs7muspddXTmWFi56bBBFjFDfX9vCGfj0BjtHs0IDPbfDUBPCTji2leprTt/7f/b
         rmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456186; x=1792060986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T/ErUb+BYhJoBzVefBGuzS4rmfVbIr3TqgsBxZ+R3Yg=;
        b=zEfwEPE0fHEnyhiDUnVUYtisLcJPsLjwo6kyyJrNu8Mq7bPtiM5tVE4v1tjFpqHMqJ
         jumSuivesZkGQOBy9InUJDqdbQLe3WY9RYxRY5pbyJGkTPQGFdCAMhTepEvHJe95ehPi
         WPfkVgiE95iKK474IH/Ah9KTMjcN6Xx1iZFKwf2vx/fhS/7PwhAXtcQo/dfjjKJKh9ED
         65fvJMlqTlvL//t4ixrO4yd+78zAHrS2mdoi2KREVumdHcmruvDfrqxNHiWM0oYFjWrs
         LJOuNLhhhapF/rw9TuSD+y6jPRZKwv5ToQfh1pXtNaTmI8B7iOIHRkCvMNmjPWfWAjXG
         VuZg==
X-Forwarded-Encrypted: i=1; AKwUvByt1WjoWALLkes6Yic6yBphL6OXjbY7uDNSYY+SxOLwp5gE0e06hD1iKrw5RgCY/sPgDI15/ar4qX+O3kw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nJbPODdC+WCqtvyf3fFybkF6SDDodd1s3pRDzSIFyw+qlIWm3U
	WiqeJ8hF2e7SsF4ajw6T2QUxkFEi37n7MSoJ2V+3Lg5et76pL60pNIbR
X-Gm-Gg: AYBFou2MkC2HfqkN04B6Dc4ALKkwMAlf7Zh4pmAqG1qKnD7/8UzqtkXapxRIXm6Csc5
	CJ6GbLkqsv3gvcXkKG39GuZ62JBVgFaBOrcZRk3R5nk3+hsNhAq/JhGclGyLwfWILMixLHmVDFW
	xZ79mC/yOJNKuBVet7Z3HOLtDiveswL9vfDPIN0Cemn8PYe9qaZBTmNVs1pe7ScGLgVE4ZacmP/
	mxZy6TvCTfQj7x343bVMi6dnE4EFH8h43hBrIPHyV6MDJdHYjIcq1S90vymBhioKetKr567kRel
	pFerN+z9oQnLhFS0Myhyslj9XUqOZWErcPGJ6MSSVOWyrHJCFIivJFfK0Hj9j2swTiCgEQxuCRI
	MC/6ScgGmVHUKgq7fiTwWTV5FKxDwgBtKYoQ1rRgKjIncSgOlZjxoD3IRRpbx38Rk90drkSl14J
	eXkjwKKR2i2RMQGGKTxxovPof4amDFVA76gw+S5gwppXB+dwea4UfC5umwn4TdKY8+T3ePtaSdN
	lGe1oM1uy5wf1XY2gQ2YuqLt+QduhNDW+vqvpdbZG7M2IahRoVJGLuH24u8gaE17HwIrDJ6cK4L
	cRUR7PW17kCPk7hHtItIT9GQ
X-Received: by 2002:a05:693c:88c6:10b0:328:3944:ee53 with SMTP id 5a478bee46e88-3515da28859mr6108352eec.2.1791456186115;
        Thu, 08 Oct 2026 03:43:06 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:43:05 -0700 (PDT)
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
Subject: [PATCH 16/24] ASoC: codecs: wm8580: Ensure the DAI is marked as started on success
Date: Thu,  8 Oct 2026 17:38:23 +0700
Message-ID: <20261008103831.542533-17-phucduc.bui@gmail.com>
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
from wm8580_playback_startup(). ASoC only marks the DAI as started
when .startup() returns 0.

This currently has no functional impact, as wm8580_dai_ops_playback
has no .shutdown() callback. Still, return 0 explicitly on success
to match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/wm8580.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 9bc5d1e795dc..5343d445c322 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -852,9 +852,15 @@ static int wm8580_playback_startup(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct wm8580_priv *wm8580 = snd_soc_component_get_drvdata(component);
+	int ret;
 
-	return snd_pcm_hw_constraint_minmax(substream->runtime,
-		SNDRV_PCM_HW_PARAM_CHANNELS, 1, wm8580->drvdata->num_dacs * 2);
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_CHANNELS, 1,
+					   wm8580->drvdata->num_dacs * 2);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 #define WM8580_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
-- 
2.43.0


