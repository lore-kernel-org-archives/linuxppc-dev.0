Return-Path: <linuxppc-dev+bounces-29031-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9E2CA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:39:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mhq2lhcz2yWy;
	Thu, 08 Oct 2026 21:39:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791455995;
	cv=none; b=X3EHnZdG7Xk0ZRqmnRrEayyxCt1ciAVh7gQNydqmjbKdqpeho2G5fNZmjl0+9fhR7Re+QeX724qbOY3idC1RXdGrLQ/ZIyBHcqv1PL505QrjkEOYq0LO5sRw5u7eGSDWYYEJKng7v9On4xgVjRD5hgpwQvOHO2WP58LWkLLVWIhGK78xpZ6ueziZUNhN1wybFdrKR2jn9tCuPB2uz9NmvW9f+m5vWPHboTn66bwlEosZBpNi573dZovF39+yNxnmHrw8meAUAhp9Ipy+qYHbFYARuw2xPgCPqrJbuKO1T08wUKKLwjXlKO1Wr2qO+KI7pSXjpns5kCfPgReAOjE1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791455995; c=relaxed/relaxed;
	bh=mFcTZ+kGWiuWqdZS5yC9jJRo6WNRtV/WgwZSDkO0NF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8TOj2cBy8aq4xpvFPEwMvNUeEmHVNV8SznDysWP0qMdDMByUGsXAdnliTSPI1fBuJ7zYhnOtc+a5otn7Dg7pfm4ADrSwBwCKtA9ZuyruSSBGQbSZICUGhtHg+PgJys871I8WHjoJ2wv9EocLD8P2vn8W21XvyIQ9+5MkLsAGANqBSyAU5ac21KpMlk7rg6MDYoA+11nk8dBTwspNVNaqjPNrIGM8bnna/SdBQaBm7aF5Dr3N279q0nNyxjVR+ENZAXs3cjADEMNBSHXRs2dXzNmfGh0uKRE1EEHknKHmcG5EvhhWUVNfCm+hg6b8eoDxzJDluZJEyIr53mWZIdyDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=omaM5+SC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=omaM5+SC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mhp4vySz2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:39:54 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-33c2520ad38so6661307eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791455992; x=1792060792; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mFcTZ+kGWiuWqdZS5yC9jJRo6WNRtV/WgwZSDkO0NF0=;
        b=omaM5+SCpwomsRwJnc5X+9l/CJrPx3NtK7UKl/rQj2Jv3+dxOqHhzFu6JOl3rR7vsW
         1uYDawtBWj++kRDwGZEbKvzH49oCBFgz+xvCRCIpOVjHzLwyC29FVJENQz+8RRkX+bf/
         sZzxojJkIbNpqD7hAngOFSiDGPuWEagti8zfIKbyzBnRXf9pSwW20U2m6nLAwh3qzhkQ
         SB2Gi1kBc42D0Dz0pLknPYEIdK2r8rghYDfMUh9HRn9l586185gW4B8fG9jGiWijOztM
         twg2TaSXADOYgUU6T31jEKdkVxmtMD2MbE9rYL3ukJa/Ve0LGE1aJJy0G/2aNjsODQZH
         428A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791455992; x=1792060792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mFcTZ+kGWiuWqdZS5yC9jJRo6WNRtV/WgwZSDkO0NF0=;
        b=Nfvi0j/MlFEQHVKqNGVtRNoQFnVWmWFG+DiqHy35oHNnuzcWdn/24vP76iuz6vtjVs
         OCtLpPWudSqal8cbj4ZtenQ/gH9z8BgyoK/kdnxVUaeciMXBf/qRlDmTBeKHJzW1WNiN
         9Zmut1fJ9BqKmVZ4uhAZfT6PVd4IdtGtJLtoU+iu93LV0uZaxdZ9axAcBUgczp5uI5Sz
         ozvJ8haEtRdRtpY4JY6HIVVoYRf6yb7Eak62Pl7WjXS36xyVQY3cPGVIrZI6SsxqI1Jo
         tZNtaSxSdoqy1Jmcau3S5LrS8MoYF5COSsDltZ4AMuvK1I2alC+c/Z2VuxuyOGrpJYP5
         bolA==
X-Forwarded-Encrypted: i=1; AKwUvBw8ODdGjAKXLm7wloUBd4wrnLfOe6bMhutz0pDf7Rll2hVS/9aUm+YjX43LdDCEdHZ6s9wQEbYTifuXGxg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKXNYWFNrjIZXgbKR/dfCnjMo8z5X6LWWQPqq22k36cu+BnEaPa
	ttwoevKus7KTsqzNield4AGEgSzBOu9E8jS6zjq0Bwyn2gU9MBtjkx43
X-Gm-Gg: AYBFou0DyVDLIra+Eg+Sa07y4o0f96DALtudmiE15muP10orDX6C13NOgwAJV6ycAx2
	lKdsjUkvDLeYqikHS14ClSxgkvAcb3hQ/M5kdF8jchxlkAm4VjIM1LHQfzQN2QZJ1hOmHapjr5e
	NWG3uAHZm0Rvte+Oxuo3e/p5SFXCi1xnoVNXhtXRAxk6OG+ZV2IQbfPi5ASfpXzs0CMEWcLhI4V
	u2EfPnQy4LCIaYHUxsXAKOf11Nui6QwRhZYq1W/l0hcCfgPZFpl+CwhpSB+FKq+vh4CUJn0vdCl
	KouAbzQ5psYDvBW4vogoscrWisYQXUVIRkHwMQVQl5HeFTSI3av3Vmow2TCsWBMf41ZBd2WgNWT
	f9/Sk1GApL9TgpZQBBXzv+6F9rQthwWBVq3Ab2UTjeZ/4yU7njvWkdewjKeicC9B6mfAJ4Nf3Bn
	Rd6z/hr1GnPRaCN5AJjkod263+Q17fuATm5nJAxuTla7LF/MzMXS8ghoSm2/AHL76JjPXN8f/vN
	4KIpRD8irWPafgmle+VECytSNby7HnOQX6KPxiFgbqBfXHryrioqP2MZKdY1lkA4bb85hsnTRst
	2XkIPZZrrKf6q+0=
X-Received: by 2002:a05:7301:3d0e:b0:351:5112:ec4b with SMTP id 5a478bee46e88-3515da5dc10mr5687961eec.2.1791455992008;
        Thu, 08 Oct 2026 03:39:52 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:39:51 -0700 (PDT)
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
Subject: [PATCH 03/24] ASoC: amd: ps: Fix acp63_sdw_dma_close() being skipped on rollback
Date: Thu,  8 Oct 2026 17:38:10 +0700
Message-ID: <20261008103831.542533-4-phucduc.bui@gmail.com>
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
from acp63_sdw_dma_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: f722917350ee ("ASoC: amd: ps: add SoundWire dma driver dma ops")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/ps/ps-sdw-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index f27ebbd21379..553fe11a2e50 100644
--- a/sound/soc/amd/ps/ps-sdw-dma.c
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -337,7 +337,7 @@ static int acp63_sdw_dma_open(struct snd_soc_component *component,
 	stream->stream_id = cpu_dai->id;
 	stream->instance = amd_manager->instance;
 	runtime->private_data = stream;
-	return ret;
+	return 0;
 }
 
 static int acp63_sdw_dma_hw_params(struct snd_soc_component *component,
-- 
2.43.0


