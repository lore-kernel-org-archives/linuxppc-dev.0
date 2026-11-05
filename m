Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA313606D82A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MJUDFR4h
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKzS64tv1z2yj1;
	Thu, 05 Nov 2026 21:43:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793875414;
	cv=none; b=JkmpODIxI7QkaOwhjOrio4ZYqhnl+Q3pp9X2kcrmty6VawMFfAqwT6H4LfgY7hBxLpmL0G2FwbYluKAEFDlPY7PqfhfbtzNfcf0ZzY+2g2djygeMcaxR9g+W3FeSHhDEqVKt3cnP4zsfbE83pm0ovim7cS67TaExc9ysaeHnqbc40Xf+M0m2j+xZyddt038fVEgYAv0fi8Sq10GwHx4zMuBaTldr0ZS3fBOTLNZfF5dUIO8VI/rx+EvOkGtKbD3DWyI19bYKkrhUGpDTddiePnKj2HGYi992aIhva0kg0Sem/PnanwjunmNWNmk4seNjS7ui53FhatBs1jfePqIU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793875414; c=relaxed/relaxed;
	bh=zEuTfCcCze6o8lz+tPI92UoFysg4iqRaW2ZEcUe6QAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdLNMy05IknUI81O1IluE8702O6H+wqyHeYQy+3b++fDL9j3kp2EG3hjvkOycF4j5HZsT/tGbEIGqLZeyU2uCC7hnWEOr+LcMaNpH9Sw6hdkSLxExozuVKUjVXjxu1kH6XX5dhqSB6XrpRXHSNN8HkWRm1LwYzYGKOEZ09+7zJRZfVP2yjEIWz6im13HeW2s0Rr9EMdJTFnV7ir31lcjRT6zxMUdu97zrEa4ErbjogsF01WE5Z7ahM61+xmxyN5ZFGcXaX+eBhyPX6Sv5EQnUZMlhIuYzumyZndjmCLpxwgSf/4K7AY7ochIMMotDFzVDd2EjDq5CvaMLcFYbV1otA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MJUDFR4h; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MJUDFR4h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com [IPv6:2607:f8b0:4864:20::1229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKzS604TBz2xqh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:43:34 +1100 (AEDT)
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-1adbf62dd31so2350034c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793875412; x=1794480212; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zEuTfCcCze6o8lz+tPI92UoFysg4iqRaW2ZEcUe6QAU=;
        b=MJUDFR4hbin+CxCSLYeOxJS0nbwiPwC8jtY7weVWD+J6cHtmYdZP23L3ZdioJYoLZW
         pyXKAKQtWjI/88p0CLmRFQB8BkGJfCIn0VgD36HnbHYT/X64tKgTcCZ1rIJ2O0iV3Cvi
         NczKi80P7rLDt2/5zinvhNF4R8qZw1vXiNaIjGKqlll+2bdSquhmpKMCO3L1hKgp9MbH
         T83EgExTB7f4fq6R2QsOCGIt9LullJ5cxyYsoRxeL/ock/aRbglWBwcMvsmr9huKAs/j
         zrF5/e2/hS3obMq2d89Q8cQy3kOlGWLGMAn6hGYlL6vtoZm+ewUYkkD11q1DftXmIO0D
         ygpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875412; x=1794480212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zEuTfCcCze6o8lz+tPI92UoFysg4iqRaW2ZEcUe6QAU=;
        b=Za2Ur+2WiVaaqMxKtkR7ytqmr+WvRLLCzMLLToUJKR8DTNHyzt/xNdtRUtewZ9Ivhy
         N9KztWQe//5kawBFB1Epv6mBMYmdgBLME4mtyN1TtDsBr/UOU6NkfmfpMtrS1um4wPh0
         mMDT+mACtW15yTQ38VpONTv3ujQNA0SoV629CpaoN0FWdzo9vDYekyY7boTd/xt9uO+N
         5su1LgFeQuoOQnIgr49wfCF168FQdVRYq0P34PtLsXNcjkUxSUdNSfYrjzbBWV8lgA/A
         iDRJNGAiYwHaTFMgsAwW5FtoF10D103GuwL+9PXGLrIG9ic6GP/f9yjjH71vk1iUv1JY
         4Wmw==
X-Forwarded-Encrypted: i=1; AKwUvBzlCMB5Dk6RLtX/38SXBnAADoQd2Djb+byb/2gK9RoCLFWCPTFyMKdLEHSwiXbrNT0vnXXUUmFkA8icBDc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9+LhA9bGgcSG79rOb8K6FSOLDKHUgMUnkn7eaI2p48omzBnEkH
	ta229RYMcO2F0USKLJZB3CuJTFDqsuoTx/EilJg7Kd33UDXmBv5IaVmu
X-Gm-Gg: AYBFou1sYl/ZUJAOzKkaRgIYATpHKTLAMrpWLIet3xVCqyLQyWBnsHFTic/77EaZR53
	oQqMZ2cAjqCeC7QzceYkkqjvEnBKEl4nuhIxMVPeTwngTP/RdqzTML8nS1JnU0hAzYOLjGhlUgv
	9R82z4KW5Wmf0wEGvy979J/Ra/bUvvk7BrIYgvlNGYaYlnSKfw+KGmJxyYmjsG3QD1J7j9u0c2I
	AaqfyGHC1vBNHlC+B767aCP7Ri5PeSDeW0J8NvkFI8P5QQ+cWivhNk2mWKxmo6EN5r/V4CmLZkg
	jz3wNZAdZPAms8CoSIvy0UBmOlwrvczMkiemvwRKYCW5UqLnfN5V0FTbPbbq1TbBYenacTyA7La
	xIzaL4BCG0HFdBW+8tcKp4LR0sTr/ZD/ghnsAa6Grq/jhiIf4YZCLF8+kKnBdjVBX2Ozs1PtT63
	F3tCyTG7acY4GmLQpRxnnNmB7UebFze2OfFhXsAgupzdUX++vbD7ebBnxi46LrW0lA/ka8/qPKZ
	sPpg074HfDbPhT2Ogm1PDbj0eeOSWDSjYQ7RuSsYrGAYZE0M43TqvKOZ4hQlLVljoBOFGnyJU6O
	r26KSWJhBZUrTuRqSRTg7/kPob9z5dCicpeXDvl3maFZ3bwEMRNX7x6pQJPxDockAEUGH0PADpc
	jfdy4vo7oe/P37Sjv1027nnGVkyBYaacJMiQ23/1y2Pxc
X-Received: by 2002:a05:7022:ea56:10b0:176:a225:e364 with SMTP id a92af1059eb24-1ac5de547afmr27758584c88.35.1793875411693;
        Thu, 05 Nov 2026 02:43:31 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm15595215c88.8.2026.11.05.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:43:30 -0800 (PST)
From: phucduc.bui@gmail.com
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 04/10] ASoC: fsl_sai: Propagate device tree property read errors
Date: Thu,  5 Nov 2026 17:42:31 +0700
Message-ID: <20261105104237.38542-5-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105104237.38542-1-phucduc.bui@gmail.com>
References: <20261105104237.38542-1-phucduc.bui@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: bui duc phuc <phucduc.bui@gmail.com>

Return the original error codes from of_property_read_u32_index()
instead of replacing them with -EINVAL.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5532fab80be0..cb07e7d13132 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1495,15 +1495,15 @@ static int fsl_sai_read_dlcfg(struct fsl_sai *sai)
 		 */
 		ret = of_property_read_u32_index(np, propname, index++, &type);
 		if (ret)
-			return -EINVAL;
+			return ret;
 
 		ret = of_property_read_u32_index(np, propname, index++, &rx);
 		if (ret)
-			return -EINVAL;
+			return ret;
 
 		ret = of_property_read_u32_index(np, propname, index++, &tx);
 		if (ret)
-			return -EINVAL;
+			return ret;
 
 		if ((rx & ~soc_dl) || (tx & ~soc_dl)) {
 			dev_err(dev, "dataline cfg[%d] setting error, mask is 0x%x\n", i, soc_dl);
-- 
2.43.0


