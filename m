Return-Path: <Dongsheng.Wang@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BC4982C009B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 17:33:47 +1100 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH 2/2] powerpc/85xx: handle the eLBC error interrupt if it exist
 in dts
Date: Tue, 7 Jan 2014 14:27:41 +0800
Message-ID: <1389076061-20159-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

On P3041, P1020, P1021, P1022, P1023 eLBC event interrupts are routed
to Int9(P3041) & Int3(P102x) while ELBC error interrupts are routed to
Int0, we need to call request_irq for each.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
index 420b453..067fb0d 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -285,7 +285,7 @@ struct fsl_lbc_ctrl {
 	/* device info */
 	struct device			*dev;
 	struct fsl_lbc_regs __iomem	*regs;
-	int				irq;
+	int				irq[2];
 	wait_queue_head_t		irq_wait;
 	spinlock_t			lock;
 	void				*nand;
diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index 6bc5a54..d631022 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -214,10 +214,14 @@ static irqreturn_t fsl_lbc_ctrl_irq(int irqno, void *data)
 	struct fsl_lbc_ctrl *ctrl = data;
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
 	u32 status;
+	unsigned long flags;
 
+	spin_lock_irqsave(&fsl_lbc_lock, flags);
 	status = in_be32(&lbc->ltesr);
-	if (!status)
+	if (!status) {
+		spin_unlock_irqrestore(&fsl_lbc_lock, flags);
 		return IRQ_NONE;
+	}
 
 	out_be32(&lbc->ltesr, LTESR_CLEAR);
 	out_be32(&lbc->lteatr, 0);
@@ -260,6 +264,7 @@ static irqreturn_t fsl_lbc_ctrl_irq(int irqno, void *data)
 	if (status & ~LTESR_MASK)
 		dev_err(ctrl->dev, "Unknown error: "
 			"LTESR 0x%08X\n", status);
+	spin_unlock_irqrestore(&fsl_lbc_lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -298,8 +303,8 @@ static int fsl_lbc_ctrl_probe(struct platform_device *dev)
 		goto err;
 	}
 
-	fsl_lbc_ctrl_dev->irq = irq_of_parse_and_map(dev->dev.of_node, 0);
-	if (fsl_lbc_ctrl_dev->irq == NO_IRQ) {
+	fsl_lbc_ctrl_dev->irq[0] = irq_of_parse_and_map(dev->dev.of_node, 0);
+	if (!fsl_lbc_ctrl_dev->irq[0]) {
 		dev_err(&dev->dev, "failed to get irq resource\n");
 		ret = -ENODEV;
 		goto err;
@@ -311,20 +316,34 @@ static int fsl_lbc_ctrl_probe(struct platform_device *dev)
 	if (ret < 0)
 		goto err;
 
-	ret = request_irq(fsl_lbc_ctrl_dev->irq, fsl_lbc_ctrl_irq, 0,
+	ret = request_irq(fsl_lbc_ctrl_dev->irq[0], fsl_lbc_ctrl_irq, 0,
 				"fsl-lbc", fsl_lbc_ctrl_dev);
 	if (ret != 0) {
 		dev_err(&dev->dev, "failed to install irq (%d)\n",
-			fsl_lbc_ctrl_dev->irq);
-		ret = fsl_lbc_ctrl_dev->irq;
+			fsl_lbc_ctrl_dev->irq[0]);
+		ret = fsl_lbc_ctrl_dev->irq[0];
 		goto err;
 	}
 
+	fsl_lbc_ctrl_dev->irq[1] = irq_of_parse_and_map(dev->dev.of_node, 1);
+	if (fsl_lbc_ctrl_dev->irq[1]) {
+		ret = request_irq(fsl_lbc_ctrl_dev->irq[1], fsl_lbc_ctrl_irq,
+				IRQF_SHARED, "fsl-lbc-err", fsl_lbc_ctrl_dev);
+		if (ret) {
+			dev_err(&dev->dev, "failed to install irq (%d)\n",
+					fsl_lbc_ctrl_dev->irq[1]);
+			ret = fsl_lbc_ctrl_dev->irq[1];
+			goto err1;
+		}
+	}
+
 	/* Enable interrupts for any detected events */
 	out_be32(&fsl_lbc_ctrl_dev->regs->lteir, LTEIR_ENABLE);
 
 	return 0;
 
+err1:
+	free_irq(fsl_lbc_ctrl_dev->irq[0], fsl_lbc_ctrl_dev);
 err:
 	iounmap(fsl_lbc_ctrl_dev->regs);
 	kfree(fsl_lbc_ctrl_dev);
-- 
1.8.5
