Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2528DDF2E
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 14:01:16 +1000 (EST)
Date: Wed, 22 Aug 2007 23:00:51 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Please pull from 'mtd-2.6.24' branch
Message-ID: <Pine.LNX.4.64.0708222259440.7853@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'mtd-2.6.24' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git mtd-2.6.24

to receive the following updates:

 drivers/mtd/maps/Kconfig   |   12 -
 drivers/mtd/maps/Makefile  |    1
 drivers/mtd/maps/pq2fads.c |   88 -------------
 drivers/mtd/maps/tqm834x.c |  286 ---------------------------------------------
 drivers/mtd/nand/Kconfig   |    2
 5 files changed, 3 insertions(+), 386 deletions(-)

Josh Boyer (1):
      [MTD] 4xx: Don't build arch/ppc dependent drivers in arch/powerpc

Kumar Gala (1):
      [MTD] Remove dead maps

commit 34a27ffdf59f80fe165f5c56a0be57d55b6da63d
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Wed Aug 22 22:53:39 2007 -0500

    [MTD] Remove dead maps

    The tqm834x map Kconfig options depends on TQM834x which does not
    exist anywhere else in the kernel.

    The pq2fads map Kconfig/makefile support was removed a while ago but
    the actual file persisted.

    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 3feb0ff1607ab3b7dcd36b2347f00c41774464c8
Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date:   Wed Aug 22 14:30:47 2007 -0500

    [MTD] 4xx: Don't build arch/ppc dependent drivers in arch/powerpc

    These drivers are specific to 4xx support in arch/ppc at the moment.  Make
    sure they don't get built on arch/powerpc.

    Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index cc6c734..5850ccd 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -354,7 +354,7 @@ config MTD_CFI_FLAGADM

 config MTD_WALNUT
 	tristate "Flash device mapped on IBM 405GP Walnut"
-	depends on MTD_JEDECPROBE && WALNUT
+	depends on MTD_JEDECPROBE && WALNUT && !PPC_MERGE
 	help
 	  This enables access routines for the flash chips on the IBM 405GP
 	  Walnut board. If you have one of these boards and would like to
@@ -370,7 +370,7 @@ config MTD_EBONY

 config MTD_OCOTEA
 	tristate "Flash devices mapped on IBM 440GX Ocotea"
-	depends on MTD_CFI && OCOTEA
+	depends on MTD_CFI && OCOTEA && !PPC_MERGE
 	help
 	  This enables access routines for the flash chips on the IBM 440GX
 	  Ocotea board. If you have one of these boards and would like to
@@ -384,14 +384,6 @@ config MTD_REDWOOD
 	  Redwood board. If you have one of these boards and would like to
 	  use the flash chips on it, say 'Y'.

-config MTD_TQM834x
-	tristate "Flash device mapped on TQ Components TQM834x Boards"
-	depends on MTD_CFI && TQM834x
-	help
-	  This enables access routines for the flash chips on the
-	  TQ Components TQM834x boards. If you have one of these boards
-	  and would like to use the flash chips on it, say 'Y'.
-
 config MTD_OCELOT
 	tristate "Momenco Ocelot boot flash device"
 	depends on MOMENCO_OCELOT
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 970b189..b9019b1 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -70,4 +70,3 @@ obj-$(CONFIG_MTD_SHARP_SL)	+= sharpsl-flash.o
 obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
 obj-$(CONFIG_MTD_MTX1)		+= mtx-1_flash.o
-obj-$(CONFIG_MTD_TQM834x)	+= tqm834x.o
diff --git a/drivers/mtd/maps/pq2fads.c b/drivers/mtd/maps/pq2fads.c
deleted file mode 100644
index fb78d87..0000000
--- a/drivers/mtd/maps/pq2fads.c
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * drivers/mtd/maps/pq2fads.c
- *
- * Mapping for the flash SIMM on 8272ADS and PQ2FADS board
- *
- * Author: Vitaly Bordug <vbordug@ru.mvista.com>
- *
- * 2005 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <asm/io.h>
-#include <asm/ppcboot.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/physmap.h>
-
-/*
-  NOTE: bank width and interleave relative to the installed flash
-  should have been chosen within MTD_CFI_GEOMETRY options.
-  */
-#define PQ2FADS_BANK_WIDTH 4
-
-static struct mtd_partition pq2fads_partitions[] = {
-	{
-#ifdef CONFIG_ADS8272
-		.name		= "HRCW",
-		.size		= 0x40000,
-		.offset 	= 0,
-		.mask_flags	= MTD_WRITEABLE,  /* force read-only */
-	}, {
-		.name		= "User FS",
-		.size		= 0x5c0000,
-		.offset 	= 0x40000,
-#else
-		.name		= "User FS",
-		.size		= 0x600000,
-		.offset 	= 0,
-#endif
-	}, {
-		.name		= "uImage",
-		.size		= 0x100000,
-		.offset 	= 0x600000,
-		.mask_flags	= MTD_WRITEABLE,  /* force read-only */
-	}, {
-		.name		= "bootloader",
-		.size		= 0x40000,
-		.offset		= 0x700000,
-		.mask_flags	= MTD_WRITEABLE,  /* force read-only */
-	}, {
-		.name		= "bootloader env",
-		.size		= 0x40000,
-		.offset		= 0x740000,
-		.mask_flags	= MTD_WRITEABLE,  /* force read-only */
-	}
-};
-
-
-/* pointer to MPC885ADS board info data */
-extern unsigned char __res[];
-
-static int __init init_pq2fads_mtd(void)
-{
-	bd_t *bd = (bd_t *)__res;
-	physmap_configure(bd->bi_flashstart, bd->bi_flashsize, PQ2FADS_BANK_WIDTH, NULL);
-
-	physmap_set_partitions(pq2fads_partitions,
-				sizeof (pq2fads_partitions) /
-				sizeof (pq2fads_partitions[0]));
-	return 0;
-}
-
-static void __exit cleanup_pq2fads_mtd(void)
-{
-}
-
-module_init(init_pq2fads_mtd);
-module_exit(cleanup_pq2fads_mtd);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MTD map and partitions for MPC8272ADS boards");
diff --git a/drivers/mtd/maps/tqm834x.c b/drivers/mtd/maps/tqm834x.c
deleted file mode 100644
index 9adc970..0000000
--- a/drivers/mtd/maps/tqm834x.c
+++ /dev/null
@@ -1,286 +0,0 @@
-/*
- * drivers/mtd/maps/tqm834x.c
- *
- * MTD mapping driver for TQM834x boards
- *
- * Copyright 2005 Wolfgang Denk, DENX Software Engineering, <wd@denx.de>.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <asm/io.h>
-#include <asm/ppcboot.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-#define FLASH_BANK_MAX	2
-
-extern unsigned char __res[];
-
-/* trivial struct to describe partition information */
-struct mtd_part_def
-{
-	int nums;
-	unsigned char *type;
-	struct mtd_partition* mtd_part;
-};
-
-static struct mtd_info* mtd_banks[FLASH_BANK_MAX];
-static struct map_info* map_banks[FLASH_BANK_MAX];
-static struct mtd_part_def part_banks[FLASH_BANK_MAX];
-
-static unsigned long num_banks;
-static unsigned long start_scan_addr;
-
-#ifdef CONFIG_MTD_PARTITIONS
-/*
- * The following defines the partition layout of TQM834x boards.
- *
- * See include/linux/mtd/partitions.h for definition of the
- * mtd_partition structure.
- *
- * Assume minimal initial size of 4 MiB per bank, will be updated
- * later in init_tqm834x_mtd() routine.
- */
-
-/* Partition definition for the first flash bank which is always present. */
-static struct mtd_partition tqm834x_partitions_bank1[] = {
-	{
-		.name	= "u-boot",		/* u-boot firmware	*/
-		.offset	= 0x00000000,
-		.size	= 0x00040000,		/* 256 KiB		*/
-		/*mask_flags: MTD_WRITEABLE,	 * force read-only	*/
-	},
-	{
-		.name	= "env",		/* u-boot environment	*/
-		.offset	= 0x00040000,
-		.size	= 0x00020000,		/* 128 KiB		*/
-		/*mask_flags: MTD_WRITEABLE,	 * force read-only	*/
-	},
-	{
-		.name	= "kernel",		/* linux kernel image	*/
-		.offset	= 0x00060000,
-		.size	= 0x00100000,		/* 1 MiB		*/
-		/*mask_flags: MTD_WRITEABLE,	 * force read-only	*/
-	},
-	{
-		.name	= "initrd",		/* ramdisk image	*/
-		.offset	= 0x00160000,
-		.size	= 0x00200000,		/* 2 MiB		*/
-	},
-	{
-		.name	= "user",		/* user data		*/
-		.offset	= 0x00360000,
-		.size	= 0x000a0000,		/* remaining space	*/
-		/* NOTE: this parttion size is re-calcated in		*/
-		/* init_tqm834x_mtd() to cover actual remaining space.	*/
-	},
-};
-
-/* Partition definition for the second flash bank which may be present on some
- * TQM834x boards.
- */
-static struct mtd_partition tqm834x_partitions_bank2[] = {
-	{
-		.name	= "jffs2",		/* jffs2 filesystem	*/
-		.offset	= 0x00000000,
-		.size	= 0x00400000,		/* whole device		*/
-		/* NOTE: this parttion size is re-calcated in		*/
-		/* init_tqm834x_mtd() to cover actual device size.	*/
-	},
-};
-
-#endif	/* CONFIG_MTD_PARTITIONS */
-
-static int __init init_tqm834x_mtd(void)
-{
-	int idx = 0, ret = 0;
-	unsigned long flash_addr, flash_size, mtd_size = 0;
-
-	/* pointer to TQM834x board info data */
-	bd_t *bd = (bd_t *)__res;
-#ifdef CONFIG_MTD_CMDLINE_PARTS
-	int n;
-	char mtdid[4];
-	const char *part_probes[] = { "cmdlinepart", NULL };
-#endif
-
-	flash_addr = bd->bi_flashstart;
-	flash_size = bd->bi_flashsize;
-
-	/* request maximum flash size address space */
-	start_scan_addr = (unsigned long)ioremap(flash_addr, flash_size);
-	if (!start_scan_addr) {
-		printk("%s: Failed to ioremap address: 0x%lx\n",
-		       __FUNCTION__, flash_addr);
-		return -EIO;
-	}
-
-	for(idx = 0 ; idx < FLASH_BANK_MAX ; idx++) {
-		if (mtd_size >= flash_size)
-			break;
-
-		pr_debug("%s: chip probing count %d\n", __FUNCTION__, idx);
-
-		map_banks[idx] = kzalloc(sizeof(struct map_info), GFP_KERNEL);
-		if (map_banks[idx] == NULL) {
-			ret = -ENOMEM;
-			goto error_mem;
-		}
-		map_banks[idx]->name = kzalloc(16, GFP_KERNEL);
-		if (map_banks[idx]->name == NULL) {
-			ret = -ENOMEM;
-			goto error_mem;
-		}
-
-		sprintf(map_banks[idx]->name, "TQM834x-%d", idx);
-		map_banks[idx]->size = flash_size;
-		map_banks[idx]->bankwidth = 4;
-
-		simple_map_init(map_banks[idx]);
-
-		map_banks[idx]->virt = (void __iomem *)
-			(start_scan_addr + ((idx > 0) ?
-			(mtd_banks[idx-1] ? mtd_banks[idx-1]->size : 0) : 0));
-		map_banks[idx]->phys =
-			flash_addr + ((idx > 0) ?
-			(mtd_banks[idx-1] ? mtd_banks[idx-1]->size : 0) : 0);
-
-		/* start to probe flash chips */
-		mtd_banks[idx] = do_map_probe("cfi_probe", map_banks[idx]);
-		if (mtd_banks[idx]) {
-			mtd_banks[idx]->owner = THIS_MODULE;
-			mtd_size += mtd_banks[idx]->size;
-			num_banks++;
-			pr_debug("%s: bank %ld, name: %s, size: %d bytes \n",
-				 __FUNCTION__, num_banks,
-				 mtd_banks[idx]->name, mtd_banks[idx]->size);
-		}
-	}
-
-	/* no supported flash chips found */
-	if (!num_banks) {
-		printk("TQM834x: No supported flash chips found!\n");
-		ret = -ENXIO;
-		goto error_mem;
-	}
-
-#ifdef CONFIG_MTD_PARTITIONS
-	/*
-	 * Select static partition definitions
-	 */
-	n = ARRAY_SIZE(tqm834x_partitions_bank1);
-	part_banks[0].mtd_part	= tqm834x_partitions_bank1;
-	part_banks[0].type	= "static image bank1";
-	part_banks[0].nums	= n;
-
-	/* update last partition size to cover actual remaining space */
-	tqm834x_partitions_bank1[n - 1].size =
-		mtd_banks[0]->size -
-		tqm834x_partitions_bank1[n - 1].offset;
-
-	/* check if we have second bank? */
-	if (num_banks == 2) {
-		n = ARRAY_SIZE(tqm834x_partitions_bank2);
-		part_banks[1].mtd_part	= tqm834x_partitions_bank2;
-		part_banks[1].type	= "static image bank2";
-		part_banks[1].nums	= n;
-
-		/* update last partition size to cover actual remaining space */
-		tqm834x_partitions_bank2[n - 1].size =
-			mtd_banks[1]->size -
-			tqm834x_partitions_bank2[n - 1].offset;
-	}
-
-	for(idx = 0; idx < num_banks ; idx++) {
-#ifdef CONFIG_MTD_CMDLINE_PARTS
-		sprintf(mtdid, "%d", idx);
-		n = parse_mtd_partitions(mtd_banks[idx],
-					 part_probes,
-					 &part_banks[idx].mtd_part,
-					 0);
-		pr_debug("%s: %d command line partitions on bank %s\n",
-			 __FUNCTION__, n, mtdid);
-		if (n > 0) {
-			part_banks[idx].type = "command line";
-			part_banks[idx].nums = n;
-		}
-#endif	/* CONFIG_MTD_CMDLINE_PARTS */
-		if (part_banks[idx].nums == 0) {
-			printk(KERN_NOTICE
-			       "TQM834x flash bank %d: no partition info "
-			       "available, registering whole device\n", idx);
-			add_mtd_device(mtd_banks[idx]);
-		} else {
-			printk(KERN_NOTICE
-			       "TQM834x flash bank %d: Using %s partition "
-			       "definition\n", idx, part_banks[idx].type);
-			add_mtd_partitions(mtd_banks[idx],
-					   part_banks[idx].mtd_part,
-					   part_banks[idx].nums);
-		}
-	}
-#else	/* ! CONFIG_MTD_PARTITIONS */
-	printk(KERN_NOTICE "TQM834x flash: registering %d flash banks "
-			"at once\n", num_banks);
-
-	for(idx = 0 ; idx < num_banks ; idx++)
-		add_mtd_device(mtd_banks[idx]);
-
-#endif	/* CONFIG_MTD_PARTITIONS */
-
-	return 0;
-error_mem:
-	for (idx = 0 ; idx < FLASH_BANK_MAX ; idx++) {
-		if (map_banks[idx] != NULL) {
-			if (map_banks[idx]->name != NULL) {
-				kfree(map_banks[idx]->name);
-				map_banks[idx]->name = NULL;
-			}
-			kfree(map_banks[idx]);
-			map_banks[idx] = NULL;
-		}
-	}
-
-	iounmap((void *)start_scan_addr);
-
-	return ret;
-}
-
-static void __exit cleanup_tqm834x_mtd(void)
-{
-	unsigned int idx = 0;
-	for(idx = 0 ; idx < num_banks ; idx++) {
-		/* destroy mtd_info previously allocated */
-		if (mtd_banks[idx]) {
-			del_mtd_partitions(mtd_banks[idx]);
-			map_destroy(mtd_banks[idx]);
-		}
-
-		/* release map_info not used anymore */
-		kfree(map_banks[idx]->name);
-		kfree(map_banks[idx]);
-	}
-
-	if (start_scan_addr) {
-		iounmap((void *)start_scan_addr);
-		start_scan_addr = 0;
-	}
-}
-
-module_init(init_tqm834x_mtd);
-module_exit(cleanup_tqm834x_mtd);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Wolfgang Denk <wd@denx.de>");
-MODULE_DESCRIPTION("MTD map driver for TQM834x boards");
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index f1d60b6..a783d62 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -134,7 +134,7 @@ config MTD_NAND_S3C2410_HWECC

 config MTD_NAND_NDFC
 	tristate "NDFC NanD Flash Controller"
-	depends on 44x
+	depends on 44x && !PPC_MERGE
 	select MTD_NAND_ECC_SMC
 	help
 	 NDFC Nand Flash Controllers are integrated in EP44x SoCs
