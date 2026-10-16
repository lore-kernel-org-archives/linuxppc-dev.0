Return-Path: <linuxppc-dev+bounces-29587-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E66CC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:11:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5WjP0LLCz2yf9;
	Fri, 16 Oct 2026 15:11:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123913;
	cv=none; b=b+KUzhf5dGvqZF+0IhDe50Yhcgdl9Am3fp/dOn9XKogwoC3xFvu/MBtFC8J6nKgLtSeqLiQVC7+ZPQ4tJrzyF78lmuP7jc8COMSknLRysE1pRJ9WyBFkj/NrjOgpmIeG6KRzpJYVzVUZstMfl6nnmlNkDaqojvtc0Vu2EaqGS8zC/8VZmjTjpTPOYMvG3D8HHMguRDC3uzYsiR14mXWKWH83BtGoWmWrOIes6IDAiqACf2zLr61r330CDrR0YrG+TrmUTgcS1zPUjSljNDUgvZRHSn++fD3i4cgDXgjp+mSiXclC3oRiJX24txw3nPlZSgECCTUD+B4zYYljCZntxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123913; c=relaxed/relaxed;
	bh=DnS3efznOy4aR/sEoOKiH1O7kNcA8JAEG4dTp1VvwAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqXym1I6LoaruaCs9VlWO7WKWU4IgTB0DjAgj5lKWVxxwN9HQ1q3YoagsWvltHtOy6ZYtarjOhG8CZ2TSBmJvZSfKr9ey34OyF7+PNUJ9hbZJg64G9SB6/upf0E5gYHbaYFtRgTcnXGXWjsR1uSegAzLFcmHssZejMVsZww2IFrXuB7s18qoxFIH59PjnYrfwrnxGTdKKSF/GfYQqGf4nNAo0uNH8awLkW1D588gQvCfdNZFT97JxUICzDnT2ykeLELziK82ZPKrCw9732ng8VurmcsHEefAY5xQ2/y811Csg/EOxuzOFJcc7n01ULogZoulb81ramxOc1/qSXU7Yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c2tqpacA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c2tqpacA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5WjN23wdz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:11:52 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2e977109392so5456155ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123910; x=1792728710; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DnS3efznOy4aR/sEoOKiH1O7kNcA8JAEG4dTp1VvwAA=;
        b=c2tqpacAAS1hIy0EeJOVx0xpVD242gpwRwNrtvExic4noCakblewpHgiFjenYknO3G
         7qSXVyyjPyIR3+6MJljcB5AofLSoEG8/WDksOli8gq2CjroWKPExcxiDojs7d0UePLyi
         TooGEumRrmJOR6sX8vC62TwrP10K7rz5XmLvZfY9UegADxJRX9/aJ5DoHhjt+vydui+V
         QQHDOdwS9SEp7Uakq2Y8LTwBPWhgBZ3ICCE2zVLtjXn4biL0dYBLG12f4l8fuvh2iSWA
         01EzIr9Z/jOmCYsk9zgOiB6pzS7ZlzpC6irvMJw3pGun1UnQSjntJNyCBIAr6o7Np3fr
         DfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123910; x=1792728710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DnS3efznOy4aR/sEoOKiH1O7kNcA8JAEG4dTp1VvwAA=;
        b=EfS/jBQE5OfQFIPErCezUexYTWQJEkURuWvRi02CNkXNMb4+4xuUciZelWnuag+IMr
         n5UsU/KMT65P7ts7QEm1scpmapPNprhyNe/PQxAWjS/7cVqlkzryc5buGk6kFmndM4m2
         NiG4A7wnIy4/tAE0zWlRDXQi4Tb2fsGxPqiQFqh6Vt6uqKn/r7rcA+KOXm7h/3kCj43L
         8VTb0x4FYch5Pra8okANUyxpaNEjON1O6gcAt/3mljNO+NIgZ0c+pMANWHNFRHzc9Moa
         CaarDuEbFFU758s4aMnl80SghAXa0HcSxVrXI9TECw1fmD9t5fZEoXqBZp0ie3wcIoVA
         iaRw==
X-Forwarded-Encrypted: i=1; AKwUvBw42W9ijs+fUGjE5CYcPaX/VvYWTABAGbS3Y8C8opzvOknynPn9+wZ+D+iszBjQG8HpKrSnNS6oFv8sRE4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJV5Ciuk5axtt9/ArmfNtoFlo/C/wrE6ZypHx8hySTR7ttAOKRn
	gh9dmjGtMoYW5dlf25tU2Phj20G6hw30izq2gd6WJRoCXFvHbIMcMRfs
X-Gm-Gg: AYBFou3wcT7s7FftP/TSAdSuK7HqgP1u1aZaNHYyADCbNhPPovZ7qJ1O1og6V6ku7jj
	ThVi2RcaydjVw966yUViY/V6c1bzLlnd3D7A4dsmP/9pG5b2TPsie43yBYdbzKQlocVyN3g/IG6
	B8Yj6hu2BUNJzVyqVulufmwnoz79FNZi68PZjsEOS7Ip8qxc4qAJTsvu/K/cNsHyh7vOLZ5eH3L
	tEEXvwSeSPEjoOFfCskZglsqkPa9Epsu/SudBrhdd8JMP+7iEEB0cs04ePXuuCVWOFeUa4am1A8
	JOvn3G/uyILkRa55odTXfdPakUqa5nkMt3ElvdvPfmUW+j8mtKsksyHBr7AFiBY1wpiC1qRnx6X
	3hsXgUDlFdDAdZ09t7XhK1u92OCsxNIkhZq1pWcJCjqWobk9+H8e6BDGiowDJShuwcyTasSBfJp
	Hx1C0Pl7DfDRvspX0mVabfKHZQ1Iv++RJvgK7Zlb2F8ddQHiYhfjd7S/WKmxGYY7CcxL6DHD1sh
	YbKVxQT9Ja3lkuhg5u4X+mtfz0zkxGEg71DeQJQlHZEzrMLAYgi5Lo1oibfu2lxcY6bvKzjRzhZ
	p+3lwZrZmg/Cbg==
X-Received: by 2002:a17:903:38c4:b0:2dd:c100:4257 with SMTP id d9443c01a7336-2e842f11875mr181177615ad.59.1792123910214;
        Thu, 15 Oct 2026 21:11:50 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm3815785ad.65.2026.10.15.21.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:11:49 -0700 (PDT)
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
Subject: [PATCH 08/11] ASoC: renesas: msiof: Remove redundant period constraint
Date: Fri, 16 Oct 2026 11:09:43 +0700
Message-ID: <20261016040946.521195-9-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016040946.521195-1-phucduc.bui@gmail.com>
References: <20261016040946.521195-1-phucduc.bui@gmail.com>
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

snd_pcm_hw_constraint_integer() is already called by
snd_dmaengine_pcm_open(). Calling it again in msiof_open() is
unnecessary, as the constraint is already applied and the second
call returns 0.

Remove the redundant constraint call.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/renesas/rcar/msiof.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/renesas/rcar/msiof.c b/sound/soc/renesas/rcar/msiof.c
index 9fead9a22cdc..11a6f22ec0ad 100644
--- a/sound/soc/renesas/rcar/msiof.c
+++ b/sound/soc/renesas/rcar/msiof.c
@@ -419,19 +419,13 @@ static int msiof_open(struct snd_soc_component *component,
 		return PTR_ERR(chan);
 
 	ret = snd_dmaengine_pcm_open(substream, chan);
-	if (ret < 0)
-		goto open_err_dma;
-
-	snd_soc_set_runtime_hwparams(substream, &msiof_pcm_hardware);
-
-	ret = snd_pcm_hw_constraint_integer(substream->runtime, SNDRV_PCM_HW_PARAM_PERIODS);
-
-open_err_dma:
 	if (ret < 0) {
 		dma_release_channel(chan);
 		return ret;
 	}
 
+	snd_soc_set_runtime_hwparams(substream, &msiof_pcm_hardware);
+
 	return 0;
 }
 
-- 
2.43.0


