Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DA3A6DDFD2
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:41:03 +1000 (EST)
Date: Mon, 23 Apr 2007 14:40:56 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4 v3] powerpc: replace undocumented interface properties
	in dts files
Message-Id: <20070423144056.529836fc.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

phy-connection-type now supercedes the interface property.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
name change since [patch 2/4 v2]: s/interface-type/phy-connection-type/g

 arch/powerpc/boot/dts/mpc832x_mds.dts |    2 --
 arch/powerpc/boot/dts/mpc832x_rdb.dts |    2 --
 arch/powerpc/boot/dts/mpc836x_mds.dts |    4 ++--
 arch/powerpc/boot/dts/mpc8568mds.dts  |    6 ++----
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index c798491..93b7606 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -306,14 +306,12 @@
 				interrupts = <11 8>;
 				reg = <3>;
 				device_type = "ethernet-phy";
-				interface = <3>; //ENET_100_MII
 			};
 			phy4: ethernet-phy@04 {
 				interrupt-parent = < &ipic >;
 				interrupts = <12 8>;
 				reg = <4>;
 				device_type = "ethernet-phy";
-				interface = <3>;
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index b55bced..be4c357 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -265,14 +265,12 @@
 				interrupts = <0>;
 				reg = <0>;
 				device_type = "ethernet-phy";
-				interface = <3>; //ENET_100_MII
 			};
 			phy04:ethernet-phy@04 {
 				interrupt-parent = <&pic>;
 				interrupts = <0>;
 				reg = <4>;
 				device_type = "ethernet-phy";
-				interface = <3>;
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 7f578eb..67622f2 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -302,6 +302,7 @@
 			interrupts = <20>;
 			interrupt-parent = < &qeic >;
 			mac-address = [ 00 04 9f 00 23 23 ];
+			phy-connection-type = "rgmii-id";
 			rx-clock = <0>;
 			tx-clock = <19>;
 			phy-handle = < &phy0 >;
@@ -317,6 +318,7 @@
 			interrupts = <21>;
 			interrupt-parent = < &qeic >;
 			mac-address = [ 00 11 22 33 44 55 ];
+			phy-connection-type = "rgmii-id";
 			rx-clock = <0>;
 			tx-clock = <14>;
 			phy-handle = < &phy1 >;
@@ -335,14 +337,12 @@
 				interrupts = <11 8>;
 				reg = <0>;
 				device_type = "ethernet-phy";
-				interface = <6>; //ENET_1000_GMII
 			};
 			phy1: ethernet-phy@01 {
 				interrupt-parent = < &ipic >;
 				interrupts = <12 8>;
 				reg = <1>;
 				device_type = "ethernet-phy";
-				interface = <6>;
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 7361b36..14e3ea6 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -285,6 +285,7 @@
 			interrupts = <20>;
 			interrupt-parent = <&qeic>;
 			mac-address = [ 00 04 9f 00 23 23 ];
+			phy-connection-type = "gmii";
 			rx-clock = <0>;
 			tx-clock = <19>;
 			phy-handle = <&qe_phy0>;
@@ -300,6 +301,7 @@
 			interrupts = <21>;
 			interrupt-parent = <&qeic>;
 			mac-address = [ 00 11 22 33 44 55 ];
+			phy-connection-type = "gmii";
 			rx-clock = <0>;
 			tx-clock = <14>;
 			phy-handle = <&qe_phy1>;
@@ -320,28 +322,24 @@
 				interrupts = <31 1>;
 				reg = <0>;
 				device_type = "ethernet-phy";
-				interface = <6>; //ENET_1000_GMII
 			};
 			qe_phy1: ethernet-phy@01 {
 				interrupt-parent = <&mpic>;
 				interrupts = <32 1>;
 				reg = <1>;
 				device_type = "ethernet-phy";
-				interface = <6>;
 			};
 			qe_phy2: ethernet-phy@02 {
 				interrupt-parent = <&mpic>;
 				interrupts = <31 1>;
 				reg = <2>;
 				device_type = "ethernet-phy";
-				interface = <6>; //ENET_1000_GMII
 			};
 			qe_phy3: ethernet-phy@03 {
 				interrupt-parent = <&mpic>;
 				interrupts = <32 1>;
 				reg = <3>;
 				device_type = "ethernet-phy";
-				interface = <6>; //ENET_1000_GMII
 			};
 		};
 
-- 
1.5.0.3
