Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id D79BDDDFB3
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 07:00:40 +1100 (EST)
Date: Wed, 18 Mar 2009 23:00:39 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v3 3/4] powerpc/85xx: Move gianfar mdio nodes under the
	ethernet nodes
Message-ID: <20090318200039.GC8182@oksana.dev.rtsoft.ru>
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

NOTE: mpc8572ds_camp_core1.dts now fully specifies ethernet@24000
layout. ethernet@24000 node is disabled via status = "disabled on
core1" property.

Suggested-by: Scott Wood <scottwood@freescale.com>
Suggested-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/ksi8560.dts              |   79 ++++++-----
 arch/powerpc/boot/dts/mpc8536ds.dts            |   78 ++++++-----
 arch/powerpc/boot/dts/mpc8540ads.dts           |  117 +++++++++--------
 arch/powerpc/boot/dts/mpc8541cds.dts           |   78 ++++++-----
 arch/powerpc/boot/dts/mpc8544ds.dts            |   81 ++++++------
 arch/powerpc/boot/dts/mpc8548cds.dts           |  156 ++++++++++++----------
 arch/powerpc/boot/dts/mpc8555cds.dts           |   78 ++++++-----
 arch/powerpc/boot/dts/mpc8560ads.dts           |  102 ++++++++-------
 arch/powerpc/boot/dts/mpc8568mds.dts           |  102 ++++++++-------
 arch/powerpc/boot/dts/mpc8572ds.dts            |  150 ++++++++++++----------
 arch/powerpc/boot/dts/mpc8572ds_36b.dts        |  150 ++++++++++++----------
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |   47 ++++---
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |   49 ++++++--
 arch/powerpc/boot/dts/sbc8548.dts              |   78 ++++++-----
 arch/powerpc/boot/dts/sbc8560.dts              |  100 ++++++++-------
 arch/powerpc/boot/dts/stx_gp3_8560.dts         |   78 ++++++-----
 arch/powerpc/boot/dts/tqm8540.dts              |  117 +++++++++--------
 arch/powerpc/boot/dts/tqm8541.dts              |   90 +++++++------
 arch/powerpc/boot/dts/tqm8548-bigflash.dts     |  168 +++++++++++++-----------
 arch/powerpc/boot/dts/tqm8548.dts              |  168 +++++++++++++-----------
 arch/powerpc/boot/dts/tqm8555.dts              |   90 +++++++------
 arch/powerpc/boot/dts/tqm8560.dts              |   90 +++++++------
 arch/powerpc/platforms/85xx/ksi8560.c          |    1 +
 arch/powerpc/platforms/85xx/mpc8536_ds.c       |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_ads.c      |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_cds.c      |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_ds.c       |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c      |    1 +
 arch/powerpc/platforms/85xx/sbc8548.c          |    1 +
 arch/powerpc/platforms/85xx/sbc8560.c          |    1 +
 arch/powerpc/platforms/85xx/stx_gp3.c          |    1 +
 arch/powerpc/platforms/85xx/tqm85xx.c          |    1 +
 32 files changed, 1229 insertions(+), 1027 deletions(-)

diff --git a/arch/powerpc/boot/dts/ksi8560.dts b/arch/powerpc/boot/dts/ksi8560.dts
index 3bfff47..308fe7c 100644
--- a/arch/powerpc/boot/dts/ksi8560.dts
+++ b/arch/powerpc/boot/dts/ksi8560.dts
@@ -124,67 +124,72 @@
 			};
 		};
 
-		mdio@24520 {					/* For TSECs */
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			PHY1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-
-			PHY2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
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
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			/* Mac address filled in by bootwrapper */
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&PHY1>;
+
+			mdio@520 {					/* For TSECs */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				PHY1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
+
+				PHY2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
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
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
 			/* Mac address filled in by bootwrapper */
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&PHY2>;
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
 
 		mpic: pic@40000 {
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index 3c905df..b31c504 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -137,42 +137,6 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 0x1>;
-				reg = <0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 0x1>;
-				reg = <1>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@26520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x26520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
 		usb@22000 {
 			compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
 			reg = <0x22000 0x1000>;
@@ -194,31 +158,73 @@
 		};
 
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 0x1>;
+					reg = <0>;
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 0x1>;
+					reg = <1>;
+					device_type = "ethernet-phy";
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet1: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
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
 
 		usb@2b000 {
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 79570ff..ddd67be 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -126,97 +126,106 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
-				reg = <0x0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <7 1>;
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
-		mdio@26520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x26520 0x20>;
-
-			tbi2: tbi-phy@11 {
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x0>;
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <7 1>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
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
 
 		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <2>;
 			device_type = "network";
 			model = "FEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <41 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy3>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 221036a..e45097f 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -126,66 +126,72 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
-				reg = <0x0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x0>;
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
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
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 0668d10..7c6932b 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -98,44 +98,6 @@
 			dfsrr;
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@26520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x26520 0x20>;
-
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-
 		dma@21300 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -178,31 +140,74 @@
 		};
 
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
 			tbi-handle = <&tbi0>;
 			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x0>;
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
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
 
 		enet1: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
 			tbi-handle = <&tbi1>;
 			phy-connection-type = "rgmii-id";
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
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index df774a7..804e903 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -142,129 +142,141 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
-				reg = <0x0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
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
-		mdio@26520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x26520 0x20>;
-
-			tbi2: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@27520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x27520 0x20>;
-
-			tbi3: tbi-phy@11 {
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x0>;
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
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
 
 /* eTSEC 3/4 are currently broken
 		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <2>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet3: ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <3>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x27000 0x1000>;
+			ranges = <0x0 0x27000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <37 2 38 2 39 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi3>;
 			phy-handle = <&phy3>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi3: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
  */
 
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 053b01e..9484f07 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -126,66 +126,72 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
-				reg = <0x0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x0>;
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
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
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 11b1bcb..cc2acf8 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -115,78 +115,84 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
-				reg = <0x0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 1>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <7 1>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <7 1>;
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
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x0>;
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <7 1>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <7 1>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
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
 
 		mpic: pic@40000 {
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 1955bd9..9d52e3b 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -149,78 +149,84 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@7 {
-				interrupt-parent = <&mpic>;
-				interrupts = <1 1>;
-				reg = <0x7>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <2 1>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <1 1>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <2 1>;
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
  			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@7 {
+					interrupt-parent = <&mpic>;
+					interrupts = <1 1>;
+					reg = <0x7>;
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <2 1>;
+					reg = <0x1>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <1 1>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <2 1>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
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
  			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy3>;
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
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 6c9354b..6e79a41 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -312,129 +312,141 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x0>;
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x1>;
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x2>;
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x3>;
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
-		mdio@26520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x26520 0x20>;
-
-			tbi2: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@27520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x27520 0x20>;
-
-			tbi3: tbi-phy@11 {
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x0>;
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x1>;
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x2>;
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x3>;
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
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
 
 		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <2>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet3: ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <3>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x27000 0x1000>;
+			ranges = <0x0 0x27000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <37 2 38 2 39 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi3>;
 			phy-handle = <&phy3>;
 			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi3: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8572ds_36b.dts b/arch/powerpc/boot/dts/mpc8572ds_36b.dts
index fc7dbf4..dbd81a7 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_36b.dts
@@ -312,129 +312,141 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x0>;
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x1>;
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x2>;
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x3>;
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
-		mdio@26520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x26520 0x20>;
-
-			tbi2: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@27520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x27520 0x20>;
-
-			tbi3: tbi-phy@11 {
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x0>;
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x1>;
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x2>;
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x3>;
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
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
 
 		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <2>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet3: ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <3>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x27000 0x1000>;
+			ranges = <0x0 0x27000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <37 2 38 2 39 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi3>;
 			phy-handle = <&phy3>;
 			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi3: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
index 32178bf..1c17960 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
@@ -148,35 +148,46 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x0>;
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x1>;
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x0>;
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x1>;
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					reg = <0x2>;
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					reg = <0x3>;
+				};
+			};
 		};
 
 		enet1: ethernet@25000 {
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
index 159cb3a..0b00da1 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
@@ -110,19 +110,46 @@
 			};
 		};
 
-		mdio@24520 {
+		enet0: ethernet@24000 {
 			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
+			status = "disabled on core1";
 
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				reg = <0x2>;
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				reg = <0x3>;
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x0>;
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x1>;
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					reg = <0x2>;
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					reg = <0x3>;
+				};
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index 2baf4a5..9c5079f 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -234,66 +234,72 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@19 {
-				interrupt-parent = <&mpic>;
-				interrupts = <0x6 0x1>;
-				reg = <0x19>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1a {
-				interrupt-parent = <&mpic>;
-				interrupts = <0x7 0x1>;
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
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@19 {
+					interrupt-parent = <&mpic>;
+					interrupts = <0x6 0x1>;
+					reg = <0x19>;
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@1a {
+					interrupt-parent = <&mpic>;
+					interrupts = <0x7 0x1>;
+					reg = <0x1a>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
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
diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
index 01542f7..b772405 100644
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -139,77 +139,83 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-			phy0: ethernet-phy@19 {
-				interrupt-parent = <&mpic>;
-				interrupts = <0x6 0x1>;
-				reg = <0x19>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1a {
-				interrupt-parent = <&mpic>;
-				interrupts = <0x7 0x1>;
-				reg = <0x1a>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@1b {
-				interrupt-parent = <&mpic>;
-				interrupts = <0x8 0x1>;
-				reg = <0x1b>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@1c {
-				interrupt-parent = <&mpic>;
-				interrupts = <0x8 0x1>;
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
 			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+				phy0: ethernet-phy@19 {
+					interrupt-parent = <&mpic>;
+					interrupts = <0x6 0x1>;
+					reg = <0x19>;
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@1a {
+					interrupt-parent = <&mpic>;
+					interrupts = <0x7 0x1>;
+					reg = <0x1a>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@1b {
+					interrupt-parent = <&mpic>;
+					interrupts = <0x8 0x1>;
+					reg = <0x1b>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@1c {
+					interrupt-parent = <&mpic>;
+					interrupts = <0x8 0x1>;
+					reg = <0x1c>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
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
 
 		mpic: pic@40000 {
diff --git a/arch/powerpc/boot/dts/stx_gp3_8560.dts b/arch/powerpc/boot/dts/stx_gp3_8560.dts
index fff33fe..8b17395 100644
--- a/arch/powerpc/boot/dts/stx_gp3_8560.dts
+++ b/arch/powerpc/boot/dts/stx_gp3_8560.dts
@@ -124,66 +124,72 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 4>;
-				reg = <2>;
-				device_type = "ethernet-phy";
-			};
-			phy4: ethernet-phy@4 {
-				interrupt-parent = <&mpic>;
-				interrupts = <5 4>;
-				reg = <4>;
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 4>;
+					reg = <2>;
+					device_type = "ethernet-phy";
+				};
+				phy4: ethernet-phy@4 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 4>;
+					reg = <4>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy4>;
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
 
 		mpic: pic@40000 {
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index 39e55ab..ac9413a 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -136,94 +136,103 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <1>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <3>;
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
-		mdio@26520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x26520 0x20>;
-
-			tbi2: tbi-phy@11 {
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy2>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <1>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <2>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <3>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
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
 
 		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <2>;
 			device_type = "network";
 			model = "FEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <41 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy3>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index 58ae8bc..c71bb5d 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -135,72 +135,78 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <1>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <3>;
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <1>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <2>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <3>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
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
diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index bff380a..28b1a95 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -148,134 +148,146 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy1: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <1>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <3>;
-				device_type = "ethernet-phy";
-			};
-			phy4: ethernet-phy@4 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <4>;
-				device_type = "ethernet-phy";
-			};
-			phy5: ethernet-phy@5 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <5>;
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
-		mdio@26520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x26520 0x20>;
-
-			tbi2: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@27520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x27520 0x20>;
-
-			tbi3: tbi-phy@11 {
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy1: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <1>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <2>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <3>;
+					device_type = "ethernet-phy";
+				};
+				phy4: ethernet-phy@4 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <4>;
+					device_type = "ethernet-phy";
+				};
+				phy5: ethernet-phy@5 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <5>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
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
 
 		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <2>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy3>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet3: ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <3>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x27000 0x1000>;
+			ranges = <0x0 0x27000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <37 2 38 2 39 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi3>;
 			phy-handle = <&phy4>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi3: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index 112ac90..826fb62 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -148,134 +148,146 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy1: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <1>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <3>;
-				device_type = "ethernet-phy";
-			};
-			phy4: ethernet-phy@4 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <4>;
-				device_type = "ethernet-phy";
-			};
-			phy5: ethernet-phy@5 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <5>;
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
-		mdio@26520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x26520 0x20>;
-
-			tbi2: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		mdio@27520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-tbi";
-			reg = <0x27520 0x20>;
-
-			tbi3: tbi-phy@11 {
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy1: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <1>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <2>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <3>;
+					device_type = "ethernet-phy";
+				};
+				phy4: ethernet-phy@4 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <4>;
+					device_type = "ethernet-phy";
+				};
+				phy5: ethernet-phy@5 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <5>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
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
 
 		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <2>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy3>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		enet3: ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <3>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x27000 0x1000>;
+			ranges = <0x0 0x27000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <37 2 38 2 39 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi3>;
 			phy-handle = <&phy4>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi3: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index 4b7da89..a133ded 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -135,72 +135,78 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <1>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <3>;
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <1>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <2>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <3>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
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
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index 3fa552f..649e2e5 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -137,72 +137,78 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <1>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <8 1>;
-				reg = <3>;
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
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <1>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <2>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <3>;
+					device_type = "ethernet-phy";
+				};
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
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
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
 
 		mpic: pic@40000 {
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index 66f2923..f4d36b5 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -219,6 +219,7 @@ static struct of_device_id __initdata of_bus_ids[] = {
 	{ .type = "simple-bus", },
 	{ .name = "cpm", },
 	{ .name = "localbus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 1bf5aef..63efca2 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -92,6 +92,7 @@ static struct of_device_id __initdata mpc8536_ds_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 21f0090..9438a89 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -226,6 +226,7 @@ static struct of_device_id __initdata of_bus_ids[] = {
 	{ .name = "cpm", },
 	{ .name = "localbus", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index aeb6a5b..0a9e491 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -336,6 +336,7 @@ static struct of_device_id __initdata of_bus_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 7326d90..de66de7 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -204,6 +204,7 @@ static struct of_device_id __initdata mpc85xxds_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 658a36f..7dd0290 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -265,6 +265,7 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .type = "qe", },
 	{ .compatible = "fsl,qe", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index 7ec77ce..ecdd8c0 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -154,6 +154,7 @@ static struct of_device_id __initdata of_bus_ids[] = {
 	{ .name = "soc", },
 	{ .type = "soc", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index 472f254..cc27807 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -213,6 +213,7 @@ static struct of_device_id __initdata of_bus_ids[] = {
 	{ .name = "cpm", },
 	{ .name = "localbus", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index 0cca8f5..f559918 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -145,6 +145,7 @@ static void stx_gp3_show_cpuinfo(struct seq_file *m)
 
 static struct of_device_id __initdata of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 2933a8e..5b0ab99 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -153,6 +153,7 @@ static void tqm85xx_show_cpuinfo(struct seq_file *m)
 
 static struct of_device_id __initdata of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
-- 
1.5.6.5
