Return-Path: <linuxppc-dev+bounces-29030-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E43CCA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:39:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mhX5HJxz30Vs;
	Thu, 08 Oct 2026 21:39:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791455980;
	cv=none; b=AEzr3GwQX6zYCQ0pYLTI1mTtG4ULIioXMctcCuGIEAJfBaAO9RAzcv4JEsmR2HnNTe9LzU32kgJgynaj/s/1d4eOo0rEhIABCKzIRvSu9OcoKGn//L3tBNcZB7ibVLkpiP1WNB6RQmEBdvf+qKJajXS7Hm8bgq5xY14Qzj+a7E6Jb2TFbNek2V9cun2Hs62MfG5IWdc48l9xhbGr+3IW9EXWrgu6kKQx/XX0LB4DisYyU/10gmUh7az4GjRMacmUmRnd7fI+mNvoa3xQCgqGlB377c5ozG3McSNMwA7zzkEXC2MIMslXLkMeZJHmlFalcg8wHE+6IMETdwfqYx6ExA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791455980; c=relaxed/relaxed;
	bh=yX2YDjC9CYpjnGWLfkYsSXKBPsqSscsCNhhIkMB+OUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXh38zzPr3ypE1kElkCxz/kBGTOsEoY3o/tGMU6UCOXmbD49WwwW4bspTupra04YdI02NN97O2YlrC4ZVli6O7j23WLHhsTSRQUMQNpRox0NjE10/8fu7Jx2Sse9V9988HuNLU5LqF44rzHAdQ2JIf5Ti01SG56WK8OLXzVEoiTrmX1Tp0fwwcjrAPzr1U1g0WHhGk25DzLNys8LhI1HI23gPzYAaAC3Ft0EmtjplctDdIN3sk7PD8/59RepP3HaU6cKGWbBVjd1H3JrwyIg8Nv48kxbXGpDF8P/0tME/ad4YOtKpKzSwqQB0gnMzQI7C0NtP/0Otlomi9tLbU7n3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NFT7D+Qh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NFT7D+Qh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mhX08w9z30Vb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:39:40 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-34ceab2900eso4961824eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791455978; x=1792060778; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yX2YDjC9CYpjnGWLfkYsSXKBPsqSscsCNhhIkMB+OUM=;
        b=NFT7D+Qhdo5Uxl8kSkZY9T7MT7x0c5mlgppqQqSQv+i433Pi2o0LR8woUpcKwzcCTN
         qNwPBykakTccLMaeby0U4qEYJ2GmoSYh/tqus038vKCbbs43IOYihE62Nv6hzxSKr5Lm
         qoOMyBqcGitUYYDq8WfYt1id+cuiAzINQAXMGS5Z98024nhhfxECZRxLeo6T7yz15bFL
         OhGypZG80w4qEfcyvImCTLFLNLUw0t5y/8uZkQtEEz8BHL4mQyzOooVXLsqyxk7u3Upp
         RzvsAjC0wTBHcLKwH2Rn/83R0TSBzvPbrq1kdj41g8jQNvoQ0F02s0VTn7DsbHiCoxMj
         2oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791455978; x=1792060778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yX2YDjC9CYpjnGWLfkYsSXKBPsqSscsCNhhIkMB+OUM=;
        b=rD60D60GmqUn5oWQ6f7tZxiVD/FK2mzMLMvb8AUcGN4uWc27m+AV+o2seMOep8nWtB
         TlkjDkS+uxecmIQgxOdoi+vzeh8z/TI//Z8jZOTtROUMwMJnvbYo2mMXOsY5fyo/tvq/
         bBEC7kC0eV4FfmB8qzsVuWPE8o9wMy2hSxrhjaF44YKcZ91M6KKUGDbfW+2CC9ttRvRf
         6xiN/Mk+8SuN3i3qyIrHXO4+mu1tZIahyv3k1n6gIvol1/+UTEaFNon/gRwW1fmvcCRO
         ZTs+0/IVBbXbHj8SFPez7OMPKGnlRt2dzDYNabsxFKxU1XZ5xaP4Me28Xl43aYXg8KND
         1R1A==
X-Forwarded-Encrypted: i=1; AKwUvBw4sBwX96kuVAxAOUc4+KHMRzJY5k4ZHZj1JwNM3AQ0TU3oZIFxOLijHDqQ8mYVjshFrx7ZU+jCU0huqPk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJN5h0xaYtQCoi8UmD2wVjPRTt2Ug3Wap/4luBM3mvUkygw0XAR
	dlkdJhOrznwu0Sz3nIc6fy3N+RkmXxTbRWesV/p7uuWFPUrM1DN29Dpz
X-Gm-Gg: AYBFou2dKzpduAKlyjBjrUWwdE74zQwVsacGE1hyzKFmgOovW3o6SoGH43mpScILuc1
	4CNJ8p8cSHUf/yb/YO88sfsJ57VVZFlfZfIKHrijLhYzqVFOS/A8Hji2ujYik7wzGfttd/UZZJf
	DK+JbecyvpbT25e2HFR7ZF1BTss3MPeXNLf7A1b/7QOM94E4A9BEwK3V/dNDYNHoz+jI3De5PDO
	sJo7g/aT9/fjhZeq7UX7xhKUn0eKZ9Q+ajYxeljk2hNocJt4wpTILbco6LksEZfxTcpzjRIIBcX
	lpaTi7dXNHljExJ+iO8N6r2anvFv1RZtgiHtRtGQZmHmwBvMYlf42re7DCnCpOt58lgBXsCY/wY
	RSgNx5zVeMuvBcfBRqn6hAEIARQaivro7p4g8bAdslKYGYA0tu/51H6ARybY+4iIUkp5PaS8uwM
	jvo5mf1h/BQnRaKid9wbPCEs7Tx7pdrmmzz7pJHiyA+mHjV6y3gMvkjJeCpSyt9ACSlQD3utqNW
	GFN70pJUBLhjN4jefzk1pI2Hrj3YOUWOSfQuf0jUu7jYHkSNBR0dxhAhepLj4FZsOPbmkCXbuel
	5ESynvRwSDGdiE5r6ggOKl8D
X-Received: by 2002:a05:7301:1e84:b0:350:89a8:5598 with SMTP id 5a478bee46e88-3515ddb2b12mr7231654eec.9.1791455977867;
        Thu, 08 Oct 2026 03:39:37 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:39:37 -0700 (PDT)
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
Subject: [PATCH 02/24] ASoC: amd: ps: Fix acp63_pdm_dma_close() being skipped on rollback
Date: Thu,  8 Oct 2026 17:38:09 +0700
Message-ID: <20261008103831.542533-3-phucduc.bui@gmail.com>
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
from acp63_pdm_dma_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 5137305662ef ("ASoC: amd: add acp6.2 pdm driver dma ops")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/ps/ps-pdm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index 04c014349347..28e0686e9373 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -211,7 +211,7 @@ static int acp63_pdm_dma_open(struct snd_soc_component *component,
 
 	pdm_data->acp63_base = adata->acp63_base;
 	runtime->private_data = pdm_data;
-	return ret;
+	return 0;
 }
 
 static int acp63_pdm_dma_hw_params(struct snd_soc_component *component,
-- 
2.43.0


