Return-Path: <linuxppc-dev+bounces-29040-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3586CA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:42:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mlM1Wfdz3bh4;
	Thu, 08 Oct 2026 21:42:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456127;
	cv=none; b=gLKeb6qc3HcwHgzKz2fAK0u/ugZYdFjXFiI9i8LyrTEhAoIA2pisJzT7C4BBTnZe6gdVjvKbIwGQbNXb14HOfjmbGCmsfRp9DqCD3ij/58eOstvi8IQpQvNPmLYYBY1fY6UbOgMur/6jdiKaXUuU3z57XbIpRC2jjcgYAzT6a/yZYXRD85ugSmIM+aK9pIVIe0NZj7LEpI/nWqx2NZUokkrNSD6eQ8TjkhpC/lPSJhAI6GKnM89vNVyMPaxwlcXMtwW9jcXZ2S/T5gjVZM4T1dCrxPcDm8DgYCLsKu/nlv8mmsllsDrFjQA3XJyFOdwxt6NZxkAcPpeG5hXEMGflOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456127; c=relaxed/relaxed;
	bh=+TNcAidsp1/YnKu0SMvrWqoUUNkBNLGyi1C+4A88wdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhsiLM3/RuMjMHKCE4VaMlD6fZ95aBunVD8+56322OtOp16hs3KY0cDeZCh7Mnbc9GNVyjFP0gq1yJvKgv0qBd7uVKtfXHDMwxDp2Fqk0q+E2Jpx6m0zUieIoLDeraSi6xen3cTcnG8tC2+nYuZwGbs7Wkx3DZ87TiWSTSoO/h4ix6JYz4OpaeORgSVdDLMQZj2pq1dbj9rjSnEygefpbLH0WpRSdasl8A+s34yrZolzqmx2WCpJt2AC9orTh4idjn8RHJqPYbhD7gfxbQRY9xrvm3B8UVBdv93KIvugD5PoHT4ajxvvPWV/IBa8/10OJ/2f/f88Ucnp3DhlRT5u9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a0rmhNdM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a0rmhNdM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mlL2g9dz3bgK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:42:06 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-30b6dad2382so6460088eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456124; x=1792060924; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+TNcAidsp1/YnKu0SMvrWqoUUNkBNLGyi1C+4A88wdo=;
        b=a0rmhNdMx6W6KA9U9hc/EfrVaMr4vvihrVfpzw6ISc/Ql1vOu+A81vLlyANlZLJniW
         yf4qpM4wE27XZmJB64Tj/R4eerT/COGA38KwEA2n7EJNEcDv19e6pEAWs/tfZVvalnxW
         jxEDxOgSEdgF3qlU4jX7wff8AEVMeqYa10QWWVTkFoecNse7uGRtlWipL8KMYia5IobJ
         +DPxQxZuel8R9OkRsuqrApanNmXTTmiWXrs7iQicxr8Ai5JA6xQ4+YG+U7Oni+Vp/mOU
         Zg1HPLN54jqR94OFkYgTLZin/uq39tSGcvwZMQ53jl3RuZNm/dJB/fWtgyCIPXdTpvtY
         GeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456124; x=1792060924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+TNcAidsp1/YnKu0SMvrWqoUUNkBNLGyi1C+4A88wdo=;
        b=obvwb+WAqv/h966AC7BFyjkc6FVMtqpttppV0X0qIsCWfhQeeOFUcA0yV9r5L0WCAe
         U7c1jk3Bjl8Xep5i4vmEv2Y5Xvul7tRS8ifiICx/5O5sgcjzQrstAuVm9KCr/9C2Ld9V
         iVZ4s7rhl0dizZ7VsIQopgzEEo0o09KEDy93UGBRnnhjTvCMIiXKk9tcxDfiie1GK3yA
         hGzwJtOo1UDUvZiau+Pxkg6Ba3H/ANX3//ds+G48K3bBgAItGNZig21j+BL36k+dC8Lr
         QEPA8r8vrSm7QWyhSDAuU+vVjooDmGtI0V1Rb18UlpJPLC5+MVvtD8NvAU7t4N/gmVVb
         Jk7Q==
X-Forwarded-Encrypted: i=1; AKwUvBywTixWCnULBvF52RKwgN+btlMq0Ux/kCnSW57q/vXzGJOHLXrmX1C8dfLpyWBx1/fkaxonh7eJGseSmmk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKxdsyl+QP2O4QdStdPV0DwX/gPDkicHcc48/6QSDFgmURbUaVu
	SVTQiygWUNeHHPu0eJ5pMWEE3p3lmMxNgYyi8+qZhD8FgVGXmekRvZgX
X-Gm-Gg: AYBFou0mlVFA3853aZdwJcQNj/b8nNKnF+oVH4BEVXlqtlHzlsU5r6ffOqZO8z+g8CE
	UgGKOarJS03Fek3lhd3ssZRRwHh3z+NTraTjD+18ZSpQ1ZzAsuk6+FM46fQRh/NNo15UVhWb8fF
	XuzLNEVQyDWvOA7uXel0bvvAWN0zTThMJw+GPNtNV0e6xKu1xzORmAkpmGEcJFawlI5Rn28yteC
	TcAqeezz6mfDPC84pMWzUqodomyQgZilL2xisWDepx+9aLw47rAQ9u1+wPc9nXS8s4Tbf7tInLH
	6aTHEtyr2NsK8ZEagXqOF8vWoNYAQ0aF/hdyYRNQBeXL13XSJWpaX7+ef1nleZHOB0RfxCS8EKL
	f2Cly5+uKWjG1OzsZ9v7grlJXvk72OrH9Iyaw6YFpu7mHROi0e0PogTiyWMv6BpLxCH8MSnEuLA
	5y0asyw8EkviCJe11UWqypol4iQHNlsNBZvBfAgfI/o76wGp1R2W3vkgo4zYqZ26VlnA1CZncSm
	C9hBdWi4gneI8m6drC8bF7L0CIa+OuxweSXKZKU/nLEZ4i9BNguAUY0KJ0hgy0C4bJ0LJPGtgNf
	Xgmf6yEJ4hw4yQ==
X-Received: by 2002:a05:7301:7a0a:b0:351:1230:5087 with SMTP id 5a478bee46e88-3515dd3322amr6214040eec.12.1791456124010;
        Thu, 08 Oct 2026 03:42:04 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:42:03 -0700 (PDT)
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
Subject: [PATCH 12/24] ASoC: codecs: nau8540: Ensure the DAI is marked as started on success
Date: Thu,  8 Oct 2026 17:38:19 +0700
Message-ID: <20261008103831.542533-13-phucduc.bui@gmail.com>
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
from nau8540_dai_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as nau8540_dai_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/codecs/nau8540.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index d4211a76b096..9484388ab262 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -419,14 +419,19 @@ static int nau8540_dai_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct nau8540 *nau8540 = snd_soc_component_get_drvdata(component);
 	const struct nau8540_osr_attr *osr;
+	int ret;
 
 	osr = nau8540_get_osr(nau8540);
 	if (!osr || !osr->osr)
 		return -EINVAL;
 
-	return snd_pcm_hw_constraint_minmax(substream->runtime,
-					    SNDRV_PCM_HW_PARAM_RATE,
-					    0, CLK_ADC_MAX / osr->osr);
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_RATE,
+					   0, CLK_ADC_MAX / osr->osr);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int nau8540_hw_params(struct snd_pcm_substream *substream,
-- 
2.43.0


