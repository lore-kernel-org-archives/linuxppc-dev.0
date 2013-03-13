Return-Path: <dedekind1@gmail.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id ED68C2C0381
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 20:04:16 +1100 (EST)
Message-ID: <1363165508.9457.13.camel@sauron.fi.intel.com>
Subject: [PATCH 08/10] mtd: remove the tqm8xxl map driver
From: Artem Bityutskiy <dedekind1@gmail.com>
To: MTD Maling List <linux-mtd@lists.infradead.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 13 Mar 2013 11:05:08 +0200
In-Reply-To: <1363086855-2847-1-git-send-email-dedekind1@gmail.com>
References: <1363086855-2847-1-git-send-email-dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This driver depends on the CONFIG_TQM8xxL symbol, which is not defined
anywhere, which means that this driver is dead.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---

Adding the PPC list

 drivers/mtd/maps/Kconfig   |   10 --
 drivers/mtd/maps/Makefile  |    1 -
 drivers/mtd/maps/tqm8xxl.c |  249 --------------------------------------------
 3 files changed, 260 deletions(-)
 delete mode 100644 drivers/mtd/maps/tqm8xxl.c

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 3fe3216..888e684 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -274,16 +274,6 @@ config MTD_L440GX
 
 	  BE VERY CAREFUL.
 
-config MTD_TQM8XXL
-	tristate "CFI Flash device mapped on TQM8XXL"
-	depends on MTD_CFI && TQM8xxL
-	help
-	  The TQM8xxL PowerPC board has up to two banks of CFI-compliant
-	  chips, currently uses AMD one. This 'mapping' driver supports
-	  that arrangement, allowing the CFI probe and command set driver
-	  code to communicate with the chips on the TQM8xxL board. More at
-	  <http://www.denx.de/wiki/PPCEmbedded/>.
-
 config MTD_CFI_FLAGADM
 	tristate "CFI Flash device mapping on FlagaDM"
 	depends on 8xx && MTD_CFI
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 8e2b289..0cdc881 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_MTD_PHYSMAP_OF)	+= physmap_of.o
 obj-$(CONFIG_MTD_PISMO)		+= pismo.o
 obj-$(CONFIG_MTD_PMC_MSP_EVM)   += pmcmsp-flash.o
 obj-$(CONFIG_MTD_PCMCIA)	+= pcmciamtd.o
-obj-$(CONFIG_MTD_TQM8XXL)	+= tqm8xxl.o
 obj-$(CONFIG_MTD_SA1100)	+= sa1100-flash.o
 obj-$(CONFIG_MTD_SBC_GXX)	+= sbc_gxx.o
 obj-$(CONFIG_MTD_SC520CDP)	+= sc520cdp.o
diff --git a/drivers/mtd/maps/tqm8xxl.c b/drivers/mtd/maps/tqm8xxl.c
deleted file mode 100644
index d785879..0000000
--- a/drivers/mtd/maps/tqm8xxl.c
+++ /dev/null
@@ -1,249 +0,0 @@
-/*
- * Handle mapping of the flash memory access routines
- * on TQM8xxL based devices.
- *
- * based on rpxlite.c
- *
- * Copyright(C) 2001 Kirk Lee <kirk@hpc.ee.ntu.edu.tw>
- *
- * This code is GPLed
- *
- */
-
-/*
- * According to TQM8xxL hardware manual, TQM8xxL series have
- * following flash memory organisations:
- *	| capacity |	| chip type |	| bank0 |	| bank1 |
- *	    2MiB	   512Kx16	  2MiB		   0
- *	    4MiB	   1Mx16	  4MiB		   0
- *	    8MiB	   1Mx16	  4MiB		   4MiB
- * Thus, we choose CONFIG_MTD_CFI_I2 & CONFIG_MTD_CFI_B4 at
- * kernel configuration.
- */
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-#include <asm/io.h>
-
-#define FLASH_ADDR 0x40000000
-#define FLASH_SIZE 0x00800000
-#define FLASH_BANK_MAX 4
-
-// trivial struct to describe partition information
-struct mtd_part_def
-{
-	int nums;
-	unsigned char *type;
-	struct mtd_partition* mtd_part;
-};
-
-//static struct mtd_info *mymtd;
-static struct mtd_info* mtd_banks[FLASH_BANK_MAX];
-static struct map_info* map_banks[FLASH_BANK_MAX];
-static struct mtd_part_def part_banks[FLASH_BANK_MAX];
-static unsigned long num_banks;
-static void __iomem *start_scan_addr;
-
-/*
- * Here are partition information for all known TQM8xxL series devices.
- * See include/linux/mtd/partitions.h for definition of the mtd_partition
- * structure.
- *
- * The *_max_flash_size is the maximum possible mapped flash size which
- * is not necessarily the actual flash size.  It must correspond to the
- * value specified in the mapping definition defined by the
- * "struct map_desc *_io_desc" for the corresponding machine.
- */
-
-/* Currently, TQM8xxL has up to 8MiB flash */
-static unsigned long tqm8xxl_max_flash_size = 0x00800000;
-
-/* partition definition for first flash bank
- * (cf. "drivers/char/flash_config.c")
- */
-static struct mtd_partition tqm8xxl_partitions[] = {
-	{
-	  .name = "ppcboot",
-	  .offset = 0x00000000,
-	  .size = 0x00020000,           /* 128KB           */
-	  .mask_flags = MTD_WRITEABLE,  /* force read-only */
-	},
-	{
-	  .name = "kernel",             /* default kernel image */
-	  .offset = 0x00020000,
-	  .size = 0x000e0000,
-	  .mask_flags = MTD_WRITEABLE,  /* force read-only */
-	},
-	{
-	  .name = "user",
-	  .offset = 0x00100000,
-	  .size = 0x00100000,
-	},
-	{
-	  .name = "initrd",
-	  .offset = 0x00200000,
-	  .size = 0x00200000,
-	}
-};
-/* partition definition for second flash bank */
-static struct mtd_partition tqm8xxl_fs_partitions[] = {
-	{
-	  .name = "cramfs",
-	  .offset = 0x00000000,
-	  .size = 0x00200000,
-	},
-	{
-	  .name = "jffs",
-	  .offset = 0x00200000,
-	  .size = 0x00200000,
-	  //.size = MTDPART_SIZ_FULL,
-	}
-};
-
-static int __init init_tqm_mtd(void)
-{
-	int idx = 0, ret = 0;
-	unsigned long flash_addr, flash_size, mtd_size = 0;
-	/* pointer to TQM8xxL board info data */
-	bd_t *bd = (bd_t *)__res;
-
-	flash_addr = bd->bi_flashstart;
-	flash_size = bd->bi_flashsize;
-
-	//request maximum flash size address space
-	start_scan_addr = ioremap(flash_addr, flash_size);
-	if (!start_scan_addr) {
-		printk(KERN_WARNING "%s:Failed to ioremap address:0x%x\n", __func__, flash_addr);
-		return -EIO;
-	}
-
-	for (idx = 0 ; idx < FLASH_BANK_MAX ; idx++) {
-		if(mtd_size >= flash_size)
-			break;
-
-		printk(KERN_INFO "%s: chip probing count %d\n", __func__, idx);
-
-		map_banks[idx] = kzalloc(sizeof(struct map_info), GFP_KERNEL);
-		if(map_banks[idx] == NULL) {
-			ret = -ENOMEM;
-			/* FIXME: What if some MTD devices were probed already? */
-			goto error_mem;
-		}
-
-		map_banks[idx]->name = kmalloc(16, GFP_KERNEL);
-
-		if (!map_banks[idx]->name) {
-			ret = -ENOMEM;
-			/* FIXME: What if some MTD devices were probed already? */
-			goto error_mem;
-		}
-		sprintf(map_banks[idx]->name, "TQM8xxL%d", idx);
-
-		map_banks[idx]->size = flash_size;
-		map_banks[idx]->bankwidth = 4;
-
-		simple_map_init(map_banks[idx]);
-
-		map_banks[idx]->virt = start_scan_addr;
-		map_banks[idx]->phys = flash_addr;
-		/* FIXME: This looks utterly bogus, but I'm trying to
-		   preserve the behaviour of the original (shown here)...
-
-		map_banks[idx]->map_priv_1 =
-		start_scan_addr + ((idx > 0) ?
-		(mtd_banks[idx-1] ? mtd_banks[idx-1]->size : 0) : 0);
-		*/
-
-		if (idx && mtd_banks[idx-1]) {
-			map_banks[idx]->virt += mtd_banks[idx-1]->size;
-			map_banks[idx]->phys += mtd_banks[idx-1]->size;
-		}
-
-		//start to probe flash chips
-		mtd_banks[idx] = do_map_probe("cfi_probe", map_banks[idx]);
-
-		if (mtd_banks[idx]) {
-			mtd_banks[idx]->owner = THIS_MODULE;
-			mtd_size += mtd_banks[idx]->size;
-			num_banks++;
-
-			printk(KERN_INFO "%s: bank%d, name:%s, size:%dbytes \n", __func__, num_banks,
-			mtd_banks[idx]->name, mtd_banks[idx]->size);
-		}
-	}
-
-	/* no supported flash chips found */
-	if (!num_banks) {
-		printk(KERN_NOTICE "TQM8xxL: No support flash chips found!\n");
-		ret = -ENXIO;
-		goto error_mem;
-	}
-
-	/*
-	 * Select Static partition definitions
-	 */
-	part_banks[0].mtd_part = tqm8xxl_partitions;
-	part_banks[0].type = "Static image";
-	part_banks[0].nums = ARRAY_SIZE(tqm8xxl_partitions);
-
-	part_banks[1].mtd_part = tqm8xxl_fs_partitions;
-	part_banks[1].type = "Static file system";
-	part_banks[1].nums = ARRAY_SIZE(tqm8xxl_fs_partitions);
-
-	for(idx = 0; idx < num_banks ; idx++) {
-		if (part_banks[idx].nums == 0)
-			printk(KERN_NOTICE "TQM flash%d: no partition info available, registering whole flash at once\n", idx);
-		else
-			printk(KERN_NOTICE "TQM flash%d: Using %s partition definition\n",
-					idx, part_banks[idx].type);
-		mtd_device_register(mtd_banks[idx], part_banks[idx].mtd_part,
-		part_banks[idx].nums);
-	}
-	return 0;
-error_mem:
-	for(idx = 0 ; idx < FLASH_BANK_MAX ; idx++) {
-		if(map_banks[idx] != NULL) {
-			kfree(map_banks[idx]->name);
-			map_banks[idx]->name = NULL;
-			kfree(map_banks[idx]);
-			map_banks[idx] = NULL;
-		}
-	}
-error:
-	iounmap(start_scan_addr);
-	return ret;
-}
-
-static void __exit cleanup_tqm_mtd(void)
-{
-	unsigned int idx = 0;
-	for(idx = 0 ; idx < num_banks ; idx++) {
-		/* destroy mtd_info previously allocated */
-		if (mtd_banks[idx]) {
-			mtd_device_unregister(mtd_banks[idx]);
-			map_destroy(mtd_banks[idx]);
-		}
-		/* release map_info not used anymore */
-		kfree(map_banks[idx]->name);
-		kfree(map_banks[idx]);
-	}
-
-	if (start_scan_addr) {
-		iounmap(start_scan_addr);
-		start_scan_addr = 0;
-	}
-}
-
-module_init(init_tqm_mtd);
-module_exit(cleanup_tqm_mtd);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Kirk Lee <kirk@hpc.ee.ntu.edu.tw>");
-MODULE_DESCRIPTION("MTD map driver for TQM8xxL boards");
-- 
1.7.10.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

-- 
Best Regards,
Artem Bityutskiy
