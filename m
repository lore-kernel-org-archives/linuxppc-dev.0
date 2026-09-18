Return-Path: <linuxppc-dev+bounces-27728-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D27C982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:37:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmVwm6zFDz2ygK;
	Fri, 18 Sep 2026 21:37:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789731464;
	cv=none; b=Onwokl73oosji+lHyH0ud6Wb/jNmJMd/3HfsGmy/gJErvzdhBx8Rr+eTM8kpXDXn9SS3pTpGB0HA2mwefTsSO7h7Uva9JkWdnVtB8XHTaWStxThs9bvDLemJYtPdpp+Ftijt6ugP0jHlyVxxm+O+LP47H7Rs0LyuDX+rMr3+AWGZuoO18kpUZ5vqftN5rcMp2Esj07vY1+4PUpHiWs0r+ywZJCXTWPNQQzY5fCj1TJ8K1BVr+fAP2iypaTJNYLgJ/a3hxV4foaJlHC8LJ8tr6dlha2jckNwD8Ck7T19SsnaLKWwmQJVv5AVGBIJ32LOK3s1aQtyYgkZZwGs9caDsrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789731464; c=relaxed/relaxed;
	bh=Nt6L3uvH9A57PRirqx3Jv0druz02+OMIZdsGOyesZzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwxzPTyyxCqC27Rue+SYMCo+nk3ACVhwDRga4LOVmuFF81cDFimaTfNV4s1bBn9ScZCrSwrSjOgYZWMyMdkddyBxXm6LuUkt8b39kExd9Uy5ld8g71pw5M+d1M1vPRkb1OH3CYomIVDgHyu+2Cbx8sz5gp4c6/XXnIUV8GQRQeGjSfWScKdynbLBcgPkVP4VqseHkh90MDLEUDQa/hI0P1R6GEl8LTF8pnQSbhOqrWEoSBCtk+GBxmVJD48WDIrdarmhTKwvwjQP7jU0uQqUzrlw5ZWRg1xri+Z8G7fsObS18jdR3hZ13dbz6tLFy4xfg6MDmt5bAA0375/TweW4/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nHeDL3Y2; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nHeDL3Y2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmVwl2Rrjz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 21:37:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789731464; x=1821267464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XLzgAaMNDk785gOrzo3Jw9J0cT01zC/WwTUadr7d3+M=;
  b=nHeDL3Y25dWhdlVfEL6inPqqJxfA23HNE//V0z97RQCtavT7+D58rMrZ
   wIXBr5A6lpq4NtWHQv80mXoxgUb+cCNfPNP7RRoFZY3dz2owwHODthPz8
   Ae4sCwF0oStfYBrQjUq348EH9Yr/bRji87o10Fb2I69MvFo61GEHb4N3e
   7AAGrbVray04oTMw1rS+KVeVDhOm5h0ZU3mJS14ulK9Yyl2lqMCdLxBHc
   1KYHHutIf+nsJxsFoGBTSidIkid/nZeaRkTdCbMVRCEAGYDeCCPmdDNfv
   1CtyAPHkHhvs1PIe2MpWVCTrhqT/QUeN0+KGFrCnbi+4n8X3upqNuEyCA
   Q==;
X-CSE-ConnectionGUID: xgMWzITRRM2/iWVjHuLpLQ==
X-CSE-MsgGUID: RrH/YvgkRwK2O5MoLx3G5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="89367459"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="89367459"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 04:37:41 -0700
X-CSE-ConnectionGUID: StlknkQKRBWNDpL5Ln95KQ==
X-CSE-MsgGUID: 9pOIgltNRyOJG64WTtDAzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="2783682"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 04:37:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5D2009B; Fri, 18 Sep 2026 13:37:29 +0200 (CEST)
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
Subject: [PATCH v2 1/7] ASoC: stm32: spdifrx: Drop mention of the deprecated and unused call
Date: Fri, 18 Sep 2026 13:34:05 +0200
Message-ID: <20260918113727.1898998-2-andriy.shevchenko@linux.intel.com>
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

The error message was not updated while driver moved from the
deprecated dma_request_slave_channel() to the dma_request_chan().
Update the message by replacing it with the correct function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/stm/stm32_spdifrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index e0fef47a227e..0ece54740773 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -400,7 +400,7 @@ static int stm32_spdifrx_dma_ctrl_register(struct device *dev,
 	spdifrx->ctrl_chan = dma_request_chan(dev, "rx-ctrl");
 	if (IS_ERR(spdifrx->ctrl_chan))
 		return dev_err_probe(dev, PTR_ERR(spdifrx->ctrl_chan),
-				     "dma_request_slave_channel error\n");
+				     "dma_request_chan error\n");
 
 	spdifrx->dmab = devm_kzalloc(dev, sizeof(struct snd_dma_buffer),
 				     GFP_KERNEL);
-- 
2.50.1


