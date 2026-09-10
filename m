Return-Path: <linuxppc-dev+bounces-27042-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DCDC88E41
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 20:25:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgq0s3b8Zz2yrD;
	Fri, 11 Sep 2026 06:25:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::833"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789071901;
	cv=none; b=bHsnBIslCiVUtUwWzJN7ca/ZFfmeH7RmSYmhklbfFgfl/XU/eb9afprtgHyJ8oTpWJmRjck6zXRC20/MoOldSt/Su1MnxW6rcGuBKzVF/q2hMtBc4eKes/kPgL056xEgIVOUYz66K2dtGGpJR55eSntvA99mtSnKyBc8wYAFa5Q06ApgZWhQQCSix3uvqMDuEzXGB6zpeTkCSIvV0K7bWXhrk428dr99iAdXL20swn8sWGKXny4N07E3WEwFAzgoO20Xo6U/kxYvKVKo9ZbmSTWrn3xLrc09voenWkwKC+2Ij8LyF5yNCuvDdiw8uRrF9kIDuKik+AMdr1aUk6rsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789071901; c=relaxed/relaxed;
	bh=5fAMAx/mtgGUhEgU04FWSZ/Setac6qTqsovVdgc29/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kk1MCcCjPRA445JDy9YoopzcJpjy4AMfg7rhgTFzIG/XAQgszrS0+UwrfhY9HIa+TSDa5bJ2D1l2Mue7Fq7pqrt4HWXKmAyZz3DTnOcbdmactpjyl2wvpVyhgMeOyZsW2e4H6l8+7g1+t1boUQ+xGvZa3aItvpY0nPNClBKwc1l4e8V1AfQAgZ8ZT3P+/SIbgldTa7fgVFi3EYB+FkErXz2+QCTqNsBiK4tgrWe/Ojw1y2sd4CVcoyfLvBMzBeJj2wZkFVpKDe0vZgi8v21V4vs2rRrUgF2EPJwEjY+AQXt09OBZrqSV1MRvWcid6gUSzdombPQ5azUjpOKXpTLeMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CrJWLBG+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CrJWLBG+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgq0r1w0mz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 06:24:58 +1000 (AEST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-517dc520840so2247471cf.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 13:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789071896; x=1789676696; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5fAMAx/mtgGUhEgU04FWSZ/Setac6qTqsovVdgc29/U=;
        b=CrJWLBG+3bvlEg/WDR6fh0FoL7+3GDEB20qZ+Q3V48Cq466tCUfMcPV4VwFEOsYo9R
         T1pjRotiyrtwGwGVyUdtBKU49oUCJ82TKxPuoMurzD0IiMGrxA+de3KdaQEnfI1nctEE
         ianOIXHAw9wg9E57J2Z6IhavbnqLFxpJt2VZKOlb0wJ6Ds6VDrBttyD0yvvtrbvMRATp
         7FvcUE3ENOLunCN04664E99Vin/dZCn9+daM8WlA/FJVkxkBgDhrFkv20lsBchmgDk6a
         iKZaXD7l9dlwFpaytBOcVd390qPmDfWqgpu5dQLUMzXyBn7yQpwlBxSn4pra4ZyI3PDF
         otSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071896; x=1789676696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5fAMAx/mtgGUhEgU04FWSZ/Setac6qTqsovVdgc29/U=;
        b=TUzGirf6fKqvDqanwvEEwFOw/1OohXgUPijoIj2Jk4IqRGlub6LnSnqJoU8lmGe+xF
         8i1QOELYpMDqzNOM5Kt/1oKJOIi6ZjXUsFZub9YktzgEO0D84oBJK7TLtwfuPMGJt3T3
         AcxPjgMiqKzaf+Rf//FlfHh9Mr0dt9SkpyGbb67NOHeRkOXmDBGF9Y2rXkRoHZ79J43R
         zO+R6Iapa+ZvSpVf1oWPDxzpS5gxC/+zfoVEiNHo5mwPgMnpdNxO49inWFGbG7GgNxn1
         jWBpFNpUyPd/uDrJalOH95SXN3+Ern/e4tBkf8mWysdhM9II3t+OyOs34VQufyG+hA6S
         Y3tQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8R1t26V7gWX5eArA7XZfTCEXIySheOc11gTKFEywK8Fqy7bb51zGAzvO4H+aE+xgqrgcAQ8jqUagVkzk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kXJeKNV5iGAYihbmb93YAj8IflUU2HYak7nYrSc6BvEW3y18DA
	vjr0ZuNCN6lmvNnzhs0zlwYSyAimUmXQ1k5JSOQIKfWfv9FYCRh7bQam
X-Gm-Gg: AYBFou1Ly9l9G8bS0Ro3O4ZcIwQ7EegRu3pBaxZoSsAKNzbgdl7Xb+caaDLo+JQ4Xqc
	9dnzEG4n56/pHoQr3D1SyEUfrv5w08MQ1NzUYvDGoqKxf0V+inNN2Wf7OEUtCh+TDt77EP4Bugj
	x7NnkfyqRt6h5GYW+ynJHFe2DtKoaM+21icIyAGfHjiwGkKQui8zchFXwB1UB8YJw8cSL4p072w
	z/39SCBTpH53p6DrfvqtrpFKNG4L2P8t/ENkksA8V+rBK2U53cAn9ADtdUbtwgF+hSJWifvhuUc
	Aw62JhzGqXk+E6Blf2mCQf+5qeil6AVfxNqxGnWvj603mT0gOE+mku6BLrd9VhLBkfFC4tdFjYV
	pX+WQXvupzkcV1GNvPg80Cbhnk+BA1J5ULFZxIqyg4s8jeGvvNVL7lWxewCaGj9D/BdanKVZKMD
	T/YXw3wLTc7CPtKDa5wqOKwxsFCOVC+wAzl1jsS6QP1PyAJQjtF68tBYcq5V3I9jKNqOcumncsG
	RDVh2teOleL33zSEuHByBE0H8QIDpyBod5wgbmDsLMaFaM7oBdp9Xq73t2SxrMFVeKQwdoIsnsi
	C+wdsueYQxMySFIMs+M0Zf5s617WFpprAUdHnXGiZq2UsqHwLw==
X-Received: by 2002:ac8:5a0f:0:b0:527:809c:f9cf with SMTP id d75a77b69052e-530c85979bcmr17636911cf.21.1789071896008;
        Thu, 10 Sep 2026 13:24:56 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca489107sm2035371cf.14.2026.09.10.13.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:24:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Zhang Wei <zw@zh-kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] dmaengine: fsldma: fix kernel-doc param names to match function signatures
Date: Thu, 10 Sep 2026 13:24:53 -0700
Message-ID: <20260910202453.47887-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Fix kernel-doc warnings where the documented parameter names
(@chan) no longer match the actual function signatures (@dchan),
and add the missing @cookie and @txstate parameters to
fsl_tx_status.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 v2: split up from series
 drivers/dma/fsldma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 22d62d958abd..6ce0e5668dc2 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -681,7 +681,7 @@ static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
 
 /**
  * fsl_dma_alloc_chan_resources - Allocate resources for DMA channel.
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
  *
  * This function will create a dma pool for descriptor allocation.
  *
@@ -738,7 +738,7 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
 
 /**
  * fsl_dma_free_chan_resources - Free all resources of the channel.
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
  */
 static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
 {
@@ -873,7 +873,7 @@ static int fsl_dma_device_config(struct dma_chan *dchan,
 
 /**
  * fsl_dma_memcpy_issue_pending - Issue the DMA start command
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
  */
 static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
 {
@@ -886,7 +886,9 @@ static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
 
 /**
  * fsl_tx_status - Determine the DMA status
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
+ * @cookie : DMA transaction identifier
+ * @txstate : DMA transaction state
  */
 static enum dma_status fsl_tx_status(struct dma_chan *dchan,
 					dma_cookie_t cookie,
-- 
2.55.0


