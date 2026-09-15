Return-Path: <linuxppc-dev+bounces-27313-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9D9C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:11:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkd815Xrxz30g6;
	Tue, 15 Sep 2026 20:10:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789467057;
	cv=none; b=ct8XkwIUH3/OXNr3nJuGqo0BuNxFKye54gaNObjpD1WFTzkIC4ydp4Figoahj8wN5P6C/cVQxSofxBP0DTiMcxul8iZeqBFXmFga2rnjEBhyXSsvzLXFez/+NLpY/r0N+bL1gR7s9YgRawtHShr0EYZr8oYEtIPN69vlutZ27rdkGu7fsE50jkVzJLPoe4xgQGqTFZ85Stb5yw+arKQSI0FV2zhVBeW5bWQWNlIJrFzIsqRtqA+mZqrcpPc9UHw0zmzWwZnMgIYuQPEphA5tQKnQcWjuQAtWjHLI+Ilg3vK5UBZOlRlpMUR7RzGsTx/QFa//IDzlQJtvuZUJGdtAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789467057; c=relaxed/relaxed;
	bh=hA0yOVAYbs6l0ZckmIs0Ox//Qo1RL1DMIwaKQmmFu1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1OJU5zQU9Rr6Jkh3pf+G5ejpXw5kvvSiBerGaYgXtfLrHdU2+QKSzCg/ewfbmJlp2XgjyNP0qEnwx070R7vEins3+OfFZ/7BTpoMt5t2fKQxs5+Jp8vlnhaCn8/WWWZdWFoMNRAxSnnpw4RPpv7ScfJD+tRzobzGCP+1qsO7VLgqNErrdThZzvAwDBg1lvgZuWB34z7ixa46vSkI8Kt51fbNXAL0p9SuLdRz4Yd3mfwHot2Viyl4cpWPlNkFsPILHXgKzJtAqAmGJEKOQvv6OCSyviVPwguMQgxzdYRtb/t0Le/uEpcQAeLS+gJS2J3pXq0wostZpvEDIy+ArUDQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nvH6XZaU; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nvH6XZaU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkd8061kPz30Pn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 20:10:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789467057; x=1821003057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0d8AW04j6ZeFgJ4c0uEx4Ne8a9AlVDa/j/DF24QsWEE=;
  b=nvH6XZaUMJcyzE5G+DptodY0pLRuAEqx4uv5zZ8qE2lKKg5jKdgSahPi
   B3pS0ZRVfILM8wXjUddjyQXiCyG+AcrlAmAalFuYg/5L9mVlh6Q4/OUQH
   n3DgCLZQSG4irtOLyowU56qtV1dIBTSWAAue+CgWeTtwZKf3tKG+Q+VG+
   3dJp/NPB2u0I/CAHEppssuqUO5op8SGlJ0pge6AqYtDiuv7uFOoe6L/YC
   g5LwKbQC0E8GO/GW0b25giAvFlgDrXWgDNRo0jQJyKYauKadFalG3rjsh
   YlplkqzCjqGPIveSzS3o2OAM3lEHuC+nPix2ojIqUbQ3nDK1RLiR3oLDM
   Q==;
X-CSE-ConnectionGUID: JXviiLEUTXebWD7gFjGFyw==
X-CSE-MsgGUID: blhOu+e4TvezxF3JMMdtRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115360976"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115360976"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:09:47 -0700
X-CSE-ConnectionGUID: 6KAa62Q0Q8ql7BY528Qu4g==
X-CSE-MsgGUID: tKnat4EfTZSUkMp5WOouHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271517612"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 15 Sep 2026 03:09:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7D1F3A5; Tue, 15 Sep 2026 12:09:32 +0200 (CEST)
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
Subject: [PATCH v1 7/7] dmaengine: Remove deprecated dma_request_slave_channel()
Date: Tue, 15 Sep 2026 12:04:28 +0200
Message-ID: <20260915100931.3593242-8-andriy.shevchenko@linux.intel.com>
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

No more users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dmaengine.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c50497ecd52d..7596ebdac466 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1763,15 +1763,6 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
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


