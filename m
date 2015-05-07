Return-Path: <Wenbin.Song@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D3621A058C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 20:17:33 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0133.outbound.protection.outlook.com [207.46.100.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4EB9014010F
 for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2015 20:17:32 +1000 (AEST)
From: songwenbin <Wenbin.Song@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v2 2/2] powerpc/mpc85xx: Fix EDAC address capture
Date: Thu, 7 May 2015 17:41:38 +0800
Message-ID: <1430991698-29832-2-git-send-email-Wenbin.Song@freescale.com>
In-Reply-To: <1430991698-29832-1-git-send-email-Wenbin.Song@freescale.com>
References: <1430991698-29832-1-git-send-email-Wenbin.Song@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mingkai.hu@freescale.com, York Sun <yorksun@freescale.com>,
 songwenbin <wenbin.song@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: York Sun <yorksun@freescale.com>

Extend err_addr to cover 64 bits for DDR errors.

Signed-off-by: York Sun <yorksun@freescale.com>
Signed-off-by: songwenbin <wenbin.song@freescale.com>
---
 drivers/edac/mpc85xx_edac.c | 10 +++++++---
 drivers/edac/mpc85xx_edac.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 68bf234..23ef8e9 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -811,6 +811,8 @@ static void sbe_ecc_decode(u32 cap_high, u32 cap_low, u32 cap_ecc,
 	}
 }
 
+#define make64(high, low) (((u64)(high) << 32) | (low))
+
 static void mpc85xx_mc_check(struct mem_ctl_info *mci)
 {
 	struct mpc85xx_mc_pdata *pdata = mci->pvt_info;
@@ -818,7 +820,7 @@ static void mpc85xx_mc_check(struct mem_ctl_info *mci)
 	u32 bus_width;
 	u32 err_detect;
 	u32 syndrome;
-	u32 err_addr;
+	u64 err_addr;
 	u32 pfn;
 	int row_index;
 	u32 cap_high;
@@ -849,7 +851,9 @@ static void mpc85xx_mc_check(struct mem_ctl_info *mci)
 	else
 		syndrome &= 0xffff;
 
-	err_addr = in_be32(pdata->mc_vbase + MPC85XX_MC_CAPTURE_ADDRESS);
+	err_addr = make64(
+		in_be32(pdata->mc_vbase + MPC85XX_MC_CAPTURE_EXT_ADDRESS),
+		in_be32(pdata->mc_vbase + MPC85XX_MC_CAPTURE_ADDRESS));
 	pfn = err_addr >> PAGE_SHIFT;
 
 	for (row_index = 0; row_index < mci->nr_csrows; row_index++) {
@@ -886,7 +890,7 @@ static void mpc85xx_mc_check(struct mem_ctl_info *mci)
 	mpc85xx_mc_printk(mci, KERN_ERR,
 			"Captured Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
 			cap_high, cap_low, syndrome);
-	mpc85xx_mc_printk(mci, KERN_ERR, "Err addr: %#8.8x\n", err_addr);
+	mpc85xx_mc_printk(mci, KERN_ERR, "Err addr: %#8.8llx\n", err_addr);
 	mpc85xx_mc_printk(mci, KERN_ERR, "PFN: %#8.8x\n", pfn);
 
 	/* we are out of range */
diff --git a/drivers/edac/mpc85xx_edac.h b/drivers/edac/mpc85xx_edac.h
index 4498baf..9352e88 100644
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
2.1.0.27.g96db324
