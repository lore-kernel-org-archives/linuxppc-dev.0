Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B2D51DDEC9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 16:46:47 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l175kiEE014278
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 22:46:44 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l175kfIf005718
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 23:46:42 -0600 (CST)
Message-ID: <45C9680C.6030601@freescale.com>
Date: Wed, 07 Feb 2007 13:47:56 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH 1/3] add USB setup code for 8349emds PB
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

Add board specific initialization code for USB
to work in both MPH and DR mode for MPC8349EMDS
PB board.

Signed-off-by: Li Yang <leoli@freescale.com> 
---
 arch/powerpc/platforms/83xx/mpc834x_sys.c |   74 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc834x_sys.h |    2 +
 arch/powerpc/platforms/83xx/mpc83xx.h     |   18 +++++++
 3 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.c b/arch/powerpc/platforms/83xx/mpc834x_sys.c
index 80b735a..3d20360 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_sys.c
@@ -35,14 +35,85 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
+#include <linux/fsl_devices.h>
 
 #include "mpc83xx.h"
+#include "mpc834x_sys.h"
 
 #ifndef CONFIG_PCI
 unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
 #endif
 
+/* Note: This is only for PB, not for PB+PIB
+ * On PB only port0 is connected using ULPI */
+static int mpc834x_usb_cfg(void)
+{
+	unsigned long sccr, sicrl;
+	void __iomem *immap;
+	void __iomem *bcsr_regs = NULL;
+	u8 bcsr5;
+	struct device_node *np = NULL;
+	int port0_is_dr = 0;
+
+	if ((np = of_find_compatible_node(np, "usb", "fsl-usb2-dr")) != NULL)
+		port0_is_dr = 1;
+	if ((np = of_find_compatible_node(np, "usb", "fsl-usb2-mph")) != NULL){
+		if (port0_is_dr) {
+			printk(KERN_WARNING
+				"There is only one USB port on PB board! \n");
+			return -1;
+		} else if (!port0_is_dr)
+			/* No usb port enabled */
+			return -1;
+	}
+
+	immap = ioremap(get_immrbase(), 0x100000);
+	if (!immap)
+		return -1;
+
+	/* Configure clock */
+	sccr = in_be32(immap + MPC83XX_SCCR_OFFS);
+	if (port0_is_dr)
+		sccr |= MPC83XX_SCCR_USB_DRCM_11;  /* 1:3 */
+	else
+		sccr |= MPC83XX_SCCR_USB_MPHCM_11; /* 1:3 */
+	out_be32(immap + MPC83XX_SCCR_OFFS, sccr);
+
+	/* Configure Pin */
+	sicrl = in_be32(immap + MPC83XX_SICRL_OFFS);
+	/* set port0 only */
+	if (port0_is_dr)
+		sicrl |= MPC83XX_SICRL_USB0;
+	else
+		sicrl &= ~(MPC83XX_SICRL_USB0);
+	out_be32(immap + MPC83XX_SICRL_OFFS, sicrl);
+
+	iounmap(immap);
+
+	/* Map BCSR area */
+	np = of_find_node_by_name(NULL, "bcsr");
+	if (np != 0) {
+		struct resource res;
+
+		of_address_to_resource(np, 0, &res);
+		bcsr_regs = ioremap(res.start, res.end - res.start + 1);
+		of_node_put(np);
+	}
+	if (!bcsr_regs)
+		return -1;
+
+	/*
+	 * if SYS board is plug into PIB board,
+	 * force to use the PHY on SYS board
+	 */
+	bcsr5 = in_8(bcsr_regs + 5);
+	if (!(bcsr5 & BCSR5_INT_USB))
+		out_8(bcsr_regs + 5, (bcsr5 | BCSR5_INT_USB));
+	iounmap(bcsr_regs);
+	return 0;
+}
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -65,6 +136,7 @@ static void __init mpc834x_sys_setup_arch(void)
 			loops_per_jiffy = 50000000 / HZ;
 		of_node_put(np);
 	}
+
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
@@ -72,6 +144,8 @@ static void __init mpc834x_sys_setup_arch(void)
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
+	mpc834x_usb_cfg();
+
 #ifdef  CONFIG_ROOT_NFS
 	ROOT_DEV = Root_NFS;
 #else
diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.h b/arch/powerpc/platforms/83xx/mpc834x_sys.h
index 7d5bbef..52f14a3 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.h
+++ b/arch/powerpc/platforms/83xx/mpc834x_sys.h
@@ -20,4 +20,6 @@
 #define PIRQC	MPC83xx_IRQ_EXT6
 #define PIRQD	MPC83xx_IRQ_EXT7
 
+#define BCSR5_INT_USB		0x02
+
 #endif				/* __MACH_MPC83XX_SYS_H__ */
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 01cae10..9cd03b5 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -4,6 +4,24 @@
 #include <linux/init.h>
 #include <linux/device.h>
 
+/* System Clock Control Register */
+#define MPC83XX_SCCR_OFFS          0xA08
+#define MPC83XX_SCCR_USB_MPHCM_11  0x00c00000
+#define MPC83XX_SCCR_USB_MPHCM_01  0x00400000
+#define MPC83XX_SCCR_USB_MPHCM_10  0x00800000
+#define MPC83XX_SCCR_USB_DRCM_11   0x00300000
+#define MPC83XX_SCCR_USB_DRCM_01   0x00100000
+#define MPC83XX_SCCR_USB_DRCM_10   0x00200000
+
+/* system i/o configuration register low */
+#define MPC83XX_SICRL_OFFS         0x114
+#define MPC83XX_SICRL_USB0         0x40000000
+#define MPC83XX_SICRL_USB1         0x20000000
+
+/* system i/o configuration register high */
+#define MPC83XX_SICRH_OFFS         0x118
+#define MPC83XX_SICRH_USB_UTMI     0x00020000
+
 /*
  * Declaration for the various functions exported by the
  * mpc83xx_* files. Mostly for use by mpc83xx_setup
