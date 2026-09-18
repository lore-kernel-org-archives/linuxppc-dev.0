Return-Path: <linuxppc-dev+bounces-27731-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD4FC982DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:38:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmVwp5smMz30V0;
	Fri, 18 Sep 2026 21:37:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789731466;
	cv=none; b=JgNQuYAa29/6/6Jdm36smIEbpcHUFXPU+iuAcirM8IxTLDvPIzkxO1ZCyH71/55CSl6YQ5JnmkOcrbBeAeqI2CMC4RcR4/TqSHML+wpWk1h5uc3PgUWZUBiOaZRSNlgZmZrpYuE5rU4fx/OpEaQy8Ug0WgzVx7ksO3WSgsZCZZYA1Hr94gEf6s6a+TaNeH4X5KsH0eYn6Yxi5uZkwEPFF8aWEUv9BYRGDTi+fb0S0wwkvMzUX/e3phVfxIKyZ5Ny2dmy2V8Af26q6T6lbfzFbT7suL0UV1dVcyWEHotiKuvbNZJaSTRPbrA2awb0e93+aBpawnta+VvRxNJSrd1Tew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789731466; c=relaxed/relaxed;
	bh=auhvNUtNhHzN8ivUnjTOLnzCC2fZ2k/foSyeLDAvO2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDAyQoeNHhk2vUjOc3Mt1PDE+AJBPh9HmV/+VkPfZe31MuvUSf4bvrrCBln9x/cUz/vZwCw8chZiOOqIsrZ98vacGjXOsvKbuHufNfXhTGtnojj5Z1c25M1FHGzG36VhHh+Q1L/AvgARdZUpufzYfWM3MQPKIbvacjbLN3lBFQaTa6wPm2PJFr/u02znX9j9V1/WL5AVb6q1GLKiFQIaRkXU8PicQf4XcaIsVSGnKM+tUcY8usxrxUR6Tr/UOp0v4P4jFkeS7ohFW+OT3WV6lIXe4/gO6UZeWTWZW2HZqrsbSr8/XDoB3tMkNBbJIpfm5SK3cD/eF4jd07a/JI3rdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nHAmPP4V; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nHAmPP4V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmVwn2pC5z2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 21:37:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789731466; x=1821267466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iHSC1nNEnhUx/XbEolv5AtLHIEcgA20Dn5X1VVvaZ8M=;
  b=nHAmPP4VDboovFXYc9UX9yRiYqO4TrG82uI3S5XazGD2277gSUQSo+CG
   fu5YomssppCHl8qRtEuqlOKkwpdDN04cMNnsA4sJAbN9YYULaEaKXOWDK
   gCB3LRfRYcHgOuWI3t9aRBSUOsoPYBW6Ga0cGb0Eg1f4QvQ4WAMUOorqL
   /087PDwbWkPss8JCbNAeZjXunkFVF46PGraztMK/Klyr17ph51FqrASnc
   EkOGIsLOFUK+B2xKvZ/x6TV5AKNCNc2s9hBz/4RIkcfocP9YTiVQDPluQ
   uBKUHsqExZgVXFIMefKb4vhqg6jkh2Cy9QMpIOrIegAuZ5wDSv2ldeyO/
   w==;
X-CSE-ConnectionGUID: E9HKJcMxSaq6JOkbm4is7A==
X-CSE-MsgGUID: 3EIMMkzmQhmlPvuwVjhVAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="89367469"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="89367469"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 04:37:41 -0700
X-CSE-ConnectionGUID: vwoX+4jyTkKozcevs1734A==
X-CSE-MsgGUID: P5cUJ9SJT2GCeaMH1c7Yjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="2783683"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 04:37:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6CEB5A1; Fri, 18 Sep 2026 13:37:29 +0200 (CEST)
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
Subject: [PATCH v2 4/7] ASoC: pxa: Replace dma_request_slave_channel() by dma_request_chan()
Date: Fri, 18 Sep 2026 13:34:08 +0200
Message-ID: <20260918113727.1898998-5-andriy.shevchenko@linux.intel.com>
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
since the former is deprecated.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/pxa/pxa2xx-pcm-lib.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-pcm-lib.c b/sound/soc/pxa/pxa2xx-pcm-lib.c
index 88a9d3226302..4b5b07f0c444 100644
--- a/sound/soc/pxa/pxa2xx-pcm-lib.c
+++ b/sound/soc/pxa/pxa2xx-pcm-lib.c
@@ -79,6 +79,7 @@ static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_dmaengine_dai_dma_data *dma_params;
+	struct dma_chan *chan;
 	int ret;
 
 	runtime->hw = pxa2xx_pcm_hardware;
@@ -107,9 +108,11 @@ static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		return ret;
 
-	return snd_dmaengine_pcm_open(
-		substream, dma_request_slave_channel(snd_soc_rtd_to_cpu(rtd, 0)->dev,
-						     dma_params->chan_name));
+	chan = dma_request_chan(snd_soc_rtd_to_cpu(rtd, 0)->dev, dma_params->chan_name);
+	if (IS_ERR(chan))
+		return -ENXIO;
+
+	return snd_dmaengine_pcm_open(substream, chan);
 }
 
 static int pxa2xx_pcm_close(struct snd_pcm_substream *substream)
-- 
2.50.1


