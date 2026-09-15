Return-Path: <linuxppc-dev+bounces-27308-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183B0C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:10:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkd7x15rhz2ygp;
	Tue, 15 Sep 2026 20:10:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789467053;
	cv=none; b=OfTrSyxi3na21CKYOu73wx8NDihFcUHeYG6Mrp3PCv0akIelwAlGrYGdJ2Sy72Wp1d4UiWJBSROUdpsVChqWbXU7Mb29FrWqj2WIrIjgNm4A1tocGW61a2MyOQJ6tbWU79rDb24BAggzv44O3Fs/8zE/mk7fIC092BPvSt6HYnhuOfBgNcKQAUc3ZarlYLfUidPPCWuExBrWxGD+0rXRtL02R7lCSe6r2cTcDgKsg+rFeeRCd0+vw6VCOr4Ifs2n+xmTEAHL0WsL+/c9rYUiuX0i3h52UDYkAulWaYAh9IR1/ywXUav9bwrKICNsdPkeoPedxNGIvn5nOhv3wIen9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789467053; c=relaxed/relaxed;
	bh=unkCLCcKHY56rsUQuuJhM9lplnY8sZMtXiwEiIG5bZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq3NduFSU5QtBeuKTLGjD24rVKDjzJESZIPocqRSPO7QDRbEpyuqV7QZAjPiV3/O5M2RebKIxd9w6jOx/bvwKWn8zBs7kVahMkWC8VeQO3E3V0HvwKKisMkUc1pzYhajsXh8idyqp3M+WTPB3PO+qmarVgKmECU44OSHFMfrV5/wd5IpUKLYFTFjkunVgnwxybe56mu38fzMCN36WxFcfwzCGeF2UhzYK6pGxF/j+GgBLqEHq2jRivM5RqGpmeniwQ9dCbKquUPbL0EauTetPNl8nqnUQ5CCvLo517MU9MDLFpuWnaW7h9F0wt9CJApGr7E6/3YhAHrpjEY6/cUvkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gmPw7Syk; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gmPw7Syk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Tue, 15 Sep 2026 20:10:49 AEST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkd7s58MKz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 20:10:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789467050; x=1821003050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jxYDYzHVYPq4YEIyup/T+qLWIcnk64L3iLPbr0dWZJU=;
  b=gmPw7SykjTJ6bEzje+7vbCAmmAbSY2due04Ynry/1nr3QPo3NpEN9PGu
   RM1omlTG0a0LQ1a5+OTO59A0TbX24EIUw2rqV9yHRGRr4jnst9sgp7emh
   hX3NQz4Od+ACeMKbsgsTteTrdYWi1NeMV604r/3x5nORQM+E4dmWMnTi1
   Ir0sTtbkGMCGbo9H8u/Zb4IhTn1GDh2Ah5De9JKH6L5RrGe7XYnsCpsCE
   Ud00Lcrp7H5v+kwMMV8oeNKfpx6I55aIW4l+i9tq+Y3qapXDjmAzTb8R4
   VioMe8dHxM+atoD7f5szmvchv+T4/okSeAnCvTvSx4f/MmqTv/DPMybv1
   Q==;
X-CSE-ConnectionGUID: reNlT4dVQSKmmn4e3bdB8w==
X-CSE-MsgGUID: KmTXYXoCRYuV5/wnqBuQhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93524789"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93524789"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:09:40 -0700
X-CSE-ConnectionGUID: xOLmSWPLQt6bUxhTM7s3Ow==
X-CSE-MsgGUID: YCeL3QUOR+uEihCX/mCHZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269670281"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 15 Sep 2026 03:09:33 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6E192A1; Tue, 15 Sep 2026 12:09:32 +0200 (CEST)
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
Subject: [PATCH v1 4/7] ASoC: pxa: Replace dma_request_slave_channel() by dma_request_chan()
Date: Tue, 15 Sep 2026 12:04:25 +0200
Message-ID: <20260915100931.3593242-5-andriy.shevchenko@linux.intel.com>
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
 sound/soc/pxa/pxa2xx-pcm-lib.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-pcm-lib.c b/sound/soc/pxa/pxa2xx-pcm-lib.c
index 88a9d3226302..0ccf88aa1138 100644
--- a/sound/soc/pxa/pxa2xx-pcm-lib.c
+++ b/sound/soc/pxa/pxa2xx-pcm-lib.c
@@ -79,6 +79,7 @@ static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_dmaengine_dai_dma_data *dma_params;
+	struct dma_chan *chan;
 	int ret;
 
 	runtime->hw = pxa2xx_pcm_hardware;
@@ -107,9 +108,12 @@ static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		return ret;
 
-	return snd_dmaengine_pcm_open(
-		substream, dma_request_slave_channel(snd_soc_rtd_to_cpu(rtd, 0)->dev,
-						     dma_params->chan_name));
+	chan = dma_request_chan(snd_soc_rtd_to_cpu(rtd, 0)->dev, dma_params->chan_name);
+	ret = PTR_ERR_OR_ZERO(chan);
+	if (ret)
+		return ret;
+
+	return snd_dmaengine_pcm_open(substream, chan);
 }
 
 static int pxa2xx_pcm_close(struct snd_pcm_substream *substream)
-- 
2.50.1


