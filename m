Return-Path: <linuxppc-dev+bounces-29521-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88833CC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:45:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rW30RJwz3bsq;
	Thu, 15 Oct 2026 12:45:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028735;
	cv=none; b=Kj3hxNqfRzA6A+PV7CTa3gh7b5qL5GVabBl+m/NGIOCcm04m4alNW2soxZVD+i1rrkvBS0GDw0Z7M8uQQT+wIGZBdFHIxRKM64ym01AsI6FFMfcuASuPZ0a6z/mDKdYo19nzJxbq452FRuZnadbrt4O0x19LpC44dxgSIADefg0XUk+Z7SrBwqXyG7aoFmGGCHeibsl/TTDr6RtwuMGYUYWmKlXOojxTwkiAEkbkK1Ekx6xaJdn0EGpArrtSr410DaSrg7tsuUEUlrYqD0D7/0BvyRAZsEj1Eaq2kCZY2/sTUT5IhjNk4FCaIW0SK4kszJzoOfaDG7NxZ9MkfcsLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028735; c=relaxed/relaxed;
	bh=eK8UF2f8kXq1TEqWl9Zyp8tJ5HPyvJ/UCpsqtpYFERs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGISVvrC44mti38OQ6X5fuABvyqfQkUX8CulXBMIl9Q7cFJHvhbs3FO5ynei1SbDA5FbbT7MlE15fG6VGBPTkurk85Wrc7Ew7yDLwMPQGJxpRLh8tPJCN6rBl3FtL6uOJcjzyyBvxsuLGdyrv8rFky29FhoDMO4exx1Omqr5bzDy40p51IsUhcjg4VkDlacidZdQDfdpE4MhGLxvLLKBQS+qhseVQuOQQaGNO882CLZDIfWSBBQ9VQrE51yZfBvUtk7shKtFTCrgGE4hv3Ow7GzkKvGFQnQRpWfWrHsWEFGAGfmnxv04qBQ+Q0v6iQVnC9TZw7ZFuUNslSCOoQOlTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qv/7ooD/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qv/7ooD/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rW227Bhz3bsm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:45:34 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2e95b3b52f2so1419865ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028732; x=1792633532; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eK8UF2f8kXq1TEqWl9Zyp8tJ5HPyvJ/UCpsqtpYFERs=;
        b=Qv/7ooD/0/sRK8+BYHJDQ9aycVyrP6b6qEiQs/8RI+A7WsNpRpX4lyRr/bapWfPGRQ
         XD9RBuP93CtSBVxnHbfa8LMA22XThaiWHflLi6Da1GjS/N0AwHbtNXDBT8uFupx+bofm
         homFVasNcVoeCi2m7UwIycX9caUp3EZuLAtyYwW/hcQIGQrBNJUVTIr0Xc/j2WtMXG/l
         qyFmcasaD0BOEhfBWWflsuEh8D4LGC8Jsjyj75fp4q55Ua1EL8IZ9w5HPPb5tNXrrrVS
         Ix5c//xK0jai+vPr2xh5lwZ54EgrGvfJXKtZp63pBeBnbKmoLi/AxbDvz5HWOowNH9pw
         czIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028732; x=1792633532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eK8UF2f8kXq1TEqWl9Zyp8tJ5HPyvJ/UCpsqtpYFERs=;
        b=nJ4hgLbolB4cfuovTuolGVXWQtm+NLSkSgJ2OghCZKHRddQfem9HF8FqbrfdnelyQu
         YRlVXfl2i0hFLwnLA/G/8nFkMzJhlRYGMzFyhuVvsloFFH6g0A6vRj3OcxRG0Nh3HQp6
         pMZ95nuFDt3+bnueHguN1QM9SkBllQ0i3KKz2VXHFTqUgaV2Z99ivehjGHgXg8nsjXdH
         HhhRgglgA5XmW609MZYtd+Ry5+7PPSQA18weYH4DOsCYj19cPVzff9xIIGNg1utqW96w
         AYiyGb0uq7jQdgnsxqDpqSIb+63oZygvz7PVx3SJeMZiGktfvnGxXCCDnwuLY/KAYLoN
         J47g==
X-Forwarded-Encrypted: i=1; AKwUvBxdXtYYb3Ouc/xqOPMz3andYpeVbFRziqyHpNbgbDqaQxHoWskQexDW/hIMKDVdYs1puDb/AcfDBfB+RaA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLSXsiBNNWTs1jpiwn3fQyOIoLJFMF9x8BbP19nyKwq0Xspl2Y7
	qEV643BkrWZOd1PdURq/psuQorK8aG/qlTSP4Sx1AEtVKU7DJUNqst5G
X-Gm-Gg: AYBFou11gs7si3eXuDp6J4EEW7Oi5OBk4i+uN0mKjSwnvO0s7KVggQmKWlOWsKz17Co
	qPxjntGOgGDxAUNWbsOZVf2lUOpaiUf1Am+Jjel+EjgE9621ctNUtkBEdVpmOdrcERLN/vNDZGM
	08mzuIxnm9sqlSNieCtRVbQvaH2SueYP0E7UXJp4ug5HG4i6G4HVuw53IO1wb9iWga6V8U9xyYu
	6UcTJHSV9+uvJqxsjQpDZrRf9enHeey3B26aaVsMkH3/b2qd9+ihxg19zwjEonsv+pbrdJajLbc
	WSLLTvme56nKtEdfJLtPACsuJH+DyC8tyef5mcGPDYMvQx+owIZHkySn05mSAUZctRVQdDuYySB
	zxb9FihPTjqpopJpEzE2nMxRlRP3/ZkqagRJjDo2nUcGo09ONX9TTIvsTot+/hIUo1QLIzGuyGa
	SMOeSMebQqjSOYxlhhI2r408QzQip/s2rMsZd/HH5VbeGnB082X4rFyfFqWOYS1jBZb48pb4nS+
	CrscnCFmKlAVi5JcVr3RjmHDIbdgT1b+JcbEr2DPShhgF5sJBJV5GHQhuWmN+KlUQQpA85F3heN
	VyYW00/q2quqUA==
X-Received: by 2002:a17:903:19e8:b0:2e8:79d:15ec with SMTP id d9443c01a7336-2e84280afc4mr161680265ad.6.1792028732357;
        Wed, 14 Oct 2026 18:45:32 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:45:32 -0700 (PDT)
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
Subject: [PATCH v2 05/25] ASoC: amd: renoir: Fix acp_pdm_dma_close() being skipped on rollback
Date: Thu, 15 Oct 2026 08:43:04 +0700
Message-ID: <20261015014324.5569-6-phucduc.bui@gmail.com>
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
from acp_pdm_dma_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 4a767b1d039a ("ASoC: amd: add acp3x pdm driver dma ops")
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 3f59b753243d..89dc60849c06 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -233,7 +233,13 @@ static int acp_pdm_dma_open(struct snd_soc_component *component,
 
 	pdm_data->acp_base = adata->acp_base;
 	runtime->private_data = pdm_data;
-	return ret;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
+	return 0;
 }
 
 static int acp_pdm_dma_hw_params(struct snd_soc_component *component,
-- 
2.43.0


