Return-Path: <linuxppc-dev+bounces-29029-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF97CA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:39:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mhD5nzsz2y8r;
	Thu, 08 Oct 2026 21:39:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791455964;
	cv=none; b=DiMNJXBHFLEFO1yfvkPnDZXHr76g1M2bMU+qU41vnzAPIJCqCgDL1wk5aLErYDJYOy5Tb+UUg3//LT/8/AYWIWVNG9kNOfc+A2343hgidE6T+Sf/++M0uImZEYjCaF1KvrOpS7bsFNv14bux7FZj/ew0TePisnwv+BGI3jIuCdAGxP/+rk1mrjDoeY8473AF5flrTSjC2Esia5R9MEUk//w9SrmKqtVILyx9ZxBts2BvP4E7PfEbYrWdVAXwNtmSRXzDlO/Pl+URv8oHSh7Hd6I+RZEypgoQ9hGl4wO92pgR+UJh0ZJ7d2v64/H1ijeupvgrfa9DIfuYfXZJWtZVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791455964; c=relaxed/relaxed;
	bh=eUBcm/HidbDHRMMNHvpjEcX/Cn/b4904BqGN3eWGjuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vag9L7UJ/pHXnYLodAOIuXekcPLo66c+bIy8mR6nyzemdHFhJr+gA6M8/DkjKii90+HlULEuokJHMioyuUr8D0qLgeozYl17T/e12NKmNjx13omOLfttuNihPZXLMAEdLbb9PyNMrxUtg+5pZfBIk2zrA5o/qivYXrycxZxVIU8HrOdyRlh+ivAzjlZ1gFyIR/iQqgT102e2jK6gHNQ2QrmfbxrHY0rnzzZZoTZEAAoGlHZT4jhPHSkaMHYSXG6YfkhavqBgLMwBNvzApip7WI0i1uOgYvZLtkTvlD8SLOhybIsGyWdOeEp3Fvd4uu0VXr5TLXv3/AF0qBtB5490QA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L6U42Ukm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L6U42Ukm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mhD0Yd0z2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:39:23 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-3516c82e96cso2572626eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791455962; x=1792060762; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUBcm/HidbDHRMMNHvpjEcX/Cn/b4904BqGN3eWGjuM=;
        b=L6U42UkmDPvW4X2fJKUMuvxuD3QiUJbHHae+80q9e+4WD6/geOHVjGmHPJsA5cJDIj
         sSKLJbZETJF51s8ACQ3ZC9pOyz3ePdDnMmv5DcYfxmenhcTwA6pj88u9sgBxPyku1hhm
         WNRCmaj9q7Qloi0OBJY2hvUz4fzKU734VDQi/s2gjZ4Jm5b9D7MMX8gKoYGsm+vuqfY7
         VY1XM2hBHI5MewsHe1NfIEPAsyX6bp9lNtGP3IBTdqSvXYhI8RpTxN0kODbJ8sE81R0E
         65BbyKMwFZSkfE7KnPAVIVuTG2IxdHUFEGz1PQPp3Yq+Lc6YXu8jVZ/wBiW5h/6bQDKP
         RadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791455962; x=1792060762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eUBcm/HidbDHRMMNHvpjEcX/Cn/b4904BqGN3eWGjuM=;
        b=JWpyj0VEBx56B53Bl5sd87qnJorjl2IkC1QJ5QFZ9lrsRjisRJtCovARBnJsp5tHK/
         7SLzQ9q3kpExtC0i3xrd/gPg9eVMsHsNUvGGjDqfCYEyAIDszlFrwsmhYwlZDOwRiIGi
         CIS2mR6/8BbNJLeF3yODlt5/kb2z3Ajji9JKqXnTaqA/s0APobTqPsT8L60hVhfT3FRB
         heLqs32+5ohFfULMmZIIMpsDhwppMY/M/sXANaydrfcn8Wc7IRSBuqq9G3IQEdRDS0f+
         J5XIVe7zOUgY8FvzVTRR1AbzADtjzVsdCiIA1p/SL3gXAGe7lKdrfblyPtC0Fj5JGGSe
         c54Q==
X-Forwarded-Encrypted: i=1; AKwUvBwYJTJswDNJ35pEOWInPix8Qfv9AXAnC56xOzg/ySCyMjnZUUuUVCp8vRN67Texk8UH/X/+/B7LkUgIbGk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lqmPnJY7YpgSsfirm0+elQUzYGQg7eeFzbzHKP8DX82N4nCK28
	AzOcLIndGZUTjIkSVGDu5gPGw2g2ck6OCJSMHCxrZFVQVmqbjr3AruBe
X-Gm-Gg: AYBFou1rzCy6xyE2oUwxHHvwQjOWRWKAQfoaHLSCi0wK5iqvAsmdo1DrInYDp/r+ciQ
	MIThDIvECYnr17fS6lBVEmW67klaWeJkQK65LmM5K8AHBxycFoVGSz/ciqH4LO8zTi1AqxH/gdm
	qcUUQFhrrIpDvi6nuICWJ+CyYmTy6plKWYG1HqLO1JhnMk6EyQILJ6vVA+MsMDzdp7Kayxt3OIA
	s0j8cm0Iy6I6ukozs2sO61Ye0t8n3THHBsToaz9U2Wzi/NDf+ehnfelNrgEFX8OpNSGs1AJFTos
	0fAfOBE9oEnVEaZpLzunqk/pkdMq5PyA8/vwCsG9A6/U5N0PNjDwj0yEZLHTmIKn/EbhN75DjWP
	JEi7wPdaTU9fQn8wKiiZxyKw6Ed00sWLvNsBNcKXV8J6QRDfVomev1YnbUn4DEAxbNLIFnryIlk
	m6JFqrb6vJP/jH5fHFN/8vSG7eU4vzvMf2xWDVKEX5k3rsHZi7PBm+HZGzHCWEaiGVUO+/2WieO
	l22M6YxtDurU4mLLXtp82A2WIuW8bUd8W8eIb5GKSqUS92x0PKlNPEQ6sB+uj588xhQshJ4pO7s
	BBTq7ZJrKwj5Qw==
X-Received: by 2002:a05:693c:41d1:20b0:351:b65:63e5 with SMTP id 5a478bee46e88-3515de8cbe2mr5796544eec.41.1791455961706;
        Thu, 08 Oct 2026 03:39:21 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:39:21 -0700 (PDT)
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
Subject: [PATCH 01/24] ASoC: amd: acp: Fix .close() being skipped on rollback
Date: Thu,  8 Oct 2026 17:38:08 +0700
Message-ID: <20261008103831.542533-2-phucduc.bui@gmail.com>
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
from acp_dma_open(). ASoC only marks the component as opened when
.open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 623621a9f9e1 ("ASoC: amd: Add common framework to support I2S on ACP SOC")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/acp/acp-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index 6b1e18b31c1c..ba6dfe8fb6b7 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -248,7 +248,7 @@ static int acp_dma_open(struct snd_soc_component *component, struct snd_pcm_subs
 	list_add_tail(&stream->list, &chip->stream_list);
 	spin_unlock_irq(&chip->acp_lock);
 
-	return ret;
+	return 0;
 }
 
 static int acp_dma_hw_params(struct snd_soc_component *component,
-- 
2.43.0


