Return-Path: <linuxppc-dev+bounces-27315-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53337C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:11:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkd830kzqz3bb2;
	Tue, 15 Sep 2026 20:10:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789467059;
	cv=none; b=PpxCq8UNASK3OpLaAIutCKF0reRMhcnmtQdRmUAsC3wDmOMPIg20ONKx0+WUdUxV+0FrgmAJz1rySlfSK57GvUurceOqiJUofEBJOpSAzr76MZicyTOgX1Ia0IeFMdkDeTP0dEiYmBFCxcx2dVl6rjbvcsapuELwlCrlOpahBRZQtgNQss+2FSKB1nCSw/kvk1QE72LFlBLUqkE7qwl/P21Dfz48OxA0eMTQwADrvAZeYLuwUfn2c7QyYDkmV6q93Yq6mlJcaF5nJlbKxnrmjs5Aztf1ZGxwAnfkMRBGy+ulKPhevVh6pqqjylFE4qGKX8Nxfo3lkPaZ0idq4UMy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789467059; c=relaxed/relaxed;
	bh=zGebEj6i+Mcb/tRGCA6W1Ao+p+atxNQYMkqBjVq7X1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6e1slG8xtUTc2q3MdbDqys5BmcqA+y+EI/rK9ohSB0OKbckkpsUbyhsJXinZz0oCVZ2EmgH+fmUPTuT7WtcIRKji3UkdKk2N5HmN6QgvEWJL4NMOnYudh37Xw0EhqAeVQorPUJZeBGiveWezjoo/9x6r+V/4s8h+OipWIFdSnObFE5Lkzgfewq9vLp7oB124NRIbYT/AzONFKrZYEdmlG6tnoUo99tKaaTOCXb8QNtovYT0WgPv3KPbJASa/HnDYg/BS3akVKcGAjTeHzYGiK7HSjH3mJ+lxmnqMyVr+4cOpQO6HMtxvfOlmOfsn7oxNOFKGXpBhJU7s5VLjFazlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dUapoPWS; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dUapoPWS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkd821nyGz3bRp
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 20:10:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789467058; x=1821003058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S3szUq2krwYbTZZeTS/C4wC1E20wM6Ut+0nvD27YgTw=;
  b=dUapoPWSSLe26oqyBdanBuvRsxIP1y4tKFZUNPWnO/RphBKhnsOufBPh
   g0Eqhdzf8pjqKmj47SZCjJcWCcT136UXR/VNu7VQq+EdyvbQtLFOMvvwj
   V2YtypGRkclySgBd5NTetHQw0ieS7cAAHfYJAO+QbGFU6YIAxe+c+/QUk
   WF344C4j7yLJ931Oo/c9FYbRknGgpprJIk2cIbDrCElI28qyah7BD62Qn
   t0RAH+pq5jRTOaSUmB13UICz3AsNu+cOGX8U5sQIgrd1L4LQDoVkKV61Z
   vdG5gRb42xrtJo4IGwgeNcp7vl75V2RCmVNWUhuMerIO88o4mIYp/04zS
   Q==;
X-CSE-ConnectionGUID: 7cDGj20dR2yl3LJIyUUcuQ==
X-CSE-MsgGUID: SCUFGhbgQkeGP+gmKZd17Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115360964"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115360964"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:09:47 -0700
X-CSE-ConnectionGUID: 42MLKcpWQmuH0LoosqBueg==
X-CSE-MsgGUID: +GC634cpT4uXWqdlsRFeRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271517611"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 15 Sep 2026 03:09:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 77E2BA4; Tue, 15 Sep 2026 12:09:32 +0200 (CEST)
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
Subject: [PATCH v1 6/7] gpib: fmh_gpib: Replace dma_request_slave_channel() by dma_request_chan()
Date: Tue, 15 Sep 2026 12:04:27 +0200
Message-ID: <20260915100931.3593242-7-andriy.shevchenko@linux.intel.com>
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
 drivers/gpib/fmh_gpib/fmh_gpib.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpib/fmh_gpib/fmh_gpib.c b/drivers/gpib/fmh_gpib/fmh_gpib.c
index 5e10e9353fed..3fdcc673ec8b 100644
--- a/drivers/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/gpib/fmh_gpib/fmh_gpib.c
@@ -1458,10 +1458,11 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 	e_priv->irq = irq;
 
 	if (acquire_dma) {
-		e_priv->dma_channel = dma_request_slave_channel(board->dev, "rxtx");
-		if (!e_priv->dma_channel) {
+		e_priv->dma_channel = dma_request_chan(board->dev, "rxtx");
+		retval = PTR_ERR_OR_ZERO(e_priv->dma_channel);
+		if (retval) {
 			dev_err(board->dev, "failed to acquire dma channel \"rxtx\".\n");
-			return -EIO;
+			return retval;
 		}
 	}
 	/*
-- 
2.50.1


