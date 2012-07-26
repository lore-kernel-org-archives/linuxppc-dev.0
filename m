Return-Path: <b08782@zro04cle141.ea.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 43B542C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 00:48:38 +1000 (EST)
From: Claudiu Manoil <claudiu.manoil@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][v1] powerpc/85xx: Fix sram_offset parameter type
Date: Thu, 26 Jul 2012 17:47:55 +0300
Message-ID: <1343314075-2127-1-git-send-email-claudiu.manoil@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>,
 Claudiu Manoil <claudiu.manoil@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The sram_offset parameter represents a physical address
and should be of type phys_addr_t. As part of this fix,
the extraction of sram_params is being cleaned-up and
fixed.
This patch fixes now the case when the offset value of
0xfff00000 was being rejected by the driver (returning
-EINVAL), although this is a valid offset value.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
---
v1: fixed copyright year format

 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h |    4 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   39 ++++++++++------------------
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h b/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
index 60c9c0b..2aa97dd 100644
--- a/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
+++ b/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2009-2010 Freescale Semiconductor, Inc
+ * Copyright 2009-2010, 2012 Freescale Semiconductor, Inc
  *
  * QorIQ based Cache Controller Memory Mapped Registers
  *
@@ -91,7 +91,7 @@ struct mpc85xx_l2ctlr {
 
 struct sram_parameters {
 	unsigned int sram_size;
-	uint64_t sram_offset;
+	phys_addr_t sram_offset;
 };
 
 extern int instantiate_cache_sram(struct platform_device *dev,
diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index 611bb4b..d131c8a 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2009-2010 Freescale Semiconductor, Inc.
+ * Copyright 2009-2010, 2012 Freescale Semiconductor, Inc.
  *
  * QorIQ (P1/P2) L2 controller init for Cache-SRAM instantiation
  *
@@ -31,24 +31,21 @@ static char *sram_size;
 static char *sram_offset;
 struct mpc85xx_l2ctlr __iomem *l2ctlr;
 
-static long get_cache_sram_size(void)
+static int get_cache_sram_params(struct sram_parameters *sram_params)
 {
-	unsigned long val;
+	unsigned long long addr;
+	unsigned int size;
 
-	if (!sram_size || (strict_strtoul(sram_size, 0, &val) < 0))
+	if (!sram_size || (kstrtouint(sram_size, 0, &size) < 0))
 		return -EINVAL;
 
-	return val;
-}
-
-static long get_cache_sram_offset(void)
-{
-	unsigned long val;
-
-	if (!sram_offset || (strict_strtoul(sram_offset, 0, &val) < 0))
+	if (!sram_offset || (kstrtoull(sram_offset, 0, &addr) < 0))
 		return -EINVAL;
 
-	return val;
+	sram_params->sram_offset = addr;
+	sram_params->sram_size = size;
+
+	return 0;
 }
 
 static int __init get_size_from_cmdline(char *str)
@@ -93,17 +90,9 @@ static int __devinit mpc85xx_l2ctlr_of_probe(struct platform_device *dev)
 	}
 	l2cache_size = *prop;
 
-	sram_params.sram_size  = get_cache_sram_size();
-	if ((int)sram_params.sram_size <= 0) {
-		dev_err(&dev->dev,
-			"Entire L2 as cache, Aborting Cache-SRAM stuff\n");
-		return -EINVAL;
-	}
-
-	sram_params.sram_offset  = get_cache_sram_offset();
-	if ((int64_t)sram_params.sram_offset <= 0) {
+	if (get_cache_sram_params(&sram_params)) {
 		dev_err(&dev->dev,
-			"Entire L2 as cache, provide a valid sram offset\n");
+			"Entire L2 as cache, provide valid sram offset and size\n");
 		return -EINVAL;
 	}
 
@@ -125,14 +114,14 @@ static int __devinit mpc85xx_l2ctlr_of_probe(struct platform_device *dev)
 	 * Write bits[0-17] to srbar0
 	 */
 	out_be32(&l2ctlr->srbar0,
-		sram_params.sram_offset & L2SRAM_BAR_MSK_LO18);
+		lower_32_bits(sram_params.sram_offset) & L2SRAM_BAR_MSK_LO18);
 
 	/*
 	 * Write bits[18-21] to srbare0
 	 */
 #ifdef CONFIG_PHYS_64BIT
 	out_be32(&l2ctlr->srbarea0,
-		(sram_params.sram_offset >> 32) & L2SRAM_BARE_MSK_HI4);
+		upper_32_bits(sram_params.sram_offset) & L2SRAM_BARE_MSK_HI4);
 #endif
 
 	clrsetbits_be32(&l2ctlr->ctl, L2CR_L2E, L2CR_L2FI);
-- 
1.6.6
