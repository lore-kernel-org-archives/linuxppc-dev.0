Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 182332C0359
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:45:56 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 11/31] net: can: mscan: improve clock API use
Date: Tue,  6 Aug 2013 22:43:51 +0200
Message-Id: <1375821851-31609-12-git-send-email-gsi@denx.de>
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

the .get_clock() callback is run from probe() and might allocate
resources, introduce a .put_clock() callback that is run from remove()
to undo any allocation activities

prepare and enable the clocks in open(), disable and unprepare the
clocks in close() if clocks were acquired during probe(), to not assume
knowledge about which activities are done in probe() and remove()

use devm_get_clk() to lookup the SYS and REF clocks, to have the clocks
put upon device shutdown

store pointers to data structures upon successful allocation already
instead of deferral until complete setup, such that subroutines in the
setup sequence may access those data structures as well to track their
resource acquisition

since clock allocation remains optional, the release callback as well as
the enable/disable calls in open/close are optional as well

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/net/can/mscan/mpc5xxx_can.c |   18 ++++++++++++------
 drivers/net/can/mscan/mscan.c       |   27 ++++++++++++++++++++++++++-
 drivers/net/can/mscan/mscan.h       |    3 +++
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index bc422ba..e59b3a3 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -40,6 +40,7 @@ struct mpc5xxx_can_data {
 	unsigned int type;
 	u32 (*get_clock)(struct platform_device *ofdev, const char *clock_name,
 			 int *mscan_clksrc);
+	void (*put_clock)(struct platform_device *ofdev);
 };
 
 #ifdef CONFIG_PPC_MPC52xx
@@ -180,7 +181,7 @@ static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
 			clockdiv = 1;
 
 		if (!clock_name || !strcmp(clock_name, "sys")) {
-			sys_clk = clk_get(&ofdev->dev, "sys_clk");
+			sys_clk = devm_clk_get(&ofdev->dev, "sys_clk");
 			if (IS_ERR(sys_clk)) {
 				dev_err(&ofdev->dev, "couldn't get sys_clk\n");
 				goto exit_unmap;
@@ -203,7 +204,7 @@ static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
 		}
 
 		if (clocksrc < 0) {
-			ref_clk = clk_get(&ofdev->dev, "ref_clk");
+			ref_clk = devm_clk_get(&ofdev->dev, "ref_clk");
 			if (IS_ERR(ref_clk)) {
 				dev_err(&ofdev->dev, "couldn't get ref_clk\n");
 				goto exit_unmap;
@@ -280,6 +281,8 @@ static int mpc5xxx_can_probe(struct platform_device *ofdev)
 	dev = alloc_mscandev();
 	if (!dev)
 		goto exit_dispose_irq;
+	platform_set_drvdata(ofdev, dev);
+	SET_NETDEV_DEV(dev, &ofdev->dev);
 
 	priv = netdev_priv(dev);
 	priv->reg_base = base;
@@ -296,8 +299,6 @@ static int mpc5xxx_can_probe(struct platform_device *ofdev)
 		goto exit_free_mscan;
 	}
 
-	SET_NETDEV_DEV(dev, &ofdev->dev);
-
 	err = register_mscandev(dev, mscan_clksrc);
 	if (err) {
 		dev_err(&ofdev->dev, "registering %s failed (err=%d)\n",
@@ -305,8 +306,6 @@ static int mpc5xxx_can_probe(struct platform_device *ofdev)
 		goto exit_free_mscan;
 	}
 
-	platform_set_drvdata(ofdev, dev);
-
 	dev_info(&ofdev->dev, "MSCAN at 0x%p, irq %d, clock %d Hz\n",
 		 priv->reg_base, dev->irq, priv->can.clock.freq);
 
@@ -324,10 +323,17 @@ exit_unmap_mem:
 
 static int mpc5xxx_can_remove(struct platform_device *ofdev)
 {
+	const struct of_device_id *match;
+	const struct mpc5xxx_can_data *data;
 	struct net_device *dev = platform_get_drvdata(ofdev);
 	struct mscan_priv *priv = netdev_priv(dev);
 
+	match = of_match_device(mpc5xxx_can_table, &ofdev->dev);
+	data = match ? match->data : NULL;
+
 	unregister_mscandev(dev);
+	if (data && data->put_clock)
+		data->put_clock(ofdev);
 	iounmap(priv->reg_base);
 	irq_dispose_mapping(dev->irq);
 	free_candev(dev);
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index e6b4095..4f998f5 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -573,10 +573,24 @@ static int mscan_open(struct net_device *dev)
 	struct mscan_priv *priv = netdev_priv(dev);
 	struct mscan_regs __iomem *regs = priv->reg_base;
 
+	if (priv->clk_ipg) {
+		ret = clk_prepare_enable(priv->clk_ipg);
+		if (ret)
+			goto exit_retcode;
+	}
+	if (priv->clk_can) {
+		ret = clk_prepare_enable(priv->clk_can);
+		if (ret) {
+			if (priv->clk_ipg)
+				clk_disable_unprepare(priv->clk_ipg);
+			goto exit_retcode;
+		}
+	}
+
 	/* common open */
 	ret = open_candev(dev);
 	if (ret)
-		return ret;
+		goto exit_dis_clock;
 
 	napi_enable(&priv->napi);
 
@@ -604,6 +618,12 @@ exit_free_irq:
 exit_napi_disable:
 	napi_disable(&priv->napi);
 	close_candev(dev);
+exit_dis_clock:
+	if (priv->clk_can)
+		clk_disable_unprepare(priv->clk_can);
+	if (priv->clk_ipg)
+		clk_disable_unprepare(priv->clk_ipg);
+exit_retcode:
 	return ret;
 }
 
@@ -621,6 +641,11 @@ static int mscan_close(struct net_device *dev)
 	close_candev(dev);
 	free_irq(dev->irq, dev);
 
+	if (priv->clk_can)
+		clk_disable_unprepare(priv->clk_can);
+	if (priv->clk_ipg)
+		clk_disable_unprepare(priv->clk_ipg);
+
 	return 0;
 }
 
diff --git a/drivers/net/can/mscan/mscan.h b/drivers/net/can/mscan/mscan.h
index af2ed8b..9c24d60 100644
--- a/drivers/net/can/mscan/mscan.h
+++ b/drivers/net/can/mscan/mscan.h
@@ -21,6 +21,7 @@
 #ifndef __MSCAN_H__
 #define __MSCAN_H__
 
+#include <linux/clk.h>
 #include <linux/types.h>
 
 /* MSCAN control register 0 (CANCTL0) bits */
@@ -283,6 +284,8 @@ struct mscan_priv {
 	unsigned int type; 	/* MSCAN type variants */
 	unsigned long flags;
 	void __iomem *reg_base;	/* ioremap'ed address to registers */
+	struct clk *clk_ipg;	/* clock for registers */
+	struct clk *clk_can;	/* clock for bitrates */
 	u8 shadow_statflg;
 	u8 shadow_canrier;
 	u8 cur_pri;
-- 
1.7.10.4
