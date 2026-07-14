Return-Path: <linuxppc-dev+bounces-24169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9918C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:45:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvN487rz3brT;
	Tue, 14 Jul 2026 11:45:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993504;
	cv=none; b=P91ZxpLEZroRiT6Y1c1E5eQhdu4aGvNO9YyKqvnyY2qU2qL7Hc08Kyz58s/mxE3RziVLKbXa+WwXwoVUZp7+Iq3gAapTpGkBcxXPqGaGLkeAJkOR8FUFjgpWqS+4x2x2KEN5ZV6OxAmmg+uopauQ2Yy42jK4Mg648kZGYaOuDw23+armgCE4ImjrULgcKMCoY89xzjnpB2E2sP23+vO0qyP0tK6r2PlnFfIMovBgUCNSb23QQA2/38NkzK8NQJnyZG/QuaAAfeL+aebeQWJXrNebsAs1CisqZcLTHGUmrK/KV8r3X/ozEZsIIvIVEweSuCrHSAkZmlPOlY6h3WknkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993504; c=relaxed/relaxed;
	bh=EuZa5Q5a/jMFskrp99UmUL5HrkAt4TSwEVsuVrrXQfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K77oPULS0TaXlQN10+6jLX+E/GpFqhb9XJQ881kG/alorOwUb5i/mCZO9YH5Bn+2oJAnOEZsmaadYnroYpJ7g9VkzB94tgH05xtE7h/EikaBtK1DDdkTgOJZGiEqd2rCPQ3FL435ihuGlvLxJAMXPTjPrPV+JTmrHtFj/vdlmp1pQfvlTbtK0x5nC8i/NEUmvrmuiMIej+Hy3DS244YppzwVuWRkGlXorluTBPsxksqrMh4wW4g8T4oPwM15lJpAD6S1qFjD7W8DMKWdU3I7x2Ylbs2OYt+qWqnNK9fH9ICypjePyJg63cXvxSx0DHqhSAu/gvgizDQowYS8P8nrjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Jj6nb2bx; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Jj6nb2bx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvB4sKSz2yYq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:44:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EuZa5Q5a/jMFskrp99UmUL5HrkAt4TSwEVsuVrrXQfg=; b=Jj6nb2bxcG7Hyhh+d25tyJ8cPK
	d35Wl10kucMNZd5o0G2RG95HKtMP4hmBvHbWuPfaaQHP1LTQ6DKSHRzjWcjFz2NGPmqVXffLFCbOJ
	nqDvzUVQ3hxx0A+YTP4R6OdoK7tsWyKvd2he3toD+fBnkR4XGDKlXlohanY4+1/jy9Gny0fMVzE93
	/bNNNZ/vtL3XF3DnXxAaZUq8x3oXCob8FJX8fP3KyCPqSXt5g/k5G+IMk+nGA9/VO5/VHTbf/JcjV
	HJyks112h2ZNpXBeKOyjtiXoWpO9cIFGRduhyt/ulGsSgD088nKhYrQabAcwEq5Wl298VM0t5wTek
	9oyfnNJw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCZ-0000000AgsR-1F5Q;
	Tue, 14 Jul 2026 01:44:51 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-sound@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
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
	linux-arm-msm@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 07/14] ASoC: fsl: mpc5200_psc_i2s: avoid kernel-doc warnings
Date: Mon, 13 Jul 2026 18:44:38 -0700
Message-ID: <20260714014445.569992-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714014445.569992-1-rdunlap@infradead.org>
References: <20260714014445.569992-1-rdunlap@infradead.org>
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
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
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

