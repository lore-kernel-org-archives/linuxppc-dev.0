Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 65F42DDDDB
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 02:20:51 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l45GKlwV015551
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 12:20:47 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l45GKlgD182204
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 10:20:47 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l45GKkW1014518
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 10:20:47 -0600
Received: from [9.67.207.4] (wecm-9-67-207-4.wecm.ibm.com [9.67.207.4])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l45GKjBM014510
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 10:20:46 -0600
Subject: [PATCH v2 2/7] Generalize tsi108 PHY types
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1178381611.3393.25.camel@zod.rchland.ibm.com>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sat, 05 May 2007 11:15:39 -0500
Message-Id: <1178381739.3393.28.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a phy_type field to the tsi108 ethernet structures to indicate which PHY
is used on a board.  This is derived from the "compatible" property in the
ethernet-phy node of the device tree.  The default remains the MV88E PHY.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/sysdev/tsi108_dev.c |    2 ++
 drivers/net/tsi108_eth.c         |   12 +++++++-----
 drivers/net/tsi108_eth.h         |    9 ---------
 include/asm-powerpc/tsi108.h     |   11 +++++++++++
 4 files changed, 20 insertions(+), 14 deletions(-)

--- linux-2.6.orig/arch/powerpc/sysdev/tsi108_dev.c
+++ linux-2.6/arch/powerpc/sysdev/tsi108_dev.c
@@ -129,6 +129,8 @@ static int __init tsi108_eth_of_init(voi
 		tsi_eth_data.phyregs = res.start;
 		tsi_eth_data.phy = *phy_id;
 		tsi_eth_data.irq_num = irq_of_parse_and_map(np, 0);
+		if (of_device_is_compatible(phy, "bcm54xx"))
+			tsi_eth_data.phy_type = TSI108_PHY_BCM54XX;
 		of_node_put(phy);
 		ret =
 		    platform_device_add_data(tsi_eth_dev, &tsi_eth_data,
--- linux-2.6.orig/drivers/net/tsi108_eth.c
+++ linux-2.6/drivers/net/tsi108_eth.c
@@ -82,6 +82,7 @@ struct tsi108_prv_data {
 	unsigned int phy;		/* Index of PHY for this interface */
 	unsigned int irq_num;
 	unsigned int id;
+	unsigned int phy_type;
 
 	struct timer_list timer;/* Timer that triggers the check phy function */
 	unsigned int rxtail;	/* Next entry in rxring to read */
@@ -1256,11 +1257,11 @@ static void tsi108_init_phy(struct net_d
 	if (i == 0)
 		printk(KERN_ERR "%s function time out \n", __FUNCTION__);
 
-#if (TSI108_PHY_TYPE == PHY_BCM54XX)	/* Broadcom BCM54xx PHY */
-	tsi108_write_mii(data, 0x09, 0x0300);
-	tsi108_write_mii(data, 0x10, 0x1020);
-	tsi108_write_mii(data, 0x1c, 0x8c00);
-#endif
+	if (data->phy_type == TSI108_PHY_BCM54XX) {
+		tsi108_write_mii(data, 0x09, 0x0300);
+		tsi108_write_mii(data, 0x10, 0x1020);
+		tsi108_write_mii(data, 0x1c, 0x8c00);
+	}
 
 	tsi108_write_mii(data,
 			 MII_BMCR,
@@ -1587,6 +1588,7 @@ tsi108_init_one(struct platform_device *
 	data->mii_if.supports_gmii = mii_check_gmii_support(&data->mii_if);
 
 	data->phy = einfo->phy;
+	data->phy_type = einfo->phy_type;
 	data->irq_num = einfo->irq_num;
 	data->id = pdev->id;
 	dev->open = tsi108_open;
--- linux-2.6.orig/drivers/net/tsi108_eth.h
+++ linux-2.6/drivers/net/tsi108_eth.h
@@ -43,15 +43,6 @@
 	in_be32((data->phyregs + (offset)))
 
 /*
- * PHY Configuration Options
- *
- * NOTE: Enable set of definitions corresponding to your board type
- */
-#define PHY_MV88E	1	/* Marvel 88Exxxx PHY */
-#define PHY_BCM54XX	2	/* Broardcom BCM54xx PHY */
-#define TSI108_PHY_TYPE	PHY_MV88E
-
-/*
  * TSI108 GIGE port registers
  */
 
--- linux-2.6.orig/include/asm-powerpc/tsi108.h
+++ linux-2.6/include/asm-powerpc/tsi108.h
@@ -70,6 +70,16 @@
 
 #define TSI108_PCI_CFG_BASE_PHYS	(0xfb000000)
 #define TSI108_PCI_CFG_SIZE		(0x01000000)
+
+/*
+ * PHY Configuration Options
+ *
+ * Specify "bcm54xx" in the compatible property of your device tree phy
+ * nodes if your board uses the Broadcom PHYs
+ */
+#define TSI108_PHY_MV88E	0	/* Marvel 88Exxxx PHY */
+#define TSI108_PHY_BCM54XX	1	/* Broardcom BCM54xx PHY */
+
 /* Global variables */
 
 extern u32 tsi108_pci_cfg_base;
@@ -93,6 +103,7 @@ typedef struct {
 	u16 phy;		/* phy address */
 	u16 irq_num;		/* irq number */
 	u8 mac_addr[6];		/* phy mac address */
+	u16 phy_type;	/* type of phy on board */
 } hw_info;
 
 extern u32 get_vir_csrbase(void);
