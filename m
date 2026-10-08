Return-Path: <linuxppc-dev+bounces-29050-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03333CA600E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:44:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mpN3rvdz3c1w;
	Thu, 08 Oct 2026 21:44:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456284;
	cv=none; b=YVfGHie2ZduJPxd1bXudd0X/jLEf+P7KNzoyLj4ZGrp/qXbC/vrV/bw6bwS0UOGL1XrCPqtRmczmlLetSTkHwiUkcY5RPClXNZx/JjT8EPKGri2S9i5euSMpBn+d+SliFM9MGP1PIXlC7JJpARw7ULjPAEfgiHDyUMgt+EtAgXq7ukjh+6rdUTRos6emfr2RkVOGKZGSmK4LVUpPuFUVZfXxNYdxe78R2LVzm/Q+N08BMBpvfsdgZ6N2RpzUwORyWRDpFFOIQicBQrAjajptjXht6Cl4Li66ZsKULQeZ498k+Mq3I0bbf6DanHCP3/qOSxiKPAdLSVtGjoh2nTdcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456284; c=relaxed/relaxed;
	bh=vINDjRMMYaX6AakE2nE7lJ054HdL6sHwsDn4uy023fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3cpiOghY+IOirAS0fQTCxBqJFGi5zyV0ilAAxnY9zNHtJYEZTO5EyurpjuwsA0zZ65AofSKDN0Ru9WVMS8pBuN0t4YQS+vpeO3R4/s7TK8hB6ixMNryS5eak2hXHrQ8//8Pv+8FfKDIFbyYUUJBBsPvu/0KnNOJxJmeEIjWtQXCBbixObinMk3W4dMw+t1zUT5BSkbWciZqNmlNOLcYtvjBeTEHa2uGgZTCYsbGp9kJVsqfVVxa8UC1kHlFVfryPYtJn4Z/tOigBua2QrYU1rglYr0Mbnef36UWCtMPd8//ytN+L4EduJGXniBn8q+AwSvxzJYieH8sK05pm7TiFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ObvaME+S; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ObvaME+S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mpM6nF3z3c1g
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:44:43 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-33fb4680717so896215eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456281; x=1792061081; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vINDjRMMYaX6AakE2nE7lJ054HdL6sHwsDn4uy023fE=;
        b=ObvaME+SMiXIoIBEBKjxfeJHCsR7Xj2C0uVLiEx/aauOEF+7iWixo9OudsIL0DfT2f
         fvK4ejdcYZ+ojWYgyiUZQrOgoM+PrOODdlabwHzn5K94kt6QzUVJunPE1/DtKq3QxU8z
         /uJDpgqRVnqrG1rKXZnWzsBP27VvxzPuilFLpD8AWx+gzjqwRvQp9IpVM2Pd8hvtNc4W
         OeOK0IFNxAw3K47o8VSSv54ubxiHoCcklxjGf5vnSQC1MnAANYl7Yl3FEtmbRcWi24mv
         26ODzbvXK3PwxxXtzbYIdfzQ3jQWfbfAHTdhVn1VC9huwKWZCppsl+ybcDnKM8y/UuDP
         k8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456281; x=1792061081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vINDjRMMYaX6AakE2nE7lJ054HdL6sHwsDn4uy023fE=;
        b=a6KVpAeVkYRpzJrGxkrf6mhRyy+13oxTUejsCq1lzq307agJmnINE0wzx9pwgJjxVy
         k55xI4At2Fk6aQYOTF8coywmyn0BOQWZAVtnk11XAh7nHXbg7iPmA4xfd/IwRbpwMOck
         58j0bIoWkWOiHhcTuUZwumbXTNotDkMkxy9SrWr3IYrLBwSX01VV/zjqZP1BqgL3QL84
         fFVyZDHkGNzTmFAwmAflFCw1xDxdmCeaOKM0Im+j7qXNhp8Rs2BKm8dw9bTkO7j2ItLF
         KvmZtxcSB/VqP5Jk7ONrIUhm4SwnNBayovtoSKgCuUf8E5FZ055lmNVRGj14B4s9uLVa
         AqiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeRpZ89J4zroN4OM34gzsays82t5mcyfLqyzdoyotB3eRHySi463QwE7FEQAUTm2p/rR4sqaRfVFudkHU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLeV2HfcV0LpzcmGNk+pvAiBRMSHrQuSJg7+1J04L5rjp+OY0ax
	tduRYycx0/TTM9bzP61Yz/B4Swh7VW0i+ZKV+O/n8bNCIAnjJUXNLDGZ
X-Gm-Gg: AYBFou2dk5M5cXSHff0JVmP6QfGUh7HNqaCJyqap7NCjsKSHpT6oAyIKRoiYi0xPYIf
	A5fIZW6teIYdh+6jJFoDNOye3rdc/DV+A02S637qn0fRoqsMnVp+S5LxfE1waFP2kIlWl/Bsck/
	6Z4P74ZbLidLcUw1aTQH3Y6Hh1PmvPI4WinOL4oNC9FUDwBQuziJxAacBLiBd05YZ38D8FYNo3J
	d6DhMmI0sIuZwEf1j2/xmo6Xjv6QCCzVl6fS3T35NnpkVulODiThhZ3DVYtU7/4y0fdmy4lMdmi
	PXw6YknbPxHgM0RdO9t0WKghwMow/WW65RUpXJa/KwA3Yl/sHt3Ecz19Hy78bn/XFCu95APRWkN
	sl96zpOqZtL+mR73GwrNQdo7JAT93XgL399YIx6B/hj/OJCtum9BFQbxasvKwh+9ub2ZQyjTASX
	HQSj0fxP1H1TrUXWMspvsUdhBfp7J+AG5ls3jpvkOydN9mLSbpAtPpn1LEDPg+ETpMhx4EPqqgZ
	fPu/h+VTAK2yohA7HEcOD+PKJ3LXuAjN+yxyo0ngdgb8WszZocF6yuwNkr8cqihpdGgZHXIBjnf
	Xtgw4hwmXAMSyeRImXuXD5Z/
X-Received: by 2002:a05:693c:8801:10b0:34d:861c:99b8 with SMTP id 5a478bee46e88-3515de37354mr6607922eec.21.1791456280856;
        Thu, 08 Oct 2026 03:44:40 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:44:40 -0700 (PDT)
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
Subject: [PATCH 22/24] ASoC: renesas: rz-ssi: Ensure the component is marked as opened on success
Date: Thu,  8 Oct 2026 17:38:29 +0700
Message-ID: <20261008103831.542533-23-phucduc.bui@gmail.com>
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

snd_pcm_hw_constraint_integer() may return 1, which is then returned
from rz_ssi_pcm_open_xx(). ASoC only marks the component as opened when
.open() returns 0.

This currently has no functional impact, as the component driver has no
.close() callback. Still, return 0 explicitly on success to match what
ASoC expects and ensure the component is correctly marked as opened.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/renesas/rz-ssi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index b1587f499cb8..2e297f721bb6 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -937,17 +937,29 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hardware = {
 static int rz_ssi_pcm_open_pio(struct snd_soc_component *component,
 			       struct snd_pcm_substream *substream)
 {
+	int ret;
+
 	snd_soc_set_runtime_hwparams(substream, &rz_ssi_pcm_hardware);
 
-	return snd_pcm_hw_constraint_integer(substream->runtime,
+	ret = snd_pcm_hw_constraint_integer(substream->runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int rz_ssi_pcm_open_dma(struct snd_soc_component *component,
 			       struct snd_pcm_substream *substream)
 {
-	return snd_pcm_hw_constraint_integer(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_PERIODS);
+	int ret;
+
+	ret = snd_pcm_hw_constraint_integer(substream->runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static snd_pcm_uframes_t rz_ssi_pcm_pointer(struct snd_soc_component *component,
-- 
2.43.0


