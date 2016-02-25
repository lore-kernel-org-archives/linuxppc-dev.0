Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id 6CE2F1A034F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 21:57:25 +1100 (AEDT)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>,
	Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [RFC PATCH v1 2/2] powerpc/86xx: Introduce and use common dtsi
Date: Thu, 25 Feb 2016 11:57:05 +0100
Message-Id: <1456397825-1786-2-git-send-email-alessio.bogani@elettra.eu>
In-Reply-To: <1456397825-1786-1-git-send-email-alessio.bogani@elettra.eu>
References: <1456397825-1786-1-git-send-email-alessio.bogani@elettra.eu>
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
 arch/powerpc/boot/dts/fsl/gef_ppc9a.dts        | 284 +++-------------------
 arch/powerpc/boot/dts/fsl/gef_sbc310.dts       | 276 +++------------------
 arch/powerpc/boot/dts/fsl/gef_sbc610.dts       | 284 +++-------------------
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts     | 318 ++++---------------------
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts | 317 ++++--------------------
 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi  | 124 ++++++++++
 arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi   |  59 +++++
 arch/powerpc/boot/dts/fsl/sbc8641d.dts         | 314 +++---------------------
 8 files changed, 400 insertions(+), 1576 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts b/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
index 83eb0fd..0c11623 100644
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
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
 
 		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
 			  1 0 0xe8000000 0x08000000	// Paged Flash 0
@@ -133,7 +90,7 @@
 			compatible = "gef,ppc9a-fpga-wdt", "gef,fpga-wdt-1.00",
 				"gef,fpga-wdt";
 			reg = <0x4 0x2000 0x8>;
-			interrupts = <0x1a 0x4>;
+			interrupts = <0x1a 0x4 0 0>;
 			interrupt-parent = <&gef_pic>;
 		};
 		/* Second watchdog available, driver currently supports one.
@@ -141,7 +98,7 @@
 			compatible = "gef,ppc9a-fpga-wdt", "gef,fpga-wdt-1.00",
 				"gef,fpga-wdt";
 			reg = <0x4 0x2010 0x8>;
-			interrupts = <0x1b 0x4>;
+			interrupts = <0x1b 0x4 0 0>;
 			interrupt-parent = <&gef_pic>;
 		};
 		*/
@@ -150,10 +107,7 @@
 			interrupt-controller;
 			compatible = "gef,ppc9a-fpga-pic", "gef,fpga-pic-1.00";
 			reg = <0x4 0x4000 0x20>;
-			interrupts = <0x8
-				      0x9>;
-			interrupt-parent = <&mpic>;
-
+			interrupts = <0x8 0x9 0 0>;
 		};
 		gef_gpio: gpio@7,14000 {
 			#gpio-cells = <2>;
@@ -163,37 +117,10 @@
 		};
 	};
 
-	soc@fef00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#interrupt-cells = <2>;
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
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		i2c1: i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
 
+		i2c@3000 {
 			hwmon@48 {
 				compatible = "national,lm92";
 				reg = <0x48>;
@@ -215,204 +142,57 @@
 			};
 		};
 
-		i2c2: i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
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
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
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
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
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
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x2a 0x2>;
-			interrupt-parent = <&mpic>;
 		};
 
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x1c 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
+		mdio@26520 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 
-		msi@41600 {
-			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
+		enet2: ethernet@25000 {
+			status = "disabled";
 		};
 
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
+		enet3: ethernet@27000 {
+			status = "disabled";
 		};
 	};
 
 	pci0: pcie@fef08000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xfef08000 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
 			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <0x18 0x2>;
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
@@ -423,3 +203,5 @@
 		};
 	};
 };
+
+/include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
index d426dd3..1a03597 100644
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
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
 
 		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
 			  1 0 0xe0000000 0x08000000	// Paged Flash 0
@@ -131,7 +91,7 @@
 			compatible = "gef,sbc310-fpga-wdt", "gef,fpga-wdt-1.00",
 				"gef,fpga-wdt";
 			reg = <0x4 0x2000 0x8>;
-			interrupts = <0x1a 0x4>;
+			interrupts = <0x1a 0x4 0 0>;
 			interrupt-parent = <&gef_pic>;
 		};
 /*
@@ -139,7 +99,7 @@
 			compatible = "gef,sbc310-fpga-wdt", "gef,fpga-wdt-1.00",
 				"gef,fpga-wdt";
 			reg = <0x4 0x2010 0x8>;
-			interrupts = <0x1b 0x4>;
+			interrupts = <0x1b 0x4 0 0>;
 			interrupt-parent = <&gef_pic>;
 		};
 */
@@ -148,10 +108,7 @@
 			interrupt-controller;
 			compatible = "gef,sbc310-fpga-pic", "gef,fpga-pic";
 			reg = <0x4 0x4000 0x20>;
-			interrupts = <0x8
-				      0x9>;
-			interrupt-parent = <&mpic>;
-
+			interrupts = <0x8 0x9 0 0>;
 		};
 		gef_gpio: gpio@4,8000 {
 			#gpio-cells = <2>;
@@ -161,52 +118,17 @@
 		};
 	};
 
-	soc@fef00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#interrupt-cells = <2>;
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
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		i2c1: i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
 
+		i2c@3000 {
 			rtc@51 {
 				compatible = "epson,rx8581";
 				reg = <0x00000051>;
 			};
 		};
 
-		i2c2: i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-
+		i2c@3100 {
 			hwmon@48 {
 				compatible = "national,lm92";
 				reg = <0x48>;
@@ -223,182 +145,57 @@
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
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
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
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <0x2a 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x1c 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
+		mdio@26520 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 
-		msi@41600 {
-			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
+		enet2: ethernet@25000 {
+			status = "disabled";
 		};
 
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
+		enet3: ethernet@27000 {
+			status = "disabled";
 		};
 	};
 
 	pci0: pcie@fef08000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xfef08000 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
 			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <0x18 0x2>;
 		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
+
 		interrupt-map = <
 			0x0000 0x0 0x0 0x1 &mpic 0x0 0x2
 			0x0000 0x0 0x0 0x2 &mpic 0x1 0x2
@@ -407,10 +204,6 @@
 		>;
 
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0x80000000
 				  0x02000000 0x0 0x80000000
 				  0x0 0x40000000
@@ -432,7 +225,6 @@
 		ranges = <0x02000000 0x0 0xc0000000 0xc0000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xfe400000 0x0 0x00400000>;
 		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
 		interrupts = <0x19 0x2>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
@@ -457,3 +249,5 @@
 		};
 	};
 };
+
+/include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc610.dts b/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
index 5db3399..621e3cc 100644
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
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
 
 		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
 			  1 0 0xe8000000 0x08000000	// Paged Flash 0
@@ -132,14 +89,14 @@
 		wdt@4,2000 {
 			compatible = "gef,fpga-wdt";
 			reg = <0x4 0x2000 0x8>;
-			interrupts = <0x1a 0x4>;
+			interrupts = <0x1a 0x4 0 0>;
 			interrupt-parent = <&gef_pic>;
 		};
 		/* Second watchdog available, driver currently supports one.
 		wdt@4,2010 {
 			compatible = "gef,fpga-wdt";
 			reg = <0x4 0x2010 0x8>;
-			interrupts = <0x1b 0x4>;
+			interrupts = <0x1b 0x4 0 0>;
 			interrupt-parent = <&gef_pic>;
 		};
 		*/
@@ -148,10 +105,7 @@
 			interrupt-controller;
 			compatible = "gef,fpga-pic";
 			reg = <0x4 0x4000 0x20>;
-			interrupts = <0x8
-				      0x9>;
-			interrupt-parent = <&mpic>;
-
+			interrupts = <0x8 0x9 0 0>;
 		};
 		gef_gpio: gpio@7,14000 {
 			#gpio-cells = <2>;
@@ -161,37 +115,10 @@
 		};
 	};
 
-	soc@fef00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#interrupt-cells = <2>;
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
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		i2c1: i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
 
+		i2c@3000 {
 			hwmon@48 {
 				compatible = "national,lm92";
 				reg = <0x48>;
@@ -213,204 +140,57 @@
 			};
 		};
 
-		i2c2: i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
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
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
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
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
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
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x2a 0x2>;
-			interrupt-parent = <&mpic>;
 		};
 
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x1c 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
+		mdio@26520 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 
-		msi@41600 {
-			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
+		enet2: ethernet@25000 {
+			status = "disabled";
 		};
 
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
+		enet3: ethernet@27000 {
+			status = "disabled";
 		};
 	};
 
 	pci0: pcie@fef08000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xfef08000 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
 			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <0x18 0x2>;
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
@@ -421,3 +201,5 @@
 		};
 	};
 };
+
+/include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
index 1c03060..c28cdaa 100644
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
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
 
 		ranges = <0 0 0xef800000 0x00800000
 			  2 0 0xffdf8000 0x00008000
@@ -101,253 +59,75 @@
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
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
 
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
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
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
+		mdio@24520 {
+			phy0: ethernet-phy@0 {
+				interrupts = <10 1>;
+				reg = <0>;
 			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+			phy1: ethernet-phy@1 {
+				interrupts = <10 1>;
+				reg = <1>;
 			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
+			phy2: ethernet-phy@2 {
+				interrupts = <10 1>;
+				reg = <2>;
 			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
+			phy3: ethernet-phy@3 {
+				interrupts = <10 1>;
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
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
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
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0>;
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <2>;
-				};
-				phy3: ethernet-phy@3 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
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
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <37 2 38 2 39 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
 		};
 
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <28 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
+		mdio@27520 {
+			tbi3: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
 		};
 
 		rmu: rmu@d3000 {
@@ -384,27 +164,12 @@
 				interrupts = <48 2>;
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
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xffe08000 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xffc00000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
 		interrupt-map-mask = <0xff00 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x11 func 0 - PCI slot 1 */
@@ -522,10 +287,6 @@
 			>;
 
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0x80000000
 				  0x02000000 0x0 0x80000000
 				  0x0 0x20000000
@@ -611,7 +372,6 @@
 		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xffc10000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
 		interrupts = <25 2>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
@@ -661,3 +421,5 @@
 */
 
 };
+
+/include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
index bb575e2..dc7f7b3 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
@@ -9,7 +9,7 @@
  * option) any later version.
  */
 
-/dts-v1/;
+/include/ "mpc8641si-pre.dtsi"
 
 / {
 	model = "MPC8641HPCN";
@@ -18,56 +18,16 @@
 	#size-cells = <2>;
 
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
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
 
 		ranges = <0 0 0xf 0xef800000 0x00800000
 			  2 0 0xf 0xffdf8000 0x00008000
@@ -101,276 +61,82 @@
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
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
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
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
+		mdio@24520 {
+			phy0: ethernet-phy@0 {
+				interrupts = <10 1>;
+				reg = <0>;
 			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+			phy1: ethernet-phy@1 {
+				interrupts = <10 1>;
+				reg = <1>;
 			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
+			phy2: ethernet-phy@2 {
+				interrupts = <10 1>;
+				reg = <2>;
 			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
+			phy3: ethernet-phy@3 {
+				interrupts = <10 1>;
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
-			interrupts = <29 2 30 2 34 2>;
-			interrupt-parent = <&mpic>;
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
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0>;
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <2>;
-				};
-				phy3: ethernet-phy@3 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
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
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <37 2 38 2 39 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
 		};
 
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <28 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
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
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0x0f 0xffe08000 0x0 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0xe0000000 0x0c 0x00000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0x0f 0xffc00000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
 		interrupt-map-mask = <0xff00 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x11 func 0 - PCI slot 1 */
@@ -488,10 +254,6 @@
 			>;
 
 		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x02000000 0x0 0xe0000000
 				  0x02000000 0x0 0xe0000000
 				  0x0 0x20000000
@@ -578,7 +340,6 @@
 		ranges = <0x02000000 0x0 0xe0000000 0x0c 0x20000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0x0f 0xffc10000 0x0 0x00010000>;
 		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
 		interrupts = <25 2>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
@@ -603,3 +364,5 @@
 		};
 	};
 };
+
+/include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
new file mode 100644
index 0000000..45cf280
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
@@ -0,0 +1,124 @@
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
+	pic@40000 {
+		compatible = "chrp,open-pic";
+	};
+
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
+	clock-frequency = <33333333>;
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
index 0000000..026fa58
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi
@@ -0,0 +1,59 @@
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
+	compatible = "fsl,MPC8641";
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
index 68f0ed7..360c0e6 100644
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
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
 
 		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
 			  1 0 0xf0000000 0x00010000	// 64KB EEPROM
@@ -120,283 +78,82 @@
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
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
 
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
+		enet0: ethernet@24000 {
 			interrupt-parent = <&mpic>;
-			dfsrr;
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
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
+		mdio@24520 {
+			phy0: ethernet-phy@1f {
+				reg = <0x1f>;
 			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
+			phy1: ethernet-phy@0 {
+				reg = <0>;
 			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
+			phy2: ethernet-phy@1 {
+				reg = <1>;
 			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
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
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <37 2 38 2 39 2>;
-			interrupt-parent = <&mpic>;
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
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <28 2>;
-			interrupt-parent = <&mpic>;
 		};
 
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
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
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
 		reg = <0xf8008000 0x1000>;
-		bus-range = <0x0 0xff>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
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
@@ -419,7 +176,6 @@
 		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x00100000>;
 		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
 		interrupts = <25 2>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
@@ -445,3 +201,5 @@
 		};
 	};
 };
+
+/include/ "mpc8641si-post.dtsi"
-- 
2.7.1
