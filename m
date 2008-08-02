Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 273C9DDDEF
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 13:30:11 +1000 (EST)
Date: Fri, 1 Aug 2008 23:30:00 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] port ndfc driver to arch/powerpc
Message-ID: <20080801233000.3574434f@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a port of the ndfc driver from arch/ppc to arch/powerpc. Since
arch/ppc has been removed, references to CONFIG_PPC_MERGE where removed.

For an example of how to use the driver see
arch/powerpc/platforms/44x/warp-nand.c .

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 02f9cc3..b0d408e 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -165,7 +165,7 @@ config MTD_NAND_S3C2410_HWECC
 
 config MTD_NAND_NDFC
 	tristate "NDFC NanD Flash Controller"
-	depends on 4xx && !PPC_MERGE
+	depends on 4xx
 	select MTD_NAND_ECC_SMC
 	help
 	 NDFC Nand Flash Controllers are integrated in IBM/AMCC's 4xx SoCs
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 955959e..efb1ab6 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -21,14 +21,11 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/ndfc.h>
 #include <linux/mtd/mtd.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/platform_device.h>
 
 #include <asm/io.h>
-#ifdef CONFIG_40x
-#include <asm/ibm405.h>
-#else
-#include <asm/ibm44x.h>
-#endif
 
 struct ndfc_nand_mtd {
 	struct mtd_info			mtd;
@@ -103,8 +100,9 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
 
 	wmb();
 	ecc = __raw_readl(ndfc->ndfcbase + NDFC_ECC);
-	ecc_code[0] = p[1];
-	ecc_code[1] = p[2];
+	/* The NDFC uses Smart Media (SMC) bytes order */
+	ecc_code[0] = p[2];
+	ecc_code[1] = p[1];
 	ecc_code[2] = p[3];
 
 	return 0;
@@ -234,11 +232,7 @@ static int ndfc_nand_probe(struct platform_device *pdev)
 	struct ndfc_controller *ndfc = &ndfc_ctrl;
 	unsigned long long phys = settings->ndfc_erpn | res->start;
 
-#ifndef CONFIG_PHYS_64BIT
 	ndfc->ndfcbase = ioremap((phys_addr_t)phys, res->end - res->start + 1);
-#else
-	ndfc->ndfcbase = ioremap64(phys, res->end - res->start + 1);
-#endif
 	if (!ndfc->ndfcbase) {
 		printk(KERN_ERR "NDFC: ioremap failed\n");
 		return -EIO;
@@ -300,9 +294,16 @@ static int __init ndfc_nand_init(void)
 	init_waitqueue_head(&ndfc_ctrl.ndfc_control.wq);
 
 	ret = platform_driver_register(&ndfc_nand_driver);
-	if (!ret)
-		ret = platform_driver_register(&ndfc_chip_driver);
-	return ret;
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&ndfc_chip_driver);
+	if (ret) {
+		platform_driver_unregister(&ndfc_nand_driver);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void __exit ndfc_nand_exit(void)
