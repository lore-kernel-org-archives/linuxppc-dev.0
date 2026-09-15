Return-Path: <linuxppc-dev+bounces-27312-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB07DC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:11:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkd811R2pz30WS;
	Tue, 15 Sep 2026 20:10:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789467057;
	cv=none; b=j2TYYPAZIkOZdHsvCtLC3m9Q1T/fobCC4zRjtu//w1g9gvW9vwKuHo7dJNZfi6hiRbIn6VHYxsHhmQK9QY3iSPV2fUO9eTCIUT1ZSHDivPMr7R2A/2YtQ+5J8Qsa59i0GnFrAmQzL81b8i3zB3VXqB9aYiObw+ekg4VvGnuachZjB3N8T4bvuC3FL6WbpsZaXEwO7IQShQ3e9CK6orNd7uCF6Hkcllxs8QFsVdX2dX9SPKb7l7PmVqoa+82548USvbWJkPRdJiMVFouPN3woY9ogCGWXq4nvz4dUZu9YCsWjPrQtgPlzv3SuAvP8p1rqBm02lzTZWZldPT/BDYDFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789467057; c=relaxed/relaxed;
	bh=Nt6L3uvH9A57PRirqx3Jv0druz02+OMIZdsGOyesZzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoI3KcXcz1+yOtCgM/cjOx95/gazEtPoY/F/fDI30h4Qbs1qKJgyVkNt3NV7JO6908ABLvsvbhCRSy5BK821TbMYnKv4SS355d0Ruk1X7kcJGQy7aLwNw6+XJ8yIrcUNHn8EdDeauCpsFlTjEOtCdDfwsUGO+j99tTmsz3pEgLUxNzpb+YCbvK0uXNHwExnKVstu54+RbfOV3q0fklaBNeobV+Lw+C4e4TkrKe1rvu97tJMWenNxB2+NseGVV8yByLe9JjF13H80VjeAarjvqM/AXgk3IvSkZk9AUZezRdiipuLzH6eg0mdLkldIFjw1M6NutVy6Qy/9CYHRXh6Aew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XUvDaSlW; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XUvDaSlW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkd8030qXz30VV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 20:10:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789467057; x=1821003057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XLzgAaMNDk785gOrzo3Jw9J0cT01zC/WwTUadr7d3+M=;
  b=XUvDaSlWsAqPdm+TopGk/l2kpPtBe6a6q1L7r87idk7apXR6cKRiD5ZP
   0KwHr5Rinq+BXYEc3MTSH1t1/GOfjnpyjwjYqNRXpgKjQlzYp7+O0dwMJ
   dYNRENzP+VVIK6yUMB9D6Hm5szt7zoVijzxwi60QjczVS59Z7LauxVXbe
   av1HAHDMWZtOOUydQC1SPrwMYwQ70Jikp5JukVTICGaWjDlHug1v8ltbv
   9TmlMSTyKIS/TIlfKNyTQKG4jgkSP5508cPqQcXe6MdXgj7++4uLTdLFD
   1JHZ9x7Axlj2F8YBSxvbZ76Lc+3VpOslBoW5KHra93hHraI3Bg4AYEaZq
   g==;
X-CSE-ConnectionGUID: uXL2ELSfRm67MhCYHI4ljA==
X-CSE-MsgGUID: 4Y73w6OOR7mQoe0ssZ/7aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93649150"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93649150"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:09:43 -0700
X-CSE-ConnectionGUID: 94G8huAuS4W8E8rtBCaQHA==
X-CSE-MsgGUID: 5uCh+aTIQo2HoQ0Fyhoeuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296442482"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 15 Sep 2026 03:09:33 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5F6509B; Tue, 15 Sep 2026 12:09:32 +0200 (CEST)
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
Subject: [PATCH v1 1/7] ASoC: stm32: spdifrx: Drop mention of the deprecated and unused call
Date: Tue, 15 Sep 2026 12:04:22 +0200
Message-ID: <20260915100931.3593242-2-andriy.shevchenko@linux.intel.com>
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


