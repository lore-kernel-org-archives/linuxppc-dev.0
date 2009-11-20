Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3B731007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 11:42:55 +1100 (EST)
From: Peter Tyser <ptyser@xes-inc.com>
To: bluesmoke-devel@lists.sourceforge.net
Subject: [PATCH 3/4] edac: Mask mpc85xx ECC syndrome appropriately
Date: Thu, 19 Nov 2009 18:42:28 -0600
Message-Id: <1258677749-15968-3-git-send-email-ptyser@xes-inc.com>
In-Reply-To: <1258677749-15968-1-git-send-email-ptyser@xes-inc.com>
References: <1258677749-15968-1-git-send-email-ptyser@xes-inc.com>
Cc: Peter Tyser <ptyser@xes-inc.com>, linuxppc-dev@ozlabs.org,
	djiang@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With a 64-bit wide data bus only the lowest 8-bits of the ECC syndrome
are relevant.  With a 32-bit wide data bus only the lowest 16-bits are
relevant on most architectures.

Without this change, the ECC syndrome displayed can be mildly confusing,
eg:

  EDAC MPC85xx MC1: syndrome: 0x25252525

When in reality the ECC syndrome is 0x25.

Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
---
A variety of Freescale manual's say a variety of different things about
how to decode the CAPTURE_ECC (syndrome) register.  I don't have a
system with a 32-bit bus to test on, but I believe the change is
correct.  It'd be good to get an ACK from someone at Freescale
about this change though.

 drivers/edac/mpc85xx_edac.c |   12 +++++++++++-
 drivers/edac/mpc85xx_edac.h |    3 +++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index ecd5928..6d0114a 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -672,6 +672,7 @@ static void mpc85xx_mc_check(struct mem_ctl_info *mci)
 {
 	struct mpc85xx_mc_pdata *pdata = mci->pvt_info;
 	struct csrow_info *csrow;
+	u32 bus_width;
 	u32 err_detect;
 	u32 syndrome;
 	u32 err_addr;
@@ -692,6 +693,15 @@ static void mpc85xx_mc_check(struct mem_ctl_info *mci)
 	}
 
 	syndrome = in_be32(pdata->mc_vbase + MPC85XX_MC_CAPTURE_ECC);
+
+	/* Mask off appropriate bits of syndrome based on bus width */
+	bus_width = (in_be32(pdata->mc_vbase + MPC85XX_MC_DDR_SDRAM_CFG) &
+			DSC_DBW_MASK) ? 32 : 64;
+	if (bus_width == 64)
+		syndrome &= 0xff;
+	else
+		syndrome &= 0xffff;
+
 	err_addr = in_be32(pdata->mc_vbase + MPC85XX_MC_CAPTURE_ADDRESS);
 	pfn = err_addr >> PAGE_SHIFT;
 
@@ -707,7 +717,7 @@ static void mpc85xx_mc_check(struct mem_ctl_info *mci)
 	mpc85xx_mc_printk(mci, KERN_ERR, "Capture Data Low: %#8.8x\n",
 			  in_be32(pdata->mc_vbase +
 				  MPC85XX_MC_CAPTURE_DATA_LO));
-	mpc85xx_mc_printk(mci, KERN_ERR, "syndrome: %#8.8x\n", syndrome);
+	mpc85xx_mc_printk(mci, KERN_ERR, "syndrome: %#2.2x\n", syndrome);
 	mpc85xx_mc_printk(mci, KERN_ERR, "err addr: %#8.8x\n", err_addr);
 	mpc85xx_mc_printk(mci, KERN_ERR, "PFN: %#8.8x\n", pfn);
 
diff --git a/drivers/edac/mpc85xx_edac.h b/drivers/edac/mpc85xx_edac.h
index 52432ee..cb24df8 100644
--- a/drivers/edac/mpc85xx_edac.h
+++ b/drivers/edac/mpc85xx_edac.h
@@ -48,6 +48,9 @@
 #define DSC_MEM_EN	0x80000000
 #define DSC_ECC_EN	0x20000000
 #define DSC_RD_EN	0x10000000
+#define DSC_DBW_MASK	0x00180000
+#define DSC_DBW_32	0x00080000
+#define DSC_DBW_64	0x00000000
 
 #define DSC_SDTYPE_MASK		0x07000000
 
-- 
1.6.2.1
