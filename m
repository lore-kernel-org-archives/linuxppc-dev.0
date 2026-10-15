Return-Path: <linuxppc-dev+bounces-29523-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A107ECC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:46:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rWb07GLz3bs5;
	Thu, 15 Oct 2026 12:46:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028762;
	cv=none; b=avhuEKKFxe27CkHuUvr0ZzIDY/lcu5oR0oPGZi5G79RjeiWl+xYpME5SwMKZXxP99py36xDAqYrklG7FGHVpMIDsqiYXI55TEaH3+GWP+BkrlAp+r5/BkgRI+Hs5J94srBTMYee32HArjutavC9Y/UwhOh9hRqv2x0nFF9PUpQxg7veS5Tndt0L8Fa0msdzTKXUf4PPwxWiApzTHcXasvpb9LeprFXpI+QxOo29tQG5YkViaWo3vbggkwdMp7O6oZPEHr1Azy/bJU2lp4rrgzTybtBLhFNOR/GisIg1yFeAzKqZuzUpp8tcjcpY/vobScds30u9N5Qz6gZFgtFMkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028762; c=relaxed/relaxed;
	bh=l+glVHzZv3mmREWfVKTa0Xbh8v/mgn1NgWb1AqzOGiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ab4gJhv+5H6lAaiq+2sFtk17592ab4Mh4qXVvLhfTsZPghX5BslDKCfUHtoFyffrYem7HRzfN4ArCMnUXMso7vd+1j1jMSx4FIZmU9+65krTQmbvC8E9yZd1SGwp7x0NKNDjnaaiHn/QHSk9kbIfvSYG4H67Q69+y6J5Cs3yQmvXyH9Cx7XhEkC3sGpq5B7kawrKoI9f3e2C5vAtIq3pGhrR1dZc7d+OnRzgqQ0I3fRmt5/Pml6zAGmuaapZwEIvSM8GNXx/OdmwWdO2qQ22UkyDyrEMmWmYG0Mw8Mu5yJNkHx1ukMANWFMdOn4SBySV3AImvtIQsa00UaRZ95FQ0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RJ6PoKFK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RJ6PoKFK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rWZ2mv7z3bs2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:46:02 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2e934449bb0so11207115ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028760; x=1792633560; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+glVHzZv3mmREWfVKTa0Xbh8v/mgn1NgWb1AqzOGiM=;
        b=RJ6PoKFKdJtqvVMxaqH70V9luGpwBFgdLk3uqCMCKJjVGB+/fBE+Zi4gkrT0Cz8Zli
         3D/8R1GUDhcIGpuU/0vB/pAHyg0dyAMe8Xh7B2G++jr/XBtS9th8zhiJzy1zBfK1iL7v
         OgVgfEgEUjf3dUtyTzY4T//AjBbzp6tGZtMc9/yBfeWpYiDeg8LbYACkcNllwP2DFcqm
         dmXRr1n7sPYlsr2E0KJIsAZBq9vOnYud8zrrAiNozLYn5t+tuOmyOp1vE8m+fBH7eSTq
         q6Rpp9D9+EGif6WtSxzF56X714dR0fDPYH7Snv3ISZSgGAPqT2oFbp87A8Jf9t6wygx0
         A0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028760; x=1792633560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+glVHzZv3mmREWfVKTa0Xbh8v/mgn1NgWb1AqzOGiM=;
        b=gaRFJHdW1ndqzVlDfZO70dFpifHmtXaBnpd6LtFltPx0wzSOiDef4Yz/+NiZjE7K3C
         9zE/EYbLkBzOacv+WaD+KzBWFyohvoR/6A3I8POEquAijSsnl8nQTkj3PDAkicJ8CC+O
         yUd0mvF4QxZzNCwJGMRxSNUhP20BE2YY3nl7o+dx1WXFzUpFiOVYhR3diiV8umKC+TGk
         JVtXccw5i5CilOBuqouwSH4NW4+MAUCT5qwbBvImj8sAtXlVh9UXDn9nsgxry0LTAOhE
         hN1OGOCIGZk0uleBCMDO4OMVPDtw7xA8mV6wqZnV1QktnW4Q+i84UeKvwznKyEPZr3Ml
         Nn5w==
X-Forwarded-Encrypted: i=1; AKwUvBwXsxpfee9R5XUtv/FGDTaPjhhL8S//juPkIYvglQhIKvJ2k5ax7PiLdvoA/irgoPp2oa3pKoQleSg2/zk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLSleQiOw8x2+tdt294hmAdvG2Rg3RYwHZzwhfvi8PZejHwQI4W
	qdGD+nzPDZQQhvBCfhFVDSp1to82AQ3D5TvAeTnxPbEC1XgKXJR5+UK2
X-Gm-Gg: AYBFou1jlRfwN9m2BF1pMIaya33ZonHQCAmR7a3d/Qw9XoVHHAdDb0OzDe/a3O2v+nn
	yk81g2cEa5MSuIt6TQoYpNQYWMp0kWEMkj7PfSVxDxl9AZ9kRJjQQBg7hnj8BJvn2FeA6cuSery
	MG77oCdFenx1Rgir/cPW+ZzJxhzA/BR0dvH0SJtbaNo7lDBlBfYcsut0vmWjlYbguDmGWLGKJ08
	psd154hncGZG892d6K7idjY8V7y5uueomNt2la8Ocp5sY3iZwhd+omnggHDCi/+tSStMJz4cX5w
	7X9ck6yNBTQ9g9JaOrlTQ4lOwuFXMS5Pctvu/AdgkxxKOvpnjIDc7a1HWjNos66UTWJGv/vgjdx
	3O8cc/lAL0MVOX72r6uKegf7zEK68DT/uW85/8JWqtYyNH3sLr+VNvr+EsA1K/tWZ3TNWi4B2Ko
	8noprUgHgirGPYab3zVs97s9Z9PoKEdQuRBN8D/WHaWphVO71aeeg+TdFAOenYTUfH8C5cqbtWy
	ouMff/WIJxRgJmUaNx7jaaM2+DXVSxvRyeuzrEKto6iL8OSxs9yFhBmz4aJlde78GvU6WIiSvku
	wzuLmizj4TZrE0M=
X-Received: by 2002:a17:902:ccc4:b0:2e8:695f:96d2 with SMTP id d9443c01a7336-2e8695f9ae1mr130100745ad.25.1792028760086;
        Wed, 14 Oct 2026 18:46:00 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:45:58 -0700 (PDT)
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
Subject: [PATCH v2 07/25] ASoC: amd: yc: Fix acp6x_pdm_dma_close() being skipped on rollback
Date: Thu, 15 Oct 2026 08:43:06 +0700
Message-ID: <20261015014324.5569-8-phucduc.bui@gmail.com>
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
from acp6x_pdm_dma_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: ceb4fcc13ae5 ("ASoC: amd: add acp6x pdm driver dma ops")
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/yc/acp6x-pdm-dma.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/yc/acp6x-pdm-dma.c b/sound/soc/amd/yc/acp6x-pdm-dma.c
index 40c4d833f4ed..cba2509faaa1 100644
--- a/sound/soc/amd/yc/acp6x-pdm-dma.c
+++ b/sound/soc/amd/yc/acp6x-pdm-dma.c
@@ -209,7 +209,13 @@ static int acp6x_pdm_dma_open(struct snd_soc_component *component,
 
 	pdm_data->acp6x_base = adata->acp6x_base;
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
 
 static int acp6x_pdm_dma_hw_params(struct snd_soc_component *component,
-- 
2.43.0


