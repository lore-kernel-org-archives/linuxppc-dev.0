Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 033C267B65
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 21:52:10 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k6ED9aKK002495
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 07:09:36 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k6EBq65V025110
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 06:52:08 -0500 (CDT)
Message-ID: <44B7857A.2060101@freescale.com>
Date: Fri, 14 Jul 2006 19:52:26 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: galak@kernel.crashing.org
Subject: [PATCH] Add USB to MPC8349 PB platform support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds USB platform support to MPC8349 PB.  It works with the fsl_usb2_udc driver.

Signed-off-by: Li Yang <leoli@freescale.com>
---

 arch/powerpc/platforms/83xx/Kconfig       |   4  ++
 arch/powerpc/platforms/83xx/mpc834x_sys.c |   72 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc834x_sys.h |   24 ++++++++++
 3 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 7675e67..8404cdf 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -24,4 +31,14 @@ config MPC834x
 	select PPC_INDIRECT_PCI
 	default y if MPC834x_SYS

+config 834x_USB_SUPPORT
+	bool
+	default y if MPC834x_SYS && (USB || USB_GADGET)
+	
 endmenu
diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.c b/arch/powerpc/platforms/83xx/mpc834x_sys.c
index 7e789d2..f10d4ae 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_sys.c
@@ -36,6 +36,7 @@ #include <asm/irq.h>
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
+#include <linux/fsl_devices.h>
 
 #include "mpc83xx.h"
 
@@ -71,6 +72,72 @@ mpc83xx_map_irq(struct pci_dev *dev, uns
 }
 #endif				/* CONFIG_PCI */
 
+#ifdef CONFIG_834x_USB_SUPPORT
+void mpc834x_usb_board_cfg(void)
+{
+	unsigned char __iomem *bcsr;
+	volatile unsigned char *bcsr5_p;
+
+	/*
+	 * if SYS board is plug into PIB board,
+	 * force to use the PHY on SYS board
+	 * */
+	bcsr = ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
+	bcsr5_p = bcsr + BCSR5_OFF;
+	if ( (*bcsr5_p & BCSR5_INT_USB) == 0 )
+		*bcsr5_p = (*bcsr5_p | BCSR5_INT_USB);
+	iounmap(bcsr);
+}
+
+/* Note: This is only for PB, not for PB+PIB
+ * On PB only port0 is connected using ULPI */
+static int mpc834x_usb_cfg(void)
+{
+	unsigned long sccr, sicrl;
+	volatile unsigned long *p;
+	unsigned long __iomem *immap;
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
+	
+	/* Configure clock */
+	p = (volatile unsigned long *)((u32)immap + MPC83XX_SCCR_OFFS);
+	sccr = *p;
+	if (port0_is_dr)
+		sccr |= MPC83XX_SCCR_USB_DRCM_11;  /* 1:3 */
+	else
+		sccr |= MPC83XX_SCCR_USB_MPHCM_11; /* 1:3 */
+	*p = sccr;
+
+	/* Configure Pin */
+	p = (volatile unsigned long *)((u32)immap + MPC83XX_SICRL_OFFS); 
+	sicrl = *p;
+	/* set port0 only */
+	if (port0_is_dr) 
+		sicrl |= MPC83XX_SICRL_USB0;
+	else 
+		sicrl &= ~(MPC83XX_SICRL_USB0);
+	*p = sicrl;
+	
+	iounmap(immap);
+	return 0;
+}
+
+#endif /* CONFIG_834x_USB_SUPPORT */
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -102,6 +169,11 @@ #ifdef CONFIG_PCI
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
 
+#ifdef CONFIG_834x_USB_SUPPORT
+	mpc834x_usb_cfg();
+	mpc834x_usb_board_cfg();
+#endif
+
 #ifdef  CONFIG_ROOT_NFS
 	ROOT_DEV = Root_NFS;
 #else
diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.h b/arch/powerpc/platforms/83xx/mpc834x_sys.h
index fedecb7..30e45e8 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.h
+++ b/arch/powerpc/platforms/83xx/mpc834x_sys.h
@@ -20,4 +20,28 @@ #define PIRQB	MPC83xx_IRQ_EXT5
 #define PIRQC	MPC83xx_IRQ_EXT6
 #define PIRQD	MPC83xx_IRQ_EXT7
 
+#define BCSR_PHYS_ADDR		((uint)0xf8000000)
+#define BCSR_SIZE		((uint)(32 * 1024))
+ 
+#define BCSR5_OFF		0x05
+#define BCSR5_INT_USB		0x02
+
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
+
 #endif				/* __MACH_MPC83XX_SYS_H__ */
