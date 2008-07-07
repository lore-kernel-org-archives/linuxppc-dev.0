Return-Path: <gerickson@nuovations.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id C5262DDF11
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:03:14 +1000 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6] ibm_newemac: Parameterize EMAC Multicast Match Handling
Date: Mon,  7 Jul 2008 15:03:11 -0700
Message-Id: <1215468191-26515-1-git-send-email-gerickson@nuovations.com>
In-Reply-To: <1215387012-6464-1-git-send-email-gerickson@nuovations.com>
References: <1215387012-6464-1-git-send-email-gerickson@nuovations.com>
Cc: sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Various instances of the EMAC core have varying: 1) number of address 
match slots, 2) width of the registers for handling address match slots, 
3) number of registers for handling address match slots and 4) base 
offset for those registers.

As the driver stands today, it assumes that all EMACs have 4 IAHT and 
GAHT 32-bit registers, starting at offset 0x30 from the register base, 
with only 16-bits of each used for a total of 64 match slots.

The 405EX(r) and 460EX now use the EMAC4SYNC core rather than the EMAC4 
core. This core has 8 IAHT and GAHT registers, starting at offset 0x80 
from the register base, with ALL 32-bits of each used for a total of 
256 match slots.

This adds a new compatible device tree entry "emac4sync" and a new,
related feature flag "EMAC_FTR_EMAC4SYNC" along with a series of macros
and inlines which supply the appropriate parameterized value based on
the presence or absence of the EMAC4SYNC feature.

The code has further been reworked where appropriate to use those macros
and inlines.

In addition, the register size passed to ioremap is now taken from the 
device tree:

	c4 for EMAC4SYNC cores
	74 for EMAC4 cores
	70 for EMAC cores

rather than sizeof (emac_regs).

Finally, the device trees have been updated with the appropriate compatible
entries and resource sizes.

This has been tested on an AMCC Haleakala board such that: 1) inbound 
ICMP requests to 'haleakala.local' via MDNS from both Mac OS X 10.4.11 
and Ubuntu 8.04 systems as well as 2) outbound ICMP requests from 
'haleakala.local' to those same systems in the '.local' domain via MDNS 
now work.

Signed-off-by: Grant Erickson <gerickson@nuovations.com>
---
 arch/powerpc/boot/dts/canyonlands.dts |    8 +-
 arch/powerpc/boot/dts/glacier.dts     |    8 +-
 arch/powerpc/boot/dts/haleakala.dts   |    4 +-
 arch/powerpc/boot/dts/katmai.dts      |    2 +-
 arch/powerpc/boot/dts/kilauea.dts     |    8 +-
 arch/powerpc/boot/dts/makalu.dts      |    8 +-
 arch/powerpc/boot/dts/rainier.dts     |    4 +-
 arch/powerpc/boot/dts/sequoia.dts     |    4 +-
 arch/powerpc/boot/dts/taishan.dts     |    8 +-
 drivers/net/ibm_newemac/core.c        |   61 ++++++++++++++------
 drivers/net/ibm_newemac/core.h        |   83 ++++++++++++++++++++++++++-
 drivers/net/ibm_newemac/debug.c       |   52 +++++++++++++----
 drivers/net/ibm_newemac/emac.h        |  101 ++++++++++++++++++++++----------
 13 files changed, 259 insertions(+), 92 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 3963412..8b82d47 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -264,7 +264,7 @@
 
 			EMAC0: ethernet@ef600e00 {
 				device_type = "network";
-				compatible = "ibm,emac-460ex", "ibm,emac4";
+				compatible = "ibm,emac-460ex", "ibm,emac4sync";
 				interrupt-parent = <&EMAC0>;
 				interrupts = <0 1>;
 				#interrupt-cells = <1>;
@@ -272,7 +272,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC2 10 4
 						 /*Wake*/   1 &UIC2 14 4>;
-				reg = <ef600e00 70>;
+				reg = <ef600e00 c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -293,7 +293,7 @@
 
 			EMAC1: ethernet@ef600f00 {
 				device_type = "network";
-				compatible = "ibm,emac-460ex", "ibm,emac4";
+				compatible = "ibm,emac-460ex", "ibm,emac4sync";
 				interrupt-parent = <&EMAC1>;
 				interrupts = <0 1>;
 				#interrupt-cells = <1>;
@@ -301,7 +301,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC2 11 4
 						 /*Wake*/   1 &UIC2 15 4>;
-				reg = <ef600f00 70>;
+				reg = <ef600f00 c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
diff --git a/arch/powerpc/boot/dts/glacier.dts b/arch/powerpc/boot/dts/glacier.dts
index 0f2fc07..8ffde9b 100644
--- a/arch/powerpc/boot/dts/glacier.dts
+++ b/arch/powerpc/boot/dts/glacier.dts
@@ -281,7 +281,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC2 10 4
 						 /*Wake*/   1 &UIC2 14 4>;
-				reg = <ef600e00 70>;
+				reg = <ef600e00 74>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -310,7 +310,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC2 11 4
 						 /*Wake*/   1 &UIC2 15 4>;
-				reg = <ef600f00 70>;
+				reg = <ef600f00 74>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
@@ -340,7 +340,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC2 12 4
 						 /*Wake*/   1 &UIC2 16 4>;
-				reg = <ef601100 70>;
+				reg = <ef601100 74>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <2>;
@@ -368,7 +368,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC2 13 4
 						 /*Wake*/   1 &UIC2 17 4>;
-				reg = <ef601200 70>;
+				reg = <ef601200 74>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <3>;
diff --git a/arch/powerpc/boot/dts/haleakala.dts b/arch/powerpc/boot/dts/haleakala.dts
index b5d95ac..d131c00 100644
--- a/arch/powerpc/boot/dts/haleakala.dts
+++ b/arch/powerpc/boot/dts/haleakala.dts
@@ -204,7 +204,7 @@
 			EMAC0: ethernet@ef600900 {
 				linux,network-index = <0>;
 				device_type = "network";
-				compatible = "ibm,emac-405exr", "ibm,emac4";
+				compatible = "ibm,emac-405exr", "ibm,emac4sync";
 				interrupt-parent = <&EMAC0>;
 				interrupts = <0 1>;
 				#interrupt-cells = <1>;
@@ -212,7 +212,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 18 4
 						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600900 70>;
+				reg = <ef600900 c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index cc2873a..c91bb66 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -206,7 +206,7 @@
 				compatible = "ibm,emac-440spe", "ibm,emac4";
 				interrupt-parent = <&UIC1>;
 				interrupts = <1c 4 1d 4>;
-				reg = <10000800 70>;
+				reg = <10000800 74>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index 48c9a6e..bfae1b2 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -205,7 +205,7 @@
 			EMAC0: ethernet@ef600900 {
 				linux,network-index = <0>;
 				device_type = "network";
-				compatible = "ibm,emac-405ex", "ibm,emac4";
+				compatible = "ibm,emac-405ex", "ibm,emac4sync";
 				interrupt-parent = <&EMAC0>;
 				interrupts = <0 1>;
 				#interrupt-cells = <1>;
@@ -213,7 +213,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 18 4
 						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600900 70>;
+				reg = <ef600900 c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -233,7 +233,7 @@
 			EMAC1: ethernet@ef600a00 {
 				linux,network-index = <1>;
 				device_type = "network";
-				compatible = "ibm,emac-405ex", "ibm,emac4";
+				compatible = "ibm,emac-405ex", "ibm,emac4sync";
 				interrupt-parent = <&EMAC1>;
 				interrupts = <0 1>;
 				#interrupt-cells = <1>;
@@ -241,7 +241,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 19 4
 						/*Wake*/  1 &UIC1 1f 4>;
-				reg = <ef600a00 70>;
+				reg = <ef600a00 c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
diff --git a/arch/powerpc/boot/dts/makalu.dts b/arch/powerpc/boot/dts/makalu.dts
index 84cc5e7..895381f 100644
--- a/arch/powerpc/boot/dts/makalu.dts
+++ b/arch/powerpc/boot/dts/makalu.dts
@@ -205,7 +205,7 @@
 			EMAC0: ethernet@ef600900 {
 				linux,network-index = <0>;
 				device_type = "network";
-				compatible = "ibm,emac-405ex", "ibm,emac4";
+				compatible = "ibm,emac-405ex", "ibm,emac4sync";
 				interrupt-parent = <&EMAC0>;
 				interrupts = <0 1>;
 				#interrupt-cells = <1>;
@@ -213,7 +213,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 18 4
 						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600900 70>;
+				reg = <ef600900 c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -233,7 +233,7 @@
 			EMAC1: ethernet@ef600a00 {
 				linux,network-index = <1>;
 				device_type = "network";
-				compatible = "ibm,emac-405ex", "ibm,emac4";
+				compatible = "ibm,emac-405ex", "ibm,emac4sync";
 				interrupt-parent = <&EMAC1>;
 				interrupts = <0 1>;
 				#interrupt-cells = <1>;
@@ -241,7 +241,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 19 4
 						/*Wake*/  1 &UIC1 1f 4>;
-				reg = <ef600a00 70>;
+				reg = <ef600a00 c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
diff --git a/arch/powerpc/boot/dts/rainier.dts b/arch/powerpc/boot/dts/rainier.dts
index 6a8fa70..026c22c 100644
--- a/arch/powerpc/boot/dts/rainier.dts
+++ b/arch/powerpc/boot/dts/rainier.dts
@@ -263,7 +263,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 18 4
 						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600e00 70>;
+				reg = <ef600e00 74>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -292,7 +292,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 19 4
 						/*Wake*/  1 &UIC1 1f 4>;
-				reg = <ef600f00 70>;
+				reg = <ef600f00 74>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index 72d6756..8d66c99 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -278,7 +278,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 18 4
 						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600e00 70>;
+				reg = <ef600e00 74>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -307,7 +307,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 19 4
 						/*Wake*/  1 &UIC1 1f 4>;
-				reg = <ef600f00 70>;
+				reg = <ef600f00 74>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
diff --git a/arch/powerpc/boot/dts/taishan.dts b/arch/powerpc/boot/dts/taishan.dts
index e808e1c..f736d87 100644
--- a/arch/powerpc/boot/dts/taishan.dts
+++ b/arch/powerpc/boot/dts/taishan.dts
@@ -258,7 +258,7 @@
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC1>;
 				interrupts = <1c 4 1d 4>;
-				reg = <40000800 70>;
+				reg = <40000800 74>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -278,7 +278,7 @@
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC1>;
 				interrupts = <1e 4 1f 4>;
-				reg = <40000900 70>;
+				reg = <40000900 74>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
@@ -298,7 +298,7 @@
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC2>;
 				interrupts = <0 4 1 4>;
-				reg = <40000c00 70>;
+				reg = <40000c00 74>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <2>;
@@ -322,7 +322,7 @@
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC2>;
 				interrupts = <2 4 3 4>;
-				reg = <40000e00 70>;
+				reg = <40000e00 74>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <3>;
diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 5d2108c..ed24a1d 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -363,25 +363,31 @@ static int emac_reset(struct emac_instance *dev)
 
 static void emac_hash_mc(struct emac_instance *dev)
 {
-	struct emac_regs __iomem *p = dev->emacp;
-	u16 gaht[4] = { 0 };
+	const int regs = EMAC_XAHT_REGS(dev);
+	u32 *gaht_base = emac_gaht_base(dev);
+	u32 gaht_temp[regs];
 	struct dev_mc_list *dmi;
+	int i;
 
 	DBG(dev, "hash_mc %d" NL, dev->ndev->mc_count);
 
+	memset(gaht_temp, 0, sizeof (gaht_temp));
+
 	for (dmi = dev->ndev->mc_list; dmi; dmi = dmi->next) {
-		int bit;
+		int slot, reg, mask;
 		DBG2(dev, "mc %02x:%02x:%02x:%02x:%02x:%02x" NL,
 		     dmi->dmi_addr[0], dmi->dmi_addr[1], dmi->dmi_addr[2],
 		     dmi->dmi_addr[3], dmi->dmi_addr[4], dmi->dmi_addr[5]);
 
-		bit = 63 - (ether_crc(ETH_ALEN, dmi->dmi_addr) >> 26);
-		gaht[bit >> 4] |= 0x8000 >> (bit & 0x0f);
+		slot = EMAC_XAHT_CRC_TO_SLOT(dev, ether_crc(ETH_ALEN, dmi->dmi_addr));
+		reg = EMAC_XAHT_SLOT_TO_REG(dev, slot);
+		mask = EMAC_XAHT_SLOT_TO_MASK(dev, slot);
+
+		gaht_temp[reg] |= mask;
 	}
-	out_be32(&p->gaht1, gaht[0]);
-	out_be32(&p->gaht2, gaht[1]);
-	out_be32(&p->gaht3, gaht[2]);
-	out_be32(&p->gaht4, gaht[3]);
+
+	for (i = 0; i < regs; i++)
+		out_be32(gaht_base + i, gaht_temp[i]);
 }
 
 static inline u32 emac_iff2rmr(struct net_device *ndev)
@@ -398,7 +404,8 @@ static inline u32 emac_iff2rmr(struct net_device *ndev)
 
 	if (ndev->flags & IFF_PROMISC)
 		r |= EMAC_RMR_PME;
-	else if (ndev->flags & IFF_ALLMULTI || ndev->mc_count > 32)
+	else if (ndev->flags & IFF_ALLMULTI ||
+			 (ndev->mc_count > EMAC_XAHT_SLOTS(dev)))
 		r |= EMAC_RMR_PMME;
 	else if (ndev->mc_count > 0)
 		r |= EMAC_RMR_MAE;
@@ -542,7 +549,7 @@ static int emac_configure(struct emac_instance *dev)
 			/* Put some arbitrary OUI, Manuf & Rev IDs so we can
 			 * identify this GPCS PHY later.
 			 */
-			out_be32(&p->ipcr, 0xdeadbeef);
+			out_be32(&p->u1.emac4.ipcr, 0xdeadbeef);
 		} else
 			mr1 |= EMAC_MR1_MF_1000;
 
@@ -2015,10 +2022,10 @@ static int emac_get_regs_len(struct emac_instance *dev)
 {
 	if (emac_has_feature(dev, EMAC_FTR_EMAC4))
 		return sizeof(struct emac_ethtool_regs_subhdr) +
-			EMAC4_ETHTOOL_REGS_SIZE;
+			EMAC4_ETHTOOL_REGS_SIZE(dev);
 	else
 		return sizeof(struct emac_ethtool_regs_subhdr) +
-			EMAC_ETHTOOL_REGS_SIZE;
+			EMAC_ETHTOOL_REGS_SIZE(dev);
 }
 
 static int emac_ethtool_get_regs_len(struct net_device *ndev)
@@ -2045,12 +2052,12 @@ static void *emac_dump_regs(struct emac_instance *dev, void *buf)
 	hdr->index = dev->cell_index;
 	if (emac_has_feature(dev, EMAC_FTR_EMAC4)) {
 		hdr->version = EMAC4_ETHTOOL_REGS_VER;
-		memcpy_fromio(hdr + 1, dev->emacp, EMAC4_ETHTOOL_REGS_SIZE);
-		return ((void *)(hdr + 1) + EMAC4_ETHTOOL_REGS_SIZE);
+		memcpy_fromio(hdr + 1, dev->emacp, EMAC4_ETHTOOL_REGS_SIZE(dev));
+		return ((void *)(hdr + 1) + EMAC4_ETHTOOL_REGS_SIZE(dev));
 	} else {
 		hdr->version = EMAC_ETHTOOL_REGS_VER;
-		memcpy_fromio(hdr + 1, dev->emacp, EMAC_ETHTOOL_REGS_SIZE);
-		return ((void *)(hdr + 1) + EMAC_ETHTOOL_REGS_SIZE);
+		memcpy_fromio(hdr + 1, dev->emacp, EMAC_ETHTOOL_REGS_SIZE(dev));
+		return ((void *)(hdr + 1) + EMAC_ETHTOOL_REGS_SIZE(dev));
 	}
 }
 
@@ -2540,7 +2547,9 @@ static int __devinit emac_init_config(struct emac_instance *dev)
 	}
 
 	/* Check EMAC version */
-	if (of_device_is_compatible(np, "ibm,emac4")) {
+	if (of_device_is_compatible(np, "ibm,emac4sync")) {
+		dev->features |= (EMAC_FTR_EMAC4 | EMAC_FTR_EMAC4SYNC);
+	} else if (of_device_is_compatible(np, "ibm,emac4")) {
 		dev->features |= EMAC_FTR_EMAC4;
 		if (of_device_is_compatible(np, "ibm,emac-440gx"))
 			dev->features |= EMAC_FTR_440GX_PHY_CLK_FIX;
@@ -2601,6 +2610,15 @@ static int __devinit emac_init_config(struct emac_instance *dev)
 	}
 	memcpy(dev->ndev->dev_addr, p, 6);
 
+	/* IAHT and GAHT filter parameterization */
+	if (emac_has_feature(dev, EMAC_FTR_EMAC4SYNC)) {
+		dev->xaht_slots_shift = EMAC4SYNC_XAHT_SLOTS_SHIFT;
+		dev->xaht_width_shift = EMAC4SYNC_XAHT_WIDTH_SHIFT;
+	} else {
+		dev->xaht_slots_shift = EMAC4_XAHT_SLOTS_SHIFT;
+		dev->xaht_width_shift = EMAC4_XAHT_WIDTH_SHIFT;
+	}
+
 	DBG(dev, "features     : 0x%08x / 0x%08x\n", dev->features, EMAC_FTRS_POSSIBLE);
 	DBG(dev, "tx_fifo_size : %d (%d gige)\n", dev->tx_fifo_size, dev->tx_fifo_size_gige);
 	DBG(dev, "rx_fifo_size : %d (%d gige)\n", dev->rx_fifo_size, dev->rx_fifo_size_gige);
@@ -2672,7 +2690,8 @@ static int __devinit emac_probe(struct of_device *ofdev,
 		goto err_irq_unmap;
 	}
 	// TODO : request_mem_region
-	dev->emacp = ioremap(dev->rsrc_regs.start, sizeof(struct emac_regs));
+	dev->emacp = ioremap(dev->rsrc_regs.start,
+			     dev->rsrc_regs.end - dev->rsrc_regs.start + 1);
 	if (dev->emacp == NULL) {
 		printk(KERN_ERR "%s: Can't map device registers!\n",
 		       np->full_name);
@@ -2884,6 +2903,10 @@ static struct of_device_id emac_match[] =
 		.type		= "network",
 		.compatible	= "ibm,emac4",
 	},
+	{
+		.type		= "network",
+		.compatible	= "ibm,emac4sync",
+	},
 	{},
 };
 
diff --git a/drivers/net/ibm_newemac/core.h b/drivers/net/ibm_newemac/core.h
index 1683db9..70794cd 100644
--- a/drivers/net/ibm_newemac/core.h
+++ b/drivers/net/ibm_newemac/core.h
@@ -235,6 +235,10 @@ struct emac_instance {
 	u32				fifo_entry_size;
 	u32				mal_burst_size; /* move to MAL ? */
 
+	/* IAHT and GAHT filter parameterization */
+	u32				xaht_slots_shift;
+	u32				xaht_width_shift;
+
 	/* Descriptor management
 	 */
 	struct mal_descriptor		*tx_desc;
@@ -309,6 +313,10 @@ struct emac_instance {
  * Set if we need phy clock workaround for 440ep or 440gr
  */
 #define EMAC_FTR_440EP_PHY_CLK_FIX	0x00000100
+/*
+ * The 405EX and 460EX contain the EMAC4SYNC core
+ */
+#define EMAC_FTR_EMAC4SYNC		0x00000200
 
 
 /* Right now, we don't quite handle the always/possible masks on the
@@ -320,7 +328,8 @@ enum {
 
 	EMAC_FTRS_POSSIBLE	=
 #ifdef CONFIG_IBM_NEW_EMAC_EMAC4
-	    EMAC_FTR_EMAC4 | EMAC_FTR_HAS_NEW_STACR |
+	    EMAC_FTR_EMAC4	| EMAC_FTR_EMAC4SYNC	|
+	    EMAC_FTR_HAS_NEW_STACR	|
 	    EMAC_FTR_STACR_OC_INVERT | EMAC_FTR_440GX_PHY_CLK_FIX |
 #endif
 #ifdef CONFIG_IBM_NEW_EMAC_TAH
@@ -342,6 +351,71 @@ static inline int emac_has_feature(struct emac_instance *dev,
 	       (EMAC_FTRS_POSSIBLE & dev->features & feature);
 }
 
+/*
+ * Various instances of the EMAC core have varying 1) number of
+ * address match slots, 2) width of the registers for handling address
+ * match slots, 3) number of registers for handling address match
+ * slots and 4) base offset for those registers.
+ *
+ * These macros and inlines handle these differences based on
+ * parameters supplied by the device structure which are, in turn,
+ * initialized based on the "compatible" entry in the device tree.
+ */
+
+#define	EMAC4_XAHT_SLOTS_SHIFT		6
+#define	EMAC4_XAHT_WIDTH_SHIFT		4
+
+#define	EMAC4SYNC_XAHT_SLOTS_SHIFT	8
+#define	EMAC4SYNC_XAHT_WIDTH_SHIFT	5
+
+#define	EMAC_XAHT_SLOTS(dev)         	(1 << (dev)->xaht_slots_shift)
+#define	EMAC_XAHT_WIDTH(dev)         	(1 << (dev)->xaht_width_shift)
+#define	EMAC_XAHT_REGS(dev)          	(1 << ((dev)->xaht_slots_shift - \
+					       (dev)->xaht_width_shift))
+
+#define	EMAC_XAHT_CRC_TO_SLOT(dev, crc)			\
+	((EMAC_XAHT_SLOTS(dev) - 1) -			\
+	 ((crc) >> ((sizeof (u32) * BITS_PER_BYTE) -	\
+		    (dev)->xaht_slots_shift)))
+
+#define	EMAC_XAHT_SLOT_TO_REG(dev, slot)		\
+	((slot) >> (dev)->xaht_width_shift)
+
+#define	EMAC_XAHT_SLOT_TO_MASK(dev, slot)		\
+	((u32)(1 << (EMAC_XAHT_WIDTH(dev) - 1)) >>	\
+	 ((slot) & (u32)(EMAC_XAHT_WIDTH(dev) - 1)))
+
+static inline u32 *emac_xaht_base(struct emac_instance *dev)
+{
+	struct emac_regs __iomem *p = dev->emacp;
+	int offset;
+
+	/* The first IAHT entry always is the base of the block of
+	 * IAHT and GAHT registers.
+	 */
+	if (emac_has_feature(dev, EMAC_FTR_EMAC4SYNC))
+		offset = offsetof(struct emac_regs, u1.emac4sync.iaht1);
+	else
+		offset = offsetof(struct emac_regs, u0.emac4.iaht1);
+
+	return ((u32 *)((ptrdiff_t)p + offset));
+}
+
+static inline u32 *emac_gaht_base(struct emac_instance *dev)
+{
+	/* GAHT registers always come after an identical number of
+	 * IAHT registers.
+	 */
+	return (emac_xaht_base(dev) + EMAC_XAHT_REGS(dev));
+}
+
+static inline u32 *emac_iaht_base(struct emac_instance *dev)
+{
+	/* IAHT registers always come before an identical number of
+	 * GAHT registers.
+	 */
+	return (emac_xaht_base(dev));
+}
 
 /* Ethtool get_regs complex data.
  * We want to get not just EMAC registers, but also MAL, ZMII, RGMII, TAH
@@ -366,4 +440,11 @@ struct emac_ethtool_regs_subhdr {
 	u32 index;
 };
 
+#define EMAC_ETHTOOL_REGS_VER		0
+#define EMAC_ETHTOOL_REGS_SIZE(dev) 	((dev)->rsrc_regs.end - \
+					 (dev)->rsrc_regs.start + 1)
+#define EMAC4_ETHTOOL_REGS_VER      	1
+#define EMAC4_ETHTOOL_REGS_SIZE(dev)	((dev)->rsrc_regs.end -	\
+					 (dev)->rsrc_regs.start + 1)
+
 #endif /* __IBM_NEWEMAC_CORE_H */
diff --git a/drivers/net/ibm_newemac/debug.c b/drivers/net/ibm_newemac/debug.c
index 86b756a..775c850 100644
--- a/drivers/net/ibm_newemac/debug.c
+++ b/drivers/net/ibm_newemac/debug.c
@@ -67,29 +67,55 @@ static void emac_desc_dump(struct emac_instance *p)
 static void emac_mac_dump(struct emac_instance *dev)
 {
 	struct emac_regs __iomem *p = dev->emacp;
+	const int xaht_regs = EMAC_XAHT_REGS(dev);
+	u32 *gaht_base = emac_gaht_base(dev);
+	u32 *iaht_base = emac_iaht_base(dev);
+	int emac4sync = emac_has_feature(dev, EMAC_FTR_EMAC4SYNC);
+	int n;
 
 	printk("** EMAC %s registers **\n"
 	       "MR0 = 0x%08x MR1 = 0x%08x TMR0 = 0x%08x TMR1 = 0x%08x\n"
 	       "RMR = 0x%08x ISR = 0x%08x ISER = 0x%08x\n"
-	       "IAR = %04x%08x VTPID = 0x%04x VTCI = 0x%04x\n"
-	       "IAHT: 0x%04x 0x%04x 0x%04x 0x%04x "
-	       "GAHT: 0x%04x 0x%04x 0x%04x 0x%04x\n"
-	       "LSA = %04x%08x IPGVR = 0x%04x\n"
-	       "STACR = 0x%08x TRTR = 0x%08x RWMR = 0x%08x\n"
-	       "OCTX = 0x%08x OCRX = 0x%08x IPCR = 0x%08x\n",
+	       "IAR = %04x%08x VTPID = 0x%04x VTCI = 0x%04x\n",
 	       dev->ofdev->node->full_name, in_be32(&p->mr0), in_be32(&p->mr1),
 	       in_be32(&p->tmr0), in_be32(&p->tmr1),
 	       in_be32(&p->rmr), in_be32(&p->isr), in_be32(&p->iser),
 	       in_be32(&p->iahr), in_be32(&p->ialr), in_be32(&p->vtpid),
-	       in_be32(&p->vtci),
-	       in_be32(&p->iaht1), in_be32(&p->iaht2), in_be32(&p->iaht3),
-	       in_be32(&p->iaht4),
-	       in_be32(&p->gaht1), in_be32(&p->gaht2), in_be32(&p->gaht3),
-	       in_be32(&p->gaht4),
+	       in_be32(&p->vtci)
+	       );
+
+	if (emac4sync)
+		printk("MAR = %04x%08x MMAR = %04x%08x\n",
+		       in_be32(&p->u0.emac4sync.mahr),
+		       in_be32(&p->u0.emac4sync.malr),
+		       in_be32(&p->u0.emac4sync.mmahr),
+		       in_be32(&p->u0.emac4sync.mmalr)
+		       );
+
+	for (n = 0; n < xaht_regs; n++)
+		printk("IAHT%02d = 0x%08x\n", n + 1, in_be32(iaht_base + n));
+
+	for (n = 0; n < xaht_regs; n++)
+		printk("GAHT%02d = 0x%08x\n", n + 1, in_be32(gaht_base + n));
+
+	printk("LSA = %04x%08x IPGVR = 0x%04x\n"
+	       "STACR = 0x%08x TRTR = 0x%08x RWMR = 0x%08x\n"
+	       "OCTX = 0x%08x OCRX = 0x%08x\n",
 	       in_be32(&p->lsah), in_be32(&p->lsal), in_be32(&p->ipgvr),
 	       in_be32(&p->stacr), in_be32(&p->trtr), in_be32(&p->rwmr),
-	       in_be32(&p->octx), in_be32(&p->ocrx), in_be32(&p->ipcr)
-	    );
+	       in_be32(&p->octx), in_be32(&p->ocrx)
+	       );
+
+	if (!emac4sync) {
+		printk("IPCR = 0x%08x\n",
+		       in_be32(&p->u1.emac4.ipcr)
+		       );
+	} else {
+		printk("REVID = 0x%08x TPC = 0x%08x\n",
+		       in_be32(&p->u1.emac4sync.revid),
+		       in_be32(&p->u1.emac4sync.tpc)
+		       );
+	}
 
 	emac_desc_dump(dev);
 }
diff --git a/drivers/net/ibm_newemac/emac.h b/drivers/net/ibm_newemac/emac.h
index 91cb096..0afc2cf 100644
--- a/drivers/net/ibm_newemac/emac.h
+++ b/drivers/net/ibm_newemac/emac.h
@@ -27,37 +27,80 @@
 
 #include <linux/types.h>
 
-/* EMAC registers 		Write Access rules */
+/* EMAC registers 			Write Access rules */
 struct emac_regs {
-	u32 mr0;		/* special 	*/
-	u32 mr1;		/* Reset 	*/
-	u32 tmr0;		/* special 	*/
-	u32 tmr1;		/* special 	*/
-	u32 rmr;		/* Reset 	*/
-	u32 isr;		/* Always 	*/
-	u32 iser;		/* Reset 	*/
-	u32 iahr;		/* Reset, R, T 	*/
-	u32 ialr;		/* Reset, R, T 	*/
-	u32 vtpid;		/* Reset, R, T 	*/
-	u32 vtci;		/* Reset, R, T 	*/
-	u32 ptr;		/* Reset,    T 	*/
-	u32 iaht1;		/* Reset, R	*/
-	u32 iaht2;		/* Reset, R	*/
-	u32 iaht3;		/* Reset, R	*/
-	u32 iaht4;		/* Reset, R	*/
-	u32 gaht1;		/* Reset, R	*/
-	u32 gaht2;		/* Reset, R	*/
-	u32 gaht3;		/* Reset, R	*/
-	u32 gaht4;		/* Reset, R	*/
+	/* Common registers across all EMAC implementations. */
+	u32 mr0;			/* Special 	*/
+	u32 mr1;			/* Reset 	*/
+	u32 tmr0;			/* Special 	*/
+	u32 tmr1;			/* Special 	*/
+	u32 rmr;			/* Reset 	*/
+	u32 isr;			/* Always 	*/
+	u32 iser;			/* Reset 	*/
+	u32 iahr;			/* Reset, R, T 	*/
+	u32 ialr;			/* Reset, R, T 	*/
+	u32 vtpid;			/* Reset, R, T 	*/
+	u32 vtci;			/* Reset, R, T 	*/
+	u32 ptr;			/* Reset,    T 	*/
+	union {
+		/* Registers unique to EMAC4 implementations */
+		struct {
+			u32 iaht1;	/* Reset, R	*/
+			u32 iaht2;	/* Reset, R	*/
+			u32 iaht3;	/* Reset, R	*/
+			u32 iaht4;	/* Reset, R	*/
+			u32 gaht1;	/* Reset, R	*/
+			u32 gaht2;	/* Reset, R	*/
+			u32 gaht3;	/* Reset, R	*/
+			u32 gaht4;	/* Reset, R	*/
+		} emac4;
+		/* Registers unique to EMAC4SYNC implementations */
+		struct {
+			u32 mahr;	/* Reset, R, T  */
+			u32 malr;	/* Reset, R, T  */
+			u32 mmahr;	/* Reset, R, T  */
+			u32 mmalr;	/* Reset, R, T  */
+			u32 rsvd0[4];
+		} emac4sync;
+	} u0;
+	/* Common registers across all EMAC implementations. */
 	u32 lsah;
 	u32 lsal;
-	u32 ipgvr;		/* Reset,    T 	*/
-	u32 stacr;		/* special 	*/
-	u32 trtr;		/* special 	*/
-	u32 rwmr;		/* Reset 	*/
+	u32 ipgvr;			/* Reset,    T 	*/
+	u32 stacr;			/* Special 	*/
+	u32 trtr;			/* Special 	*/
+	u32 rwmr;			/* Reset 	*/
 	u32 octx;
 	u32 ocrx;
-	u32 ipcr;
+	union {
+		/* Registers unique to EMAC4 implementations */
+		struct {
+			u32 ipcr;
+		} emac4;
+		/* Registers unique to EMAC4SYNC implementations */
+		struct {
+			u32 rsvd1;
+			u32 revid;
+ 			u32 rsvd2[2];
+			u32 iaht1;	/* Reset, R     */
+			u32 iaht2;	/* Reset, R     */
+			u32 iaht3;	/* Reset, R     */
+			u32 iaht4;	/* Reset, R     */
+			u32 iaht5;	/* Reset, R     */
+			u32 iaht6;	/* Reset, R     */
+			u32 iaht7;	/* Reset, R     */
+			u32 iaht8;	/* Reset, R     */
+			u32 gaht1;	/* Reset, R     */
+			u32 gaht2;	/* Reset, R     */
+			u32 gaht3;	/* Reset, R     */
+			u32 gaht4;	/* Reset, R     */
+			u32 gaht5;	/* Reset, R     */
+			u32 gaht6;	/* Reset, R     */
+			u32 gaht7;	/* Reset, R     */
+			u32 gaht8;	/* Reset, R     */
+			u32 tpc;	/* Reset, T     */
+		} emac4sync;
+	} u1;
 };
 
 /*
@@ -73,12 +116,6 @@ struct emac_regs {
 #define PHY_MODE_RTBI	7
 #define PHY_MODE_SGMII	8
 
-
-#define EMAC_ETHTOOL_REGS_VER		0
-#define EMAC_ETHTOOL_REGS_SIZE		(sizeof(struct emac_regs) - sizeof(u32))
-#define EMAC4_ETHTOOL_REGS_VER      	1
-#define EMAC4_ETHTOOL_REGS_SIZE		sizeof(struct emac_regs)
-
 /* EMACx_MR0 */
 #define EMAC_MR0_RXI			0x80000000
 #define EMAC_MR0_TXI			0x40000000
