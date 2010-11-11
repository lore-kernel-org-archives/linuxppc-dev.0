Return-Path: <R58472@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B517EB7126
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 22:26:17 +1100 (EST)
Received: from mail127-va3 (localhost.localdomain [127.0.0.1])	by
	mail127-va3-R.bigfish.com (Postfix) with ESMTP id 9ACD8F58463	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 11:26:11 +0000 (UTC)
Received: from VA3EHSMHS009.bigfish.com (unknown [10.7.14.241])	by
	mail127-va3.bigfish.com (Postfix) with ESMTP id 72A0F1C2004E	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 11:26:11 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oABBQ3fE022417	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 04:26:03 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oABBhIvb025657	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 05:43:19 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: <dan.j.williams@intel.com>
Subject: [PATCH v2] fsldma: add support to 36-bit physical address
Date: Thu, 11 Nov 2010 20:16:29 +0800
Message-ID: <1289477789-10651-1-git-send-email-leoli@freescale.com>
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

Expand the dma_mask of fsldma device to 36-bit, indicating that the
DMA engine can deal with 36-bit physical address and does not need
the SWIOTLB to create bounce buffer for it when doing dma_map_*().

Signed-off-by: Li Yang <leoli@freescale.com>
---
Add more detailed commit message

 drivers/dma/fsldma.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index cea08be..8c79b37 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1,7 +1,7 @@
 /*
  * Freescale MPC85xx, MPC83xx DMA Engine support
  *
- * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (C) 2007-2010 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author:
  *   Zhang Wei <wei.zhang@freescale.com>, Jul 2007
@@ -1338,6 +1338,8 @@ static int __devinit fsldma_of_probe(struct platform_device *op,
 	fdev->common.device_control = fsl_dma_device_control;
 	fdev->common.dev = &op->dev;
 
+	dma_set_mask(&(op->dev), DMA_BIT_MASK(36));
+
 	dev_set_drvdata(&op->dev, fdev);
 
 	/*
-- 
1.6.6-rc1.GIT
