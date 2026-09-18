Return-Path: <linuxppc-dev+bounces-27730-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A9FC982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:37:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmVwn4jkHz30Lw;
	Fri, 18 Sep 2026 21:37:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789731465;
	cv=none; b=hOcZhEBgJEG1H/gRVCuiNcq+tNOSLhAWB5BvvsMneckUzREApC9Gi6ZhUZjskM09Wvvlq8W5/CXuWjC7F4EErKaO4BlCVmjeOdlF4VnwdlbF7cthJoDTZG4ZypTuO/cSahjOhxb4o6ysAQDHex7Hl8hGMSEw64eFSmCZ8TkM/yHETU2Tm42Ls/PWyiFmr5KTwR/6oXP8C8+hZx+FHmgyvzrjB7z3nxK5FjBmL6H3EWgjvX9Hbhj0x3xCrR0d7IQXUw2bzjnHzAlWLeEZgq+xhkr92CFQqM9FWQ8R3U7JyhUsEqn/EBjFTL0/KwMYZ81wq9ZISDia6G7gvoFY+0pwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789731465; c=relaxed/relaxed;
	bh=iCb774S6nPnlt27AN21fS7+AXM8jLF0u2+u/WwMLr+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M++xeYkQYijezoZ77sYz/P/k0C69b5/x6TT0rm5S+7nmFg7JI9h55s0PPbvUXVNmsyQwcQEmKg5Muar4RLBgTVNCxwCL8mdpYTFAmrK99nOO/4XWiEb/lOxbNPw9RefNpa/fT3eQIhuGDzwwMGipUg4w5W3pWzMwEzkjCeLK/XwXkKbO0By6wOSfxfFn2h50sNqeFiVHRCrv5fGBCAV2aMFP2/CPudMLeIzuiosiTF1hNaA92y02030CpgZiHdWpYsEIAdm5WQbDoMW0oq4sVxNixcTIPMNF7afxSfiStCpSKL3yqc8uwmoWrUzuR7zt4qDcmp4Tj5WUOxnenbXSTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hqhBrqHP; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hqhBrqHP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmVwm004yz2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 21:37:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789731464; x=1821267464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HBMn/5uoBJRDMKsyJnTaBaHBHzv4hmzBn/RwfpsTeuY=;
  b=hqhBrqHPZmeiePde8tDonUts+kc53SvueeQQqjOQgdR7q0eVS4LZo+QI
   Si2BG9D/95oJ2iVF2+z+YSMS38ECfHlQAot5ZOX2EtOB5RW5KUYfzZYEE
   WvNETaP58UFwiCxOXf3TNL15V4+Jn2NtsnLqWCdC4OrBhfrn/pq0uhB/C
   FZKoJjAbnbvKnY8JCXjX0OOmJAId+vr8bJfknCS/t4kLDX3P/+Sqbc0nk
   H8Tjt13F1NSLDxv7D03NZPt41shYQynROqEbw/ZBhVx1E1aP0oEsoDxLj
   2b1TrxM4Sq8Rf/04QR8ndRDPLbHwTiPA5npkRgnfwA4kzm91Qs6SzXvIU
   w==;
X-CSE-ConnectionGUID: IUIAx5iyQZ+Dnm/PDbo4Lw==
X-CSE-MsgGUID: FNxFZWaOTBWiPN0W5nWMuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="92739729"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="92739729"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 04:37:40 -0700
X-CSE-ConnectionGUID: ojMW1seUSfORwlkiKf3M8Q==
X-CSE-MsgGUID: knn7zAWeRM+3HtKgvEjlkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="271029239"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 18 Sep 2026 04:37:34 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 67EEC9E; Fri, 18 Sep 2026 13:37:29 +0200 (CEST)
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2 3/7] ASoC: soc-generic-dmaengine-pcm: Replace dma_request_slave_channel() by dma_request_chan()
Date: Fri, 18 Sep 2026 13:34:07 +0200
Message-ID: <20260918113727.1898998-4-andriy.shevchenko@linux.intel.com>
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

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 65b7ec52a054..6d1dbee8f6c1 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -242,9 +242,11 @@ static int dmaengine_pcm_new(struct snd_soc_component *component,
 		if (!substream)
 			continue;
 
-		if (!pcm->chan[i] && config->chan_names[i])
-			pcm->chan[i] = dma_request_slave_channel(dev,
-				config->chan_names[i]);
+		if (!pcm->chan[i] && config->chan_names[i]) {
+			pcm->chan[i] = dma_request_chan(dev, config->chan_names[i]);
+			if (IS_ERR(pcm->chan[i]))
+				pcm->chan[i] = NULL;
+		}
 
 		if (!pcm->chan[i] && (pcm->flags & SND_DMAENGINE_PCM_FLAG_COMPAT)) {
 			pcm->chan[i] = dmaengine_pcm_compat_request_channel(
-- 
2.50.1


