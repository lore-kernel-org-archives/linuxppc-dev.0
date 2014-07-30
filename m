Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 257C31A01B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 12:22:02 +1000 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <wg@grandegger.com>,
 <mkl@pengutronix.de>, <linux-can@vger.kernel.org>, <B07421@freescale.com>
Subject: [PATCH v7] flexcan: add err_irq handler for flexcan
Date: Wed, 30 Jul 2014 10:17:44 +0800
Message-ID: <1406686664-32716-1-git-send-email-B45475@freescale.com>
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
Changes for v6:
	- move RX_IRQ handling back to flexcan_irq
Changes for v7:
	- seperate err_irq_handling code from rx_irq_handling code and move it to err_irq_handler.

 drivers/net/can/flexcan.c | 73 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f425ec2..12385f8 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -208,6 +208,7 @@ struct flexcan_priv {
 	void __iomem *base;
 	u32 reg_esr;
 	u32 reg_ctrl_default;
+	int err_irq;
 
 	struct clk *clk_ipg;
 	struct clk *clk_per;
@@ -690,6 +691,38 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
 	return work_done;
 }
 
+static irqreturn_t flexcan_err_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->base;
+	u32 reg_ctrl, reg_esr;
+	irqreturn_t ret = IRQ_NONE;
+
+	reg_esr = flexcan_read(&regs->esr);
+	reg_ctrl = flexcan_read(&regs->ctrl);
+
+	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
+		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
+		ret = IRQ_HANDLED;
+	}
+
+	if (reg_esr & FLEXCAN_ESR_ERR_INT)
+		flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK, &regs->ctrl);
+
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	    flexcan_has_and_handle_berr(priv, reg_esr)) {
+		/* The error bits are cleared on read,
+		 * save them for later use.
+		 */
+		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
+		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
+			      &regs->ctrl);
+		napi_schedule(&priv->napi);
+	}
+	return ret;
+}
+
 static irqreturn_t flexcan_irq(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
@@ -698,11 +731,10 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct flexcan_regs __iomem *regs = priv->base;
 	u32 reg_iflag1, reg_esr;
 
-	reg_iflag1 = flexcan_read(&regs->iflag1);
 	reg_esr = flexcan_read(&regs->esr);
-	/* ACK all bus error and state change IRQ sources */
-	if (reg_esr & FLEXCAN_ESR_ALL_INT)
-		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
+	reg_iflag1 = flexcan_read(&regs->iflag1);
+
+	flexcan_err_irq(irq, dev);
 
 	/*
 	 * schedule NAPI in case of:
@@ -710,18 +742,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	 * - state change IRQ
 	 * - bus error IRQ and bus error reporting is activated
 	 */
-	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
-	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    flexcan_has_and_handle_berr(priv, reg_esr)) {
-		/*
-		 * The error bits are cleared on read,
-		 * save them for later use.
-		 */
-		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
+	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
 		flexcan_write(FLEXCAN_IFLAG_DEFAULT &
 			~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
-		       &regs->ctrl);
 		napi_schedule(&priv->napi);
 	}
 
@@ -944,10 +967,17 @@ static int flexcan_open(struct net_device *dev)
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
 
@@ -956,6 +986,9 @@ static int flexcan_open(struct net_device *dev)
 
 	return 0;
 
+ out_free_err_irq:
+	if (priv->err_irq)
+		free_irq(priv->err_irq, dev);
  out_free_irq:
 	free_irq(dev->irq, dev);
  out_close:
@@ -977,6 +1010,9 @@ static int flexcan_close(struct net_device *dev)
 	flexcan_chip_stop(dev);
 
 	free_irq(dev->irq, dev);
+	if (priv->err_irq)
+		free_irq(priv->err_irq, dev);
+
 	clk_disable_unprepare(priv->clk_per);
 	clk_disable_unprepare(priv->clk_ipg);
 
@@ -1099,7 +1135,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct clk *clk_ipg = NULL, *clk_per = NULL;
 	void __iomem *base;
-	int err, irq;
+	int err, irq, err_irq;
 	u32 clock_freq = 0;
 
 	if (pdev->dev.of_node)
@@ -1126,6 +1162,10 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return -ENODEV;
 
+	err_irq = platform_get_irq(pdev, 1);
+	if (err_irq <= 0)
+		err_irq = 0;
+
 	base = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -1149,6 +1189,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	dev->flags |= IFF_ECHO;
 
 	priv = netdev_priv(dev);
+	priv->err_irq = err_irq;
 	priv->can.clock.freq = clock_freq;
 	priv->can.bittiming_const = &flexcan_bittiming_const;
 	priv->can.do_set_mode = flexcan_set_mode;
-- 
1.8.5
