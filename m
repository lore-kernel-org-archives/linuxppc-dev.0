Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 72C7BDDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 11:34:56 +1100 (EST)
Date: Wed, 28 Nov 2007 18:37:31 -0600
From: Olof Johansson <olof@lixom.net>
To: dwmw2@infradead.org
Subject: [PATCH v2] MTD: pasemi_nand driver
Message-ID: <20071129003731.GA15115@lixom.net>
References: <20071128221448.GA1144@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071128221448.GA1144@lixom.net>
Cc: linuxppc-dev@ozlabs.org, egor@pasemi.com, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Plumbing for NAND connected via localbus on PA Semi PWRficient-based
boards.

From: Egor Martovetsky <egor@pasemi.com>
Signed-off-by: Olof Johansson <olof@lixom.net>

---

Changes from original post:

* asm/of_platform.h -> linux/of_platform.h
* MODULE_DEVICE_TABLE()

 drivers/mtd/nand/Kconfig       |    6 
 drivers/mtd/nand/Makefile      |    1 
 drivers/mtd/nand/pasemi_nand.c |  243 +++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+)


Index: 2.6.24/drivers/mtd/nand/Kconfig
===================================================================
--- 2.6.24.orig/drivers/mtd/nand/Kconfig
+++ 2.6.24/drivers/mtd/nand/Kconfig
@@ -283,6 +283,12 @@ config MTD_NAND_CM_X270
 	tristate "Support for NAND Flash on CM-X270 modules"
 	depends on MTD_NAND && MACH_ARMCORE
 
+config MTD_NAND_PASEMI
+	tristate "NAND support for PA Semi PWRficient"
+	depends on MTD_NAND && PPC_PASEMI
+	help
+	  Enables support for NAND Flash interface on PA Semi PWRficient
+	  based boards
 
 config MTD_NAND_NANDSIM
 	tristate "Support for NAND Flash Simulator"
Index: 2.6.24/drivers/mtd/nand/Makefile
===================================================================
--- 2.6.24.orig/drivers/mtd/nand/Makefile
+++ 2.6.24/drivers/mtd/nand/Makefile
@@ -29,5 +29,6 @@ obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx27
 obj-$(CONFIG_MTD_NAND_BASLER_EXCITE)	+= excite_nandflash.o
 obj-$(CONFIG_MTD_NAND_PLATFORM)		+= plat_nand.o
 obj-$(CONFIG_MTD_ALAUDA)		+= alauda.o
+obj-$(CONFIG_MTD_NAND_PASEMI)		+= pasemi_nand.o
 
 nand-objs := nand_base.o nand_bbt.o
Index: 2.6.24/drivers/mtd/nand/pasemi_nand.c
===================================================================
--- /dev/null
+++ 2.6.24/drivers/mtd/nand/pasemi_nand.c
@@ -0,0 +1,243 @@
+/*
+ * Copyright (C) 2006-2007 PA Semi, Inc
+ *
+ * Author: Egor Martovetsky <egor@pasemi.com>
+ * Maintained by: Olof Johansson <olof@lixom.net>
+ *
+ * Driver for the PWRficient onchip NAND flash interface
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
+#undef DEBUG
+
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+
+#include <asm/io.h>
+
+#define LBICTRL_LPCCTL_NR		0x00004000
+#define CLE_PIN_CTL			15
+#define ALE_PIN_CTL			14
+
+static unsigned int lpcctl;
+static struct mtd_info *pasemi_nand_mtd;
+static const char driver_name[] = "pasemi-nand";
+
+static void pasemi_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+{
+	struct nand_chip *chip = mtd->priv;
+
+	while (len > 0x800) {
+		memcpy_fromio(buf, chip->IO_ADDR_R, 0x800);
+		buf += 0x800;
+		len -= 0x800;
+	}
+	memcpy_fromio(buf, chip->IO_ADDR_R, len);
+}
+
+static void pasemi_write_buf(struct mtd_info *mtd, const u_char *buf, int len)
+{
+	struct nand_chip *chip = mtd->priv;
+
+	while (len > 0x800) {
+		memcpy_toio(chip->IO_ADDR_R, buf, 0x800);
+		buf += 0x800;
+		len -= 0x800;
+	}
+	memcpy_toio(chip->IO_ADDR_R, buf, len);
+}
+
+static void pasemi_hwcontrol(struct mtd_info *mtd, int cmd,
+			     unsigned int ctrl)
+{
+	struct nand_chip *chip = mtd->priv;
+
+	if (cmd == NAND_CMD_NONE)
+		return;
+
+	if (ctrl & NAND_CLE)
+		out_8(chip->IO_ADDR_W + (1 << CLE_PIN_CTL), cmd);
+	else
+		out_8(chip->IO_ADDR_W + (1 << ALE_PIN_CTL), cmd);
+
+	/* Push out posted writes */
+	eieio();
+	inl(lpcctl);
+}
+
+int pasemi_device_ready(struct mtd_info *mtd)
+{
+	return !!(inl(lpcctl) & LBICTRL_LPCCTL_NR);
+}
+
+static int __devinit pasemi_nand_probe(struct of_device *ofdev,
+				      const struct of_device_id *match)
+{
+	struct pci_dev *pdev;
+	struct device_node *np = ofdev->node;
+	struct resource res;
+	struct nand_chip *chip;
+	int err = 0;
+
+	err = of_address_to_resource(np, 0, &res);
+
+	if (err)
+		return -EINVAL;
+
+	/* We only support one device at the moment */
+	if (pasemi_nand_mtd)
+		return -ENODEV;
+
+	pr_debug("pasemi_nand at %lx-%lx\n", res.start, res.end);
+
+	/* Allocate memory for MTD device structure and private data */
+	pasemi_nand_mtd = kzalloc(sizeof(struct mtd_info) +
+				  sizeof(struct nand_chip), GFP_KERNEL);
+	if (!pasemi_nand_mtd) {
+		printk(KERN_WARNING
+		       "Unable to allocate PASEMI NAND MTD device structure\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* Get pointer to private data */
+	chip = (struct nand_chip *)&pasemi_nand_mtd[1];
+
+	/* Link the private data with the MTD structure */
+	pasemi_nand_mtd->priv = chip;
+	pasemi_nand_mtd->owner = THIS_MODULE;
+
+	chip->IO_ADDR_R = of_iomap(np, 0);
+	chip->IO_ADDR_W = chip->IO_ADDR_R;
+
+	if (!chip->IO_ADDR_R) {
+		err = -EIO;
+		goto out_mtd;
+	}
+
+	pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa008, NULL);
+	if (!pdev) {
+		err = -ENODEV;
+		goto out_ior;
+	}
+
+	lpcctl = pci_resource_start(pdev, 0);
+
+	if (!request_region(lpcctl, 4, driver_name)) {
+		err = -EBUSY;
+		goto out_ior;
+	}
+
+	chip->cmd_ctrl = pasemi_hwcontrol;
+	chip->dev_ready = pasemi_device_ready;
+	chip->read_buf = pasemi_read_buf;
+	chip->write_buf = pasemi_write_buf;
+	chip->chip_delay = 0;
+	chip->ecc.mode = NAND_ECC_SOFT;
+
+	/* Enable the following for a flash based bad block table */
+	chip->options = NAND_USE_FLASH_BBT | NAND_NO_AUTOINCR;
+
+	/* Scan to find existance of the device */
+	if (nand_scan(pasemi_nand_mtd, 1)) {
+		err = -ENXIO;
+		goto out_lpc;
+	}
+
+	if (add_mtd_device(pasemi_nand_mtd)) {
+		printk(KERN_ERR "pasemi_nand: Unable to register MTD device\n");
+		err = -ENODEV;
+		goto out_lpc;
+	}
+
+	printk(KERN_INFO "PA Semi NAND flash at %08lx, control at I/O %x\n",
+	       res.start, lpcctl);
+
+	return 0;
+
+ out_lpc:
+	release_region(lpcctl, 4);
+ out_ior:
+	iounmap(chip->IO_ADDR_R);
+ out_mtd:
+	kfree(pasemi_nand_mtd);
+ out:
+	return err;
+}
+
+static int __devexit pasemi_nand_remove(struct of_device *ofdev)
+{
+	struct nand_chip *chip;
+
+	if (!pasemi_nand_mtd)
+		return 0;
+
+	chip = pasemi_nand_mtd->priv;
+
+	/* Release resources, unregister device */
+	nand_release(pasemi_nand_mtd);
+
+	release_region(lpcctl, 4);
+
+	iounmap(chip->IO_ADDR_R);
+
+	/* Free the MTD device structure */
+	kfree(pasemi_nand_mtd);
+
+	pasemi_nand_mtd = NULL;
+
+	return 0;
+}
+
+static struct of_device_id pasemi_nand_match[] =
+{
+	{
+		.compatible   = "pasemi,localbus-nand",
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, pasemi_nand_match);
+
+static struct of_platform_driver pasemi_nand_driver =
+{
+	.name		= (char*)driver_name,
+	.match_table	= pasemi_nand_match,
+	.probe		= pasemi_nand_probe,
+	.remove		= pasemi_nand_remove,
+};
+
+static int __init pasemi_nand_init(void)
+{
+	return of_register_platform_driver(&pasemi_nand_driver);
+}
+module_init(pasemi_nand_init);
+
+static void __exit pasemi_nand_exit(void)
+{
+	of_unregister_platform_driver(&pasemi_nand_driver);
+}
+module_exit(pasemi_nand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Egor Martovetsky <egor@pasemi.com>");
+MODULE_DESCRIPTION("NAND flash interface driver for PA Semi PWRficient");
