Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id EA2362C0040
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2013 09:34:37 +1100 (EST)
From: Timur Tabi <timur@tabi.org>
To: Scott Wood <scottwood@freescale.com>,
 Kumar Gala <kumar.gala@freescale.com>, stuart.yoder@freescale.com,
 linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/85xx: describe the PAMU topology in the device
 tree
Date: Thu, 17 Jan 2013 16:34:33 -0600
Message-Id: <1358462073-2558-2-git-send-email-timur@tabi.org>
In-Reply-To: <1358462073-2558-1-git-send-email-timur@tabi.org>
References: <1358462073-2558-1-git-send-email-timur@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>

The PAMU caches use the LIODNs to determine which cache lines hold the
entries for the corresponding LIODs.  The LIODNs must therefore be
carefully assigned to avoid cache thrashing -- two active LIODs with
LIODNs that put them in the same cache line.

Currently, LIODNs are statically assigned by U-Boot, but this has
limitations.  LIODNs are assigned even for devices that may be disabled
or unused by the kernel.  Static assignments also do not allow for device
drivers which may know which LIODs can be used simultaneously.  In
other words, we really should assign LIODNs dynamically in Linux.

To do that, we need to describe the PAMU device and cache topologies in
the device trees.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/guts.txt       |   14 ++-
 .../devicetree/bindings/powerpc/fsl/pamu.txt       |  142 ++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   87 +++++++++++--
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   87 +++++++++++--
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   68 +++++++++-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |   92 +++++++++++--
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   92 +++++++++++--
 7 files changed, 533 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/pamu.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
index 9e7a241..1970542 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
@@ -17,9 +17,21 @@ Recommended properties:
    contains a functioning "reset control register" (i.e. the board
    is wired to reset upon setting the HRESET_REQ bit in this register).
 
-Example:
+ - fsl,liodn-bits : Indicates the number of defined bits in the LIODN
+   registers, for those SOCs that have a PAMU device.
+
+Examples:
 	global-utilities@e0000 {	/* global utilities block */
 		compatible = "fsl,mpc8548-guts";
 		reg = <e0000 1000>;
 		fsl,has-rstcr;
 	};
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,qoriq-device-config-1.0";
+		reg = <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		#sleep-cells = <1>;
+		fsl,liodn-bits = <12>;
+	};
+
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pamu.txt b/Documentation/devicetree/bindings/powerpc/fsl/pamu.txt
new file mode 100644
index 0000000..4826268
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/pamu.txt
@@ -0,0 +1,142 @@
+Freescale Peripheral Management Access Unit (PAMU) Device Tree Binding
+
+DESCRIPTION
+
+The PAMU is an I/O MMU that provides device-to-memory access control and
+address translation capabilities.
+
+Required properties:
+
+- compatible	: <string>
+		  First entry is a version-specific string, such as
+		  "fsl,pamu-v1.0".  The second is "fsl,pamu".
+- ranges	: <prop-encoded-array>
+		  A standard property. Utilized to describe the memory mapped
+		  I/O space utilized by the controller.  The size should
+		  be set to the total size of the register space of all
+		  physically present PAMU controllers.  For example, for
+		  PAMU v1.0, on an SOC that has five PAMU devices, the size
+		  is 0x5000.
+- interrupts	: <prop-encoded-array>
+		  Interrupt mappings.  The first tuple is the normal PAMU
+		  interrupt, used for reporting access violations.  The second
+		  is for PAMU hardware errors, such as PAMU operation errors
+		  and ECC errors.
+- #address-cells: <u32>
+		  A standard property.
+- #size-cells	: <u32>
+		  A standard property.
+
+Optional properties:
+- reg		: <prop-encoded-array>
+		  A standard property.   It represents the CCSR registers of
+		  all child PAMUs combined.  Include it to provide support
+		  for legacy drivers.
+- interrupt-parent : <phandle>
+		  Phandle to interrupt controller
+
+Child nodes:
+
+Each child node represents one PAMU controller.  Each SOC device that is
+connected to a specific PAMU device should have a "fsl,pamu-phandle" property
+that links to the corresponding specific child PAMU controller.
+
+- reg		: <prop-encoded-array>
+		  A standard property.  Specifies the physical address and
+		  length (relative to the parent 'ranges' property) of this
+		  PAMU controller's configuration registers.  The size should
+		  be set to the size of this PAMU controllers's register space.
+		  For PAMU v1.0, this size is 0x1000.
+- fsl,primary-cache-geometry
+		: <prop-encoded-array>
+		  Two cells that specify the geometry of the primary PAMU
+		  cache.  The first is the number of cache lines, and the
+		  second is the number of "ways".  For direct-mapped caches,
+		  specify a value of 1.
+- fsl,secondary-cache-geometry
+		: <prop-encoded-array>
+		  Two cells that specify the geometry of the secondary PAMU
+		  cache.  The first is the number of cache lines, and the
+		  second is the number of "ways".  For direct-mapped caches,
+		  specify a value of 1.
+
+Device nodes:
+
+Devices that have LIODNs need to specify links to the parent PAMU controller
+(the actual PAMU controller that this device is connected to) and a pointer to
+the LIODN register, if applicable.
+
+- fsl,iommu-parent
+		: <phandle>
+		Phandle to the single, specific PAMU controller node to which
+		this device is connect.  The PAMU topology is represented in
+		the device tree to assist code that dynamically determines the
+		best LIODN values to minimize PAMU cache thrashing.
+
+- fsl,liodn-reg : <prop-encoded-array>
+		  Two cells that specify the location of the LIODN register
+		  for this device.  Required for devices that have a single
+		  LIODN.  The first cell is a phandle to a node that contains
+		  the registers where the LIODN is to be set.  The second is
+		  the offset from the first "reg" resource of the node where
+		  the specific LIODN register is located.
+
+
+Example:
+
+	iommu@20000 {
+		compatible = "fsl,pamu-v1.0", "fsl,pamu";
+		reg = <0x20000 0x5000>;
+		ranges = <0 0x20000 0x5000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupts = <
+			24 2 0 0
+			16 2 1 30>;
+
+		pamu0: pamu@0 {
+			reg = <0 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu1: pamu@1000 {
+			reg = <0x1000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu2: pamu@2000 {
+			reg = <0x2000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu3: pamu@3000 {
+			reg = <0x3000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu4: pamu@4000 {
+			reg = <0x4000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+	};
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,qoriq-device-config-1.0";
+		reg = <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		#sleep-cells = <1>;
+		fsl,liodn-bits = <12>;
+	};
+
+/include/ "qoriq-dma-0.dtsi"
+	dma@100300 {
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x584>; /* DMA2LIODNR */
+	};
+
+
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 531eab8..69ac1ac 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -48,6 +48,8 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 15>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x500>; /* PEX1LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -75,6 +77,8 @@
 	bus-range = <0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 14>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x504>; /* PEX2LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -102,6 +106,8 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 13>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x508>; /* PEX3LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -125,18 +131,21 @@
 	interrupts = <16 2 1 11>;
 	#address-cells = <2>;
 	#size-cells = <2>;
+	fsl,iommu-parent = <&pamu0>;
 	ranges;
 
 	port1 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		cell-index = <1>;
+		fsl,liodn-reg = <&guts 0x510>; /* RIO1LIODNR */
 	};
 
 	port2 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		cell-index = <2>;
+		fsl,liodn-reg = <&guts 0x514>; /* RIO2LIODNR */
 	};
 };
 
@@ -246,10 +255,37 @@
 
 	iommu@20000 {
 		compatible = "fsl,pamu-v1.0", "fsl,pamu";
-		reg = <0x20000 0x4000>;
+		reg = <0x20000 0x4000>; /* for compatibility with older PAMU drivers */
+		ranges = <0 0x20000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 		interrupts = <
 			24 2 0 0
 			16 2 1 30>;
+
+		pamu0: pamu@0 {
+			reg = <0 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu1: pamu@1000 {
+			reg = <0x1000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu2: pamu@2000 {
+			reg = <0x2000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu3: pamu@3000 {
+			reg = <0x3000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
 	};
 
 /include/ "qoriq-mpic.dtsi"
@@ -291,7 +327,17 @@
 	};
 
 /include/ "qoriq-dma-0.dtsi"
+	dma@100300 {
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x580>; /* DMA1LIODNR */
+	};
+
 /include/ "qoriq-dma-1.dtsi"
+	dma@101300 {
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x584>; /* DMA2LIODNR */
+	};
+
 /include/ "qoriq-espi-0.dtsi"
 	spi@110000 {
 		fsl,espi-num-chipselects = <4>;
@@ -299,6 +345,8 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		sdhci,auto-cmd12;
 	};
 
@@ -308,20 +356,37 @@
 /include/ "qoriq-duart-1.dtsi"
 /include/ "qoriq-gpio-0.dtsi"
 /include/ "qoriq-usb2-mph-0.dtsi"
-		usb0: usb@210000 {
-			compatible = "fsl-usb2-mph-v1.6", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
-			phy_type = "utmi";
-			port0;
-		};
+	usb0: usb@210000 {
+		compatible = "fsl-usb2-mph-v1.6", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
+		phy_type = "utmi";
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x520>; /* USB1LIODNR */
+		port0;
+	};
 
 /include/ "qoriq-usb2-dr-0.dtsi"
-		usb1: usb@211000 {
-			compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
-			dr_mode = "host";
-			phy_type = "utmi";
-		};
+	usb1: usb@211000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x524>; /* USB2LIODNR */
+		dr_mode = "host";
+		phy_type = "utmi";
+	};
 
 /include/ "qoriq-sata2-0.dtsi"
+	sata@220000 {
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x550>; /* SATA1LIODNR */
+	};
+
 /include/ "qoriq-sata2-1.dtsi"
+	sata@221000 {
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
+	};
+
 /include/ "qoriq-sec4.2-0.dtsi"
+crypto: crypto@300000 {
+		fsl,iommu-parent = <&pamu1>;
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index af4ebc8..9b5a81a 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -48,6 +48,8 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 15>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x500>; /* PEX1LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -75,6 +77,8 @@
 	bus-range = <0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 14>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x504>; /* PEX2LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -102,6 +106,8 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 13>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x508>; /* PEX3LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -152,18 +158,21 @@
 	interrupts = <16 2 1 11>;
 	#address-cells = <2>;
 	#size-cells = <2>;
+	fsl,iommu-parent = <&pamu0>;
 	ranges;
 
 	port1 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		cell-index = <1>;
+		fsl,liodn-reg = <&guts 0x510>; /* RIO1LIODNR */
 	};
 
 	port2 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		cell-index = <2>;
+		fsl,liodn-reg = <&guts 0x514>; /* RIO2LIODNR */
 	};
 };
 
@@ -273,10 +282,37 @@
 
 	iommu@20000 {
 		compatible = "fsl,pamu-v1.0", "fsl,pamu";
-		reg = <0x20000 0x4000>;
+		reg = <0x20000 0x4000>; /* for compatibility with older PAMU drivers */
+		ranges = <0 0x20000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 		interrupts = <
 			24 2 0 0
 			16 2 1 30>;
+
+		pamu0: pamu@0 {
+			reg = <0 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu1: pamu@1000 {
+			reg = <0x1000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu2: pamu@2000 {
+			reg = <0x2000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu3: pamu@3000 {
+			reg = <0x3000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
 	};
 
 /include/ "qoriq-mpic.dtsi"
@@ -318,7 +354,17 @@
 	};
 
 /include/ "qoriq-dma-0.dtsi"
+	dma@100300 {
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x580>; /* DMA1LIODNR */
+	};
+
 /include/ "qoriq-dma-1.dtsi"
+	dma@101300 {
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x584>; /* DMA2LIODNR */
+	};
+
 /include/ "qoriq-espi-0.dtsi"
 	spi@110000 {
 		fsl,espi-num-chipselects = <4>;
@@ -326,6 +372,8 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		sdhci,auto-cmd12;
 	};
 
@@ -335,20 +383,37 @@
 /include/ "qoriq-duart-1.dtsi"
 /include/ "qoriq-gpio-0.dtsi"
 /include/ "qoriq-usb2-mph-0.dtsi"
-		usb0: usb@210000 {
-			compatible = "fsl-usb2-mph-v1.6", "fsl-usb2-mph";
-			phy_type = "utmi";
-			port0;
-		};
+	usb0: usb@210000 {
+		compatible = "fsl-usb2-mph-v1.6", "fsl-usb2-mph";
+		phy_type = "utmi";
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x520>; /* USB1LIODNR */
+		port0;
+	};
 
 /include/ "qoriq-usb2-dr-0.dtsi"
-		usb1: usb@211000 {
-			compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
-			dr_mode = "host";
-			phy_type = "utmi";
-		};
+	usb1: usb@211000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x524>; /* USB2LIODNR */
+		dr_mode = "host";
+		phy_type = "utmi";
+	};
 
 /include/ "qoriq-sata2-0.dtsi"
+	sata@220000 {
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x550>; /* SATA1LIODNR */
+	};
+
 /include/ "qoriq-sata2-1.dtsi"
+	sata@221000 {
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
+	};
+
 /include/ "qoriq-sec4.2-0.dtsi"
+crypto: crypto@300000 {
+		fsl,iommu-parent = <&pamu1>;
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index cf4f538..19859ad 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -48,6 +48,8 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 15>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x500>; /* PEX1LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -75,6 +77,8 @@
 	bus-range = <0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 14>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x504>; /* PEX2LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -102,6 +106,8 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 13>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x508>; /* PEX3LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -126,18 +132,21 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 	fsl,srio-rmu-handle = <&rmu>;
+	fsl,iommu-parent = <&pamu0>;
 	ranges;
 
 	port1 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		cell-index = <1>;
+		fsl,liodn-reg = <&guts 0x510>; /* RIO1LIODNR */
 	};
 
 	port2 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		cell-index = <2>;
+		fsl,liodn-reg = <&guts 0x514>; /* RIO2LIODNR */
 	};
 };
 
@@ -281,13 +290,51 @@
 
 	iommu@20000 {
 		compatible = "fsl,pamu-v1.0", "fsl,pamu";
-		reg = <0x20000 0x5000>;
+		reg = <0x20000 0x5000>; /* for compatibility with older PAMU drivers */
+		ranges = <0 0x20000 0x5000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 		interrupts = <
 			24 2 0 0
 			16 2 1 30>;
+
+		pamu0: pamu@0 {
+			reg = <0 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu1: pamu@1000 {
+			reg = <0x1000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu2: pamu@2000 {
+			reg = <0x2000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu3: pamu@3000 {
+			reg = <0x3000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu4: pamu@4000 {
+			reg = <0x4000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
 	};
 
 /include/ "qoriq-rmu-0.dtsi"
+	rmu@d3000 {
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x540>; /* RMULIODNR */
+	};
+
 /include/ "qoriq-mpic.dtsi"
 
 	guts: global-utilities@e0000 {
@@ -327,7 +374,17 @@
 	};
 
 /include/ "qoriq-dma-0.dtsi"
+	dma@100300 {
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x580>; /* DMA1LIODNR */
+	};
+
 /include/ "qoriq-dma-1.dtsi"
+	dma@101300 {
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x584>; /* DMA2LIODNR */
+	};
+
 /include/ "qoriq-espi-0.dtsi"
 	spi@110000 {
 		fsl,espi-num-chipselects = <4>;
@@ -335,6 +392,8 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		voltage-ranges = <3300 3300>;
 		sdhci,auto-cmd12;
 	};
@@ -347,11 +406,18 @@
 /include/ "qoriq-usb2-mph-0.dtsi"
 	usb@210000 {
 		compatible = "fsl-usb2-mph-v1.6", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x520>; /* USB1LIODNR */
 		port0;
 	};
 /include/ "qoriq-usb2-dr-0.dtsi"
 	usb@211000 {
 		compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x524>; /* USB2LIODNR */
 	};
 /include/ "qoriq-sec4.0-0.dtsi"
+crypto: crypto@300000 {
+		fsl,iommu-parent = <&pamu1>;
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index 5d7205b..9ea77c3 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -48,6 +48,8 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 15>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x500>; /* PEX1LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -75,6 +77,8 @@
 	bus-range = <0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 14>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x504>; /* PEX2LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -102,6 +106,8 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 13>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x508>; /* PEX3LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -129,6 +135,8 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 12>;
+	fsl,iommu-parent = <&pamu0>;
+	fsl,liodn-reg = <&guts 0x50c>; /* PEX4LIODNR */
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -152,18 +160,21 @@
 	interrupts = <16 2 1 11>;
 	#address-cells = <2>;
 	#size-cells = <2>;
+	fsl,iommu-parent = <&pamu0>;
 	ranges;
 
 	port1 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		cell-index = <1>;
+		fsl,liodn-reg = <&guts 0x510>; /* RIO1LIODNR */
 	};
 
 	port2 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		cell-index = <2>;
+		fsl,liodn-reg = <&guts 0x514>; /* RIO2LIODNR */
 	};
 };
 
@@ -276,10 +287,37 @@
 
 	iommu@20000 {
 		compatible = "fsl,pamu-v1.0", "fsl,pamu";
-		reg = <0x20000 0x4000>;
+		reg = <0x20000 0x4000>; /* for compatibility with older PAMU drivers */
+		ranges = <0 0x20000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 		interrupts = <
 			24 2 0 0
 			16 2 1 30>;
+
+		pamu0: pamu@0 {
+			reg = <0 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu1: pamu@1000 {
+			reg = <0x1000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu2: pamu@2000 {
+			reg = <0x2000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu3: pamu@3000 {
+			reg = <0x3000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
 	};
 
 /include/ "qoriq-mpic.dtsi"
@@ -321,7 +359,17 @@
 	};
 
 /include/ "qoriq-dma-0.dtsi"
+	dma@100300 {
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x580>; /* DMA1LIODNR */
+	};
+
 /include/ "qoriq-dma-1.dtsi"
+	dma@101300 {
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x584>; /* DMA2LIODNR */
+	};
+
 /include/ "qoriq-espi-0.dtsi"
 	spi@110000 {
 		fsl,espi-num-chipselects = <4>;
@@ -329,6 +377,8 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		sdhci,auto-cmd12;
 	};
 
@@ -338,21 +388,41 @@
 /include/ "qoriq-duart-1.dtsi"
 /include/ "qoriq-gpio-0.dtsi"
 /include/ "qoriq-usb2-mph-0.dtsi"
-		usb0: usb@210000 {
-			compatible = "fsl-usb2-mph-v1.6", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
-			phy_type = "utmi";
-			port0;
-		};
+	usb0: usb@210000 {
+		compatible = "fsl-usb2-mph-v1.6", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x520>; /* USB1LIODNR */
+		phy_type = "utmi";
+		port0;
+	};
 
 /include/ "qoriq-usb2-dr-0.dtsi"
-		usb1: usb@211000 {
-			compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
-			dr_mode = "host";
-			phy_type = "utmi";
-		};
+	usb1: usb@211000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x524>; /* USB2LIODNR */
+		dr_mode = "host";
+		phy_type = "utmi";
+	};
 
 /include/ "qoriq-sata2-0.dtsi"
+	sata@220000 {
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x550>; /* SATA1LIODNR */
+	};
+
 /include/ "qoriq-sata2-1.dtsi"
+	sata@221000 {
+		fsl,iommu-parent = <&pamu1>;
+		fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
+	};
 /include/ "qoriq-sec4.2-0.dtsi"
+	crypto@300000 {
+		fsl,iommu-parent = <&pamu1>;
+	};
+
 /include/ "qoriq-raid1.0-0.dtsi"
+	raideng@320000 {
+		fsl,iommu-parent = <&pamu1>;
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index db2c9a7..97f8c26 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -48,6 +48,7 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 15>;
+	fsl,iommu-parent = <&pamu0>;
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -75,6 +76,7 @@
 	bus-range = <0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 14>;
+	fsl,iommu-parent = <&pamu0>;
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -102,6 +104,7 @@
 	bus-range = <0x0 0xff>;
 	clock-frequency = <33333333>;
 	interrupts = <16 2 1 13>;
+	fsl,iommu-parent = <&pamu0>;
 	pcie@0 {
 		reg = <0 0 0 0 0>;
 		#interrupt-cells = <1>;
@@ -239,10 +242,42 @@
 
 	iommu@20000 {
 		compatible = "fsl,pamu-v1.0", "fsl,pamu";
-		reg = <0x20000 0x5000>;
-		interrupts = <
-			24 2 0 0
-			16 2 1 30>;
+		reg = <0x20000 0x5000>; /* for compatibility with older PAMU drivers */
+		ranges = <0 0x20000 0x5000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupts = <24 2 0 0
+			      16 2 1 30>;
+
+		pamu0: pamu@0 {
+			reg = <0 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu1: pamu@1000 {
+			reg = <0x1000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu2: pamu@2000 {
+			reg = <0x2000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu3: pamu@3000 {
+			reg = <0x3000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
+
+		pamu4: pamu@4000 {
+			reg = <0x4000 0x1000>;
+			fsl,primary-cache-geometry = <32 1>;
+			fsl,secondary-cache-geometry = <128 2>;
+		};
 	};
 
 /include/ "qoriq-mpic.dtsi"
@@ -284,7 +319,17 @@
 	};
 
 /include/ "qoriq-dma-0.dtsi"
+	dma@100300 {
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x580>; /* DMA1LIODNR */
+	};
+
 /include/ "qoriq-dma-1.dtsi"
+	dma@101300 {
+		fsl,iommu-parent = <&pamu0>;
+		fsl,liodn-reg = <&guts 0x584>; /* DMA2LIODNR */
+	};
+
 /include/ "qoriq-espi-0.dtsi"
 	spi@110000 {
 		fsl,espi-num-chipselects = <4>;
@@ -292,6 +337,8 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		fsl,iommu-parent = <&pamu2>;
+		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		sdhci,auto-cmd12;
 	};
 
@@ -301,20 +348,37 @@
 /include/ "qoriq-duart-1.dtsi"
 /include/ "qoriq-gpio-0.dtsi"
 /include/ "qoriq-usb2-mph-0.dtsi"
-		usb0: usb@210000 {
-			compatible = "fsl-usb2-mph-v1.6", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
-			phy_type = "utmi";
-			port0;
-		};
+	usb0: usb@210000 {
+		compatible = "fsl-usb2-mph-v1.6", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
+		fsl,iommu-parent = <&pamu4>;
+		fsl,liodn-reg = <&guts 0x520>; /* USB1LIODNR */
+		phy_type = "utmi";
+		port0;
+	};
 
 /include/ "qoriq-usb2-dr-0.dtsi"
-		usb1: usb@211000 {
-			compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
-			dr_mode = "host";
-			phy_type = "utmi";
-		};
+	usb1: usb@211000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
+		fsl,iommu-parent = <&pamu4>;
+		fsl,liodn-reg = <&guts 0x524>; /* USB2LIODNR */
+		dr_mode = "host";
+		phy_type = "utmi";
+	};
 
 /include/ "qoriq-sata2-0.dtsi"
+	sata@220000 {
+		fsl,iommu-parent = <&pamu4>;
+		fsl,liodn-reg = <&guts 0x550>; /* SATA1LIODNR */
+	};
+
 /include/ "qoriq-sata2-1.dtsi"
+	sata@221000 {
+		fsl,iommu-parent = <&pamu4>;
+		fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
+	};
+
 /include/ "qoriq-sec5.2-0.dtsi"
+	crypto@300000 {
+		fsl,iommu-parent = <&pamu4>;
+	};
 };
-- 
1.7.3.4
