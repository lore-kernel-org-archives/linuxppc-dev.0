Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 3DAD1DDDA2
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:15:28 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/12] mpc5121: Added I2C support.
Date: Wed,  6 May 2009 22:15:15 +0200
Message-Id: <1241640919-4650-9-git-send-email-wd@denx.de>
In-Reply-To: <1241640919-4650-1-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
Cc: linux-i2c@vger.kernel.org, Piotr Ziecik <kosmo@semihalf.com>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Piotr Ziecik <kosmo@semihalf.com>

- Enabled I2C interrupts on MPC5121.
- Updated Kconfig for i2c-mpc driver.

Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: <linux-i2c@vger.kernel.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
 arch/powerpc/platforms/512x/mpc5121_ads.c    |    2 ++
 arch/powerpc/platforms/512x/mpc512x.h        |    1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c |   24 ++++++++++++++++++++++++
 drivers/i2c/busses/Kconfig                   |    9 +++++----
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 441abc4..a8976b4 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -42,6 +42,8 @@ static void __init mpc5121_ads_setup_arch(void)
 	for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
 		mpc83xx_add_bridge(np);
 #endif
+
+	mpc512x_init_i2c();
 }
 
 static void __init mpc5121_ads_init_IRQ(void)
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index 9c03693..f4db8a7 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -13,5 +13,6 @@
 #define __MPC512X_H__
 extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
 extern void __init mpc512x_init_IRQ(void);
+extern void __init mpc512x_init_i2c(void);
 void __init mpc512x_declare_of_platform_devices(void);
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 7135d89..b776e45 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -65,6 +65,30 @@ void __init mpc512x_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
+void __init mpc512x_init_i2c(void)
+{
+	struct device_node *np;
+	void __iomem *i2cctl;
+
+	/* Enable I2C interrupts */
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-i2c-ctrl");
+	if (np) {
+		i2cctl = of_iomap(np, 0);
+		if (i2cctl) {
+			/*
+			 * Set interrupt enable bits:
+			 *  - I2C-0: bit 24,
+			 *  - I2C-1: bit 26,
+			 *  - I2C-2: bit 28.
+			 */
+			out_be32(i2cctl, 0x15000000);
+			iounmap(i2cctl);
+		}
+
+		of_node_put(np);
+	}
+}
+
 /*
  * Nodes to do bus probe on, soc and localbus
  */
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index a48c8ae..57ed637 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -391,13 +391,14 @@ config I2C_IXP2000
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
-- 
1.6.0.6
