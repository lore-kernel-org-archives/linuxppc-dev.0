Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id BB28967F2E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Aug 2005 09:26:34 +1000 (EST)
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	Matt Porter <mporter@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="=-FGJpnqXD03PZ8Get/wI7"
Message-Id: <1123284390.27734.19.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 05 Aug 2005 16:26:30 -0700
Subject: [PATCH] add field to struct ocp_func_emac_data for
	platform-specific unsupported PHY features
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--=-FGJpnqXD03PZ8Get/wI7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello all,

This patch adds a field to struct ocp_func_emac_data that allows
platform-specific unsupported PHY features to be passed in to the
ibm_emac ethernet driver.

This patch also adds some logic for the Bamboo eval board to populate
this field based on the dip switches on the board.  This is a workaround
for the improperly biased RJ-45 sockets on the Rev. 0 Bamboo.  See the
comments in bamboo.c for more information on this bug.

-Wade Farnsworth

Signed-off by: Wade Farnsworth <wfarnsworth@mvista.com>

--=-FGJpnqXD03PZ8Get/wI7
Content-Disposition: attachment; filename=ibm-emac-phy-feat-unsupp-ppc.patch
Content-Type: text/plain; name=ibm-emac-phy-feat-unsupp-ppc.patch;
	charset=us-ascii
Content-Transfer-Encoding: 7bit

--- linux-2.6/arch/ppc/platforms/4xx/bamboo.c	2005-08-03 13:33:41.000000000 -0700
+++ linux-2.6-dev/arch/ppc/platforms/4xx/bamboo.c	2005-08-02 10:51:00.000000000 -0700
@@ -123,33 +123,69 @@ bamboo_map_irq(struct pci_dev *dev, unsi
 
 static void __init bamboo_set_emacdata(void)
 {
-	unsigned char * selection1_base;
+	u8 * base_addr;
 	struct ocp_def *def;
 	struct ocp_func_emac_data *emacdata;
-	u8 selection1_val;
+	u8 val;
 	int mode;
+	u32 unsupported = 0;
 
-	selection1_base = ioremap64(BAMBOO_FPGA_SELECTION1_REG_ADDR, 16);
-	selection1_val = readb(selection1_base);
-	iounmap((void *) selection1_base);
-	if (BAMBOO_SEL_MII(selection1_val))
+	base_addr = ioremap64(BAMBOO_FPGA_SELECTION1_REG_ADDR, 16);
+	val = readb(base_addr);
+	iounmap((void *) base_addr);
+	if (BAMBOO_SEL_MII(val))
 		mode = PHY_MODE_MII;
-	else if (BAMBOO_SEL_RMII(selection1_val))
+	else if (BAMBOO_SEL_RMII(val))
 		mode = PHY_MODE_RMII;
 	else
 		mode = PHY_MODE_SMII;
 
-	/* Set mac_addr and phy mode for each EMAC */
+	/*
+	 * SW2 on the Bamboo is used for ethernet configuration and is accessed
+	 * via the CONFIG2 register in the FPGA.  If the ANEG pin is set,
+	 * overwrite the supported features with the settings in SW2.
+	 *
+	 * This is used as a workaround for the improperly biased RJ-45 sockets
+	 * on the Rev. 0 Bamboo.  By default only 10baseT is functional.
+	 * Removing inductors L17 and L18 from the board allows 100baseT, but
+	 * disables 10baseT.  The Rev. 1 has no such limitations.
+	 */
+
+	base_addr = ioremap64(BAMBOO_FPGA_CONFIG2_REG_ADDR, 8);
+	val = readb(base_addr);
+	iounmap((void *) base_addr);
+	if (!BAMBOO_AUTONEGOTIATE(val)) {
+		unsupported |= SUPPORTED_Autoneg;
+		if (BAMBOO_FORCE_100Mbps(val)) {
+			unsupported |= SUPPORTED_10baseT_Full;
+			unsupported |= SUPPORTED_10baseT_Half;
+			if (BAMBOO_FULL_DUPLEX_EN(val))
+				unsupported |= SUPPORTED_100baseT_Half;
+			else
+				unsupported |= SUPPORTED_100baseT_Full;
+		} else {
+			unsupported |= SUPPORTED_100baseT_Full;
+			unsupported |= SUPPORTED_100baseT_Half;
+			if (BAMBOO_FULL_DUPLEX_EN(val))
+				unsupported |= SUPPORTED_10baseT_Half;
+			else
+				unsupported |= SUPPORTED_10baseT_Full;
+		}
+	}
+	
+	/* Set mac_addr, phy mode and unsupported phy features for each EMAC */
 
 	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
 	emacdata = def->additions;
 	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
 	emacdata->phy_mode = mode;
+	emacdata->feat_unsupp = unsupported;
 
 	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
 	emacdata = def->additions;
 	memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
 	emacdata->phy_mode = mode;
+	emacdata->feat_unsupp = unsupported;
 }
 
 static int
--- linux-2.6/include/asm-ppc/ibm_ocp.h	2005-08-03 13:34:08.000000000 -0700
+++ linux-2.6-dev/include/asm-ppc/ibm_ocp.h	2005-08-02 10:49:42.000000000 -0700
@@ -67,6 +67,7 @@ struct ocp_func_emac_data {
 	int	phy_mode;	/* PHY type or configurable mode */
 	u8	mac_addr[6];	/* EMAC mac address */
 	u32	phy_map;	/* EMAC phy map */
+	u32	feat_unsupp;	/* Unsupported phy features */
 };
 
 /* Sysfs support */

--=-FGJpnqXD03PZ8Get/wI7--
