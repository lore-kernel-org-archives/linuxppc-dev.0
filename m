Return-Path: <linuxppc-dev+bounces-27729-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D42C982DC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:37:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmVwn046zz2yhP;
	Fri, 18 Sep 2026 21:37:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789731464;
	cv=none; b=I5bI1M5/YJMbkV94jFimyW0Y54opfu6yuoi9fNHSedszk3gM0dltMUpQsd4DGnj3gjG60hHOvtp8fJ7HiTS0Bn6WmMYnDB5vt9V7T3yt/D8iLIqeKhrk9qUOYTpdOkVzEoAuR7AFJiQBC0jGYN3x4k1GXBtRx4YTfIpJbsZnBA/w9fmMCijWmJysnGUijRj4DyMnW4SNf3yzc/HxWD3RmWIAStDEjOBiX0Vzc4u7hecfDFGRzlt7GiznNJ4WRgynjHESdU7tysQIeflSPPUx06m8nZfVa/h5pHlaLAvHNRGf6x9EtXpJ7JHf+iLz1J2zphOAtiRUPH42R4f6ABCvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789731464; c=relaxed/relaxed;
	bh=q44P+TGcV0oD+z/AvCG4yiydzItwnrsyloeqwtRctNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5/xb1b8WTrj/WGpb45VKt8xXT05F9/XOd8RNLh3c8QenvY669HTTb/7oGA4d4FQ+dfEhZzLWeshT5glloXwckU04lErt0Zup7a3j88TlCOE/0B8XiGX/SVOAkuUKiqP+WPfSTWjZ8/s+ZDvi8a8/XM2Fvhl6JdiRSVaR7ADnMjMiWiohp/o+iIQKOqIm+ujtfe+PY9EbmOfZuyrQEBN35lPsE3al2TPZwS0v88dFrQWgRtPlMy1CED/NWCk0hH6ERmG1Z0t9eZa/AG6KuQzEHfS2p2Rc0JmN2k/3rvj6iqL+SkQIos4IOQYYMAsKXyYdwBZP5d6qBt/YJHXd4F/1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LIWHYAec; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LIWHYAec;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmVwj2DpZz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 21:37:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789731462; x=1821267462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3kWwrnL64mx1dLXwcHsMMT0BAa2zKW4PRgmp1oM+8L4=;
  b=LIWHYAecIywk1+W+9bq2N0nbtKPQyVXiw7EtJN0o0MaRFgIsG3DyxSM5
   U7MqUXuwIkUvpt85Zp4OS96IxTFNasxgiYUI9W1sOwdRKT0WquXUZANe+
   9Ck3RqVDjuzXBPVMsSl7MfeI7LrNt2VccIR+DkVYo5uXfa39qUiiJQYHg
   xHjZRgr5zWBAk3jwUomXrF78CsRt/1VFrJ8332UY7ezCk7AIEzAMTIzbA
   SGTGGzCrIo7Rb2gEWvaVu/rPsxXzcZa5Uz+G+fvJYyIW1Rzh0Dh3D3Sys
   pSH4VPry6ICp8ICqvUwLkfIR1EvOjJTU8O1OgvSQv3Xl9fdgQerj6Q70x
   g==;
X-CSE-ConnectionGUID: a8peqARRSMyAA1RkyVyn2A==
X-CSE-MsgGUID: e9VJ+6dzQ1aPsVBuZUjm/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="89367430"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="89367430"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 04:37:36 -0700
X-CSE-ConnectionGUID: 1R6KiivqQbSH2qbKz/O6QA==
X-CSE-MsgGUID: CLf4k4XbTtOWa//DNCduFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="2783655"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 04:37:30 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6253F9D; Fri, 18 Sep 2026 13:37:29 +0200 (CEST)
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
Subject: [PATCH v2 2/7] ASoC: sprd: Replace dma_request_slave_channel() by dma_request_chan()
Date: Fri, 18 Sep 2026 13:34:06 +0200
Message-ID: <20260918113727.1898998-3-andriy.shevchenko@linux.intel.com>
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

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/sprd/sprd-pcm-compress.c | 9 +++++----
 sound/soc/sprd/sprd-pcm-dma.c      | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
index e5249924b54d..f394121d417a 100644
--- a/sound/soc/sprd/sprd-pcm-compress.c
+++ b/sound/soc/sprd/sprd-pcm-compress.c
@@ -145,6 +145,7 @@ static int sprd_platform_compr_dma_config(struct snd_soc_component *component,
 	enum dma_slave_buswidth bus_width;
 	int period, period_cnt, sg_num = 2;
 	dma_addr_t src_addr, dst_addr;
+	struct dma_chan *chan;
 	unsigned long flags;
 	int ret, j;
 
@@ -153,12 +154,12 @@ static int sprd_platform_compr_dma_config(struct snd_soc_component *component,
 		return -EINVAL;
 	}
 
-	dma->chan = dma_request_slave_channel(dev,
-					      dma_params->chan_name[channel]);
-	if (!dma->chan) {
+	chan = dma_request_chan(dev, dma_params->chan_name[channel]);
+	if (IS_ERR(chan)) {
 		dev_err(dev, "failed to request dma channel\n");
-		return -ENODEV;
+		return PTR_ERR(chan);
 	}
+	dma->chan = chan;
 
 	sgt = sg = kzalloc_objs(*sg, sg_num);
 	if (!sg) {
diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
index 2d5ffbe17e81..2a89dc7616bf 100644
--- a/sound/soc/sprd/sprd-pcm-dma.c
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -170,15 +170,16 @@ static int sprd_pcm_request_dma_channel(struct snd_soc_component *component,
 
 	for (i = 0; i < channels; i++) {
 		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+		struct dma_chan *chan;
 
-		data->chan = dma_request_slave_channel(dev,
-						       dma_params->chan_name[i]);
-		if (!data->chan) {
+		chan = dma_request_chan(dev, dma_params->chan_name[i]);
+		if (IS_ERR(chan)) {
 			dev_err(dev, "failed to request dma channel:%s\n",
 				dma_params->chan_name[i]);
 			sprd_pcm_release_dma_channel(substream);
-			return -ENODEV;
+			return PTR_ERR(chan);
 		}
+		data->chan = chan;
 	}
 
 	return 0;
-- 
2.50.1


