Return-Path: <dgibson@ozlabs.org>
Date: Thu, 20 Sep 2007 11:22:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Vitaly Wool <vwool@ru.mvista.com>, David Woodhouse <dwmw2@redhat.com>
Subject: Cleanups for physmap_of.c (v2)
Message-ID: <20070920012225.GG14404@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch includes a whole batch of smallish cleanups for
drivers/mtd/physmap_of.c.

	- A bunch of uneeded #includes are removed
	- We switch to the modern linux/of.h etc. in place of
asm/prom.h
	- Use some helper macros to avoid some ugly inline #ifdefs
	- A few lines of unreachable code are removed
	- A number of indentation / line-wrapping fixes
	- More consistent use of kernel idioms such as if (!p) instead
of if (p == NULL)
	- Clarify some printk()s and other informative strings.
	- parse_obsolete_partitions() now returns 0 if no partition
information is found, instead of returning -ENOENT which the caller
had to handle specially.
	- (the big one) Despite the name, this driver really has
nothing to do with drivers/mtd/physmap.c.  The fact that the flash
chips must be physically direct mapped is a constrant, but doesn't
really say anything about the actual purpose of this driver, which is
to instantiate MTD devices based on information from the device tree.
Therefore the physmap name is replaced everywhere within the file with
"of_flash".  The file itself and the Kconfig option is not renamed for
now (so that the diff is actually a diff).  That can come later.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

Reworked to apply on top of jwb's bugfix for not correctly handling
parse_obsolete_partitions() -ENOENT return value.

Index: working-2.6/drivers/mtd/maps/physmap_of.c
===================================================================
--- working-2.6.orig/drivers/mtd/maps/physmap_of.c	2007-09-20 11:16:37.000000000 +1000
+++ working-2.6/drivers/mtd/maps/physmap_of.c	2007-09-20 11:18:22.000000000 +1000
@@ -1,5 +1,5 @@
 /*
- * Normal mappings of chips in physical memory for OF devices
+ * Flash mappings described by the OF (or flattened) device tree
  *
  * Copyright (C) 2006 MontaVista Software Inc.
  * Author: Vitaly Wool <vwool@ru.mvista.com>
@@ -15,20 +15,15 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
-#include <linux/mtd/physmap.h>
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
-struct physmap_flash_info {
+struct of_flash {
 	struct mtd_info		*mtd;
 	struct map_info		map;
 	struct resource		*res;
@@ -38,8 +33,10 @@ struct physmap_flash_info {
 };
 
 #ifdef CONFIG_MTD_PARTITIONS
+#define OF_FLASH_PARTS(info)	((info)->parts)
+
 static int parse_obsolete_partitions(struct of_device *dev,
-				     struct physmap_flash_info *info,
+				     struct of_flash *info,
 				     struct device_node *dp)
 {
 	int i, plen, nr_parts;
@@ -50,17 +47,15 @@ static int parse_obsolete_partitions(str
 
 	part = of_get_property(dp, "partitions", &plen);
 	if (!part)
-		return -ENOENT;
+		return 0; /* No partitions found */
 
 	dev_warn(&dev->dev, "Device tree uses obsolete partition map binding\n");
 
 	nr_parts = plen / sizeof(part[0]);
 
-	info->parts = kzalloc(nr_parts * sizeof(struct mtd_partition), GFP_KERNEL);
-	if (!info->parts) {
-		printk(KERN_ERR "Can't allocate the flash partition data!\n");
+	info->parts = kzalloc(nr_parts * sizeof(*info->parts), GFP_KERNEL);
+	if (!info->parts)
 		return -ENOMEM;
-	}
 
 	names = of_get_property(dp, "partition-names", &plen);
 
@@ -86,8 +81,8 @@ static int parse_obsolete_partitions(str
 	return nr_parts;
 }
 
-static int __devinit process_partitions(struct physmap_flash_info *info,
-					struct of_device *dev)
+static int __devinit parse_partitions(struct of_flash *info,
+				      struct of_device *dev)
 {
 	const char *partname;
 	static const char *part_probe_types[]
@@ -109,89 +104,68 @@ static int __devinit process_partitions(
 	for (pp = dp->child; pp; pp = pp->sibling)
 		nr_parts++;
 
-	if (nr_parts) {
-		info->parts = kzalloc(nr_parts * sizeof(struct mtd_partition),
-				      GFP_KERNEL);
-		if (!info->parts) {
-			printk(KERN_ERR "Can't allocate the flash partition data!\n");
-			return -ENOMEM;
-		}
+	if (nr_parts == 0)
+		return parse_obsolete_partitions(dev, info, dp);
 
-		for (pp = dp->child, i = 0 ; pp; pp = pp->sibling, i++) {
-			const u32 *reg;
-			int len;
-
-			reg = of_get_property(pp, "reg", &len);
-			if (!reg || (len != 2*sizeof(u32))) {
-				dev_err(&dev->dev, "Invalid 'reg' on %s\n",
-					dp->full_name);
-				kfree(info->parts);
-				info->parts = NULL;
-				return -EINVAL;
-			}
-			info->parts[i].offset = reg[0];
-			info->parts[i].size = reg[1];
-
-			partname = of_get_property(pp, "label", &len);
-			if (!partname)
-				partname = of_get_property(pp, "name", &len);
-			info->parts[i].name = (char *)partname;
+	info->parts = kzalloc(nr_parts * sizeof(*info->parts),
+			      GFP_KERNEL);
+	if (!info->parts)
+		return -ENOMEM;
 
-			if (of_get_property(pp, "read-only", &len))
-				info->parts[i].mask_flags = MTD_WRITEABLE;
+	for (pp = dp->child, i = 0; pp; pp = pp->sibling, i++) {
+		const u32 *reg;
+		int len;
+
+		reg = of_get_property(pp, "reg", &len);
+		if (!reg || (len != 2*sizeof(u32))) {
+			dev_err(&dev->dev, "Invalid 'reg' on %s\n",
+				dp->full_name);
+			kfree(info->parts);
+			info->parts = NULL;
+			return -EINVAL;
 		}
-	} else {
-		nr_parts = parse_obsolete_partitions(dev, info, dp);
-		if (nr_parts == -ENOENT)
-			nr_parts = 0;
-	}
+		info->parts[i].offset = reg[0];
+		info->parts[i].size = reg[1];
 
-	if (nr_parts < 0)
-		return nr_parts;
+		partname = of_get_property(pp, "label", &len);
+		if (!partname)
+			partname = of_get_property(pp, "name", &len);
+		info->parts[i].name = (char *)partname;
 
-	if (nr_parts > 0)
-		add_mtd_partitions(info->mtd, info->parts, nr_parts);
-	else
-		add_mtd_device(info->mtd);
+		if (of_get_property(pp, "read-only", &len))
+			info->parts[i].mask_flags = MTD_WRITEABLE;
+	}
 
-	return 0;
+	return nr_parts;
 }
 #else /* MTD_PARTITIONS */
-static int __devinit process_partitions(struct physmap_flash_info *info,
-					struct device_node *dev)
-{
-	add_mtd_device(info->mtd);
-	return 0;
-}
+#define	OF_FLASH_PARTS(info)		(0)
+#define parse_partitions(info, dev)	(0)
 #endif /* MTD_PARTITIONS */
 
-static int of_physmap_remove(struct of_device *dev)
+static int of_flash_remove(struct of_device *dev)
 {
-	struct physmap_flash_info *info;
+	struct of_flash *info;
 
 	info = dev_get_drvdata(&dev->dev);
-	if (info == NULL)
+	if (!info)
 		return 0;
 	dev_set_drvdata(&dev->dev, NULL);
 
-	if (info->mtd != NULL) {
-#ifdef CONFIG_MTD_PARTITIONS
-		if (info->parts) {
+	if (info->mtd) {
+		if (OF_FLASH_PARTS(info)) {
 			del_mtd_partitions(info->mtd);
-			kfree(info->parts);
+			kfree(OF_FLASH_PARTS(info));
 		} else {
 			del_mtd_device(info->mtd);
 		}
-#else
-		del_mtd_device(info->mtd);
-#endif
 		map_destroy(info->mtd);
 	}
 
-	if (info->map.virt != NULL)
+	if (info->map.virt)
 		iounmap(info->map.virt);
 
-	if (info->res != NULL) {
+	if (info->res) {
 		release_resource(info->res);
 		kfree(info->res);
 	}
@@ -229,52 +203,49 @@ static struct mtd_info * __devinit obsol
 		return do_map_probe("jedec_probe", map);
 	} else {
 		if (strcmp(of_probe, "ROM") != 0)
-			dev_dbg(&dev->dev, "obsolete_probe: don't know probe type "
-				"'%s', mapping as rom\n", of_probe);
+			dev_warn(&dev->dev, "obsolete_probe: don't know probe "
+				 "type '%s', mapping as rom\n", of_probe);
 		return do_map_probe("mtd_rom", map);
 	}
 }
 
-static int __devinit of_physmap_probe(struct of_device *dev, const struct of_device_id *match)
+static int __devinit of_flash_probe(struct of_device *dev,
+				    const struct of_device_id *match)
 {
 	struct device_node *dp = dev->node;
 	struct resource res;
-	struct physmap_flash_info *info;
-	const char *probe_type = (const char *)match->data;
+	struct of_flash *info;
+	const char *probe_type = match->data;
 	const u32 *width;
 	int err;
 
+	err = -ENXIO;
 	if (of_address_to_resource(dp, 0, &res)) {
-		dev_err(&dev->dev, "Can't get the flash mapping!\n");
-		err = -EINVAL;
+		dev_err(&dev->dev, "Can't get IO address from device tree\n");
 		goto err_out;
 	}
 
-       	dev_dbg(&dev->dev, "physmap flash device: %.8llx at %.8llx\n",
-	    (unsigned long long)res.end - res.start + 1,
-	    (unsigned long long)res.start);
-
-	info = kzalloc(sizeof(struct physmap_flash_info), GFP_KERNEL);
-	if (info == NULL) {
-		err = -ENOMEM;
+       	dev_dbg(&dev->dev, "of_flash device: %.8llx-%.8llx\n",
+		(unsigned long long)res.start, (unsigned long long)res.end);
+
+	err = -ENOMEM;
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
 		goto err_out;
-	}
 	memset(info, 0, sizeof(*info));
 
 	dev_set_drvdata(&dev->dev, info);
 
+	err = -EBUSY;
 	info->res = request_mem_region(res.start, res.end - res.start + 1,
-			dev->dev.bus_id);
-	if (info->res == NULL) {
-		dev_err(&dev->dev, "Could not reserve memory region\n");
-		err = -ENOMEM;
+				       dev->dev.bus_id);
+	if (!info->res)
 		goto err_out;
-	}
 
+	err = -ENXIO;
 	width = of_get_property(dp, "bank-width", NULL);
-	if (width == NULL) {
-		dev_err(&dev->dev, "Can't get the flash bank width!\n");
-		err = -EINVAL;
+	if (!width) {
+		dev_err(&dev->dev, "Can't get bank width from device tree\n");
 		goto err_out;
 	}
 
@@ -283,10 +254,10 @@ static int __devinit of_physmap_probe(st
 	info->map.size = res.end - res.start + 1;
 	info->map.bankwidth = *width;
 
+	err = -ENOMEM;
 	info->map.virt = ioremap(info->map.phys, info->map.size);
-	if (info->map.virt == NULL) {
-		dev_err(&dev->dev, "Failed to ioremap flash region\n");
-		err = EIO;
+	if (!info->map.virt) {
+		dev_err(&dev->dev, "Failed to ioremap() flash region\n");
 		goto err_out;
 	}
 
@@ -297,25 +268,30 @@ static int __devinit of_physmap_probe(st
 	else
 		info->mtd = obsolete_probe(dev, &info->map);
 
-	if (info->mtd == NULL) {
-		dev_err(&dev->dev, "map_probe failed\n");
-		err = -ENXIO;
+	err = -ENXIO;
+	if (!info->mtd) {
+		dev_err(&dev->dev, "do_map_probe() failed\n");
 		goto err_out;
 	}
 	info->mtd->owner = THIS_MODULE;
 
-	return process_partitions(info, dev);
+	err = parse_partitions(info, dev);
+	if (err < 0)
+		goto err_out;
 
-err_out:
-	of_physmap_remove(dev);
-	return err;
+	if (err > 0)
+		add_mtd_partitions(info->mtd, OF_FLASH_PARTS(info), err);
+	else
+		add_mtd_device(info->mtd);
 
 	return 0;
 
-
+err_out:
+	of_flash_remove(dev);
+	return err;
 }
 
-static struct of_device_id of_physmap_match[] = {
+static struct of_device_id of_flash_match[] = {
 	{
 		.compatible	= "cfi-flash",
 		.data		= (void *)"cfi_probe",
@@ -337,30 +313,28 @@ static struct of_device_id of_physmap_ma
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(of, of_flash_match);
 
-MODULE_DEVICE_TABLE(of, of_physmap_match);
-
-
-static struct of_platform_driver of_physmap_flash_driver = {
-	.name		= "physmap-flash",
-	.match_table	= of_physmap_match,
-	.probe		= of_physmap_probe,
-	.remove		= of_physmap_remove,
+static struct of_platform_driver of_flash_driver = {
+	.name		= "of-flash",
+	.match_table	= of_flash_match,
+	.probe		= of_flash_probe,
+	.remove		= of_flash_remove,
 };
 
-static int __init of_physmap_init(void)
+static int __init of_flash_init(void)
 {
-	return of_register_platform_driver(&of_physmap_flash_driver);
+	return of_register_platform_driver(&of_flash_driver);
 }
 
-static void __exit of_physmap_exit(void)
+static void __exit of_flash_exit(void)
 {
-	of_unregister_platform_driver(&of_physmap_flash_driver);
+	of_unregister_platform_driver(&of_flash_driver);
 }
 
-module_init(of_physmap_init);
-module_exit(of_physmap_exit);
+module_init(of_flash_init);
+module_exit(of_flash_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Vitaly Wool <vwool@ru.mvista.com>");
-MODULE_DESCRIPTION("Configurable MTD map driver for OF");
+MODULE_DESCRIPTION("Device tree based MTD map driver");

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
