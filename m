Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (unknown [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0FCFC2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 07:14:03 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc: split sbc8548 dts file into pre and post chunks
Date: Wed, 23 Jan 2013 15:13:30 -0500
Message-Id: <1358972013-5271-2-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1358972013-5271-1-git-send-email-paul.gortmaker@windriver.com>
References: <1358972013-5271-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Updates to u-boot allow this board to boot off of either
the 8MB soldered on flash, or the 64MB SODIMM flash.

This is achieved by changing JP12 and SW2.8 which in turn
swaps which flash device appears on /CS0 and /CS6 respectively.

Since the flash devices are not the same size, this also
changes the MTD memory map layout on the local bus.

Here we split the common chunks out into a pre and post
include, so they can be reused by an upcoming "alternative
boot" dts file; leaving only the local bus chunk behind.

No content changes are made at this point - it is just purely
the move to using include files.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8548-post.dtsi | 295 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/sbc8548-pre.dtsi  |  52 ++++++
 arch/powerpc/boot/dts/sbc8548.dts       | 322 +-------------------------------
 3 files changed, 351 insertions(+), 318 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/sbc8548-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/sbc8548-pre.dtsi

diff --git a/arch/powerpc/boot/dts/sbc8548-post.dtsi b/arch/powerpc/boot/dts/sbc8548-post.dtsi
new file mode 100644
index 0000000..33a47e2
--- /dev/null
+++ b/arch/powerpc/boot/dts/sbc8548-post.dtsi
@@ -0,0 +1,295 @@
+/*
+ * SBC8548 Device Tree Source
+ *
+ * Copyright 2007 Wind River Systems Inc.
+ *
+ * Paul Gortmaker (see MAINTAINERS for contact information)
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/{
+	soc8548@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x00000000 0xe0000000 0x00100000>;
+		bus-frequency = <0>;
+		compatible = "simple-bus";
+
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8548-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		memory-controller@2000 {
+			compatible = "fsl,mpc8548-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <0x12 0x2>;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,mpc8548-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <0x20>;	// 32 bytes
+			cache-size = <0x80000>;	// L2, 512K
+			interrupt-parent = <&mpic>;
+			interrupts = <0x10 0x2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8548-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
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
+		};
+
+		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi1>;
+			phy-handle = <&phy1>;
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
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4500 0x100>;	// reg base, size
+			clock-frequency = <0>;	// should we fill in in uboot?
+			interrupts = <0x2a 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4600 0x100>;	// reg base, size
+			clock-frequency = <0>;	// should we fill in in uboot?
+			interrupts = <0x2a 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	//global utilities reg
+			compatible = "fsl,mpc8548-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+
+		crypto@30000 {
+			compatible = "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0xfe>;
+			fsl,descriptor-types-mask = <0x12b0ebf>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+	};
+
+	pci0: pci@e0008000 {
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x01 (PCI-X slot) @66MHz */
+			0x0800 0x0 0x0 0x1 &mpic 0x2 0x1
+			0x0800 0x0 0x0 0x2 &mpic 0x3 0x1
+			0x0800 0x0 0x0 0x3 &mpic 0x4 0x1
+			0x0800 0x0 0x0 0x4 &mpic 0x1 0x1
+
+			/* IDSEL 0x11 (PCI, 3.3V 32bit) @33MHz */
+			0x8800 0x0 0x0 0x1 &mpic 0x2 0x1
+			0x8800 0x0 0x0 0x2 &mpic 0x3 0x1
+			0x8800 0x0 0x0 0x3 &mpic 0x4 0x1
+			0x8800 0x0 0x0 0x4 &mpic 0x1 0x1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <0x18 0x2>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00800000>;
+		clock-frequency = <66000000>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xe0008000 0x1000>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+	};
+
+	pci1: pcie@e000a000 {
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+
+			/* IDSEL 0x0 (PEX) */
+			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <0x1a 0x2>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe2800000 0x0 0x08000000>;
+		clock-frequency = <33000000>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xe000a000 0x1000>;
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0xa0000000
+				  0x02000000 0x0 0xa0000000
+				  0x0 0x10000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00800000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/sbc8548-pre.dtsi b/arch/powerpc/boot/dts/sbc8548-pre.dtsi
new file mode 100644
index 0000000..d8c6629
--- /dev/null
+++ b/arch/powerpc/boot/dts/sbc8548-pre.dtsi
@@ -0,0 +1,52 @@
+/*
+ * SBC8548 Device Tree Source
+ *
+ * Copyright 2007 Wind River Systems Inc.
+ *
+ * Paul Gortmaker (see MAINTAINERS for contact information)
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/{
+	model = "SBC8548";
+	compatible = "SBC8548";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8548@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <0x20>;	// 32 bytes
+			i-cache-line-size = <0x20>;	// 32 bytes
+			d-cache-size = <0x8000>;	// L1, 32K
+			i-cache-size = <0x8000>;	// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+};
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index 77be771..ad8dc68 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -14,44 +14,9 @@
 
 /dts-v1/;
 
-/ {
-	model = "SBC8548";
-	compatible = "SBC8548";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-		pci1 = &pci1;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8548@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <0x20>;	// 32 bytes
-			i-cache-line-size = <0x20>;	// 32 bytes
-			d-cache-size = <0x8000>;	// L1, 32K
-			i-cache-size = <0x8000>;	// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;
-			clock-frequency = <0>;
-			next-level-cache = <&L2>;
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x00000000 0x10000000>;
-	};
+/include/ "sbc8548-pre.dtsi"
 
+/{
 	localbus@e0000000 {
 		#address-cells = <2>;
 		#size-cells = <1>;
@@ -144,285 +109,6 @@
 			};
                 };
         };
-
-	soc8548@e0000000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		ranges = <0x00000000 0xe0000000 0x00100000>;
-		bus-frequency = <0>;
-		compatible = "simple-bus";
-
-		ecm-law@0 {
-			compatible = "fsl,ecm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		ecm@1000 {
-			compatible = "fsl,mpc8548-ecm", "fsl,ecm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		memory-controller@2000 {
-			compatible = "fsl,mpc8548-memory-controller";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <0x12 0x2>;
-		};
-
-		L2: l2-cache-controller@20000 {
-			compatible = "fsl,mpc8548-l2-cache-controller";
-			reg = <0x20000 0x1000>;
-			cache-line-size = <0x20>;	// 32 bytes
-			cache-size = <0x80000>;	// L2, 512K
-			interrupt-parent = <&mpic>;
-			interrupts = <0x10 0x2>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2>;
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
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8548-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8548-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8548-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8548-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8548-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@19 {
-					interrupt-parent = <&mpic>;
-					interrupts = <0x6 0x1>;
-					reg = <0x19>;
-					device_type = "ethernet-phy";
-				};
-				phy1: ethernet-phy@1a {
-					interrupt-parent = <&mpic>;
-					interrupts = <0x7 0x1>;
-					reg = <0x1a>;
-					device_type = "ethernet-phy";
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi1>;
-			phy-handle = <&phy1>;
-
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
-			};
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;	// reg base, size
-			clock-frequency = <0>;	// should we fill in in uboot?
-			interrupts = <0x2a 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;	// reg base, size
-			clock-frequency = <0>;	// should we fill in in uboot?
-			interrupts = <0x2a 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		global-utilities@e0000 {	//global utilities reg
-			compatible = "fsl,mpc8548-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-
-		crypto@30000 {
-			compatible = "fsl,sec2.1", "fsl,sec2.0";
-			reg = <0x30000 0x10000>;
-			interrupts = <45 2>;
-			interrupt-parent = <&mpic>;
-			fsl,num-channels = <4>;
-			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0xfe>;
-			fsl,descriptor-types-mask = <0x12b0ebf>;
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
-	};
-
-	pci0: pci@e0008000 {
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x01 (PCI-X slot) @66MHz */
-			0x0800 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x0800 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x0800 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x0800 0x0 0x0 0x4 &mpic 0x1 0x1
-
-			/* IDSEL 0x11 (PCI, 3.3V 32bit) @33MHz */
-			0x8800 0x0 0x0 0x1 &mpic 0x2 0x1
-			0x8800 0x0 0x0 0x2 &mpic 0x3 0x1
-			0x8800 0x0 0x0 0x3 &mpic 0x4 0x1
-			0x8800 0x0 0x0 0x4 &mpic 0x1 0x1>;
-
-		interrupt-parent = <&mpic>;
-		interrupts = <0x18 0x2>;
-		bus-range = <0 0>;
-		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x10000000
-			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00800000>;
-		clock-frequency = <66000000>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xe0008000 0x1000>;
-		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
-		device_type = "pci";
-	};
-
-	pci1: pcie@e000a000 {
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-
-			/* IDSEL 0x0 (PEX) */
-			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1>;
-
-		interrupt-parent = <&mpic>;
-		interrupts = <0x1a 0x2>;
-		bus-range = <0x0 0xff>;
-		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
-			  0x01000000 0x0 0x00000000 0xe2800000 0x0 0x08000000>;
-		clock-frequency = <33000000>;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xe000a000 0x1000>;
-		compatible = "fsl,mpc8548-pcie";
-		device_type = "pci";
-		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x02000000 0x0 0xa0000000
-				  0x02000000 0x0 0xa0000000
-				  0x0 0x10000000
-
-				  0x01000000 0x0 0x00000000
-				  0x01000000 0x0 0x00000000
-				  0x0 0x00800000>;
-		};
-	};
 };
+
+/include/ "sbc8548-post.dtsi"
-- 
1.8.1
