Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 0014FDE091
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 05:05:36 +1100 (EST)
Message-ID: <47850CEF.9060209@pikatech.com>
Date: Wed, 09 Jan 2008 13:05:35 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] MTD for Taco
References: <477F12D1.2070109@pikatech.com> <200801051041.18173.sr@denx.de>
In-Reply-To: <200801051041.18173.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Saturday 05 January 2008, Sean MacLennan wrote:
>   
>> This patch adds the maps for the taco. It also gets the ndfc.c NAND
>> driver in a compilable state. The map is guaranteed to change since the
>> exact NOR/NAND flash configuration is in flux right now when we found
>> the 256M NAND flash won't boot properly.
>>
>> Currently it configures the NOR in a reasonable fashion and leaves the
>> NAND as one honkin' parition.
>>     
>
> <snip>
>
>   
>> diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
>> index 1c0e89f..f5e93cf 100644
>> --- a/drivers/mtd/nand/ndfc.c
>> +++ b/drivers/mtd/nand/ndfc.c
>> @@ -24,11 +24,6 @@
>>  #include <linux/platform_device.h>
>>  
>>  #include <asm/io.h>
>> -#ifdef CONFIG_40x
>> -#include <asm/ibm405.h>
>> -#else
>> -#include <asm/ibm44x.h>
>> -#endif
>>     
>
> You do break arch/ppc support with this patch. We have to still support
> arch/ppc a few month, so please don't break this support for now.
>  
Here is an updated patch that does not break the ppc arch support. 
Unfortunately, it still has the taco specific patch. I can't find 
anything different between the taco and the sequoia and since this patch 
fixes the problem, the hardware guys refuse to look into it. I can't 
blame them as we are overloaded as it is.

But I will send out the patch anyway in case anybody needs the ndfc 
driver working under the powerpc arch.

Cheers,
    Sean

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
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
index 1c0e89f..fe19177 100644
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
@@ -110,6 +112,40 @@ static int ndfc_calculate_ecc(struct mtd_info *mtd,
 	return 0;
 }
 
+#ifdef CONFIG_WARP
+/* The NDFC may allow 32bit read/writes, but it sure doesn't work on
+ * the Warp!
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
@@ -145,6 +181,7 @@ static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 			return -EFAULT;
 	return 0;
 }
+#endif
 
 /*
  * Initialize chip structure
@@ -236,6 +273,8 @@ static int ndfc_nand_probe(struct platform_device *pdev)
 
 #ifndef CONFIG_PHYS_64BIT
 	ndfc->ndfcbase = ioremap((phys_addr_t)phys, res->end - res->start + 1);
+#elif defined(CONFIG_PPC_MERGE)
+	ndfc->ndfcbase = ioremap(phys, res->end - res->start + 1);
 #else
 	ndfc->ndfcbase = ioremap64(phys, res->end - res->start + 1);
 #endif
