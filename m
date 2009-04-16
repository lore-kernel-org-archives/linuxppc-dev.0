Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH 1/3 v3] mtd: physmap_of: Add multiple regions and
	concatenation support
Date: Thu, 16 Apr 2009 14:10:45 +0200
Message-Id: <1239883845-17804-1-git-send-email-sr@denx.de>
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support to handle multiple non-identical chips in one
flash device tree node. It also adds concat support to physmap_of. This
makes it possible to support e.g. the Intel P30 48F4400 chips which
internally consists of 2 non-identical NOR chips on one die. Additionally
partitions now can span over multiple chips.

To describe such a chip's, multiple "reg" tuples are now supported in one
flash device tree node. Here an dts example:

        flash@f0000000,0 {
                #address-cells = <1>;
                #size-cells = <1>;
                compatible = "cfi-flash";
                reg = <0 0x00000000 0x02000000
                       0 0x02000000 0x02000000>;
                bank-width = <2>;
                partition@0 {
                        label = "test-part1";
                        reg = <0 0x04000000>;
                };
        };

Signed-off-by: Stefan Roese <sr@denx.de>
Reviewd-by: Grant Likely <grant.likely@secretlab.ca>
---
Changes in ver3:
- s/4/sizeof(u32)

Changes in ver2 (as suggested by Grant Likely):
- Removed MAX_RESOURCES introduced in ver1. Now we don't have a hard limit
  for "reg" tuples anymore.
- Used of_n_addr_cells() and of_n_size_cells() to determine size of each tuple.

 drivers/mtd/maps/physmap_of.c |  199 +++++++++++++++++++++++++++++------------
 1 files changed, 143 insertions(+), 56 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index c83a60f..39d357b 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -20,16 +20,23 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/concat.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
+struct of_flash_list {
+	struct mtd_info *mtd;
+	struct map_info map;
+	struct resource *res;
+};
+
 struct of_flash {
-	struct mtd_info		*mtd;
-	struct map_info		map;
-	struct resource		*res;
+	struct mtd_info		*cmtd;
 #ifdef CONFIG_MTD_PARTITIONS
 	struct mtd_partition	*parts;
 #endif
+	int list_size; /* number of elements in of_flash_list */
+	struct of_flash_list	list[0];
 };
 
 #ifdef CONFIG_MTD_PARTITIONS
@@ -88,30 +95,44 @@ static int parse_obsolete_partitions(struct of_device *dev,
 static int of_flash_remove(struct of_device *dev)
 {
 	struct of_flash *info;
+	int i;
 
 	info = dev_get_drvdata(&dev->dev);
 	if (!info)
 		return 0;
 	dev_set_drvdata(&dev->dev, NULL);
 
-	if (info->mtd) {
+#ifdef CONFIG_MTD_CONCAT
+	if (info->cmtd != info->list[0].mtd) {
+		del_mtd_device(info->cmtd);
+		mtd_concat_destroy(info->cmtd);
+	}
+#endif
+
+	if (info->cmtd) {
 		if (OF_FLASH_PARTS(info)) {
-			del_mtd_partitions(info->mtd);
+			del_mtd_partitions(info->cmtd);
 			kfree(OF_FLASH_PARTS(info));
 		} else {
-			del_mtd_device(info->mtd);
+			del_mtd_device(info->cmtd);
 		}
-		map_destroy(info->mtd);
 	}
 
-	if (info->map.virt)
-		iounmap(info->map.virt);
+	for (i = 0; i < info->list_size; i++) {
+		if (info->list[i].mtd)
+			map_destroy(info->list[i].mtd);
 
-	if (info->res) {
-		release_resource(info->res);
-		kfree(info->res);
+		if (info->list[i].map.virt)
+			iounmap(info->list[i].map.virt);
+
+		if (info->list[i].res) {
+			release_resource(info->list[i].res);
+			kfree(info->list[i].res);
+		}
 	}
 
+	kfree(info);
+
 	return 0;
 }
 
@@ -164,68 +185,130 @@ static int __devinit of_flash_probe(struct of_device *dev,
 	const char *probe_type = match->data;
 	const u32 *width;
 	int err;
-
-	err = -ENXIO;
-	if (of_address_to_resource(dp, 0, &res)) {
-		dev_err(&dev->dev, "Can't get IO address from device tree\n");
+	int i;
+	int count;
+	const u32 *p;
+	int reg_tuple_size;
+	struct mtd_info **mtd_list = NULL;
+
+	reg_tuple_size = (of_n_addr_cells(dp) + of_n_size_cells(dp)) * sizeof(u32);
+
+	/*
+	 * Get number of "reg" tuples. Scan for MTD devices on area's
+	 * described by each "reg" region. This makes it possible (including
+	 * the concat support) to support the Intel P30 48F4400 chips which
+	 * consists internally of 2 non-identical NOR chips on one die.
+	 */
+	p = of_get_property(dp, "reg", &count);
+	if (count % reg_tuple_size != 0) {
+		dev_err(&dev->dev, "Malformed reg property on %s\n",
+				dev->node->full_name);
+		err = -EINVAL;
 		goto err_out;
 	}
-
-       	dev_dbg(&dev->dev, "of_flash device: %.8llx-%.8llx\n",
-		(unsigned long long)res.start, (unsigned long long)res.end);
+	count /= reg_tuple_size;
 
 	err = -ENOMEM;
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(struct of_flash) +
+		       sizeof(struct of_flash_list) * count, GFP_KERNEL);
+	if (!info)
+		goto err_out;
+
+	mtd_list = kzalloc(sizeof(struct mtd_info) * count, GFP_KERNEL);
 	if (!info)
 		goto err_out;
 
 	dev_set_drvdata(&dev->dev, info);
 
-	err = -EBUSY;
-	info->res = request_mem_region(res.start, res.end - res.start + 1,
-				       dev_name(&dev->dev));
-	if (!info->res)
-		goto err_out;
+	for (i = 0; i < count; i++) {
+		err = -ENXIO;
+		if (of_address_to_resource(dp, i, &res)) {
+			dev_err(&dev->dev, "Can't get IO address from device"
+				" tree\n");
+			goto err_out;
+		}
 
-	err = -ENXIO;
-	width = of_get_property(dp, "bank-width", NULL);
-	if (!width) {
-		dev_err(&dev->dev, "Can't get bank width from device tree\n");
-		goto err_out;
-	}
+		dev_dbg(&dev->dev, "of_flash device: %.8llx-%.8llx\n",
+			(unsigned long long)res.start,
+			(unsigned long long)res.end);
+
+		err = -EBUSY;
+		info->list[i].res = request_mem_region(res.start, res.end -
+						       res.start + 1,
+						       dev_name(&dev->dev));
+		if (!info->list[i].res)
+			goto err_out;
+
+		err = -ENXIO;
+		width = of_get_property(dp, "bank-width", NULL);
+		if (!width) {
+			dev_err(&dev->dev, "Can't get bank width from device"
+				" tree\n");
+			goto err_out;
+		}
 
-	info->map.name = dev_name(&dev->dev);
-	info->map.phys = res.start;
-	info->map.size = res.end - res.start + 1;
-	info->map.bankwidth = *width;
+		info->list[i].map.name = dev_name(&dev->dev);
+		info->list[i].map.phys = res.start;
+		info->list[i].map.size = res.end - res.start + 1;
+		info->list[i].map.bankwidth = *width;
+
+		err = -ENOMEM;
+		info->list[i].map.virt = ioremap(info->list[i].map.phys,
+						 info->list[i].map.size);
+		if (!info->list[i].map.virt) {
+			dev_err(&dev->dev, "Failed to ioremap() flash"
+				" region\n");
+			goto err_out;
+		}
 
-	err = -ENOMEM;
-	info->map.virt = ioremap(info->map.phys, info->map.size);
-	if (!info->map.virt) {
-		dev_err(&dev->dev, "Failed to ioremap() flash region\n");
-		goto err_out;
-	}
+		simple_map_init(&info->list[i].map);
 
-	simple_map_init(&info->map);
+		if (probe_type) {
+			info->list[i].mtd = do_map_probe(probe_type,
+							 &info->list[i].map);
+		} else {
+			info->list[i].mtd = obsolete_probe(dev,
+							   &info->list[i].map);
+		}
+		mtd_list[i] = info->list[i].mtd;
 
-	if (probe_type)
-		info->mtd = do_map_probe(probe_type, &info->map);
-	else
-		info->mtd = obsolete_probe(dev, &info->map);
+		err = -ENXIO;
+		if (!info->list[i].mtd) {
+			dev_err(&dev->dev, "do_map_probe() failed\n");
+			goto err_out;
+		} else {
+			info->list_size++;
+		}
+		info->list[i].mtd->owner = THIS_MODULE;
+		info->list[i].mtd->dev.parent = &dev->dev;
+	}
 
-	err = -ENXIO;
-	if (!info->mtd) {
-		dev_err(&dev->dev, "do_map_probe() failed\n");
-		goto err_out;
+	err = 0;
+	if (info->list_size == 1) {
+		info->cmtd = info->list[0].mtd;
+	} else if (info->list_size > 1) {
+		/*
+		 * We detected multiple devices. Concatenate them together.
+		 */
+#ifdef CONFIG_MTD_CONCAT
+		info->cmtd = mtd_concat_create(mtd_list, info->list_size,
+					       dev_name(&dev->dev));
+		if (info->cmtd == NULL)
+			err = -ENXIO;
+#else
+		printk(KERN_ERR "physmap_of: multiple devices "
+		       "found but MTD concat support disabled.\n");
+		err = -ENXIO;
+#endif
 	}
-	info->mtd->owner = THIS_MODULE;
-	info->mtd->dev.parent = &dev->dev;
+	if (err)
+		goto err_out;
 
 #ifdef CONFIG_MTD_PARTITIONS
 	/* First look for RedBoot table or partitions on the command
 	 * line, these take precedence over device tree information */
-	err = parse_mtd_partitions(info->mtd, part_probe_types,
-	                           &info->parts, 0);
+	err = parse_mtd_partitions(info->cmtd, part_probe_types,
+				   &info->parts, 0);
 	if (err < 0)
 		return err;
 
@@ -244,15 +327,19 @@ static int __devinit of_flash_probe(struct of_device *dev,
 	}
 
 	if (err > 0)
-		add_mtd_partitions(info->mtd, info->parts, err);
+		add_mtd_partitions(info->cmtd, info->parts, err);
 	else
 #endif
-		add_mtd_device(info->mtd);
+		add_mtd_device(info->cmtd);
+
+	kfree(mtd_list);
 
 	return 0;
 
 err_out:
+	kfree(mtd_list);
 	of_flash_remove(dev);
+
 	return err;
 }
 
-- 
1.6.2.3
