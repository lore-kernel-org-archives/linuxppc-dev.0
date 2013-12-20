Return-Path: <jjhiblot@gmail.com>
Received: from mail-we0-f175.google.com (mail-we0-f175.google.com
 [74.125.82.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D1BD2C037C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 02:16:01 +1100 (EST)
Received: by mail-we0-f175.google.com with SMTP id t60so2570643wes.20
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 07:15:57 -0800 (PST)
From: jean-jacques hiblot <jjhiblot@traphandler.com>
To: wsa@the-dreams.de
Subject: [PATCH v3 REPOST 3/4] i2c: i2c-ibm-iic: Implements transfer abortion
Date: Fri, 20 Dec 2013 16:12:55 +0100
Message-Id: <1387552376-12986-4-git-send-email-jjhiblot@traphandler.com>
In-Reply-To: <1387552376-12986-1-git-send-email-jjhiblot@traphandler.com>
References: <1387552376-12986-1-git-send-email-jjhiblot@traphandler.com>
Cc: gregory.clement@free-electrons.com,
 jean-jacques hiblot <jjhiblot@traphandler.com>, linuxppc-dev@lists.ozlabs.org,
 linux-i2c@vger.kernel.org, jean-jacques hiblot <jjhiblot@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: jean-jacques hiblot <jjhiblot@gmail.com>

Clean-up properly when a transfer fails for whatever reason.
Cancel the transfer when the process is signaled.

Signed-off-by: jean-jacques hiblot <jjhiblot@traphandler.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 146 ++++++++++-----------------------------
 drivers/i2c/busses/i2c-ibm_iic.h |   2 +-
 2 files changed, 36 insertions(+), 112 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index a92e8f6..857259e 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -336,120 +336,25 @@ static irqreturn_t iic_handler(int irq, void *dev_id)
 }
 
 /*
- * Get master transfer result and clear errors if any.
- * Returns the number of actually transferred bytes or error (<0)
- */
-static int iic_xfer_result(struct ibm_iic_private* dev)
-{
-	struct iic_regs __iomem *iic = dev->vaddr;
-
-	if (unlikely(in_8(&iic->sts) & STS_ERR)){
-		DBG(dev, "xfer error, EXTSTS = 0x%02x\n",
-			in_8(&iic->extsts));
-
-		/* Clear errors and possible pending IRQs */
-		out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD |
-			EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA);
-
-		/* Flush master data buffer */
-		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
-
-		/*
-		 * Is bus free?
-		 * If error happened during combined xfer
-		 * IIC interface is usually stuck in some strange
-		 * state, the only way out - soft reset.
-		 */
-		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
-			DBG(dev, "bus is stuck, resetting\n");
-			iic_dev_reset(dev);
-		}
-		return -EREMOTEIO;
-	}
-	else
-		return in_8(&iic->xfrcnt) & XFRCNT_MTC_MASK;
-}
-
-/*
  * Try to abort active transfer.
  */
-static void iic_abort_xfer(struct ibm_iic_private* dev)
+static void iic_abort_xfer(struct ibm_iic_private *dev)
 {
-	struct iic_regs __iomem *iic = dev->vaddr;
-	unsigned long x;
-
-	DBG(dev, "iic_abort_xfer\n");
+	struct device *device = dev->adap.dev.parent;
+	unsigned long end;
 
-	out_8(&iic->cntl, CNTL_HMT);
+	DBG(dev, "aborting transfer\n");
+	/* transfer should be aborted within 10ms */
+	end = jiffies + 10;
+	dev->abort = 1;
 
-	/*
-	 * Wait for the abort command to complete.
-	 * It's not worth to be optimized, just poll (timeout >= 1 tick)
-	 */
-	x = jiffies + 2;
-	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
-		if (time_after(jiffies, x)){
-			DBG(dev, "abort timeout, resetting...\n");
-			iic_dev_reset(dev);
-			return;
-		}
+	while (time_after(end, jiffies) && !dev->transfer_complete)
 		schedule();
-	}
 
-	/* Just to clear errors */
-	iic_xfer_result(dev);
-}
-
-/*
- * Wait for master transfer to complete.
- * It puts current process to sleep until we get interrupt or timeout expires.
- * Returns the number of transferred bytes or error (<0)
- */
-static int iic_wait_for_tc(struct ibm_iic_private* dev){
-
-	struct iic_regs __iomem *iic = dev->vaddr;
-	int ret = 0;
-
-	if (dev->irq >= 0){
-		/* Interrupt mode */
-		ret = wait_event_interruptible_timeout(dev->wq,
-			!(in_8(&iic->sts) & STS_PT), dev->adap.timeout);
-
-		if (unlikely(ret < 0))
-			DBG(dev, "wait interrupted\n");
-		else if (unlikely(in_8(&iic->sts) & STS_PT)){
-			DBG(dev, "wait timeout\n");
-			ret = -ETIMEDOUT;
-		}
-	}
-	else {
-		/* Polling mode */
-		unsigned long x = jiffies + dev->adap.timeout;
-
-		while (in_8(&iic->sts) & STS_PT){
-			if (unlikely(time_after(jiffies, x))){
-				DBG(dev, "poll timeout\n");
-				ret = -ETIMEDOUT;
-				break;
-			}
-
-			if (unlikely(signal_pending(current))){
-				DBG(dev, "poll interrupted\n");
-				ret = -ERESTARTSYS;
-				break;
-			}
-			schedule();
-		}
+	if (!dev->transfer_complete) {
+		dev_err(device, "abort operation failed\n");
+		iic_dev_reset(dev);
 	}
-
-	if (unlikely(ret < 0))
-		iic_abort_xfer(dev);
-	else
-		ret = iic_xfer_result(dev);
-
-	DBG2(dev, "iic_wait_for_tc -> %d\n", ret);
-
-	return ret;
 }
 
 /*
@@ -473,6 +378,13 @@ static int iic_xfer_bytes(struct ibm_iic_private *dev)
 			    EXTSTS_ICT | EXTSTS_XFRA);
 	out_8(&iic->sts, STS_IRQA | STS_SCMP);
 
+	if (dev->status == -ECANCELED) {
+		DBG(dev, "abort completed\n");
+		dev->transfer_complete = 1;
+		complete(&dev->iic_compl);
+		return dev->status;
+	}
+
 	if ((status & STS_ERR) ||
 	    (ext_status & (EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA))) {
 		DBG(dev, "status 0x%x\n", status);
@@ -577,7 +489,14 @@ static int iic_xfer_bytes(struct ibm_iic_private *dev)
 	/* actually start the transfer of the current data chunk */
 	out_8(&iic->cntl, cntl | CNTL_PT);
 
-	return 0;
+	/* The transfer must be aborted. */
+	if (dev->abort) {
+		DBG(dev, "aborting\n");
+		out_8(&iic->cntl, CNTL_HMT);
+		dev->status = -ECANCELED;
+	}
+
+	return dev->status;
 }
 
 /*
@@ -682,6 +601,7 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	dev->current_byte = dev->current_msg = dev->current_byte_rx = 0;
 	dev->transfer_complete = 0;
 	dev->status = 0;
+	dev->abort = 0;
 	dev->msgs = msgs;
 	dev->num_msgs = num;
 
@@ -719,8 +639,10 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		/*  wait for the transfer to complete */
 		ret = wait_for_completion_interruptible_timeout(
 			&dev->iic_compl, num * HZ);
-		/* mask the interrupts */
-		out_8(&iic->intmsk, 0);
+		/*
+		 * we don't mask the interrupts here because we may
+		 * need them to abort the transfer gracefully
+		 */
 	}
 
 	if (ret == 0) {
@@ -729,11 +651,15 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	} else if (ret < 0) {
 		if (ret == -ERESTARTSYS)
 			ERR(dev, "transfer interrupted\n");
+		iic_abort_xfer(dev);
 	} else {
 		/* Transfer is complete */
 		ret = (dev->status) ? dev->status : num;
 	}
 
+	/* mask the interrupts */
+	out_8(&iic->intmsk, 0);
+
 	return ret;
 }
 
@@ -832,8 +758,6 @@ static int iic_probe(struct platform_device *ofdev)
 		goto error_cleanup;
 	}
 
-	init_waitqueue_head(&dev->wq);
-
 	dev->irq = iic_request_irq(ofdev, dev);
 	if (!dev->irq)
 		dev_info(&ofdev->dev, "using polling mode\n");
diff --git a/drivers/i2c/busses/i2c-ibm_iic.h b/drivers/i2c/busses/i2c-ibm_iic.h
index 76c476a..0ee28a9 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.h
+++ b/drivers/i2c/busses/i2c-ibm_iic.h
@@ -47,7 +47,6 @@ struct iic_regs {
 struct ibm_iic_private {
 	struct i2c_adapter adap;
 	struct iic_regs __iomem *vaddr;
-	wait_queue_head_t wq;
 	int irq;
 	int fast_mode;
 	u8  clckdiv;
@@ -58,6 +57,7 @@ struct ibm_iic_private {
 	int current_byte_rx;
 	int transfer_complete;
 	int status;
+	int abort;
 	struct completion iic_compl;
 };
 
-- 
1.8.4.2
