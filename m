Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CD031DDEE0
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 00:33:05 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 4F84C8810
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 19:33:04 +0500 (SAMST)
Date: Tue, 25 Sep 2007 18:34:55 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/7] [POWERPC] mpc8568mds: update dts to be able to use UCCs
Message-ID: <20070925143455.GE5323@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070925143126.GA30013@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. UCC1's RX_DV pin is 16, not 15;
2. UCC1's phy is at 0x7, not 0x1. Schematics says 0x7, and recent
   u-boot also using 0x7.
3. Use gianfar's (eTSEC) mdio bus. This is hardware default setup.
4. tx-clock should be CLK16 (GE125, PB31);
5. phy-connection-type is RGMII-ID;

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index c472a4b..1d082fb 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -95,10 +95,10 @@
 			device_type = "mdio";
 			compatible = "gianfar";
 			reg = <24520 20>;
-			phy0: ethernet-phy@0 {
+			phy0: ethernet-phy@7 {
 				interrupt-parent = <&mpic>;
 				interrupts = <1 1>;
-				reg = <0>;
+				reg = <7>;
 				device_type = "ethernet-phy";
 			};
 			phy1: ethernet-phy@1 {
@@ -286,7 +286,7 @@
 					4  1a  2  0  2  0 	/* RxD7 */
 					4  0b  1  0  2  0 	/* TX_EN */
 					4  18  1  0  2  0 	/* TX_ER */
-					4  0f  2  0  2  0 	/* RX_DV */
+					4  10  2  0  2  0 	/* RX_DV */
 					4  1e  2  0  2  0 	/* RX_ER */
 					4  11  2  0  2  0 	/* RX_CLK */
 					4  13  1  0  2  0 	/* GTX_CLK */
@@ -377,10 +377,10 @@
 			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <0>;
-			tx-clock = <19>;
-			phy-handle = <&qe_phy0>;
-			phy-connection-type = "gmii";
+			tx-clock = <20>;
 			pio-handle = <&pio1>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
 		};
 
 		ucc@3000 {
@@ -399,10 +399,10 @@
 			mac-address = [ 00 00 00 00 00 00 ];
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			rx-clock = <0>;
-			tx-clock = <14>;
-			phy-handle = <&qe_phy1>;
-			phy-connection-type = "gmii";
+			tx-clock = <20>;
 			pio-handle = <&pio2>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
 		};
 
 		mdio@2120 {
@@ -414,10 +414,10 @@
 
 			/* These are the same PHYs as on
 			 * gianfar's MDIO bus */
-			qe_phy0: ethernet-phy@00 {
+			qe_phy0: ethernet-phy@07 {
 				interrupt-parent = <&mpic>;
 				interrupts = <1 1>;
-				reg = <0>;
+				reg = <7>;
 				device_type = "ethernet-phy";
 			};
 			qe_phy1: ethernet-phy@01 {
-- 
1.5.0.6
