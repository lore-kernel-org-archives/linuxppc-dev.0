Return-Path: <linuxppc-dev+bounces-27735-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A1EC982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:38:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmVwt25xVz2y7r;
	Fri, 18 Sep 2026 21:37:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789731470;
	cv=none; b=eIX4OPS45FnN8lxBSGZS4TT3VeVN352lMQ0orwtAL7zwhhGhoh4GWxDjsHySz+2cmwzFm5d+dF2aZuGdR3lFYtjMvQaZuK7lxHIlseAQjiWLj/1ypam24zG1OKSSHuWo4EJWGbtU8xvzeo7KHqb+GBdYYb5n05xxbmmEDizjDiqiK+/HjiwhXoozvRikbNsk688aMhh1IxCzjsavCQzq8c27e5+6yBDbmo7h+fFLuXbeC/om9nwAtYV0EaqaZQ0s+dLadtP0wP3JckyoSlYvd60mbQO+RiKNzsN8L7HbdNWXfUL9zptHqIHHpOdQpeSN9SZr+JHQ1g8jFIaG5DlM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789731470; c=relaxed/relaxed;
	bh=4KsdukRpL6sakIWtrVDGHhPDBcwJ9oEKV+9OztPr5qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6x8l9M3eLKYhHaAutibBZ78lMfnATMRcpt8AfVHtHjmqqE7aTRo1Y4+Rb5Be7xXokFNUdEUSdhlaq7ZBgngAqZ6WDdwbbPzhdaHmFzG/+jekIQ6y2yXESFD6gINVwtn395LN5st1/O0ulSeu1TCrjziJRcwv0eWkomso/bSqPrFPM1i/CNW8jlMaHnC2PoEoqn650jNIq+0rNZCkSPuajdfn2ufSEVyhnMl0bzVR28XXNinm73JCdThafOWis8mrnz/nV3BSRofKmYnMeYJeXKWyzodCdh8sjUUZ0BEAnDPvE60PVUysvhCqzIZHJDB1qDGl8HaeIUDUilG4d91ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O8wQSz/O; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O8wQSz/O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmVws2MSYz3bZf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 21:37:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789731470; x=1821267470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YSI2Kqp03uJdGsxs/TigJRkMGLCix8Ae7tfRm9DSN0Q=;
  b=O8wQSz/O2DdJbklxjFRW8n6I1ary6hcPgeh3QIVAtzW3rxXDMYxr6/iD
   Nl2kX5DzqgMeiPu9eGhTZMgqjvqLbbfso7I5HpGAqNuD5S1dQw7i2KWBP
   5DX+43SFhDxZIYaBidS8D0iAQGafREKgWHvWB/TzFJqi1SQaeBftoYN/w
   pU7TfP184gwhLAab6Gow1rRMVewRMm/qefdorhWFAPedYRgH7IyiwRVW0
   7YZWJMFo9+RMwFalyb4OtzrBrhcJl8kkeR3v5lLpsRiqbz9BMZh9CIvmE
   /UVlxdtITHQ/ZM+pWn8Kfc1wcQt+6RhuaL2EyKoP9GPX67ARWs2IDzF7A
   A==;
X-CSE-ConnectionGUID: BtPyOt85Qea0PcTHDBawcw==
X-CSE-MsgGUID: mi560sUsQC6dcDVHKTpWyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="89367495"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="89367495"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 04:37:47 -0700
X-CSE-ConnectionGUID: c6DS/Y6KQE6nNfenLUwhZQ==
X-CSE-MsgGUID: dSLxz0Y6Sn2i5TM1ASrqFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="2783722"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 04:37:41 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7BEA3A5; Fri, 18 Sep 2026 13:37:29 +0200 (CEST)
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
Subject: [PATCH v2 7/7] dmaengine: Remove deprecated dma_request_slave_channel()
Date: Fri, 18 Sep 2026 13:34:11 +0200
Message-ID: <20260918113727.1898998-8-andriy.shevchenko@linux.intel.com>
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

No more users.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dmaengine.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c3a49a33307c..1b57bc4a7e72 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1768,15 +1768,6 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 #define dma_request_channel(mask, x, y) \
 	__dma_request_channel(&(mask), x, y, NULL)
 
-/* Deprecated, please use dma_request_chan() directly */
-static inline struct dma_chan * __deprecated
-dma_request_slave_channel(struct device *dev, const char *name)
-{
-	struct dma_chan *ch = dma_request_chan(dev, name);
-
-	return IS_ERR(ch) ? NULL : ch;
-}
-
 static inline struct dma_chan
 *dma_request_slave_channel_compat(const dma_cap_mask_t mask,
 				  dma_filter_fn fn, void *fn_param,
-- 
2.50.1


