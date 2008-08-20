Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB33BDF0B2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 07:08:35 +1000 (EST)
Date: Wed, 20 Aug 2008 22:59:58 +0200
From: Sebastian Siewior <bigeasy@linutronix.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: [RFC] mtd: add OF2PDEV convertor for the NDFC driver
Message-ID: <20080820205958.GA13371@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I didn't convert the NDFC driver to support OF because there are
non-OF-aware platforms with the ndfc chip.
All settings are mandatory except the oob layout.

Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
---
 drivers/mtd/nand/Kconfig   |    7 ++
 drivers/mtd/nand/Makefile  |    1 +
 drivers/mtd/nand/ndfc_of.c |  253 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/ndfc_of.c

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index ab0d77e..5bf0a25 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -170,6 +170,13 @@ config MTD_NAND_NDFC
 	help
 	 NDFC Nand Flash Controllers are integrated in IBM/AMCC's 4xx SoCs
 
+config MTD_NAND_NDFC_OF
+	tristate "OF support for NDFC"
+	depends on MTD_NAND_NDFC && PPC_OF
+	help
+	  This setting allows to read the NanD configuration from OF instead
+	  of a Platform device.
+
 config MTD_NAND_S3C2410_CLKSTOP
 	bool "S3C2410 NAND IDLE clock stop"
 	depends on MTD_NAND_S3C2410
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index b786c5d..5a9da0f 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_MTD_NAND_TS7250)		+= ts7250.o
 obj-$(CONFIG_MTD_NAND_NANDSIM)		+= nandsim.o
 obj-$(CONFIG_MTD_NAND_CS553X)		+= cs553x_nand.o
 obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
+obj-$(CONFIG_MTD_NAND_NDFC_OF)		+= ndfc_of.o
 obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel_nand.o
 obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
 obj-$(CONFIG_MTD_NAND_BASLER_EXCITE)	+= excite_nandflash.o
diff --git a/drivers/mtd/nand/ndfc_of.c b/drivers/mtd/nand/ndfc_of.c
new file mode 100644
index 0000000..852dca3
--- /dev/null
+++ b/drivers/mtd/nand/ndfc_of.c
@@ -0,0 +1,253 @@
+/*
+ * OF -> Platform device wrapper for NDFC
+ * (c) Sebastian Siewior, Linutronix
+ */
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/ndfc.h>
+
+struct resource ndfc_resource;
+
+struct ndfc_controller_settings ndfc_settings;
+
+struct platform_nand_ctrl ndfc_nand_ctrl = {
+	.priv = &ndfc_settings,
+};
+
+static struct platform_device ndfc_nand_device = {
+	.name = "ndfc-nand",
+	.id = 0,
+	.dev = {
+		.platform_data = &ndfc_nand_ctrl,
+	},
+	.num_resources = 1,
+	.resource = &ndfc_resource,
+};
+
+static int ndfc_num_devices;
+
+struct of_ndfc_devices {
+	struct platform_device device;
+	struct platform_nand_chip chip;
+	struct ndfc_chip_settings chip_settings;
+	struct nand_ecclayout ecclayout;
+};
+
+static struct of_ndfc_devices *ndfc_chips;
+
+static int __devinit of_nand_probe(struct of_device *dev,
+		const struct of_device_id *match)
+{
+	struct device_node *dp = dev->node;
+	struct device_node *child_node;
+	const u32 *u32_val;
+	int ret;
+	int i;
+	u32 len;
+	u32 ccr_bank;
+	u32 read_cycles;
+	u32 num_chips = 0;
+
+	ret = of_address_to_resource(dp, 0, &ndfc_resource);
+	if (ret) {
+		dev_err(&dev->dev, "Failed to read address from DT.\n");
+		return ret;
+	}
+
+	u32_val = of_get_property(dp, "id", &len);
+	if (!u32_val || len != 4) {
+		dev_err(&dev->dev, "Failed to read property: id\n");
+		return -EINVAL;
+	}
+	ndfc_nand_device.id = *u32_val;
+
+	u32_val = of_get_property(dp, "ccr_bank", &len);
+	if (!u32_val || len != 4) {
+		dev_err(&dev->dev, "Failed to read property: ccr_bank\n");
+		return -EINVAL;
+	}
+	ccr_bank = *u32_val;
+
+	u32_val = of_get_property(dp, "read_cycles", &len);
+	if (!u32_val || len != 4) {
+		dev_err(&dev->dev, "Failed to read property: read_cycles\n");
+		return -EINVAL;
+	}
+	read_cycles = *u32_val;
+
+	ndfc_settings.ccr_settings = NDFC_CCR_BS(ccr_bank) | read_cycles;
+
+	u32_val = of_get_property(dp, "erpn", &len);
+	if (!u32_val || len != 4) {
+		dev_err(&dev->dev, "Failed to read property: erpn\n");
+		return -EINVAL;
+	}
+	ndfc_settings.ndfc_erpn = *u32_val;
+
+	for_each_child_of_node(dp, child_node)
+			num_chips++;
+
+	if (!num_chips) {
+		dev_err(&dev->dev, "Failed to find chip nodes\n");
+		return -EINVAL;
+	}
+
+	ndfc_num_devices = num_chips;
+	ndfc_chips = kzalloc(ndfc_num_devices * sizeof(struct of_ndfc_devices),
+			GFP_KERNEL);
+	if (!ndfc_chips) {
+		dev_err(&dev->dev, "OOM while allocating memory for %d "
+				"ndfc_chips\n", num_chips);
+		return -ENOMEM;
+	}
+
+	num_chips = 0;
+	for_each_child_of_node(dp, child_node) {
+		struct of_ndfc_devices *cur_dev;
+		struct mtd_partition *partitions;
+		int num_part;
+
+		BUG_ON(num_chips > ndfc_num_devices);
+		cur_dev = &ndfc_chips[num_chips];
+
+		num_part = of_mtd_parse_partitions(&dev->dev, child_node,
+				&partitions);
+		if (num_part < 0) {
+			dev_err(&dev->dev, "Failed to parse partition table %d "
+					"from OF\n", num_chips);
+			goto out_err;
+		}
+
+		u32_val = of_get_property(child_node, "chipoffset", &len);
+		if (!u32_val || len != 4) {
+			dev_err(&dev->dev, "Failed to read property: chipoffset\n");
+			goto out_err;
+		}
+		cur_dev->chip.chip_offset = *u32_val;
+
+		u32_val = of_get_property(child_node, "delay", &len);
+		if (!u32_val || len != 4) {
+			dev_err(&dev->dev, "Failed to read property: delay\n");
+			goto out_err;
+		}
+		cur_dev->chip.chip_delay = *u32_val;
+
+		u32_val = of_get_property(child_node, "banksettings", &len);
+		if (!u32_val || len != 4) {
+			dev_err(&dev->dev, "Failed to read property: banksettings\n");
+			goto out_err;
+		}
+		cur_dev->chip_settings.bank_settings = *u32_val;
+
+		cur_dev->device.name = "ndfc-chip";
+		cur_dev->device.id = num_chips;
+		cur_dev->device.num_resources = 1;
+		cur_dev->device.resource = &ndfc_resource;
+
+		cur_dev->device.dev.platform_data = &cur_dev->chip;
+		cur_dev->device.dev.parent = &ndfc_nand_device.dev;
+
+		u32_val = of_get_property(child_node, "eccbytes", &len);
+		if (!u32_val)
+			goto skip_oob_data;
+
+		cur_dev->ecclayout.eccbytes = *u32_val;
+
+		u32_val = of_get_property(child_node, "eccpos", &len);
+		if (!u32_val)
+			goto skip_oob_data;
+
+		len /= sizeof(u32);
+		if (len > 64)
+			goto skip_oob_data;
+
+		for (i = 0; i < len; i++)
+			cur_dev->ecclayout.eccpos[i] = u32_val[i];
+
+		u32_val = of_get_property(child_node, "oobfree", &len);
+		if (!u32_val)
+			goto skip_oob_data;
+
+		len /= sizeof(u32);
+		if (len & 1)
+			goto skip_oob_data;
+
+		if (len / 2 > MTD_MAX_OOBFREE_ENTRIES)
+			goto skip_oob_data;
+
+		for (i = 0; i < len; i += 2) {
+			cur_dev->ecclayout.oobfree[i / 2].offset =
+				u32_val[i];
+			cur_dev->ecclayout.oobfree[i / 2].length =
+				u32_val[i + 1];
+		}
+
+		cur_dev->chip.ecclayout = &cur_dev->ecclayout;
+skip_oob_data:
+		cur_dev->chip.nr_partitions = num_part;
+		cur_dev->chip.partitions = partitions;
+
+		cur_dev->chip.priv = &cur_dev->chip_settings;
+
+		num_chips++;
+	}
+
+	platform_device_register(&ndfc_nand_device);
+	for (i = 0; i < ndfc_num_devices; i++)
+		platform_device_register(&ndfc_chips[i].device);
+	return 0;
+
+out_err:
+	for (i = 0; i < num_chips; i++)
+		kfree(ndfc_chips[i].chip.partitions);
+	kfree(ndfc_chips);
+	ndfc_chips = NULL;
+	return -EINVAL;
+}
+
+static int of_nand_remove(struct of_device *dev)
+{
+	int i;
+
+	for (i = 0; i < ndfc_num_devices; i++)
+		platform_device_unregister(&ndfc_chips[i].device);
+	platform_device_unregister(&ndfc_nand_device);
+	kfree(ndfc_chips);
+	ndfc_chips = NULL;
+	return 0;
+}
+
+static struct of_device_id of_nand_match[] = {
+	{
+		.compatible = "ibm,ndfc",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_nand_match);
+
+static struct of_platform_driver of_flash_driver = {
+	.name           = "of-ibm-ndfc",
+	.match_table    = of_nand_match,
+	.probe          = of_nand_probe,
+	.remove         = of_nand_remove,
+};
+
+static int __init agco_nand_init(void)
+{
+	return of_register_platform_driver(&of_flash_driver);
+}
+
+static void __exit agco_nand_exit(void)
+{
+	of_unregister_platform_driver(&of_flash_driver);
+}
+
+module_init(agco_nand_init);
+module_exit(agco_nand_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Sebastian Siewior <bigeasy@linutronix.de>");
+MODULE_DESCRIPTION("OF 2 PDEV converter for ndfc");
-- 
1.5.5.2
