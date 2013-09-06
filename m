Return-Path: <R58495@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 567E22C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 01:43:47 +1000 (EST)
From: York Sun <yorksun@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 1/7] powerpc/mpc85xx: Fix EDAC address capture
Date: Fri, 6 Sep 2013 08:43:13 -0700
Message-ID: <1378482199-10581-1-git-send-email-yorksun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Extend err_addr to cover 64 bits for DDR errors.

Signed-off-by: York Sun <yorksun@freescale.com>
Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
---
 drivers/edac/mpc85xx_edac.c |   10 +++++++---
 drivers/edac/mpc85xx_edac.h |    1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 3eb32f6..392178f 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -773,6 +773,8 @@ static void sbe_ecc_decode(u32 cap_high, u32 cap_low, u32 cap_ecc,
 	}
 }
 
+#define make64(high, low) (((u64)(high) << 32) | (low))
+
 static void mpc85xx_mc_check(struct mem_ctl_info *mci)
 {
 	struct mpc85xx_mc_pdata *pdata = mci->pvt_info;
@@ -780,7 +782,7 @@ static void mpc85xx_mc_check(struct mem_ctl_info *mci)
 	u32 bus_width;
 	u32 err_detect;
 	u32 syndrome;
-	u32 err_addr;
+	u64 err_addr;
 	u32 pfn;
 	int row_index;
 	u32 cap_high;
@@ -811,7 +813,9 @@ static void mpc85xx_mc_check(struct mem_ctl_info *mci)
 	else
 		syndrome &= 0xffff;
 
-	err_addr = in_be32(pdata->mc_vbase + MPC85XX_MC_CAPTURE_ADDRESS);
+	err_addr = make64(
+		in_be32(pdata->mc_vbase + MPC85XX_MC_CAPTURE_EXT_ADDRESS),
+		in_be32(pdata->mc_vbase + MPC85XX_MC_CAPTURE_ADDRESS));
 	pfn = err_addr >> PAGE_SHIFT;
 
 	for (row_index = 0; row_index < mci->nr_csrows; row_index++) {
@@ -848,7 +852,7 @@ static void mpc85xx_mc_check(struct mem_ctl_info *mci)
 	mpc85xx_mc_printk(mci, KERN_ERR,
 			"Captured Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
 			cap_high, cap_low, syndrome);
-	mpc85xx_mc_printk(mci, KERN_ERR, "Err addr: %#8.8x\n", err_addr);
+	mpc85xx_mc_printk(mci, KERN_ERR, "Err addr: %#8.8llx\n", err_addr);
 	mpc85xx_mc_printk(mci, KERN_ERR, "PFN: %#8.8x\n", pfn);
 
 	/* we are out of range */
diff --git a/drivers/edac/mpc85xx_edac.h b/drivers/edac/mpc85xx_edac.h
index 932016f..efb25bc 100644
--- a/drivers/edac/mpc85xx_edac.h
+++ b/drivers/edac/mpc85xx_edac.h
@@ -43,6 +43,7 @@
 #define MPC85XX_MC_ERR_INT_EN		0x0e48
 #define MPC85XX_MC_CAPTURE_ATRIBUTES	0x0e4c
 #define MPC85XX_MC_CAPTURE_ADDRESS	0x0e50
+#define MPC85XX_MC_CAPTURE_EXT_ADDRESS	0x0e54
 #define MPC85XX_MC_ERR_SBE		0x0e58
 
 #define DSC_MEM_EN	0x80000000
-- 
1.7.9.5
