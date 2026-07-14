Return-Path: <linuxppc-dev+bounces-24177-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E860FC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:46:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvZ1Hwfz30F9;
	Tue, 14 Jul 2026 11:45:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993514;
	cv=none; b=Zoo/0ToO2L8rdNQu2LnKWFCWiGEWBtnwCxFGSb3A+vzNhSzOR+o34T2MrSPxHbzL1V6AobkoZuA5mPktxgv+q2NkxvK0aLm12qGPx+e2iH0wTe2MTWs3J2R2vR6naiy7tJP1Qz4yrGt4Cwa0xMJcqG0KI6zoEdVLiCoMlDi+rWo2shxhXPJBVRRcdmV72boRi6wFn430KdR1/oFKxaBehCSWZCQngGTN9NNgk6kYVZEZYl8lepyI3CLDeAJv5KU7jhIqIuCbBgxs6qXa+1Itu/kSwqkdaBpJLHbpkLLFiPLP7DApoKlqaunEOV50nX3cD29WXejitaWwEN9NmJe8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993514; c=relaxed/relaxed;
	bh=C2OhovbADJqYH9SjFWe+bdXuuSMpvFMRbOlHjiIHQYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILhcVTC2h8Fl8U0cc5qXDNaWtUxBNo8Hf2oAlgx/I1j5T1J0C9UHdqDEPGbUaESEAZil4Wz2QOTTVd/BSx1aAZ16uYqWIEQLhYJzfJtry3/wL6XHNiRyI3e9V1sMarabl1Jfvw+S4C1kgjR96FdFexqJSi3NHe3y2Mp8A6rnTbg5ONRlt+R90tQoVnpL4T+Lzgg0H/Q72xIerLMWeclNBreivuiYORKq81IewQZmmkZcJHw8RNFSBB4m0/DdeZHBrkktyjDnZPD9a/A0+neDyW51FAmqGGw39tYD/58hMcG+4dPNaYcB1KczUpY9HxJ7OIqSLuUAGMgCrtg8NHwOxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i/oKD2eo; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i/oKD2eo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvY1BFpz3c9b
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:44:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=C2OhovbADJqYH9SjFWe+bdXuuSMpvFMRbOlHjiIHQYE=; b=i/oKD2eokJkBPLHZYeSRVyfMCA
	C1gElCK6m9h0+HqyzwNzCF9xssaoYxSWHgXjhOq2UKaPUgefw8+CIC+vZxovYrcZ73wKb6ZNqgUKx
	ZWec8VnQ3mjTj3AznUjA1n64c4h9hl4ZsxjoyvUXU9IAnE1P8F06V8YvQAxsSNCm1JeNo5kjSWkNk
	H0MbDKY4EqsS1AnToyotbquHKUhFMTilM2rE10/em9CVXh1FG0sHUeKdVwLpksJxboJVRzdGLKrlb
	iZSB9ux538MDXL3OgH69BXa8cmyA89r4lbO8aNsbwjvw9hJdC59sr6CU/SdVJhyypXcMLyAgVTnh7
	3jXknlPg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCV-0000000AgsR-3SPs;
	Tue, 14 Jul 2026 01:44:47 +0000
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
Subject: [PATCH 01/14] ASoC: codecs: NeoFidelity: repair the kernel-doc format
Date: Mon, 13 Jul 2026 18:44:32 -0700
Message-ID: <20260714014445.569992-2-rdunlap@infradead.org>
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

Don't use "/**" for a non-kernel-doc comment.
Use kernel-doc notation to document the parameters and return value of
ntpfw_load().

Fixes these warnings:
Warning: ../sound/soc/codecs/ntpfw.h:2 This comment starts with '/**', but isn't a kernel-doc comment.
 * ntpfw.h - Firmware helper functions for Neofidelity codecs
Warning: sound/soc/codecs/ntpfw.h:20 function parameter 'i2c' not described in 'ntpfw_load'
Warning: sound/soc/codecs/ntpfw.h:20 function parameter 'name' not described in 'ntpfw_load'
Warning: sound/soc/codecs/ntpfw.h:20 function parameter 'magic' not described in 'ntpfw_load'
Warning: sound/soc/codecs/ntpfw.h:20 No description found for return value of 'ntpfw_load'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>

 sound/soc/codecs/ntpfw.h |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- linext-2026-0710.orig/sound/soc/codecs/ntpfw.h
+++ linext-2026-0710/sound/soc/codecs/ntpfw.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * ntpfw.h - Firmware helper functions for Neofidelity codecs
  *
  * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
@@ -13,10 +13,11 @@
 /**
  * ntpfw_load - load firmware to amplifier over i2c interface.
  *
- * @i2c		Pointer to amplifier's I2C client.
- * @name	Firmware file name.
- * @magic	Magic number to validate firmware.
- * @return	0 or error code upon error.
+ * @i2c:	Pointer to amplifier's I2C client.
+ * @name:	Firmware file name.
+ * @magic:	Magic number to validate firmware.
+ *
+ * Returns:	0 or error code upon error.
  */
 int ntpfw_load(struct i2c_client *i2c, const char *name, const u32 magic);
 

