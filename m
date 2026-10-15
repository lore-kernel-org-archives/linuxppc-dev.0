Return-Path: <linuxppc-dev+bounces-29522-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C96CC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:45:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rWJ3jStz3brv;
	Thu, 15 Oct 2026 12:45:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028748;
	cv=none; b=RDtNUy//oqL63WaHaZwFeQnwUinrESHHcjj95pBOLffgn4owxyeGi9jkPK4xYst12qYdAAy1eJvUEfBIkPMhxbdFRgjyfxwU3J9aBugStcx8b8+w8s60hAH4U0JorLbxBZMblhnU6jyhihujWJFfEXuVkE3y4kmcgBge80HlfgAIqzrkgYOovRDCQ8EoB6lh0i5S5TuJTBGOtrrDTrXhFTdcuAUn0MsljpikgV7104tRMQdWE1nCvyIUh+yVzDBevy1jBsc7uPvgotFajsnw5taJ6Fek1HAlKLe5Mx1qBmUqXZR0Rcr0AdJK0KZnlPI2w66/b7W+zCKjHrBEK68QUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028748; c=relaxed/relaxed;
	bh=/n4smlFZhMXZJQElrsN5vEKX5hOiO4PseO+WVYrBqMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJzBZuCifcJymQOR9okJTbO8dd4laNEMZpSZv8RUr9KDLlVzsZ7dFWDG8m3A0zrHdQn5CtK6x4CGVDFFXQm+fR/85v/TKuKtK01AmTgMkoBOhZV7lh5SxpHDA0oNXOngPGUTNADygJ2vl307EvcV9CFWzmf0/pSCMri5SSDRV32LA/oDVnvmOss4Lkl3Q2iD/5qIPqGQpKR64ATWJ1tJlnSzmb+Bx8ez8nUlLPrA0UgMy5+0OhE1veqK1rA7QSq//zHmRBRwZVrnuYBeHOsWspM43inBrghh9TXJ4qUGTdzGr698x2CYwb9sotmqLMpf8dzCTEKgtzWzjy2JTVR6Nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lYNdT0Fn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lYNdT0Fn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rWH5c8Kz3brr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:45:47 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2e7e742a2c7so32165885ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028745; x=1792633545; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/n4smlFZhMXZJQElrsN5vEKX5hOiO4PseO+WVYrBqMc=;
        b=lYNdT0FnoLjgUmkzuQNdhiY6tIdNYMBLxhgSHj+9WjWyoJWvoJaIcoxDjvXOlaBnG1
         seMLS85ns++pUcSw9QB5CFdhSEYBZ8mHuvDrKnhq8TppjncOFu558Heohgkz3HiyhONI
         t9ASLSgfZYTreqblmsyIbcemHbhrRCNKrItlQGZ4ioxxfoXtoQTp+PPxbru48Zw1lNjx
         s7YEaZ/G+TRwgQcKgvUNTj6MYAiHJFwwaCcVUAmz4UZRX7swOSLYJHBGvQMuL0JwC44C
         bONkAkHau40xhfEO6O4jEmd11d6kjjldiEBWMJWJwk6fyvva7IRVTqXMXjcb8mahCtj5
         vRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028745; x=1792633545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/n4smlFZhMXZJQElrsN5vEKX5hOiO4PseO+WVYrBqMc=;
        b=QbYO6GaHO7j0/ZeWl4QKMoTpzHg7ijO9xhumZ52le8GhWjE2II/bSYvY4vYkebZIXl
         Jtk1N0d5D8puxMUFioHzVhvIQssw7xFUxxnQbJBgyZ8GiTSs4iAiU+0d35PsML7KcdTh
         mFNJ72DK5GP01ViSYLd2doT4CzFJJtTsK5s2pqSEiFgcqoR+8bQ9pWqTPKT5FT4ARKzw
         BlmTVJZCJx7wOTsNoPzEQy3/hB0ftx5+a/QubloTHvmLHALQAcGMUayUlbiNicQqbUoe
         G77ZaWqdXzdXCCOzYall83rO0hQHvjFTMSPEj3bqLAG7wo7sg8u0l2Hzhg/eYsNSGOwn
         l5jg==
X-Forwarded-Encrypted: i=1; AKwUvBwN4qT9fyOjLTldQhbHtoxmr5GK3Ke/ZCfrzqWCCd8c8VmB5//8qO/VvXmgTwRWfp7sWVcPlJSy/D9L3/U=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKnLwWIg7n7k2mk4fuaQbxrNyugw5So9tKYV4QUKb/FJEvvq5EH
	Jy62vIn2Upcih1W8t8fjZgdq2pHT40dOnZM8qsc05Qb7otup9m1jK1Gt
X-Gm-Gg: AYBFou1+7447hWVIvfEmuPOxNpFfLwYEdR5GdHa/1gaJ4uok0qBZzPS3v8YOU3tQlGZ
	Na7atCaltqllK94y4lN+C3fXv4pziyXE3ftv+DDxQhGW47ieJZIuXxAsOgE8L3J80BTRSU0sh/P
	OpB2vGh7CQxuV09ihBMSIGH/oJj+IVem3B95yVDnZ3T82hlKJ30FmfX2NCV0zHWMH0sq71JPrC3
	ex08qHLCuSw2jlQq9D9EuTgJ4j8ZVnzzpda9m5jcdM1HXKSfLiAUb2VDRqhUgtZGd5WgP9/uKgE
	ot4lRoos0B8+2Bt9BV4KfPGYSmCZvG8irXxS1ANCQ7jrd5IIPuNhLxF/j/Lfn8VonOTys+mxRdp
	L4SREAZqe59l94yhzyQpkReSZLKEIE5osXOUwB3Uln5E8LctrkqAR7h8gN3QeN2v+9zGkbyvXb+
	Z14Up3/BjYEdOQCOmi4dOBQYF5MBu9+UM9cuORZq7n0UDpo8H/ZnkPRwyUU+sSXmzzFEPlqbOZ0
	FT2S0SLygaRWwTob3WzOFWKUByTheZg4Kdo+KHcpM9DLNkTmkP7xA5oXnKNOiFCE9/uFn2xHafb
	u/Y6GDEpFUKdjA==
X-Received: by 2002:a17:903:1b70:b0:2e6:e9a:eb48 with SMTP id d9443c01a7336-2e842f2d257mr110492185ad.41.1792028745495;
        Wed, 14 Oct 2026 18:45:45 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:45:45 -0700 (PDT)
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
Subject: [PATCH v2 06/25] ASoC: amd: vangogh: Fix acp5x_dma_close() being skipped on rollback
Date: Thu, 15 Oct 2026 08:43:05 +0700
Message-ID: <20261015014324.5569-7-phucduc.bui@gmail.com>
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

snd_pcm_hw_constraint_integer() may return 1, which is then returned
from acp5x_dma_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: cab396d8b22c ("ASoC: amd: add ACP5x pcm dma driver ops")
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index 831e30e9b042..72050fa2de80 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -231,7 +231,13 @@ static int acp5x_dma_open(struct snd_soc_component *component,
 	}
 	i2s_data->acp5x_base = adata->acp5x_base;
 	runtime->private_data = i2s_data;
-	return ret;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
+	return 0;
 }
 
 static int acp5x_dma_hw_params(struct snd_soc_component *component,
-- 
2.43.0


