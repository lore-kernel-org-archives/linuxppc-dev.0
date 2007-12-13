Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1648EDE0AB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 04:24:04 +1100 (EST)
Date: Thu, 13 Dec 2007 11:15:52 -0600
From: Scott Wood <scottwood@freescale.com>
To: dwmw2@infradead.org
Subject: [PATCH 3/4] mtd: Factor out OF partition support from the NOR driver.
Message-ID: <20071213171552.GB4459@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071213171528.GA4440@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/mtd/Kconfig            |    8 ++++
 drivers/mtd/Makefile           |    1 +
 drivers/mtd/maps/physmap_of.c  |   88 ++++++++++++---------------------------
 drivers/mtd/ofpart.c           |   68 +++++++++++++++++++++++++++++++
 include/linux/mtd/partitions.h |    9 ++++-
 5 files changed, 112 insertions(+), 62 deletions(-)
 create mode 100644 drivers/mtd/ofpart.c

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 8848e8a..b729410 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -150,6 +150,14 @@ config MTD_AFS_PARTS
 	  for your particular device. It won't happen automatically. The
 	  'armflash' map driver (CONFIG_MTD_ARMFLASH) does this, for example.
 
+config MTD_OF_PARTS
+	tristate "Flash partition map based on OF description"
+	depends on PPC_OF && MTD_PARTITIONS
+	help
+	  This provides a partition parsing function which derives
+	  the partition map from the children of the flash node,
+	  as described in Documentation/powerpc/booting-without-of.txt.
+
 comment "User Modules And Translation Layers"
 
 config MTD_CHAR
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 7f0b04b..538e33d 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MTD_CONCAT)	+= mtdconcat.o
 obj-$(CONFIG_MTD_REDBOOT_PARTS) += redboot.o
 obj-$(CONFIG_MTD_CMDLINE_PARTS) += cmdlinepart.o
 obj-$(CONFIG_MTD_AFS_PARTS)	+= afs.o
+obj-$(CONFIG_MTD_OF_PARTS)      += ofpart.o
 
 # 'Users' - code which presents functionality to userspace.
 obj-$(CONFIG_MTD_CHAR)		+= mtdchar.o
diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index aeed9ea..49acd41 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -80,64 +80,6 @@ static int parse_obsolete_partitions(struct of_device *dev,
 
 	return nr_parts;
 }
-
-static int __devinit parse_partitions(struct of_flash *info,
-				      struct of_device *dev)
-{
-	const char *partname;
-	static const char *part_probe_types[]
-		= { "cmdlinepart", "RedBoot", NULL };
-	struct device_node *dp = dev->node, *pp;
-	int nr_parts, i;
-
-	/* First look for RedBoot table or partitions on the command
-	 * line, these take precedence over device tree information */
-	nr_parts = parse_mtd_partitions(info->mtd, part_probe_types,
-					&info->parts, 0);
-	if (nr_parts > 0) {
-		add_mtd_partitions(info->mtd, info->parts, nr_parts);
-		return 0;
-	}
-
-	/* First count the subnodes */
-	nr_parts = 0;
-	for (pp = dp->child; pp; pp = pp->sibling)
-		nr_parts++;
-
-	if (nr_parts == 0)
-		return parse_obsolete_partitions(dev, info, dp);
-
-	info->parts = kzalloc(nr_parts * sizeof(*info->parts),
-			      GFP_KERNEL);
-	if (!info->parts)
-		return -ENOMEM;
-
-	for (pp = dp->child, i = 0; pp; pp = pp->sibling, i++) {
-		const u32 *reg;
-		int len;
-
-		reg = of_get_property(pp, "reg", &len);
-		if (!reg || (len != 2*sizeof(u32))) {
-			dev_err(&dev->dev, "Invalid 'reg' on %s\n",
-				dp->full_name);
-			kfree(info->parts);
-			info->parts = NULL;
-			return -EINVAL;
-		}
-		info->parts[i].offset = reg[0];
-		info->parts[i].size = reg[1];
-
-		partname = of_get_property(pp, "label", &len);
-		if (!partname)
-			partname = of_get_property(pp, "name", &len);
-		info->parts[i].name = (char *)partname;
-
-		if (of_get_property(pp, "read-only", &len))
-			info->parts[i].mask_flags = MTD_WRITEABLE;
-	}
-
-	return nr_parts;
-}
 #else /* MTD_PARTITIONS */
 #define	OF_FLASH_PARTS(info)		(0)
 #define parse_partitions(info, dev)	(0)
@@ -212,6 +154,10 @@ static struct mtd_info * __devinit obsolete_probe(struct of_device *dev,
 static int __devinit of_flash_probe(struct of_device *dev,
 				    const struct of_device_id *match)
 {
+#ifdef CONFIG_MTD_PARTITIONS
+	static const char *part_probe_types[]
+		= { "cmdlinepart", "RedBoot", NULL };
+#endif
 	struct device_node *dp = dev->node;
 	struct resource res;
 	struct of_flash *info;
@@ -274,13 +220,33 @@ static int __devinit of_flash_probe(struct of_device *dev,
 	}
 	info->mtd->owner = THIS_MODULE;
 
-	err = parse_partitions(info, dev);
+#ifdef CONFIG_MTD_PARTITIONS
+	/* First look for RedBoot table or partitions on the command
+	 * line, these take precedence over device tree information */
+	err = parse_mtd_partitions(info->mtd, part_probe_types,
+	                           &info->parts, 0);
 	if (err < 0)
-		goto err_out;
+		return err;
+
+#ifdef CONFIG_MTD_OF_PARTS
+	if (err == 0) {
+		err = of_mtd_parse_partitions(&dev->dev, info->mtd,
+		                              dp, &info->parts);
+		if (err < 0)
+			return err;
+	}
+#endif
+
+	if (err == 0) {
+		err = parse_obsolete_partitions(dev, info, dp);
+		if (err < 0)
+			return err;
+	}
 
 	if (err > 0)
-		add_mtd_partitions(info->mtd, OF_FLASH_PARTS(info), err);
+		add_mtd_partitions(info->mtd, info->parts, err);
 	else
+#endif
 		add_mtd_device(info->mtd);
 
 	return 0;
diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
new file mode 100644
index 0000000..6a36cb9
--- /dev/null
+++ b/drivers/mtd/ofpart.c
@@ -0,0 +1,68 @@
+/*
+ * Flash partitions described by the OF (or flattened) device tree
+ *
+ * Copyright (C) 2006 MontaVista Software Inc.
+ * Author: Vitaly Wool <vwool@ru.mvista.com>
+ *
+ * Revised to handle newer style flash binding by:
+ *   Copyright (C) 2007 David Gibson, IBM Corporation.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+int __devinit of_mtd_parse_partitions(struct device *dev,
+                                      struct mtd_info *mtd,
+                                      struct device_node *node,
+                                      struct mtd_partition **pparts)
+{
+	const char *partname;
+	struct device_node *pp;
+	int nr_parts, i;
+
+	/* First count the subnodes */
+	nr_parts = 0;
+	for (pp = node->child; pp; pp = pp->sibling)
+		nr_parts++;
+
+	if (nr_parts == 0)
+		return 0;
+
+	*pparts = kzalloc(nr_parts * sizeof(**pparts), GFP_KERNEL);
+	if (!*pparts)
+		return -ENOMEM;
+
+	for (pp = node->child, i = 0; pp; pp = pp->sibling, i++) {
+		const u32 *reg;
+		int len;
+
+		reg = of_get_property(pp, "reg", &len);
+		if (!reg || (len != 2*sizeof(u32))) {
+			dev_err(dev, "Invalid 'reg' on %s\n", node->full_name);
+			kfree(*pparts);
+			*pparts = NULL;
+			return -EINVAL;
+		}
+		(*pparts)[i].offset = reg[0];
+		(*pparts)[i].size = reg[1];
+
+		partname = of_get_property(pp, "label", &len);
+		if (!partname)
+			partname = of_get_property(pp, "name", &len);
+		(*pparts)[i].name = (char *)partname;
+
+		if (of_get_property(pp, "read-only", &len))
+			(*pparts)[i].mask_flags = MTD_WRITEABLE;
+	}
+
+	return nr_parts;
+}
+EXPORT_SYMBOL(of_mtd_parse_partitions);
diff --git a/include/linux/mtd/partitions.h b/include/linux/mtd/partitions.h
index da6b3d6..7c37d7e 100644
--- a/include/linux/mtd/partitions.h
+++ b/include/linux/mtd/partitions.h
@@ -71,5 +71,12 @@ extern int parse_mtd_partitions(struct mtd_info *master, const char **types,
 
 #define put_partition_parser(p) do { module_put((p)->owner); } while(0)
 
-#endif
+struct device;
+struct device_node;
+
+int __devinit of_mtd_parse_partitions(struct device *dev,
+                                      struct mtd_info *mtd,
+                                      struct device_node *node,
+                                      struct mtd_partition **pparts);
 
+#endif
-- 
1.5.3.7
