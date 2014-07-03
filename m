Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51F321A0004
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 12:26:35 +1000 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <wg@grandegger.com>,
 <mkl@pengutronix.de>, <linux-can@vger.kernel.org>, <B07421@freescale.com>
Subject: [PATCH v5] flexcan: add err_irq handler for flexcan
Date: Thu, 3 Jul 2014 10:23:00 +0800
Message-ID: <1404354180-46431-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

when flexcan is not physically linked, command 'cantest' will
trigger an err_irq, add err_irq handler for it.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
Changes for v2:
	- use a space instead of tab
	- use flexcan_poll_state instead of print
Changes for v3:
	- return IRQ_HANDLED if err is triggered
	- stop transmitted packets when there is an err_interrupt 
Changes for v4:
	- call flexcan_irq 
Changes for v5:
	- move err_int_handling code from flexcan_irq to flexcan_err_irq
	- call flexcan_err_irq from flexcan_irq

 drivers/net/can/flexcan.c | 55 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f425ec2..a12d3a4 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -208,6 +208,7 @@ struct flexcan_priv {
 	void __iomem *base;
 	u32 reg_esr;
 	u32 reg_ctrl_default;
+	int err_irq;
 
 	struct clk *clk_ipg;
 	struct clk *clk_per;
@@ -690,19 +691,22 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
 	return work_done;
 }
 
-static irqreturn_t flexcan_irq(int irq, void *dev_id)
+static irqreturn_t flexcan_err_irq(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
-	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->base;
-	u32 reg_iflag1, reg_esr;
+	u32 reg_ctrl, reg_esr, reg_iflag1;
+	irqreturn_t ret = IRQ_NONE;
 
-	reg_iflag1 = flexcan_read(&regs->iflag1);
 	reg_esr = flexcan_read(&regs->esr);
-	/* ACK all bus error and state change IRQ sources */
-	if (reg_esr & FLEXCAN_ESR_ALL_INT)
+	reg_ctrl = flexcan_read(&regs->ctrl);
+	reg_iflag1 = flexcan_read(&regs->iflag1);
+
+	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
 		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
+		ret = IRQ_HANDLED;
+	}
 
 	/*
 	 * schedule NAPI in case of:
@@ -725,6 +729,23 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		napi_schedule(&priv->napi);
 	}
 
+	if (reg_esr & FLEXCAN_ESR_ERR_INT)
+		flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK, &regs->ctrl);
+
+	return ret;
+}
+
+static irqreturn_t flexcan_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct net_device_stats *stats = &dev->stats;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->base;
+	u32 reg_iflag1;
+
+	reg_iflag1 = flexcan_read(&regs->iflag1);
+
+	flexcan_err_irq(irq, dev);
 	/* FIFO overflow */
 	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
 		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
@@ -944,10 +965,17 @@ static int flexcan_open(struct net_device *dev)
 	if (err)
 		goto out_close;
 
+	if (priv->err_irq) {
+		err = request_irq(priv->err_irq, flexcan_err_irq, IRQF_SHARED,
+				  dev->name, dev);
+		if (err)
+			goto out_free_irq;
+	}
+
 	/* start chip and queuing */
 	err = flexcan_chip_start(dev);
 	if (err)
-		goto out_free_irq;
+		goto out_free_err_irq;
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
@@ -956,6 +984,9 @@ static int flexcan_open(struct net_device *dev)
 
 	return 0;
 
+ out_free_err_irq:
+	if (priv->err_irq)
+		free_irq(priv->err_irq, dev);
  out_free_irq:
 	free_irq(dev->irq, dev);
  out_close:
@@ -977,6 +1008,9 @@ static int flexcan_close(struct net_device *dev)
 	flexcan_chip_stop(dev);
 
 	free_irq(dev->irq, dev);
+	if (priv->err_irq)
+		free_irq(priv->err_irq, dev);
+
 	clk_disable_unprepare(priv->clk_per);
 	clk_disable_unprepare(priv->clk_ipg);
 
@@ -1099,7 +1133,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct clk *clk_ipg = NULL, *clk_per = NULL;
 	void __iomem *base;
-	int err, irq;
+	int err, irq, err_irq;
 	u32 clock_freq = 0;
 
 	if (pdev->dev.of_node)
@@ -1126,6 +1160,10 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return -ENODEV;
 
+	err_irq = platform_get_irq(pdev, 1);
+	if (err_irq <= 0)
+		err_irq = 0;
+
 	base = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -1149,6 +1187,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	dev->flags |= IFF_ECHO;
 
 	priv = netdev_priv(dev);
+	priv->err_irq = err_irq;
 	priv->can.clock.freq = clock_freq;
 	priv->can.bittiming_const = &flexcan_bittiming_const;
 	priv->can.do_set_mode = flexcan_set_mode;
-- 
1.8.5
