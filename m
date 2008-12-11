Return-Path: <m.fortini@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58B2B474C2
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 05:40:14 +1100 (EST)
Message-ID: <49415E59.7000301@selcomgroup.com>
Date: Thu, 11 Dec 2008 19:39:21 +0100
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: [RESEND] [PATCH] ADS5121 Fix: put dummy byte to enable fixing EOF
	bug to first place in order not to break some drivers\nUse ALARM
	interrupt to avoid waiting for data to come in
References: <49400F56.2040008@selcomgroup.com>
	<20081211093517.31741578@zod.rchland.ibm.com>
In-Reply-To: <20081211093517.31741578@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch is to avoid breaking some drivers, in my case the ADS7846 
touchscreen one, which use 1 char messages.
If you put the dummy byte after the 1 char message, you get part of the 
answer to the message in the rxbuf of the message, which is thrown away.

The solution is to put the dummy byte before the message, so that the 
slave doesn't respond.

It also optimizes the interrupt handling, by using the alarm function of 
the FIFO, to wait until the rx FIFO has received enough bytes, instead 
of waiting until the tx FIFO is empty.



Signed-off-by: Matteo Fortini <m.fortini@selcomgroup.com>
---
 drivers/spi/mpc512x_psc_spi.c |   50 
+++++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/mpc512x_psc_spi.c b/drivers/spi/mpc512x_psc_spi.c
index 1fd7ad4..eace796 100644
--- a/drivers/spi/mpc512x_psc_spi.c
+++ b/drivers/spi/mpc512x_psc_spi.c
@@ -175,6 +175,7 @@ static int mpc512x_psc_spi_transfer_rxtx(struct 
spi_device *spi,
         u8 data;
         size_t fifosz;
         int rxcount;
+        int txcount;
 
         /*
          * The number of bytes that can be sent at a time
@@ -183,41 +184,49 @@ static int mpc512x_psc_spi_transfer_rxtx(struct 
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
-
-        /* enable transmiter/receiver */
-        out_8(&psc->command, MPC52xx_PSC_TX_ENABLE | 
MPC52xx_PSC_RX_ENABLE);
+        /* Enable FIFO_ALARM interrupts for rx_fifo */
+        out_be32(&fifo->rxalarm, txcount);
+        out_be32(&fifo->rxisr, MPC512x_PSC_FIFO_ALARM);
+        out_be32(&fifo->rximr, MPC512x_PSC_FIFO_ALARM);
 
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
+                "but got %d\n", txcount, rxcount);
         rxcount = min(rxcount, count);
         {
+            /* Throw away possible initial dummy byte */
+            if (t->len == 1) {
+                (void)in_8(&fifo->rxdata_8);
+            }
             for (i = rxcount; i > 0; i--) {
                 data = in_8(&fifo->rxdata_8);
                 if (rx_buf)
@@ -418,10 +427,9 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, 
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
