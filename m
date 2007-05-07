Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37A72DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 07:32:00 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l47LVvAO012967
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 17:31:57 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47LVvmK170996
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 15:31:57 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47LVvWD006281
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 15:31:57 -0600
Subject: [PATCH v4 2/7] Generalize tsi108 PHY types
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
In-Reply-To: <1178572962.2990.197.camel@zod.rchland.ibm.com>
References: <1178572962.2990.197.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 07 May 2007 16:26:22 -0500
Message-Id: <1178573182.2990.201.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
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

Also, convert the setup code to use of_get_mac_address instead of hard coding
a lookup for the "address" property in the ethernet node.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/sysdev/tsi108_dev.c |    7 +++++--
 drivers/net/tsi108_eth.c         |   12 +++++++-----
 drivers/net/tsi108_eth.h         |    9 ---------
 include/asm-powerpc/tsi108.h     |   11 +++++++++++
 4 files changed, 23 insertions(+), 16 deletions(-)

--- linux-2.6.orig/arch/powerpc/sysdev/tsi108_dev.c
+++ linux-2.6/arch/powerpc/sysdev/tsi108_dev.c
@@ -107,8 +107,9 @@ static int __init tsi108_eth_of_init(voi
 			goto err;
 		}
 
-		mac_addr = of_get_property(np, "address", NULL);
-		memcpy(tsi_eth_data.mac_addr, mac_addr, 6);
+		mac_addr = of_get_mac_address(np);
+		if (mac_addr)
+			memcpy(tsi_eth_data.mac_addr, mac_addr, 6);
 
 		ph = of_get_property(np, "phy-handle", NULL);
 		phy = of_find_node_by_phandle(*ph);
@@ -129,6 +130,8 @@ static int __init tsi108_eth_of_init(voi
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
