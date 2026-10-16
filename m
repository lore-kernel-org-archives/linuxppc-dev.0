Return-Path: <linuxppc-dev+bounces-29584-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E961CC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:11:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5Whg6PSxz2yVL;
	Fri, 16 Oct 2026 15:11:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123875;
	cv=none; b=dUJctUcOWcgp6c9cF4h1JtCMnPoh35965luhEhbfzoregNJfoBcZ+v3tBSCktgtaCsmCa0ufUHbjX+yhTDdhR6NCVtKp6GRq61nSFWde+dJaZjC6sPJoLS4EbWbqvgJNCnHEbgc6/PHDerlJTB77LVxOn6Hz70ueQuCCtLkG+pMjjkDGa5eEIOC/+XjxlWXozL15uDQeBGesjatol30DDhPvcqQyz+KOMYk09twjxIb5MtQrzXoLeDqBWbGlMu5sULDrcEJqt4LR67JWEaorkiq+KVevKbcCmaRoFIJeh+wPUBMKkvmGlBaQtxMlozA3+lQW2TdnyybCN6QdQw0rvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123875; c=relaxed/relaxed;
	bh=QXlahNE+Wx5snJLp/MKBjKZg6Q+5VrSpbj2QDx2YWrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7CrpgfnGnhd7Hldj8HQszLkBLyhKbfuSAI/G7DlNUUsnOc4rxW/oghvT+lT7VVHQ8aAxEbOGDIpR7UVTTVsUuXxTGfJLcDoAydzgLiKViJ2/UQsiiU0VsI0rDOnMY2tHeupJPa/fSRHeC+L/qPnt7okHFnpLmU2DvHMM+5XVlWViT2LL79ULI6yXgZAVfo/gMYea+JcTsGSML3mM+KBwdl0Hk3fA8VVCAGG+lvLj16YI5xOFg+fLNkhify/d/b/fpkgIdyi6dB46WM89OTNf4l/IqpFc3FLZIdedDnB/2KviU18ZMAwVziQc2WBZ1VWPn8/+SxucdYdm1QVBFxG3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kr7uRBoJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kr7uRBoJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5Whg2Bdmz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:11:15 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2e812e2b31bso34992245ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123873; x=1792728673; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXlahNE+Wx5snJLp/MKBjKZg6Q+5VrSpbj2QDx2YWrA=;
        b=Kr7uRBoJMitwLm8Zd35gawaLSnpKKUzg+K0ss54MPMsDBkeidDWIbP8vx3U9eUB6br
         HK8CFoBr4LLDGVfhIzQU6PxR7VOWFhsanoSOdeKsRa2aTGPCVYhDN7LJc/NN0yYs+jIt
         vL13xD9FTDI9o7uvgPnSRuKTf1C+UcUEbDSaxCO4k4fpvGRK+b9ttZ+zM0rRZasbLxBv
         T4ibgDOjFZBD7Vut3osRdB7ajAmgjWub4XQW5aABqvnke5DCyhU94dTsrL9WXUgcz4+U
         CsVmMGZDXsoNda9QxxLicK6a+wgUeb9htJmfKu2QQtv8/eS6pkc63iRYcg7EXPbuZDjs
         /7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123873; x=1792728673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXlahNE+Wx5snJLp/MKBjKZg6Q+5VrSpbj2QDx2YWrA=;
        b=ZfId3aRpTfc5JpICvWBNVUfN0u3YuP12rI8cOpm7WJvDY1JbXDqVI+qCCpPrkWguYu
         P0dKjhFRBYfQ59tgCZM8I5E0ZqIsMLOlXti4wz/t5lm491XojzHOxXfGrmLus45MmNdV
         79Ek7KxYIE6BY/HKbPbGxIl/oAq5ThGRmhEzEjyucQNt7pObo8DbhshJH/GG3n2+GnJy
         EmQsrsTnYqMk+HNxW8ihgiEY0wQnQHesPFUhsWePkQPOoZPjF44TO5Ub86LVWABfMCUc
         DLOog62rR5aF6ta6BesINj29mlMkc9ueCztOlO3oiXs+mFGhQhLfhALSEziCebTSePyH
         ZB/g==
X-Forwarded-Encrypted: i=1; AKwUvBzIDcP45uwZj6Y2FT2+cw90ky0BqtPT+UrhDbaacp6MJW1Tf9oljhs+eTXcPeXZ2u4xKYA+8me1qPKBZeU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLfkjFf7MackW0k8NH0axn2fjtvvmd7oSPCjTTHeP2zD9eLMmup
	y4JtFYjS9kCOuIm3XAM2nq/43yHePPWZP4OrRwnJeftDwRfBZqhDLj1R
X-Gm-Gg: AYBFou1lQdUtc5ZT354ZwLpjS+fqIRJkxzBLqwx8DrJaBfibvrVzxzPRlAtiOYyFrHf
	skxzUHL1q2rsOXkWQCQQMJjYYN3LQ64er369Xbg4boFdwKzSKH120vv5gNPdPWsIwUHdd1X/dT4
	SuJZN9pTPDWaoG6K5QR/3w/tWb+qQGPW5IFXSJbAxYMVJ7oCfP22N6Y4O/C1E9ZwWnyfjxFpS19
	wuUqXL6GHXNelWX8zEivBg5+CjYSargY/BzufhycdR3sdvjB4TC4EFKM6CoZ0VuiYPOcG1AMhFp
	9/3qRZi6WuO2ewtzs3JGKKCI3EmTE2NIEuM0z4+F6+vNrWNhIiClfCcyBdYjLJlo5bl0WOIWKd6
	8PzqEwbIqyfRk9z5ZU/6tPe52uniYhdmPQv91ilrG94TlIJOG2a4GKu5Xl8nRwXBq++4IbDtch2
	PFmurK0IdGuNBkvr7mG5dlhp+YKAN3gpHfXMZU2mS8QkNP07dM1h3vpZl1/NCP2GsqQBwk7mBqR
	FWSTwx6fROXNDyF0xD0vTvfaimsRYkqANwAlENkbAE5R8k0bvNAUxILPO5+X3zPUCxHul66pl7t
	t6OVzuDwsihUzA==
X-Received: by 2002:a17:903:19cf:b0:2dd:c100:4b76 with SMTP id d9443c01a7336-2e842ce7c78mr210820935ad.45.1792123873102;
        Thu, 15 Oct 2026 21:11:13 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm3815785ad.65.2026.10.15.21.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:11:12 -0700 (PDT)
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
	bui duc phuc <phucduc.bui@gmail.com>,
	Chancel Liu <chancel.liu@gmail.com>
Subject: [PATCH 05/11] ASoC: imx-pcm-rpmsg: Explain component open return value handling
Date: Fri, 16 Oct 2026 11:09:40 +0700
Message-ID: <20261016040946.521195-6-phucduc.bui@gmail.com>
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

Add a comment explaining why .open() must return 0 on success
to ensure proper rollback handling and prevent future changes
from reintroducing the issue.

Reviewed-by: Chancel Liu <chancel.liu@gmail.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/imx-pcm-rpmsg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index 30e75fee5175..85b7c929a28a 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -269,6 +269,12 @@ static int imx_rpmsg_pcm_open(struct snd_soc_component *component,
 	info->stream_timer[substream->stream].substream = substream;
 	timer_setup(&info->stream_timer[substream->stream].timer,
 		    imx_rpmsg_timer_callback, 0);
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
 	return 0;
 }
 
-- 
2.43.0


