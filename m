Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 4857A680C3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 06:42:11 +1000 (EST)
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20050808164457.C9951@cox.net>
References: <1123284390.27734.19.camel@rhino.az.mvista.com>
	<20050808164457.C9951@cox.net>
Content-Type: multipart/mixed; boundary="=-VUGe4nXcPU3N2VrcakT9"
Message-Id: <1123792927.27880.34.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 11 Aug 2005 13:42:07 -0700
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] add field to struct ocp_func_emac_data for
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



--=-VUGe4nXcPU3N2VrcakT9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-08-08 at 16:44, Matt Porter wrote:
(snip)
> 
> Could you update this field (and related usages) to be "phy_ftr_exc"?
> For "Excluded phy features".  Eugene and I discussed this on IRC and
> think it's a better name...for one it starts with the phy_ prefix like
> other related phy data. Except for that, it's ready for upstream.
> 
> Thanks,
> Matt

Here is the updated patch with the field renamed to "phy_ftr_exc"
instead of "feat_unsupp".

-Wade Farnsworth

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

--=-VUGe4nXcPU3N2VrcakT9
Content-Disposition: attachment; filename=ibm-emac-phy-feat-exc-ppc.patch
Content-Type: text/x-patch; name=ibm-emac-phy-feat-exc-ppc.patch
Content-Transfer-Encoding: 7bit

diff -upr linux-2.6/arch/ppc/platforms/4xx/bamboo.c linux-2.6-dev/arch/ppc/platforms/4xx/bamboo.c
--- linux-2.6/arch/ppc/platforms/4xx/bamboo.c	2005-08-11 13:29:30.000000000 -0700
+++ linux-2.6-dev/arch/ppc/platforms/4xx/bamboo.c	2005-08-11 13:15:59.000000000 -0700
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
+	u32 excluded = 0;
 
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
+		excluded |= SUPPORTED_Autoneg;
+		if (BAMBOO_FORCE_100Mbps(val)) {
+			excluded |= SUPPORTED_10baseT_Full;
+			excluded |= SUPPORTED_10baseT_Half;
+			if (BAMBOO_FULL_DUPLEX_EN(val))
+				excluded |= SUPPORTED_100baseT_Half;
+			else
+				excluded |= SUPPORTED_100baseT_Full;
+		} else {
+			excluded |= SUPPORTED_100baseT_Full;
+			excluded |= SUPPORTED_100baseT_Half;
+			if (BAMBOO_FULL_DUPLEX_EN(val))
+				excluded |= SUPPORTED_10baseT_Half;
+			else
+				excluded |= SUPPORTED_10baseT_Full;
+		}
+	}
+	
+	/* Set mac_addr, phy mode and unsupported phy features for each EMAC */
 
 	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
 	emacdata = def->additions;
 	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
 	emacdata->phy_mode = mode;
+	emacdata->phy_feat_exc = excluded;
 
 	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
 	emacdata = def->additions;
 	memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
 	emacdata->phy_mode = mode;
+	emacdata->phy_feat_exc = excluded;
 }
 
 static int
diff -upr linux-2.6/include/asm-ppc/ibm_ocp.h linux-2.6-dev/include/asm-ppc/ibm_ocp.h
--- linux-2.6/include/asm-ppc/ibm_ocp.h	2005-08-11 13:30:02.000000000 -0700
+++ linux-2.6-dev/include/asm-ppc/ibm_ocp.h	2005-08-11 13:12:34.000000000 -0700
@@ -67,6 +67,7 @@ struct ocp_func_emac_data {
 	int	phy_mode;	/* PHY type or configurable mode */
 	u8	mac_addr[6];	/* EMAC mac address */
 	u32	phy_map;	/* EMAC phy map */
+	u32	phy_feat_exc;	/* Excluded PHY features */
 };
 
 /* Sysfs support */

--=-VUGe4nXcPU3N2VrcakT9--
