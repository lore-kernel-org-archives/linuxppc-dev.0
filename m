Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ql96J3thwzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 13:59:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: wsa@the-dreams.de
Cc: <linuxppc-dev@ozlabs.org>, jochen@scram.de, linux-i2c@vger.kernel.org,
 <linux-kernel@vger.kernel.org>, scottwood@freescale.com
Subject: [PATCH] i2c: cpm: Fix build break due to incompatible pointer types
Date: Wed, 13 Apr 2016 13:59:14 +1000
Message-Id: <1460519954-9365-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit ea8daa7b9784 ("kbuild: Add option to turn incompatible
pointer check into error"), assignments from an incompatible pointer
types have become a hard error, eg:

  drivers/i2c/busses/i2c-cpm.c:545:91: error: passing argument 3 of
  'dma_alloc_coherent' from incompatible pointer type

Fix the build break by converting txdma & rxdma to dma_addr_t.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/i2c/busses/i2c-cpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

*** Build tested only.

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 714bdc837769..b167ab25310a 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -116,8 +116,8 @@ struct cpm_i2c {
 	cbd_t __iomem *rbase;
 	u_char *txbuf[CPM_MAXBD];
 	u_char *rxbuf[CPM_MAXBD];
-	u32 txdma[CPM_MAXBD];
-	u32 rxdma[CPM_MAXBD];
+	dma_addr_t txdma[CPM_MAXBD];
+	dma_addr_t rxdma[CPM_MAXBD];
 };
 
 static irqreturn_t cpm_i2c_interrupt(int irq, void *dev_id)
-- 
2.5.0
