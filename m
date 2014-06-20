Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 231481A02BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 12:04:26 +1000 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-can@vger.kernel.org>,
 <wg@grandegger.com>, <mkl@pengutronix.de>, <B07421@freescale.com>
Subject: [PATCH v2 1/2] flexcan: add err_irq handler for flexcan
Date: Fri, 20 Jun 2014 10:01:03 +0800
Message-ID: <1403229664-33912-1-git-send-email-B45475@freescale.com>
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

 drivers/net/can/flexcan.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f425ec2..7432ba4 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -208,6 +208,7 @@ struct flexcan_priv {
 	void __iomem *base;
 	u32 reg_esr;
 	u32 reg_ctrl_default;
+	unsigned int err_irq;
 
 	struct clk *clk_ipg;
 	struct clk *clk_per;
@@ -744,6 +745,23 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t flexcan_err_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->base;
+	u32 reg_ctrl, reg_esr;
+
+	reg_esr = flexcan_read(&regs->esr);
+	reg_ctrl = flexcan_read(&regs->ctrl);
+	if (reg_esr & FLEXCAN_ESR_TX_WRN) {
+		flexcan_write(reg_esr & ~FLEXCAN_ESR_TX_WRN, &regs->esr);
+		flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK, &regs->ctrl);
+		flexcan_poll_state(dev, reg_esr);
+	}
+	return IRQ_HANDLED;
+}
+
 static void flexcan_set_bittiming(struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
@@ -944,6 +962,12 @@ static int flexcan_open(struct net_device *dev)
 	if (err)
 		goto out_close;
 
+	if (priv->err_irq)
+		err = request_irq(priv->err_irq, flexcan_err_irq, IRQF_SHARED,
+				  dev->name, dev);
+	if (err)
+		goto out_close;
+
 	/* start chip and queuing */
 	err = flexcan_chip_start(dev);
 	if (err)
@@ -1099,7 +1123,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct clk *clk_ipg = NULL, *clk_per = NULL;
 	void __iomem *base;
-	int err, irq;
+	int err, irq, err_irq;
 	u32 clock_freq = 0;
 
 	if (pdev->dev.of_node)
@@ -1126,6 +1150,10 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return -ENODEV;
 
+	err_irq = platform_get_irq(pdev, 1);
+	if (err_irq <= 0)
+		err_irq = 0;
+
 	base = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -1149,6 +1177,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	dev->flags |= IFF_ECHO;
 
 	priv = netdev_priv(dev);
+	priv->err_irq = err_irq;
 	priv->can.clock.freq = clock_freq;
 	priv->can.bittiming_const = &flexcan_bittiming_const;
 	priv->can.do_set_mode = flexcan_set_mode;
-- 
1.8.5
