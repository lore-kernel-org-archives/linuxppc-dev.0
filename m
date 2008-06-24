Return-Path: <gerickson@nuovations.com>
Received: from relay01.pair.com (relay01.pair.com [209.68.5.15])
	by ozlabs.org (Postfix) with SMTP id 064A2DE328
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 09:53:00 +1000 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Parameterize EMAC Multicast Match Handling
Date: Tue, 24 Jun 2008 16:46:17 -0700
Message-Id: <1214351177-11972-1-git-send-email-gerickson@nuovations.com>
Cc: Stefan Roese <sr@denx.de>
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

The 405EX(r) and 460 now use the EMAC4SYNC core rather than the EMAC4 
core. This core has 8 IAHT and GAHT registers, starting at offset 0x80 
from the register base, with ALL 32-bits of each used for a total of 
256 match slots.

This adds macros and inlines for handling these differences based on
three parameters parsed from the device tree:

	xaht-slots-shift
	xaht-width-shift
	xaht-base-offset

and reworks the code, where appropriate to use those macros and inlines. 
EMAC/EMAC4 values are defaulted for these keys if missing, resulting in 
a driver that works as today's does for all cores.

In addition the register size passed to ioremap is now taken from the 
device tree:

	c0 for EMAC4SYNC cores
	74 for EMAC4 cores
	70 for EMAC cores

rathaer than sizeof (emac_regs).

Finally, the device trees have been updated with the appropriate xaht-* 
keys and values.

This has been tested on an AMCC Haleakala board such that: 1) inbound 
ICMP requests to 'haleakala.local' via MDNS from both Mac OS X 10.4.11 
and Ubuntu 8.04 systems as well as 2) outbound ICMP requests from 
'haleakala.local' to those same systems in the '.local' domain via MDNS 
now work.

Signed-off-by: Grant Erickson <gerickson@nuovations.com>
---
 arch/powerpc/boot/dts/bamboo.dts      |    6 +++
 arch/powerpc/boot/dts/canyonlands.dts |   10 ++++-
 arch/powerpc/boot/dts/ebony.dts       |    6 +++
 arch/powerpc/boot/dts/ep405.dts       |    3 ++
 arch/powerpc/boot/dts/glacier.dts     |   20 +++++++++--
 arch/powerpc/boot/dts/haleakala.dts   |    5 ++-
 arch/powerpc/boot/dts/katmai.dts      |    5 ++-
 arch/powerpc/boot/dts/kilauea.dts     |   10 ++++-
 arch/powerpc/boot/dts/makalu.dts      |   10 ++++-
 arch/powerpc/boot/dts/rainier.dts     |   10 ++++-
 arch/powerpc/boot/dts/sequoia.dts     |   10 ++++-
 arch/powerpc/boot/dts/taishan.dts     |   20 +++++++++--
 arch/powerpc/boot/dts/walnut.dts      |    3 ++
 arch/powerpc/boot/dts/warp.dts        |    3 ++
 drivers/net/ibm_newemac/core.c        |   55 +++++++++++++++++++----------
 drivers/net/ibm_newemac/core.h        |   61 +++++++++++++++++++++++++++++++++
 drivers/net/ibm_newemac/debug.c       |   32 +++++++++++------
 drivers/net/ibm_newemac/emac.h        |   15 +-------
 18 files changed, 219 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/boot/dts/bamboo.dts b/arch/powerpc/boot/dts/bamboo.dts
index ba2521b..200a4ec 100644
--- a/arch/powerpc/boot/dts/bamboo.dts
+++ b/arch/powerpc/boot/dts/bamboo.dts
@@ -221,6 +221,9 @@
 				phy-map = <00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 			};
 
 			EMAC1: ethernet@ef600f00 {
@@ -241,6 +244,9 @@
 				phy-map = <00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 			};
 
 			usb@ef601000 {
diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 3963412..75ff768 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -272,7 +272,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC2 10 4
 						 /*Wake*/   1 &UIC2 14 4>;
-				reg = <ef600e00 70>;
+				reg = <ef600e00 74>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -287,6 +287,9 @@
 				rgmii-channel = <0>;
 				tah-device = <&TAH0>;
 				tah-channel = <0>;
+				xaht-base-offset = <80>;
+				xaht-slots-shift = <8>;
+				xaht-width-shift = <5>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
@@ -301,7 +304,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC2 11 4
 						 /*Wake*/   1 &UIC2 15 4>;
-				reg = <ef600f00 70>;
+				reg = <ef600f00 74>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
@@ -316,6 +319,9 @@
 				rgmii-channel = <1>;
 				tah-device = <&TAH1>;
 				tah-channel = <1>;
+				xaht-base-offset = <80>;
+				xaht-slots-shift = <8>;
+				xaht-width-shift = <5>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 				mdio-device = <&EMAC0>;
diff --git a/arch/powerpc/boot/dts/ebony.dts b/arch/powerpc/boot/dts/ebony.dts
index 5079dc8..3c68c1e 100644
--- a/arch/powerpc/boot/dts/ebony.dts
+++ b/arch/powerpc/boot/dts/ebony.dts
@@ -258,6 +258,9 @@
 				phy-map = <00000001>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 			};
 			EMAC1: ethernet@40000900 {
 				device_type = "network";
@@ -277,6 +280,9 @@
 				phy-map = <00000001>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 			};
 
 
diff --git a/arch/powerpc/boot/dts/ep405.dts b/arch/powerpc/boot/dts/ep405.dts
index 9293855..730a561 100644
--- a/arch/powerpc/boot/dts/ep405.dts
+++ b/arch/powerpc/boot/dts/ep405.dts
@@ -143,6 +143,9 @@
 				tx-fifo-size = <800>;
 				phy-mode = "rmii";
 				phy-map = <00000000>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 			};
 
 		};
diff --git a/arch/powerpc/boot/dts/glacier.dts b/arch/powerpc/boot/dts/glacier.dts
index 0f2fc07..c73bea1 100644
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
@@ -296,6 +296,9 @@
 				rgmii-channel = <0>;
 				tah-device = <&TAH0>;
 				tah-channel = <0>;
+				xaht-base-offset = <80>;
+				xaht-slots-shift = <8>;
+				xaht-width-shift = <5>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
@@ -310,7 +313,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC2 11 4
 						 /*Wake*/   1 &UIC2 15 4>;
-				reg = <ef600f00 70>;
+				reg = <ef600f00 74>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
@@ -325,6 +328,9 @@
 				rgmii-channel = <1>;
 				tah-device = <&TAH1>;
 				tah-channel = <1>;
+				xaht-base-offset = <80>;
+				xaht-slots-shift = <8>;
+				xaht-width-shift = <5>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 				mdio-device = <&EMAC0>;
@@ -340,7 +346,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC2 12 4
 						 /*Wake*/   1 &UIC2 16 4>;
-				reg = <ef601100 70>;
+				reg = <ef601100 74>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <2>;
@@ -353,6 +359,9 @@
 				phy-map = <00000000>;
 				rgmii-device = <&RGMII1>;
 				rgmii-channel = <0>;
+				xaht-base-offset = <80>;
+				xaht-slots-shift = <8>;
+				xaht-width-shift = <5>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 				mdio-device = <&EMAC0>;
@@ -368,7 +377,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC2 13 4
 						 /*Wake*/   1 &UIC2 17 4>;
-				reg = <ef601200 70>;
+				reg = <ef601200 74>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <3>;
@@ -381,6 +390,9 @@
 				phy-map = <00000000>;
 				rgmii-device = <&RGMII1>;
 				rgmii-channel = <1>;
+				xaht-base-offset = <80>;
+				xaht-slots-shift = <8>;
+				xaht-width-shift = <5>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 				mdio-device = <&EMAC0>;
diff --git a/arch/powerpc/boot/dts/haleakala.dts b/arch/powerpc/boot/dts/haleakala.dts
index b5d95ac..7a1243b 100644
--- a/arch/powerpc/boot/dts/haleakala.dts
+++ b/arch/powerpc/boot/dts/haleakala.dts
@@ -212,7 +212,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 18 4
 						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600900 70>;
+				reg = <ef600900 c0>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -225,6 +225,9 @@
 				phy-map = <00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
+				xaht-base-offset = <80>;
+				xaht-slots-shift = <8>;
+				xaht-width-shift = <5>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index cc2873a..cbe23bd 100644
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
@@ -217,6 +217,9 @@
 				tx-fifo-size = <800>;
 				phy-mode = "gmii";
 				phy-map = <00000000>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index 48c9a6e..2164d6c 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -213,7 +213,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 18 4
 						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600900 70>;
+				reg = <ef600900 c0>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -226,6 +226,9 @@
 				phy-map = <00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
+				xaht-base-offset = <80>;
+				xaht-slots-shift = <8>;
+				xaht-width-shift = <5>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
@@ -241,7 +244,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 19 4
 						/*Wake*/  1 &UIC1 1f 4>;
-				reg = <ef600a00 70>;
+				reg = <ef600900 c0>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
@@ -254,6 +257,9 @@
 				phy-map = <00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
+				xaht-base-offset = <80>;
+				xaht-slots-shift = <8>;
+				xaht-width-shift = <5>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
diff --git a/arch/powerpc/boot/dts/makalu.dts b/arch/powerpc/boot/dts/makalu.dts
index 84cc5e7..8f97927 100644
--- a/arch/powerpc/boot/dts/makalu.dts
+++ b/arch/powerpc/boot/dts/makalu.dts
@@ -213,7 +213,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 18 4
 						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600900 70>;
+				reg = <ef600900 c0>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
@@ -226,6 +226,9 @@
 				phy-map = <0000003f>;	/* Start at 6 */
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
+				xaht-base-offset = <80>;
+				xaht-slots-shift = <8>;
+				xaht-width-shift = <5>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
@@ -241,7 +244,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 19 4
 						/*Wake*/  1 &UIC1 1f 4>;
-				reg = <ef600a00 70>;
+				reg = <ef600900 c0>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
@@ -254,6 +257,9 @@
 				phy-map = <00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
+				xaht-base-offset = <80>;
+				xaht-slots-shift = <8>;
+				xaht-width-shift = <5>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
diff --git a/arch/powerpc/boot/dts/rainier.dts b/arch/powerpc/boot/dts/rainier.dts
index 6a8fa70..422c969 100644
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
@@ -278,6 +278,9 @@
 				zmii-channel = <0>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
@@ -292,7 +295,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 19 4
 						/*Wake*/  1 &UIC1 1f 4>;
-				reg = <ef600f00 70>;
+				reg = <ef600f00 74>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
@@ -307,6 +310,9 @@
 				zmii-channel = <1>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index 72d6756..cb52b3b 100644
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
@@ -293,6 +293,9 @@
 				zmii-channel = <0>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
@@ -307,7 +310,7 @@
 				#size-cells = <0>;
 				interrupt-map = </*Status*/ 0 &UIC0 19 4
 						/*Wake*/  1 &UIC1 1f 4>;
-				reg = <ef600f00 70>;
+				reg = <ef600f00 74>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
@@ -322,6 +325,9 @@
 				zmii-channel = <1>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
diff --git a/arch/powerpc/boot/dts/taishan.dts b/arch/powerpc/boot/dts/taishan.dts
index e808e1c..872d7b7 100644
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
@@ -271,6 +271,9 @@
 				phy-map = <00000001>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 			};
 		 	EMAC1: ethernet@40000900 {
 				unused = <1>;
@@ -278,7 +281,7 @@
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC1>;
 				interrupts = <1e 4 1f 4>;
-				reg = <40000900 70>;
+				reg = <40000900 74>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
@@ -291,6 +294,9 @@
 				phy-map = <00000001>;
  				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 			};
 
 		 	EMAC2: ethernet@40000c00 {
@@ -298,7 +304,7 @@
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC2>;
 				interrupts = <0 4 1 4>;
-				reg = <40000c00 70>;
+				reg = <40000c00 74>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <2>;
@@ -315,6 +321,9 @@
 				zmii-channel = <2>;
 				tah-device = <&TAH0>;
 				tah-channel = <0>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 			};
 
 		 	EMAC3: ethernet@40000e00 {
@@ -322,7 +331,7 @@
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC2>;
 				interrupts = <2 4 3 4>;
-				reg = <40000e00 70>;
+				reg = <40000e00 74>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <3>;
@@ -339,6 +348,9 @@
 				zmii-channel = <3>;
 				tah-device = <&TAH1>;
 				tah-channel = <0>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 			};
 
 
diff --git a/arch/powerpc/boot/dts/walnut.dts b/arch/powerpc/boot/dts/walnut.dts
index a328607..eb7e776 100644
--- a/arch/powerpc/boot/dts/walnut.dts
+++ b/arch/powerpc/boot/dts/walnut.dts
@@ -142,6 +142,9 @@
 				tx-fifo-size = <800>;
 				phy-mode = "rmii";
 				phy-map = <00000001>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 			};
 
 		};
diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
index b04a52e..a4c3dfb 100644
--- a/arch/powerpc/boot/dts/warp.dts
+++ b/arch/powerpc/boot/dts/warp.dts
@@ -221,6 +221,9 @@
 				phy-map = <00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
+				xaht-base-offset = <30>;
+				xaht-slots-shift = <6>;
+				xaht-width-shift = <4>;
 			};
 
 			usb@ef601000 {
diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 5d2108c..9427972 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -363,25 +363,32 @@ static int emac_reset(struct emac_instance *dev)
 
 static void emac_hash_mc(struct emac_instance *dev)
 {
-	struct emac_regs __iomem *p = dev->emacp;
-	u16 gaht[4] = { 0 };
+	const int regs = EMAC_XAHT_REGS(dev);
+	u32 *gaht_base = emac_gaht_base(dev);
+	u32 gaht_temp[regs];
 	struct dev_mc_list *dmi;
+	int i;
 
-	DBG(dev, "hash_mc %d" NL, dev->ndev->mc_count);
+	DBG3(dev, "hash_mc %d" NL, dev->ndev->mc_count);
+
+	memset(gaht_temp, 0, sizeof (gaht_temp));
 
 	for (dmi = dev->ndev->mc_list; dmi; dmi = dmi->next) {
-		int bit;
-		DBG2(dev, "mc %02x:%02x:%02x:%02x:%02x:%02x" NL,
+		int slot, reg, mask;
+		DBG3(dev, "mc %02x:%02x:%02x:%02x:%02x:%02x" NL,
 		     dmi->dmi_addr[0], dmi->dmi_addr[1], dmi->dmi_addr[2],
 		     dmi->dmi_addr[3], dmi->dmi_addr[4], dmi->dmi_addr[5]);
 
-		bit = 63 - (ether_crc(ETH_ALEN, dmi->dmi_addr) >> 26);
-		gaht[bit >> 4] |= 0x8000 >> (bit & 0x0f);
+		slot = EMAC_XAHT_CRC_TO_SLOT(dev, ether_crc(ETH_ALEN, dmi->dmi_addr));
+		reg = EMAC_XAHT_SLOT_TO_REG(dev, slot);
+		mask = EMAC_XAHT_SLOT_TO_MASK(dev, slot);
+
+		gaht_temp[reg] |= mask;
+	}
+
+	for (i = 0; i < regs; i++) {
+		out_be32(gaht_base + i, gaht_temp[i]);
 	}
-	out_be32(&p->gaht1, gaht[0]);
-	out_be32(&p->gaht2, gaht[1]);
-	out_be32(&p->gaht3, gaht[2]);
-	out_be32(&p->gaht4, gaht[3]);
 }
 
 static inline u32 emac_iff2rmr(struct net_device *ndev)
@@ -398,7 +405,8 @@ static inline u32 emac_iff2rmr(struct net_device *ndev)
 
 	if (ndev->flags & IFF_PROMISC)
 		r |= EMAC_RMR_PME;
-	else if (ndev->flags & IFF_ALLMULTI || ndev->mc_count > 32)
+	else if (ndev->flags & IFF_ALLMULTI ||
+			 (ndev->mc_count > EMAC_XAHT_SLOTS(dev)))
 		r |= EMAC_RMR_PMME;
 	else if (ndev->mc_count > 0)
 		r |= EMAC_RMR_MAE;
@@ -2015,10 +2023,10 @@ static int emac_get_regs_len(struct emac_instance *dev)
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
@@ -2045,12 +2053,12 @@ static void *emac_dump_regs(struct emac_instance *dev, void *buf)
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
 
@@ -2520,6 +2528,14 @@ static int __devinit emac_init_config(struct emac_instance *dev)
 	if (emac_read_uint_prop(np, "mal-burst-size", &dev->mal_burst_size, 0))
 		dev->mal_burst_size = 256;
 
+	/* IAHT and GAHT filter parameterization */
+	if (emac_read_uint_prop(np, "xaht-base-offset", &dev->xaht_base_offset, 0))
+		dev->xaht_base_offset = EMAC4_XAHT_BASE_OFFSET_DEFAULT;
+	if (emac_read_uint_prop(np, "xaht-slots-shift", &dev->xaht_slots_shift, 0))
+		dev->xaht_slots_shift = EMAC4_XAHT_SLOTS_SHIFT_DEFAULT;
+	if (emac_read_uint_prop(np, "xaht-width-shift", &dev->xaht_width_shift, 0))
+		dev->xaht_width_shift = EMAC4_XAHT_WIDTH_SHIFT_DEFAULT;
+
 	/* PHY mode needs some decoding */
 	dev->phy_mode = PHY_MODE_NA;
 	pm = of_get_property(np, "phy-mode", &plen);
@@ -2672,7 +2688,8 @@ static int __devinit emac_probe(struct of_device *ofdev,
 		goto err_irq_unmap;
 	}
 	// TODO : request_mem_region
-	dev->emacp = ioremap(dev->rsrc_regs.start, sizeof(struct emac_regs));
+	dev->emacp = ioremap(dev->rsrc_regs.start,
+						 dev->rsrc_regs.end - dev->rsrc_regs.start + 1);
 	if (dev->emacp == NULL) {
 		printk(KERN_ERR "%s: Can't map device registers!\n",
 		       np->full_name);
diff --git a/drivers/net/ibm_newemac/core.h b/drivers/net/ibm_newemac/core.h
index 1683db9..e4087fb 100644
--- a/drivers/net/ibm_newemac/core.h
+++ b/drivers/net/ibm_newemac/core.h
@@ -235,6 +235,11 @@ struct emac_instance {
 	u32				fifo_entry_size;
 	u32				mal_burst_size; /* move to MAL ? */
 
+	/* IAHT and GAHT filter parameterization */
+	u32				xaht_base_offset;
+	u32				xaht_slots_shift;
+	u32				xaht_width_shift;
+
 	/* Descriptor management
 	 */
 	struct mal_descriptor		*tx_desc;
@@ -342,6 +347,55 @@ static inline int emac_has_feature(struct emac_instance *dev,
 	       (EMAC_FTRS_POSSIBLE & dev->features & feature);
 }
 
+/*
+ * Various instances of the EMAC core have varying 1) number of
+ * address match slots, 2) width of the registers for handling address
+ * match slots, 3) number of registers for handling address match
+ * slots and 4) base offset for those registers.
+ *
+ * These macros and inlines handle these differences based on
+ * parameters supplied by the device tree.
+ */
+
+#define	EMAC4_XAHT_SLOTS_SHIFT_DEFAULT	6
+#define	EMAC4_XAHT_WIDTH_SHIFT_DEFAULT	4
+#define	EMAC4_XAHT_BASE_OFFSET_DEFAULT	0x30
+
+#define	EMAC_XAHT_SLOTS(dev)         	(1 << (dev)->xaht_slots_shift)
+#define	EMAC_XAHT_WIDTH(dev)         	(1 << (dev)->xaht_width_shift)
+#define	EMAC_XAHT_REGS(dev)          	(1 << ((dev)->xaht_slots_shift - \
+											   (dev)->xaht_width_shift))
+
+#define	EMAC_XAHT_CRC_TO_SLOT(dev, crc) 	\
+	((EMAC_XAHT_SLOTS(dev) - 1) -										\
+	 ((crc) >> ((sizeof (u32) * BITS_PER_BYTE) - (dev)->xaht_slots_shift)))
+
+#define	EMAC_XAHT_SLOT_TO_REG(dev, slot)	\
+	((slot) >> (dev)->xaht_width_shift)
+
+#define	EMAC_XAHT_SLOT_TO_MASK(dev, slot) 	\
+	((u32)(1 << (EMAC_XAHT_WIDTH(dev) - 1)) >> \
+	 ((slot) & (u32)(EMAC_XAHT_WIDTH(dev) - 1)))
+
+static inline u32 *emac_xaht_base(struct emac_instance *dev)
+{
+	struct emac_regs __iomem *p = dev->emacp;
+
+	return ((u32 *)((ptrdiff_t)p + dev->xaht_base_offset));
+}
+
+static inline u32 *emac_gaht_base(struct emac_instance *dev)
+{
+	/* GAHT registers always follow an identical number of IAHT registers */
+	return (emac_xaht_base(dev) + EMAC_XAHT_REGS(dev));
+}
+
+static inline u32 *emac_iaht_base(struct emac_instance *dev)
+{
+	/* IAHT registers are always come before GAHT registers */
+	return (emac_xaht_base(dev));
+}
+
 
 /* Ethtool get_regs complex data.
  * We want to get not just EMAC registers, but also MAL, ZMII, RGMII, TAH
@@ -366,4 +420,11 @@ struct emac_ethtool_regs_subhdr {
 	u32 index;
 };
 
+#define EMAC_ETHTOOL_REGS_VER			0
+#define EMAC_ETHTOOL_REGS_SIZE(dev) 	((dev)->rsrc_regs.end - \
+									 	(dev)->rsrc_regs.start + 1)
+#define EMAC4_ETHTOOL_REGS_VER      	1
+#define EMAC4_ETHTOOL_REGS_SIZE(dev)	((dev)->rsrc_regs.end -	\
+										 (dev)->rsrc_regs.start + 1)
+
 #endif /* __IBM_NEWEMAC_CORE_H */
diff --git a/drivers/net/ibm_newemac/debug.c b/drivers/net/ibm_newemac/debug.c
index 86b756a..d9fc0f4 100644
--- a/drivers/net/ibm_newemac/debug.c
+++ b/drivers/net/ibm_newemac/debug.c
@@ -67,29 +67,37 @@ static void emac_desc_dump(struct emac_instance *p)
 static void emac_mac_dump(struct emac_instance *dev)
 {
 	struct emac_regs __iomem *p = dev->emacp;
+	const int xaht_regs = EMAC_XAHT_REGS(dev);
+	u32 *gaht_base = emac_gaht_base(dev);
+	u32 *iaht_base = emac_iaht_base(dev);
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
+		  );
+
+	for (n = 0; n < xaht_regs; n++) {
+		printk("IAHT%02d: 0x%08x\n", n + 1, in_be32(iaht_base + n));
+	}
+
+	for (n = 0; n < xaht_regs; n++) {
+		printk("GAHT%02d: 0x%08x\n", n + 1, in_be32(gaht_base + n));
+	}
+
+	printk("LSA = %04x%08x IPGVR = 0x%04x\n"
+	       "STACR = 0x%08x TRTR = 0x%08x RWMR = 0x%08x\n"
+	       "OCTX = 0x%08x OCRX = 0x%08x IPCR = 0x%08x\n",
 	       in_be32(&p->lsah), in_be32(&p->lsal), in_be32(&p->ipgvr),
 	       in_be32(&p->stacr), in_be32(&p->trtr), in_be32(&p->rwmr),
 	       in_be32(&p->octx), in_be32(&p->ocrx), in_be32(&p->ipcr)
-	    );
+		  );
 
 	emac_desc_dump(dev);
 }
diff --git a/drivers/net/ibm_newemac/emac.h b/drivers/net/ibm_newemac/emac.h
index 91cb096..a4b5775 100644
--- a/drivers/net/ibm_newemac/emac.h
+++ b/drivers/net/ibm_newemac/emac.h
@@ -41,14 +41,7 @@ struct emac_regs {
 	u32 vtpid;		/* Reset, R, T 	*/
 	u32 vtci;		/* Reset, R, T 	*/
 	u32 ptr;		/* Reset,    T 	*/
-	u32 iaht1;		/* Reset, R	*/
-	u32 iaht2;		/* Reset, R	*/
-	u32 iaht3;		/* Reset, R	*/
-	u32 iaht4;		/* Reset, R	*/
-	u32 gaht1;		/* Reset, R	*/
-	u32 gaht2;		/* Reset, R	*/
-	u32 gaht3;		/* Reset, R	*/
-	u32 gaht4;		/* Reset, R	*/
+	u32 reserved[8];/* Chip-dependent */
 	u32 lsah;
 	u32 lsal;
 	u32 ipgvr;		/* Reset,    T 	*/
@@ -73,12 +66,6 @@ struct emac_regs {
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
-- 
1.5.4.3
