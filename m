Return-Path: <linuxppc-dev+bounces-27732-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD58BC982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:38:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmVwq1QZvz30VM;
	Fri, 18 Sep 2026 21:37:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789731466;
	cv=none; b=dIUZtpW8GzqUGaPN2HtYsjljKu5Sv19ehta5CJUw8jWOf92qXTTvqbw2PQmjl1YPOB90EvhCaTFG3+r7tev33Ij/GcRqdhsTtyTHcCcSoIjW0FsC3yjHQp8nv/DbF2IsINICTC3kmTPpef9dZhjXqJyX++8yOsOU460wXiowQGL3Jry28bvnu7uB60kdRqklvfqV2rAg1O40Ve92sX1tkPY8wmDFchaJOgIpFHQPhpj6gSF/qRu6V10Z3Y0HW9rig6uGyk5YtK+TfTz0dgky0mvhTAYjbg5YzA3udJr1kE37hOXpcCerCZHZpNeQna5Bbf4JYmWE052LtYfBVjES5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789731466; c=relaxed/relaxed;
	bh=q1vgpEyqoB5Yit/Cccb7tneqG7j1BMP/IM+pD573dhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UO8XNrEEXzszEYkBBOqbCK5UucztJhUOkWYb5Yj6Diy2XXb2kxupvizWxqo5ZNgHBNryLPZyh+KEL8RgzomIABZDu2Un9yUCHX0iupCkfPnEZDGsGkKYHjCy3Y6S37bw2OUtPsvN7cTxdwdiDNTRat8cPPD/h5Lmt5/nsh6a91iKqegmNy9v2gwnBwPQSqE48LjIW17DUK1V0oMxrklVk5xGu6hsMNP/MXuYcmBpFMYBRSKh27OW2jPZUhtn/ZjlrqtMIvDZQ0RaPwLmyuOBBJAaUYuWJj6CciSAn0MI1yLckSAdADF2Iq2OF6DywnfL3QMseved98043OSjVjxjqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aaxO9t0U; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aaxO9t0U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmVwn4ypRz30M6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 21:37:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789731466; x=1821267466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3tCjl0Z1sktzbW2YwCZvEyafyorhC/cCFxIhMbEzRQg=;
  b=aaxO9t0U5/JW+93F2JLG5U7XBbEAmRXc7+wCoEOQ1nhQb32OJyBV8Alk
   QcrYHKM7SyJJqJDsm4QdL0CK5i4Z1fn/qqdo+0s1lX9aMo+9pYu4rZMMi
   OsPhKAS3EXL9z2Y/sCQVF2o/0nYYEZ09uquqRR2EsVmEqzUXtkAw5qCo8
   visPwwVpKCzRUiqzZary6329dU3oGrIW4WCvKwDRNImN1bo8ik7OS8+pG
   uThXo5d2ACV2VeqVba4ZdbdER8GwlzABQD3w/yOZLaTQD+P4ygAnIlxHS
   /2hu8q8EQeMN/052z7e2bF2C+0DfGE6siPcXBPXNpNA9VpGCwvgilBVcZ
   g==;
X-CSE-ConnectionGUID: jfqYfKraR3SOWyGbB8Jkiw==
X-CSE-MsgGUID: MpmidYhOQ0WOuF7j76rorw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="92739745"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="92739745"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 04:37:41 -0700
X-CSE-ConnectionGUID: Jf/bNaFCTZSqe9QU4FSD7g==
X-CSE-MsgGUID: 1EkaHw41Qp2XYb8vIyZBcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="271029220"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 18 Sep 2026 04:37:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5958099; Fri, 18 Sep 2026 13:37:29 +0200 (CEST)
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
Subject: [PATCH v2 0/7] ASoC et alia: Convert to use dma_request_chan()
Date: Fri, 18 Sep 2026 13:34:04 +0200
Message-ID: <20260918113727.1898998-1-andriy.shevchenko@linux.intel.com>
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

Changelog v2:
- Add a comment that errors are now propagated to the caller (Frank)
- Make sure the error pointer is not dereferenced (Sashiko, Mark)
- Collected tags

v1: <20260915100931.3593242-1-andriy.shevchenko@linux.intel.com>

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

 drivers/gpib/fmh_gpib/fmh_gpib.c      | 10 +++++++---
 include/linux/dmaengine.h             |  9 ---------
 sound/soc/fsl/fsl_asrc.c              |  2 +-
 sound/soc/fsl/fsl_asrc_dma.c          | 19 +++++++++++--------
 sound/soc/fsl/fsl_asrc_m2m.c          | 15 +++++++++------
 sound/soc/fsl/fsl_easrc.c             |  2 +-
 sound/soc/pxa/pxa2xx-pcm-lib.c        |  9 ++++++---
 sound/soc/soc-generic-dmaengine-pcm.c |  8 +++++---
 sound/soc/sprd/sprd-pcm-compress.c    |  9 +++++----
 sound/soc/sprd/sprd-pcm-dma.c         |  9 +++++----
 sound/soc/stm/stm32_spdifrx.c         |  2 +-
 11 files changed, 51 insertions(+), 43 deletions(-)

-- 
2.50.1


