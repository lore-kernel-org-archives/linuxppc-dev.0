Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 055EA2C0275
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:45:17 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 06/31] i2c: mpc: cleanup clock API use
Date: Tue,  6 Aug 2013 22:43:46 +0200
Message-Id: <1375821851-31609-7-git-send-email-gsi@denx.de>
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

make the MPC I2C driver get, prepare and enable the peripheral clock
during probe ('per' for access to the peripheral's registers); disable
and unprepare the clock upon remove(), put is done by the devm approach;
hold a reference to the clock over the period of use

clock lookup is non-fatal in this implementation as not all platforms
may provide clock specs in their device tree, but enable errors for
specified clocks are considered fatal

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/i2c/busses/i2c-mpc.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 7607dc0..4b00dd0 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -21,6 +21,7 @@
 #include <linux/of_i2c.h>
 #include <linux/slab.h>
 
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/fsl_devices.h>
 #include <linux/i2c.h>
@@ -67,6 +68,7 @@ struct mpc_i2c {
 #ifdef CONFIG_PM
 	u8 fdr, dfsrr;
 #endif
+	struct clk *clk_per;
 };
 
 struct mpc_i2c_divider {
@@ -623,6 +625,8 @@ static int fsl_i2c_probe(struct platform_device *op)
 	u32 clock = MPC_I2C_CLOCK_LEGACY;
 	int result = 0;
 	int plen;
+	struct clk *clk;
+	int err;
 
 	match = of_match_device(mpc_i2c_of_match, &op->dev);
 	if (!match)
@@ -653,6 +657,21 @@ static int fsl_i2c_probe(struct platform_device *op)
 		}
 	}
 
+	/*
+	 * enable clock for the I2C peripheral (non fatal),
+	 * keep a reference upon successful allocation
+	 */
+	clk = devm_clk_get(&op->dev, "per");
+	if (!IS_ERR(clk)) {
+		err = clk_prepare_enable(clk);
+		if (err) {
+			dev_err(&op->dev, "failed to enable clock\n");
+			goto fail_request;
+		} else {
+			i2c->clk_per = clk;
+		}
+	}
+
 	if (of_get_property(op->dev.of_node, "fsl,preserve-clocking", NULL)) {
 		clock = MPC_I2C_CLOCK_PRESERVE;
 	} else {
@@ -696,6 +715,8 @@ static int fsl_i2c_probe(struct platform_device *op)
 	return result;
 
  fail_add:
+	if (i2c->clk_per)
+		clk_disable_unprepare(i2c->clk_per);
 	free_irq(i2c->irq, i2c);
  fail_request:
 	irq_dispose_mapping(i2c->irq);
@@ -711,6 +732,9 @@ static int fsl_i2c_remove(struct platform_device *op)
 
 	i2c_del_adapter(&i2c->adap);
 
+	if (i2c->clk_per)
+		clk_disable_unprepare(i2c->clk_per);
+
 	if (i2c->irq)
 		free_irq(i2c->irq, i2c);
 
-- 
1.7.10.4
