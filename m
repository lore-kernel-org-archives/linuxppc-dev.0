Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id 31E8D1A0B56
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 23:16:59 +1100 (AEDT)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>,
	Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [RFC PATCH v3 3/3] powerpc/86xx: Introduce and use common dtsi
Date: Wed,  2 Mar 2016 13:16:39 +0100
Message-Id: <1456920999-30282-3-git-send-email-alessio.bogani@elettra.eu>
In-Reply-To: <1456920999-30282-1-git-send-email-alessio.bogani@elettra.eu>
References: <1456920999-30282-1-git-send-email-alessio.bogani@elettra.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 arch/powerpc/boot/dts/fsl/gef_ppc9a.dts        | 258 +++------------------
 arch/powerpc/boot/dts/fsl/gef_sbc310.dts       | 246 +++-----------------
 arch/powerpc/boot/dts/fsl/gef_sbc610.dts       | 258 +++------------------
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts     | 300 ++++---------------------
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts | 298 ++++--------------------
 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi  | 120 ++++++++++
 arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi   |  58 +++++
 arch/powerpc/boot/dts/fsl/sbc8641d.dts         | 299 +++---------------------
 8 files changed, 394 insertions(+), 1443 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts b/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
index 7e4487b..0424fc2 100644
--- a/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
+++ b/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
@@ -18,62 +18,19 @@
  * Compiled with dtc -I dts -O dtb -o gef_ppc9a.dtb gef_ppc9a.dts
  */
 
-/dts-v1/;
+/include/ "mpc8641si-pre.dtsi"
 
 / {
 	model = "GEF_PPC9A";
 	compatible = "gef,ppc9a";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	interrupt-parent = <&mpic>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8641@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-		PowerPC,8641@1 {
-			device_type = "cpu";
-			reg = <1>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-	};
 
 	memory {
 		device_type = "memory";
 		reg = <0x0 0x40000000>;	// set by uboot
 	};
 
-	localbus@fef05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8641-localbus", "simple-bus";
+	lbc: localbus@fef05000 {
 		reg = <0xfef05000 0x1000>;
-		interrupts = <19 2 0 0>;
 
 		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
 			  1 0 0xe8000000 0x08000000	// Paged Flash 0
@@ -161,34 +118,10 @@
 		};
 	};
 
-	soc@fef00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "fsl,mpc8641-soc", "simple-bus";
+	soc: soc@fef00000 {
 		ranges = <0x0 0xfef00000 0x00100000>;
-		bus-frequency = <33333333>;
-
-		mcm-law@0 {
-			compatible = "fsl,mcm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		mcm@1000 {
-			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2 0 0>;
-		};
 
 		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2 0 0>;
-			dfsrr;
-
 			hwmon@48 {
 				compatible = "national,lm92";
 				reg = <0x48>;
@@ -210,192 +143,65 @@
 			};
 		};
 
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2 0 0>;
-			dfsrr;
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupts = <20 2 0 0>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupts = <21 2 0 0>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupts = <22 2 0 0>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupts = <23 2 0 0>;
-			};
-		};
-
 		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 0 0 30  2 0 0 34 2 0 0>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "gmii";
+		};
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&gef_pic>;
-					interrupts = <0x9 0x4>;
-					reg = <1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&gef_pic>;
-					interrupts = <0x8 0x4>;
-					reg = <3>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+		mdio@24520 {
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&gef_pic>;
+				interrupts = <0x9 0x4>;
+				reg = <1>;
+			};
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&gef_pic>;
+				interrupts = <0x8 0x4>;
+				reg = <3>;
+			};
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet1: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "gmii";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
 		};
 
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x2a 0x2 0 0>;
+		mdio@26520 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x1c 0x2 0 0>;
+		enet2: ethernet@25000 {
+			status = "disabled";
 		};
 
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <4>;
-			reg = <0x40000 0x40000>;
-			compatible = "fsl,mpic", "chrp,open-pic";
-			device_type = "open-pic";
+		mdio@25520 {
+			status = "disabled";
 		};
 
-		msi@41600 {
-			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0 0 0
-				0xe1 0 0 0
-				0xe2 0 0 0
-				0xe3 0 0 0
-				0xe4 0 0 0
-				0xe5 0 0 0
-				0xe6 0 0 0
-				0xe7 0 0 0>;
+		enet3: ethernet@27000 {
+			status = "disabled";
 		};
 
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
+		mdio@27520 {
+			status = "disabled";
 		};
 	};
 
 	pci0: pcie@fef08000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xfef08000 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
 			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
-		clock-frequency = <100000000>;
-		interrupts = <0x18 0x2 0 0>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1
-		>;
 
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0x80000000
 				  0x02000000 0x0 0x80000000
 				  0x0 0x40000000
@@ -406,3 +212,5 @@
 		};
 	};
 };
+
+/include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
index 1299011..84b3d38 100644
--- a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
@@ -18,63 +18,23 @@
  * Compiled with dtc -I dts -O dtb -o gef_sbc310.dtb gef_sbc310.dts
  */
 
-/dts-v1/;
+/include/ "mpc8641si-pre.dtsi"
 
 / {
 	model = "GEF_SBC310";
 	compatible = "gef,sbc310";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	interrupt-parent = <&mpic>;
 
 	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
 		pci1 = &pci1;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8641@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-		PowerPC,8641@1 {
-			device_type = "cpu";
-			reg = <1>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x0 0x40000000>;	// set by uboot
 	};
 
-	localbus@fef05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8641-localbus", "simple-bus";
+	lbc: localbus@fef05000 {
 		reg = <0xfef05000 0x1000>;
-		interrupts = <19 2 0 0>;
 
 		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
 			  1 0 0xe0000000 0x08000000	// Paged Flash 0
@@ -159,34 +119,10 @@
 		};
 	};
 
-	soc@fef00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "fsl,mpc8641-soc", "simple-bus";
+	soc: soc@fef00000 {
 		ranges = <0x0 0xfef00000 0x00100000>;
-		bus-frequency = <33333333>;
-
-		mcm-law@0 {
-			compatible = "fsl,mcm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		mcm@1000 {
-			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2 0 0>;
-		};
 
 		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2 0 0>;
-			dfsrr;
-
 			rtc@51 {
 				compatible = "epson,rx8581";
 				reg = <0x00000051>;
@@ -194,13 +130,6 @@
 		};
 
 		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2 0 0>;
-			dfsrr;
-
 			hwmon@48 {
 				compatible = "national,lm92";
 				reg = <0x48>;
@@ -217,170 +146,63 @@
 			};
 		};
 
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupts = <20 2 0 0>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupts = <21 2 0 0>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupts = <22 2 0 0>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupts = <23 2 0 0>;
-			};
-		};
-
 		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 0 0 30  2 0 0 34 2 0 0>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "gmii";
+		};
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&gef_pic>;
-					interrupts = <0x9 0x4>;
-					reg = <1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&gef_pic>;
-					interrupts = <0x8 0x4>;
-					reg = <3>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+		mdio@24520 {
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&gef_pic>;
+				interrupts = <0x9 0x4>;
+				reg = <1>;
+			};
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&gef_pic>;
+				interrupts = <0x8 0x4>;
+				reg = <3>;
+			};
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet1: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "gmii";
+		};
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+		mdio@26520 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x2a 0x2 0 0>;
+		enet2: ethernet@25000 {
+			status = "disabled";
 		};
 
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x1c 0x2 0 0>;
+		mdio@25520 {
+			status = "disabled";
 		};
 
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <4>;
-			reg = <0x40000 0x40000>;
-			compatible = "fsl,mpic", "chrp,open-pic";
-			device_type = "open-pic";
+		enet3: ethernet@27000 {
+			status = "disabled";
 		};
 
-		msi@41600 {
-			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0 0 0
-				0xe1 0 0 0
-				0xe2 0 0 0
-				0xe3 0 0 0
-				0xe4 0 0 0
-				0xe5 0 0 0
-				0xe6 0 0 0
-				0xe7 0 0 0>;
-		};
-
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
+		mdio@27520 {
+			status = "disabled";
 		};
 	};
 
 	pci0: pcie@fef08000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xfef08000 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
 			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
-		clock-frequency = <100000000>;
-		interrupts = <0x18 0x2 0 0>;
 		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
 		interrupt-map = <
 			0x0000 0x0 0x0 0x1 &mpic 0x0 0x2
@@ -390,10 +212,6 @@
 		>;
 
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0x80000000
 				  0x02000000 0x0 0x80000000
 				  0x0 0x40000000
@@ -438,3 +256,5 @@
 		};
 	};
 };
+
+/include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc610.dts b/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
index 3a1f438..974446a 100644
--- a/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
@@ -18,62 +18,19 @@
  * Compiled with dtc -I dts -O dtb -o gef_sbc610.dtb gef_sbc610.dts
  */
 
-/dts-v1/;
+/include/ "mpc8641si-pre.dtsi"
 
 / {
 	model = "GEF_SBC610";
 	compatible = "gef,sbc610";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	interrupt-parent = <&mpic>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8641@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-		PowerPC,8641@1 {
-			device_type = "cpu";
-			reg = <1>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-	};
 
 	memory {
 		device_type = "memory";
 		reg = <0x0 0x40000000>;	// set by uboot
 	};
 
-	localbus@fef05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8641-localbus", "simple-bus";
+	lbc: localbus@fef05000 {
 		reg = <0xfef05000 0x1000>;
-		interrupts = <19 2 0 0>;
 
 		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
 			  1 0 0xe8000000 0x08000000	// Paged Flash 0
@@ -159,34 +116,10 @@
 		};
 	};
 
-	soc@fef00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
+	soc: soc@fef00000 {
 		ranges = <0x0 0xfef00000 0x00100000>;
-		bus-frequency = <33333333>;
-
-		mcm-law@0 {
-			compatible = "fsl,mcm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		mcm@1000 {
-			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2 0 0>;
-		};
 
 		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2 0 0>;
-			dfsrr;
-
 			hwmon@48 {
 				compatible = "national,lm92";
 				reg = <0x48>;
@@ -208,192 +141,65 @@
 			};
 		};
 
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2 0 0>;
-			dfsrr;
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupts = <20 2 0 0>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupts = <21 2 0 0>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupts = <22 2 0 0>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupts = <23 2 0 0>;
-			};
-		};
-
 		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
 			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "gmii";
+		};
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&gef_pic>;
-					interrupts = <0x9 0x4>;
-					reg = <1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&gef_pic>;
-					interrupts = <0x8 0x4>;
-					reg = <3>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+		mdio@24520 {
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&gef_pic>;
+				interrupts = <0x9 0x4>;
+				reg = <1>;
+			};
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&gef_pic>;
+				interrupts = <0x8 0x4>;
+				reg = <3>;
+			};
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet1: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "gmii";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
 		};
 
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x2a 0x2 0 0>;
+		mdio@26520 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x1c 0x2 0 0>;
+		enet2: ethernet@25000 {
+			status = "disabled";
 		};
 
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <4>;
-			reg = <0x40000 0x40000>;
-			compatible = "fsl,mpic", "chrp,open-pic";
-			device_type = "open-pic";
+		mdio@25520 {
+			status = "disabled";
 		};
 
-		msi@41600 {
-			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0 0 0
-				0xe1 0 0 0
-				0xe2 0 0 0
-				0xe3 0 0 0
-				0xe4 0 0 0
-				0xe5 0 0 0
-				0xe6 0 0 0
-				0xe7 0 0 0>;
+		enet3: ethernet@27000 {
+			status = "disabled";
 		};
 
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
+		mdio@27520 {
+			status = "disabled";
 		};
 	};
 
 	pci0: pcie@fef08000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xfef08000 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
 			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
-		clock-frequency = <100000000>;
-		interrupts = <0x18 0x2 0 0>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1
-		>;
 
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0x80000000
 				  0x02000000 0x0 0x80000000
 				  0x0 0x40000000
@@ -404,3 +210,5 @@
 		};
 	};
 };
+
+/include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
index 03ef3f7..554001f 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
@@ -9,65 +9,23 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "mpc8641si-pre.dtsi"
 
 / {
 	model = "MPC8641HPCN";
 	compatible = "fsl,mpc8641hpcn";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	interrupt-parent = <&mpic>;
 
 	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		ethernet3 = &enet3;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
 		pci1 = &pci1;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8641@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <32>;
-			i-cache-line-size = <32>;
-			d-cache-size = <32768>;		// L1
-			i-cache-size = <32768>;		// L1
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-		PowerPC,8641@1 {
-			device_type = "cpu";
-			reg = <1>;
-			d-cache-line-size = <32>;
-			i-cache-line-size = <32>;
-			d-cache-size = <32768>;
-			i-cache-size = <32768>;
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x00000000 0x40000000>;	// 1G at 0x0
 	};
 
-	localbus@ffe05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8641-localbus", "simple-bus";
+	lbc: localbus@ffe05000 {
 		reg = <0xffe05000 0x1000>;
-		interrupts = <19 2 0 0>;
 
 		ranges = <0 0 0xef800000 0x00800000
 			  2 0 0xffdf8000 0x00008000
@@ -101,236 +59,75 @@
 		};
 	};
 
-	soc8641@ffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
+	soc: soc8641@ffe00000 {
 		ranges = <0x00000000 0xffe00000 0x00100000>;
-		bus-frequency = <0>;
-
-		mcm-law@0 {
-			compatible = "fsl,mcm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		mcm@1000 {
-			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2 0 0>;
-		};
 
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2 0 0>;
-			dfsrr;
-		};
-
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2 0 0>;
-			dfsrr;
+		enet0: ethernet@24000 {
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
 		};
 
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupts = <20 2 0 0>;
+		mdio@24520 {
+			phy0: ethernet-phy@0 {
+				interrupts = <10 1 0 0>;
+				reg = <0>;
 			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupts = <21 2 0 0>;
+			phy1: ethernet-phy@1 {
+				interrupts = <10 1 0 0>;
+				reg = <1>;
 			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupts = <22 2 0 0>;
+			phy2: ethernet-phy@2 {
+				interrupts = <10 1 0 0>;
+				reg = <2>;
 			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupts = <23 2 0 0>;
+			phy3: ethernet-phy@3 {
+				interrupts = <10 1 0 0>;
+				reg = <3>;
 			};
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 0 0 30  2 0 0 34 2 0 0>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupts = <10 1 0 0>;
-					reg = <0>;
-				};
-				phy1: ethernet-phy@1 {
-					interrupts = <10 1 0 0>;
-					reg = <1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupts = <10 1 0 0>;
-					reg = <2>;
-				};
-				phy3: ethernet-phy@3 {
-					interrupts = <10 1 0 0>;
-					reg = <3>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
+		};
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi1: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+		mdio@25520 {
+			tbi1: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 		
 		enet2: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "rgmii-id";
+		};
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+		mdio@26520 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet3: ethernet@27000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <3>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x27000 0x1000>;
-			ranges = <0x0 0x27000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <37 2 0 0 38 2 0 0 39 2 0 0>;
 			tbi-handle = <&tbi3>;
 			phy-handle = <&phy3>;
 			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi3: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
 		};
 
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2 0 0>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <28 2 0 0>;
-		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <4>;
-			reg = <0x40000 0x40000>;
-			compatible = "fsl,mpic", "chrp,open-pic";
-			device_type = "open-pic";
+		mdio@27520 {
+			tbi3: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 
 		rmu: rmu@d3000 {
@@ -358,7 +155,7 @@
 				compatible = "fsl,srio-dbell-unit";
 				reg = <0x400 0x80>;
 				interrupts = <
-					49 2 0 0 /* bell_outb_irq */
+					49 2 0 0  /* bell_outb_irq */
 					50 2 0 0>;/* bell_inb_irq */
 			};
 			port-write-unit@4e0 {
@@ -367,25 +164,12 @@
 				interrupts = <48 2 0 0>;
 			};
 		};
-
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
 	};
 
 	pci0: pcie@ffe08000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xffe08000 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xffc00000 0x0 0x00010000>;
-		clock-frequency = <100000000>;
-		interrupts = <24 2 0 0>;
 		interrupt-map-mask = <0xff00 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x11 func 0 - PCI slot 1 */
@@ -503,10 +287,6 @@
 			>;
 
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0x80000000
 				  0x02000000 0x0 0x80000000
 				  0x0 0x20000000
@@ -636,3 +416,5 @@
 */
 
 };
+
+/include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
index 0a2c21f..fec5867 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
@@ -9,65 +9,25 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "mpc8641si-pre.dtsi"
 
 / {
 	model = "MPC8641HPCN";
 	compatible = "fsl,mpc8641hpcn";
 	#address-cells = <2>;
 	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
 
 	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		ethernet3 = &enet3;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
 		pci1 = &pci1;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8641@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// 33 MHz, from uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-		PowerPC,8641@1 {
-			device_type = "cpu";
-			reg = <1>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// 33 MHz, from uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x0 0x00000000 0x0 0x40000000>;	// 1G at 0x0
 	};
 
-	localbus@fffe05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8641-localbus", "simple-bus";
+	lbc: localbus@fffe05000 {
 		reg = <0x0f 0xffe05000 0x0 0x1000>;
-		interrupts = <19 2 0 0>;
 
 		ranges = <0 0 0xf 0xef800000 0x00800000
 			  2 0 0xf 0xffdf8000 0x00008000
@@ -101,257 +61,82 @@
 		};
 	};
 
-	soc8641@fffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
+	soc: soc8641@fffe00000 {
 		ranges = <0x00000000 0x0f 0xffe00000 0x00100000>;
-		bus-frequency = <0>;
 
-		mcm-law@0 {
-			compatible = "fsl,mcm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		mcm@1000 {
-			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2 0 0>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2 0 0>;
-			dfsrr;
-		};
-
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2 0 0>;
-			dfsrr;
+		enet0: ethernet@24000 {
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
 		};
 
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupts = <20 2 0 0>;
+		mdio@24520 {
+			phy0: ethernet-phy@0 {
+				interrupts = <10 1 0 0>;
+				reg = <0>;
 			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupts = <21 2 0 0>;
+			phy1: ethernet-phy@1 {
+				interrupts = <10 1 0 0>;
+				reg = <1>;
 			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupts = <22 2 0 0>;
+			phy2: ethernet-phy@2 {
+				interrupts = <10 1 0 0>;
+				reg = <2>;
 			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupts = <23 2 0 0>;
+			phy3: ethernet-phy@3 {
+				interrupts = <10 1 0 0>;
+				reg = <3>;
 			};
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupts = <10 1 0 0>;
-					reg = <0>;
-				};
-				phy1: ethernet-phy@1 {
-					interrupts = <10 1 0 0>;
-					reg = <1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupts = <10 1 0 0>;
-					reg = <2>;
-				};
-				phy3: ethernet-phy@3 {
-					interrupts = <10 1 0 0>;
-					reg = <3>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
+		};
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi1: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+		mdio@25520 {
+			tbi1: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet2: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "rgmii-id";
+		};
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+		mdio@26520 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet3: ethernet@27000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <3>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x27000 0x1000>;
-			ranges = <0x0 0x27000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <37 2 0 0 38 2 0 0 39 2 0 0>;
 			tbi-handle = <&tbi3>;
 			phy-handle = <&phy3>;
 			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi3: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2 0 0>;
 		};
 
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <28 2 0 0>;
-		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <4>;
-			reg = <0x40000 0x40000>;
-			compatible = "fsl,mpic", "chrp,open-pic";
-			device_type = "open-pic";
-		};
-
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
+		mdio@27520 {
+			tbi3: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 	};
 
 	pci0: pcie@fffe08000 {
-		cell-index = <0>;
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0x0f 0xffe08000 0x0 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0xe0000000 0x0c 0x00000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0x0f 0xffc00000 0x0 0x00010000>;
-		clock-frequency = <100000000>;
-		interrupts = <24 2 0 0>;
 		interrupt-map-mask = <0xff00 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x11 func 0 - PCI slot 1 */
@@ -469,10 +254,6 @@
 			>;
 
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0xe0000000
 				  0x02000000 0x0 0xe0000000
 				  0x0 0x20000000
@@ -545,7 +326,6 @@
 	};
 
 	pci1: pcie@fffe09000 {
-		cell-index = <1>;
 		compatible = "fsl,mpc8641-pcie";
 		device_type = "pci";
 		#size-cells = <2>;
@@ -579,3 +359,5 @@
 		};
 	};
 };
+
+/include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
new file mode 100644
index 0000000..70889d8
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
@@ -0,0 +1,120 @@
+/*
+ * MPC8641 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2016 Elettra-Sincrotrone Trieste S.C.p.A.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+&lbc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	compatible = "fsl,mpc8641-localbus", "simple-bus";
+	interrupts = <19 2 0 0>;
+};
+
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "soc";
+	compatible = "fsl,mpc8641-soc", "simple-bus";
+	bus-frequency = <0>;
+
+	mcm-law@0 {
+		compatible = "fsl,mcm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <10>;
+	};
+
+	mcm@1000 {
+		compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+		reg = <0x1000 0x1000>;
+		interrupts = <17 2 0 0>;
+	};
+
+/include/ "pq3-i2c-0.dtsi"
+/include/ "pq3-i2c-1.dtsi"
+/include/ "pq3-duart-0.dtsi"
+	serial@4600 {
+		interrupts = <28 2 0 0>;
+	};
+/include/ "pq3-dma-0.dtsi"
+	dma@21300 {
+		compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
+	};
+	dma-channel@0 {
+		compatible = "fsl,mpc8641-dma-channel", "fsl,eloplus-dma-channel";
+	};
+	dma-channel@80 {
+		compatible = "fsl,mpc8641-dma-channel", "fsl,eloplus-dma-channel";
+	};
+	dma-channel@100 {
+		compatible = "fsl,mpc8641-dma-channel", "fsl,eloplus-dma-channel";
+	};
+	dma-channel@180 {
+		compatible = "fsl,mpc8641-dma-channel", "fsl,eloplus-dma-channel";
+	};
+
+/include/ "pq3-etsec1-0.dtsi"
+	ethernet@24000 {
+		model = "TSEC";
+	};
+/include/ "pq3-etsec1-1.dtsi"
+	ethernet@25000 {
+		model = "TSEC";
+	};
+/include/ "pq3-etsec1-2.dtsi"
+	ethernet@26000 {
+		model = "TSEC";
+	};
+/include/ "pq3-etsec1-3.dtsi"
+	ethernet@27000 {
+		model = "TSEC";
+	};
+
+/include/ "qoriq-mpic.dtsi"
+	msi@41600 {
+		compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
+	};
+	msi@41800 {
+		compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
+	};
+	msi@41a00 {
+		compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
+	};
+
+	global-utilities@e0000 {
+		compatible = "fsl,mpc8641-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+};
+
+&pci0 {
+	compatible = "fsl,mpc8641-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	clock-frequency = <100000000>;
+	interrupts = <24 2 0 0>;
+	interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+
+	interrupt-map = <
+		0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
+		0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
+		0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
+		0x0000 0x0 0x0 0x4 &mpic 0x3 0x1
+		>;
+
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi
new file mode 100644
index 0000000..9e03328
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi
@@ -0,0 +1,58 @@
+/*
+ * MPC8641 Silicon/SoC Device Tree Source (pre include)
+ *
+ * Copyright 2016 Elettra-Sincrotrone Trieste S.C.p.A.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&mpic>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8641@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+
+		PowerPC,8641@1 {
+			device_type = "cpu";
+			reg = <1>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/sbc8641d.dts b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
index 47c83a0..0a9733c 100644
--- a/arch/powerpc/boot/dts/fsl/sbc8641d.dts
+++ b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
@@ -13,65 +13,23 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "mpc8641si-pre.dtsi"
 
 / {
 	model = "SBC8641D";
 	compatible = "wind,sbc8641";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	interrupt-parent = <&mpic>;
 
 	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		ethernet3 = &enet3;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
 		pci1 = &pci1;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8641@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <32>;
-			i-cache-line-size = <32>;
-			d-cache-size = <32768>;		// L1
-			i-cache-size = <32768>;		// L1
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-		PowerPC,8641@1 {
-			device_type = "cpu";
-			reg = <1>;
-			d-cache-line-size = <32>;
-			i-cache-line-size = <32>;
-			d-cache-size = <32768>;
-			i-cache-size = <32768>;
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>;	// 512M at 0x0
 	};
 
-	localbus@f8005000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8641-localbus", "simple-bus";
+	lbc: localbus@f8005000 {
 		reg = <0xf8005000 0x1000>;
-		interrupts = <19 2 0 0>;
 
 		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
 			  1 0 0xf0000000 0x00010000	// 64KB EEPROM
@@ -120,268 +78,81 @@
 		};
 	};
 
-	soc@f8000000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
+	soc: soc@f8000000 {
 		ranges = <0x00000000 0xf8000000 0x00100000>;
-		bus-frequency = <0>;
-
-		mcm-law@0 {
-			compatible = "fsl,mcm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		mcm@1000 {
-			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2 0 0>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2 0 0>;
-			dfsrr;
-		};
 
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2 0 0>;
-			dfsrr;
+		enet0: ethernet@24000 {
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
 		};
 
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupts = <20 2 0 0>;
+		mdio@24520 {
+			phy0: ethernet-phy@1f {
+				reg = <0x1f>;
 			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupts = <21 2 0 0>;
+			phy1: ethernet-phy@0 {
+				reg = <0>;
 			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupts = <22 2 0 0>;
+			phy2: ethernet-phy@1 {
+				reg = <1>;
 			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupts = <23 2 0 0>;
+			phy3: ethernet-phy@2 {
+				reg = <2>;
 			};
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 0 0 30  2 0 0 34 2 0 0>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@1f {
-					reg = <0x1f>;
-				};
-				phy1: ethernet-phy@0 {
-					reg = <0>;
-				};
-				phy2: ethernet-phy@1 {
-					reg = <1>;
-				};
-				phy3: ethernet-phy@2 {
-					reg = <2>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
 			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
+		};
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi1: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+		mdio@25520 {
+			tbi1: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet2: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "rgmii-id";
+		};
 
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
+		mdio@26520 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
 			};
 		};
 
 		enet3: ethernet@27000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <3>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x27000 0x1000>;
-			ranges = <0x0 0x27000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <37 2 0 0 38 2 0 0 39 2 0 0>;
 			tbi-handle = <&tbi3>;
 			phy-handle = <&phy3>;
 			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi3: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2 0 0>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <28 2 0 0>;
 		};
 
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <4>;
-			reg = <0x40000 0x40000>;
-			compatible = "fsl,mpic", "chrp,open-pic";
-			device_type = "open-pic";
-			big-endian;
-		};
-
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
+		mdio@27520 {
+			tbi3: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 	};
 
 	pci0: pcie@f8008000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xf8008000 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
-		clock-frequency = <100000000>;
-		interrupts = <24 2 0 0>;
 		interrupt-map-mask = <0xff00 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0x0000 0 0 1 &mpic 0 1
-			0x0000 0 0 2 &mpic 1 1
-			0x0000 0 0 3 &mpic 2 1
-			0x0000 0 0 4 &mpic 3 1
-			>;
 
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0x80000000
 				  0x02000000 0x0 0x80000000
 				  0x0 0x20000000
@@ -428,3 +199,5 @@
 		};
 	};
 };
+
+/include/ "mpc8641si-post.dtsi"
-- 
2.7.2
