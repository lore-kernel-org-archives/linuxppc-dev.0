Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 28DA1DDF1E
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 07:00:50 +1100 (EST)
Date: Wed, 18 Mar 2009 23:00:48 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v3 4/4] powerpc/86xx: Move gianfar mdio nodes under the
	ethernet nodes
Message-ID: <20090318200048.GD8182@oksana.dev.rtsoft.ru>
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
Suggested-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/gef_sbc310.dts       |   39 ++++---
 arch/powerpc/boot/dts/gef_sbc610.dts       |   39 ++++---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |  157 +++++++++++++++-------------
 arch/powerpc/boot/dts/sbc8641d.dts         |  156 +++++++++++++++-------------
 arch/powerpc/platforms/86xx/gef_sbc310.c   |    1 +
 arch/powerpc/platforms/86xx/gef_sbc610.c   |    1 +
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    1 +
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 +
 arch/powerpc/platforms/86xx/sbc8641d.c     |    1 +
 9 files changed, 215 insertions(+), 181 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/gef_sbc310.dts
index 09eeb43..1569117 100644
--- a/arch/powerpc/boot/dts/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/gef_sbc310.dts
@@ -247,34 +247,37 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&gef_pic>;
-				interrupts = <0x9 0x4>;
-				reg = <1>;
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&gef_pic>;
-				interrupts = <0x8 0x4>;
-				reg = <3>;
-			};
-		};
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "gmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&gef_pic>;
+					interrupts = <0x9 0x4>;
+					reg = <1>;
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&gef_pic>;
+					interrupts = <0x8 0x4>;
+					reg = <3>;
+				};
+			};
 		};
 
 		enet1: ethernet@26000 {
diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index 714175c..6582dbd 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -202,34 +202,37 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@0 {
-				interrupt-parent = <&gef_pic>;
-				interrupts = <0x9 0x4>;
-				reg = <1>;
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&gef_pic>;
-				interrupts = <0x8 0x4>;
-				reg = <3>;
-			};
-		};
-
 		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			device_type = "network";
 			model = "eTSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "gmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&gef_pic>;
+					interrupts = <0x9 0x4>;
+					reg = <1>;
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&gef_pic>;
+					interrupts = <0x8 0x4>;
+					reg = <3>;
+				};
+			};
 		};
 
 		enet1: ethernet@26000 {
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 4481532..d72beb1 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -180,133 +180,144 @@
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
-				reg = <0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <1>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
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
 			interrupts = <29 2 30  2 34 2>;
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
+					reg = <0>;
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <1>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <2>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
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
 			model = "TSEC";
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
 			model = "TSEC";
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
diff --git a/arch/powerpc/boot/dts/sbc8641d.dts b/arch/powerpc/boot/dts/sbc8641d.dts
index 36db981..e3e914e 100644
--- a/arch/powerpc/boot/dts/sbc8641d.dts
+++ b/arch/powerpc/boot/dts/sbc8641d.dts
@@ -192,132 +192,144 @@
 			};
 		};
 
-		mdio@24520 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl,gianfar-mdio";
-			reg = <0x24520 0x20>;
-
-			phy0: ethernet-phy@1f {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0x1f>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <0>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@1 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <1>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <10 1>;
-				reg = <2>;
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
 			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <29 2 30  2 34 2>;
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
+				phy0: ethernet-phy@1f {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0x1f>;
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <1>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <2>;
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
 			model = "TSEC";
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
 			model = "TSEC";
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
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index 0f20172..5dd0ad6 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -201,6 +201,7 @@ static long __init mpc86xx_time_init(void)
 
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index d6b772b..ea23606 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -194,6 +194,7 @@ static long __init mpc86xx_time_init(void)
 
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index e8d54ac..3f49a6f 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -46,6 +46,7 @@ static unsigned char *pixis_bdcfg0, *pixis_arch;
 static struct of_device_id __initdata mpc8610_ids[] = {
 	{ .compatible = "fsl,mpc8610-immr", },
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{}
 };
 
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 27e0e68..c4ec49b 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -148,6 +148,7 @@ mpc86xx_time_init(void)
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "fsl,rapidio-delta", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
index 5fd7ed4..2886a36 100644
--- a/arch/powerpc/platforms/86xx/sbc8641d.c
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -103,6 +103,7 @@ mpc86xx_time_init(void)
 
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
 	{},
 };
 
-- 
1.5.6.5
