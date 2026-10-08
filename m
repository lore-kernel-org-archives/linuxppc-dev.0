Return-Path: <linuxppc-dev+bounces-29033-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD07CA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:40:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mjN5hr7z3bgK;
	Thu, 08 Oct 2026 21:40:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456024;
	cv=none; b=eKAAqqvOP9HUBjKgRARoJhHE5l179oboeduHIbbSCi2zqY/SMsyGwaXz5cSDkzfssR84RS5UKLpsvtxkYJ5+0vqdtFSReh3JQ0U05SIr8gO/kmEFSQa/ZXbY+k0PqiOmQwRf4HGxrhJMW5mLU63zSlt4JyYcBe1aEIYorAtYk6Da5a6d0SPBGHY1MxOvR+MjBT9af5sQLjgn3/ie3eIW2afvWYF17k/0tmEhg+yjhQy65mwXPYNh95xNqXfbYteiL1aN5x2rZw9X4XRuO3Bj0RaOLXL4uNWrgRjTHNAJsYxtAI6up8WiaUA/Yh+gqDp6EJ2LN2A+6sGwBzQGp4gwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456024; c=relaxed/relaxed;
	bh=h9Ry8JRaSeFrVq0Ud0+uxs62YoBNOy3ejKA8MS9Fs2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UciBEl4QRRFRMCJUR6O1raguycqlERDYZr9gs0xeoclaWhyJhwbmDJq7j3rP1l55fAB67eRKzsHoXEDKqNjo7CQdpYghH38z9/XOC7A8SMWAEtLvot9NA0FSHJmvUXH057xDwxm0PkUsAE5jr8QrCv6MXa6mxWCmJk6Se16Bb7rnDSd346HbT61qFf6jJY2B3laK0KMmo2N1TtpBFn1qv67WrWMiljJvXEdoX9tjbQMCaRL/tQG3znem50ox62gZVW6IOkYzpEqvGiMoPLmS0UBMzANn0yWaase+nCdQnsFHCN56y5mQQHQule/lE2DEwpIxgFDFk2O0pv3h1PXh2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=grxFli3C; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=grxFli3C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mjN0mQ1z30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:40:24 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-34bb8b31647so7925294eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456022; x=1792060822; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h9Ry8JRaSeFrVq0Ud0+uxs62YoBNOy3ejKA8MS9Fs2w=;
        b=grxFli3C+D/jefW1t7lne7MPYsIV39O/oqUeS9xYjhx3FNKIUOtsVEYtJjlZ5MUd1o
         fxZ1nIxU4tzR2NHEXPkpzKMtGQ/buQ7QMoiAGNF/GdIEgE4x6PkkBEFhlhvqsf0jRY6V
         KLafBSFoHYsLIn0OZFDcpIx5l/qe5J0ItW2XwCffqrsgSkNO1z6OiQhJfNSSo2Hrhd+e
         GCLnRyI6hgFGpIj7V/csPB3MJQKhPyKtbslG/W4RrJi7PLaXdndin/+IbYy0g05XAMHa
         p3srj33MjXhiMQbOYv+9bQzQoni1P3d3qckut02QD1SrNLhyZSvkzMSFjnpIoXZiL9cE
         invQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456022; x=1792060822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h9Ry8JRaSeFrVq0Ud0+uxs62YoBNOy3ejKA8MS9Fs2w=;
        b=oi29EYZ0v5TlCf2OF9sWXFI24o6gKsLxZdlX9e7dXCsL9yE9gOIdBz1c1IQ7Ef9xwT
         3um3+PuoL0yRTcwyr4Vg7VIWKCjSc7zVc+KLVJ/sRsRzJGmK6px34C1hxNAFgHCNpWiK
         JrNNWV0FZ2qn83+fswi7GXkfZ8NKZHMmf2fBxQ/CPQ9ivvkC7Uy5mDiD2o8s9XVqgW//
         /mJXj/Shw4nUiDfYbfArHmbHhQZli1irBo+TLJtcWgI5ogp9kjGkLr7PG7K4zf+TiAS8
         hZ5LbnDfHWPf41EMoelYD7mc5ejdAZlhRnEYtGSMpGuPyEYJtuD2BAwLIKSotzDmmAUu
         O75w==
X-Forwarded-Encrypted: i=1; AKwUvBwc0euqQR1z3KAXM3iapFa509GF+sKG5p5Px9F9JmgZjzZJn//NJ5usU4Oja+4yxvC1F3LiV8ISefUni0c=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l7QQQqKy4okBNmkAwNMnCMaWUSc/cAlLGWVg6+WCifcCd2GXo9
	XhMN9Mu80QHf2DjF5HCQHQFn+oc7lQTpo8J1BzBJ4VeUmJyvIUAg2Jor
X-Gm-Gg: AYBFou1noGsLLRyd53KyUbNCGChTQxLevkobOvHyMDKvmS5dgZBerx7cHqbeUxtwB/0
	+R36cCMgWb+n3nAhKA1W9anVvL4U0iERBESN32+6qs3EBdTkuuHrd3y9a+8KizDtFJsHwKqTXQh
	U6As3GYOOD3rDX7TNpRwP4xPgYCvJduy8NU3sv1pLWxopVPUIbpX37s6ec2mcGp1xWDZZRkoSTt
	cfHBSEFc5zot5MS8wQwxIohObgoBHnPcJSfpDastLK3nOACe3Q2+32OWuHiJMiYm91UgLhTJ5tB
	V3WxG8iK8e7jclB6SLSMj3wmIm7+zVyw+qBRv6XZcRD4QEtuPqfCchpFJ4nf/v4WShlKlNQ2n5o
	NoOwqtnWE9varmGBLMOw3cgzOuML0TGlVMzVxoyWo98FGHzMNl4Di5mjYBBh0mrVaRWb/AT5oSz
	Zn5aU/eSunO7y/Ltd+Dqz5qjBdwWIY4hn6EAws+ZT4e84gLklk7JNLhReKC12BMHmr1G9K8r3s1
	V2gCX4qe2hhHR8Qd7IPWbR4T3qBkiSAYQGSmSSBbBONivWnqxf5tg3UgrCIb1w7ZwqxP+e/487T
	0OtY5B6SOlfuDDpKcBcvmmuA
X-Received: by 2002:a05:693c:414b:20b0:351:1e2e:da4d with SMTP id 5a478bee46e88-3515def434bmr6671263eec.23.1791456022013;
        Thu, 08 Oct 2026 03:40:22 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:40:20 -0700 (PDT)
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
Subject: [PATCH 05/24] ASoC: amd: renoir: Fix acp_pdm_dma_close() being skipped on rollback
Date: Thu,  8 Oct 2026 17:38:12 +0700
Message-ID: <20261008103831.542533-6-phucduc.bui@gmail.com>
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
from acp_pdm_dma_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 4a767b1d039a ("ASoC: amd: add acp3x pdm driver dma ops")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 3f59b753243d..c0481a9ba858 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -233,7 +233,7 @@ static int acp_pdm_dma_open(struct snd_soc_component *component,
 
 	pdm_data->acp_base = adata->acp_base;
 	runtime->private_data = pdm_data;
-	return ret;
+	return 0;
 }
 
 static int acp_pdm_dma_hw_params(struct snd_soc_component *component,
-- 
2.43.0


