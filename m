Return-Path: <jjhiblot@gmail.com>
Received: from mail-we0-f181.google.com (mail-we0-f181.google.com
 [74.125.82.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E29C22C0379
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 02:16:03 +1100 (EST)
Received: by mail-we0-f181.google.com with SMTP id x55so2630803wes.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 07:15:59 -0800 (PST)
From: jean-jacques hiblot <jjhiblot@traphandler.com>
To: wsa@the-dreams.de
Subject: [PATCH v3 REPOST 4/4] i2c: i2c-ibm-iic: Implements a polling mode
Date: Fri, 20 Dec 2013 16:12:56 +0100
Message-Id: <1387552376-12986-5-git-send-email-jjhiblot@traphandler.com>
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

When no valid interrupt is defined for the controller, use polling to handle
the transfers.
The polling mode can also be forced with the "iic_force_poll" module parameter.

Signed-off-by: jean-jacques hiblot <jjhiblot@traphandler.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 91 ++++++++++++++++++++++++++++++++--------
 drivers/i2c/busses/i2c-ibm_iic.h |  1 +
 2 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 857259e..aefe228 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -336,11 +336,45 @@ static irqreturn_t iic_handler(int irq, void *dev_id)
 }
 
 /*
+ * Polling used when interrupt can't be used
+ */
+static int poll_for_end_of_transfer(struct ibm_iic_private *dev, u32 timeout)
+{
+	struct iic_regs __iomem *iic = dev->vaddr;
+	u32 status;
+	unsigned long end = jiffies + timeout;
+
+	while ((dev->transfer_complete == 0) &&
+	   time_after(end, jiffies) &&
+	   !signal_pending(current)) {
+		status = in_8(&iic->sts);
+		/* check if the transfer is done or an error occured */
+		if ((status & (STS_ERR | STS_SCMP)) || !(status & STS_PT))
+			iic_xfer_bytes(dev);
+		/* The transfer is not complete,
+		 * calling schedule relaxes the CPU load and allows to know
+		 * if the process is being signaled (for abortion)
+		 */
+		if (dev->transfer_complete == 0)
+			schedule();
+	}
+
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	if (dev->transfer_complete == 0)
+		return 0;
+
+	return 1;
+}
+
+/*
  * Try to abort active transfer.
  */
 static void iic_abort_xfer(struct ibm_iic_private *dev)
 {
 	struct device *device = dev->adap.dev.parent;
+	struct iic_regs __iomem *iic = dev->vaddr;
 	unsigned long end;
 
 	DBG(dev, "aborting transfer\n");
@@ -348,8 +382,17 @@ static void iic_abort_xfer(struct ibm_iic_private *dev)
 	end = jiffies + 10;
 	dev->abort = 1;
 
-	while (time_after(end, jiffies) && !dev->transfer_complete)
-		schedule();
+	while (time_after(end, jiffies) && !dev->transfer_complete) {
+		u32 sts;
+		if (dev->use_polling) {
+			sts = in_8(&iic->sts);
+			/* check if the transfer is done or an error occured */
+			if ((sts & (STS_ERR | STS_SCMP)) || !(sts & STS_PT))
+				iic_xfer_bytes(dev);
+		}
+		if (dev->transfer_complete == 0)
+			schedule();
+	}
 
 	if (!dev->transfer_complete) {
 		dev_err(device, "abort operation failed\n");
@@ -381,7 +424,8 @@ static int iic_xfer_bytes(struct ibm_iic_private *dev)
 	if (dev->status == -ECANCELED) {
 		DBG(dev, "abort completed\n");
 		dev->transfer_complete = 1;
-		complete(&dev->iic_compl);
+		if (!dev->use_polling)
+			complete(&dev->iic_compl);
 		return dev->status;
 	}
 
@@ -400,7 +444,8 @@ static int iic_xfer_bytes(struct ibm_iic_private *dev)
 
 		dev->status = -EIO;
 		dev->transfer_complete = 1;
-		complete(&dev->iic_compl);
+		if (!dev->use_polling)
+			complete(&dev->iic_compl);
 		return dev->status;
 	}
 
@@ -428,7 +473,8 @@ static int iic_xfer_bytes(struct ibm_iic_private *dev)
 		if (dev->current_msg == dev->num_msgs) {
 			DBG2(dev, "end of transfer\n");
 			dev->transfer_complete = 1;
-			complete(&dev->iic_compl);
+			if (!dev->use_polling)
+				complete(&dev->iic_compl);
 			return dev->status;
 		}
 		pm++;
@@ -625,24 +671,29 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	/* Load slave address */
 	iic_address(dev, &msgs[0]);
 
-	init_completion(&dev->iic_compl);
+	if (!dev->use_polling)
+		init_completion(&dev->iic_compl);
 
 	/* start the transfer */
 	ret = iic_xfer_bytes(dev);
 
 	if (ret == 0) {
-		/* enable the interrupts */
-		out_8(&iic->mdcntl, MDCNTL_EINT);
-		/*  unmask the interrupts */
-		out_8(&iic->intmsk,	INTRMSK_EIMTC | INTRMSK_EITA  |
-					INTRMSK_EIIC | INTRMSK_EIHE);
-		/*  wait for the transfer to complete */
-		ret = wait_for_completion_interruptible_timeout(
-			&dev->iic_compl, num * HZ);
-		/*
-		 * we don't mask the interrupts here because we may
-		 * need them to abort the transfer gracefully
-		 */
+		if (dev->use_polling) {
+			ret = poll_for_end_of_transfer(dev, num * HZ);
+		} else {
+			/* enable the interrupts */
+			out_8(&iic->mdcntl, MDCNTL_EINT);
+			/*  unmask the interrupts */
+			out_8(&iic->intmsk,	INTRMSK_EIMTC | INTRMSK_EITA  |
+						INTRMSK_EIIC | INTRMSK_EIHE);
+			/*  wait for the transfer to complete */
+			ret = wait_for_completion_interruptible_timeout(
+				&dev->iic_compl, num * HZ);
+			/*
+			 * we don't mask the interrupts here because we may
+			 * need them to abort the transfer gracefully
+			 */
+		}
 	}
 
 	if (ret == 0) {
@@ -709,6 +760,8 @@ static int iic_request_irq(struct platform_device *ofdev,
 	struct device_node *np = ofdev->dev.of_node;
 	int irq;
 
+	dev->use_polling = 1;
+
 	if (iic_force_poll)
 		return 0;
 
@@ -729,6 +782,8 @@ static int iic_request_irq(struct platform_device *ofdev,
 		return 0;
 	}
 
+	dev->use_polling = 0;
+
 	return irq;
 }
 
diff --git a/drivers/i2c/busses/i2c-ibm_iic.h b/drivers/i2c/busses/i2c-ibm_iic.h
index 0ee28a9..523cfc1 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.h
+++ b/drivers/i2c/busses/i2c-ibm_iic.h
@@ -58,6 +58,7 @@ struct ibm_iic_private {
 	int transfer_complete;
 	int status;
 	int abort;
+	int use_polling;
 	struct completion iic_compl;
 };
 
-- 
1.8.4.2
