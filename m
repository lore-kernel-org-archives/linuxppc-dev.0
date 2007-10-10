Return-Path: <SRS0=iyrW=PE=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id E095FDDF88
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 16:31:55 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][POWERPC] Add arch/powerpc 4xx NDFC (NAND) support
Date: Wed, 10 Oct 2007 08:32:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710100832.13105.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes the PPC4xx NAND flash controller (NDFC) device-tree
friendly using OF glue code to create and insert necessary platform
devices. Such "constructor" approach makes NAND usable under
arch/powerpc yet keeping full compatibility with arch/ppc.

This patch also introduces a "common" (not NOR only)
of_parse_flash_partitions() routine in mtdpart.c that can/should be
used by all drivers parsing device-tree partition informations. The
current implementation is not compatible with the current physmap_of
version and needs some additional work to make it really usable from
both "drivers", physmap_of and ndfc_of. I'm just posting it right now
to get some feedback, since this stuff is already sitting here too
long on my disk and waiting for upstream merge.

Any feedback welcome. Thanks.

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit 721a340398e66872b9cc7e8b630fc92a7681ca04
tree ffbe1194146cb4fc324755f35c9062025b7ec0f6
parent 26f571d7c968dbd30656fc1421eeb0d9088aaad9
author Stefan Roese <sr@denx.de> Mon, 08 Oct 2007 16:00:49 +0200
committer Stefan Roese <sr@denx.de> Mon, 08 Oct 2007 16:00:49 +0200

 arch/powerpc/boot/dts/sequoia.dts    |   32 +++++++
 arch/powerpc/platforms/44x/Makefile  |    6 +
 arch/powerpc/platforms/44x/ndfc_of.c |  158 ++++++++++++++++++++++++++++++++++
 drivers/mtd/mtdpart.c                |   61 +++++++++++++
 drivers/mtd/nand/ndfc.c              |    6 +
 include/linux/mtd/partitions.h       |    2 
 6 files changed, 264 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index 36be75b..9b15482 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -122,6 +122,38 @@
 			interrupt-map-mask = <ffffffff>;
 		};
 
+		ndfc@1d0000000, {
+			device_type = "nand";
+			compatible = "ibm,ndfc";
+			reg = <1 d0000000 2000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* ndfc stuff, composed off ndfc_settings. */
+			/* select bank on CE[3], 4 Addr, 1 Col 3 Row 512b page */
+			ccr-settings = <3001000>;
+
+			chip@0 {
+				device_type = "nand-chip";
+				reg = <0 1>;
+				chip-nr = <1>;
+				chip-offset = <3>;
+				chip-delay = <50>;
+				chip-bank-settings = <80002222>;
+
+				/* normal NAND ECC stuff */
+				ecc-bytes = <6>;
+				ecc-pos = <0 1 2 3 6 7>;
+				/* list of tuples assumed here */
+				ecc-oobfree = <8 8>;
+
+				partition@0 {
+					label = "content";
+					reg = <0 0>;
+				};
+			};
+		};
+
 		POB0: opb {
 		  	compatible = "ibm,opb-440epx", "ibm,opb";
 			#address-cells = <1>;
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 10ce674..d6195ee 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -1,4 +1,8 @@
 obj-$(CONFIG_44x)	:= misc_44x.o
 obj-$(CONFIG_EBONY)	+= ebony.o
-obj-$(CONFIG_BAMBOO) += bamboo.o
+obj-$(CONFIG_BAMBOO)	+= bamboo.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
+
+ifeq ($(CONFIG_MTD_NAND_NDFC),y)
+obj-y			+= ndfc_of.o
+endif
diff --git a/arch/powerpc/platforms/44x/ndfc_of.c b/arch/powerpc/platforms/44x/ndfc_of.c
new file mode 100644
index 0000000..e5b41cf
--- /dev/null
+++ b/arch/powerpc/platforms/44x/ndfc_of.c
@@ -0,0 +1,158 @@
+/*
+ * PPC4xx NAND wrapper from device tree to platform device
+ *
+ * Stefan Roese <sr@denx.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/ndfc.h>
+#include <linux/of.h>
+
+static struct ndfc_controller_settings ndfc_settings;
+static struct platform_nand_ctrl nand_ctrl = {
+	.priv = &ndfc_settings,
+};
+
+static struct ndfc_chip_settings chip_settings;
+static struct nand_ecclayout ecclayout;
+static struct mtd_partition *nand_parts;
+
+static struct platform_nand_chip nand_chip = {
+	.ecclayout = &ecclayout,
+	.priv = &chip_settings,
+};
+
+static struct resource r;
+
+static struct platform_device ndfc_dev = {
+	.name = "ndfc-nand",
+	.id = 0,
+	.num_resources = 1,
+	.resource = &r,
+	.dev = {
+		.platform_data = &nand_ctrl,
+	}
+};
+
+static struct platform_device nand_dev = {
+	.name = "ndfc-chip",
+	.id = 0,
+	.num_resources = 1,
+	.resource = &r,
+	.dev = {
+		.platform_data = &nand_chip,
+		.parent = &ndfc_dev.dev,
+	}
+};
+
+/* Until this will be settled */
+static inline u32 of_get_int(struct device_node *np, const char *name)
+{
+	unsigned int size;
+	const u32 *prop = of_get_property(np, name, &size);
+
+	if ((prop == NULL) || (size != sizeof(int))) {
+		printk(KERN_WARNING "%s property missing!\n", __FUNCTION__);
+		return 0;
+	}
+
+	return *prop;
+}
+
+static int ppc4xx_setup_nand_chip_node(struct device_node *dev)
+{
+	unsigned int what = -ENODEV;
+	unsigned int size, amnt;
+	const u32 *prop;
+	int i;
+
+	/* process necessary properties */
+	what = of_get_int(dev, "chip-nr");
+	nand_chip.nr_chips = what;
+
+	what = of_get_int(dev, "chip-offset");
+	nand_chip.chip_offset = what;
+
+	what = of_get_int(dev, "chip-delay");
+	nand_chip.chip_delay = what;
+
+	what = of_get_int(dev, "ecc-bytes");
+	ecclayout.eccbytes = what;
+
+	what = of_get_int(dev, "chip-bank-settings");
+	chip_settings.bank_settings = what;
+
+	prop = of_get_property(dev, "ecc-pos", &size);
+	for (i = 0; i < (size/sizeof(unsigned int)); i++)
+		ecclayout.eccpos[i] = prop[i];
+
+	prop = of_get_property(dev, "ecc-oobfree", &size);
+	amnt = size/sizeof(unsigned int);
+
+	for (i = 0; i < amnt; i += 2) {
+		nand_chip.ecclayout->oobfree[i].offset = prop[i];
+		nand_chip.ecclayout->oobfree[i].length = prop[i+1];
+	}
+
+	nand_chip.nr_partitions = of_parse_flash_partitions(dev, &nand_parts);
+	nand_chip.partitions = nand_parts;
+
+	return 0;
+}
+
+static int __init ppc4xx_setup_nand_node(struct device_node *dev)
+{
+	struct device_node *child = NULL;
+	int ret = 0;
+
+	memset(&r, 0, sizeof(r));
+
+	/* generic NDFC register */
+	ret = of_address_to_resource(dev, 0, &r);
+	if (ret)
+		goto err;
+
+	/* Now let's create platform_data stuff based on dts entries */
+	ret = of_get_int(dev, "ccr-settings");
+
+	ndfc_settings.ccr_settings = ret;
+	ndfc_settings.ndfc_erpn = r.start & 0xf00000000ULL;
+
+	child = of_get_next_child(dev, NULL);
+	/* NAND platform device is sole, so assuming one child of ndfc node */
+	if (child != NULL)
+		ppc4xx_setup_nand_chip_node(child);
+
+	ndfc_dev.resource = &r;
+	nand_dev.resource = &r;
+
+	platform_device_register(&ndfc_dev);
+	platform_device_register(&nand_dev);
+
+err:
+	return ret;
+}
+
+static int ppc4xx_init_nand(void)
+{
+	struct device_node *np =
+		of_find_compatible_node(NULL, "nand", "ibm,ndfc");
+
+	if (np != NULL)
+		ppc4xx_setup_nand_node(np);
+
+	return 0;
+}
+arch_initcall(ppc4xx_init_nand);
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 6174a97..cc620ee 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -21,6 +21,10 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/compatmac.h>
 
+#ifdef CONFIG_PPC_MERGE
+#include <linux/of.h>
+#endif
+
 /* Our partition linked list */
 static LIST_HEAD(mtd_partitions);
 
@@ -557,6 +561,63 @@ int parse_mtd_partitions(struct mtd_info *master, const char **types,
 	return ret;
 }
 
+#ifdef CONFIG_PPC_MERGE
+int of_parse_flash_partitions(struct device_node *dp,
+			      struct mtd_partition **mparts)
+{
+	int nr_parts = 0;
+	int i;
+	struct device_node *pp;
+	const char *partname;
+	struct mtd_partition *parts;
+
+	/* First count the subnodes */
+	for (pp = dp->child; pp; pp = pp->sibling)
+		nr_parts++;
+
+	if (nr_parts) {
+		parts = kzalloc(nr_parts * sizeof(struct mtd_partition),
+				GFP_KERNEL);
+		if (!parts) {
+			printk(KERN_ERR
+			       "Can't allocate the flash partition data!\n");
+			return -ENOMEM;
+		}
+
+		for (pp = dp->child, i = 0 ; pp; pp = pp->sibling, i++) {
+			const u32 *reg;
+			int len;
+
+			reg = of_get_property(pp, "reg", &len);
+			if (!reg || (len != 2*sizeof(u32))) {
+				printk(KERN_ERR "Invalid 'reg' on %s\n",
+				       dp->full_name);
+				kfree(parts);
+				parts = NULL;
+				return -EINVAL;
+			}
+			parts[i].offset = reg[0];
+			parts[i].size = reg[1];
+
+			partname = of_get_property(pp, "label", &len);
+			if (!partname)
+				partname = of_get_property(pp, "name", &len);
+			parts[i].name = (char *)partname;
+			if (of_get_property(pp, "read-only", &len))
+				parts[i].mask_flags = MTD_WRITEABLE;
+			(*mparts) = parts;
+		}
+	} else {
+		printk(KERN_ERR
+		       "Node %s does not seem to contain partitions definition!\n",
+		       dp->full_name);
+		return -EINVAL;
+	}
+
+	return nr_parts;
+}
+#endif
+
 EXPORT_SYMBOL_GPL(parse_mtd_partitions);
 EXPORT_SYMBOL_GPL(register_mtd_parser);
 EXPORT_SYMBOL_GPL(deregister_mtd_parser);
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index fd7a8d5..7901019 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -24,7 +24,9 @@
 #include <linux/platform_device.h>
 
 #include <asm/io.h>
+#ifndef CONFIG_PPC_MERGE
 #include <asm/ibm44x.h>
+#endif
 
 struct ndfc_nand_mtd {
 	struct mtd_info			mtd;
@@ -230,7 +232,11 @@ static int ndfc_nand_probe(struct platform_device *pdev)
 	struct ndfc_controller *ndfc = &ndfc_ctrl;
 	unsigned long long phys = settings->ndfc_erpn | res->start;
 
+#if !defined(CONFIG_PHYS_64BIT) || defined(CONFIG_PPC_MERGE)
+	ndfc->ndfcbase = ioremap((phys_addr_t)phys, res->end - res->start + 1);
+#else
 	ndfc->ndfcbase = ioremap64(phys, res->end - res->start + 1);
+#endif
 	if (!ndfc->ndfcbase) {
 		printk(KERN_ERR "NDFC: ioremap failed\n");
 		return -EIO;
diff --git a/include/linux/mtd/partitions.h b/include/linux/mtd/partitions.h
index da6b3d6..546a098 100644
--- a/include/linux/mtd/partitions.h
+++ b/include/linux/mtd/partitions.h
@@ -68,6 +68,8 @@ extern int register_mtd_parser(struct mtd_part_parser *parser);
 extern int deregister_mtd_parser(struct mtd_part_parser *parser);
 extern int parse_mtd_partitions(struct mtd_info *master, const char **types,
 				struct mtd_partition **pparts, unsigned long origin);
+extern int of_parse_flash_partitions(struct device_node *node,
+				     struct mtd_partition **parts);
 
 #define put_partition_parser(p) do { module_put((p)->owner); } while(0)
 
