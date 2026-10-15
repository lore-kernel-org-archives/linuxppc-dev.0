Return-Path: <linuxppc-dev+bounces-29519-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6489FCC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:45:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rVW6GBHz3brr;
	Thu, 15 Oct 2026 12:45:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028707;
	cv=none; b=KQe6sEv4Na5JK+RrMna4RRFHMKQFEsbmjJmpD7ks1UwB5wVYaTfq1Zbu9ikABCKgjv/z5FHUMrEpJ4N1c8GWBct2n7MFYMzYtzkSd4bitJ+xDT2L0+FPowxDoQSVlNmyqAZhSO4IqIgnelWTk2b70cKKsV6RkGDVN1A54NBY5BvLTptj4T923ZZM+emQUA2qZME/LU6Tb0/mR2uGLJD00c+LmptMQc6HVPRpPpk6w1a5giOZTaCc1lF9M+tjH6YHRr8oYw0G3aPutw7ZdPJKVHxCYdIVjJg8kUDGiFqdRPGSDsXqcYX/x1QfU3v6KQd3DCNpP8xZ5JVTk8vgn5+0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028707; c=relaxed/relaxed;
	bh=tHQEAftjxeSOQpgNapgwf4pKKw/+LL69dyB2CtXEGKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qcji9tx9wg6RGkjoVzSYb04OmoGPzbRmwZ9URKuK3fdqK99ePDUqIxysINuN0iQw+y41lK1C30Dey5zW7LoWKsE7pgnir8odj8b7P7YaLTeHD7GxFuuOJKsjAHPwk0YDRQ5xrVKK9e8oMlecUN4Q0DBJxZwmTd9hkbfWY4ahroB8hvVA8MHv9T2bgsFwaLKO8OODt5VlVBmujXkiwJWxgBOyyo0Hh7wp0oH7WxuGABYO+2WV0Xb2pzPqal92zIGFV4BDi5FI2fDi8YmFxlS3Wu24qBcnE8NxMX6nOi7sP6CM+Sth0th4dtaLuZPDj2Z+ji4plEWcozyshaEdXOb0NQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gg1K7kIa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gg1K7kIa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rVV5V1qz3brM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:45:06 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2e831e86ebfso8942425ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028705; x=1792633505; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHQEAftjxeSOQpgNapgwf4pKKw/+LL69dyB2CtXEGKE=;
        b=gg1K7kIaXfdA/34w6HTBIqwqZzW+bDJzXSOEySDSfn7yIXCHtr+KdK+SKwO/TcgVGv
         lk9KZstj1g4/BL/qR0/1mmg8FupM/1RRYmJhWwsBlCiOR3tp7UnY2BiJ7KIZOrV72WX/
         ++WXDXLUlGbL1ghz8ktB5IL8B4pEBt3xems7N293TjEgPvy56QHsc383Skby63u6ggQn
         crlvyE6XLp8O7Eae/5C4+9U+lfAaVgErT3kDSmJYiqcEPponKLcMR4kWMG6uJImFNKfK
         rPgB+RQ9LGwgU8LiT8UvJpi1xUvZtx5UBSodgFxbCWf+8nMvRWmRSSPA74s4G5Uk3unV
         YiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028705; x=1792633505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tHQEAftjxeSOQpgNapgwf4pKKw/+LL69dyB2CtXEGKE=;
        b=exTHweUDMZp0Dw1FKVSrPOGwJmpiQyRuxr17dYMd+9RSPaaFX9/BxTcvBmNwnY2Xan
         JEgiabGS3nEgNn1y/PibxS/UPafpILspxMAfd7PBr0H5aIowsGJWw2Yhm32rGEzeBYez
         G5F3ypc/Tvqdn9baNF+GGDEuO4wqwhZq75rd9qzF/r01W9Prvfqs8CYgzsV9GVXABEgk
         oxX/CxPwbsBQmM1F3aUgirC8cQ27Az0KxWc2dXViqNSt1ksFtn9q5VK4hf6l6vr9TENu
         K4WMQU5Q48eHWL4liXwUn3/0dQsrkffqQb61TLhaTih9uOY2Jo3uzyRuXLqEwHBd6gwY
         vn5g==
X-Forwarded-Encrypted: i=1; AKwUvBzIUpL5eKBY5ZmhMypF2rl3oTVDoHU7uf6az70sL6orQd9dr9uKxEwMtvGOaJ6RtpZaRwwLzM/xmyr7B/w=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI6cJ2KWjNfS9UDHJUNG7udKAKvSJfMUWUJky69VIyXUuD5rTza
	02W1plDBcQ9Ob831taMS/R7CsIvNRTJXNDHIcn1HFEDuvx/tRJHdgp7x
X-Gm-Gg: AYBFou0rfKUqfazImOy0hYFcMmXxQoxBRVYHgW1+wbUc1opGwIpGdPfRFhiO/RiB2vY
	VHD9kd2HfpbYLh0ZABm2zLxmdyLCsx/R0k/PtHIFXabeMs6a0edDGXNEBT8iF1QJWWOBiSD+1+L
	ljpSs75ZhqDeA/YBnTFcXvs5khnMX+LcYOSzxu8Y8b+ZhEOKQOXJT7Goo4C0g48YMVUi6RE/gCf
	g1sLux4Wd6jtYq8RlFXNwCoejJJoCj5+ANVSUjAIuqw6mDS8Co5wEN8Mlw/b9jeCi7vpwlIM7tK
	8kfviOyMfnR1zzPIfXogav1dKAGI2ZJIs9O5Jo1BS8jy0p8RYc0hK9B6qw60F66j6EW3T4eRvGB
	F60zl9aQpP/lZwcUNvxAgax0sbzdv3lKOdHZFnyDsDWXlI34teVWOoEHqs4RbWwwlscK5ElVIXF
	mWStSiK5xvqMzxorJ6QPRopUz+UB83o4k9/0PfTdURG4ryNaGltDyOIFDualD6N3vzZLtQ0c+yw
	yqtb3g7jvoEsnXUm/v/eJc2H49RM6zq0xJ5rohnizeENzNhk4VwbUz3AOyo3Aci0iRI3d/KyRL4
	lwTvxqBe40P3VA==
X-Received: by 2002:a17:903:110e:b0:2e9:2a1a:8b69 with SMTP id d9443c01a7336-2e92a1a8ba7mr50722885ad.55.1792028704623;
        Wed, 14 Oct 2026 18:45:04 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:45:03 -0700 (PDT)
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
Subject: [PATCH v2 03/25] ASoC: amd: ps: Fix acp63_sdw_dma_close() being skipped on rollback
Date: Thu, 15 Oct 2026 08:43:02 +0700
Message-ID: <20261015014324.5569-4-phucduc.bui@gmail.com>
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
from acp63_sdw_dma_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: f722917350ee ("ASoC: amd: ps: add SoundWire dma driver dma ops")
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/ps/ps-sdw-dma.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index f27ebbd21379..c2640985f54c 100644
--- a/sound/soc/amd/ps/ps-sdw-dma.c
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -337,7 +337,13 @@ static int acp63_sdw_dma_open(struct snd_soc_component *component,
 	stream->stream_id = cpu_dai->id;
 	stream->instance = amd_manager->instance;
 	runtime->private_data = stream;
-	return ret;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
+	return 0;
 }
 
 static int acp63_sdw_dma_hw_params(struct snd_soc_component *component,
-- 
2.43.0


