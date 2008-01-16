Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id B7BABDDE1A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 08:25:25 +1100 (EST)
Message-ID: <478E7643.5040804@pikatech.com>
Date: Wed, 16 Jan 2008 16:25:23 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
Subject: Re: [PATCH] MTD for Taco
References: <477F12D1.2070109@pikatech.com> <200801051041.18173.sr@denx.de>
	<478AEB39.70106@pikatech.com>
In-Reply-To: <478AEB39.70106@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sean MacLennan wrote:
> How about adding a config option that lets you specify 8 bit access? 
> Something like CONFIG_NDFC_8BIT_ACCESS. We could default it to no and 
> put a little blurb that says something like:
>
> On some platforms the 32bit read/writes cause a machine access 
> exception. If you get a machine access exception while reading the NAND 
> bad block table, try turning on 8 bit access.
>   
I know it would be better if 32 bit access just worked, but nobody 
actively objected to this idea, so here is a patch ;)

Cheers,
   Sean

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 246d451..2809ded 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -153,11 +153,21 @@ config MTD_NAND_S3C2410_HWECC
 
 config MTD_NAND_NDFC
 	tristate "NDFC NanD Flash Controller"
-	depends on 4xx && !PPC_MERGE
+	depends on 4xx
 	select MTD_NAND_ECC_SMC
 	help
 	 NDFC Nand Flash Controllers are integrated in IBM/AMCC's 4xx SoCs
 
+config NDFC_8BIT_ACCESS
+	bool "NDFC 8-bit access only"
+	depends on MTD_NAND_NDFC
+	default n
+	help
+	 The NDFC supports 32 bit read/writes to the NAND to improve
+	 performance. On some platforms this does not work. If you get
+	 a machine access exception while reading the bad block table,
+	 try setting this to Y.
+
 config MTD_NAND_S3C2410_CLKSTOP
 	bool "S3C2410 NAND IDLE clock stop"
 	depends on MTD_NAND_S3C2410
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 1c0e89f..ac06099 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -24,11 +24,13 @@
 #include <linux/platform_device.h>
 
 #include <asm/io.h>
+#ifndef CONFIG_PPC_MERGE
 #ifdef CONFIG_40x
 #include <asm/ibm405.h>
 #else
 #include <asm/ibm44x.h>
 #endif
+#endif
 
 struct ndfc_nand_mtd {
 	struct mtd_info			mtd;
@@ -110,6 +112,37 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
 	return 0;
 }
 
+#ifdef CONFIG_NDFC_8BIT_ACCESS
+static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+{
+	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	uint8_t *p = (uint8_t *) buf;
+
+	for (; len > 0; len--)
+		*p++ = __raw_readb(ndfc->ndfcbase + NDFC_DATA);
+}
+
+static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	uint8_t *p = (uint8_t *) buf;
+
+	for (; len > 0; len--)
+		__raw_writeb(*p++, ndfc->ndfcbase + NDFC_DATA);
+}
+
+static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct ndfc_controller *ndfc = &ndfc_ctrl;
+	uint8_t *p = (uint8_t *) buf;
+
+	for (; len > 0; len--)
+		if (*p++ != __raw_readb(ndfc->ndfcbase + NDFC_DATA))
+			return -EFAULT;
+
+	return 0;
+}
+#else
 /*
  * Speedups for buffer read/write/verify
  *
@@ -145,6 +178,7 @@ static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 			return -EFAULT;
 	return 0;
 }
+#endif
 
 /*
  * Initialize chip structure
@@ -236,6 +270,8 @@ static int ndfc_nand_probe(struct platform_device *pdev)
 
 #ifndef CONFIG_PHYS_64BIT
 	ndfc->ndfcbase = ioremap((phys_addr_t)phys, res->end - res->start + 1);
+#elif defined(CONFIG_PPC_MERGE)
+	ndfc->ndfcbase = ioremap(phys, res->end - res->start + 1);
 #else
 	ndfc->ndfcbase = ioremap64(phys, res->end - res->start + 1);
 #endif
