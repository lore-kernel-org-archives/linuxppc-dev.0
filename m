Return-Path: <linuxppc-dev+bounces-24283-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0CBC4450B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:06:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfL43c1z3c2L;
	Wed, 15 Jul 2026 10:05:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073946;
	cv=none; b=etD7WEg4K8pmx0V1URAeX6IB2HjltRG96vJw8YjeQH9pZKtJTht1sq9ST1D2b+8ZT0MsfUdmwRhw+KzW7TpGYj/PgPDH8QXO1G61QU1wvtxOCtwGVMvRXusY05YZCuNbTPvyTpz86KIss2KcClQMBNpeYsi7R2l+D9Yd8eCUH4RLn3s2UPXLhGLVylBvpGeNdvQwndV9hP6HFvZ8L4r0Qo8m3G76FX3SSYYmohUTYVfq7RHDHwjlxi10unmPUJ72wc2tWdpAkgLFNRwLjULuF19hjzAkZpU4LwlO0/WB+Lg85pen/PPb0XcOR4PkRJXrRGzH33r4ejdlNxSvINp8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073946; c=relaxed/relaxed;
	bh=7hW3M2QpgKenNW5fwTkZzoAIUk07IxCTC40ZiH/i8oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nf/3rHN31dDdljMJnRXAg5P+P6OEl3qxJUdhUYdLVaPtb295XXGVQ6dLBdUaa0YtKSHM1RFeUBU67sRPO02N91/YvXhIi6VfURg3K4H+oeMtsiA/hF5/IlPiNCJfFUlQmQW0zUabeKyUPqIRUisepB4e4c9Kp1gkd8SR/IkAMVAQaSCl1w8NPh9sIaexHtDeswJ1WEAFu+MeRFQlXjvbf1gUq5Ga81TNhjYkbLHCyUTGuXcM8YXgck+plnAzQRy8forYcg/YDG5F38xerdVjw9f8g27tuvtqcs+OUduYLXQ71lZ0ZlI01I98A+BRGwd1dfrn5/VlDXvywqskQxnXOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WU8HVTkn; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WU8HVTkn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfC6xsxz303B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7hW3M2QpgKenNW5fwTkZzoAIUk07IxCTC40ZiH/i8oM=; b=WU8HVTknn80YMCVD5fR5pB9pQ4
	DweV8LRwXGFDnTWFHfG3kl1cHwzt1QCQJllxiNG6KDH74mhoALqWCbDPY57ysNQAOtgvHGfFcmWwV
	uMTdwj4YnKk4BQAAdsx6trlI3fI4CXDy7FznyPDo8f2TpS1L25sN2Wo8zljWL6DHEZQUBjcmft1RV
	Z9lEaI26SOaEp+y0hYyMoapx1ccBouQhMzP30BPQDF7rO9KUT3y9yXgvUsHbuOUMFH9OCx4L8Yfkp
	SZds/3GInZkXoznc/ULZ2gCJQDcOVEdRM1MF9pbKs6SNV4rt1ZnYtbbz809KjNKg5jPWjNTUMbMIL
	bx+MHOgA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn81-0000000DTcu-1K4S;
	Wed, 15 Jul 2026 00:05:33 +0000
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
Subject: [PATCH 09/14 v2] ASoC: uniphier: don't use "/**" for non-kernel-doc comment
Date: Tue, 14 Jul 2026 17:05:20 -0700
Message-ID: <20260715000525.739874-10-rdunlap@infradead.org>
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

Use a C-style "/*" comment to avoid multiple kernel-doc warnings:

Warning: ../sound/soc/uniphier/aio.h:159 Cannot find identifier on line:
 * 'SoftWare MAPping' setting of UniPhier AIO registers.
Warning: ../sound/soc/uniphier/aio.h:160 Cannot find identifier on line: *
Warning: ../sound/soc/uniphier/aio.h:161 This comment starts with '/**', but isn't a kernel-doc comment.
 * We have to setup 'virtual' register maps to access 'real' registers of AIO.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: no change

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org

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

