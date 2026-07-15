Return-Path: <linuxppc-dev+bounces-24276-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D05FC4450B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:05:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfD407Mz303X;
	Wed, 15 Jul 2026 10:05:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073940;
	cv=none; b=Tasb7ileBtqxilh+Eu8GAFcdowYQ7uwmcIXoPOkNEZI7/DsmQkqH2daWqQ9u7tuamt9cWdn0N5n3g9tHfia3lCn7byb/p9A6nC7X7EZZFA680/ZTmmze3N90508pVqS2yasXcjkBoLj23ZRHomH9Z+ab234rApo39kV+C8kfFeP5MV/mX+Bn77BuXGa0QrcvTps+P/sGHflEh4pW8Ptt/C53O2aDX0PmtTWP/KoTR5/6xAHLuOnfCpxAGAJmQIIDu9o2SjoTjIo6s7YEwkIjTqt00kcgxuK5EJyMLfM4Ih8Div13Zjt5XFFiDNb+f6P6khdD0jIh0rVvw88U+8AOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073940; c=relaxed/relaxed;
	bh=G+ICPr4j5N29bqgssjH6/kLVysBy2Z2WmiFI+/aQQHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIuTqUVrXRC1RKleA+F0y/oxwZPapLO+u8pCJ+TWpKYY6S/fBS1m4l5z8sJwiK23tOIeRWiSVUKY437nrKEjO/TViUxBRWGiSBVvUs7tul7EjQ0fImbD9OUV5neXrjDmWObP39gZzSDrNCSJnVGcJfrrWcMWxQNEoQHMteXRfZ11bU4RSG7kr/2YjMFFY7mObe3rVjdIDic42e5IBmNll94kE7d9+7D321GZxRKovpErZBEX5mVwztBRIpUVYZ8YQ7pkABvJBA1+t6FBaHAbnMHReyciNfwBLtEuj9U+vV6vSSp5gMbPwFdem4zlQRkjrywcNlUPC4x6ri3Kdz7mPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T0CUoKFP; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T0CUoKFP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfB3JYMz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=G+ICPr4j5N29bqgssjH6/kLVysBy2Z2WmiFI+/aQQHg=; b=T0CUoKFPmf9OVYNj4ZoWHojS2u
	z4Gwx70W/kY+Hr1XC3YRzifUDHCih/fhoTwNy6/TpckrZWQW2RMcSu4g9QYujWZY3czHi5SXLs2yv
	dkL9nB2kEPr2UoFbLyL3tvpLIpCQbtuGJZuR85aCsKXNndfBGx0JMWBiMwHOLQs+kBrK8Hrr7i14c
	EYKoT9Lg0uvo8pwqqL7c0IuyK2cIK6iHNWJdofGjhaDwo8h7QMTaLTy5qWxLe7lazjVkr4BqQV4lf
	mApc2S+FMlWkVUmLma9nuRubnFTSz7/tOrHT7FYl1RjBM8yxAlxjITdrqwIl0vsAidsGp3HKL7v+W
	IuU66hOA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn7y-0000000DTcu-1XYG;
	Wed, 15 Jul 2026 00:05:30 +0000
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
Subject: [PATCH 04/14 v2] ASoC: fsl-dma: fix all kernel-doc warnings
Date: Tue, 14 Jul 2026 17:05:15 -0700
Message-ID: <20260715000525.739874-5-rdunlap@infradead.org>
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

Don't use "/**" for non-kernel-doc comments to avoid kernel-doc warnings:

Warning: ../sound/soc/fsl/fsl_dma.h:95 This comment starts with '/**', but isn't a kernel-doc comment.
 *  List Descriptor for extended chaining mode DMA operations.
Warning: ../sound/soc/fsl/fsl_dma.h:110 This comment starts with '/**', but isn't a kernel-doc comment.
 *  Link Descriptor for basic and extended chaining mode DMA operations.

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

