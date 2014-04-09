Return-Path: <Gang.Liu@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 96FC414015F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 20:07:01 +1000 (EST)
Received: from mail207-ch1 (localhost [127.0.0.1])	by
 mail207-ch1-R.bigfish.com (Postfix) with ESMTP id 20A011206E3	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 10:06:35 +0000 (UTC)
From: Liu Gang <Gang.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <b07421@freescale.com>
Subject: [PATCH] powerpc/rmu: Fix the error memory free parameters
Date: Wed, 9 Apr 2014 18:04:45 +0800
Message-ID: <1397037885-21060-1-git-send-email-Gang.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liu Gang <Gang.Liu@freescale.com>, r61911@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are error parameters should be corrected when
calling dma_free_coherent to free rmu rx-ring buffers
in fsl_open_inb_mbox() function.

Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 arch/powerpc/sysdev/fsl_rmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
index 00e224a..b48197a 100644
--- a/arch/powerpc/sysdev/fsl_rmu.c
+++ b/arch/powerpc/sysdev/fsl_rmu.c
@@ -881,9 +881,9 @@ fsl_open_inb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entries)
 	rc = request_irq(IRQ_RIO_RX(mport), fsl_rio_rx_handler, 0,
 			 "msg_rx", (void *)mport);
 	if (rc < 0) {
-		dma_free_coherent(priv->dev, RIO_MSG_BUFFER_SIZE,
-			rmu->msg_tx_ring.virt_buffer[i],
-			rmu->msg_tx_ring.phys_buffer[i]);
+		dma_free_coherent(priv->dev,
+			rmu->msg_rx_ring.size * RIO_MAX_MSG_SIZE,
+			rmu->msg_rx_ring.virt, rmu->msg_rx_ring.phys);
 		goto out;
 	}
 
-- 
1.8.5
