Return-Path: <m.fortini@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 965EADDF3D
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 05:50:52 +1100 (EST)
Message-ID: <49400F56.2040008@selcomgroup.com>
Date: Wed, 10 Dec 2008 19:49:58 +0100
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ADS5121 Fix: put dummy byte to enable fixing EOF bug to first
	place in order not to break some drivers\nUse ALARM interrupt to
	avoid waiting for data to come in
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 From d500e922b750a2bea554d32d8f12937f4da9c80a Mon Sep 17 00:00:00 2001
From: Matteo Fortini <m.fortini@selcomgroup.com>
Date: Wed, 10 Dec 2008 19:33:16 +0100
Subject: [PATCH] Fix: put dummy byte to enable fixing EOF bug to first 
place in order not to break some drivers
 Use ALARM interrupt to avoid waiting for data to come in


Signed-off-by: Matteo Fortini <m.fortini@selcomgroup.com>
---
 drivers/spi/mpc512x_psc_spi.c |   53 
++++++++++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/mpc512x_psc_spi.c b/drivers/spi/mpc512x_psc_spi.c
index 1fd7ad4..41faa49 100644
--- a/drivers/spi/mpc512x_psc_spi.c
+++ b/drivers/spi/mpc512x_psc_spi.c
@@ -136,6 +136,7 @@ static void mpc512x_psc_spi_deactivate_cs(struct 
spi_device *spi)
                    (spi->mode & SPI_CS_HIGH) ? 1 : 0);
 }
 
+
 /*
  * Current MPC5121's have a bug in the SS logic that requires setting
  * the EOF flag on the next to last byte instead of the last
@@ -155,7 +156,7 @@ static int mpc512x_psc_spi_transfer_rxtx(struct 
spi_device *spi,
 
     if (!tx_buf && !rx_buf && t->len)
         return -EINVAL;
-
+    
     /*
      * zero out Mode register 2
      * From the ref man:
@@ -175,6 +176,7 @@ static int mpc512x_psc_spi_transfer_rxtx(struct 
spi_device *spi,
         u8 data;
         size_t fifosz;
         int rxcount;
+        int txcount;
 
         /*
          * The number of bytes that can be sent at a time
@@ -183,41 +185,49 @@ static int mpc512x_psc_spi_transfer_rxtx(struct 
spi_device *spi,
         fifosz = MPC512x_PSC_FIFO_SZ(in_be32(&fifo->txsz));
         count = min(fifosz, len);
 
+        txcount = 0;
+        /*
+         * Insert a dummy byte before a message of len 1 to make it at 
least 2 bytes long
+         * to be able to set EOF correctly
+         */
+        if (t->len == 1) {
+            out_8(&fifo->txdata_8, 0);
+            txcount++;
+        }
         for (i = count; i > 0; i--) {
             if (len == EOFBYTE || t->len == 1)
                 setbits32(&fifo->txcmd, MPC512x_PSC_FIFO_EOF);
             data = tx_buf ? *tx_buf++ : 0;
             out_8(&fifo->txdata_8, data);
-            if (t->len == 1)
-                out_8(&fifo->txdata_8, 0);
+            txcount++;
             len--;
         }
 
         INIT_COMPLETION(mps->done);
 
-        /* interrupt on tx fifo empty */
-        out_be32(&fifo->txisr, MPC512x_PSC_FIFO_EMPTY);
-        out_be32(&fifo->tximr, MPC512x_PSC_FIFO_EMPTY);
+        /* Enable FIFO_ALARM interrupts for rx_fifo */
+        out_be32(&fifo->rxalarm, txcount);
+        out_be32(&fifo->rxisr, MPC512x_PSC_FIFO_ALARM);
+        out_be32(&fifo->rximr, MPC512x_PSC_FIFO_ALARM);
 
-        /* enable transmiter/receiver */
-        out_8(&psc->command, MPC52xx_PSC_TX_ENABLE | 
MPC52xx_PSC_RX_ENABLE);
-
-        wait_for_completion(&mps->done);
+        /* Disable tx_fifo interrupts */
+        out_be32(&fifo->txisr, 0xffffffff);
+        out_be32(&fifo->tximr, 0);
 
-        mdelay(1);
+        out_8(&psc->command, MPC52xx_PSC_TX_ENABLE | 
MPC52xx_PSC_RX_ENABLE);
 
-        /* rx fifo should have count bytes in it */
-        rxcount = in_be32(&fifo->rxcnt);
-        if (rxcount != count)
-            mdelay(1);
+        wait_for_completion (&mps->done);
 
         rxcount = in_be32(&fifo->rxcnt);
-        if (rxcount != count && t->len != 1)
+        if (rxcount != txcount)
             printk(KERN_WARNING "expected %d bytes in rx fifo "
-                       "but got %d\n", count, rxcount);
-
+                    "but got %d\n", txcount, rxcount);
         rxcount = min(rxcount, count);
         {
+            /* Throw away possible initial dummy byte */
+            if (t->len == 1) {
+                (void)in_8(&fifo->rxdata_8);
+            }
             for (i = rxcount; i > 0; i--) {
                 data = in_8(&fifo->rxdata_8);
                 if (rx_buf)
@@ -418,10 +428,9 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, 
void *dev_id)
     struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
 
     /* clear interrupt and wake up the work queue */
-    if (in_be32(&fifo->txisr)
-        & in_be32(&fifo->tximr) & MPC512x_PSC_FIFO_EMPTY) {
-        out_be32(&fifo->txisr, MPC512x_PSC_FIFO_EMPTY);
-        out_be32(&fifo->tximr, 0);
+    if (in_be32(&fifo->rxisr) & in_be32(&fifo->rximr) & 
MPC512x_PSC_FIFO_ALARM) {
+        out_be32(&fifo->rxisr, MPC512x_PSC_FIFO_ALARM);
+        out_be32(&fifo->rximr, 0);
         complete(&mps->done);
         return IRQ_HANDLED;
     }
-- 
1.5.4.3
