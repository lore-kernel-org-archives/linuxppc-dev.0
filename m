Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D708DDFA2
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 20:55:45 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2.6.22] pasemi: hardware rng driver
Date: Fri, 27 Apr 2007 12:54:43 +0200
MIME-Version: 1.0
Message-Id: <200704271254.43588.mb@bu3sch.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, egor@pasemi.com,
	arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Olof Johansson <olof@lixom.net>

Driver for the on-chip hardware random number generator on PA Semi
PA6T-1682M.

Signed-off-by: Egor Martovetsky <egor@pasemi.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Michael Buesch <mb@bu3sch.de>


---

This is patch version 3.

v3:
* error return codes
* iounmap on register fail
* fix iounmap race on remove

v2:
* Moved register pointer to hwrng->priv
* Cleanups (__init/__exit, module_init/exit)

Index: powerpc/drivers/char/hw_random/Kconfig
===================================================================
--- powerpc.orig/drivers/char/hw_random/Kconfig
+++ powerpc/drivers/char/hw_random/Kconfig
@@ -91,3 +91,17 @@ config HW_RANDOM_OMAP
 	  module will be called omap-rng.
 
  	  If unsure, say Y.
+
+config HW_RANDOM_PASEMI
+	tristate "PA Semi HW Random Number Generator support"
+	depends on HW_RANDOM && PPC_PASEMI
+	default HW_RANDOM
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on PA6T-1682M processor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pasemi-rng.
+
+	  If unsure, say Y.
+
Index: powerpc/drivers/char/hw_random/Makefile
===================================================================
--- powerpc.orig/drivers/char/hw_random/Makefile
+++ powerpc/drivers/char/hw_random/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_HW_RANDOM_GEODE) += geode-r
 obj-$(CONFIG_HW_RANDOM_VIA) += via-rng.o
 obj-$(CONFIG_HW_RANDOM_IXP4XX) += ixp4xx-rng.o
 obj-$(CONFIG_HW_RANDOM_OMAP) += omap-rng.o
+obj-$(CONFIG_HW_RANDOM_PASEMI) += pasemi-rng.o
Index: powerpc/drivers/char/hw_random/pasemi-rng.c
===================================================================
--- /dev/null
+++ powerpc/drivers/char/hw_random/pasemi-rng.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright (C) 2006-2007 PA Semi, Inc
+ *
+ * Maintained by: Olof Johansson <olof@lixom.net>
+ *
+ * Driver for the PWRficient onchip rng
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/hw_random.h>
+#include <asm/of_platform.h>
+#include <asm/io.h>
+
+#define SDCRNG_CTL_REG			0x00
+#define   SDCRNG_CTL_FVLD_M		0x0000f000
+#define   SDCRNG_CTL_FVLD_S		12
+#define   SDCRNG_CTL_KSZ		0x00000800
+#define   SDCRNG_CTL_RSRC_CRG		0x00000010
+#define   SDCRNG_CTL_RSRC_RRG		0x00000000
+#define   SDCRNG_CTL_CE			0x00000004
+#define   SDCRNG_CTL_RE			0x00000002
+#define   SDCRNG_CTL_DR			0x00000001
+#define   SDCRNG_CTL_SELECT_RRG_RNG	(SDCRNG_CTL_RE | SDCRNG_CTL_RSRC_RRG)
+#define   SDCRNG_CTL_SELECT_CRG_RNG	(SDCRNG_CTL_CE | SDCRNG_CTL_RSRC_CRG)
+#define SDCRNG_VAL_REG			0x20
+
+#define MODULE_NAME "pasemi_rng"
+
+static int pasemi_rng_data_present(struct hwrng *rng)
+{
+	void __iomem *rng_regs = (void __iomem *)rng->priv;
+
+	return (in_le32(rng_regs + SDCRNG_CTL_REG)
+		& SDCRNG_CTL_FVLD_M) ? 1 : 0;
+}
+
+static int pasemi_rng_data_read(struct hwrng *rng, u32 *data)
+{
+	void __iomem *rng_regs = (void __iomem *)rng->priv;
+	*data = in_le32(rng_regs + SDCRNG_VAL_REG);
+	return 4;
+}
+
+static int pasemi_rng_init(struct hwrng *rng)
+{
+	void __iomem *rng_regs = (void __iomem *)rng->priv;
+	u32 ctl;
+
+	ctl = SDCRNG_CTL_DR | SDCRNG_CTL_SELECT_RRG_RNG | SDCRNG_CTL_KSZ;
+	out_le32(rng_regs + SDCRNG_CTL_REG, ctl);
+	out_le32(rng_regs + SDCRNG_CTL_REG, ctl & ~SDCRNG_CTL_DR);
+
+	return 0;
+}
+
+static void pasemi_rng_cleanup(struct hwrng *rng)
+{
+	void __iomem *rng_regs = (void __iomem *)rng->priv;
+	u32 ctl;
+
+	ctl = SDCRNG_CTL_RE | SDCRNG_CTL_CE;
+	out_le32(rng_regs + SDCRNG_CTL_REG,
+		 in_le32(rng_regs + SDCRNG_CTL_REG) & ~ctl);
+}
+
+static struct hwrng pasemi_rng = {
+	.name		= MODULE_NAME,
+	.init		= pasemi_rng_init,
+	.cleanup	= pasemi_rng_cleanup,
+	.data_present	= pasemi_rng_data_present,
+	.data_read	= pasemi_rng_data_read,
+};
+
+static int __devinit rng_probe(struct of_device *ofdev,
+			       const struct of_device_id *match)
+{
+	void __iomem *rng_regs;
+	struct device_node *rng_np = ofdev->node;
+	struct resource res;
+	int err = 0;
+
+	err = of_address_to_resource(rng_np, 0, &res);
+	if (err)
+		return -ENODEV;
+
+	rng_regs = ioremap(res.start, 0x100);
+
+	if (!rng_regs)
+		return -ENOMEM;
+
+	pasemi_rng.priv = (unsigned long)rng_regs;
+
+	printk(KERN_INFO "Registering PA Semi RNG\n");
+
+	err = hwrng_register(&pasemi_rng);
+
+	if (err)
+		iounmap(rng_regs);
+
+	return err;
+}
+
+static int __devexit rng_remove(struct of_device *dev)
+{
+	void __iomem *rng_regs = (void __iomem *)pasemi_rng.priv;
+
+	hwrng_unregister(&pasemi_rng);
+	iounmap(rng_regs);
+
+	return 0;
+}
+
+static struct of_device_id rng_match[] =
+{
+	{
+		.compatible      = "1682m-rng",
+	},
+	{},
+};
+
+static struct of_platform_driver rng_driver =
+{
+	.name		= "pasemi-rng",
+	.match_table	= rng_match,
+	.probe		= rng_probe,
+	.remove		= rng_remove,
+};
+
+static int __init rng_init(void)
+{
+	return of_register_platform_driver(&rng_driver);
+}
+module_init(rng_init);
+
+static void __exit rng_exit(void)
+{
+	of_unregister_platform_driver(&rng_driver);
+}
+module_exit(rng_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Egor Martovetsky <egor@pasemi.com>");
+MODULE_DESCRIPTION("H/W RNG driver for PA Semi processor");


-- 
Greetings Michael.
