Return-Path: <linuxppc-dev+bounces-27311-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73993C88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:11:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkd7z745Zz30Tm;
	Tue, 15 Sep 2026 20:10:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789467055;
	cv=none; b=gHwZ/BZa86nllqhgv66RV1jUzCa1MTBSuAbzrcgGeDSedbSn8dUQMtFJBqKN883VTfYR1qWT/thy+9+9enON9FrS4V+lnslsH3RQsa/JPKBqyUX8RxBWk1BZ9E2LDXhV+/uMIlnxkD75qJ8QUaAr+YUFVenpb+7Ze1PslR7gA4+U0bmHyWa3ZSN0PZ+CeFZHunErYK/f+wI5Z2Lp2Sf7O7JmM1tBgn9wPKAXrI7cDAdjEKLj0TEGf3RZdTf/uKtmLkmio+ELVD1AmP/Fo3TieFaFwFqUGYbaRshfBSNdYcZZsD5s5oOgnboWbfKmMCUXBmtC9MfY99RnlLZvR/HI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789467055; c=relaxed/relaxed;
	bh=DOLdmoMA90ePHrObFN66+cI371ZUZG8vr9aDokr1vns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJHrf0XipKNO7GcL0imJZRzMhgVLbRtGrWebzbtfL2s51xHAd5f5yrNcQ6lHDR3QeGgc/5ixIvf5141HVlW0jk/bjbej8Xb4M3eTRFfoGC/meeSI0FPawYUVdnbGMlk9HNgRfMcyX9mbX4OqQ3mJCwWR4UpxSiruGfb3W18mzfPT9MJ8IOGM32TT9DGPodzJsxkWlbzQHVRFnG5ekTW1JjCjTp9ATMjhec8xxsxeTbkq83YnV5Ollrcz2LwlOITOmCP2ve9RvayUlFlrVzYObU9onMkIRFvKLBnyQTBA+wNx3IgNK+is2P4Sv5XWg5IYVUA9GUF0cRTTjPDlKkPT8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LICPYeTF; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LICPYeTF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 63 seconds by postgrey-1.37 at boromir; Tue, 15 Sep 2026 20:10:50 AEST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkd7t6lWQz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 20:10:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789467051; x=1821003051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w2DAbC3uMPgmhkJrhUyn5lKx37XxWntjSija75HyW4U=;
  b=LICPYeTF3car3UcAvhe0p+rpOcJpz602/EmNz8lqHYAzSmxFDH8bqOYM
   vHZKcvoQiQNxwPAyXGyqCp34UAuvDVoJgj/sWN7ARwY/dFXEpIB1RYNWB
   HUpcewQaug1yFhY+GhVhoT2a8zZL4sUwv4eZtOecUpYeety6P4bR1b//r
   naZP2UUPxJWjHUU4xRPgE7X0Qg1+/sEdFnIFs7tXDgfbCGOEvehubFbzZ
   Rw+6K1ByT0rAjvZTD4FITzsiIZWBaVJcIh8OJS+l/Rm3iZ82sIPTpjEtj
   83inJ5UcJovVCmr7d2lUulVQyzaMrG9I3qB7BClkM++YMmA7vzKAs1j/m
   Q==;
X-CSE-ConnectionGUID: /7FZ0bjMQ0ev1YPL1Zd0XA==
X-CSE-MsgGUID: ICCbQVMFRRqsfNPEu53zXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93649162"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93649162"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:09:43 -0700
X-CSE-ConnectionGUID: aMDeGoWGStOWi0L2fcNgqQ==
X-CSE-MsgGUID: AzomspuhSQKxEu/pCuSgJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296442487"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 15 Sep 2026 03:09:33 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6438C9D; Tue, 15 Sep 2026 12:09:32 +0200 (CEST)
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
Subject: [PATCH v1 2/7] ASoC: sprd: Replace dma_request_slave_channel() by dma_request_chan()
Date: Tue, 15 Sep 2026 12:04:23 +0200
Message-ID: <20260915100931.3593242-3-andriy.shevchenko@linux.intel.com>
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
 sound/soc/sprd/sprd-pcm-compress.c | 7 +++----
 sound/soc/sprd/sprd-pcm-dma.c      | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
index e5249924b54d..5613c25fffd7 100644
--- a/sound/soc/sprd/sprd-pcm-compress.c
+++ b/sound/soc/sprd/sprd-pcm-compress.c
@@ -153,11 +153,10 @@ static int sprd_platform_compr_dma_config(struct snd_soc_component *component,
 		return -EINVAL;
 	}
 
-	dma->chan = dma_request_slave_channel(dev,
-					      dma_params->chan_name[channel]);
-	if (!dma->chan) {
+	dma->chan = dma_request_chan(dev, dma_params->chan_name[channel]);
+	if (IS_ERR(dma->chan)) {
 		dev_err(dev, "failed to request dma channel\n");
-		return -ENODEV;
+		return PTR_ERR(dma->chan);
 	}
 
 	sgt = sg = kzalloc_objs(*sg, sg_num);
diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
index f509a4601de2..1586eff61120 100644
--- a/sound/soc/sprd/sprd-pcm-dma.c
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -171,13 +171,12 @@ static int sprd_pcm_request_dma_channel(struct snd_soc_component *component,
 	for (i = 0; i < channels; i++) {
 		struct sprd_pcm_dma_data *data = &dma_private->data[i];
 
-		data->chan = dma_request_slave_channel(dev,
-						       dma_params->chan_name[i]);
-		if (!data->chan) {
+		data->chan = dma_request_chan(dev, dma_params->chan_name[i]);
+		if (IS_ERR(data->chan)) {
 			dev_err(dev, "failed to request dma channel:%s\n",
 				dma_params->chan_name[i]);
 			sprd_pcm_release_dma_channel(substream);
-			return -ENODEV;
+			return PTR_ERR(data->chan);
 		}
 	}
 
-- 
2.50.1


