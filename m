Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by ozlabs.org (Postfix) with ESMTP id C51C6DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 20:55:45 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linux-mtd@lists.infradead.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] mtd: physmap_of: Add multiple regions and concatenation
	support
Date: Fri,  3 Apr 2009 11:55:34 +0200
Message-Id: <1238752534-7718-1-git-send-email-sr@denx.de>
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
CC: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/mtd/maps/physmap_of.c |  174 ++++++++++++++++++++++++++++-------------
 1 files changed, 120 insertions(+), 54 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 5fcfec0..c1c2d08 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -20,13 +20,17 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/concat.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
+#define MAX_RESOURCES		4
+
 struct of_flash {
-	struct mtd_info		*mtd;
-	struct map_info		map;
-	struct resource		*res;
+	struct mtd_info		*mtd[MAX_RESOURCES];
+	struct mtd_info		*cmtd;
+	struct map_info		map[MAX_RESOURCES];
+	struct resource		*res[MAX_RESOURCES];
 #ifdef CONFIG_MTD_PARTITIONS
 	struct mtd_partition	*parts;
 #endif
@@ -88,28 +92,40 @@ static int parse_obsolete_partitions(struct of_device *dev,
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
+	if (info->cmtd != info->mtd[0]) {
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
+	for (i = 0; i < MAX_RESOURCES; i++) {
+		if (info->mtd[i])
+			map_destroy(info->mtd[i]);
+
+		if (info->map[i].virt)
+			iounmap(info->map[i].virt);
 
-	if (info->res) {
-		release_resource(info->res);
-		kfree(info->res);
+		if (info->res[i]) {
+			release_resource(info->res[i]);
+			kfree(info->res[i]);
+		}
 	}
 
 	return 0;
@@ -164,15 +180,25 @@ static int __devinit of_flash_probe(struct of_device *dev,
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
+	int devices_found = 0;
+
+	/*
+	 * Get number of "reg" tuples. Scan for MTD devices on area's
+	 * described by each "reg" region. This makes it possible (including
+	 * the concat support) to support the Intel P30 48F4400 chips which
+	 * consists internally of 2 non-identical NOR chips on one die.
+	 */
+	p = of_get_property(dp, "reg", &count);
+	if (count % 12 != 0) {
+		dev_err(&dev->dev, "Malformed reg property on %s\n",
+				dev->node->full_name);
+		err = -EINVAL;
 		goto err_out;
 	}
-
-       	dev_dbg(&dev->dev, "of_flash device: %.8llx-%.8llx\n",
-		(unsigned long long)res.start, (unsigned long long)res.end);
+	count /= 12;
 
 	err = -ENOMEM;
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
@@ -181,50 +207,90 @@ static int __devinit of_flash_probe(struct of_device *dev,
 
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
+		info->res[i] = request_mem_region(res.start, res.end -
+						  res.start + 1,
+						  dev_name(&dev->dev));
+		if (!info->res[i])
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
+		info->map[i].name = dev_name(&dev->dev);
+		info->map[i].phys = res.start;
+		info->map[i].size = res.end - res.start + 1;
+		info->map[i].bankwidth = *width;
+
+		err = -ENOMEM;
+		info->map[i].virt = ioremap(info->map[i].phys,
+					    info->map[i].size);
+		if (!info->map[i].virt) {
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
+		simple_map_init(&info->map[i]);
 
-	simple_map_init(&info->map);
+		if (probe_type)
+			info->mtd[i] = do_map_probe(probe_type, &info->map[i]);
+		else
+			info->mtd[i] = obsolete_probe(dev, &info->map[i]);
 
-	if (probe_type)
-		info->mtd = do_map_probe(probe_type, &info->map);
-	else
-		info->mtd = obsolete_probe(dev, &info->map);
+		err = -ENXIO;
+		if (!info->mtd[i]) {
+			dev_err(&dev->dev, "do_map_probe() failed\n");
+			goto err_out;
+		} else {
+			devices_found++;
+		}
+		info->mtd[i]->owner = THIS_MODULE;
+	}
 
-	err = -ENXIO;
-	if (!info->mtd) {
-		dev_err(&dev->dev, "do_map_probe() failed\n");
-		goto err_out;
+	err = 0;
+	if (devices_found == 1) {
+		info->cmtd = info->mtd[0];
+	} else if (devices_found > 1) {
+		/*
+		 * We detected multiple devices. Concatenate them together.
+		 */
+#ifdef CONFIG_MTD_CONCAT
+		info->cmtd = mtd_concat_create(info->mtd, devices_found,
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
 
@@ -243,10 +309,10 @@ static int __devinit of_flash_probe(struct of_device *dev,
 	}
 
 	if (err > 0)
-		add_mtd_partitions(info->mtd, info->parts, err);
+		add_mtd_partitions(info->cmtd, info->parts, err);
 	else
 #endif
-		add_mtd_device(info->mtd);
+		add_mtd_device(info->cmtd);
 
 	return 0;
 
-- 
1.6.2.2
