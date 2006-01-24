Return-Path: <jrigby@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 91B51681BD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 04:10:50 +1100 (EST)
Message-ID: <43D65FE3.6080501@freescale.com>
Date: Tue, 24 Jan 2006 10:12:03 -0700
From: John Rigby <jrigby@freescale.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tnt.com>
Subject: [PATCH] Add support for lite5200b board.
Content-Type: multipart/mixed; boundary="------------060806030106080604030403"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060806030106080604030403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sylvain,

Here is an updated patch for the liteb board.

John



--------------060806030106080604030403
Content-Type: text/x-patch;
 name="liteb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="liteb.patch"

Adds support for liteb board.

Signed-off-by: John Rigby <jrigby@freescale.com>


 arch/ppc/Kconfig              |    8 ++++++++
 arch/ppc/platforms/lite5200.c |   38 +++++++++++++++++++++++++++++++++++---
 arch/ppc/syslib/mpc52xx_pci.c |    3 ++-
 include/linux/pci_ids.h       |    1 +
 4 files changed, 46 insertions(+), 4 deletions(-)

3a68d4fcd6a175c7887e570b3f11af07a812bdc0
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 11899f0..eecb608 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -664,6 +664,14 @@ config LITE5200
 	  much but it's only been tested on this board version. I think this
 	  board is also known as IceCube.
 
+config LITE5200B
+	bool "Freescale LITE5200B"
+	depends on LITE5200
+	help
+	  Support for the LITE5200B dev board for the MPC5200 from Freescale.
+	  This is the new board with 2 PCI slots.
+
+
 config MPC834x_SYS
 	bool "Freescale MPC834x SYS"
 	help
diff --git a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
index 7ed52dc..8cd9c67 100644
--- a/arch/ppc/platforms/lite5200.c
+++ b/arch/ppc/platforms/lite5200.c
@@ -36,6 +36,7 @@
 #include <asm/mpc52xx.h>
 #include <asm/ppc_sys.h>
 #include <asm/machdep.h>
+#include <asm/pci-bridge.h>
 
 #include <syslib/mpc52xx_pci.h>
 
@@ -70,12 +71,32 @@ lite5200_show_cpuinfo(struct seq_file *m
 }
 
 #ifdef CONFIG_PCI
+#ifdef CONFIG_LITE5200B
+static int
+lite5200_map_irq(struct pci_dev *dev, unsigned char idsel,
+		    unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	/*
+	 *      PCI IDSEL/INTPIN->INTLINE
+	 *        A             B             C             D
+	 */
+	{
+		{MPC52xx_IRQ0, MPC52xx_IRQ1, MPC52xx_IRQ2, MPC52xx_IRQ3},
+		{MPC52xx_IRQ1, MPC52xx_IRQ2, MPC52xx_IRQ3, MPC52xx_IRQ0},
+	};
+
+	const long min_idsel = 24, max_idsel = 25, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+#else /* Original Lite */
 static int
 lite5200_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
 {
 	return (pin == 1) && (idsel==24) ? MPC52xx_IRQ0 : -1;
 }
 #endif
+#endif
 
 static void __init
 lite5200_setup_cpu(void)
@@ -111,6 +132,11 @@ lite5200_setup_cpu(void)
 	/* Get port mux config */
 	port_config = in_be32(&gpio->port_config);
 
+#ifdef CONFIG_LITE5200B
+	/* turn on cs1 */
+	port_config |= 0x80000000;
+#endif
+
 	/* 48Mhz internal, pin is GPIO */
 	port_config &= ~0x00800000;
 
@@ -129,11 +155,17 @@ lite5200_setup_cpu(void)
 	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_SNOOP);
 	out_be32(&xlb->snoop_window, MPC52xx_PCI_TARGET_MEM | 0x1d);
 
-	/* IRQ[0-3] setup : IRQ0     - Level Active Low  */
-	/*                  IRQ[1-3] - Level Active High */
+	/* IRQ[0-3] setup */
 	intr_ctrl = in_be32(&intr->ctrl);
 	intr_ctrl &= ~0x00ff0000;
-	intr_ctrl |=  0x00c00000;
+#if CONFIG_LITE5200B
+	/* IRQ[0-3] Level Active Low */
+	intr_ctrl |=  0x00ff0000;
+#else
+	/* IRQ0 Level Active Low
+	 * IRQ[1-3] Level Active High */
+ 	intr_ctrl |=  0x00c00000;
+#endif
 	out_be32(&intr->ctrl, intr_ctrl);
 
 	/* Unmap reg zone */
diff --git a/arch/ppc/syslib/mpc52xx_pci.c b/arch/ppc/syslib/mpc52xx_pci.c
index 313c96e..c5bf453 100644
--- a/arch/ppc/syslib/mpc52xx_pci.c
+++ b/arch/ppc/syslib/mpc52xx_pci.c
@@ -227,7 +227,8 @@ mpc52xx_pci_fixup_resources(struct pci_d
 	/* The PCI Host bridge of MPC52xx has a prefetch memory resource
 	   fixed to 1Gb. Doesn't fit in the resource system so we remove it */
 	if ( (dev->vendor == PCI_VENDOR_ID_MOTOROLA) &&
-	     (dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200) ) {
+	     (dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200
+	      || dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200B) ) {
 		struct resource *res = &dev->resource[1];
 		res->start = res->end = res->flags = 0;
 	}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ecc1fc1..c16cf15 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -778,6 +778,7 @@
 #define PCI_DEVICE_ID_MOTOROLA_HAWK	0x4803
 #define PCI_DEVICE_ID_MOTOROLA_HARRIER	0x480b
 #define PCI_DEVICE_ID_MOTOROLA_MPC5200	0x5803
+#define PCI_DEVICE_ID_MOTOROLA_MPC5200B	0x5809
 
 #define PCI_VENDOR_ID_PROMISE		0x105a
 #define PCI_DEVICE_ID_PROMISE_20265	0x0d30
-- 
1.1.3

--------------060806030106080604030403--
