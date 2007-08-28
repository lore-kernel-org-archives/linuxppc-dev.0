Return-Path: <dgibson@ozlabs.org>
Date: Tue, 28 Aug 2007 13:47:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Document and implement an improved flash device binding for powerpc
Message-ID: <20070828034751.GD6811@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch replaces the binding for flash chips in
booting-without-of.txt with an clarified and improved version.  It
also makes drivers/mtd/maps/physmap_of.c recognize this new binding.
Finally it revises the Ebony device tree source to use the new binding
as an example.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
I don't know that this is ready yet, but I thought I'd try to kick
along the rather stalled process of getting this new flash binding in
place by sending out my current draft.

Index: working-2.6/Documentation/powerpc/booting-without-of.txt
===================================================================
--- working-2.6.orig/Documentation/powerpc/booting-without-of.txt	2007-08-28 13:25:42.000000000 +1000
+++ working-2.6/Documentation/powerpc/booting-without-of.txt	2007-08-28 13:38:10.000000000 +1000
@@ -1757,45 +1757,46 @@ platforms are moved over to use the flat
 		};
 	};
 
-    j) Flash chip nodes
+   j) CFI or JEDEC memory-mapped NOR flash
 
     Flash chips (Memory Technology Devices) are often used for solid state
     file systems on embedded devices.
 
-    Required properties:
-
-     - device_type : has to be "rom"
-     - compatible : Should specify what this flash device is compatible with.
-       Currently, this is most likely to be "direct-mapped" (which
-       corresponds to the MTD physmap mapping driver).
-     - reg : Offset and length of the register set (or memory mapping) for
-       the device.
-     - bank-width : Width of the flash data bus in bytes. Required
-       for the NOR flashes (compatible == "direct-mapped" and others) ONLY.
-
-    Recommended properties :
-
-     - partitions : Several pairs of 32-bit values where the first value is
-       partition's offset from the start of the device and the second one is
-       partition size in bytes with LSB used to signify a read only
-       partition (so, the partition size should always be an even number).
-     - partition-names : The list of concatenated zero terminated strings
-       representing the partition names.
-     - probe-type : The type of probe which should be done for the chip
-       (JEDEC vs CFI actually). Valid ONLY for NOR flashes.
-
-   Example:
-
- 	flash@ff000000 {
- 		device_type = "rom";
- 		compatible = "direct-mapped";
- 		probe-type = "CFI";
- 		reg = <ff000000 01000000>;
- 		bank-width = <4>;
- 		partitions = <00000000 00f80000
- 			      00f80000 00080001>;
- 		partition-names = "fs\0firmware";
- 	};
+     - compatible : should contain the specific model of flash chip(s)
+       used, if known, followed by either "cfi-flash" or "jedec-flash"
+     - reg : Address range of the flash chip
+     - bank-width : Width (in bytes) of the flash bank.  Equal to the
+       device width times the number of interleaved chips.
+     - device-width : (optional) Width of a single flash chip.  If
+       omitted, assumed to be equal to 'bank-width'.
+     - #address-cells, #size-cells : Must be present if the flash has
+       sub-nodes representing partitions (see below).  In this case
+       both #address-cells and #size-cells must be equal to 1.
+
+    For JEDEC compatible devices, the following additional properties
+    are defined:
+
+     - vendor-id : Contains the flash chip's vendor id (1 byte).
+     - device-id : Contains the flash chip's device id (1 byte).
+
+    In addition to the information on the flash bank itself, the
+    device tree may optionally contain additional information
+    describing partitions of the flash address space.  This can be
+    used on platforms which have strong conventions about which
+    portions of the flash are used for what purposes, but which don't
+    use an on-flash partition table such as RedBoot.
+
+    Each partitions is represented as a sub-node of the flash device.
+    Each node's name represents the name of the corresponding
+    partition of the flash device.
+
+    Flash partitions
+     - reg : The partition's offset and size within the flash bank.
+     - read-only : (optional) This parameter, if present, is a hint to
+       Linux that this flash partition should only be mounted
+       read-only.  This is usually used for flash partitions
+       containing early-boot firmware images or data which should not
+       be clobbered.
 
    k) Global Utilities Block
 
Index: working-2.6/drivers/mtd/maps/physmap_of.c
===================================================================
--- working-2.6.orig/drivers/mtd/maps/physmap_of.c	2007-08-28 13:25:42.000000000 +1000
+++ working-2.6/drivers/mtd/maps/physmap_of.c	2007-08-28 13:26:43.000000000 +1000
@@ -4,6 +4,9 @@
  * Copyright (C) 2006 MontaVista Software Inc.
  * Author: Vitaly Wool <vwool@ru.mvista.com>
  *
+ * Revised to handle newer style flash binding by:
+ *   Copyright (C) 2007 David Gibson, IBM Corporation.
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -30,56 +33,129 @@ struct physmap_flash_info {
 	struct map_info		map;
 	struct resource		*res;
 #ifdef CONFIG_MTD_PARTITIONS
-	int			nr_parts;
 	struct mtd_partition	*parts;
 #endif
 };
 
-static const char *rom_probe_types[] = { "cfi_probe", "jedec_probe", "map_rom", NULL };
-#ifdef CONFIG_MTD_PARTITIONS
-static const char *part_probe_types[] = { "cmdlinepart", "RedBoot", NULL };
-#endif
-
 #ifdef CONFIG_MTD_PARTITIONS
-static int parse_flash_partitions(struct device_node *node,
-		struct mtd_partition **parts)
+static int parse_obsolete_partitions(struct physmap_flash_info *info,
+				     struct device_node *dp)
 {
-	int i, plen, retval = -ENOMEM;
-	const  u32  *part;
-	const  char *name;
-
-	part = of_get_property(node, "partitions", &plen);
-	if (part == NULL)
-		goto err;
-
-	retval = plen / (2 * sizeof(u32));
-	*parts = kzalloc(retval * sizeof(struct mtd_partition), GFP_KERNEL);
-	if (*parts == NULL) {
+	int i, plen, nr_parts;
+	const struct {
+		u32 offset, len;
+	} *part;
+	const char *names;
+
+	part = of_get_property(dp, "partitions", &plen);
+	if (!part)
+		return -ENOENT;
+
+	nr_parts = plen / sizeof(part[0]);
+
+	info->parts = kzalloc(nr_parts * sizeof(struct mtd_partition), GFP_KERNEL);
+	if (!info->parts) {
 		printk(KERN_ERR "Can't allocate the flash partition data!\n");
-		goto err;
+		return -ENOMEM;
 	}
 
-	name = of_get_property(node, "partition-names", &plen);
+	names = of_get_property(dp, "partition-names", &plen);
 
-	for (i = 0; i < retval; i++) {
-		(*parts)[i].offset = *part++;
-		(*parts)[i].size   = *part & ~1;
-		if (*part++ & 1) /* bit 0 set signifies read only partition */
-			(*parts)[i].mask_flags = MTD_WRITEABLE;
+	for (i = 0; i < nr_parts; i++) {
+		info->parts[i].offset = part->offset;
+		info->parts[i].size   = part->len & ~1;
+		if (part->len & 1) /* bit 0 set signifies read only partition */
+			info->parts[i].mask_flags = MTD_WRITEABLE;
 
-		if (name != NULL && plen > 0) {
-			int len = strlen(name) + 1;
+		if (names && (plen > 0)) {
+			int len = strlen(names) + 1;
 
-			(*parts)[i].name = (char *)name;
+			info->parts[i].name = (char *)names;
 			plen -= len;
-			name += len;
-		} else
-			(*parts)[i].name = "unnamed";
+			names += len;
+		} else {
+			info->parts[i].name = "unnamed";
+		}
+
+		part++;
 	}
-err:
-	return retval;
+
+	return nr_parts;
 }
-#endif
+
+static int __devinit process_partitions(struct physmap_flash_info *info,
+					struct of_device *dev)
+{
+	static const char *part_probe_types[]
+		= { "cmdlinepart", "RedBoot", NULL };
+	struct device_node *dp = dev->node, *pp;
+	int nr_parts, i, err;
+
+	/* First look for RedBoot table or partitions on the command
+	 * line, these take precedence over device tree information */
+	nr_parts = parse_mtd_partitions(info->mtd, part_probe_types,
+					&info->parts, 0);
+	if (nr_parts > 0) {
+		add_mtd_partitions(info->mtd, info->parts, err);
+		return 0;
+	}
+
+	/* First count the subnodes */
+	nr_parts = 0;
+	for (pp = dp->child; pp; pp = pp->sibling)
+		nr_parts++;
+
+	if (nr_parts) {
+		info->parts = kzalloc(nr_parts * sizeof(struct mtd_partition),
+				      GFP_KERNEL);
+		if (!info->parts) {
+			printk(KERN_ERR "Can't allocate the flash partition data!\n");
+			return -ENOMEM;
+		}
+
+		for (pp = dp->child, i = 0 ; pp; pp = pp->sibling, i++) {
+			const u32 *reg;
+			int len;
+
+			reg = of_get_property(pp, "reg", &len);
+			if (!reg || (len != 2*sizeof(u32))) {
+				dev_err(&dev->dev, "Invalid 'reg' on %s\n",
+					dp->full_name);
+				kfree(info->parts);
+				info->parts = NULL;
+				return -EINVAL;
+			}
+			info->parts[i].offset = reg[0];
+			info->parts[i].size = reg[1];
+
+			info->parts[i].name =
+				(char *)of_get_property(pp, "name", &len);
+
+			if (of_get_property(pp, "read-only", &len))
+				info->parts[i].mask_flags = MTD_WRITEABLE;
+		}
+	} else {
+		nr_parts = parse_obsolete_partitions(info, dp);
+	}
+
+	if (nr_parts < 0)
+		return nr_parts;
+
+	if (nr_parts > 0)
+		add_mtd_partitions(info->mtd, info->parts, nr_parts);
+	else
+		add_mtd_device(info->mtd);
+
+	return 0;
+}
+#else /* MTD_PARTITIONS */
+static int __devinit process_partitions(struct physmap_flash_info *info,
+					struct device_node *dev)
+{
+	add_mtd_device(info->mtd);
+	return 0;
+}
+#endif /* MTD_PARTITIONS */
 
 static int of_physmap_remove(struct of_device *dev)
 {
@@ -92,7 +168,7 @@ static int of_physmap_remove(struct of_d
 
 	if (info->mtd != NULL) {
 #ifdef CONFIG_MTD_PARTITIONS
-		if (info->nr_parts) {
+		if (info->parts) {
 			del_mtd_partitions(info->mtd);
 			kfree(info->parts);
 		} else {
@@ -115,13 +191,45 @@ static int of_physmap_remove(struct of_d
 	return 0;
 }
 
+/* Helper function to handle probing of the obsolete "direct-mapped"
+ * compatible binding, which has an extra "probe-type" property
+ * describing the type of flash probe necessary. */
+static struct mtd_info * __devinit obsolete_probe(struct of_device *dev,
+						  struct map_info *map)
+{
+	struct device_node *dp = dev->node;
+	const char *of_probe;
+	struct mtd_info *mtd;
+	static const char *rom_probe_types[]
+		= { "cfi_probe", "jedec_probe", "map_rom"};
+	int i;
+
+	of_probe = of_get_property(dp, "probe-type", NULL);
+	if (!of_probe) {
+		for (i = 0; i < ARRAY_SIZE(rom_probe_types); i++) {
+			mtd = do_map_probe(rom_probe_types[i], map);
+			if (mtd)
+				return mtd;
+		}
+		return NULL;
+	} else if (strcmp(of_probe, "CFI") == 0) {
+		return do_map_probe("cfi_probe", map);
+	} else if (strcmp(of_probe, "JEDEC") == 0) {
+		return do_map_probe("jedec_probe", map);
+	} else {
+ 		if (strcmp(of_probe, "ROM") != 0)
+			dev_dbg(&dev->dev, "obsolete_probe: don't know probe type "
+				"'%s', mapping as rom\n", of_probe);
+		return do_map_probe("mtd_rom", map);
+	}
+}
+
 static int __devinit of_physmap_probe(struct of_device *dev, const struct of_device_id *match)
 {
 	struct device_node *dp = dev->node;
 	struct resource res;
 	struct physmap_flash_info *info;
-	const char **probe_type;
-	const char *of_probe;
+	const char *probe_type = (const char *)match->data;
 	const u32 *width;
 	int err;
 
@@ -174,21 +282,11 @@ static int __devinit of_physmap_probe(st
 
 	simple_map_init(&info->map);
 
-	of_probe = of_get_property(dp, "probe-type", NULL);
-	if (of_probe == NULL) {
-		probe_type = rom_probe_types;
-		for (; info->mtd == NULL && *probe_type != NULL; probe_type++)
-			info->mtd = do_map_probe(*probe_type, &info->map);
-	} else if (!strcmp(of_probe, "CFI"))
-		info->mtd = do_map_probe("cfi_probe", &info->map);
-	else if (!strcmp(of_probe, "JEDEC"))
-		info->mtd = do_map_probe("jedec_probe", &info->map);
-	else {
- 		if (strcmp(of_probe, "ROM"))
-			dev_dbg(&dev->dev, "map_probe: don't know probe type "
-			"'%s', mapping as rom\n", of_probe);
-		info->mtd = do_map_probe("mtd_rom", &info->map);
-	}
+	if (probe_type)
+		info->mtd = do_map_probe(probe_type, &info->map);
+	else
+		info->mtd = obsolete_probe(dev, &info->map);
+
 	if (info->mtd == NULL) {
 		dev_err(&dev->dev, "map_probe failed\n");
 		err = -ENXIO;
@@ -196,19 +294,7 @@ static int __devinit of_physmap_probe(st
 	}
 	info->mtd->owner = THIS_MODULE;
 
-#ifdef CONFIG_MTD_PARTITIONS
-	err = parse_mtd_partitions(info->mtd, part_probe_types, &info->parts, 0);
-	if (err > 0) {
-		add_mtd_partitions(info->mtd, info->parts, err);
-	} else if ((err = parse_flash_partitions(dp, &info->parts)) > 0) {
-		dev_info(&dev->dev, "Using OF partition information\n");
-		add_mtd_partitions(info->mtd, info->parts, err);
-		info->nr_parts = err;
-	} else
-#endif
-
-	add_mtd_device(info->mtd);
-	return 0;
+	return process_partitions(info, dev);
 
 err_out:
 	of_physmap_remove(dev);
@@ -221,6 +307,14 @@ err_out:
 
 static struct of_device_id of_physmap_match[] = {
 	{
+		.compatible	= "cfi-flash",
+		.data		= (void *)"cfi_probe",
+	},
+	{
+		.compatible	= "jedec-flash",
+		.data		= (void *)"jedec_probe",
+	},
+	{
 		.type		= "rom",
 		.compatible	= "direct-mapped"
 	},
Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2007-08-28 13:25:42.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-08-28 13:41:00.000000000 +1000
@@ -142,13 +142,15 @@
 				interrupt-parent = <&UIC1>;
 
 				small-flash@0,80000 {
-					device_type = "rom";
-					compatible = "direct-mapped";
-					probe-type = "JEDEC";
+					compatible = "jedec-flash";
 					bank-width = <1>;
-					partitions = <0 80000>;
-					partition-names = "OpenBIOS";
 					reg = <0 80000 80000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					OpenBIOS@0 {
+						reg = <0 80000>;
+						read-only;
+					};
 				};
 
 				ds1743@1,0 {
@@ -158,14 +160,17 @@
 				};
 
 				large-flash@2,0 {
-					device_type = "rom";
-					compatible = "direct-mapped";
-					probe-type = "JEDEC";
+					compatible = "jedec-flash";
 					bank-width = <1>;
-					partitions = <0 380000
-						      380000 80000>;
-					partition-names = "fs", "firmware";
 					reg = <2 0 400000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					fs@0 {
+						reg = <0 380000>;
+					};
+					firmware@380000 {
+						reg = <380000 80000>;
+					};
 				};
 
 				ir@3,0 {

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
