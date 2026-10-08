Return-Path: <linuxppc-dev+bounces-29032-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43179CA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:40:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mj65Vnjz30gC;
	Thu, 08 Oct 2026 21:40:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456010;
	cv=none; b=Vr5Z+qCavQK8c0z8una2ybKL/UtTnZEMXfJ65iIIEAXaBMUSoVM5fXEpmiaJrPGDOcLLBvloL55e+aSRuYf7P+KHxy3kq6pmOgtJa9fOJQGcIkI7XfVlS6XMxfuduAYmB+fXLGcpvLD+w7cFKMxHp/niTOngbyLLQ7sU0wbITqwclm0KsFfSNVVcbcYwL/kB9aGSVRlbuxgmXDxyjhFCZVnUQiAtkMzpahfFQuehK/dDkVqfRuW1fGLPs5lBBPN8R+JSc0nRttVh0ZIKZ6ixcaHwAklWlDPive0yWoAYY7OaXt0GwgPWp2QCqbwjOM6PH9jE8A02OTxEGCkv0bbu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456010; c=relaxed/relaxed;
	bh=l9nxhJUopT9Lxb0IcO/P1HkSQbbENhmHQ1cr6x4IK+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikLXijf5hZtumyijG9AVvBNYZZBsnjNGfXpOrK4Zs4L1glmGNfbS4XioKb7awLNBmS6okmnmQceInZkpPlUcNPWsBPF+1kZsAx5Y1SCKfAfAAAnRch88iRxxy0ASXKgXGTVRiruuTc1LXQyDNpkZHDBZ+WsXIF36KXFD1i1SuoUhrPe9Gdn4GKK+LAEIKP0W+50PIl4og+XgA9/Sc4rVGcW26xh/mSqAzj8iU0/VmP/rzwLXGv+MbANjRkLq1JK/zVloDqJnj8fCezYWOtQR1y323klOWaLfeWwrkPGe/LRaiZvIpNfdbOn7ujmrfzdhsnrDUJT2b+CIvY5bcnjp9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gIGn70JC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gIGn70JC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mj56Vw9z30YZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:40:09 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-35154cb9de2so4039644eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456008; x=1792060808; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l9nxhJUopT9Lxb0IcO/P1HkSQbbENhmHQ1cr6x4IK+g=;
        b=gIGn70JC8AyNBj2QowxFL2WKvYXccwhlWdsTgLx1B1U87UjhpwUoGA7fAUGGxw/5c+
         wc1O3rDGVlkTiIww/2XLfHMDD7T+AHEi5WAM2Qd/szMMpbxEzgfKM7tnoxQFXzhjdsmN
         i5l4NwbD+Ya70c3qz0M82q4wa2Md6wCImDDX8bNyb5j/9MDKNXOUhdPqVoNHFbUgpXvi
         pu0P0cLQEAwVnLqgbHJm4F/mhd5TrRa8CFGiSU2GP0Nn3vC9hhsLEqcX1RwxrfJML8pZ
         o8ilfm4jBaJ31iTerIVrnvdOJguPEzg+X6MFpGwKSYCG6cBwvJyJmK3LlIvr23PWAu94
         Hg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456008; x=1792060808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l9nxhJUopT9Lxb0IcO/P1HkSQbbENhmHQ1cr6x4IK+g=;
        b=wNTPD6v+Mlh52PY4QuRAgRUOCGf5n7v14osNQNjaaWPhndQQwb+P4ujrVbMJcbzeXG
         Du0Xt70LzUtB5Z0KFtgb4zuw+Tw4Bkscn2z1o2jA9JXk4UAUC1ZHSlJu6oduYv7dJQPv
         8qoicRmkEUIu/vqXB27he53VKSO8l2nas5I1iOY+e2bcUtinKg4EJrY89WF79HqBMJG1
         uPa7hWjfnyVtVIKqKayupo7al5g+s5xrJE0EiuUs4PGDSlIqujk5By2B8JhEBiACcHsX
         JUs2Fq1USDRQCCq4jBEjosIBgeDQn6DoyK+zh7O5gZXsePEsI4tTIaMkraa4Mm5LcYI2
         7t3g==
X-Forwarded-Encrypted: i=1; AKwUvBzMmDANLxmdvnE1g4spQ14otE6dXdi5BhB1t1/S61SbVbmC9qibv0HWDAeLr9ilengLhRZmYfJx2ry0c0Y=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJVn3x3w+XDtiZXn0d/sMwUWLKFPIV8dqP4BL6n0Y1XjSfBflCf
	dh1+ThBAwlZuIA9jWX1zg+EO+GItxgauYG8s5hUVzuY6b35DtHo4V83/
X-Gm-Gg: AYBFou0996O8wc+7q89ZFJTkUeLFXrVDPQ5hUdfWE5+CuXHTcNxoHcuG6iDm+Tn2bR5
	dNEHi1chG8fs1j5jp2frhz29fXTlswoi/zFE2QyN5gEl+g5jqkpUMC31RsrXOcIGLpWAO3z0PjJ
	A+5cljskTrF1haWS9AqQVqQKZP4V+GGc67PotW6EgUcBhUAkTrST7KLXfp2mIQ/bLGwKp/4tpmT
	sRUVAWJWmi/ZD0v8UjrM9Ae99R3Dt4xX62QDcTQWSAG4faEQ08Yd5i2vfhmKbMYeW9rCTCspng4
	eeuEZPulqmbfknvctq3ten/CoIOEe8isq12HyQFzFQdflE6HvV+HZa6XOcQpsBLYNqwlcHFzTW/
	9pfTb+CphXmQU2zMCxL+wSJ7jZxhb6dd8QEp52QV5Ea5Jv6ZsjUlN3OYUdSO/E/Gs39CliFRMuk
	mgs3v7BgVLFEh870SEHNWgc+h6waHtZBScoWl9gRCwdXUeJJw0shPdkeLZF9i7Rq26ixtFn2JC6
	A3T+zaQGrT3jSurvybQooGHPhvOJ18iF3iPrjciFgiLNFSgbp7IMdhCpeuqo/pVm6Gb+L5UApLp
	Gb8LZjtR58OWDA==
X-Received: by 2002:a05:7301:1e84:b0:350:89a8:5598 with SMTP id 5a478bee46e88-3515ddb2b12mr7233126eec.9.1791456007627;
        Thu, 08 Oct 2026 03:40:07 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:40:05 -0700 (PDT)
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
Subject: [PATCH 04/24] ASoC: amd: raven: Fix acp3x_dma_close() being skipped on rollback
Date: Thu,  8 Oct 2026 17:38:11 +0700
Message-ID: <20261008103831.542533-5-phucduc.bui@gmail.com>
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
from acp3x_dma_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 703a6e22888b ("ASoC: amd: Enabling I2S instance in DMA and DAI")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 37ea5c572eb9..072f3dc35d40 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -237,7 +237,7 @@ static int acp3x_dma_open(struct snd_soc_component *component,
 
 	i2s_data->acp3x_base = adata->acp3x_base;
 	runtime->private_data = i2s_data;
-	return ret;
+	return 0;
 }
 
 
-- 
2.43.0


