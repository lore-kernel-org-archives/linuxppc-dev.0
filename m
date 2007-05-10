Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6EFDDDEFE
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 13:13:28 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4A3DLoD016280
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 20:13:22 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4A3DKmX023063
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 22:13:20 -0500 (CDT)
Message-ID: <46428E37.7010708@freescale.com>
Date: Thu, 10 May 2007 11:15:03 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH 2/2] 83xx USB platform code rework
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add 831x USB platform setup code and rework 834x USB
platform setup code.  Move USB platform code to usb.c
for different boards with CPU of the same series to share
the USB initialization code.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/platforms/83xx/Kconfig       |    2 +
 arch/powerpc/platforms/83xx/Makefile      |    2 +-
 arch/powerpc/platforms/83xx/mpc8313_rdb.c |    1 +
 arch/powerpc/platforms/83xx/mpc834x_mds.c |   47 +-------
 arch/powerpc/platforms/83xx/mpc83xx.h     |   28 ++++-
 arch/powerpc/platforms/83xx/usb.c         |  174 +++++++++++++++++++++++++++++
 6 files changed, 207 insertions(+), 47 deletions(-)
 create mode 100644 arch/powerpc/platforms/83xx/usb.c

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 713b31a..9cb4d88 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -51,6 +51,7 @@ config PPC_MPC831x
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
+	select USB_EHCI_FSL
 	default y if MPC8313_RDB
 
 config PPC_MPC832x
@@ -63,6 +64,7 @@ config MPC834x
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
+	select USB_EHCI_FSL
 	default y if MPC834x_MDS || MPC834x_ITX
 
 config PPC_MPC836x
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index dfc970d..77712cb 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the PowerPC 83xx linux kernel.
 #
-obj-y				:= misc.o
+obj-y				:= misc.o usb.o
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_MPC8313_RDB)	+= mpc8313_rdb.o
 obj-$(CONFIG_MPC834x_MDS)	+= mpc834x_mds.o
diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
index 96970ac..a404910 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -53,6 +53,7 @@ static void __init mpc8313_rdb_setup_arch(void)
 
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
+	mpc831x_usb_cfg();
 }
 
 void __init mpc8313_rdb_init_IRQ(void)
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 10394b2..d6bee69 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -44,55 +44,15 @@ unsigned long isa_mem_base = 0;
 #endif
 
 #define BCSR5_INT_USB		0x02
-/* Note: This is only for PB, not for PB+PIB
- * On PB only port0 is connected using ULPI */
-static int mpc834x_usb_cfg(void)
+static int mpc834xemds_usb_cfg(void)
 {
-	unsigned long sccr, sicrl;
-	void __iomem *immap;
+	struct device_node *np;
 	void __iomem *bcsr_regs = NULL;
 	u8 bcsr5;
-	struct device_node *np = NULL;
-	int port0_is_dr = 0;
-
-	if ((np = of_find_compatible_node(NULL, "usb", "fsl-usb2-dr")) != NULL)
-		port0_is_dr = 1;
-	if ((np = of_find_compatible_node(NULL, "usb", "fsl-usb2-mph")) != NULL){
-		if (port0_is_dr) {
-			printk(KERN_WARNING
-				"There is only one USB port on PB board! \n");
-			return -1;
-		} else if (!port0_is_dr)
-			/* No usb port enabled */
-			return -1;
-	}
-
-	immap = ioremap(get_immrbase(), 0x1000);
-	if (!immap)
-		return -1;
-
-	/* Configure clock */
-	sccr = in_be32(immap + MPC83XX_SCCR_OFFS);
-	if (port0_is_dr)
-		sccr |= MPC83XX_SCCR_USB_DRCM_11;  /* 1:3 */
-	else
-		sccr |= MPC83XX_SCCR_USB_MPHCM_11; /* 1:3 */
-	out_be32(immap + MPC83XX_SCCR_OFFS, sccr);
-
-	/* Configure Pin */
-	sicrl = in_be32(immap + MPC83XX_SICRL_OFFS);
-	/* set port0 only */
-	if (port0_is_dr)
-		sicrl |= MPC83XX_SICRL_USB0;
-	else
-		sicrl &= ~(MPC83XX_SICRL_USB0);
-	out_be32(immap + MPC83XX_SICRL_OFFS, sicrl);
-
-	iounmap(immap);
 
 	/* Map BCSR area */
 	np = of_find_node_by_name(NULL, "bcsr");
-	if (np != 0) {
+	if (np) {
 		struct resource res;
 
 		of_address_to_resource(np, 0, &res);
@@ -135,6 +95,7 @@ static void __init mpc834x_mds_setup_arch(void)
 #endif
 
 	mpc834x_usb_cfg();
+	mpc834xemds_usb_cfg();
 }
 
 static void __init mpc834x_mds_init_IRQ(void)
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 9cd03b5..a44e5b1 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -6,6 +6,7 @@
 
 /* System Clock Control Register */
 #define MPC83XX_SCCR_OFFS          0xA08
+#define MPC83XX_SCCR_USB_MASK      0x00f00000
 #define MPC83XX_SCCR_USB_MPHCM_11  0x00c00000
 #define MPC83XX_SCCR_USB_MPHCM_01  0x00400000
 #define MPC83XX_SCCR_USB_MPHCM_10  0x00800000
@@ -15,12 +16,31 @@
 
 /* system i/o configuration register low */
 #define MPC83XX_SICRL_OFFS         0x114
-#define MPC83XX_SICRL_USB0         0x40000000
-#define MPC83XX_SICRL_USB1         0x20000000
+#define MPC834X_SICRL_USB_MASK     0x60000000
+#define MPC834X_SICRL_USB0         0x40000000
+#define MPC834X_SICRL_USB1         0x20000000
+#define MPC831X_SICRL_USB_MASK     0x00000c00
+#define MPC831X_SICRL_USB_ULPI     0x00000800
 
 /* system i/o configuration register high */
 #define MPC83XX_SICRH_OFFS         0x118
-#define MPC83XX_SICRH_USB_UTMI     0x00020000
+#define MPC834X_SICRH_USB_UTMI     0x00020000
+#define MPC831X_SICRH_USB_MASK     0x000000e0
+#define MPC831X_SICRH_USB_ULPI     0x000000a0
+
+/* USB Control Register */
+#define FSL_USB2_CONTROL_OFFS      0x500
+#define CONTROL_UTMI_PHY_EN        0x00000200
+#define CONTROL_REFSEL_48MHZ       0x00000080
+#define CONTROL_PHY_CLK_SEL_ULPI   0x00000400
+#define CONTROL_OTG_PORT           0x00000020
+
+/* USB PORTSC Registers */
+#define FSL_USB2_PORTSC1_OFFS      0x184
+#define FSL_USB2_PORTSC2_OFFS      0x188
+#define PORTSCX_PTW_16BIT          0x10000000
+#define PORTSCX_PTS_UTMI           0x00000000
+#define PORTSCX_PTS_ULPI           0x80000000
 
 /*
  * Declaration for the various functions exported by the
@@ -31,5 +51,7 @@ extern int add_bridge(struct device_node *dev);
 extern int mpc83xx_exclude_device(u_char bus, u_char devfn);
 extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
+extern int mpc834x_usb_cfg(void);
+extern int mpc831x_usb_cfg(void);
 
 #endif				/* __MPC83XX_H__ */
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
new file mode 100644
index 0000000..4c2511c
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -0,0 +1,174 @@
+/*
+ * Freescale 83xx USB SOC setup code
+ *
+ * Copyright (C) 2007 Freescale Semiconductor, Inc.
+ * Author: Li Yang
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <sysdev/fsl_soc.h>
+
+#include "mpc83xx.h"
+
+
+#ifdef CONFIG_MPC834x
+int mpc834x_usb_cfg(void)
+{
+	unsigned long sccr, sicrl, sicrh;
+	void __iomem *immap;
+	struct device_node *np = NULL;
+	int port0_is_dr = 0, port1_is_dr = 0;
+	const void *prop;
+
+	immap = ioremap(get_immrbase(), 0x1000);
+	if (!immap)
+		return -ENOMEM;
+
+	/* Read registers */
+	/* Note: DR and MPH must use the same clock setting in SCCR */
+	sccr = in_be32(immap + MPC83XX_SCCR_OFFS) & ~MPC83XX_SCCR_USB_MASK;
+	sicrl = in_be32(immap + MPC83XX_SICRL_OFFS) & ~MPC834X_SICRL_USB_MASK;
+	sicrh = in_be32(immap + MPC83XX_SICRH_OFFS) & ~MPC834X_SICRH_USB_UTMI;
+
+	if ((np = of_find_compatible_node(NULL, "usb", "fsl-usb2-dr"))
+				!= NULL) {
+		sccr |= MPC83XX_SCCR_USB_DRCM_11;  /* 1:3 */
+
+		prop = get_property(np, "phy_type", NULL);
+		if (prop && (!strcmp(prop, "utmi") ||
+					!strcmp(prop, "utmi_wide"))) {
+			sicrl |= MPC834X_SICRL_USB0 | MPC834X_SICRL_USB1;
+			sicrh |= MPC834X_SICRH_USB_UTMI;
+			port1_is_dr = 1;
+		} else if (prop && !strcmp(prop, "serial")) {
+			if (!strcmp(get_property(np, "dr_mode", NULL), "otg")) {
+				sicrl |= MPC834X_SICRL_USB0 | MPC834X_SICRL_USB1;
+				port1_is_dr = 1;
+			} else {
+				sicrl |= MPC834X_SICRL_USB0;
+			}
+		} else if (prop && !strcmp(prop, "ulpi")) {
+			sicrl |= MPC834X_SICRL_USB0;
+		} else {
+			printk(KERN_WARNING "834x USB PHY type not supported\n");
+		}
+		port0_is_dr = 1;
+		of_node_put(np);
+	}
+	if ((np = of_find_compatible_node(NULL, "usb", "fsl-usb2-mph"))
+				!= NULL) {
+		sccr |= MPC83XX_SCCR_USB_MPHCM_11; /* 1:3 */
+
+		prop = get_property(np, "port0", NULL);
+		if (prop) {
+			if (port0_is_dr)
+				printk(KERN_WARNING
+					"834x USB port0 can't be used by both DR and MPH!\n");
+			sicrl |= MPC834X_SICRL_USB0;
+		}
+		prop = get_property(np, "port1", NULL);
+		if (prop) {
+			if (port1_is_dr)
+				printk(KERN_WARNING
+					"834x USB port1 can't be used by both DR and MPH!\n");
+			sicrl |= MPC834X_SICRL_USB1;
+		}
+		of_node_put(np);
+	}
+
+	/* Write back */
+	out_be32(immap + MPC83XX_SCCR_OFFS, sccr);
+	out_be32(immap + MPC83XX_SICRL_OFFS, sicrl);
+	out_be32(immap + MPC83XX_SICRH_OFFS, sicrh);
+
+	iounmap(immap);
+	return 0;
+}
+#endif /* CONFIG_MPC834x */
+
+#ifdef CONFIG_PPC_MPC831x
+int mpc831x_usb_cfg(void)
+{
+	u32 temp;
+	void __iomem *immap, *usb_regs;
+	struct device_node *np = NULL;
+	const void *prop;
+	struct resource res;
+	int ret = 0;
+
+	if ((np = of_find_compatible_node(NULL, "usb", "fsl-usb2-dr")) == NULL)
+		return -ENODEV;
+	prop = get_property(np, "phy_type", NULL);
+
+	/* Map IMMR space for pin and clock settings */
+	immap = ioremap(get_immrbase(), 0x1000);
+	if (!immap) {
+		of_node_put(np);
+		return -ENOMEM;
+	}
+
+	/* Configure clock */
+	temp = in_be32(immap + MPC83XX_SCCR_OFFS);
+	temp &= ~MPC83XX_SCCR_USB_MASK;
+	temp |= MPC83XX_SCCR_USB_DRCM_11;  /* 1:3 */
+	out_be32(immap + MPC83XX_SCCR_OFFS, temp);
+
+	/* Configure pin mux for ULPI.  There is no pin mux for UTMI */
+	if (!strcmp(prop, "ulpi")) {
+		temp = in_be32(immap + MPC83XX_SICRL_OFFS);
+		temp &= ~MPC831X_SICRL_USB_MASK;
+		temp |= MPC831X_SICRL_USB_ULPI;
+		out_be32(immap + MPC83XX_SICRL_OFFS, temp);
+
+		temp = in_be32(immap + MPC83XX_SICRH_OFFS);
+		temp &= ~MPC831X_SICRH_USB_MASK;
+		temp |= MPC831X_SICRH_USB_ULPI;
+		out_be32(immap + MPC83XX_SICRH_OFFS, temp);
+	}
+
+	iounmap(immap);
+
+	/* Map USB SOC space */
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret) {
+		of_node_put(np);
+		return ret;
+	}
+	usb_regs = ioremap(res.start, res.end - res.start + 1);
+
+	/* Using on-chip PHY */
+	if (!strcmp(prop, "utmi_wide") ||
+			!strcmp(prop, "utmi")) {
+		/* Set UTMI_PHY_EN, REFSEL to 48MHZ */
+		out_be32(usb_regs + FSL_USB2_CONTROL_OFFS,
+				CONTROL_UTMI_PHY_EN | CONTROL_REFSEL_48MHZ);
+	/* Using external UPLI PHY */
+	} else if (!strcmp(prop, "ulpi")) {
+		/* Set PHY_CLK_SEL to ULPI */
+		temp = CONTROL_PHY_CLK_SEL_ULPI;
+#ifdef CONFIG_USB_OTG
+		/* Set OTG_PORT */
+		temp |= CONTROL_OTG_PORT;
+#endif /* CONFIG_USB_OTG */
+		out_be32(usb_regs + FSL_USB2_CONTROL_OFFS, temp);
+	} else {
+		printk(KERN_WARNING "831x USB PHY type not supported\n");
+		ret = -EINVAL;
+	}
+
+	iounmap(usb_regs);
+	of_node_put(np);
+	return ret;
+}
+#endif /* CONFIG_PPC_MPC831x */
