Return-Path: <linuxppc-dev+bounces-24277-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773A7C44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:05:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfF3zh3z309r;
	Wed, 15 Jul 2026 10:05:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073941;
	cv=none; b=AzEkeceIZmj1ByzzpJoNQT+oi/qJGCW6ZSE4qeS1VIv8fmF+MNcUuJqeatxNjskx72uAz7wa8qb2LaXFPH68H4FTXVXYgiKoXFrAHIam4sia691dnYmJr3ffJGEqy0XmgeZFSlkmKzkQ3j5lbadXiomouzdHtwT/54g/Gc6ejjmE6rgSUliEI69A8CgDuxKQOAxnRBkjCJ4HYrLFd014VLznJPvzWedMCfg31BFBB140AeeX+fm2QZTzUdhYoOhguOdpzwt0Joi46/pAvzMhWjmqa9KaREy3ALc7x0fDZz/qOIKkrksLfbEPqcP93Updlz9WiMPr5THv1ApJQ2wNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073941; c=relaxed/relaxed;
	bh=whUJBq9j7Gjt4+AHK6WYV+GQWugxRvRw0PxjhsMjkDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKeiVQ7/7RZ82qZaiYeRGN0w8Bin9tJJddbtl7oBlQvHLn69J8Vi90g3a1sQxv6IKO0tlZaF/NQSJnDQ5dlXn5IS9Get/QrcklCNuRx5aaedimoaFxTFkoEbJPWevqyH/kgPSQj8et7itSeGjoNd+Mh6GqFiOmWapNtiRsCuhiycRKsLUnJ3Cb8RohB4Etq2TuAZUfkm0PCPVwte2rDXc7GHaVSI1bS3+bzFJW379OVs9kYkUPhtiiEhGs72gjyCPEBaV7vdt+O+1yZ9oqCSHnRMd/PkPpGlqURKwPRei6daYyP28r324VvG46gclCGuGwGpO+IfEKTbsd5VgKnf1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A8d0NQ+F; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A8d0NQ+F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfB4XkDz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=whUJBq9j7Gjt4+AHK6WYV+GQWugxRvRw0PxjhsMjkDE=; b=A8d0NQ+FTZXw7OoJA2+XIB1Hkn
	+RlrilZKqSNHdalqtsNGkPjs9/c0Tm2w9bXHd2Q76r2Hk4zwFSuc7kw+LKLBgDcdy23yIjZP7GaB7
	1LNE4RIiSdzU7psxeFqilDGB93VzJrYax6oEz7Eexo18fzv08lmcu+bgZV+XZXwftyLBT/5M8DmAn
	YfpIS0+69viuum399syVOGg/adjeRcKnP+FlMGNdYPnol2DInd1FoZJNYR7V70cCcrkaAiqIjpKWS
	3tp4EiKziVDcF7CC3LpIF5WzO6L3uyxBLnd+JLHyFwapMn5InV7T4OO+f3pSwqGD64XQBBg5P9V0z
	5OEasVjw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn7w-0000000DTcu-2ZXa;
	Wed, 15 Jul 2026 00:05:28 +0000
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
Subject: [PATCH 01/14 v2] ASoC: codecs: NeoFidelity: repair the kernel-doc format
Date: Tue, 14 Jul 2026 17:05:12 -0700
Message-ID: <20260715000525.739874-2-rdunlap@infradead.org>
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
v2: no change

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org

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
 

