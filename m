Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 29C1C68368
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 13:13:42 +1000 (EST)
In-Reply-To: <2005922203.UPGbNSgrHKasoXYq@cisco.com>
Date: Thu, 22 Sep 2005 20:03:35 -0700
Message-Id: <2005922203.qtfGFmWm3E8jkhq1@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: mporter@kernel.crashing.org
From: Roland Dreier <rolandd@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 3/4] [PPC32] ibm_emac: Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene, I'm not sure what the status of your ibm_emac rewrite is.  Is
there a tree somewhere that you would like me to merge this change
with and then send you a patch, or do you want to take care of merging?


For some reason, the hardware designers made the polarity of one bit
in the 440SPe's PHY interface register the opposite of all other PPC
440 chips.  To handle this, abstract our access to this bit into
emac_phy_start() and emac_phy_done() functions, and do the right thing
based on the configured CPU type.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/net/ibm_emac/ibm_emac.h      |    2 -
 drivers/net/ibm_emac/ibm_emac_core.c |   72 ++++++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 19 deletions(-)

187bfbe2d410e5a229fb828e2c3dd0a8045857e8
diff --git a/drivers/net/ibm_emac/ibm_emac.h b/drivers/net/ibm_emac/ibm_emac.h
--- a/drivers/net/ibm_emac/ibm_emac.h
+++ b/drivers/net/ibm_emac/ibm_emac.h
@@ -237,7 +237,7 @@ typedef struct emac_regs {
 #define EMAC_RWMR_DEFAULT		0x1000a200
 #define EMAC_TMR0_DEFAULT		EMAC_TMR0_TFAE_2_32
 #define EMAC_TMR1_DEFAULT		0xa00f0000
-#elif defined(CONFIG_440SP)
+#elif defined(CONFIG_440SP) || defined(CONFIG_440SPE)
 #define EMAC_RWMR_DEFAULT		0x08002000
 #define EMAC_TMR0_DEFAULT		EMAC_TMR0_TFAE_128_2048
 #define EMAC_TMR1_DEFAULT		0xf8200000
diff --git a/drivers/net/ibm_emac/ibm_emac_core.c b/drivers/net/ibm_emac/ibm_emac_core.c
--- a/drivers/net/ibm_emac/ibm_emac_core.c
+++ b/drivers/net/ibm_emac/ibm_emac_core.c
@@ -160,6 +160,34 @@ static struct net_device_stats *emac_sta
 	return &fep->stats;
 };
 
+/*
+ * For the 440SPe, AMCC inexplicably changed the polarity of
+ * the "operation complete" bit in the MII control register.
+ */
+#ifdef CONFIG_440SPE
+static inline int emac_phy_done(uint32_t stacr)
+{
+	return !(stacr & EMAC_STACR_OC);
+};
+
+static inline uint32_t emac_phy_start(uint32_t stacr)
+{
+	return stacr | EMAC_STACR_OC;
+};
+
+#else /* CONFIG_440SPE */
+
+static inline int emac_phy_done(uint32_t stacr)
+{
+	return stacr & EMAC_STACR_OC;
+};
+
+static inline uint32_t emac_phy_start(uint32_t stacr)
+{
+	return stacr;
+};
+#endif /* CONFIG_440SPE */
+
 static int
 emac_init_rgmii(struct ocp_device *rgmii_dev, int input, int phy_mode)
 {
@@ -397,13 +425,15 @@ int emac_phy_read(struct net_device *dev
 		emacp = fep->emacp;
 	}
 
-	count = 0;
-	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
-					&& (count++ < MDIO_DELAY))
+	for (count = 0; count < MDIO_DELAY; ++count) {
+		stacr = in_be32(&emacp->em0stacr);
+		if (emac_phy_done(stacr))
+			break;
 		udelay(1);
+	}
 	MDIO_DEBUG((" (count was %d)\n", count));
 
-	if ((stacr & EMAC_STACR_OC) == 0) {
+	if (!emac_phy_done(stacr)) {
 		printk(KERN_WARNING "%s: PHY read timeout #1!\n", dev->name);
 		return -1;
 	}
@@ -412,15 +442,17 @@ int emac_phy_read(struct net_device *dev
 	stacr = ((EMAC_STACR_READ | (reg & 0x1f)) & ~EMAC_STACR_CLK_100MHZ);
 	stacr |= ((mii_id & 0x1F) << 5);
 
-	out_be32(&emacp->em0stacr, stacr);
+	out_be32(&emacp->em0stacr, emac_phy_start(stacr));
 
-	count = 0;
-	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
-					&& (count++ < MDIO_DELAY))
+	for (count = 0; count < MDIO_DELAY; ++count) {
+		stacr = in_be32(&emacp->em0stacr);
+		if (emac_phy_done(stacr))
+			break;
 		udelay(1);
+	}
 	MDIO_DEBUG((" (count was %d)\n", count));
 
-	if ((stacr & EMAC_STACR_OC) == 0) {
+	if (!emac_phy_done(stacr)) {
 		printk(KERN_WARNING "%s: PHY read timeout #2!\n", dev->name);
 		return -1;
 	}
@@ -457,13 +489,15 @@ void emac_phy_write(struct net_device *d
 		emacp = fep->emacp;
 	}
 
-	count = 0;
-	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
-					&& (count++ < MDIO_DELAY))
+	for (count = 0; count < MDIO_DELAY; ++count) {
+		stacr = in_be32(&emacp->em0stacr);
+		if (emac_phy_done(stacr))
+			break;
 		udelay(1);
+	}
 	MDIO_DEBUG((" (count was %d)\n", count));
 
-	if ((stacr & EMAC_STACR_OC) == 0) {
+	if (!emac_phy_done(stacr)) {
 		printk(KERN_WARNING "%s: PHY write timeout #2!\n", dev->name);
 		return;
 	}
@@ -473,15 +507,17 @@ void emac_phy_write(struct net_device *d
 	stacr = ((EMAC_STACR_WRITE | (reg & 0x1f)) & ~EMAC_STACR_CLK_100MHZ);
 	stacr |= ((mii_id & 0x1f) << 5) | ((data & 0xffff) << 16);
 
-	out_be32(&emacp->em0stacr, stacr);
+	out_be32(&emacp->em0stacr, emac_phy_start(stacr));
 
-	count = 0;
-	while ((((stacr = in_be32(&emacp->em0stacr)) & EMAC_STACR_OC) == 0)
-					&& (count++ < MDIO_DELAY))
+	for (count = 0; count < MDIO_DELAY; ++count) {
+		stacr = in_be32(&emacp->em0stacr);
+		if (emac_phy_done(stacr))
+			break;
 		udelay(1);
+	}
 	MDIO_DEBUG((" (count was %d)\n", count));
 
-	if ((stacr & EMAC_STACR_OC) == 0)
+	if (!emac_phy_done(stacr))
 		printk(KERN_WARNING "%s: PHY write timeout #2!\n", dev->name);
 
 	/* Check for a write error */
