Return-Path: <linuxppc-dev+bounces-22369-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4264CD8CAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 22:21:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZjyn2glzz2ySS;
	Wed, 10 Jun 2026 08:20:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781043617;
	cv=none; b=gCXtNu1kbHANuQhDw/uKstsfR5wJy7RIx1B9sp2Kh2ag3D4wR/Ylpqf9DnXfb8+964aTt8qNcyTnkJ67/2g+LchdramdiPZFa+sCGume7dE89Y6HXwYt/srQJpuMTlou26fmtPhwI/hX7rVQ7LBF4VTVxGXj89ybAhZEFx3UbapXWKGexXVupOR/ED8xfJN97J/tacvmyQ1xC2yemvDy3C0lnOTefKa2fdcL1Qe8Y1GKB1NzCaCWo+zk60x5P922ydvuFP6FvmjZq/FtSrsTtgDRmnWpJFSrTsDULDRJF1biVJO7eqKUcUDyNRbzigdMXI3qSwwDeLPETU4OlAeFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781043617; c=relaxed/relaxed;
	bh=7abx5gUeKQ1VRxaWBSzbzTorD8zfPoqeElZR6g6xg44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcpm0R2GUHHdJ/MoMi9cqNyY3NU2thO2lRyiS8rfZ+ASIWqGQKPomHXkmTB38rJ+OdStgA4Vq7OIXH0BVqfcpBqEIzkdGOOx3nQwomUJOvnpXVHxRfiSMfZVoLWLUCKe5zsChwd7Qqr4ZygvgglSURESos5zTn7mkPxelom5PCU4QQXhnoOG3IpRI/Qr8E1MpBLAY4D9zrielvSyrXgXPXhsw+t9EOOVu70Y3qWQtnyA5Dsd8btpH9qHNXeDYbaYwhEjQvB1+zNG7B0NjVqXkpkx+3rE71U+uoBzaEEJQyUwxaxGvdEgOsjLgcE4DvBveHi+HXzh7S4gdTEuDBpyHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dGVvj7UD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dGVvj7UD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZjym5NXkz3cB1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:20:16 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so3977761a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 15:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043614; x=1781648414; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7abx5gUeKQ1VRxaWBSzbzTorD8zfPoqeElZR6g6xg44=;
        b=dGVvj7UDVTb3whl8INUdO7Y/9OxaPqytwnIHVOvXl8CUOF9OdWZ8cx6IwO8cI5fc7I
         g23Bpv8IgEid05BABmbR6R0qHYixcbgYFH9eN7iA/wnO88hA4GTrVs+ApL5ShI96JWJi
         xydKoHREf/ACSCFMt9yNNRCrD2BefpgkSYCUhpQiDTduMLaXMbZN7m3wXbr/c6U/6iK8
         3UyRC0XCOHFzNAowpuF97S+FydKyLuFWEn3G2bpOd7r5+RJsPGEFFtchBqA3PHOgTZZ4
         ECq4aOcW+v7a34dFEE4SOnsqvTmIJEabr8W2u8Wsyw15YDvzBAQCWmAthih2uhBAni1H
         ABCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043614; x=1781648414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7abx5gUeKQ1VRxaWBSzbzTorD8zfPoqeElZR6g6xg44=;
        b=axE/tCvQAdw9/fg/EXOdjEwFGGB0idO+e8y1bOFTYoggoodaoox+0ahejhCMTu3jqs
         1gmD44o1Qm/rOtD4Qe1dy4LSgmDInQXlmKODGxLOc7GT4lkOwktPe7bteVVr3x47oUUZ
         StYoWJWMXwFv5J4thqSS4WVLm4L0eL6rpOY8xtGAYdA/0VjSqJZ/cJ65gZ/5qUi43WER
         nkqpEApoACyR7jGnOnjn+BkybYGezTeQU55OpMNpV2RRtu2Ezq/VXXtsqb5MmOqsO1Ng
         lkgV9PijR0d5rPGfEUdMDntPLYJwLqsxUIANAF+zZGhHOtzohxY4BIktx4QQDM2ej7mN
         Gdog==
X-Forwarded-Encrypted: i=1; AFNElJ+eF1ZVgpVKcfJcmlV+WayvNM3jJUT/y2kaEuxd910460ug/ZMcmKnKJE2CA4yBeIakayj4lv68cYxH2F8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzteOdZ0sGVVILPuQ9MOdHIwtw2mQKkdyUYK1dQiIfuHitKRJ8v
	PnjM4T33R0tzr2tThxFWEr54D89WpTbzcfOSMvpXM1N7SKpeOqMLxNEg
X-Gm-Gg: Acq92OGc5pBz3TPLQHcK0r/HU1M8lTkqmhau+KaMbN2jFZIkRlwfdkLJyoWkv3vZI1/
	hPMaMVUUqZKABoA1VRz28jU+kHSlJu2Je+v471a7lPfb8fa++m1qzZTkalHbft4UQUdNB5XK0oT
	OPD0dkQqUunPNy79DDYa8Ddeq7oNLdaytOjLRdOnhKskMIwP/fWSs93FysBqK0WbP1arkvsz4ko
	uQ+6n1/ckyg1lAq5zgQ41XlYR2OGW/JBl2ZYwfM06RVJZnVXaY23F+LmmzYr4DSqk+9lDO3kdvc
	D2AbqBl1WrtoTdJgULQr06RuqBq+iH4bHvqdoLMiaegerdqutNmuhCI+0DQPsL7CuglanJfIwLw
	qJN2aPy+QiNTLWvqcX8ZyQavnRnSQLBRPjdG2QpLj+Vr77j+PCuEfozvnIo+tgeeOaJyLG5iMu3
	evJvmaFqvHtS2ms6btHh7uxAcDkNIhA+k1NFklJvfeBNj60Ytf8r21npjplvNmsvS3rKA1y5IHH
	q2V2mvkcrs+7zkFRYu0VoYhuAbbMPwpP8D6MPagsXVAPZqJimbPD8HS
X-Received: by 2002:a17:90b:5204:b0:36d:df4f:ab2 with SMTP id 98e67ed59e1d1-370f0772dd1mr26545593a91.13.1781043614688;
        Tue, 09 Jun 2026 15:20:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv3 15/15] dmaengine: fsldma: fix kernel-doc param names to match function signatures
Date: Tue,  9 Jun 2026 15:19:26 -0700
Message-ID: <20260609221926.35538-16-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609221926.35538-1-rosenp@gmail.com>
References: <20260609221926.35538-1-rosenp@gmail.com>
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

These are pre-existing mismatches that predate the recent
devm conversion series.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index d4c9b81ade0d..c0dbcd09999e 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -685,7 +685,7 @@ static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
 
 /**
  * fsl_dma_alloc_chan_resources - Allocate resources for DMA channel.
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
  *
  * This function will create a dma pool for descriptor allocation.
  *
@@ -742,7 +742,7 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
 
 /**
  * fsl_dma_free_chan_resources - Free all resources of the channel.
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
  */
 static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
 {
@@ -878,7 +878,7 @@ static int fsl_dma_device_config(struct dma_chan *dchan,
 
 /**
  * fsl_dma_memcpy_issue_pending - Issue the DMA start command
- * @chan : Freescale DMA channel
+ * @dchan : Freescale DMA channel
  */
 static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
 {
@@ -891,7 +891,9 @@ static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
 
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
2.54.0


