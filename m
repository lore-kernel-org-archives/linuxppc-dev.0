Return-Path: <linuxppc-dev+bounces-27734-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78272C982DC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:38:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmVwr4vBRz3bNw;
	Fri, 18 Sep 2026 21:37:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789731468;
	cv=none; b=cHjfm756wyYBwj+WswdJbUH9xZynXNhkVrTDdCafdF/gTS73hCzJi+pldjFURYoWTJRAMyOWudaKZjCrPR4lCoHezfWclW/S3+sIzLRgK4xboLxvPnxr4KuXYrtlwNrEm/0HQdDFCfvit0kr1cF/yxOhXWpXNduALkiUlCHSnN9JvHq1D3j73ElWeqnkaJ8UHqS9tt6fXWRd08497+hdBYLVPncziPvN0XQL/+wtcuWeJiQPsC0QM2jm1oS5rMB1bIx3CPNVa7JFLuxDqLBA6VcyVGGD+FKqBLtDwv+Usr6APoOuDdsSD+Y3jOXKBMb3xtanSsg4kHiYcFnfcs2Krg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789731468; c=relaxed/relaxed;
	bh=Xngq4QnkZ9SQriVo8X8dXEURA+Fnv00PqNye1+fCTv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+5BolqvkK0uhnhiExmNHQs9iS9zEeFHM3o3mguNTFlGlvIZjpXxKHW/0kTjsN3jmqaBF88GvweLp8AXolgX4hpNVOPixzxWYGV043gAWlyZtY/cqrGETwcna7bHSKOHuLWtvcoID6hYnoDOl4FYNDRE17XWfNExPbXfCsiaHQY49cwO/xGsGRz/ofnaNm7mM5noAStm4D/h4DxrQCIQtkdp1hAlB5HHGucMO53nDPsp/2z6dow/6LOODuq9DYpe7Ph8U8viRioJcYGd3qaV0R49jcZKYT1J9NlyfY9svF9p4dWrRdeUvCaVsAj7kSrdfnhy5VgUJ98Cf0pQJV16Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OJqq4xsa; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OJqq4xsa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmVwq3Tvxz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 21:37:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789731468; x=1821267468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5gUb+hVvLoFAVftWGRnnASwFC0wEvWCakupR8SXd3dg=;
  b=OJqq4xsaOkXjlszFXMfqtwoh64tRdK2pJ4MgyXEjrHV6asOdTl7NG554
   R9YRoZAQCtFoxNTUdPLngNwAoGsAltKcZOlegiyc0ohvZ2ulQUJ9StCRC
   rG6uJZmuDHdpZafOXCeb3b/W86G+j0BFJAYzLcaeXN5X7l6itcsfgHqlF
   on70DM+C07i5IGq62PvDnz/dtLbRVZIjkdBSWULRyQtFXiSnyQi4+u/Fp
   68TOTGYpqzkfGY75ghKogQUqF3S+azW+9xRuIa1FdbVsMbjE7GwoNU3m1
   w1TAAI5T79P+Qmy/nIzv/FgPJnzS2raE2KGv2BKkp4KpSWSz87+hDilF7
   w==;
X-CSE-ConnectionGUID: XUFQ5oygTeebfhK5wiPSDQ==
X-CSE-MsgGUID: mIfjxY6hR8C15J/Z0hL81g==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="92739779"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="92739779"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 04:37:43 -0700
X-CSE-ConnectionGUID: MKVMvLwrQiuKI46WECtxaA==
X-CSE-MsgGUID: LBXUdJr7QP6V58c7vq4Yhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="271029226"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 18 Sep 2026 04:37:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 72129A2; Fri, 18 Sep 2026 13:37:29 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Cc: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: [PATCH v2 5/7] ASoC: fsl_asrc: Replace dma_request_slave_channel() by dma_request_chan()
Date: Fri, 18 Sep 2026 13:34:09 +0200
Message-ID: <20260918113727.1898998-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260918113727.1898998-1-andriy.shevchenko@linux.intel.com>
References: <20260918113727.1898998-1-andriy.shevchenko@linux.intel.com>
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
since the former is deprecated. With this, propagate all possible errors
to the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/fsl/fsl_asrc.c     |  2 +-
 sound/soc/fsl/fsl_asrc_dma.c | 19 +++++++++++--------
 sound/soc/fsl/fsl_asrc_m2m.c | 15 +++++++++------
 sound/soc/fsl/fsl_easrc.c    |  2 +-
 4 files changed, 22 insertions(+), 16 deletions(-)

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
index 2f662bdf14d0..86489f70e262 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -136,8 +136,8 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	struct snd_dmaengine_dai_dma_data *dma_params_be = NULL;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_asrc_pair *pair = runtime->private_data;
-	struct dma_chan *tmp_chan = NULL, *be_chan = NULL;
 	struct snd_soc_component *component_be = NULL;
+	struct dma_chan *tmp_chan, *be_chan = NULL;
 	struct fsl_asrc *asrc = pair->asrc;
 	struct dma_slave_config config_fe = {}, config_be = {};
 	struct sdma_peripheral_config audio_config;
@@ -190,11 +190,12 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	dma_params_fe->addr = asrc->paddr + asrc->get_fifo_addr(!dir, index);
 	dma_params_fe->maxburst = dma_params_be->maxburst;
 
-	pair->dma_chan[!dir] = asrc->get_dma_channel(pair, !dir);
-	if (!pair->dma_chan[!dir]) {
+	tmp_chan = asrc->get_dma_channel(pair, !dir);
+	if (IS_ERR(tmp_chan)) {
 		dev_err(dev, "failed to request DMA channel\n");
-		return -EINVAL;
+		return PTR_ERR(tmp_chan);
 	}
+	pair->dma_chan[!dir] = tmp_chan;
 
 	ret = snd_dmaengine_pcm_prepare_slave_config(substream, params, &config_fe);
 	if (ret) {
@@ -223,6 +224,8 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 
 		be_chan = pcm->chan[substream->stream];
 		tmp_chan = be_chan;
+	} else {
+		tmp_chan = NULL;
 	}
 	if (!tmp_chan) {
 		tmp_chan = dma_request_chan(dev_be, tx ? "tx" : "rx");
@@ -404,9 +407,9 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
 
 	/* Request a dummy dma channel, which will be released later. */
 	tmp_chan = asrc->get_dma_channel(pair, dir);
-	if (!tmp_chan) {
+	ret = PTR_ERR_OR_ZERO(tmp_chan);
+	if (ret) {
 		dev_err(dev, "failed to get dma channel\n");
-		ret = -EINVAL;
 		goto dma_chan_err;
 	}
 
@@ -497,9 +500,9 @@ static int fsl_asrc_dma_pcm_new(struct snd_soc_component *component,
 
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
index 4bc40f328f58..e7b91196d35b 100644
--- a/sound/soc/fsl/fsl_asrc_m2m.c
+++ b/sound/soc/fsl/fsl_asrc_m2m.c
@@ -466,6 +466,7 @@ static int fsl_asrc_m2m_comp_task_create(struct snd_compr_stream *stream,
 	struct snd_compr_runtime *runtime = stream->runtime;
 	struct fsl_asrc_pair *pair = runtime->private_data;
 	struct device *dev = &asrc->pdev->dev;
+	struct dma_chan *tmp_chan;
 	int ret;
 
 	exp_info_in.ops = &fsl_asrc_m2m_dma_buf_ops;
@@ -502,19 +503,21 @@ static int fsl_asrc_m2m_comp_task_create(struct snd_compr_stream *stream,
 	}
 
 	/* Request dma channels */
-	pair->dma_chan[IN] = asrc->get_dma_channel(pair, IN);
-	if (!pair->dma_chan[IN]) {
+	tmp_chan = asrc->get_dma_channel(pair, IN);
+	ret = PTR_ERR_OR_ZERO(tmp_chan);
+	if (ret) {
 		dev_err(dev, "[ctx%d] failed to get input DMA channel\n", pair->index);
-		ret = -EBUSY;
 		goto err_dma_channel_in;
 	}
+	pair->dma_chan[IN] = tmp_chan;
 
-	pair->dma_chan[OUT] = asrc->get_dma_channel(pair, OUT);
-	if (!pair->dma_chan[OUT]) {
+	tmp_chan = asrc->get_dma_channel(pair, OUT);
+	ret = PTR_ERR_OR_ZERO(tmp_chan);
+	if (ret) {
 		dev_err(dev, "[ctx%d] failed to get output DMA channel\n", pair->index);
-		ret = -EBUSY;
 		goto err_dma_channel_out;
 	}
+	pair->dma_chan[OUT] = tmp_chan;
 
 	return 0;
 
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


