Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4D1606A31B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QsZf/4i/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKNgp6wXqz2xf8;
	Wed, 04 Nov 2026 22:36:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793789331;
	cv=none; b=oE0jAup4FbtpUl4KubMqtgkocRwy25UZYIokO15f3ZwHXHRiubDPAQnB/FT+tD+JiKaCPIYxQ73n+NjLgEy8EoOBzpn0K9SP6me4Oype1JYVqGt7rBrkMUiJjS+erakHiTuEv55mowv7o999G48AwPXvsiy2URwQyrShrXfxJN8mLRD9kgZkx7G8bzFb95IWPrDS8s4uGe7bRPW7m2NifdMsmxLM963HriFr5b1fZ9TcaSw2sJCzPffjmM1JaWIsoDP2tarFeU96Xpk6/h7Gl2v2Zza8WFUHdGNcV/lEPlc6qF4IA8MT2Es/qwPAib0nwMLeWq62kew0XGhWO7Hhug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793789331; c=relaxed/relaxed;
	bh=QtbqG07ZqasrjsOtWvFMIUfN1oH5l3jO6rDIKIN7V9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q8Qoh3t2WMbG9ETbKoSeqArwIQlJPpe8nIuhIkNZicOuNXgL6fe5UZ9W5jCGyfdrZsn4vXSdZNxVTiNJumb/NEa8cgYPXlXhFXLhcyQLyZuf6XIrManIJaIQN7rEj1QS7LT1rVZ4us1swgh4/wkrlBYVGLH8UiGNGndxPUVmmazinSNSR2eOCKGveCDnQPzkkMRt78P4TlGtiLXNz5LZmQr8soJjazhww0iYMYlk8noil3hhWwSZX/h5FL5FY+vlqetBow0xRLpvPjQx/UP3mjSwfFquJhiC0ePVHJRQ5ZAZQb2pI64USEJOOGa7lLsIMYpw7/KQHo53rbiMByt/BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QsZf/4i/; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=vsetti@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QsZf/4i/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=vsetti@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKMcd5FDNz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 21:48:48 +1100 (AEDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso2189615e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 02:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793789326; x=1794394126; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QtbqG07ZqasrjsOtWvFMIUfN1oH5l3jO6rDIKIN7V9s=;
        b=QsZf/4i/KU3sGiHhaieuYAzDecmOpdB9l5lj1VXElG6+n/CHS6F2pNpzF0bjCvvVoZ
         E2Ku8vX3BCuvIXEJlmKcRu1pRpaZND81Ye/LpHhc6uAxFQEHreE/xc7BSQIhTNfE/G78
         Rso3Gh4IlA11K5WjP1nrvOc7RkzH/RxCBGw3IU8UwO0euNxBnUw2BVA5JBpPBOe7E/yg
         ERs6bq8xJHEHvwelRXFhlLR6X+TiM1QUYYCZYKrLI9+JJ5C36hAJFhn4PKlvrJeb86on
         6dQ1oFXRF31vQmPFBxk0SX6ujmbLfO6RAVaju4bBxKqwvtCvd4Hn/A+EgGQ+m2IgEhTE
         puBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793789326; x=1794394126;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QtbqG07ZqasrjsOtWvFMIUfN1oH5l3jO6rDIKIN7V9s=;
        b=IF2N7FXhuOc4f3s4Dd1E/NFX5BYKQJMKJkgsTCVECgyJ1bULE6ZuDqBPMBs/6pN668
         vJIqLgBVCMMhYlAi9/ruK+2KfXse3e+vwsAhqGPoW4jrBsC2OTPlY/5XkDFCRb0DV46g
         uR2doaSwgeHKnH1JeKe66WN4Xo4LzE7m37ly6n+eMk9ECM9F5lneFRSkoVNDXKeEIfMg
         1I6bEPtPyiZrHKtzNNSqN1/UAEJNplLzqEHYhrZe3pG9UCVg+IyLnbz+WaYQRTCktEOA
         tYqqIQrFUYHEuxf8eXyt0xK4Pa7aRSAnezzbLFfX0B4R/fGKtovUV7MH4YgGn5zSyYpq
         9m2A==
X-Forwarded-Encrypted: i=1; AKwUvBxooQQro3RWJj1YzBH8Ka/sXusybYSqBZmby1lW52UJIivnO5TA0tOpjBh9J4v40JoRQw0mYZiTGXm4wXk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8/tEtfLqqF9zP024az1vv6OvQUCs7PlF9GYSLYPvH+D4b2CUf/
	7pABgBrkSxIpAz4detLYoKA4QAlzmLU0ZHGWzaDDjTQO/3ByTR/Ky1fOXSAzwoed/+4=
X-Gm-Gg: AYBFou0ydIR9eQJiSY0zisZJsX5+4N5S2jqrBjM1uCzbD0cIQ/3UhKW6r7bV8maFDgl
	eYNOsPlc2W0GX1ewQmOp1yVZXZXKZxM1LB935C3RFCd9v2OLzHgQB1KpHHUvRL5udOWFyS1hcDZ
	EUIKc6yyfLoMLHU9eTgqjqbrBexo/FlCSRVTcLzL36JAPnh94N4kGhO8aml6AF0Ar/nml9PF2X+
	xXjMG/fN4EwDyIDwzhAcx5hQnmALatGF2p76j5yamNUFdtHkJzrMX9HYLV9JV1+RAfDBxNtQiJn
	fJPrkk8gFrckq0YyKiP+x2KAF5V3OklfJTQw5gT6MMzGih1n4VKMoRCKOKzj3K8why7TPGMc1Kq
	5EId7au39keopUJlF56odcGX4dqCspp2Y4Pu4MdMQWLjSm2pKnRZAD6CVQI5wWPlx3ZWJXqsS3r
	VgQg2vmItQ8yAetrgIyVgeuE1m+Y4lpIxJ5svfZfvetNTkXmQ0wz8lR1uwLRip8lL4EmJDJFOjq
	RmB/6j3eIrFm2jv63bgDLYANDu4kWxZDhnx19BlEW0qFDs9DkWnLTGJQ/+lmRijB/91arbnwsaw
	E36Zk8bqiBsGbQSAptMgZRAg1I3tDSTsRyB+RytjIM9+9RJx
X-Received: by 2002:a05:600c:1c23:b0:4a2:47:b79c with SMTP id 5b1f17b1804b1-4ac180f2addmr415568325e9.32.1793789325659;
        Wed, 04 Nov 2026 02:48:45 -0800 (PST)
Received: from [127.0.1.1] ([151.61.248.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a80e184esm136455625e9.2.2026.11.04.02.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:48:43 -0800 (PST)
From: Valerio Setti <vsetti@baylibre.com>
Date: Wed, 04 Nov 2026 11:48:35 +0100
Subject: [PATCH] ASoC: fsl: imx-sgtl5000: release codec clock right after
 reading its rate
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-imx-sgtl5000-cleanup-v1-1-62739fbb4a25@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAIIN62oC/yXMSwqDQBBF0a1IjS2oNn7ArQQHpn0xFbQjXRoEc
 e/pJMMzuPcgQ1QYtdlBEW81fYUEl2fkH30YwTokUyFF7ZyUrPPONq5TJSLsJ/RhW/jSODRSohp
 QU0qXiLvuv+21+9u22xN+/b7oPD8+32steAAAAA==
X-Change-ID: 20261104-imx-sgtl5000-cleanup-371e704e5de6
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Valerio Setti <vsetti@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3504; i=vsetti@baylibre.com;
 h=from:subject:message-id; bh=ioLvTLPQ9whgkMJcbvVWkeDAXZlfFZobCdzIe0dI7xo=;
 b=owGbwMvMwCV2z3ty7kUrRgbG02pJDFmvedtyLG/E7rQ9UKBp77CEsZNvw7oJec4JDyW+H73J6
 9v/OHBPRykLgxgXg6yYIgvL9Hu/C0rVHhonnCyAmcPKBDKEgYtTACZyXoLhD7fllU59pXtZbBOD
 lT4ud685XSI5347ReNq5A1fjTNf+usfwT2NDfkjp8+tNc9Z93pHCG8nwgMk66xf/V4fK3NnJUcw
 P+AE=
X-Developer-Key: i=vsetti@baylibre.com; a=openpgp;
 fpr=0497DEFB707526E13360C970DE4B936DD13A0100
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 'codec_clk' is only used in 'probe' to read its rate, which is then
cached in clk_frequency and used by 'imx_sgtl5000_dai_init()'. Holding the
clk until 'remove()' serves no purpose.

Release the clock right after reading its rate. This allows turning
'codec_clk' into a local variable, simplifying the probe error path and
dropping the 'remove()' callback, which has nothing left to do.

Signed-off-by: Valerio Setti <vsetti@baylibre.com>
---
While reviewing [1] I realized that the driver could be simplified a bit.
'codec_clk' is only used in the 'probe()' function with 'clk_get_rate()',
so it can be a local variable there. Also it must be put when no more
used, still in the 'probe()' function.
This allows to remove 'imx_sgtl5000_remove()'.

This patch does not depend on [1] and they are addressing different things.
The two should apply cleanly on 7.4-rc1.

[1] https://lore.kernel.org/all/20261104022815.1484320-1-vulab@iscas.ac.cn/
---
 sound/soc/fsl/imx-sgtl5000.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 8bcf54ef709e..032ea3e066bd 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -20,7 +20,6 @@ struct imx_sgtl5000_data {
 	struct snd_soc_card card;
 	char codec_dai_name[DAI_NAME_SIZE];
 	char platform_name[DAI_NAME_SIZE];
-	struct clk *codec_clk;
 	unsigned int clk_frequency;
 };
 
@@ -54,8 +53,9 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	struct device_node *ssi_np, *codec_np;
 	struct platform_device *ssi_pdev;
 	struct i2c_client *codec_dev;
-	struct imx_sgtl5000_data *data = NULL;
+	struct imx_sgtl5000_data *data;
 	struct snd_soc_dai_link_component *comp;
+	struct clk *codec_clk;
 	int int_port, ext_port;
 	int ret;
 
@@ -129,13 +129,14 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 		goto put_device;
 	}
 
-	data->codec_clk = clk_get(&codec_dev->dev, NULL);
-	if (IS_ERR(data->codec_clk)) {
-		ret = PTR_ERR(data->codec_clk);
+	codec_clk = clk_get(&codec_dev->dev, NULL);
+	if (IS_ERR(codec_clk)) {
+		ret = PTR_ERR(codec_clk);
 		goto put_device;
 	}
 
-	data->clk_frequency = clk_get_rate(data->codec_clk);
+	data->clk_frequency = clk_get_rate(codec_clk);
+	clk_put(codec_clk);
 
 	data->dai.cpus		= &comp[0];
 	data->dai.codecs	= &comp[1];
@@ -185,22 +186,12 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 put_device:
 	put_device(&codec_dev->dev);
 fail:
-	if (data && !IS_ERR(data->codec_clk))
-		clk_put(data->codec_clk);
 	of_node_put(ssi_np);
 	of_node_put(codec_np);
 
 	return ret;
 }
 
-static void imx_sgtl5000_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct imx_sgtl5000_data *data = snd_soc_card_get_drvdata(card);
-
-	clk_put(data->codec_clk);
-}
-
 static const struct of_device_id imx_sgtl5000_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-sgtl5000", },
 	{ /* sentinel */ }
@@ -214,7 +205,6 @@ static struct platform_driver imx_sgtl5000_driver = {
 		.of_match_table = imx_sgtl5000_dt_ids,
 	},
 	.probe = imx_sgtl5000_probe,
-	.remove = imx_sgtl5000_remove,
 };
 module_platform_driver(imx_sgtl5000_driver);
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261104-imx-sgtl5000-cleanup-371e704e5de6

Best regards,
--  
Valerio Setti <vsetti@baylibre.com>


