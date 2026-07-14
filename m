Return-Path: <linuxppc-dev+bounces-24163-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3074DC44501
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:45:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvH6YYJz2yrQ;
	Tue, 14 Jul 2026 11:44:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993499;
	cv=none; b=iAre8M2zYsitPrpxKI+mV9U85iAafB6fi/YSX8X3g0dvBIdh1eOrHPaaunLD0hsFdM68OrZVZ2oJjvCONEd+rZ7XVK5iVR2Hh+mfze13M0Kjj6bXydgMe8IxjKS06Fpt72M8TAn7a/+iVWAb2uFPK4x0KBTgQ/ZdB8Jwp29VFOow44qW1BKAlUJ/wkqW7nxQ4d4emx4gq9StTjmf0JnK6wP/VtVEbLJpLvsIAA1+zuOaEWda59hKHSqW/44Q5oEE7RbMzcOnLXc5mlCFCNQeIu8TYVFFLa7/1T4DqLQUTq8PAd9Z8ZO4XFBjcU3ULr61OfFqymiQPtaT0yFIXKzwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993499; c=relaxed/relaxed;
	bh=n6ptzdNiKxIt/9IdKIh/JryAO0MOA128SHJPdsO4CPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrEvW8UvSz51NjAO90dHeQqHS8zLWvHftJJKKKbLAFMeIiaBvYAN5TntEhr2Q81vA2bGe4HWntfxmpGQqB2k/m3ksHLPE5IeHoWtEy7wGDH2/gDLsBJX7NhxExX4bQANZh/w2h5z8Wtkj+KOufnDNrOyrc6DuHNENPSYK7+FIm1DdoLUVeKLN1oEY+dwrJHzfpeMbRokFnTYS2lVw4RhudISVVbu2blZ+i8Mv/oSshp2SZIsuPyTTDaMVypss0HzdF5/58cBpgfi4APeYTIoTwKuJ7O0BIg4vHdWZzWN4atNHIUEw0ETICPWIs4yQwuI1d/QfQfZUaDc6qSVMbprzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RA7NNrOY; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RA7NNrOY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvB5CpLz2ybK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:44:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=n6ptzdNiKxIt/9IdKIh/JryAO0MOA128SHJPdsO4CPs=; b=RA7NNrOY8nEVwexeyZnwKVsUoj
	LVdscNYA5L+RFhpCNzXDdHWyHiFAThgYvPIFHnKt+Btcykpnneq/J3Tj50Ffqh5aYyej4ootfksj9
	2mGaWvs+172r+QotM4dVUQWtM2dPPDNr+JSiqIv1k+gxEnULmePZ+xt6PVtfXwi6PB4d/DydcmSMS
	DbGMVNbHVkf9j2J4Q+wTqlfBBxfLSVhZ2LF9zRRKOg9MPyIcF5DIVsLU71I1iPQMnkUJzcsAR531V
	J6NK9j2Xq6zp87x+AjkG4tK1C+DR8yw+iSHt2vnDdf8ng93d/ahnj65EshbCBP/n2yibtSd6YgBcj
	ZA2sWFxg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCW-0000000AgsR-1j8c;
	Tue, 14 Jul 2026 01:44:48 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-sound@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
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
	linux-arm-msm@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 02/14] ASoC: fsl_asrc_common: fix all kernel-doc warnings
Date: Mon, 13 Jul 2026 18:44:33 -0700
Message-ID: <20260714014445.569992-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714014445.569992-1-rdunlap@infradead.org>
References: <20260714014445.569992-1-rdunlap@infradead.org>
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
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
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

