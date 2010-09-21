Return-Path: <R58472@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 4DAECB6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 20:13:07 +1000 (EST)
Received: from mail33-tx2 (localhost.localdomain [127.0.0.1])	by
	mail33-tx2-R.bigfish.com (Postfix) with ESMTP id 09A3411F0564	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 10:12:55 +0000 (UTC)
Received: from TX2EHSMHS031.bigfish.com (unknown [10.9.14.244])	by
	mail33-tx2.bigfish.com (Postfix) with ESMTP id 162341890065	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 10:12:38 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8LACa1S019415	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 03:12:36 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8LARw54004664	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 05:27:59 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: dan.j.williams@intel.com
Subject: [PATCH] fsldma: add support to 36-bit physical address
Date: Tue, 21 Sep 2010 18:57:18 +0800
Message-ID: <1285066638-7473-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/dma/fsldma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index cea08be..9163552 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1,7 +1,7 @@
 /*
  * Freescale MPC85xx, MPC83xx DMA Engine support
  *
- * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (C) 2007-2009 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author:
  *   Zhang Wei <wei.zhang@freescale.com>, Jul 2007
@@ -1338,6 +1338,7 @@ static int __devinit fsldma_of_probe(struct platform_device *op,
 	fdev->common.device_control = fsl_dma_device_control;
 	fdev->common.dev = &op->dev;
 
+	dma_set_mask(&op->dev, DMA_BIT_MASK(36));
 	dev_set_drvdata(&op->dev, fdev);
 
 	/*
-- 
1.6.6-rc1.GIT
