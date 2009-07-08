Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 43348B707E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 02:19:57 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 9D8BBDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 02:19:56 +1000 (EST)
Date: Wed, 8 Jul 2009 09:19:54 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: bluesmoke-devel@lists.sourceforge.net, Dave Jiang <djiang@mvista.com>,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] edac: mpc85xx: add support for mpc83xx memory controller
Message-ID: <20090708161954.GC14979@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the Freescale MPC83xx memory controller to the existing
driver for the Freescale MPC85xx memory controller. The only difference
between the two processors are in the CS_BNDS register parsing code.

The L2 cache controller does not exist on the MPC83xx, but the OF subsystem
will not use the driver if the device is not present in the OF device tree.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

This was tested on an MPC8349EMDS-based board.

I don't really like how the MCE disable works on mpc85xx (clearing the
HID1 register), but this can be revisited when mpc86xx support gets
added. It sucks to have this happen before the probe() routine is called
and we know what kind of hardware we're actually running on.

 drivers/edac/Kconfig        |    6 +++---
 drivers/edac/mpc85xx_edac.c |   38 ++++++++++++++++++++++++++++----------
 drivers/edac/mpc85xx_edac.h |    3 +++
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 4339b1a..78303f9 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -176,11 +176,11 @@ config EDAC_I5100
 	  San Clemente MCH.
 
 config EDAC_MPC85XX
-	tristate "Freescale MPC85xx"
-	depends on EDAC_MM_EDAC && FSL_SOC && MPC85xx
+	tristate "Freescale MPC83xx / MPC85xx"
+	depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || MPC85xx)
 	help
 	  Support for error detection and correction on the Freescale
-	  MPC8560, MPC8540, MPC8548
+	  MPC8349, MPC8560, MPC8540, MPC8548
 
 config EDAC_MV64X60
 	tristate "Marvell MV64x60"
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index b4f5c63..3b05130 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -43,7 +43,9 @@ static u32 orig_pci_err_en;
 #endif
 
 static u32 orig_l2_err_disable;
+#ifdef CONFIG_MPC85xx
 static u32 orig_hid1[2];
+#endif
 
 /************************ MC SYSFS parts ***********************************/
 
@@ -738,7 +740,8 @@ static irqreturn_t mpc85xx_mc_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void __devinit mpc85xx_init_csrows(struct mem_ctl_info *mci)
+static void __devinit mpc85xx_init_csrows(struct mem_ctl_info *mci,
+					  const struct of_device_id *match)
 {
 	struct mpc85xx_mc_pdata *pdata = mci->pvt_info;
 	struct csrow_info *csrow;
@@ -784,18 +787,26 @@ static void __devinit mpc85xx_init_csrows(struct mem_ctl_info *mci)
 	}
 
 	for (index = 0; index < mci->nr_csrows; index++) {
-		u32 start;
-		u32 end;
+		u32 start, end, extra;
 
 		csrow = &mci->csrows[index];
 		cs_bnds = in_be32(pdata->mc_vbase + MPC85XX_MC_CS_BNDS_0 +
 				  (index * MPC85XX_MC_CS_BNDS_OFS));
-		start = (cs_bnds & 0xfff0000) << 4;
-		end = ((cs_bnds & 0xfff) << 20);
+
+		if (match->data && match->data == MPC83xx) {
+			start = (cs_bnds & 0x00ff0000) << 8;
+			end   = (cs_bnds & 0x000000ff) << 24;
+			extra = 0x00ffffff;
+		} else {
+			start = (cs_bnds & 0x0fff0000) << 4;
+			end   = (cs_bnds & 0x00000fff) << 20;
+			extra = 0x000fffff;
+		}
+
 		if (start)
-			start |= 0xfffff;
+			start |= extra;
 		if (end)
-			end |= 0xfffff;
+			end |= extra;
 
 		if (start == end)
 			continue;	/* not populated */
@@ -886,7 +897,7 @@ static int __devinit mpc85xx_mc_err_probe(struct of_device *op,
 
 	mpc85xx_set_mc_sysfs_attributes(mci);
 
-	mpc85xx_init_csrows(mci);
+	mpc85xx_init_csrows(mci, match);
 
 #ifdef CONFIG_EDAC_DEBUG
 	edac_mc_register_mcidev_debug((struct attribute **)debug_attr);
@@ -986,6 +997,7 @@ static struct of_device_id mpc85xx_mc_err_of_match[] = {
 	{ .compatible = "fsl,mpc8560-memory-controller", },
 	{ .compatible = "fsl,mpc8568-memory-controller", },
 	{ .compatible = "fsl,mpc8572-memory-controller", },
+	{ .compatible = "fsl,mpc8349-memory-controller", .data = MPC83xx, },
 	{},
 };
 
@@ -1001,13 +1013,13 @@ static struct of_platform_driver mpc85xx_mc_err_driver = {
 		   },
 };
 
-
+#ifdef CONFIG_MPC85xx
 static void __init mpc85xx_mc_clear_rfxe(void *data)
 {
 	orig_hid1[smp_processor_id()] = mfspr(SPRN_HID1);
 	mtspr(SPRN_HID1, (orig_hid1[smp_processor_id()] & ~0x20000));
 }
-
+#endif
 
 static int __init mpc85xx_mc_init(void)
 {
@@ -1040,26 +1052,32 @@ static int __init mpc85xx_mc_init(void)
 		printk(KERN_WARNING EDAC_MOD_STR "PCI fails to register\n");
 #endif
 
+#ifdef CONFIG_MPC85xx
 	/*
 	 * need to clear HID1[RFXE] to disable machine check int
 	 * so we can catch it
 	 */
 	if (edac_op_state == EDAC_OPSTATE_INT)
 		on_each_cpu(mpc85xx_mc_clear_rfxe, NULL, 0);
+#endif
 
 	return 0;
 }
 
 module_init(mpc85xx_mc_init);
 
+#ifdef CONFIG_MPC85xx
 static void __exit mpc85xx_mc_restore_hid1(void *data)
 {
 	mtspr(SPRN_HID1, orig_hid1[smp_processor_id()]);
 }
+#endif
 
 static void __exit mpc85xx_mc_exit(void)
 {
+#ifdef CONFIG_MPC85xx
 	on_each_cpu(mpc85xx_mc_restore_hid1, NULL, 0);
+#endif
 #ifdef CONFIG_PCI
 	of_unregister_platform_driver(&mpc85xx_pci_err_driver);
 #endif
diff --git a/drivers/edac/mpc85xx_edac.h b/drivers/edac/mpc85xx_edac.h
index 52432ee..fb166d0 100644
--- a/drivers/edac/mpc85xx_edac.h
+++ b/drivers/edac/mpc85xx_edac.h
@@ -139,6 +139,9 @@
 #define MPC85XX_PCI_GAS_TIMR		0x0020
 #define MPC85XX_PCI_PCIX_TIMR		0x0024
 
+/* Device types */
+#define MPC83xx ((void *)1)
+
 struct mpc85xx_mc_pdata {
 	char *name;
 	int edac_idx;
-- 
1.5.4.3
