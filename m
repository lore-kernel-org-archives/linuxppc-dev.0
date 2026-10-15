Return-Path: <linuxppc-dev+bounces-29540-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77FECC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:50:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rcw3b5Zz3byZ;
	Thu, 15 Oct 2026 12:50:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792029040;
	cv=none; b=PbhPdeo48br5oRXnM+K24ap2O/ljIr88oSUR6XcqPLKW++KRTWmm0yU6ULXRJJSZUUIkdefyIghmNqtrXmN2XY0RujwId6O0xr9BGD5q+1puw4J1E0VB0s6XpKW00JZCu//QGntJyHoadnopUw4QCKUeS7deEa/3o4CzOgRS5uf0oIFt78L0iqlL7B84JrD7oDBYE9KBk4j2UZXjYMsLYOmZAwQZs6HJpDRITFtAsM8B4JhFoVZ5oJO796cKez1GTgS5Muxmfgj8eJt1uzuvtsFBoqfSqZWD0zVTGwRhlMwPteJtfnkmMzDtRHodJIHf9iI8eclDctAQqwyXOtvIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792029040; c=relaxed/relaxed;
	bh=Lmt1bwfRxOTKjQOsp9tkvpG9ehM8yzZulL3eFnlXWR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcAbQn2O7InsK38xySIfeV5k3clcxZ1Gvhs3yvtDickrkvqar4Oe7qTu0uyHEJWyeKVRuOti5Rzo2WprKbSU4r7qC29fPDt2+o421o7twqeEnJyEaR3KmtLT7tUno1GYjdnoY+QGmLYLq7J3bfnARE8V89jPya+pvCn6PC3VRSVvDKkVkFoudqBSiOCe2p1/B7vyt5HZ/1kNF3hNBYPXTj4/51Y7lHam8ToF2FM3QjckFopwMABDHbmf7UKDipVH3GQtYePQ4zQHzvrAubiXi/ueF/cRNyxgfcFo5iMUdfcggA+MNRP1ioX9Q0ZoNHnOJCZNfWYsXdzMmZ9mG8RBCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HaFtn1kB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HaFtn1kB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rcv51J9z2yqT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:50:39 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2e86dce4510so24259075ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792029037; x=1792633837; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lmt1bwfRxOTKjQOsp9tkvpG9ehM8yzZulL3eFnlXWR4=;
        b=HaFtn1kBHjF6jO7Vtpoxsdnl7iJNcJvyO0DBux6mX+OMFPcmAC8bCSmTGF97sHYCAJ
         oWakrMR3Id6qc79m76j0W5S8ehNLkN1PZXMJ7aH+64YXr2nd14cS0chqzypmtxhUOTrI
         R4E4fS8tds9ghLh59FCj5AawCXU/bQT3Xf7KHc7Ks3wexhfh0iOG3qzrCefRbxi18mEY
         5fvoM1UADJjYMcUHCWiMwNT43B5n/ZxT/uZ7G2k7+MaTvOqG0EVPP+yhILNMBUOePZJy
         y0gNhIGg5glIlOO5mdmEou2tHOqmdpy5bJKFBJqgVRiFsykmJ1+LiSl96ATkjVStege8
         XxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792029037; x=1792633837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lmt1bwfRxOTKjQOsp9tkvpG9ehM8yzZulL3eFnlXWR4=;
        b=W8IqLu7xpV9nmwM4l0xRc6rv2G0TAbTARIBmtV/WfTLOvjsQzAZwxqzrYOo/P7enx7
         kAfDokCgsHV2h4ABC6mNQ7ajI80greZASdnkhcsYOefdTApiGa40BdQGc+bU3rUkSw5g
         OMCNRX8qLji18rDi1YlTS8fG+q7zXy1tTllyLW4qCmzE/CUXIj18NHpMiXTB1V6V0Ozv
         6/JH+Xt31B1jNmxNJq/4qbpsAZNvvGEFrhXPbXz/oxT4iJnOBan6qta+zwPM3qbRKOMJ
         TdIWvu2DvwnnP2qEg28f9J4QZDv4nHpbzrY6QoBWkBqmD8mUGoMbSF1+Z4BmSC+gR2xU
         oa+A==
X-Forwarded-Encrypted: i=1; AKwUvBzT9cvCPRShr7+yvXvZ74/iIsk3l97IFI3XMwII2ta12oYpF7IBzaCo2iW2lYbhHPWm8b5JoJFPA02KkSA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKLTNRoYMhQJuvHbYuX8ISMWNw0WnNH5xI27uAe8nBZOHt3moAO
	NuJRypswUYc/PdT4pE0D37p+OsYAJmQGOlih4bxBm2bpvQxlSv14h0Xv
X-Gm-Gg: AYBFou3he42Hs7zccSotKWDLjoBzQSykRUj/alsZITvp4HjHPGpXPxJ2zjQEQ/GS6a8
	qUckIVPRvF3RdbaUwGYGLCSMzSmc5vyITie2PsAg8Pezc+JV43txarvbc6MyBjtxhB7puz9l4sD
	GpKZAut1vjWOWKkmbqrqquOrWeRRZTFuslYhTCiJYyaflTNNFDx8JeeVIQ4VIE83lsaqDETfz20
	+vCqd4oaDHpSypBje77lW9XhZQexsz8HvXjVpLqxTsNLRN8zlLpFf+ydKSXjOPPmqTI3IE9FImz
	fI16rnUkSbThHGvbjS4Nm2Cbm4y0Gq8RSCKRMRkFI3uoKirDOiwS6Rj6H6qu1HDyBQKT4HaNJeG
	4+YwV8DFoR5y/wKuv1PvbPQItJJv1OCNlUX3gFLqGLMDYwOptutZZWRnY3PR8QWMO1FDjLhWRVw
	9f1PXCQRrKXXk9DCSfRT0BUnyZa81tKqn2umOElih203k764hSZQDpsEMFDWHVXSoaCf7fl4jZ1
	pL6xJPLV0oAM/AWVuZhllNKp5kxWKXgxOjxsCl1fs/jK6rYIDeEtpKvxuTLBCOL4m9Uj7S0+cLp
	kUlB2l9moIplzA==
X-Received: by 2002:a17:902:f706:b0:2dd:c053:82f1 with SMTP id d9443c01a7336-2e842cdb110mr149481055ad.40.1792029037428;
        Wed, 14 Oct 2026 18:50:37 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:50:35 -0700 (PDT)
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
Subject: [PATCH v2 24/25] ASoC: rockchip: rk3399_gru_sound: Mark the link as started on success
Date: Thu, 15 Oct 2026 08:43:23 +0700
Message-ID: <20261015014324.5569-25-phucduc.bui@gmail.com>
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
from rockchip_sound_startup(). ASoC only marks the DAI link as started
when .startup() returns 0.

This currently has no functional impact, as there is no .shutdown()
callback in the relevant snd_soc_ops. Still, return 0 explicitly on
success to match what ASoC expects and ensure the DAI link is correctly
marked as started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 04e7bed8275d..d4a0daabfb42 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -258,10 +258,20 @@ static int rockchip_sound_dmic_hw_params(struct snd_pcm_substream *substream,
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
+	/*
+	 * ASoC only marks the DAI link as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI link is correctly marked as started.
+	 */
+	return 0;
 }
 
 static const struct snd_soc_ops rockchip_sound_max98357a_ops = {
-- 
2.43.0


