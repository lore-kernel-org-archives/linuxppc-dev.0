Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 69E3CB7D43
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 07:24:23 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/11] i2c-mpc: Add MPC5121 I2C bus support
Date: Tue, 19 Jan 2010 21:24:06 +0100
Message-Id: <1263932653-3634-5-git-send-email-agust@denx.de>
In-Reply-To: <1263932653-3634-1-git-send-email-agust@denx.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
Cc: wd@denx.de, dzu@denx.de, linux-i2c@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Piotr Ziecik <kosmo@semihalf.com>

    - Update Kconfig for i2c-mpc driver.
    - Enable I2C interrupts on MPC5121.

Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: <linux-i2c@vger.kernel.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
 drivers/i2c/busses/Kconfig   |    9 +++++----
 drivers/i2c/busses/i2c-mpc.c |   23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 5f318ce..f481f30 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -418,13 +418,14 @@ config I2C_IXP2000
 	  instead.
 
 config I2C_MPC
-	tristate "MPC107/824x/85xx/52xx/86xx"
+	tristate "MPC107/824x/85xx/512x/52xx/86xx"
 	depends on PPC32
 	help
 	  If you say yes to this option, support will be included for the
-	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
-	  MPC85xx/MPC8641 family processors. The driver may also work on 52xx
-	  family processors, though interrupts are known not to work.
+	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245,
+	  MPC85xx/MPC8641 and MPC512x family processors. The driver may
+	  also work on 52xx family processors, though interrupts are known
+	  not to work.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mpc.
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index f627001..84eeb25 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -540,6 +540,29 @@ static int __devinit fsl_i2c_probe(struct of_device *op,
 		}
 	}
 
+	if (of_device_is_compatible(op->node, "fsl,mpc5121-i2c")) {
+		struct device_node *np;
+		void __iomem *i2cctl;
+
+		/* Enable I2C interrupts */
+		np = of_find_compatible_node(NULL, NULL,
+					     "fsl,mpc5121-i2c-ctrl");
+		if (np) {
+			i2cctl = of_iomap(np, 0);
+			if (i2cctl) {
+				/*
+				 * Set interrupt enable bits:
+				 *  - I2C-0: bit 24,
+				 *  - I2C-1: bit 26,
+				 *  - I2C-2: bit 28.
+				 */
+				out_be32(i2cctl, 0x15000000);
+				iounmap(i2cctl);
+			}
+			of_node_put(np);
+		}
+	}
+
 	dev_set_drvdata(&op->dev, i2c);
 
 	i2c->adap = mpc_ops;
-- 
1.5.6.3
