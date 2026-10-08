Return-Path: <linuxppc-dev+bounces-29036-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A9BCA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:41:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mkC6t1dz2yYK;
	Thu, 08 Oct 2026 21:41:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456067;
	cv=none; b=h3XUA3GHDelzEpLGTT97BhQehbs9gltYmLAAwUo3kyvRnDi520MOsNWu3aNypt/scNEZ0zvr8wSAmDsT0nC1t3HY6OlLUF9XVUImDQo9Ypt2xEypomSbnrBd9edwecTmoRuKA52DsnmODSXQk/AYy3I1OMHmSRKfzOH1oXD4+cr04q9tWuJjrl471pxdXHb4JTbTmyqr7GOrz1UcqRn7Y9hEM721PoXRxdiOMBMjwfKLe30ABv80Hhx/8iEP22kU+20B0p6BR08q9ZZS8BQciaBm5IsGGkoJSkD1p2Ovm/vhFprvYOIb7PM9j5dYtYVOd4SRbSqMcFAovwEDyiB23A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456067; c=relaxed/relaxed;
	bh=YTcgEknypy3JpI9J/G9mPIrbfMp+7I5/710LUj+4UxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Buc4ivokzSIbPLfe9jBUC77UONjn//IvFeSOjFDkDsEz6ohXmad76AwpMkzH3PDI/9C4/+qGz7oL5qtbtO3nwxA4W6ARrQp5GIQrMdi2H/xg0QhFASyPWImfN8fMBGj1WfHtEJ2DmJxSz/9d6eSvGZkl3M62jC4JdXetg6EHvFQq3zQyvklm1B5RQaSjupw+unKsurp4ShcviMLP+7OYS1yaecnnl4CzN5u+xhBOPMDNTUnO83rZhtOKD61CxiYqVGSlN3D0GI5y0IyHYDw0roBDKqML/VHqR4RX//dIF8R8wYkryHP0lNtffU8wHS+Ygg93Q3NlvnRCa07gGxvNmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EXJKw6B6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EXJKw6B6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mkC2JwKz2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:41:07 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-35154cb9de2so4040948eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456065; x=1792060865; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YTcgEknypy3JpI9J/G9mPIrbfMp+7I5/710LUj+4UxE=;
        b=EXJKw6B6b12l/egnlhiB6FhXkUcZ1HRfW68pJf2jcawsxNgLKRq+LMwp560/QwD/Ak
         gvEmlp5qqaib9BpEPMdDfiZsJ408BnOT2iv9ReWICeXr8PelTRgZVDckuubNOK75rAPb
         5S7jP2nsk3x+lVGA/fdQiMk7ELFk4to8DFAdAieWHm+bAolh4V0QzehVjJa6gbHd1bUf
         nZIzxy0tTkxOi3Jg6fRmwWa+IlIr/HHHIusNUYwplSUVJaDmu880Dlfcm5BKncF9HspR
         B9wza7/6/kg3fU9rupbFWfvCe0MNzNK9M9GBkB7yyNu2ZeCvAy4CoP56EC22Bbkv8YzB
         bxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456065; x=1792060865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YTcgEknypy3JpI9J/G9mPIrbfMp+7I5/710LUj+4UxE=;
        b=JYmvuj/Eoa01JCnluu1vKeuGyVmmbBZ//eMOKZPXpHmJCSsVK1hsKvi7c9zijVFTsX
         AbEYWYEnPjM3S31rqwCVR4zlr4Emy3u5y+iZOgp92qK2w08ZDPOh9FCuEYjYzglSazSi
         eUISTvPwgCa9g/vPN93Mglc/bjyFeYnLkXlw49qsMhO2O5Ec62mEueOBuQsHmbYelPKa
         ewAnSxmxEUr91RaoCM/41nh/4Lkx/QdZ/UtL0mB41joBwLCv8GaSF1HVibYl3qgXr5Hp
         Yxqe11SZnV3c3lkpTkKWw1o4udkgCkzI8Xd6c7+oCIwFhiDqjNMBNLvdAi2ea6XqA1nx
         izjA==
X-Forwarded-Encrypted: i=1; AKwUvBwfoAxvjDW54YdgKSiRicq39QcgiyT+bEcgJ3Wsc8IbwGrnKUIquVIwtyExgykL+9Qrz3pM4ts0zG93mDk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nn15UQ9uilfByAR6a3L1UTKFvs5vzl7JGnXf5g+Eo+d94mmPId
	msVwUHRyyAH9uEshGuHw96uQq/BKm2Fc4IIp1CYzbvUQpUYPnaYRJmmj
X-Gm-Gg: AYBFou1O5+izCKVMAr5P3juRBNBawqkjm6/0zSPU/9aJm+yKJOa+zI6ENgoCmBOwFbU
	xf3RkjWA6varki2dloXH1DLb32D+y0KGSzt6Ho/fxJkJmI1cBBJehjIckuRdhD146sWIarSXWjD
	WQF0bKBHrfpB6CSz/Q/5r7SLaoCu+h7LZH+/656gXkfip/jiDCzLr6EJ88MDhr5UVSrjqualFua
	/OLvYvL5XBQiqJYhmeg3GBhst1fZTMWlCCXysg8DGLkzQR8Dce5KitcEHb84pRDpOJm/f6d3IBp
	NebJwkny8OZf/7XY+fnKknWmrKCy+Nb1397jAOM2+09asK0/V1vosHH1J9Wulj6qVNUIRm8tCBz
	tfA/1HnZTjFPZYW7nrc18RNYOj/hgWAEe8e1QwGW9aZ2WSddV6sJqAPz4kDi+F4di3g/k0/6bA4
	h1yq80IYlORHB5fofTkGl/h0xOSG2gHXR/HB0l5a4iTpFfkFHNzpYwncSwUKRuIx7Uy+CqP76Bw
	fWhbLmmFU5k0YASOm/gF7eMFoKjJiB9bruLd+k4WgRMt9HZIzIvBFH63/WTchidjPPpeIj6kge/
	zTsE2ITHit1kug==
X-Received: by 2002:a05:693c:880d:20b0:34b:f279:2c16 with SMTP id 5a478bee46e88-3515db9190dmr5490986eec.5.1791456064946;
        Thu, 08 Oct 2026 03:41:04 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:41:04 -0700 (PDT)
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
Subject: [PATCH 08/24] ASoC: apple: mca: Ensure the DAI is marked as started on success
Date: Thu,  8 Oct 2026 17:38:15 +0700
Message-ID: <20261008103831.542533-9-phucduc.bui@gmail.com>
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
from mca_fe_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as mca_fe_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/apple/mca.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index be702b2942a5..3585432ad49b 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -516,6 +516,7 @@ static int mca_fe_startup(struct snd_pcm_substream *substream,
 {
 	struct mca_cluster *cl = mca_dai_to_cluster(dai);
 	unsigned int mask, nchannels;
+	int ret;
 
 	if (cl->tdm_slots) {
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -528,9 +529,13 @@ static int mca_fe_startup(struct snd_pcm_substream *substream,
 		nchannels = 2;
 	}
 
-	return snd_pcm_hw_constraint_minmax(substream->runtime,
-					    SNDRV_PCM_HW_PARAM_CHANNELS,
-					    1, nchannels);
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_CHANNELS,
+					   1, nchannels);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int mca_fe_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
-- 
2.43.0


