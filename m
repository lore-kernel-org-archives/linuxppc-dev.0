Return-Path: <linuxppc-dev+bounces-24170-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB0BC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:45:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvP3qsYz3bx1;
	Tue, 14 Jul 2026 11:45:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993505;
	cv=none; b=PMW/3G1Isu7ycRFDmDgPc3KGckK6Jj00QDfeUAFJ4zo8+pwlaaYxZHI33CLomKu9H1RiGjTFiIj5GkeXQKAZMyp83Cqt/aEiwoPGMI1+oQEPpRZrcmKr+7X+5s41raWD1Jb7FwQFfrLausx0lIjwhsT+wJW0sl8hYHPf0JPVxi0LucQJWEhXDDfMWiSfElwOdH7q19IcIGC0ut3b71/uFeU0yAZGpiMKjygAEhUlz/bfvTIj4TDIcte8y1FUNqOeIUyyIZqV2I+KRgr3gV09kyxUB9ttyLczQzJ0s0fJzuz9WR5NvHmEB6vQxyhJB2fUQa89nSnihHu+BFeHohwlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993505; c=relaxed/relaxed;
	bh=vnfsYfktu5U5dXFqu4+zHIXwtmVyfE56yQqIND2vx9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLA8ebiTTl7Pm2EqTC2jUQngAiqnTCvVDUn8GaELWfJLQS4yfopemB7Dlfgo/EolX427nUSkSEIpp7m1uxLZvgxtZUopCrCp+R1Fwb8TN80Gh5U3EPgAMmgJeW1DLZCI2Y7tvwoVmpTMTAcPjt7K1RMmqMNZ1p2VR0lXEsLLbUfocOP4SVYCOdkq8egi0hf1J1Z4mQA2/P9XoSXk3/Leq99OTlQeTzsd1oj0IvN+DzeKRo+O1of14OHDjb6DnPgQq7ovOi0OdHCJGUjuVPhLLGP5hl3U9aJpBrahBswtouPyAnEAPStMRIQhiQmiG60ajkfYm2xqUd03Hr1nQfd73Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NhEpc/OX; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NhEpc/OX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvB5RH3z2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:44:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vnfsYfktu5U5dXFqu4+zHIXwtmVyfE56yQqIND2vx9A=; b=NhEpc/OXBnVTiaG6aq9cgKgQH7
	hQGD4GwkZohSHaeAQoKkVTwm0++E6a81Z6VKtJFaP0hjJ0BKhlAoGG4YeDCLNLLJa7CeLL8CBvSmb
	ZK6GJBCk2sbqtu/WliRu86KNn8fAL4olrntazUBuZCmAMDIEkJiNN0M1vX5SwoL7cUPCE2tCJWCjr
	krLfX/xyRJBM4x8yduerKNK6CxRVpdlmEp4yrhborp/yc+/SWw4PTr3J2rRF0mdpOqEgrx1adGvs6
	gCK74LJ2b0uSyGE7VpBtfAsVeds2DxDCgwDT7UxjqzN/1jGmpXBkFiqvypQSP6yBFanvhhv3HqGW1
	2Hc0nfcA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCX-0000000AgsR-2GAy;
	Tue, 14 Jul 2026 01:44:49 +0000
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
Subject: [PATCH 04/14] ASoC: fsl-dma: fix all kernel-doc warnings
Date: Mon, 13 Jul 2026 18:44:35 -0700
Message-ID: <20260714014445.569992-5-rdunlap@infradead.org>
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

Don't use "/**" for non-kernel-doc comments to avoid kernel-doc warnings:

Warning: ../sound/soc/fsl/fsl_dma.h:95 This comment starts with '/**', but isn't a kernel-doc comment.
 *  List Descriptor for extended chaining mode DMA operations.
Warning: ../sound/soc/fsl/fsl_dma.h:110 This comment starts with '/**', but isn't a kernel-doc comment.
 *  Link Descriptor for basic and extended chaining mode DMA operations.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org

 sound/soc/fsl/fsl_dma.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linext-2026-0710.orig/sound/soc/fsl/fsl_dma.h
+++ linext-2026-0710/sound/soc/fsl/fsl_dma.h
@@ -92,7 +92,7 @@ static inline u32 CCSR_DMA_ECLNDAR_ADDR(
 #define CCSR_DMA_ATR_SNOOP      	0x00050000
 #define CCSR_DMA_ATR_ESAD_MASK  	0x0000000F
 
-/**
+/*
  *  List Descriptor for extended chaining mode DMA operations.
  *
  *  The CLSDAR register points to the first (in a linked-list) List
@@ -107,7 +107,7 @@ struct fsl_dma_list_descriptor {
 	u8 res[8];      	/* Reserved */
 } __attribute__ ((aligned(32), packed));
 
-/**
+/*
  *  Link Descriptor for basic and extended chaining mode DMA operations.
  *
  *  A Link Descriptor points to a single DMA buffer.  Each link descriptor

