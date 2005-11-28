Return-Path: <aris@cathedrallabs.org>
Received: from tinc.cathedrallabs.org (tinc.cathedrallabs.org [72.9.252.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43D32687F8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 01:09:04 +1100 (EST)
Date: Mon, 28 Nov 2005 12:10:42 -0200
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20051128141042.GR7163@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="65ImJOski3p8EhYV"
Subject: [RFC] add PHY support to AM79C874
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a simple port from old fec driver to PHY layer to support AMD
AM79C874 PHY.
As I don't have the hardware to test this, all kinds of feedback are
most welcome.
Thanks,

-- 
Aristeu


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="phy-add_am79c874_phy.patch"

Index: testing/drivers/net/phy/Kconfig
===================================================================
--- testing.orig/drivers/net/phy/Kconfig	2005-11-25 15:26:38.000000000 -0200
+++ testing/drivers/net/phy/Kconfig	2005-11-25 15:28:55.000000000 -0200
@@ -53,5 +53,11 @@
 	---help---
 	  Currently supports the cis8204
 
+config AMD_PHY
+	tristate "Drivers for the AMD PHYs"
+	depends on PHYLIB
+	---help---
+	  Currenty supports AM79C874
+
 endmenu
 
Index: testing/drivers/net/phy/Makefile
===================================================================
--- testing.orig/drivers/net/phy/Makefile	2005-11-25 15:26:38.000000000 -0200
+++ testing/drivers/net/phy/Makefile	2005-11-25 15:26:56.000000000 -0200
@@ -8,3 +8,5 @@
 obj-$(CONFIG_CICADA_PHY)	+= cicada.o
 obj-$(CONFIG_LXT_PHY)		+= lxt.o
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
+obj-$(CONFIG_AMD_PHY)		+= amd.o
+
Index: testing/drivers/net/phy/amd.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ testing/drivers/net/phy/amd.c	2005-11-28 11:39:34.000000000 -0200
@@ -0,0 +1,71 @@
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#define MII_AM79C874_MFR	16  /* Miscellaneous Features Register      */
+#define MII_AM79C874_ICSR	17  /* Interrupt Control/Status Register    */
+#define MII_AM79C874_DR		18  /* Diagnostic Register		    */
+#define MII_AM79C874_PMLR	19  /* Power Management & Loopback Register */
+#define MII_AM79C874_MCR	21  /* Mode Control Register		    */
+#define MII_AM79C874_DC		23  /* Disconnect Counter		    */
+#define MII_AM79C874_REC	24  /* Receiver Error Counter		    */
+
+static int am79c874_ack_interrupt(struct phy_device *phy)
+{
+	int err;
+
+	err = phy_read(phy, MII_AM79C874_ICSR);
+
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static int am79c874_config_intr(struct phy_device *phy)
+{
+	int err;
+
+	if (phy->interrupts == PHY_INTERRUPT_ENABLED)
+		err = phy_write(phy, MII_AM79C874_ICSR, 0xff00);
+	else
+		err = phy_write(phy, MII_AM79C874_ICSR, 0);
+
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static struct phy_driver am79c874 = {
+	.phy_id		= 0x00022561,
+	.name		= "AM79C874",
+	.phy_id_mask	= 0x0fffffff,
+	.features	= PHY_BASIC_FEATURES,
+	.flags		= PHY_HAS_INTERRUPT,
+	.config_aneg	= genphy_config_aneg,
+	.read_status	= genphy_read_status,
+	.ack_interrupt	= am79c874_ack_interrupt,
+	.config_intr	= am79c874_config_intr,
+	.driver 	= { .owner = THIS_MODULE,},
+};
+
+static __init int am79c874_init(void)
+{
+	return phy_driver_register(&am79c874);
+}
+
+static __exit void am79c874_exit(void)
+{
+	phy_driver_unregister(&am79c874);
+}
+module_init(am79c874_init);
+module_exit(am79c874_exit);
+

--65ImJOski3p8EhYV--
