Return-Path: <suvidh.kankariya@ntigo.com>
Received: from nti1.com (nti1.com [65.243.248.10])
	by ozlabs.org (Postfix) with ESMTP id 16A46B7BC0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Oct 2009 01:20:30 +1100 (EST)
Received: from PC140.ntigo.com (host82.networktechinc.com [65.243.248.82] (may
	be forged)) by nti1.com (8.14.1/8.14.3) with ESMTP id n9SEKI2R005094
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 09:20:23 -0500 (EST)
Message-Id: <200910281420.n9SEKI2R005094@nti1.com>
Date: Wed, 28 Oct 2009 10:19:04 -0500
To: linuxppc-dev@lists.ozlabs.org
From: suvidh kankariya <suvidh.kankariya@ntigo.com>
Subject: Re: Micrel PHY KSZ8001 on MPC5200B FEC 
In-Reply-To: <mailman.1198.1256674402.12812.linuxppc-dev@lists.ozlabs.or
 g>
References: <mailman.1198.1256674402.12812.linuxppc-dev@lists.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Romen,
         I am sorry for the misguided statement.
         I indeed had patched it .
I am copying the patch here. Hope it helps you.
diff --exclude CVS -uNr linux-2.6.30/drivers/net/phy/Kconfig 
linux-2.6.30.modified/drivers/net/phy/Kconfig
--- linux-2.6.30/drivers/net/phy/Kconfig        2009-06-09 
23:05:27.000000000 -0400
+++ linux-2.6.30.modified/drivers/net/phy/Kconfig       2009-10-09 
15:43:09.000000000 -0400
@@ -82,6 +82,12 @@
         ---help---
           Supports the LSI ET1011C PHY.

+config MICREL_PHY
+       tristate "Drivers for MICREL  PHYs"
+        depends on PHYLIB
+       ---help---
+         Currently supports the KS8721BL, KSZ8041NL
+
  config FIXED_PHY
         bool "Driver for MDIO Bus/PHY emulation with fixed speed/link PHYs"
         depends on PHYLIB=y
diff --exclude CVS -uNr linux-2.6.30/drivers/net/phy/Makefile 
linux-2.6.30.modified/drivers/net/phy/Makefile
--- linux-2.6.30/drivers/net/phy/Makefile       2009-06-09 
23:05:27.000000000 -0400
+++ linux-2.6.30.modified/drivers/net/phy/Makefile      2009-10-09 
16:07:37.000000000 -0400
@@ -14,6 +14,7 @@
  obj-$(CONFIG_ICPLUS_PHY)       += icplus.o
  obj-$(CONFIG_REALTEK_PHY)      += realtek.o
  obj-$(CONFIG_LSI_ET1011C_PHY)  += et1011c.o
+obj-$(CONFIG_MICREL_PHY)       += micrel.o
  obj-$(CONFIG_FIXED_PHY)                += fixed.o
  obj-$(CONFIG_MDIO_BITBANG)     += mdio-bitbang.o
  obj-$(CONFIG_MDIO_GPIO)                += mdio-gpio.o
diff --exclude CVS -uNr linux-2.6.30/drivers/net/phy/micrel.c 
linux-2.6.30.modified/drivers/net/phy/micrel.c
--- linux-2.6.30/drivers/net/phy/micrel.c       1969-12-31 
19:00:00.000000000 -0500
+++ linux-2.6.30.modified/drivers/net/phy/micrel.c      2009-09-23 
16:04:53.000000000 -0400
@@ -0,0 +1,129 @@
+ /* drivers/net/phy/micrel.c
+ *
+ * Driver for Micrel  PHY
+ * based on drivers/net/phy/marvell.c  *
+ *
+ *
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/unistd.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#define MII_MICRELL_RXERCR     0x15
+#define MII_MICRELL_ICSR       0x1B
+#define MII_MICRELL_PHYCR      0x1F
+
+
+MODULE_DESCRIPTION("Micrel PHY driver");
+MODULE_AUTHOR("Suvidh Kankariya");
+MODULE_LICENSE("GPL");
+
+
+static int micrel_config_intr(struct phy_device *phydev)
+{
+  int err;
+
+       if(phydev->interrupts == PHY_INTERRUPT_ENABLED)
+       {
+         err = phy_write(phydev, MII_MICRELL_ICSR, 0xFF00);
+         err = phy_write(phydev, 0, 0x1200); /* control register */
+       }
+       else
+               err = phy_write(phydev, MII_MICRELL_ICSR, 0);
+
+       return err;
+}
+
+static int micrel_config_init(struct phy_device *phydev)
+{
+    printk("Phy config  done");
+
+       phy_write(phydev, MII_MICRELL_ICSR, 0);
+       return 0;
+}
+
+
+static int micrel_ack_interrupt(struct phy_device *phydev)
+{
+       int err = phy_read(phydev, MII_MICRELL_ICSR);
+       if (err < 0)
+               return err;
+
+       return 0;
+}
+
+static struct phy_driver ks8721bl_driver = {
+       .phy_id         = 0x000221619,
+       .name           = "KS8721BL",
+       .phy_id_mask    = 0xfffffff0,
+       .features       = PHY_BASIC_FEATURES,
+       .flags          = PHY_HAS_INTERRUPT,
+       .config_init    = micrel_config_init,
+       .config_aneg    = genphy_config_aneg,
+       .read_status    = genphy_read_status,
+       .ack_interrupt  = micrel_ack_interrupt,
+       .config_intr    = micrel_config_intr,
+       .driver         = { .owner = THIS_MODULE,},
+};
+
+
+
+static struct phy_driver ksz8041nl_driver = {
+       .phy_id         = 0x00022151,
+       .name           = "KSZ8041NL",
+       .phy_id_mask    = 0xfffffff0,
+       .features       = PHY_BASIC_FEATURES,
+       .flags          = PHY_HAS_INTERRUPT,
+       .config_init    = micrel_config_init,
+       .config_aneg    = genphy_config_aneg,
+       .read_status    = genphy_read_status,
+       .ack_interrupt  = micrel_ack_interrupt,
+       .config_intr    = micrel_config_intr,
+       .driver         = { .owner = THIS_MODULE,},
+};
+
+static int __init micrel_init(void)
+{
+       int ret;
+
+       ret = phy_driver_register(&ks8721bl_driver);
+       if (ret)
+               return ret;
+    ret = phy_driver_register(&ksz8041nl_driver);
+    printk("Phy Init  done");
+    if (ret)
+        goto err8041;
+
+       return 0;
+ err8041:
+    phy_driver_unregister(&ks8721bl_driver);
+       return ret;
+}
+
+static void __exit micrel_exit(void)
+{
+       phy_driver_unregister(&ks8721bl_driver);
+    phy_driver_unregister(&ksz8041nl_driver);
+}
+
+module_init(micrel_init);
+module_exit(micrel_exit);



Suvidh





>------------------------------
>
>Message: 6
>Date: Tue, 27 Oct 2009 20:54:47 +0100
>From: Roman Fietze <roman.fietze@telemotive.de>
>To: linuxppc-dev@lists.ozlabs.org
>Subject: Re: Micrel PHY KSZ8001 on MPC5200B FEC
>Message-ID: <200910272054.47398.roman.fietze@telemotive.de>
>Content-Type: Text/Plain;  charset="iso-8859-1"
>
>Hello Suvidh,
>
>On Tuesday 27 October 2009 17:47:51 suvidh kankariya wrote:
>
> > A driver for micrel phy exists in /drivers/net/phy/micrel.c. in
> > 2.6.30.
>
>Am I somewhat blind, or do you have access to other 2.6.30's than I
>have?
>
>I searched git.kernel.org, git.denx.de and git.secretlab.ca, but could
>not find that file, neither in the current master, nor in older tags
>somewhat related to "2.6.30", nor in any local clone in any version of
>the 2.6 since "He" created the repos.
>
>
> > If you are using older kernel you may want to copy it.
>
>2.6.30 and 2.6.31 from DENX or kernel.org.
>
>
>Roman
>
>--
>Roman Fietze                Telemotive AG B?ro M?hlhausen
>Breitwiesen                              73347 M?hlhausen
>Tel.: +49(0)7335/18493-45        http://www.telemotive.de
>
>
>------------------------------
