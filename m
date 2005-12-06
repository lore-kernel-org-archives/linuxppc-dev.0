Return-Path: <pantelis.antoniou@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.206])
	by ozlabs.org (Postfix) with ESMTP id A602D688B3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 08:50:58 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id m18so54714nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 06 Dec 2005 13:50:58 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Dan Malek <dan@embeddededge.com>, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-embedded@ozlabs.org, linux-mtd@lists.infradead.org
Date: Tue, 6 Dec 2005 23:58:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200512062358.49810.pantelis.antoniou@gmail.com>
Subject: [PATCH] ppc32: STXXTC board mtd bits.
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Support NOR & NAND present in Silicon Turnkey's XTc.

---
commit 721e1a97125a2f6118efc52b169a045a0334deb5
tree 508fde3b74cda7abf47c42421049330ec4116088
parent 76d9ad9d0440e6f26ff87899284a90cd865dd330
author Pantelis Antoniou <pantelis.antoniou@gmail.com> Tue, 06 Dec 2005 23:18:16 +0200
committer Pantelis Antoniou <pantelis.antoniou@gmail.com> Tue, 06 Dec 2005 23:18:16 +0200

 drivers/mtd/maps/Kconfig       |    6 +
 drivers/mtd/maps/Makefile      |    1 
 drivers/mtd/maps/stxxtc_nor.c  |  268 +++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/Kconfig       |    8 +
 drivers/mtd/nand/Makefile      |    1 
 drivers/mtd/nand/stxxtc_nand.c |  277 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 560 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -639,5 +639,11 @@ config MTD_PLATRAM
 
 	  This selection automatically selects the map_ram driver.
 
+config MTD_STXXTC_NOR
+	tristate "NOR Map driver for STXXTC NOR flash"
+	depends on STXXTC && MTD_CONCAT && MTD_PARTITIONS && MTD_CFI_INTELEXT
+	help
+	  Map driver for Silicon Turnkey eXpress XTc NOR flash. 
+
 endmenu
 
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -72,3 +72,4 @@ obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
 obj-$(CONFIG_MTD_MTX1)		+= mtx-1_flash.o
 obj-$(CONFIG_MTD_TQM834x)	+= tqm834x.o
+obj-$(CONFIG_MTD_STXXTC_NOR)	+= stxxtc_nor.o
diff --git a/drivers/mtd/maps/stxxtc_nor.c b/drivers/mtd/maps/stxxtc_nor.c
new file mode 100644
--- /dev/null
+++ b/drivers/mtd/maps/stxxtc_nor.c
@@ -0,0 +1,268 @@
+/*
+ * Handle mapping of the flash on the STXXTC board
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <asm/io.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/concat.h>
+
+/* Boot flash; same on every board */
+static struct mtd_info *stxxtc_mtd;
+
+#define SECTORSZ(x)	((x) * 64 * 1024)
+
+#define UBOOT_CODE_SECTORS	4
+
+#define ENV1_PART	0
+#define ENV2_PART	1
+
+#define CHKP1_PART	2
+#define CHKP2_PART	3
+
+#define STRG1_PART	4
+
+#define BOOT_PART	5
+
+#define STRG2_PART	6
+
+/* partition_info gives details on the logical partitions that the split the
+ * single flash device into. If the size if zero we use up to the end of the
+ * device. */
+static struct mtd_partition pi[]= {
+	[ENV1_PART] = {
+		.name		= "u-boot_env_#1_0_4000",
+		.size		= SECTORSZ(1),
+		.offset		= SECTORSZ(0),
+	},
+	[ENV2_PART] = {
+		.name		= "u-boot_env_#2_0_4000",
+		.size		= SECTORSZ(1),
+		.offset		= SECTORSZ(1),
+	},
+	[CHKP1_PART] = {
+		.name		= "checkpoint_#1",
+		.size		= SECTORSZ(1),
+		.offset		= SECTORSZ(2),
+	},
+	[CHKP2_PART] = {
+		.name		= "checkpoint_#2",
+		.size		= SECTORSZ(1),
+		.offset		= SECTORSZ(3),
+	},
+	[STRG1_PART] = {
+		.name		= "storage_#1",
+		.size		= 0,	/* to be filled */
+		.offset		= SECTORSZ(4),
+	},
+	[BOOT_PART] = {
+		.name		= "u-boot_code",
+		.size		= SECTORSZ(UBOOT_CODE_SECTORS),
+		.offset		= 0,	/* to be filled */
+		.mask_flags	= MTD_WRITEABLE,	/* don't allow writes at all */
+	},
+	[STRG2_PART] = {
+		.name		= "storage_#2",
+		.size		= 0,	/* what ever remains */
+		.offset		= 0,	/* to be filled */
+	}
+};
+
+#define NUM_PARTITIONS (sizeof(pi) / sizeof(pi[0]))
+
+#define WINDOW_ADDR	0x40000000
+#define WINDOW_SIZE	0x00200000
+
+struct map_info stxxtc_map = {
+	.name		= "STXXTC_boot_flash",
+	.size		= WINDOW_SIZE,
+	.bankwidth	= 2,
+	.phys		= WINDOW_ADDR,
+};
+
+/* two chips supported */
+#define NR_CHIPS	2
+
+struct stxxtc_nor_info {
+	unsigned long base;
+	unsigned long map_size;
+	char *mapname;
+	int width;
+	struct map_info map;
+	struct mtd_info *mtd;
+	struct resource *res;
+};
+
+static struct stxxtc_nor_info info[NR_CHIPS] = {
+	{
+		.base		= 0x40000000,
+		.map_size	= 0x01000000,
+		.width		= 2,
+		.mapname	= "stxxtc_NOR_flash_#1",
+	}, {
+		.base		= 0x42000000,
+		.map_size	= 0x01000000,
+		.width		= 2,
+		.mapname	= "stxxtc_NOR_flash_#2",
+	}
+};
+
+int __init init_stxxtc_nor(void)
+{
+	struct stxxtc_nor_info *ni;
+	int i, j, r = 0, found = 0;
+	unsigned long mask, off;
+	struct mtd_info *subdev[NR_CHIPS];
+
+	memset(subdev, 0, sizeof(subdev));
+
+	for (i = 0, ni = info; i < NR_CHIPS; i++, ni++) {
+
+		memset(&ni->map, 0, sizeof(ni->map));
+
+		ni->res = request_mem_region(ni->base, ni->map_size, ni->mapname);
+		if (ni->res == NULL) {
+			r = -EBUSY;
+			goto err;
+		}
+
+		ni->map.virt = ioremap(ni->base, ni->map_size);
+		if (ni->map.virt == NULL) {
+			r = -ENOMEM;
+			goto err;
+		}
+		ni->map.name = ni->mapname;
+		ni->map.phys = ni->base;
+		ni->map.bankwidth = 2;
+		ni->map.size = ni->map_size;
+		simple_map_init(&ni->map);
+
+		ni->mtd = do_map_probe("cfi_probe", &ni->map);
+		if (ni->mtd == NULL) {
+			/* chip missing; just cleanup and continue */
+			iounmap(ni->map.virt);
+			release_resource(ni->res);
+			ni->res = NULL;
+			memset(&ni->map, 0, sizeof(ni->map));
+			continue;
+		}
+
+		ni->mtd->owner = THIS_MODULE;
+
+		found++;
+
+	}
+
+	/* no chips found... */
+	if (found == 0) {
+		printk(KERN_INFO "stxxtc_nor: No devices found\n");
+		return -ENXIO;
+	}
+
+	/* first chip must exist. */
+	ni = &info[0]; i = 0; j = 0;
+	if (ni->mtd == NULL) {
+		printk(KERN_INFO "stxxtc_nor: First chip missing, not able to continue\n");
+		r = -ENXIO;
+		goto err;
+	}
+
+	printk(KERN_INFO "stxxtc_nor: CFI device found at 0x%08lx, "
+			"%dMiB, %d-bit wide\n", 
+			ni->base, ni->mtd->size >> 20, ni->width * 8);
+
+	/* find out where u-boot code is. It's size is 256K and is located
+	 * at the last megabyte of the first flash, for example a 2M flash
+	 * will have the u-boot part at offset 0x00100000
+	 */
+
+	mask = ni->mtd->size - 1;
+	off = 0xFFF00000 & mask;
+	printk(KERN_INFO "u-boot offset is at 0x%08lx\n", off);
+
+	/* keep it */
+	subdev[j++] = ni->mtd;
+
+	/* next */
+	i++; ni++;
+
+	/* report what we found */
+	for (; i < NR_CHIPS; i++, ni++) {
+		if (ni->mtd == NULL)
+			continue;
+		printk(KERN_INFO "stxxtc_nor: CFI device found at 0x%08lx, "
+				"%dMiB, %d-bit wide\n", 
+				ni->base, ni->mtd->size >> 20, ni->width * 8);
+		subdev[j++] = ni->mtd;
+	}
+
+	/* concat all the devices into one */
+	stxxtc_mtd = mtd_concat_create(subdev, found, "stxxtc NOR flash");
+	if (stxxtc_mtd == NULL) {
+		r = -ENXIO;
+		goto err;
+	}
+	stxxtc_mtd->owner = THIS_MODULE;
+
+	/* fixup partitions */
+	pi[STRG1_PART].size	= off - pi[STRG1_PART].offset;
+	pi[BOOT_PART].offset 	= off;
+	pi[STRG2_PART].offset	= pi[BOOT_PART].offset + pi[BOOT_PART].size;
+
+	add_mtd_partitions(stxxtc_mtd, pi, NUM_PARTITIONS);
+
+	return 0;
+
+err:
+	if (stxxtc_mtd != NULL) {
+		del_mtd_partitions(stxxtc_mtd);
+		mtd_concat_destroy(stxxtc_mtd);
+	}
+
+	for (i = NR_CHIPS - 1, ni = info + i; i >= 0; i--, ni--) {
+		if (ni->mtd)
+			map_destroy(ni->mtd);
+		if (ni->map.virt)
+			iounmap(ni->map.virt);
+		if (ni->res != NULL)
+			release_resource(ni->res);
+	}
+
+
+	return r;
+}
+
+static void __exit cleanup_stxxtc_nor(void)
+{
+	int i;
+	struct stxxtc_nor_info *ni;
+
+	if (stxxtc_mtd != NULL) {
+		del_mtd_partitions(stxxtc_mtd);
+		mtd_concat_destroy(stxxtc_mtd);
+	}
+
+	for (i = NR_CHIPS - 1, ni = info + i; i >= 0; i--, ni--) {
+		if (ni->mtd)
+			map_destroy(ni->mtd);
+		if (ni->map.virt)
+			iounmap(ni->map.virt);
+		if (ni->res != NULL)
+			release_resource(ni->res);
+	}
+
+}
+
+module_init(init_stxxtc_nor);
+module_exit(cleanup_stxxtc_nor);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pantelis Antoniou <pantelis.antoniou@gmail.com>");
+MODULE_DESCRIPTION("MTD map driver for STXXTC boards");
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -190,5 +190,11 @@ config MTD_NAND_DISKONCHIP_BBTWRITE
 	help
 	  The simulator may simulate verious NAND flash chips for the
 	  MTD nand layer.
- 
+
+config MTD_NAND_STXXTC
+	tristate "NAND Flash support for STXXTC"
+	depends on STXXTC && MTD_NAND
+	help
+	  Use the NAND flash present on Silicon Turnkey eXpress XTc.
+
 endmenu
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_MTD_NAND_H1900)		+= h1910.o
 obj-$(CONFIG_MTD_NAND_RTC_FROM4)	+= rtc_from4.o
 obj-$(CONFIG_MTD_NAND_SHARPSL)		+= sharpsl.o
 obj-$(CONFIG_MTD_NAND_NANDSIM)		+= nandsim.o
+obj-$(CONFIG_MTD_NAND_STXXTC)		+= stxxtc_nand.o
 
 nand-objs = nand_base.o nand_bbt.o
diff --git a/drivers/mtd/nand/stxxtc_nand.c b/drivers/mtd/nand/stxxtc_nand.c
new file mode 100644
--- /dev/null
+++ b/drivers/mtd/nand/stxxtc_nand.c
@@ -0,0 +1,277 @@
+/*
+ *  drivers/mtd/nand/stxxtc_nand.c
+ *
+ *  Copyright (C) 2005 Pantelis Antoniou <pantelis.antoniou@gmail.com>
+ *                     Dan Malek <dan@embeddedalley.com>
+ *
+ *  Derived from drivers/mtd/nand/edb7312.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/config.h>
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/semaphore.h>
+
+#include <platforms/stxxtc.h>
+
+/******************************************************************************/
+
+static struct mtd_info *stxxtc_mtd = NULL;
+static unsigned int stxxtc_fio_base;
+static int mtd_parts_nb = 0;
+static struct mtd_partition *mtd_parts;
+static const char *part_type = NULL;
+static const char *part_probes[] = { "cmdlinepart", NULL };
+
+/* we need these */
+extern struct semaphore mtd_table_mutex;
+extern struct mtd_info *mtd_table[MAX_MTD_DEVICES];
+
+/******************************************************************************/
+
+/* 
+ * hardware specific access to control-lines
+ */
+static void stxxtc_hwcontrol(struct mtd_info *mtd, int cmd) 
+{
+	unsigned long flags;
+	
+	local_irq_save(flags);
+
+	switch (cmd) {
+
+		case NAND_CTL_SETNCE:
+			_PIN_LO(F_CE);
+			break;
+
+		case NAND_CTL_CLRNCE:
+			_PIN_HI(F_CE);
+			break;
+
+		case NAND_CTL_SETCLE:
+			_PIN_HI(F_CLE);
+			break;
+
+		case NAND_CTL_CLRCLE:
+			_PIN_LO(F_CLE);
+			break;
+
+		case NAND_CTL_SETALE:
+			_PIN_HI(F_ALE);
+			break;
+
+		case NAND_CTL_CLRALE:
+			_PIN_LO(F_ALE);
+			break;
+	}
+
+	local_irq_restore(flags);
+}
+
+/*
+ *	read device ready pin
+ */
+static int stxxtc_device_ready(struct mtd_info *mtd)
+{
+	return _PIN_GET(F_RY_BY);
+}
+
+/*
+ * Main initialization routine
+ */
+static int __init stxxtc_init(void)
+{
+	struct nand_chip *this = NULL;
+	int i, j, err = 0, rootidx;
+	const char *s, *rootmark="root=/dev/mtdblock";
+	unsigned int curroff, sz;
+	struct mtd_partition *part;
+	
+	/* Allocate memory for MTD device structure and private data */
+	stxxtc_mtd = kmalloc(sizeof(struct mtd_info) + sizeof(struct nand_chip), GFP_KERNEL);
+	if (!stxxtc_mtd) {
+		printk("Unable to allocate STXXTC NAND MTD device structure.\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* map physical adress */
+	stxxtc_fio_base = (unsigned long)ioremap(NAND_BASE, NAND_SIZE);
+	if(!stxxtc_fio_base) {
+		printk("ioremap STXXTC NAND flash failed\n");
+		err = -EIO;
+		goto out;
+	}
+	
+	/* Get pointer to private data */
+	this = (struct nand_chip *)&stxxtc_mtd[1];
+	
+	/* Initialize structures */
+	memset((char *) stxxtc_mtd, 0, sizeof(struct mtd_info));
+	memset((char *) this, 0, sizeof(struct nand_chip));
+	
+	/* Link the private data with the MTD structure */
+	stxxtc_mtd->priv = this;
+	
+	/* insert callbacks */
+	this->IO_ADDR_R = (void __iomem *)stxxtc_fio_base;
+	this->IO_ADDR_W = (void __iomem *)stxxtc_fio_base;
+	this->hwcontrol = stxxtc_hwcontrol;
+	this->dev_ready = stxxtc_device_ready;
+	/* 15 us command delay time (XXX actually not used) */
+	this->chip_delay = 15;
+	/* TODO F_RY_BY pin is interrupt capable but it's not used as such */
+	this->eccmode = NAND_ECC_SOFT;
+	
+	/* Scan to find existence of the device (minimum size is 8MiB) */
+	if (nand_scan(stxxtc_mtd, 1) || stxxtc_mtd->size < 8 * 1024 * 1024) {
+		err = -ENXIO;
+		goto out;
+	}
+
+	/* Set internal data buffer */
+	this->data_buf = kmalloc(stxxtc_mtd->oobblock + stxxtc_mtd->oobsize, GFP_KERNEL);
+	if (this->data_buf == NULL) {
+		printk(KERN_ERR "stxxtc_nand: Unable to allocate data buffer\n");
+		err = -ENOMEM;
+		goto out;
+	}
+
+
+#ifdef CONFIG_MTD_CMDLINE_PARTS
+	stxxtc_mtd->name = "stxxtc-nand";
+	mtd_parts_nb = parse_mtd_partitions(stxxtc_mtd, part_probes, &mtd_parts, 0);
+	if (mtd_parts_nb > 0)
+		part_type = "command line";
+	else
+		mtd_parts_nb = 0;
+#endif
+	if (mtd_parts_nb == 0) {
+
+		mtd_parts_nb = 3;
+
+		mtd_parts = kmalloc(sizeof(*mtd_parts) * mtd_parts_nb, GFP_KERNEL);
+		if (mtd_parts == NULL) {
+			printk(KERN_ERR "stxxtc_nand: Unable to allocate partition table buffer\n");
+			err = -ENOMEM;
+			goto out;
+		}
+		memset(mtd_parts, 0, sizeof(*mtd_parts) * mtd_parts_nb);
+
+		part = mtd_parts;
+
+		curroff = 0;
+
+		sz = (stxxtc_mtd->size - 512 * 1024) / 2;
+
+		part->name	= "STXXTC_root_fs_#1";
+		part->offset	= curroff;
+		part->size	= sz;
+		/* part->mask_flags= MTD_WRITEABLE; */
+		part++;
+		curroff += sz;
+
+		part->name	= "STXXTC_root_fs_#2";
+		part->offset	= curroff;
+		part->size	= sz;
+		part++;
+		curroff += sz;
+
+		part->name	= "Persistent_storage";
+		part->offset	= curroff;
+		part->size	= stxxtc_mtd->size - curroff;
+		part++;
+
+		part_type = "static";
+	}
+
+	/* lookup index of root MTD partition (if any) */
+	if ((s = strstr(saved_command_line, rootmark)) != NULL) {
+
+		rootidx = simple_strtoul(s + strlen(rootmark), NULL, 10);
+
+		/* XXX we assume that no-one will interrupts afterwards */
+		down(&mtd_table_mutex);
+		for (i = 0, j = 0; i < MAX_MTD_DEVICES; i++) {
+
+			if (mtd_table[i] != NULL)
+				continue;
+
+			if (i == rootidx) {
+				printk(KERN_INFO "stxxtc_nand: Marking root device mtd%d as read-only (%d)\n", i, j);
+				mtd_parts[j].mask_flags = MTD_WRITEABLE;
+				break;
+			}
+
+			if (++j >= mtd_parts_nb)
+				break;
+		}
+		up(&mtd_table_mutex);
+
+	}
+
+	/* Register the partitions */
+	printk(KERN_NOTICE "Using %s partition definition\n", part_type);
+	err = add_mtd_partitions(stxxtc_mtd, mtd_parts, mtd_parts_nb);
+	if (err != 0) {
+		printk(KERN_ERR "stxxtc_nand: Unable to add mtd partitions\n");
+		goto out;
+	}
+
+	kfree(mtd_parts);
+	mtd_parts = NULL;
+
+	return 0;
+
+out:
+	if (mtd_parts)
+		kfree(mtd_parts);
+	if (stxxtc_fio_base)
+		iounmap((void *)stxxtc_fio_base);
+	if (this && this->data_buf)
+		kfree(this->data_buf);
+	if (stxxtc_mtd)
+		kfree(stxxtc_mtd);
+	return err;
+}
+
+/*
+ * Clean up routine
+ */
+static void __exit stxxtc_cleanup(void)
+{
+	struct nand_chip *this = (struct nand_chip *) &stxxtc_mtd[1];
+
+	/* Unregister the device */
+	del_mtd_device(stxxtc_mtd);
+	
+	/* unmap */
+	iounmap((void *)stxxtc_fio_base);
+
+	/* free data buffer */
+	kfree(this->data_buf);
+
+	/* Free the MTD device structure */
+	kfree(stxxtc_mtd);
+}
+
+module_init(stxxtc_init);
+module_exit(stxxtc_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pantelis Antoniou <pantelis.antoniou@gmail.com>");
+MODULE_DESCRIPTION("MTD map driver for STXXTC");
+
+
