Date: Thu, 5 Aug 2004 15:02:00 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: jgarzik@pobox.com
Cc: linuxppc-dev@lists.linuxppc.org, linux-net@vger.kernel.org
Subject: [PATCH][EMAC] ibm_emac driver updates
Message-ID: <20040805150200.F14159@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Optimizes transmit windows for improved performance and to prevent
TX underruns. Fixes driver registration error handling. Fixes ZMII
and RGMII thinkos. Fixes for MDIO handling issues from Ralph
Siemsen. Please apply.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== drivers/net/ibm_emac/ibm_emac.h 1.1 vs edited =====
--- 1.1/drivers/net/ibm_emac/ibm_emac.h	Sat May 22 10:13:08 2004
+++ edited/drivers/net/ibm_emac/ibm_emac.h	Wed Aug  4 15:41:48 2004
@@ -228,6 +228,21 @@
 	 (desc & EMAC_BAD_RX_PACKET)
 #endif

+/* SoC implementation specific EMAC register defaults */
+#if defined(CONFIG_440GP)
+#define EMAC_RWMR_DEFAULT		0x80009000
+#define EMAC_TMR0_DEFAULT		0x00000000
+#define EMAC_TMR1_DEFAULT		0xf8640000
+#elif defined(CONFIG_440GX)
+#define EMAC_RWMR_DEFAULT		0x1000a200
+#define EMAC_TMR0_DEFAULT		EMAC_TMR0_TFAE_2_32
+#define EMAC_TMR1_DEFAULT		0xa00f0000
+#else
+#define EMAC_RWMR_DEFAULT		0x0f002000
+#define EMAC_TMR0_DEFAULT		0x00000000
+#define EMAC_TMR1_DEFAULT		0x380f0000
+#endif				/* CONFIG_440GP */
+
 /* Revision specific EMAC register defaults */
 #ifdef CONFIG_IBM_EMAC4
 #define EMAC_M1_DEFAULT			(EMAC_M1_BASE | \
@@ -236,7 +251,7 @@
 #define EMAC_RMR_DEFAULT		(EMAC_RMR_BASE | \
 					EMAC_RMR_RFAF_128_2048)
 #define EMAC_TMR0_XMIT			(EMAC_TMR0_GNP0 | \
-					EMAC_TMR0_TFAE_128_2048)
+					EMAC_TMR0_DEFAULT)
 #define EMAC_TRTR_DEFAULT		EMAC_TRTR_1024
 #else				/* !CONFIG_IBM_EMAC4 */
 #define EMAC_M1_DEFAULT			EMAC_M1_BASE
@@ -244,20 +259,5 @@
 #define EMAC_TMR0_XMIT			EMAC_TMR0_GNP0
 #define EMAC_TRTR_DEFAULT		EMAC_TRTR_1600
 #endif				/* CONFIG_IBM_EMAC4 */
-
-/* SoC implementation specific EMAC register defaults */
-#if defined(CONFIG_440GP)
-#define EMAC_RWMR_DEFAULT		0x80009000
-#define EMAC_TMR0_DEFAULT		0x00000000
-#define EMAC_TMR1_DEFAULT		0xf8640000
-#elif defined(CONFIG_440GX)
-#define EMAC_RWMR_DEFAULT		0x1000a200
-#define EMAC_TMR0_DEFAULT		EMAC_TMR0_TFAE_128_2048
-#define EMAC_TMR1_DEFAULT		0x88810000
-#else
-#define EMAC_RWMR_DEFAULT		0x0f002000
-#define EMAC_TMR0_DEFAULT		0x00000000
-#define EMAC_TMR1_DEFAULT		0x380f0000
-#endif				/* CONFIG_440GP */

 #endif
===== drivers/net/ibm_emac/ibm_emac_core.c 1.2 vs edited =====
--- 1.2/drivers/net/ibm_emac/ibm_emac_core.c	Fri Jun  4 08:50:36 2004
+++ edited/drivers/net/ibm_emac/ibm_emac_core.c	Thu Aug  5 14:35:59 2004
@@ -90,23 +90,24 @@

 #define RGMII_PRIV(ocpdev) ((struct ibm_ocp_rgmii*)ocp_get_drvdata(ocpdev))

-static unsigned int rgmii_enable[] =
-    { RGMII_RTBI, RGMII_RGMII, RGMII_TBI, RGMII_GMII };
+static unsigned int rgmii_enable[] = {
+	RGMII_RTBI,
+	RGMII_RGMII,
+	RGMII_TBI,
+	RGMII_GMII
+};

-static unsigned int rgmii_speed_mask[] = { 0,
-	0,
+static unsigned int rgmii_speed_mask[] = {
 	RGMII_MII2_SPDMASK,
 	RGMII_MII3_SPDMASK
 };

-static unsigned int rgmii_speed100[] = { 0,
-	0,
+static unsigned int rgmii_speed100[] = {
 	RGMII_MII2_100MB,
 	RGMII_MII3_100MB
 };

-static unsigned int rgmii_speed1000[] = { 0,
-	0,
+static unsigned int rgmii_speed1000[] = {
 	RGMII_MII2_1000MB,
 	RGMII_MII3_1000MB
 };
@@ -122,11 +123,21 @@
 	 ~(ZMII_MDI0 | ZMII_MDI1 | ZMII_MDI3)},
 	{ZMII_SMII3, ZMII_RMII3, ZMII_MII3, ~(ZMII_MDI0 | ZMII_MDI1 | ZMII_MDI2)}
 };
-static unsigned int mdi_enable[] =
-    { ZMII_MDI0, ZMII_MDI1, ZMII_MDI2, ZMII_MDI3 };
+
+static unsigned int mdi_enable[] = {
+	ZMII_MDI0,
+	ZMII_MDI1,
+	ZMII_MDI2,
+	ZMII_MDI3
+};

 static unsigned int zmii_speed = 0x0;
-static unsigned int zmii_speed100[] = { ZMII_MII0_100MB, ZMII_MII1_100MB };
+static unsigned int zmii_speed100[] = {
+	ZMII_MII0_100MB,
+	ZMII_MII1_100MB,
+	ZMII_MII2_100MB,
+	ZMII_MII3_100MB
+};

 /* Since multiple EMACs share MDIO lines in various ways, we need
  * to avoid re-using the same PHY ID in cases where the arch didn't
@@ -367,6 +378,7 @@

 int emac_phy_read(struct net_device *dev, int mii_id, int reg)
 {
+	int count;
 	uint32_t stacr;
 	struct ocp_enet_private *fep = dev->priv;
 	emac_t *emacp = fep->emacp;
@@ -385,9 +397,13 @@
 		emacp = fep->emacp;
 	}

-	udelay(MDIO_DELAY);
+	count = 0;
+	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
+					&& (count++ < MDIO_DELAY))
+		udelay(1);
+	MDIO_DEBUG((" (count was %d)\n", count));

-	if ((in_be32(&emacp->em0stacr) & EMAC_STACR_OC) == 0) {
+	if ((stacr & EMAC_STACR_OC) == 0) {
 		printk(KERN_WARNING "%s: PHY read timeout #1!\n", dev->name);
 		return -1;
 	}
@@ -398,8 +414,11 @@

 	out_be32(&emacp->em0stacr, stacr);

-	udelay(MDIO_DELAY);
-	stacr = in_be32(&emacp->em0stacr);
+	count = 0;
+	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
+					&& (count++ < MDIO_DELAY))
+		udelay(1);
+	MDIO_DEBUG((" (count was %d)\n", count));

 	if ((stacr & EMAC_STACR_OC) == 0) {
 		printk(KERN_WARNING "%s: PHY read timeout #2!\n", dev->name);
@@ -419,6 +438,7 @@

 void emac_phy_write(struct net_device *dev, int mii_id, int reg, int data)
 {
+	int count;
 	uint32_t stacr;
 	struct ocp_enet_private *fep = dev->priv;
 	emac_t *emacp = fep->emacp;
@@ -437,9 +457,13 @@
 		emacp = fep->emacp;
 	}

-	udelay(MDIO_DELAY);
+	count = 0;
+	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
+					&& (count++ < MDIO_DELAY))
+		udelay(1);
+	MDIO_DEBUG((" (count was %d)\n", count));

-	if ((in_be32(&emacp->em0stacr) & EMAC_STACR_OC) == 0) {
+	if ((stacr & EMAC_STACR_OC) == 0) {
 		printk(KERN_WARNING "%s: PHY write timeout #2!\n", dev->name);
 		return;
 	}
@@ -451,9 +475,12 @@

 	out_be32(&emacp->em0stacr, stacr);

-	udelay(MDIO_DELAY);
+	while (((stacr = in_be32(&emacp->em0stacr) & EMAC_STACR_OC) == 0)
+					&& (count++ < 5000))
+		udelay(1);
+	MDIO_DEBUG((" (count was %d)\n", count));

-	if ((in_be32(&emacp->em0stacr) & EMAC_STACR_OC) == 0)
+	if ((stacr & EMAC_STACR_OC) == 0)
 		printk(KERN_WARNING "%s: PHY write timeout #2!\n", dev->name);

 	/* Check for a write error */
@@ -1940,8 +1967,6 @@

 static int __init emac_init(void)
 {
-	int rc;
-
 	printk(KERN_INFO DRV_NAME ": " DRV_DESC ", version " DRV_VERSION "\n");
 	printk(KERN_INFO "Maintained by " DRV_AUTHOR "\n");

@@ -1950,13 +1975,8 @@
 		       skb_res);
 		skb_res = 2;
 	}
-	rc = ocp_register_driver(&emac_driver);
-	if (rc < 0) {
-		ocp_unregister_driver(&emac_driver);
-		return -ENODEV;
-	}

-	return 0;
+	return ocp_register_driver(&emac_driver);
 }

 static void __exit emac_exit(void)
===== drivers/net/ibm_emac/ibm_emac_core.h 1.1 vs edited =====
--- 1.1/drivers/net/ibm_emac/ibm_emac_core.h	Sat May 22 10:13:08 2004
+++ edited/drivers/net/ibm_emac/ibm_emac_core.h	Thu Aug  5 14:26:55 2004
@@ -67,7 +67,7 @@
 #define TX_TIMEOUT		(2*HZ)

 /* MDIO latency delay */
-#define MDIO_DELAY		50
+#define MDIO_DELAY		250

 /* Power managment shift registers */
 #define IBM_CPM_EMMII	0	/* Shift value for MII */

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
