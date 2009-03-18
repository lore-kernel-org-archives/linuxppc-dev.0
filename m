Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 81945DDED8
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 07:00:35 +1100 (EST)
Date: Wed, 18 Mar 2009 23:00:33 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v3 2/4] powerpc/83xx: Move gianfar mdio nodes under the
	ethernet nodes
Message-ID: <20090318200033.GB8182@oksana.dev.rtsoft.ru>
References: <20090318195911.GA31525@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090318195911.GA31525@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently it doesn't matter where the mdio nodes are placed, but with
power management support (i.e. when sleep = <> properties will take
effect), mdio nodes placement will become important: mdio controller
is a part of the ethernet block, so the mdio nodes should be placed
correctly. Otherwise we may wrongly assume that MDIO controllers are
available during sleep.

Suggested-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/asp834x-redboot.dts |   82 +++++++++++++++-------------
 arch/powerpc/boot/dts/mpc8315erdb.dts     |   80 +++++++++++++++-------------
 arch/powerpc/boot/dts/mpc8349emitx.dts    |   69 +++++++++++++-----------
 arch/powerpc/boot/dts/mpc8349emitxgp.dts  |   42 ++++++++-------
 arch/powerpc/boot/dts/mpc834x_mds.dts     |   81 +++++++++++++++-------------
 arch/powerpc/boot/dts/mpc8377_mds.dts     |   80 +++++++++++++++-------------
 arch/powerpc/boot/dts/mpc8377_rdb.dts     |   67 +++++++++++++-----------
 arch/powerpc/boot/dts/mpc8378_mds.dts     |   80 +++++++++++++++-------------
 arch/powerpc/boot/dts/mpc8378_rdb.dts     |   69 ++++++++++++++-----------
 arch/powerpc/boot/dts/mpc8379_mds.dts     |   79 +++++++++++++++------------
 arch/powerpc/boot/dts/mpc8379_rdb.dts     |   66 +++++++++++++----------
 arch/powerpc/boot/dts/sbc8349.dts         |   80 +++++++++++++++-------------
 arch/powerpc/platforms/83xx/asp834x.c     |    1 +
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    1 +
 arch/powerpc/platforms/83xx/mpc834x_mds.c |    1 +
 arch/powerpc/platforms/83xx/mpc837x_mds.c |    1 +
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
 arch/powerpc/platforms/83xx/sbc834x.c     |    1 +
 18 files changed, 488 insertions(+), 393 deletions(-)

diff --git a/arch/powerpc/boot/dts/asp834x-redboot.dts b/arch/powerpc/boot/dts/asp834x-redboot.dts
index 524af7e..7da84fd 100644
--- a/arch/powerpc/boot/dts/asp834x-redboot.dts
+++ b/arch/powerpc/boot/dts/asp834x-redboot.dts
@@ -181,70 +181,76 @@
 			phy_type = "ulpi";
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 08 e5 11 32 33 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			linux,network-index = <0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
+
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 08 e5 11 32 34 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			linux,network-index = <1>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 88d691c..3f4c5fb 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -190,66 +190,74 @@
 			phy_type = "utmi";
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&ipic>;
-				interrupts = <20 0x8>;
-				reg = <0x0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&ipic>;
-				interrupts = <19 0x8>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = < &phy0 >;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&ipic>;
+					interrupts = <20 0x8>;
+					reg = <0x0>;
+					device_type = "ethernet-phy";
+				};
+
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&ipic>;
+					interrupts = <19 0x8>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = < &phy1 >;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index b5eda94..1ae38f0 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -170,57 +170,52 @@
 			phy_type = "ulpi";
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			/* Vitesse 8201 */
-			phy1c: ethernet-phy@1c {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x1c>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy1c>;
 			linux,network-index = <0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				/* Vitesse 8201 */
+				phy1c: ethernet-phy@1c {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x1c>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			interrupt-parent = <&ipic>;
@@ -228,6 +223,18 @@
 			fixed-link = <1 1 1000 0 0>;
 			linux,network-index = <1>;
 			tbi-handle = <&tbi1>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index c87a601..662abe1 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -149,37 +149,41 @@
 			phy_type = "ulpi";
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			/* Vitesse 8201 */
-			phy1c: ethernet-phy@1c {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x1c>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy1c>;
 			linux,network-index = <0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				/* Vitesse 8201 */
+				phy1c: ethernet-phy@1c {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x1c>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index d9adba0..d9f0a23 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -167,69 +167,76 @@
 			phy_type = "ulpi";
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			linux,network-index = <0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x0>;
+					device_type = "ethernet-phy";
+				};
+
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			linux,network-index = <1>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index cebfc50..9637080 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -196,48 +196,15 @@
 			sleep = <&pmc 0x00c00000>;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x3>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
@@ -246,14 +213,43 @@
 			phy-handle = <&phy2>;
 			sleep = <&pmc 0xc0000000>;
 			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
@@ -262,6 +258,18 @@
 			phy-handle = <&phy3>;
 			sleep = <&pmc 0x30000000>;
 			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 32311c8..0533393 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -248,42 +248,15 @@
 			sleep = <&pmc 0x00c00000>;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
@@ -292,14 +265,36 @@
 			phy-handle = <&phy2>;
 			sleep = <&pmc 0xc0000000>;
 			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
@@ -308,6 +303,18 @@
 			tbi-handle = <&tbi1>;
 			sleep = <&pmc 0x30000000>;
 			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 155841d..651ff2f 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -235,48 +235,15 @@
 			sleep = <&pmc 0x00c00000>;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x3>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
@@ -285,14 +252,43 @@
 			phy-handle = <&phy2>;
 			sleep = <&pmc 0xc0000000>;
 			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
@@ -301,6 +297,18 @@
 			phy-handle = <&phy3>;
 			sleep = <&pmc 0x30000000>;
 			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 54ad96c..5d90e85 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -248,64 +248,73 @@
 			sleep = <&pmc 0x00c00000>;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = <&ipic>;
+			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
 			sleep = <&pmc 0xc0000000>;
 			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
 			interrupt-parent = <&ipic>;
 			fixed-link = <1 1 1000 0 0>;
+			tbi-handle = <&tbi1>;
 			sleep = <&pmc 0x30000000>;
 			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index 9deb5b2..d6f208b 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -233,47 +233,15 @@
 			sleep = <&pmc 0x00c00000>;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&ipic>;
-				interrupts = <18 0x8>;
-				reg = <0x3>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
@@ -282,14 +250,43 @@
 			phy-handle = <&phy2>;
 			sleep = <&pmc 0xc0000000>;
 			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&ipic>;
+					interrupts = <18 0x8>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
@@ -298,6 +295,18 @@
 			phy-handle = <&phy3>;
 			sleep = <&pmc 0x30000000>;
 			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 3f4778f..98ae95b 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -246,41 +246,15 @@
 			sleep = <&pmc 0x00c00000>;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&ipic>;
-				interrupts = <17 0x8>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			phy-connection-type = "mii";
@@ -289,14 +263,36 @@
 			phy-handle = <&phy2>;
 			sleep = <&pmc 0xc0000000>;
 			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&ipic>;
+					interrupts = <17 0x8>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			phy-connection-type = "mii";
@@ -305,6 +301,18 @@
 			tbi-handle = <&tbi1>;
 			sleep = <&pmc 0x30000000>;
 			fsl,magic-packet;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index 8d365a5..a36dbbc 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -159,68 +159,76 @@
 			phy_type = "ulpi";
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@19 {
-				interrupt-parent = <&ipic>;
-				interrupts = <20 0x8>;
-				reg = <0x19>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1a {
-				interrupt-parent = <&ipic>;
-				interrupts = <21 0x8>;
-				reg = <0x1a>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@25520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x25520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <0>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			linux,network-index = <0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@19 {
+					interrupt-parent = <&ipic>;
+					interrupts = <20 0x8>;
+					reg = <0x19>;
+					device_type = "ethernet-phy";
+				};
+
+				phy1: ethernet-phy@1a {
+					interrupt-parent = <&ipic>;
+					interrupts = <21 0x8>;
+					reg = <0x1a>;
+					device_type = "ethernet-phy";
+				};
+
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 0x8 36 0x8 37 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			linux,network-index = <1>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/platforms/83xx/asp834x.c b/arch/powerpc/platforms/83xx/asp834x.c
index bb30d67..aa0d84d 100644
--- a/arch/powerpc/platforms/83xx/asp834x.c
+++ b/arch/powerpc/platforms/83xx/asp834x.c
@@ -58,6 +58,7 @@ static struct __initdata of_device_id asp8347_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 76092d3..81e44fa 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -42,6 +42,7 @@
 static struct of_device_id __initdata mpc834x_itx_ids[] = {
 	{ .compatible = "fsl,pq2pro-localbus", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index fc3f2ed..d0a634b 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -112,6 +112,7 @@ static struct of_device_id mpc834x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 634785c..51df7e7 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -96,6 +96,7 @@ static struct of_device_id mpc837x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 3d7b953..76f3b32 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -48,6 +48,7 @@ static struct of_device_id mpc837x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
index 156c4e2..49023db 100644
--- a/arch/powerpc/platforms/83xx/sbc834x.c
+++ b/arch/powerpc/platforms/83xx/sbc834x.c
@@ -84,6 +84,7 @@ static struct __initdata of_device_id sbc834x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
-- 
1.5.6.5
