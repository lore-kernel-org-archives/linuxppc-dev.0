Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 497D0DE0D3
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Apr 2009 03:48:54 +1000 (EST)
Date: Sat, 18 Apr 2009 21:48:52 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] fsl_rio: Pass the proper device to dma mapping routines
Message-ID: <20090418174852.GA28955@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The driver should pass a device that specifies internal DMA ops, but
currently NULL pointer is passed, therefore following bug appears
during boot up:

  ------------[ cut here ]------------
  Kernel BUG at c0018a7c [verbose debug info unavailable]
  Oops: Exception in kernel mode, sig: 5 [#1]
  [...]
  NIP [c0018a7c] fsl_rio_doorbell_init+0x34/0x60
  LR [c0018a70] fsl_rio_doorbell_init+0x28/0x60
  Call Trace:
  [ef82bda0] [c0018a70] fsl_rio_doorbell_init+0x28/0x60 (unreliable)
  [ef82bdc0] [c0019160] fsl_rio_setup+0x6b8/0x84c
  [ef82be20] [c02d28ac] fsl_of_rio_rpn_probe+0x30/0x50
  [ef82be40] [c0234f20] of_platform_device_probe+0x5c/0x84
  [...]
  ---[ end trace 561bb236c800851f ]---

This patch fixes the issue.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/fsl_rio.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index a0fa4eb..abdb124 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/device.h>
 #include <linux/rio.h>
 #include <linux/rio_drv.h>
 #include <linux/of_platform.h>
@@ -159,6 +160,7 @@ struct rio_msg_rx_ring {
 };
 
 struct rio_priv {
+	struct device *dev;
 	void __iomem *regs_win;
 	struct rio_atmu_regs __iomem *atmu_regs;
 	struct rio_atmu_regs __iomem *maint_atmu_regs;
@@ -484,13 +486,13 @@ int rio_open_outb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entr
 
 	for (i = 0; i < priv->msg_tx_ring.size; i++) {
 		priv->msg_tx_ring.virt_buffer[i] =
-			dma_alloc_coherent(NULL, RIO_MSG_BUFFER_SIZE,
+			dma_alloc_coherent(priv->dev, RIO_MSG_BUFFER_SIZE,
 				&priv->msg_tx_ring.phys_buffer[i], GFP_KERNEL);
 		if (!priv->msg_tx_ring.virt_buffer[i]) {
 			rc = -ENOMEM;
 			for (j = 0; j < priv->msg_tx_ring.size; j++)
 				if (priv->msg_tx_ring.virt_buffer[j])
-					dma_free_coherent(NULL,
+					dma_free_coherent(priv->dev,
 							RIO_MSG_BUFFER_SIZE,
 							priv->msg_tx_ring.
 							virt_buffer[j],
@@ -501,7 +503,7 @@ int rio_open_outb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entr
 	}
 
 	/* Initialize outbound message descriptor ring */
-	priv->msg_tx_ring.virt = dma_alloc_coherent(NULL,
+	priv->msg_tx_ring.virt = dma_alloc_coherent(priv->dev,
 				priv->msg_tx_ring.size * RIO_MSG_DESC_SIZE,
 				&priv->msg_tx_ring.phys, GFP_KERNEL);
 	if (!priv->msg_tx_ring.virt) {
@@ -549,12 +551,13 @@ int rio_open_outb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entr
 	return rc;
 
       out_irq:
-	dma_free_coherent(NULL, priv->msg_tx_ring.size * RIO_MSG_DESC_SIZE,
+	dma_free_coherent(priv->dev,
+			  priv->msg_tx_ring.size * RIO_MSG_DESC_SIZE,
 			  priv->msg_tx_ring.virt, priv->msg_tx_ring.phys);
 
       out_dma:
 	for (i = 0; i < priv->msg_tx_ring.size; i++)
-		dma_free_coherent(NULL, RIO_MSG_BUFFER_SIZE,
+		dma_free_coherent(priv->dev, RIO_MSG_BUFFER_SIZE,
 				  priv->msg_tx_ring.virt_buffer[i],
 				  priv->msg_tx_ring.phys_buffer[i]);
 
@@ -576,7 +579,8 @@ void rio_close_outb_mbox(struct rio_mport *mport, int mbox)
 	out_be32(&priv->msg_regs->omr, 0);
 
 	/* Free ring */
-	dma_free_coherent(NULL, priv->msg_tx_ring.size * RIO_MSG_DESC_SIZE,
+	dma_free_coherent(priv->dev,
+			  priv->msg_tx_ring.size * RIO_MSG_DESC_SIZE,
 			  priv->msg_tx_ring.virt, priv->msg_tx_ring.phys);
 
 	/* Free interrupt */
@@ -654,7 +658,7 @@ int rio_open_inb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entri
 		priv->msg_rx_ring.virt_buffer[i] = NULL;
 
 	/* Initialize inbound message ring */
-	priv->msg_rx_ring.virt = dma_alloc_coherent(NULL,
+	priv->msg_rx_ring.virt = dma_alloc_coherent(priv->dev,
 				priv->msg_rx_ring.size * RIO_MAX_MSG_SIZE,
 				&priv->msg_rx_ring.phys, GFP_KERNEL);
 	if (!priv->msg_rx_ring.virt) {
@@ -673,7 +677,7 @@ int rio_open_inb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entri
 	rc = request_irq(IRQ_RIO_RX(mport), fsl_rio_rx_handler, 0,
 			 "msg_rx", (void *)mport);
 	if (rc < 0) {
-		dma_free_coherent(NULL, RIO_MSG_BUFFER_SIZE,
+		dma_free_coherent(priv->dev, RIO_MSG_BUFFER_SIZE,
 				  priv->msg_tx_ring.virt_buffer[i],
 				  priv->msg_tx_ring.phys_buffer[i]);
 		goto out;
@@ -713,7 +717,7 @@ void rio_close_inb_mbox(struct rio_mport *mport, int mbox)
 	out_be32(&priv->msg_regs->imr, 0);
 
 	/* Free ring */
-	dma_free_coherent(NULL, priv->msg_rx_ring.size * RIO_MAX_MSG_SIZE,
+	dma_free_coherent(priv->dev, priv->msg_rx_ring.size * RIO_MAX_MSG_SIZE,
 			  priv->msg_rx_ring.virt, priv->msg_rx_ring.phys);
 
 	/* Free interrupt */
@@ -890,7 +894,7 @@ static int fsl_rio_doorbell_init(struct rio_mport *mport)
 	}
 
 	/* Initialize inbound doorbells */
-	priv->dbell_ring.virt = dma_alloc_coherent(NULL, 512 *
+	priv->dbell_ring.virt = dma_alloc_coherent(priv->dev, 512 *
 		    DOORBELL_MESSAGE_SIZE, &priv->dbell_ring.phys, GFP_KERNEL);
 	if (!priv->dbell_ring.virt) {
 		printk(KERN_ERR "RIO: unable allocate inbound doorbell ring\n");
@@ -911,7 +915,7 @@ static int fsl_rio_doorbell_init(struct rio_mport *mport)
 			 "dbell_rx", (void *)mport);
 	if (rc < 0) {
 		iounmap(priv->dbell_win);
-		dma_free_coherent(NULL, 512 * DOORBELL_MESSAGE_SIZE,
+		dma_free_coherent(priv->dev, 512 * DOORBELL_MESSAGE_SIZE,
 				  priv->dbell_ring.virt, priv->dbell_ring.phys);
 		printk(KERN_ERR
 		       "MPC85xx RIO: unable to request inbound doorbell irq");
@@ -1087,6 +1091,8 @@ int fsl_rio_setup(struct of_device *dev)
 	rio_init_mbox_res(&port->riores[RIO_OUTB_MBOX_RESOURCE], 0, 0);
 	strcpy(port->name, "RIO0 mport");
 
+	priv->dev = &dev->dev;
+
 	port->ops = ops;
 	port->host_deviceid = fsl_rio_get_hdid(port->id);
 
-- 
1.6.2.2
