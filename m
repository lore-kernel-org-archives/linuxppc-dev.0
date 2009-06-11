Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7E071B7237
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 06:19:13 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6C942DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 06:19:12 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc5xxx_get_bus_frequency(): use common code on MPC512x and
	MPC52xx
Date: Thu, 11 Jun 2009 22:19:02 +0200
Message-Id: <1244751543-21977-1-git-send-email-wd@denx.de>
In-Reply-To: <fa686aa40906080737h64bad3cfv32155e5b819d650b@mail.gmail.com>
References: <fa686aa40906080737h64bad3cfv32155e5b819d650b@mail.gmail.com>
Cc: Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So far, MPC512x used mpc512x_find_ips_freq() to get the bus frequency,
while MPC52xx used mpc52xx_find_ipb_freq().  Despite the different
clock names (IPS vs. IPB) the code was identical.

Use common code for both processor families.

Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Kumar Gala <galak@kernel.crashing.org>
---

This patch is not only intended to avoid code duplication, but it
will be needed in a following patch that fixes a MII speed
miscalculation in drivers/net/fs_enet/mii-fec.c - this patch allows
for a clean solution that works both on MPC512x and MPC52x systems.

 arch/powerpc/include/asm/mpc512x.h           |   22 -----------------
 arch/powerpc/include/asm/mpc52xx.h           |    2 +-
 arch/powerpc/include/asm/mpc5xxx.h           |   22 +++++++++++++++++
 arch/powerpc/platforms/512x/clock.c          |    2 +-
 arch/powerpc/platforms/512x/mpc512x.h        |    1 -
 arch/powerpc/platforms/512x/mpc512x_shared.c |   23 ------------------
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   32 +------------------------
 arch/powerpc/sysdev/Makefile                 |    3 ++
 arch/powerpc/sysdev/mpc5xxx_clocks.c         |   33 ++++++++++++++++++++++++++
 drivers/ata/pata_mpc52xx.c                   |    2 +-
 drivers/i2c/busses/i2c-mpc.c                 |    2 +-
 drivers/net/fec_mpc52xx.c                    |    2 +-
 drivers/net/fec_mpc52xx_phy.c                |    2 +-
 drivers/serial/mpc52xx_uart.c                |    5 +--
 drivers/watchdog/mpc5200_wdt.c               |    2 +-
 15 files changed, 68 insertions(+), 87 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/mpc512x.h
 create mode 100644 arch/powerpc/include/asm/mpc5xxx.h
 create mode 100644 arch/powerpc/sysdev/mpc5xxx_clocks.c

diff --git a/arch/powerpc/include/asm/mpc512x.h b/arch/powerpc/include/asm/mpc512x.h
deleted file mode 100644
index c48a165..0000000
--- a/arch/powerpc/include/asm/mpc512x.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
- *
- * Author: John Rigby, <jrigby@freescale.com>, Friday Apr 13 2007
- *
- * Description:
- * MPC5121 Prototypes and definitions
- *
- * This is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-
-#ifndef __ASM_POWERPC_MPC512x_H__
-#define __ASM_POWERPC_MPC512x_H__
-
-extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
-
-#endif /* __ASM_POWERPC_MPC512x_H__ */
-
diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index 52e049c..1b4f697 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -16,6 +16,7 @@
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 #include <asm/prom.h>
+#include <asm/mpc5xxx.h>
 #endif /* __ASSEMBLY__ */
 
 #include <linux/suspend.h>
@@ -268,7 +269,6 @@ struct mpc52xx_intr {
 #ifndef __ASSEMBLY__
 
 /* mpc52xx_common.c */
-extern unsigned int mpc52xx_find_ipb_freq(struct device_node *node);
 extern void mpc5200_setup_xlb_arbiter(void);
 extern void mpc52xx_declare_of_platform_devices(void);
 extern void mpc52xx_map_common_devices(void);
diff --git a/arch/powerpc/include/asm/mpc5xxx.h b/arch/powerpc/include/asm/mpc5xxx.h
new file mode 100644
index 0000000..5ce9c5f
--- /dev/null
+++ b/arch/powerpc/include/asm/mpc5xxx.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: John Rigby, <jrigby@freescale.com>, Friday Apr 13 2007
+ *
+ * Description:
+ * MPC5xxx Prototypes and definitions
+ *
+ * This is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef __ASM_POWERPC_MPC5xxx_H__
+#define __ASM_POWERPC_MPC5xxx_H__
+
+extern unsigned long mpc5xxx_get_bus_frequency(struct device_node *node);
+
+#endif /* __ASM_POWERPC_MPC5xxx_H__ */
+
diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index 1bcff94..f4c4c6f 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -24,7 +24,7 @@
 #include <linux/io.h>
 
 #include <linux/of_platform.h>
-#include <asm/mpc512x.h>
+#include <asm/mpc5xxx.h>
 #include <asm/clk_interface.h>
 
 #undef CLK_DEBUG
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index 9c03693..22a5352 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -11,7 +11,6 @@
 
 #ifndef __MPC512X_H__
 #define __MPC512X_H__
-extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
 extern void __init mpc512x_init_IRQ(void);
 void __init mpc512x_declare_of_platform_devices(void);
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index d8cd579..434d683 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -24,29 +24,6 @@
 
 #include "mpc512x.h"
 
-unsigned long
-mpc512x_find_ips_freq(struct device_node *node)
-{
-	struct device_node *np;
-	const unsigned int *p_ips_freq = NULL;
-
-	of_node_get(node);
-	while (node) {
-		p_ips_freq = of_get_property(node, "bus-frequency", NULL);
-		if (p_ips_freq)
-			break;
-
-		np = of_get_parent(node);
-		of_node_put(node);
-		node = np;
-	}
-	if (node)
-		of_node_put(node);
-
-	return p_ips_freq ? *p_ips_freq : 0;
-}
-EXPORT_SYMBOL(mpc512x_find_ips_freq);
-
 void __init mpc512x_init_IRQ(void)
 {
 	struct device_node *np;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 8e3dd5a..a46bad0 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -47,36 +47,6 @@ static DEFINE_SPINLOCK(mpc52xx_lock);
 static struct mpc52xx_gpt __iomem *mpc52xx_wdt;
 static struct mpc52xx_cdm __iomem *mpc52xx_cdm;
 
-/**
- * 	mpc52xx_find_ipb_freq - Find the IPB bus frequency for a device
- * 	@node:	device node
- *
- * 	Returns IPB bus frequency, or 0 if the bus frequency cannot be found.
- */
-unsigned int
-mpc52xx_find_ipb_freq(struct device_node *node)
-{
-	struct device_node *np;
-	const unsigned int *p_ipb_freq = NULL;
-
-	of_node_get(node);
-	while (node) {
-		p_ipb_freq = of_get_property(node, "bus-frequency", NULL);
-		if (p_ipb_freq)
-			break;
-
-		np = of_get_parent(node);
-		of_node_put(node);
-		node = np;
-	}
-	if (node)
-		of_node_put(node);
-
-	return p_ipb_freq ? *p_ipb_freq : 0;
-}
-EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
-
-
 /*
  * Configure the XLB arbiter settings to match what Linux expects.
  */
@@ -221,7 +191,7 @@ unsigned int mpc52xx_get_xtal_freq(struct device_node *node)
 	if (!mpc52xx_cdm)
 		return 0;
 
-	freq = mpc52xx_find_ipb_freq(node);
+	freq = mpc5xxx_get_bus_frequency(node);
 	if (!freq)
 		return 0;
 
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index b33b28a..2a1df88 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -47,6 +47,9 @@ obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_8xx)		+= mpc8xx_pic.o cpm1.o
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
 
+obj-$(CONFIG_PPC_MPC512x)	+= mpc5xxx_clocks.o
+obj-$(CONFIG_PPC_MPC52xx)	+= mpc5xxx_clocks.o
+
 ifeq ($(CONFIG_SUSPEND),y)
 obj-$(CONFIG_6xx)		+= 6xx-suspend.o
 endif
diff --git a/arch/powerpc/sysdev/mpc5xxx_clocks.c b/arch/powerpc/sysdev/mpc5xxx_clocks.c
new file mode 100644
index 0000000..34e12f9
--- /dev/null
+++ b/arch/powerpc/sysdev/mpc5xxx_clocks.c
@@ -0,0 +1,33 @@
+/**
+ * 	mpc5xxx_get_bus_frequency - Find the bus frequency for a device
+ * 	@node:	device node
+ *
+ * 	Returns bus frequency (IPS on MPC512x, IPB on MPC52xx),
+ * 	or 0 if the bus frequency cannot be found.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+
+unsigned int
+mpc5xxx_get_bus_frequency(struct device_node *node)
+{
+	struct device_node *np;
+	const unsigned int *p_bus_freq = NULL;
+
+	of_node_get(node);
+	while (node) {
+		p_bus_freq = of_get_property(node, "bus-frequency", NULL);
+		if (p_bus_freq)
+			break;
+
+		np = of_get_parent(node);
+		of_node_put(node);
+		node = np;
+	}
+	if (node)
+		of_node_put(node);
+
+	return p_bus_freq ? *p_bus_freq : 0;
+}
+EXPORT_SYMBOL(mpc5xxx_get_bus_frequency);
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 68d27bc..2bc2dbe 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -694,7 +694,7 @@ mpc52xx_ata_probe(struct of_device *op, const struct of_device_id *match)
 	struct bcom_task *dmatsk = NULL;
 
 	/* Get ipb frequency */
-	ipb_freq = mpc52xx_find_ipb_freq(op->node);
+	ipb_freq = mpc5xxx_get_bus_frequency(op->node);
 	if (!ipb_freq) {
 		dev_err(&op->dev, "could not determine IPB bus frequency\n");
 		return -ENODEV;
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index dd778d7..d325e86 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -197,7 +197,7 @@ int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int prescaler)
 		return -EINVAL;
 
 	/* Determine divider value */
-	divider = mpc52xx_find_ipb_freq(node) / clock;
+	divider = mpc5xxx_get_bus_frequency(node) / clock;
 
 	/*
 	 * We want to choose an FDR/DFSR that generates an I2C bus speed that
diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index 8bbe7f6..5ddf033 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -1006,7 +1006,7 @@ mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
 	priv->phy_addr = FEC5200_PHYADDR_NONE;
 	priv->speed = 100;
 	priv->duplex = DUPLEX_HALF;
-	priv->phy_speed = ((mpc52xx_find_ipb_freq(op->node) >> 20) / 5) << 1;
+	priv->phy_speed = ((mpc5xxx_get_bus_frequency(op->node) >> 20) / 5) << 1;
 
 	/* the 7-wire property means don't use MII mode */
 	if (of_find_property(op->node, "fsl,7-wire-mode", NULL))
diff --git a/drivers/net/fec_mpc52xx_phy.c b/drivers/net/fec_mpc52xx_phy.c
index dd9bfa4..176e9b8 100644
--- a/drivers/net/fec_mpc52xx_phy.c
+++ b/drivers/net/fec_mpc52xx_phy.c
@@ -120,7 +120,7 @@ static int mpc52xx_fec_mdio_probe(struct of_device *of,
 
 	/* set MII speed */
 	out_be32(&priv->regs->mii_speed,
-		((mpc52xx_find_ipb_freq(of->node) >> 20) / 5) << 1);
+		((mpc5xxx_get_bus_frequency(of->node) >> 20) / 5) << 1);
 
 	err = mdiobus_register(bus);
 	if (err)
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index b3feb61..abbd146 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -76,7 +76,6 @@
 #include <linux/of_platform.h>
 
 #include <asm/mpc52xx.h>
-#include <asm/mpc512x.h>
 #include <asm/mpc52xx_psc.h>
 
 #if defined(CONFIG_SERIAL_MPC52xx_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
@@ -254,7 +253,7 @@ static unsigned long mpc52xx_getuartclk(void *p)
 	 * but the generic serial code assumes 16
 	 * so return ipb freq / 2
 	 */
-	return mpc52xx_find_ipb_freq(p) / 2;
+	return mpc5xxx_get_bus_frequency(p) / 2;
 }
 
 static struct psc_ops mpc52xx_psc_ops = {
@@ -391,7 +390,7 @@ static void mpc512x_psc_cw_restore_ints(struct uart_port *port)
 
 static unsigned long mpc512x_getuartclk(void *p)
 {
-	return mpc512x_find_ips_freq(p);
+	return mpc5xxx_get_bus_frequency(p);
 }
 
 static struct psc_ops mpc512x_psc_ops = {
diff --git a/drivers/watchdog/mpc5200_wdt.c b/drivers/watchdog/mpc5200_wdt.c
index 465fe36..fa9c47c 100644
--- a/drivers/watchdog/mpc5200_wdt.c
+++ b/drivers/watchdog/mpc5200_wdt.c
@@ -188,7 +188,7 @@ static int mpc5200_wdt_probe(struct of_device *op,
 	if (!wdt)
 		return -ENOMEM;
 
-	wdt->ipb_freq = mpc52xx_find_ipb_freq(op->node);
+	wdt->ipb_freq = mpc5xxx_get_bus_frequency(op->node);
 
 	err = of_address_to_resource(op->node, 0, &wdt->mem);
 	if (err)
-- 
1.6.0.6
