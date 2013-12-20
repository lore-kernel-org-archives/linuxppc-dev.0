Return-Path: <jjhiblot@gmail.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E6932C037C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 02:15:59 +1100 (EST)
Received: by mail-wg0-f43.google.com with SMTP id k14so2609552wgh.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 07:15:55 -0800 (PST)
From: jean-jacques hiblot <jjhiblot@traphandler.com>
To: wsa@the-dreams.de
Subject: [PATCH v3 REPOST 2/4] i2c: i2c-ibm-iic: perform the transfer in the
 interrupt handler
Date: Fri, 20 Dec 2013 16:12:54 +0100
Message-Id: <1387552376-12986-3-git-send-email-jjhiblot@traphandler.com>
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

The current implementation uses the interrupt only to wakeup the process doing
the data transfer. While this is working, it introduces indesirable latencies.
This patch implements the data transfer in the interrupt handler. It keeps the
latency between individual bytes low and the jitter on the total transfer time
is reduced.

Note: transfer abortion and polling mode are not working and will be supported
in further patches

This was tested on a custom board built around a PPC460EX with several
different I2C devices (including EEPROMs and smart batteries)

Signed-off-by: jean-jacques hiblot <jjhiblot@traphandler.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 230 ++++++++++++++++++++++++++++-----------
 drivers/i2c/busses/i2c-ibm_iic.h |   8 ++
 2 files changed, 177 insertions(+), 61 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 03ab756..a92e8f6 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -58,6 +58,8 @@ static bool iic_force_fast;
 module_param(iic_force_fast, bool, 0);
 MODULE_PARM_DESC(iic_force_fast, "Force fast mode (400 kHz)");
 
+#define FIFO_FLUSH_TIMEOUT 100
+
 #define DBG_LEVEL 0
 
 #ifdef DBG
@@ -125,6 +127,7 @@ static struct i2c_timings {
 	.high 	= 600,
 	.buf	= 1300,
 }};
+static int iic_xfer_bytes(struct ibm_iic_private *dev);
 
 /* Enable/disable interrupt generation */
 static inline void iic_interrupt_mode(struct ibm_iic_private* dev, int enable)
@@ -167,8 +170,8 @@ static void iic_dev_init(struct ibm_iic_private* dev)
 	/* Clear control register */
 	out_8(&iic->cntl, 0);
 
-	/* Enable interrupts if possible */
-	iic_interrupt_mode(dev, dev->irq >= 0);
+	/* Start with each individual interrupt masked*/
+	iic_interrupt_mode(dev, 0);
 
 	/* Set mode control */
 	out_8(&iic->mdcntl, MDCNTL_FMDB | MDCNTL_EINT | MDCNTL_EUBS
@@ -327,16 +330,8 @@ err:
  */
 static irqreturn_t iic_handler(int irq, void *dev_id)
 {
-	struct ibm_iic_private* dev = (struct ibm_iic_private*)dev_id;
-	struct iic_regs __iomem *iic = dev->vaddr;
-
-	DBG2(dev, "irq handler, STS = 0x%02x, EXTSTS = 0x%02x\n",
-	     in_8(&iic->sts), in_8(&iic->extsts));
-
-	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
-	out_8(&iic->sts, STS_IRQA | STS_SCMP);
-	wake_up_interruptible(&dev->wq);
-
+	struct ibm_iic_private *dev = (struct ibm_iic_private *) dev_id;
+	iic_xfer_bytes(dev);
 	return IRQ_HANDLED;
 }
 
@@ -460,60 +455,129 @@ static int iic_wait_for_tc(struct ibm_iic_private* dev){
 /*
  * Low level master transfer routine
  */
-static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
-			  int combined_xfer)
+static int iic_xfer_bytes(struct ibm_iic_private *dev)
 {
-	struct iic_regs __iomem *iic = dev->vaddr;
-	char* buf = pm->buf;
-	int i, j, loops, ret = 0;
-	int len = pm->len;
-
-	u8 cntl = (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
-	if (pm->flags & I2C_M_RD)
-		cntl |= CNTL_RW;
+	struct i2c_msg *pm = &(dev->msgs[dev->current_msg]);
+	struct iic_regs *iic = dev->vaddr;
+	u8 cntl = in_8(&iic->cntl) & CNTL_AMD;
+	int count;
+	u32 status;
+	u32 ext_status;
+
+	/* First check the status register */
+	status = in_8(&iic->sts);
+	ext_status = in_8(&iic->extsts);
+
+	/* and acknowledge the interrupt */
+	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA |
+			    EXTSTS_ICT | EXTSTS_XFRA);
+	out_8(&iic->sts, STS_IRQA | STS_SCMP);
 
-	loops = (len + 3) / 4;
-	for (i = 0; i < loops; ++i, len -= 4){
-		int count = len > 4 ? 4 : len;
-		u8 cmd = cntl | ((count - 1) << CNTL_TCT_SHIFT);
+	if ((status & STS_ERR) ||
+	    (ext_status & (EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA))) {
+		DBG(dev, "status 0x%x\n", status);
+		DBG(dev, "extended status 0x%x\n", ext_status);
+		if (status & STS_ERR)
+			ERR(dev, "Error detected\n");
+		if (ext_status & EXTSTS_LA)
+			DBG(dev, "Lost arbitration\n");
+		if (ext_status & EXTSTS_ICT)
+			ERR(dev, "Incomplete transfer\n");
+		if (ext_status & EXTSTS_XFRA)
+			ERR(dev, "Transfer aborted\n");
+
+		dev->status = -EIO;
+		dev->transfer_complete = 1;
+		complete(&dev->iic_compl);
+		return dev->status;
+	}
 
-		if (!(cntl & CNTL_RW))
-			for (j = 0; j < count; ++j)
-				out_8(&iic->mdbuf, *buf++);
+	if (dev->msgs == NULL) {
+		DBG(dev, "spurious !!!!!\n");
+		dev->status = -EINVAL;
+		return dev->status;
+	}
 
-		if (i < loops - 1)
-			cmd |= CNTL_CHT;
-		else if (combined_xfer)
-			cmd |= CNTL_RPST;
+	/* check if there's any data to read from the fifo */
+	if (pm->flags & I2C_M_RD) {
+		while (dev->current_byte_rx < dev->current_byte) {
+			u8 *buf = pm->buf + dev->current_byte_rx;
+			*buf = in_8(&iic->mdbuf);
+			dev->current_byte_rx++;
+			DBG2(dev, "read 0x%x\n", *buf);
+		}
+	}
+	/* check if we must go with the next tranfer */
+	if (pm->len  == dev->current_byte) {
+		DBG2(dev, "going to next transfer\n");
+		dev->current_byte = 0;
+		dev->current_byte_rx = 0;
+		dev->current_msg++;
+		if (dev->current_msg == dev->num_msgs) {
+			DBG2(dev, "end of transfer\n");
+			dev->transfer_complete = 1;
+			complete(&dev->iic_compl);
+			return dev->status;
+		}
+		pm++;
+	}
 
-		DBG2(dev, "xfer_bytes, %d, CNTL = 0x%02x\n", count, cmd);
+	/* take care of the direction */
+	if (pm->flags & I2C_M_RD)
+		cntl |= CNTL_RW;
 
-		/* Start transfer */
-		out_8(&iic->cntl, cmd);
+	/*
+	 * how much data are we going to transfer this time ?
+	 * (up to 4 bytes at once)
+	 */
+	count = pm->len  - dev->current_byte;
+	count = (count > 4) ? 4 : count;
+	cntl |= (count - 1) << CNTL_TCT_SHIFT;
+
+	if ((pm->flags & I2C_M_RD) == 0) {
+		/* This is a write. we must fill the fifo with the data */
+		int i;
+		u8 *buf = pm->buf + dev->current_byte;
+
+		for (i = 0; i < count; i++) {
+			out_8(&iic->mdbuf, buf[i]);
+			DBG2(dev, "write : 0x%x\n", buf[i]);
+		}
+	}
 
-		/* Wait for completion */
-		ret = iic_wait_for_tc(dev);
+	/* will the current transfer complete with this chunk of data ? */
+	if (pm->len  > dev->current_byte + 4) {
+		/*
+		 * we're not done with the current transfer.
+		 * Don't send a repeated start
+		 */
+		cntl |= CNTL_CHT;
+	}
+	/*
+	 * This transfer will be complete with this chunk of data
+	 * BUT is this the last transfer of the list ?
+	 */
+	else if (dev->current_msg != (dev->num_msgs-1)) {
+		/* not the last tranfer */
+		cntl |= CNTL_RPST; /* Do not send a STOP condition */
+		/* check if the NEXT transfer needs a repeated start */
+		if (pm[1].flags & I2C_M_NOSTART)
+			cntl |= CNTL_CHT;
+	}
 
-		if (unlikely(ret < 0))
-			break;
-		else if (unlikely(ret != count)){
-			DBG(dev, "xfer_bytes, requested %d, transferred %d\n",
-				count, ret);
+	if ((cntl & CNTL_RPST) == 0)
+		DBG2(dev, "STOP required\n");
 
-			/* If it's not a last part of xfer, abort it */
-			if (combined_xfer || (i < loops - 1))
-    				iic_abort_xfer(dev);
+	if ((cntl & CNTL_CHT) == 0)
+		DBG2(dev, "next transfer will begin with START\n");
 
-			ret = -EREMOTEIO;
-			break;
-		}
+	/* keep track of the amount of data transfered (RX and TX) */
+	dev->current_byte += count;
 
-		if (cntl & CNTL_RW)
-			for (j = 0; j < count; ++j)
-				*buf++ = in_8(&iic->mdbuf);
-	}
+	/* actually start the transfer of the current data chunk */
+	out_8(&iic->cntl, cntl | CNTL_PT);
 
-	return ret > 0 ? 0 : ret;
+	return 0;
 }
 
 /*
@@ -614,19 +678,63 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 			return -EREMOTEIO;
 		}
 	}
-	else {
-		/* Flush master data buffer (just in case) */
-		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
+
+	dev->current_byte = dev->current_msg = dev->current_byte_rx = 0;
+	dev->transfer_complete = 0;
+	dev->status = 0;
+	dev->msgs = msgs;
+	dev->num_msgs = num;
+
+	/* clear the buffers */
+	out_8(&iic->mdcntl, MDCNTL_FMDB);
+	i = FIFO_FLUSH_TIMEOUT;
+	while (in_8(&iic->mdcntl) & MDCNTL_FMDB) {
+		if (i-- < 0) {
+			DBG(dev, "iic_xfer, unable to flush\n");
+			return -EREMOTEIO;
+		}
 	}
 
+	/* clear all interrupts masks */
+	out_8(&iic->intmsk, 0x0);
+	/* clear any status */
+	out_8(&iic->sts, STS_IRQA | STS_SCMP);
+	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA |
+			    EXTSTS_ICT | EXTSTS_XFRA);
+
 	/* Load slave address */
 	iic_address(dev, &msgs[0]);
 
-	/* Do real transfer */
-    	for (i = 0; i < num && !ret; ++i)
-		ret = iic_xfer_bytes(dev, &msgs[i], i < num - 1);
+	init_completion(&dev->iic_compl);
+
+	/* start the transfer */
+	ret = iic_xfer_bytes(dev);
+
+	if (ret == 0) {
+		/* enable the interrupts */
+		out_8(&iic->mdcntl, MDCNTL_EINT);
+		/*  unmask the interrupts */
+		out_8(&iic->intmsk,	INTRMSK_EIMTC | INTRMSK_EITA  |
+					INTRMSK_EIIC | INTRMSK_EIHE);
+		/*  wait for the transfer to complete */
+		ret = wait_for_completion_interruptible_timeout(
+			&dev->iic_compl, num * HZ);
+		/* mask the interrupts */
+		out_8(&iic->intmsk, 0);
+	}
 
-	return ret < 0 ? ret : num;
+	if (ret == 0) {
+		ERR(dev, "transfer timed out\n");
+		ret = -ETIMEDOUT;
+	} else if (ret < 0) {
+		if (ret == -ERESTARTSYS)
+			ERR(dev, "transfer interrupted\n");
+	} else {
+		/* Transfer is complete */
+		ret = (dev->status) ? dev->status : num;
+	}
+
+	return ret;
 }
 
 static u32 iic_func(struct i2c_adapter *adap)
diff --git a/drivers/i2c/busses/i2c-ibm_iic.h b/drivers/i2c/busses/i2c-ibm_iic.h
index 1efce5d..76c476a 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.h
+++ b/drivers/i2c/busses/i2c-ibm_iic.h
@@ -51,6 +51,14 @@ struct ibm_iic_private {
 	int irq;
 	int fast_mode;
 	u8  clckdiv;
+	struct i2c_msg *msgs;
+	int num_msgs;
+	int current_msg;
+	int current_byte;
+	int current_byte_rx;
+	int transfer_complete;
+	int status;
+	struct completion iic_compl;
 };
 
 /* IICx_CNTL register */
-- 
1.8.4.2
