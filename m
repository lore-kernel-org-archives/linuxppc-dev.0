Return-Path: <linuxppc-dev+bounces-24286-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880E3C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:06:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfP0Cdhz3c5M;
	Wed, 15 Jul 2026 10:05:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073948;
	cv=none; b=nQ4xtdm7L0/yBc5ofDTZapEvb5n2rbT51sH686P7D0VOQi6Pzu5O8AY33pXCqiv2hiR2uwnKBlxdK2S1n71GTvxIvDiXQk4KJs6l0KPeS7dNfLpOwlmB/N/gB1B+iTcd45MB5vq+qWdosUrtxdqTQNhJ0EbzcPRbnyAv17xATq/wOeRTojrVHacUwD9qGYRCXaP1MNx+UP7T0Sb87zsDQ2EcYLqSh11Nn0PEVMhV7oUPFDGbe8lS1Hs+ywo/OkwSDUDJIh8yufYUwYh3Whd2yOyGX3no0GwmKnuvDTTypUTqPvhqszocn5IcMjQ1h+1nP8lhAjbZhyF0nNn/+l2neQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073948; c=relaxed/relaxed;
	bh=XertOOfFvpAplO/JrXsYikR9iJI/5mQbiOBJ8r5yVLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBqRQFiDJHSLn9LcAeS1ZDAfaoskeqhbsMQP3+f77FkiLHaMPZfhDDvv1+kakRsxUJv9HY3VSpPOKa5h+FkwfH0RLitaRo1LkipElanPvcRf/K+RmvrBnVNLYmxw2BiqlcDD9ck6q4wa45t9w57l7diOvzx00/YFv2XFrb2pCADW11dEhKf9Bp2uM9ySvwsOzh5s1YVzIX8sD/L0cSo6m3dXrqRN5+CnssTDvx9lfKGq7X6COnuC6WsFYgTtLSqL/ZekVxlc2V0kiFnXFgXRgb7TJv+X3OV5QtSetbRvopYw6Pax3GUcWb023X4PCdRz6GZW3I0pmKCyliyxKzzPYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BFVhVWgm; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BFVhVWgm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfL5Kmvz3c2Z
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XertOOfFvpAplO/JrXsYikR9iJI/5mQbiOBJ8r5yVLw=; b=BFVhVWgmF8Tu0/VlCpz6e4+xxR
	/z/aTnIe4M94RU3PDWGzerm3sAiS6RhmL9NR5RIB8j1ynsh4vGCQ51Gj1WwHMy5opjF6LDEfEPlU+
	EHYJeSbgntpoTAaeeUX1V8YgmwmRT4o+AykGeEF58OzX6Dmd/MKM8l/jERzY5GwpIenwKLxlt/21X
	isOStveFnQ844M08IsSVYa6CBec0u7e17AOmPMrPDf3WAh/RR4CBencwEJX9srqgpToMfBrzU0WA+
	EvjMUboiLOZ3oWkS9Zt6M+EB3z/eiN2jUJkh5gjLpJIejWS8SxMVwFhx+bC3bRwkDI7gMYs+T3V9u
	3GosD8mw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn7x-0000000DTcu-0oxX;
	Wed, 15 Jul 2026 00:05:29 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-sound@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	patches@opensource.cirrus.com,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 02/14 v2] ASoC: fsl_asrc_common: fix all kernel-doc warnings
Date: Tue, 14 Jul 2026 17:05:13 -0700
Message-ID: <20260715000525.739874-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715000525.739874-1-rdunlap@infradead.org>
References: <20260715000525.739874-1-rdunlap@infradead.org>
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

Add missing struct fields for struct fsl_asrc_m2m_cap.
Add the missing "struct" keyword on struct kernel-doc headings.

Warning: ../sound/soc/fsl/fsl_asrc_common.h:65 cannot understand function prototype: 'struct fsl_asrc_pair'
Warning: ../sound/soc/fsl/fsl_asrc_common.h:129 cannot understand function prototype: 'struct fsl_asrc'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: no change

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org

 sound/soc/fsl/fsl_asrc_common.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linext-2026-0710.orig/sound/soc/fsl/fsl_asrc_common.h
+++ linext-2026-0710/sound/soc/fsl/fsl_asrc_common.h
@@ -28,7 +28,9 @@ enum asrc_pair_index {
  * @chan_min: minimum channel number
  * @chan_max: maximum channel number
  * @rate_in: minimum rate
- * @rate_out: maximum rete
+ * @rate_in_count: number of array elements in @rate_in
+ * @rate_out: maximum rate
+ * @rate_out_count: number of array elements in @rate_out
  */
 struct fsl_asrc_m2m_cap {
 	u64 fmt_in;
@@ -42,7 +44,7 @@ struct fsl_asrc_m2m_cap {
 };
 
 /**
- * fsl_asrc_pair: ASRC Pair common data
+ * struct fsl_asrc_pair - ASRC Pair common data
  *
  * @asrc: pointer to its parent module
  * @error: error record
@@ -90,7 +92,7 @@ struct fsl_asrc_pair {
 };
 
 /**
- * fsl_asrc: ASRC common data
+ * struct fsl_asrc - ASRC common data
  *
  * @dma_params_rx: DMA parameters for receive channel
  * @dma_params_tx: DMA parameters for transmit channel

