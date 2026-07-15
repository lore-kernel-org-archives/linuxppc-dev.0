Return-Path: <linuxppc-dev+bounces-24287-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1819C44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:06:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfP4ln4z3c6n;
	Wed, 15 Jul 2026 10:05:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073949;
	cv=none; b=QKrgcc18rnUjbenKid38yGI6F2uQPbXsJ4hMqpTYSshfpVFUa4ID6CCe/BCOhR/FeCy1VCjt1WadDWorkIzKCuZWCdA/NcvBnb1eC8oHKqqtdZNIDGJwx8R5q/aB7DAZad+gWgksXTYpafMarI8D4uX1/qO4lHereG13fXxTDwfGXzUTUpCTPx/bljedpLpfZiIVjjH+iG8kS8uDnGFH/AO5mMx55myCGXpCesjOhg/DSh8mk0Fc5xmV325CcNTKUbrh843XLhGsQmMjTDMw2NLXMBIupR7YxtmiSLzW0tXkR3tXqyD7S26ugwHJxxw6uaIoToSvM8f62K/55PXlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073949; c=relaxed/relaxed;
	bh=PsmGT/sQld/pt62ygshu3j5BEf/gAGTuk82oceWecys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U85SJVV2pxD4hJG9g6wUIrptpGe1a+87hPabgppneofNyrTyfT3S9uGJOiXNNVn/hgPd/vUQvVzJvV37mPFJRmRbevM0tBdKn/+1n4oFMaYHlEOKrfUR7gU1uF6ShoK4s9nlm8ZSbicGgJgXpwvjunP2Dab4jNPSQSM21SecYS/OiOJsJzCHuOY5HurQUXTBazWNmrQv8G18ld//ofSGu9Qu7hmlaz2KT5UUyl9Su9/Ix/LYJ003nS8y273mgu5U4c1/J3PzeaZSmGH9nQB1uyES4tGJ+c2TxstJZl7aLhV7AR4li39TtYlFjva9XXoUrsKM2Cib8p0H0AcGuIJ+zA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rRnwIDcW; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rRnwIDcW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfL5thPz3c2q
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PsmGT/sQld/pt62ygshu3j5BEf/gAGTuk82oceWecys=; b=rRnwIDcW1l5KnfcrIubl7vi3x5
	Jk0kYSBdmLb9wKIbpERIQR40xYayoo5Bcwh1MXSy7nAuEBexkJd1xAU/iho7zM9WSXlEzIKSsKmw4
	y9u1RgsWg/4mYAIl4uvaNJu2p6RUDLy4aIWK2PVarJJbyuAdj5YMou7u4UgMdQyDfm3BY6wqx9oeW
	Z1w3rbhhCpr3dNujS0JSUEDwAVWhcoQLtkK3p2TbjjTdsA/OkZuLfA9CmYjWimsoXjO8kAf3NBm5U
	rYbut9aes/IwzAY0nNFvMg3Oh+IGabM7hySmQAsCezrWuTtTLq6VU9R/nE2WFdfMkgXpBmQ05xqAC
	0dDuKnCw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn80-0000000DTcu-0fow;
	Wed, 15 Jul 2026 00:05:32 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-sound@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	patches@opensource.cirrus.com,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 07/14 v2] ASoC: fsl: mpc5200_psc_i2s: avoid kernel-doc warnings
Date: Tue, 14 Jul 2026 17:05:18 -0700
Message-ID: <20260715000525.739874-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715000525.739874-1-rdunlap@infradead.org>
References: <20260715000525.739874-1-rdunlap@infradead.org>
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

Add missing kernel-doc for function parameters.
Use kernel-doc format for function return value descriptions.
Use the "var" keyword to describe a data definition.

These changes avoid all kernel-doc warnings in this file:

Warning: ../sound/soc/fsl/mpc5200_psc_i2s.c:123 cannot understand function prototype: 'const struct snd_soc_dai_ops psc_i2s_dai_ops ='
Warning: sound/soc/fsl/mpc5200_psc_i2s.c:87 function parameter 'cpu_dai' not described in 'psc_i2s_set_sysclk'
Warning: sound/soc/fsl/mpc5200_psc_i2s.c:87 No description found for return value of 'psc_i2s_set_sysclk'
Warning: sound/soc/fsl/mpc5200_psc_i2s.c:106 function parameter 'cpu_dai' not described in 'psc_i2s_set_fmt'
Warning: sound/soc/fsl/mpc5200_psc_i2s.c:106 No description found for return value of 'psc_i2s_set_fmt'
Warning: sound/soc/fsl/mpc5200_psc_i2s.c:123 cannot understand function prototype: 'const struct snd_soc_dai_ops psc_i2s_dai_ops ='

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: no change

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org

 sound/soc/fsl/mpc5200_psc_i2s.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linext-2026-0710.orig/sound/soc/fsl/mpc5200_psc_i2s.c
+++ linext-2026-0710/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -79,9 +79,12 @@ static int psc_i2s_hw_params(struct snd_
  * and we don't care about the frequency.  Return an error if the direction
  * is not SND_SOC_CLOCK_IN.
  *
+ * @cpu_dai: DAI runtime data pointer
  * @clk_id: reserved, should be zero
  * @freq: the frequency of the given clock ID, currently ignored
  * @dir: SND_SOC_CLOCK_IN (clock slave) or SND_SOC_CLOCK_OUT (clock master)
+ *
+ * Returns: %0 on success or %-EINVAL on failure.
  */
 static int psc_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 			      int clk_id, unsigned int freq, int dir)
@@ -101,7 +104,10 @@ static int psc_i2s_set_sysclk(struct snd
  * This driver only supports I2S mode.  Return an error if the format is
  * not SND_SOC_DAIFMT_I2S.
  *
+ * @cpu_dai: DAI runtime data pointer
  * @format: one of SND_SOC_DAIFMT_xxx
+ *
+ * Returns: %0 on success or %-EINVAL on failure.
  */
 static int psc_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int format)
 {
@@ -119,7 +125,7 @@ static int psc_i2s_set_fmt(struct snd_so
  */
 
 /**
- * psc_i2s_dai_template: template CPU Digital Audio Interface
+ * var psc_i2s_dai_ops - template CPU Digital Audio Interface
  */
 static const struct snd_soc_dai_ops psc_i2s_dai_ops = {
 	.hw_params	= psc_i2s_hw_params,

