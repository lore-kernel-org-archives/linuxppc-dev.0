Return-Path: <linuxppc-dev+bounces-27310-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4599C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:11:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkd7z4rwpz2yps;
	Tue, 15 Sep 2026 20:10:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789467055;
	cv=none; b=Yz0ZbjuRkLjmwhvAcwsSjb0560MQotmLjWABUdrHYncWFwxv9faDW0QcztWx0YZG+XctEjtnid4msWuD6VRjmIyOySj/NVyD7YWRE60e/Dg9XQlCREYLtXNOZk53adhzm8s2NdcGOm2z0zdAj3YJS8J02ow88M0YG+x0PzGCy26g9K/Qp8wN+82igrtZoSpchUSthnL3eGl9YCH2fH2TFaevyLHqybF0QutH+3uyTwCESwVj8ccLRpb85xzaGGWvEILF7n9hRs2f12NEQWt2RWmGdTTrMplnObKmOj50VqlGwMpKE4LupKgEx/eqrn3+kv7Hx91CefPG7pusshCgag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789467055; c=relaxed/relaxed;
	bh=qQqM77rtghvgKu6YabCwwuVBNYl794CidFfVv4BKvYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UN1BXCEkbK1bB+zPUPIXSEY+EkziGezP8eMrtaWXDhtEIQTS+XtFYjpdunVq6Trn3FRbEcLFcuMceUmS+1rGrn+cHNpYjcacQTGFnfw5ZQjVMF1hQgL2BA/7HPBcM/HWHdpFGhj1ohEuLBCnymbp0r1ltrNVXPyzbrVOKcteR2BzmQ9NlHCer90Btdeq3ElScvKDs9eAiRTzT5rOZ0zrrYE0eRQd/Y+xzpekTHxBLvSXssGn+mYWzxJsQC5XuyNgQq98Y3JTtoKUrqc/r1FN2A5sIsz7jRWsK9i0qX/w71jG8bkE/wzsZBy/qHlptIKVeoe5CsGy2TKfVdqkrWzbMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KneEG3dT; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KneEG3dT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkd7y6hNkz30Pn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 20:10:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789467056; x=1821003056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W9AeHQQ9O7vDh1ohv/edIAywDUCEHTQoqqfoGL/kpls=;
  b=KneEG3dTXmxLD/PuEarIZ9h5owFhOWdUDmUTBANqlnyobRdX+2WY5GzU
   Mn5F938pEvrarrXmeynm/mS5PaRN16bxk2HCF+zFxl2rhfYWiWb/nDu9O
   RwMRnplDoJ0RBtqA03ulLDrsyh6uSd5EdTej9hLQLAKmXkALHUcDqqim0
   Q2/ob3x7aHzvKRSY9B0nwJrs99XnMtbHI2MGKcG0cfypnOLVJJFCtr0Hx
   lNkT9vQELAc4jFXqzIal3O9DoKYa66TBT4TJrBLq/F7OHigcWborqWjv+
   MOhF2hg419rxKJV9kCDFWzBKCEoqVbVFEdro6WAWHrG3tQKkkRW4qxXHy
   Q==;
X-CSE-ConnectionGUID: a+Yfja07Sxe3fUJ+H4EM6w==
X-CSE-MsgGUID: mtGb/JSMSI+aqRZQ6v7fpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93524820"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93524820"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:09:41 -0700
X-CSE-ConnectionGUID: K1NmNoVzTm+8qhwkZ/RYog==
X-CSE-MsgGUID: zb6nhcKYRhehd3UVzZyxHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269670283"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 15 Sep 2026 03:09:33 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5BF7799; Tue, 15 Sep 2026 12:09:32 +0200 (CEST)
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
Subject: [PATCH v1 0/7] ASoC et alia: Convert to use dma_request_chan()
Date: Tue, 15 Sep 2026 12:04:21 +0200
Message-ID: <20260915100931.3593242-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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

Convert the last users (mostly in ASoC) to use dma_request_chan() and
drop deprecated dma_request_slave_channel() completely.

I think the best is to allow Mark to take the whole lot and provide an
immutable tag or branch to others (DMAengine and GPIB).

Andy Shevchenko (7):
  ASoC: stm32: spdifrx: Drop mention of the deprecated and unused call
  ASoC: sprd: Replace dma_request_slave_channel() by dma_request_chan()
  ASoC: soc-generic-dmaengine-pcm: Replace dma_request_slave_channel()
    by dma_request_chan()
  ASoC: pxa: Replace dma_request_slave_channel() by dma_request_chan()
  ASoC: fsl_asrc: Replace dma_request_slave_channel() by
    dma_request_chan()
  gpib: fmh_gpib: Replace dma_request_slave_channel() by
    dma_request_chan()
  dmaengine: Remove deprecated dma_request_slave_channel()

 drivers/gpib/fmh_gpib/fmh_gpib.c      |  7 ++++---
 include/linux/dmaengine.h             |  9 ---------
 sound/soc/fsl/fsl_asrc.c              |  2 +-
 sound/soc/fsl/fsl_asrc_dma.c          | 13 +++++++------
 sound/soc/fsl/fsl_asrc_m2m.c          |  8 ++++----
 sound/soc/fsl/fsl_easrc.c             |  2 +-
 sound/soc/pxa/pxa2xx-pcm-lib.c        | 10 +++++++---
 sound/soc/soc-generic-dmaengine-pcm.c |  8 +++++---
 sound/soc/sprd/sprd-pcm-compress.c    |  7 +++----
 sound/soc/sprd/sprd-pcm-dma.c         |  7 +++----
 sound/soc/stm/stm32_spdifrx.c         |  2 +-
 11 files changed, 36 insertions(+), 39 deletions(-)

-- 
2.50.1


