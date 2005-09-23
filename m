Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 61ECF68378
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 15:25:33 +1000 (EST)
To: Eugene Surovegin <ebs@ebshome.net>
References: <2005922203.UPGbNSgrHKasoXYq@cisco.com>
	<2005922203.qtfGFmWm3E8jkhq1@cisco.com>
	<20050923032236.GA10089@gate.ebshome.net>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 22 Sep 2005 22:25:26 -0700
In-Reply-To: <20050923032236.GA10089@gate.ebshome.net> (Eugene Surovegin's
	message of "Thu, 22 Sep 2005 20:22:36 -0700")
Message-ID: <52irwscq49.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 3/4] [PPC32] ibm_emac: Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Eugene> Well, new driver was sent to jgarzik and netdev list three
    Eugene> weeks ago. So far I haven't heard anything technical from
    Eugene> Jeff. I don't know when and even if it will be merged.

Assuming everyone in the PPC4xx world thinks your driver should
replace the old driver, it might be worth sending directly to Andrew.
There's no reason Jeff has to become a bottleneck for this.

    Eugene> I'll try to look at merging your patch into my tree, but
    Eugene> probably not right now - I'm kinda busy with other stuff
    Eugene> and netdev "progress" doesn't quite motivate me working on
    Eugene> this project, frankly. Though, if you can send me a patch
    Eugene> against my tree, I'll appreciate it :).

No problem at all.  Here's a patch against your git tree -- only
tested on my Yucca board, so you might want to doublecheck that I
didn't break all the systems will the opposite polarity.

Thanks,
  Roland



For some reason, the hardware designers made the polarity of one bit
in the 440SPe's PHY interface register the opposite of all other PPC
440 chips.  To handle this, abstract our access to this bit and do the
right thing based on the configured CPU type.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/drivers/net/ibm_emac/ibm_emac.h b/drivers/net/ibm_emac/ibm_emac.h
--- a/drivers/net/ibm_emac/ibm_emac.h
+++ b/drivers/net/ibm_emac/ibm_emac.h
@@ -26,7 +26,7 @@
 /* This is a simple check to prevent use of this driver on non-tested SoCs */
 #if !defined(CONFIG_405GP) && !defined(CONFIG_405GPR) && !defined(CONFIG_405EP) && \
     !defined(CONFIG_440GP) && !defined(CONFIG_440GX) && !defined(CONFIG_440SP) && \
-    !defined(CONFIG_440EP) && !defined(CONFIG_NP405H)
+    !defined(CONFIG_440EP) && !defined(CONFIG_NP405H) && !defined(CONFIG_440SPE)
 #error	"Unknown SoC. Please, check chip user manual and make sure EMAC defines are OK"
 #endif
 
diff --git a/drivers/net/ibm_emac/ibm_emac_core.c b/drivers/net/ibm_emac/ibm_emac_core.c
--- a/drivers/net/ibm_emac/ibm_emac_core.c
+++ b/drivers/net/ibm_emac/ibm_emac_core.c
@@ -139,6 +139,29 @@ static inline void EMAC_RX_CLK_DEFAULT(i
 #define EMAC_CLK_EXTERNAL		((void)0)
 #endif
 
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
+#define EMAC_STACR_START EMAC_STACR_OC
+
+#else /* CONFIG_440SPE */
+
+static inline int emac_phy_done(uint32_t stacr)
+{
+	return stacr & EMAC_STACR_OC;
+};
+
+#define EMAC_STACR_START 0
+#endif /* CONFIG_440SPE */
+
+
 /* I don't want to litter system log with timeout errors 
  * when we have brain-damaged PHY.
  */
@@ -546,7 +569,7 @@ static int __emac_mdio_read(struct ocp_e
 
 	/* Wait for management interface to become idle */
 	n = 10;
-	while (!(in_be32(&p->stacr) & EMAC_STACR_OC)) {
+	while (!emac_phy_done(in_be32(&p->stacr))) {
 		udelay(1);
 		if (!--n)
 			goto to;
@@ -556,11 +579,12 @@ static int __emac_mdio_read(struct ocp_e
 	out_be32(&p->stacr,
 		 EMAC_STACR_BASE(emac_opb_mhz()) | EMAC_STACR_STAC_READ |
 		 (reg & EMAC_STACR_PRA_MASK)
-		 | ((id & EMAC_STACR_PCDA_MASK) << EMAC_STACR_PCDA_SHIFT));
+		 | ((id & EMAC_STACR_PCDA_MASK) << EMAC_STACR_PCDA_SHIFT)
+		 | EMAC_STACR_START);
 
 	/* Wait for read to complete */
 	n = 100;
-	while (!((r = in_be32(&p->stacr)) & EMAC_STACR_OC)) {
+	while (!emac_phy_done(r = in_be32(&p->stacr))) {
 		udelay(1);
 		if (!--n)
 			goto to;
@@ -594,7 +618,7 @@ static void __emac_mdio_write(struct ocp
 
 	/* Wait for management interface to be idle */
 	n = 10;
-	while (!(in_be32(&p->stacr) & EMAC_STACR_OC)) {
+	while (!emac_phy_done(in_be32(&p->stacr))) {
 		udelay(1);
 		if (!--n)
 			goto to;
@@ -605,11 +629,12 @@ static void __emac_mdio_write(struct ocp
 		 EMAC_STACR_BASE(emac_opb_mhz()) | EMAC_STACR_STAC_WRITE |
 		 (reg & EMAC_STACR_PRA_MASK) |
 		 ((id & EMAC_STACR_PCDA_MASK) << EMAC_STACR_PCDA_SHIFT) |
-		 (val << EMAC_STACR_PHYD_SHIFT));
+		 (val << EMAC_STACR_PHYD_SHIFT) |
+		 EMAC_STACR_START);
 
 	/* Wait for write to complete */
 	n = 100;
-	while (!(in_be32(&p->stacr) & EMAC_STACR_OC)) {
+	while (!emac_phy_done(in_be32(&p->stacr))) {
 		udelay(1);
 		if (!--n)
 			goto to;
diff --git a/drivers/net/ibm_emac/ibm_emac_mal.h b/drivers/net/ibm_emac/ibm_emac_mal.h
--- a/drivers/net/ibm_emac/ibm_emac_mal.h
+++ b/drivers/net/ibm_emac/ibm_emac_mal.h
@@ -34,7 +34,8 @@
 #if defined(CONFIG_405GP) || defined(CONFIG_405GPR) || defined(CONFIG_405EP) || \
     defined(CONFIG_440EP) || defined(CONFIG_NP405H)
 #define MAL_VERSION		1
-#elif defined(CONFIG_440GP) || defined(CONFIG_440GX) || defined(CONFIG_440SP)
+#elif defined(CONFIG_440GP) || defined(CONFIG_440GX) || defined(CONFIG_440SP) || \
+      defined(CONFIG_440SPE)
 #define MAL_VERSION		2
 #else
 #error "Unknown SoC, please check chip manual and choose MAL 'version'"
