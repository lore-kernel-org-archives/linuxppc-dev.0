Return-Path: <linuxppc-dev+bounces-24171-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E447EC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:45:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhvR2PW8z3c13;
	Tue, 14 Jul 2026 11:45:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783993506;
	cv=none; b=Sbt/Qo5z10W55pIE4FUC92KjSBEZLzi5Q8aJM5on/J6xF3tzDXEdUiln2iJ1UIMeLDeVjp2bLNeNJkEOjyzxifklJwXfGOq+Gijn0t/1V+Hx2pATfuJspzXEI6CIWOEk6QDunACYAHHVLFFn/H0t2Yb/veozUOd7wBYThT5EksrkU7fS0XeNFkL3fb5Srj9tDmsdEDlcSrTn62eKVBABvzTB7zZvzYwe7Oel5peSQDHWAg8zX/J2+9ivGhKhlMyjDggIcrpveL2H3o+7IEc9oI9UFdaFxGe35rYgBSQuifGUpi+hIqYvtF5zhtF8sMI6Cv+dhmt7iF/JIUmNrS1PEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783993506; c=relaxed/relaxed;
	bh=UPVlbpyK7pCvn9FniuWKtZdUWJg+hYJv1PxfFdkhpfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z89O7m6+xpzEaWDkzvhjEDCz3Q3bwLBsHXyTqUALESrxdWIIA/9u2JTq62TfLmYSgVwj5wOv2hmzrwXTbN0cop6Tv2fZj4qGT2aci1Zyk+WTkdemxHfjfT5mePueOhqMRsu379tsR9CrWB6f0SEOvJ9JEE1jwyLn8J0ApLk4jmXG+hzr301AvIOwLTFPCTW3LPb6GcGT7H1ZjlLR7zmmEF5V2GWBziAr0fmS/2K+vElvbDaM/Xt6M25aVfHjfSroO8cJKSxE9atIXkQMgzvxYapM+KT8nhZamsJnd04FmpVdqCURPBGqIczXf7uCUuyGdc6rI81VerUwX08GPrFXKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kEdhg6ai; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kEdhg6ai;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhvG3x6Xz2yl0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:44:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UPVlbpyK7pCvn9FniuWKtZdUWJg+hYJv1PxfFdkhpfU=; b=kEdhg6aiPFOlfQFoSz9Weif1jT
	tFuR/sdxV3Ihrsf5Sqv5v5cTO91MamoRRArbzKAW6nk07OS6b6HJvqq2ac4spkgfaZvJiEjdJtH7A
	jeLZiAUEJ8ieit+7cRsIm2rq2r6g7GlBLzBIy5GbfclGbNLwspY6ohE59qZO9jwUkXoRFICUwy+mM
	LeHuFFw12FbDr1lkZ6a7Y8+QwQ01zh3bqMgvX1C5gjE/cIpa7cPtTeMlvhr4VbGbykaJU51nbPlT+
	zGwS9/lpC4npEcE7SOQ3eD4T1LYa6nJcwVaDPdgulFQxRMURlTEm5iIN76p0jdotDKigJK8w1sGxW
	BNC1Naog==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjSCa-0000000AgsR-209b;
	Tue, 14 Jul 2026 01:44:52 +0000
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
Subject: [PATCH 09/14] ASoC: uniphier: don't use "/**" for non-kernel-doc comment
Date: Mon, 13 Jul 2026 18:44:40 -0700
Message-ID: <20260714014445.569992-10-rdunlap@infradead.org>
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

Use a C-style "/*" comment to avoid multiple kernel-doc warnings:

Warning: ../sound/soc/uniphier/aio.h:159 Cannot find identifier on line:
 * 'SoftWare MAPping' setting of UniPhier AIO registers.
Warning: ../sound/soc/uniphier/aio.h:160 Cannot find identifier on line: *
Warning: ../sound/soc/uniphier/aio.h:161 This comment starts with '/**', but isn't a kernel-doc comment.
 * We have to setup 'virtual' register maps to access 'real' registers of AIO.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>

 sound/soc/uniphier/aio.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linext-2026-0710.orig/sound/soc/uniphier/aio.h
+++ linext-2026-0710/sound/soc/uniphier/aio.h
@@ -156,7 +156,7 @@ struct uniphier_aio_selector {
 	int hw;
 };
 
-/**
+/*
  * 'SoftWare MAPping' setting of UniPhier AIO registers.
  *
  * We have to setup 'virtual' register maps to access 'real' registers of AIO.

