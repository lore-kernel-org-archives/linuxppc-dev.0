Return-Path: <linuxppc-dev+bounces-27314-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B114C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:11:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkd8240NRz3bV5;
	Tue, 15 Sep 2026 20:10:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789467058;
	cv=none; b=jpPKAcjoNItcXgJKo5r/lw7kUUT8tuzl20X9C1D9Z5CctYILS0cUMyhySU5m8oHM+ATCO+SqawcQw/ZblKHGY2bCrv7NS4EJ/7o+AjTFlAArNgQpVIN/JOII0wXMsI42Idhdy7mxw6I7QWPHJowblj2rcyxuAwLM0y4RPvt+raz+Taw/ZIzhBW0hzkHxJWfKvIlMUVr0KKVqHB8Pwnar1aAYnA7pfiz9+nv1BWy5U8scnZ9u42ksOw1ypQ9hBc5efY/m5R7UzkHs638fGNKCFvyqjddAgpooJ52ZygVK2W74aUVwMIGLjheP3iT887f2pwqpDyae6pa3J6ija42Sig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789467058; c=relaxed/relaxed;
	bh=1s6meXsRDcAiElrJnxb7p0En8b2xo3FlUs+u4S3pZb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhM2kFl/cUgVowouwWhpZaeJub74FCsFMRrlHMOQdGjqL7gyCopAC5QhKnM6Fw6OnQV5+2v08wjLTmHOhDBK3San95t9E/gcODpMYSAa5ryP3Ip8hlKnrT0QwI9OA3ubVjIctWybgnPz2ZGCYVSC9r+9mYMvn0fKtZQhGf303eWvHzufRfOkXfJcmxgUWkKMZDoW7t+2oxyLewrJpi6wRvVKDxKj8gkN43jqS/apIU4xWWVQkjAjdlAPPSNRRxgOxaVD1toT4w8FYZ1JeqFjoQ+Bc9FeLR9AqlsfFh+LysIYabLkEP2q26N+hqD1BtdtD+hyF3rKsbut40VzvopY9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cwSUuitP; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cwSUuitP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkd814X5hz30Wh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 20:10:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789467058; x=1821003058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D1bk2913pdN2XTk5dYfDZD30b03Yi/im1ni4fvAIaRg=;
  b=cwSUuitPLlhx0t/FCV/twq38lkqv8xy1BzAR54oBfeuG8sBXyBuyRPkP
   vdGEQRevluxXmem7uJ+gn+PD6vlZpr3m87QqlOqeDN0VPkPwIj/EfVHhd
   /2XengrTjp6VKyuxmJcJUN2c1SeFJF7+DIHZRMOZ8i30jpVgQUONeBaVb
   9jQP5zBLCNxK4xeIN/73FZyDGAQwcY5R2hRwy3jMpavykZuhocIDYi+hu
   /JD0gmfhABfOZgvW5ESu4nLX4haYVsK9Exfc39i0IMZ07RoEfWUiqdKKK
   eivRfta44/D5Wz7P9iOtsK+RRRcCqr3vybAmGlOoMM7OF4oYU/oNmO1Dz
   A==;
X-CSE-ConnectionGUID: YcEbgRovQ+2eGyFyivVFRw==
X-CSE-MsgGUID: E34bwaSjSnGO+WQKu+KChQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93649196"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93649196"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:09:47 -0700
X-CSE-ConnectionGUID: 2n8xZtl4QHaOyEk6gsbb5Q==
X-CSE-MsgGUID: zwriBC04QHyA/SUGdRggxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296442788"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 15 Sep 2026 03:09:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 73190A2; Tue, 15 Sep 2026 12:09:32 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank Li <Frank.Li@nxp.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Tianchu Chen <flynnnchen@tencent.com>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Cc: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH v1 5/7] ASoC: fsl_asrc: Replace dma_request_slave_channel() by dma_request_chan()
Date: Tue, 15 Sep 2026 12:04:26 +0200
Message-ID: <20260915100931.3593242-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260915100931.3593242-1-andriy.shevchenko@linux.intel.com>
References: <20260915100931.3593242-1-andriy.shevchenko@linux.intel.com>
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

Replace dma_request_slave_channel() by dma_request_chan() as suggested
since the former is deprecated.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/fsl/fsl_asrc.c     |  2 +-
 sound/soc/fsl/fsl_asrc_dma.c | 13 +++++++------
 sound/soc/fsl/fsl_asrc_m2m.c |  8 ++++----
 sound/soc/fsl/fsl_easrc.c    |  2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index b24737add001..ae682bf450f6 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -638,7 +638,7 @@ static struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair,
 
 	sprintf(name, "%cx%c", dir == IN ? 'r' : 't', index + 'a');
 
-	return dma_request_slave_channel(&asrc->pdev->dev, name);
+	return dma_request_chan(&asrc->pdev->dev, name);
 }
 
 static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 2f662bdf14d0..5cd12781c604 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -191,9 +191,10 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	dma_params_fe->maxburst = dma_params_be->maxburst;
 
 	pair->dma_chan[!dir] = asrc->get_dma_channel(pair, !dir);
-	if (!pair->dma_chan[!dir]) {
+	ret = PTR_ERR_OR_ZERO(pair->dma_chan[!dir]);
+	if (ret) {
 		dev_err(dev, "failed to request DMA channel\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	ret = snd_dmaengine_pcm_prepare_slave_config(substream, params, &config_fe);
@@ -404,9 +405,9 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
 
 	/* Request a dummy dma channel, which will be released later. */
 	tmp_chan = asrc->get_dma_channel(pair, dir);
-	if (!tmp_chan) {
+	ret = PTR_ERR_OR_ZERO(tmp_chan);
+	if (ret) {
 		dev_err(dev, "failed to get dma channel\n");
-		ret = -EINVAL;
 		goto dma_chan_err;
 	}
 
@@ -497,9 +498,9 @@ static int fsl_asrc_dma_pcm_new(struct snd_soc_component *component,
 
 	/* Request a dma channel, which will be released later. */
 	chan = asrc->get_dma_channel(pair, IN);
-	if (!chan) {
+	ret = PTR_ERR_OR_ZERO(chan);
+	if (ret) {
 		dev_err(dev, "failed to get dma channel\n");
-		ret = -EINVAL;
 		goto dma_chan_err;
 	}
 
diff --git a/sound/soc/fsl/fsl_asrc_m2m.c b/sound/soc/fsl/fsl_asrc_m2m.c
index 4bc40f328f58..e440cc083ebb 100644
--- a/sound/soc/fsl/fsl_asrc_m2m.c
+++ b/sound/soc/fsl/fsl_asrc_m2m.c
@@ -503,16 +503,16 @@ static int fsl_asrc_m2m_comp_task_create(struct snd_compr_stream *stream,
 
 	/* Request dma channels */
 	pair->dma_chan[IN] = asrc->get_dma_channel(pair, IN);
-	if (!pair->dma_chan[IN]) {
+	ret = PTR_ERR_OR_ZERO(pair->dma_chan[IN]);
+	if (ret) {
 		dev_err(dev, "[ctx%d] failed to get input DMA channel\n", pair->index);
-		ret = -EBUSY;
 		goto err_dma_channel_in;
 	}
 
 	pair->dma_chan[OUT] = asrc->get_dma_channel(pair, OUT);
-	if (!pair->dma_chan[OUT]) {
+	ret = PTR_ERR_OR_ZERO(pair->dma_chan[OUT]);
+	if (ret) {
 		dev_err(dev, "[ctx%d] failed to get output DMA channel\n", pair->index);
-		ret = -EBUSY;
 		goto err_dma_channel_out;
 	}
 
diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index aced16d1228a..d30cc3e90215 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1433,7 +1433,7 @@ static struct dma_chan *fsl_easrc_get_dma_channel(struct fsl_asrc_pair *ctx,
 	/* Example of dma name: ctx0_rx */
 	sprintf(name, "ctx%c_%cx", index + '0', dir == IN ? 'r' : 't');
 
-	return dma_request_slave_channel(&easrc->pdev->dev, name);
+	return dma_request_chan(&easrc->pdev->dev, name);
 };
 
 static const unsigned int easrc_rates[] = {
-- 
2.50.1


