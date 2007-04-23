Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27A68DDF9A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 07:26:20 +1000 (EST)
Date: Mon, 23 Apr 2007 16:26:14 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4 v4] powerpc: replace undocumented interface properties
	in dts files
Message-Id: <20070423162614.52599bb2.kim.phillips@freescale.com>
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
moved phy-connection-type below phy-handle

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
index 7f578eb..38c8594 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -305,6 +305,7 @@
 			rx-clock = <0>;
 			tx-clock = <19>;
 			phy-handle = < &phy0 >;
+			phy-connection-type = "rgmii-id";
 			pio-handle = < &pio1 >;
 		};
 
@@ -320,6 +321,7 @@
 			rx-clock = <0>;
 			tx-clock = <14>;
 			phy-handle = < &phy1 >;
+			phy-connection-type = "rgmii-id";
 			pio-handle = < &pio2 >;
 		};
 
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
index 7361b36..948a3b6 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -288,6 +288,7 @@
 			rx-clock = <0>;
 			tx-clock = <19>;
 			phy-handle = <&qe_phy0>;
+			phy-connection-type = "gmii";
 			pio-handle = <&pio1>;
 		};
 
@@ -303,6 +304,7 @@
 			rx-clock = <0>;
 			tx-clock = <14>;
 			phy-handle = <&qe_phy1>;
+			phy-connection-type = "gmii";
 			pio-handle = <&pio2>;
 		};
 
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
