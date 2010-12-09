Return-Path: <leoli@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1828B6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 18:20:30 +1100 (EST)
Received: from mail98-tx2 (localhost.localdomain [127.0.0.1])	by
	mail98-tx2-R.bigfish.com (Postfix) with ESMTP id A52E014D01BB	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Dec 2010 07:20:25 +0000 (UTC)
Received: from TX2EHSMHS039.bigfish.com (unknown [10.9.14.245])	by
	mail98-tx2.bigfish.com (Postfix) with ESMTP id 6CDC91630058	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Dec 2010 07:20:25 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id oB97KNtX003405	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 9 Dec 2010 00:20:23 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net ([10.192.129.221])	by
	az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	oB97KMTG005293	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 9 Dec 2010 01:20:23 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: <dan.j.williams@intel.com>
Subject: [PATCH] fsldma: fix issue of slow dma
Date: Thu, 9 Dec 2010 16:14:04 +0800
Message-ID: <1291882444-1523-1-git-send-email-leoli@freescale.com>
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

From: Forrest Shi <b29237@freescale.com>

Fixed fsl dma slow issue by initializing dma mode register with
bandwidth control. It boosts dma performance and should works
with 85xx board.

Signed-off-by: Forrest Shi <b29237@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/dma/fsldma.c |    6 ++++--
 drivers/dma/fsldma.h |    9 ++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 286c3ac..e5e172d 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -50,9 +50,11 @@ static void dma_init(struct fsldma_chan *chan)
 		 * EIE - Error interrupt enable
 		 * EOSIE - End of segments interrupt enable (basic mode)
 		 * EOLNIE - End of links interrupt enable
+		 * BWC - Bandwidth sharing among channels
 		 */
-		DMA_OUT(chan, &chan->regs->mr, FSL_DMA_MR_EIE
-				| FSL_DMA_MR_EOLNIE | FSL_DMA_MR_EOSIE, 32);
+		DMA_OUT(chan, &chan->regs->mr, FSL_DMA_MR_BWC
+				| FSL_DMA_MR_EIE | FSL_DMA_MR_EOLNIE
+				| FSL_DMA_MR_EOSIE, 32);
 		break;
 	case FSL_DMA_IP_83XX:
 		/* Set the channel to below modes:
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index cb4d6ff..ba9f403 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (C) 2007-2010 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author:
  *   Zhang Wei <wei.zhang@freescale.com>, Jul 2007
@@ -36,6 +36,13 @@
 #define FSL_DMA_MR_DAHE		0x00002000
 #define FSL_DMA_MR_SAHE		0x00001000
 
+/*
+ * Bandwidth/pause control determines how many bytes a given
+ * channel is allowed to transfer before the DMA engine pauses
+ * the current channel and switches to the next channel
+ */
+#define FSL_DMA_MR_BWC         0x08000000
+
 /* Special MR definition for MPC8349 */
 #define FSL_DMA_MR_EOTIE	0x00000080
 #define FSL_DMA_MR_PRC_RM	0x00000800
-- 
1.6.6-rc1.GIT
