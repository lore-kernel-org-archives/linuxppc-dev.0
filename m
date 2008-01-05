Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E0990DDE2D
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 16:17:06 +1100 (EST)
Message-ID: <477F12D1.2070109@pikatech.com>
Date: Sat, 05 Jan 2008 00:17:05 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] MTD for Taco
Content-Type: multipart/mixed; boundary="------------000806040002010103050004"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000806040002010103050004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds the maps for the taco. It also gets the ndfc.c NAND 
driver in a compilable state. The map is guaranteed to change since the 
exact NOR/NAND flash configuration is in flux right now when we found 
the 256M NAND flash won't boot properly.

Currently it configures the NOR in a reasonable fashion and leaves the 
NAND as one honkin' parition.

Cheers,
   Sean


--------------000806040002010103050004
Content-Type: text/plain;
 name="mtd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mtd.patch"

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index a592fc0..24cbafa 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -588,6 +588,15 @@ config MTD_INTEL_VR_NOR
 	  Map driver for a NOR flash bank located on the Expansion Bus of the
 	  Intel Vermilion Range chipset.
 
+config MTD_TACO
+	tristate "Flash devices mapped on Taco boards."
+	depends on MTD_CFI && PPC32 && 44x && TACO
+	help
+	  This enables access routined for the flash chips on the PIKA
+	  Taco board.
+	  If you have this board and would like to use the flash
+	  chips on it, say 'Y'.
+
 config MTD_PLATRAM
 	tristate "Map driver for platform device RAM (mtd-ram)"
 	select MTD_RAM
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 316382a..4de7ef9 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -69,3 +69,4 @@ obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
 obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
 obj-$(CONFIG_MTD_MTX1)		+= mtx-1_flash.o
 obj-$(CONFIG_MTD_INTEL_VR_NOR)	+= intel_vr_nor.o
+obj-$(CONFIG_MTD_TACO)	        += taco.o
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 246d451..ca9f35a 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -153,7 +153,7 @@ config MTD_NAND_S3C2410_HWECC
 
 config MTD_NAND_NDFC
 	tristate "NDFC NanD Flash Controller"
-	depends on 4xx && !PPC_MERGE
+	depends on 4xx
 	select MTD_NAND_ECC_SMC
 	help
 	 NDFC Nand Flash Controllers are integrated in IBM/AMCC's 4xx SoCs
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 1c0e89f..f5e93cf 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -24,11 +24,6 @@
 #include <linux/platform_device.h>
 
 #include <asm/io.h>
-#ifdef CONFIG_40x
-#include <asm/ibm405.h>
-#else
-#include <asm/ibm44x.h>
-#endif
 
 struct ndfc_nand_mtd {
 	struct mtd_info			mtd;
@@ -110,6 +105,40 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
 	return 0;
 }
 
+#ifdef CONFIG_TACO
+/* The NDFC may allow 32bit read/writes, but it sure doesn't work on
+ * the taco!
+ */
+static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+{
+	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	uint8_t *p = (uint8_t *) buf;
+
+	for(;len > 0; len -= 1)
+		*p++ = __raw_readb(ndfc->ndfcbase + NDFC_DATA);
+}
+
+static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	uint8_t *p = (uint8_t *) buf;
+
+	for(;len > 0; len -= 1)
+		__raw_writeb(*p++, ndfc->ndfcbase + NDFC_DATA);
+}
+
+static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	uint8_t *p = (uint8_t *) buf;
+
+	for(;len > 0; len -= 1)
+		if (*p++ != __raw_readb(ndfc->ndfcbase + NDFC_DATA))
+			return -EFAULT;
+
+	return 0;
+}
+#else
 /*
  * Speedups for buffer read/write/verify
  *
@@ -145,6 +174,7 @@ static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 			return -EFAULT;
 	return 0;
 }
+#endif
 
 /*
  * Initialize chip structure
@@ -237,7 +267,7 @@ static int ndfc_nand_probe(struct platform_device *pdev)
 #ifndef CONFIG_PHYS_64BIT
 	ndfc->ndfcbase = ioremap((phys_addr_t)phys, res->end - res->start + 1);
 #else
-	ndfc->ndfcbase = ioremap64(phys, res->end - res->start + 1);
+	ndfc->ndfcbase = ioremap(phys, res->end - res->start + 1);
 #endif
 	if (!ndfc->ndfcbase) {
 		printk(KERN_ERR "NDFC: ioremap failed\n");
--- /dev/null	2005-11-20 22:22:37.000000000 -0500
+++ drivers/mtd/maps/taco.c	2008-01-02 13:07:43.000000000 -0500
@@ -0,0 +1,140 @@
+/*
+ * $Id: $
+ *
+ * drivers/mtd/maps/taco.c
+ *
+ * Mapping for PIKA Taco flash
+ *
+ * Based on original work by
+ *      Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/io.h>
+
+#define TACO_FLASH_BASE 0xffc00000 // SAM CHECK
+
+#define RW_KERNEL_SZ	0x00180000
+#define RW_ROOT_SZ      0x03480000
+#define RW_FPGA_SZ	0x00040000
+#define RW_ENV_SZ       0x00040000
+#define RW_UBOOT_SZ	0x00080000
+
+static struct mtd_partition taco_flash_parts[] = {
+	{ // 0
+		.name   = "kernel",
+		.offset = 0,
+		.size   = RW_KERNEL_SZ
+	},
+	{ // 1
+		.name   = "root",
+		.offset = RW_KERNEL_SZ,
+		.size   = RW_ROOT_SZ
+	},
+	{ // 2
+		.name   = "user",
+		.offset = RW_KERNEL_SZ + RW_ROOT_SZ,
+		.size   = 0 // auto - must be zero
+	},
+	/* ------------------------ */
+	{  // 3
+		.name = "fpga",
+		.size = RW_FPGA_SZ
+	},
+	{ // 4
+		.name = "env",
+		.size = RW_ENV_SZ
+	},
+	{ // 5
+		.name = "u-boot",
+		.size = RW_UBOOT_SZ
+	}
+};
+
+struct map_info taco_flash_map = {
+	.name = "taco-flash",
+	.bankwidth = 2,
+};
+
+static struct mtd_info *taco_mtd;
+
+int __init init_taco_flash(void)
+{
+	unsigned long flash_base, flash_size;
+	int i, user_size; // must be signed!
+
+	// SAM How do we get the flash size??????
+	flash_base = TACO_FLASH_BASE;
+	flash_size = 64 * 0x100000; // SAM HACK 64M
+
+	taco_flash_map.size = flash_size;
+	taco_flash_map.phys = flash_base;
+	taco_flash_map.virt = (void __iomem *)ioremap(flash_base, flash_size);
+
+	if (!taco_flash_map.virt) {
+		printk("init_taco_flash: failed to ioremap\n");
+		return -EIO;
+	}
+
+	/* user gets left over space */
+	user_size = flash_size;
+	for(i = 0; i < ARRAY_SIZE(taco_flash_parts); ++i)
+		user_size -= taco_flash_parts[i].size;
+	if(user_size > 0)
+		taco_flash_parts[2].size = user_size;
+
+	/* u-boot */
+	flash_size -= RW_UBOOT_SZ;
+	taco_flash_parts[5].offset = flash_size;
+
+	/* env */
+	flash_size -= RW_ENV_SZ;
+	taco_flash_parts[4].offset = flash_size;
+
+	/* fpga */
+	flash_size -= RW_FPGA_SZ;
+	taco_flash_parts[3].offset = flash_size;
+
+	simple_map_init(&taco_flash_map);
+
+	taco_mtd = do_map_probe("cfi_probe", &taco_flash_map);
+
+	if (taco_mtd) {
+		taco_mtd->owner = THIS_MODULE;
+		return add_mtd_partitions(taco_mtd,
+								  taco_flash_parts,
+								  ARRAY_SIZE(taco_flash_parts));
+	}
+
+	return -ENXIO;
+}
+
+static void __exit cleanup_taco_flash(void)
+{
+	if (taco_mtd) {
+		del_mtd_partitions(taco_mtd);
+		/* moved iounmap after map_destroy - armin */
+		map_destroy(taco_mtd);
+		iounmap((void *)taco_flash_map.virt);
+		taco_mtd = NULL;
+	}
+}
+
+module_init(init_taco_flash);
+module_exit(cleanup_taco_flash);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MTD map and partitions for Taco boards");

--------------000806040002010103050004--
