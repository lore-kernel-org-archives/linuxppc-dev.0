Return-Path: <oleks@ivymike.arcturusnetworks.com>
Received: from ivymike.arcturusnetworks.com (gw.arcturusgroup.net [66.11.68.6])
 by lists.ozlabs.org (Postfix) with ESMTP id 529421A00CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 02:01:22 +1000 (AEST)
From: Oleksandr G Zhadan <oleks@arcturusnetworks.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] powerpc: mpc85xx: Add board support for ucp1020
Date: Tue,  5 May 2015 11:52:01 -0400
Message-Id: <1430841121-1997-1-git-send-email-oleks@arcturusnetworks.com>
Cc: Michael Durrant <mdurrant@arcturusnetworks.com>,
 Oleksandr G Zhadan <oleks@arcturusnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

New QorIQ p1020 based board support from Arcturus Networks Inc.
http://www.arcturusnetworks.com/products/ucp1020/

Signed-off-by: Michael Durrant <mdurrant@arcturusnetworks.com>
Signed-off-by: Oleksandr G Zhadan <oleks@arcturusnetworks.com>
---
 Documentation/devicetree/bindings/pci/fsl,pci.txt  |    2 +-
 .../devicetree/bindings/powerpc/arcturus/board.txt |  149 ++
 .../devicetree/bindings/powerpc/arcturus/ecm.txt   |   64 +
 Documentation/devicetree/bindings/usb/fsl-usb.txt  |    2 +-
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi     |  179 ++
 arch/powerpc/boot/dts/fsl/ucp1020som-pre.dtsi      |   70 +
 arch/powerpc/boot/dts/ucp1020_32b.dts              |   88 +
 arch/powerpc/boot/dts/ucp1020_32b.dtsi             |  174 ++
 arch/powerpc/configs/ucp1020_defconfig             | 2731 ++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig                |    7 +
 arch/powerpc/platforms/85xx/Makefile               |    1 +
 arch/powerpc/platforms/85xx/ucp1020_som.c          |  100 +
 13 files changed, 3566 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/arcturus/board.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/arcturus/ecm.txt
 create mode 100644 arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/ucp1020som-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/ucp1020_32b.dts
 create mode 100644 arch/powerpc/boot/dts/ucp1020_32b.dtsi
 create mode 100644 arch/powerpc/configs/ucp1020_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/ucp1020_som.c

diff --git a/Documentation/devicetree/bindings/pci/fsl,pci.txt b/Documentation/devicetree/bindings/pci/fsl,pci.txt
index d8ac4a7..298a5e6 100644
--- a/Documentation/devicetree/bindings/pci/fsl,pci.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,pci.txt
@@ -20,7 +20,7 @@ Example:
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci", "fsl,mpc8548-pcie";
 		device_type = "pci";
 		...
 		...
diff --git a/Documentation/devicetree/bindings/powerpc/arcturus/board.txt b/Documentation/devicetree/bindings/powerpc/arcturus/board.txt
new file mode 100644
index 0000000..54e9765
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/arcturus/board.txt
@@ -0,0 +1,149 @@
+UCP1020 module Tree Bindings
+----------------------------
+
+Copyright 2013-2015 Arcturus Networks, Inc.
+
+QorIQ p1020 based board
+http://www.arcturusnetworks.com/products/ucp1020/
+-------------------------------------------------
+
+Root Module
+
+Properties:
+- model:		"arcturus,uCP1020"
+- compatible:		"arcturus,uCP1020"
+- SN:			"1234567890-1234"
+
+/ {
+	model = "arcturus,uCP1020";
+	compatible = "arcturus,uCP1020", "fsl,P1020";
+	SN = "1234567890-1234";
+	...
+  }
+-------------------------------------------------
+
+P1020 SPI controller
+
+Properties:
+- compatible:		"spansion,s25fl008k", "winbond,w25q80bl"
+
+Example:
+	spi@7000 {
+		flash@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "spansion,s25fl008k", "winbond,w25q80bl";
+			reg = <0>;
+			spi-max-frequency = <40000000>; /* input clock */
+			...
+		};
+-------------------------------------------------
+
+Chipselect/Local Bus
+
+Properties:
+- #address-cells:	<2>.
+- #size-cells:		<1>.
+- compatible:		"fsl,p1020-elbc", "fsl,elbc", "simple-bus","fsl,p1020-immr"
+- interrupts:		interrupts to report localbus events.
+
+Example:
+
+&lbc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	compatible = "fsl,p1020-elbc", "fsl,elbc", "simple-bus";
+	interrupts = <19 2 0 0>;
+};
+-------------------------------------------------
+
+Freescale L2 Cache Controller
+
+L2 cache is present in Freescale's QorIQ and QorIQ Qonverge platforms.
+The cache bindings explained below are ePAPR compliant
+
+Properties:
+
+- compatible	: Should include "fsl,chip-l2-cache-controller" and "cache"
+		  where chip is the processor (bsc9132, npc8572 etc.)
+- reg		: Address and size of L2 cache controller registers
+- cache-size	: Size of the entire L2 cache
+- interrupts	: Error interrupt of L2 controller
+- cache-line-size : Size of L2 cache lines
+
+Example:
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,p1020-l2-cache-controller", "cache";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>; // 32 bytes
+		cache-size = <0x40000>; // L2,256K
+		interrupts = <16 2 1 0>;
+	};
+-------------------------------------------------
+
+Freescale DDR memory controller
+
+Properties:
+
+- compatible	: Should include "fsl,chip-memory-controller" where
+		  chip is the processor (bsc9132, mpc8572 etc.), or
+		  "fsl,qoriq-memory-controller".
+- reg		: Address and size of DDR controller registers
+- interrupts	: Error interrupt of DDR controller
+
+Example 1:
+
+	memory-controller@2000 {
+		compatible = "fsl,p1020-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <16 2 1 8>;
+	};
+
+Example 2:
+
+	ddr1: memory-controller@8000 {
+		compatible = "fsl,qoriq-memory-controller-v4.7",
+				"fsl,qoriq-memory-controller";
+		reg = <0x8000 0x1000>;
+		interrupts = <16 2 1 23>;
+	};
+-------------------------------------------------
+
+Global Utilities Block
+
+The global utilities block controls power management, I/O device
+enabling, power-on-reset configuration monitoring, general-purpose
+I/O signal configuration, alternate function selection for multiplexed
+signals, and clock control.
+
+Required properties:
+
+ - compatible : Should define the compatible device type for
+   global-utilities.
+ - reg : Offset and length of the register set for the device.
+
+Recommended properties:
+
+ - fsl,has-rstcr : Indicates that the global utilities register set
+   contains a functioning "reset control register" (i.e. the board
+   is wired to reset upon setting the HRESET_REQ bit in this register).
+
+ - fsl,liodn-bits : Indicates the number of defined bits in the LIODN
+   registers, for those SOCs that have a PAMU device.
+
+Examples:
+	global-utilities@e0000 {	/* global utilities block */
+		compatible = "fsl,p1020-guts";
+		reg = <e0000 1000>;
+		fsl,has-rstcr;
+	};
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,qoriq-device-config-1.0";
+		reg = <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		#sleep-cells = <1>;
+		fsl,liodn-bits = <12>;
+	};
+-------------------------------------------------
diff --git a/Documentation/devicetree/bindings/powerpc/arcturus/ecm.txt b/Documentation/devicetree/bindings/powerpc/arcturus/ecm.txt
new file mode 100644
index 0000000..8fab3d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/arcturus/ecm.txt
@@ -0,0 +1,64 @@
+=====================================================================
+E500 LAW & Coherency Module Device Tree Binding
+Copyright (C) 2009 Freescale Semiconductor Inc.
+=====================================================================
+
+Local Access Window (LAW) Node
+
+The LAW node represents the region of CCSR space where local access
+windows are configured.  For ECM based devices this is the first 4k
+of CCSR space that includes CCSRBAR, ALTCBAR, ALTCAR, BPTR, and some
+number of local access windows as specified by fsl,num-laws.
+
+PROPERTIES
+
+  - compatible
+      Usage: required
+      Value type: <string>
+      Definition: Must include "fsl,ecm-law"
+
+  - reg
+      Usage: required
+      Value type: <prop-encoded-array>
+      Definition: A standard property.  The value specifies the
+          physical address offset and length of the CCSR space
+          registers.
+
+  - fsl,num-laws
+      Usage: required
+      Value type: <u32>
+      Definition: The value specifies the number of local access
+          windows for this device.
+
+=====================================================================
+
+E500 Coherency Module Node
+
+The E500 LAW node represents the region of CCSR space where ECM config
+and error reporting registers exist, this is the second 4k (0x1000)
+of CCSR space.
+
+PROPERTIES
+
+  - compatible
+      Usage: required
+      Value type: <string>
+      Definition: Must include "fsl,p1020-ecm", "fsl,ecm" where
+      CHIP is the processor (mpc8572, mpc8544, etc.)
+
+  - reg
+      Usage: required
+      Value type: <prop-encoded-array>
+      Definition: A standard property.  The value specifies the
+          physical address offset and length of the CCSR space
+          registers.
+
+   - interrupts
+      Usage: required
+      Value type: <prop-encoded-array>
+
+   - interrupt-parent
+      Usage: required
+      Value type: <phandle>
+
+=====================================================================
diff --git a/Documentation/devicetree/bindings/usb/fsl-usb.txt b/Documentation/devicetree/bindings/usb/fsl-usb.txt
index 4779c02..a2663ad 100644
--- a/Documentation/devicetree/bindings/usb/fsl-usb.txt
+++ b/Documentation/devicetree/bindings/usb/fsl-usb.txt
@@ -57,7 +57,7 @@ Example multi port host USB controller device node :
 
 Example dual role USB controller device node :
 	usb@23000 {
-		compatible = "fsl-usb2-dr";
+		compatible = "fsl-usb2-dr", "fsl-usb2-dr-v1.6";
 		reg = <23000 1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8033919..da85f01 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -24,6 +24,7 @@ amstaos	AMS-Taos Inc.
 apm	Applied Micro Circuits Corporation (APM)
 aptina	Aptina Imaging
 arasan	Arasan Chip Systems
+arcturus	Arcturus Networks Inc.
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
 artesyn	Artesyn Embedded Technologies Inc.
diff --git a/arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi b/arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi
new file mode 100644
index 0000000..930a6e3
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/ucp1020som-post.dtsi
@@ -0,0 +1,179 @@
+/*
+ * P1020/P1011 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+&lbc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	compatible = "fsl,p1020-elbc", "fsl,elbc", "simple-bus";
+	interrupts = <19 2 0 0>;
+};
+
+/* controller at 0x9000 */
+&pci0 {
+	compatible = "fsl,mpc8548-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 255>;
+	clock-frequency = <33333333>;
+	interrupts = <16 2 0 0>;
+
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x4 0x1 0x0 0x0
+			0000 0x0 0x0 0x2 &mpic 0x5 0x1 0x0 0x0
+			0000 0x0 0x0 0x3 &mpic 0x6 0x1 0x0 0x0
+			0000 0x0 0x0 0x4 &mpic 0x7 0x1 0x0 0x0
+			>;
+	};
+};
+
+/* controller at 0xa000 */
+&pci1 {
+	compatible = "fsl,mpc8548-pcie";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0 255>;
+	clock-frequency = <33333333>;
+	interrupts = <16 2 0 0>;
+
+	pcie@0 {
+		reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <16 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0x0 0x0 0x1 &mpic 0x0 0x1 0x0 0x0
+			0000 0x0 0x0 0x2 &mpic 0x1 0x1 0x0 0x0
+			0000 0x0 0x0 0x3 &mpic 0x2 0x1 0x0 0x0
+			0000 0x0 0x0 0x4 &mpic 0x3 0x1 0x0 0x0
+			>;
+	};
+};
+
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "soc";
+	compatible = "fsl,p1020-immr", "simple-bus";
+	bus-frequency = <0>;		// Filled out by uboot.
+
+	ecm-law@0 {
+		compatible = "fsl,ecm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <12>;
+	};
+
+	ecm@1000 {
+		compatible = "fsl,p1020-ecm", "fsl,ecm";
+		reg = <0x1000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
+	memory-controller@2000 {
+		compatible = "fsl,p1020-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-i2c-0.dtsi"
+/include/ "pq3-i2c-1.dtsi"
+/include/ "pq3-duart-0.dtsi"
+
+/include/ "pq3-espi-0.dtsi"
+	spi@7000 {
+		fsl,espi-num-chipselects = <4>;
+	};
+
+/include/ "pq3-gpio-0.dtsi"
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,p1020-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x40000>; // L2,256K
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "pq3-dma-0.dtsi"
+/include/ "pq3-usb2-dr-0.dtsi"
+	usb@22000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl-usb2-dr";
+	};
+/include/ "pq3-usb2-dr-1.dtsi"
+	usb@23000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl-usb2-dr";
+	};
+
+/include/ "pq3-esdhc-0.dtsi"
+	sdhc@2e000 {
+		compatible = "fsl,p1020-esdhc", "fsl,esdhc";
+		sdhci,auto-cmd12;
+	};
+/include/ "pq3-sec3.3-0.dtsi"
+
+/include/ "pq3-mpic.dtsi"
+/include/ "pq3-mpic-timer-B.dtsi"
+
+/include/ "pq3-etsec2-0.dtsi"
+	enet0: enet0_grp2: ethernet@b0000 {
+	};
+
+/include/ "pq3-etsec2-2.dtsi"
+	enet1: enet2_grp2: ethernet@b2000 {
+	};
+
+	global-utilities@e0000 {
+		compatible = "fsl,p1020-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+};
+
+/include/ "pq3-etsec2-grp2-0.dtsi"
+/include/ "pq3-etsec2-grp2-2.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/ucp1020som-pre.dtsi b/arch/powerpc/boot/dts/fsl/ucp1020som-pre.dtsi
new file mode 100644
index 0000000..6a80b1c
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/ucp1020som-pre.dtsi
@@ -0,0 +1,70 @@
+/*
+ * P1020/P1011 Silicon/SoC Device Tree Source (pre include)
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/dts-v1/;
+
+/include/ "e500v2_power_isa.dtsi"
+
+/ {
+	compatible = "fsl,P1020";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,P1020@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,P1020@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/ucp1020_32b.dts b/arch/powerpc/boot/dts/ucp1020_32b.dts
new file mode 100644
index 0000000..4a8358c
--- /dev/null
+++ b/arch/powerpc/boot/dts/ucp1020_32b.dts
@@ -0,0 +1,88 @@
+/*
+ * uCP1020 Tree Source (32-bit address map)
+ *
+ * Copyright 2013-2015 Arcturus Networks Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/include/ "fsl/ucp1020som-pre.dtsi"
+/ {
+	model = "arcturus,uCP1020";
+	compatible = "arcturus,uCP1020";
+	SN = "1234567890-1234";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@ffe05000 {
+		reg = <0 0xffe05000 0 0x1000>;
+
+		/* NOR Flash */
+		ranges = <0x0 0x0 0x0 0xec000000 0x04000000>;
+	};
+
+	soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@ffe09000 {
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		reg = <0 0xffe09000 0 0x1000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xa0000000
+				  0x2000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@ffe0a000 {
+		reg = <0 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
+
+/include/ "ucp1020_32b.dtsi"
+/include/ "fsl/ucp1020som-post.dtsi"
diff --git a/arch/powerpc/boot/dts/ucp1020_32b.dtsi b/arch/powerpc/boot/dts/ucp1020_32b.dtsi
new file mode 100644
index 0000000..448ddb6
--- /dev/null
+++ b/arch/powerpc/boot/dts/ucp1020_32b.dtsi
@@ -0,0 +1,174 @@
+/*
+ * uCP1020 Device Tree Source stub (no addresses or top-level ranges)
+ *
+ * Copyright 2013-2015 Arcturus Networks Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+&lbc {
+	nor@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x04000000>;
+		bank-width = <2>;
+		device-width = <1>;
+
+		partition@100000 {
+			/* 7MB - PART 0 */
+			reg = <0x00100000 0x00700000>;
+			label = "0";
+		};
+
+		partition@800000 {
+			/* 32MB - PART 1 */
+			reg = <0x0800000 0x02000000>;
+			label = "1";
+		};
+
+		partition@2800000 {
+			/* 8MB - PART 2 */
+			reg = <0x02800000 0x00800000>;
+			label = "2";
+		};
+
+		partition@3000000 {
+			/* (16MB - 512K) - PART 3 JFFS 2 */
+			reg = <0x03000000 0x00f80000>;
+			label = "3";
+		};
+
+		partition@0 {
+			/* 512KB - bootloader[u-boot, uCbootloader] */
+			reg = <0x0 0x00080000>;
+			label = "BOOT_SPI";
+		};
+
+		partition@3f80000 {
+			/* 512KB - bootloade NOR r[u-boot, uCbootloader] */
+			reg = <0x03f80000 0x00080000>;
+			label = "B";
+		};
+
+		partition@80000 {
+			/* 256KB - bootloaders environment (uCenv) */
+			reg = <0x00080000 0x00040000>;
+			label = "E";
+		};
+
+		partition@C0000 {
+			/* 256KB - bootloaders environment (u-boot) */
+			reg = <0x000C0000 0x00040000>;
+			label = "UENV";
+		};
+	};
+};
+
+&soc {
+	i2c@3000 {
+		rtc@68 {
+			compatible = "pericom,pt7c4338";
+			reg = <0x68>;
+		};
+	};
+
+	i2c@3100 {
+			dtt@4C {
+				compatible = "national,lm90";
+				reg = <0x4C>;
+			};
+	};
+
+	spi@7000 {
+		flash@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "spansion,s25fl008k", "winbond,w25q80bl";
+			reg = <0>;
+			spi-max-frequency = <40000000>; /* input clock */
+
+			partition@0 {
+				label = "SPI MBR";
+				reg = <0x00000000 0x00002000>;
+				read-only;
+			};
+			partition@2000 {
+				label = "SPI ENV";
+				reg = <0x00002000 0x00006000>;
+				read-only;
+			};
+			partition@8000 {
+				label = "SPI FS";
+				reg = <0x00008000 0x000F8000>;
+			};
+		};
+		flash@3 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "spansion,s25fl008k", "winbond,w25q80bl";
+			reg = <3>;
+			spi-max-frequency = <40000000>; /* input clock */
+			partition@0 {
+				label = "SPI USER";
+				reg = <0x00000000 0x00100000>;
+			};
+		};
+	};
+
+	usb@22000 {
+		phy_type = "ulpi";
+	};
+
+	mdio@24000 {
+		phy0: ethernet-phy@4 {
+			interrupt-parent = <&mpic>;
+			interrupts = <4 1>;
+			reg = <0x04>;
+		};
+
+		phy1: ethernet-phy@6 {
+			interrupt-parent = <&mpic>;
+			interrupts = <8 1>;
+			reg = <0x6>;
+		};
+	};
+
+	enet0: ethernet@b0000 {
+		phy-handle = <&phy0>;
+		phy-connection-type = "rgmii-id";
+
+	};
+
+	enet1: ethernet@b2000 {
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii-id";
+	};
+
+};
diff --git a/arch/powerpc/configs/ucp1020_defconfig b/arch/powerpc/configs/ucp1020_defconfig
new file mode 100644
index 0000000..62f99aa
--- /dev/null
+++ b/arch/powerpc/configs/ucp1020_defconfig
@@ -0,0 +1,2731 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Linux/powerpc 4.0.0 Kernel Configuration
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_PPC_BOOK3S_32 is not set
+CONFIG_PPC_85xx=y
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_E500=y
+# CONFIG_PPC_E500MC is not set
+CONFIG_FSL_EMB_PERFMON=y
+CONFIG_BOOKE=y
+CONFIG_FSL_BOOKE=y
+CONFIG_PPC_FSL_BOOK3E=y
+# CONFIG_PHYS_64BIT is not set
+CONFIG_SPE_POSSIBLE=y
+CONFIG_SPE=y
+CONFIG_PPC_MMU_NOHASH=y
+CONFIG_PPC_BOOK3E_MMU=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+CONFIG_PPC_DOORBELL=y
+CONFIG_CPU_BIG_ENDIAN=y
+# CONFIG_CPU_LITTLE_ENDIAN is not set
+CONFIG_PPC32=y
+CONFIG_32BIT=y
+CONFIG_WORD_SIZE=32
+# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
+# CONFIG_ARCH_DMA_ADDR_T_64BIT is not set
+CONFIG_MMU=y
+# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
+# CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
+CONFIG_NR_IRQS=512
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_LOCKBREAK=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_PPC=y
+# CONFIG_GENERIC_CSUM is not set
+CONFIG_EARLY_PRINTK=y
+CONFIG_PANIC_TIMEOUT=180
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_PPC_UDBG_16550=y
+CONFIG_GENERIC_TBSYNC=y
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+# CONFIG_EPAPR_BOOT is not set
+CONFIG_DEFAULT_UIMAGE=y
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
+CONFIG_ARCH_SUPPORTS_UPROBES=y
+CONFIG_PPC_ADV_DEBUG_REGS=y
+CONFIG_PPC_ADV_DEBUG_IACS=2
+CONFIG_PPC_ADV_DEBUG_DACS=2
+CONFIG_PPC_ADV_DEBUG_DVCS=0
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_IRQ_WORK=y
+
+#
+# General setup
+#
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE="powerpc-linux-"
+# CONFIG_COMPILE_TEST is not set
+CONFIG_LOCALVERSION=""
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEFAULT_HOSTNAME="uCP1020"
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+CONFIG_CROSS_MEMORY_ATTACH=y
+# CONFIG_FHANDLE is not set
+CONFIG_USELIB=y
+CONFIG_AUDIT=y
+CONFIG_HAVE_ARCH_AUDITSYSCALL=y
+# CONFIG_AUDITSYSCALL is not set
+
+#
+# IRQ subsystem
+#
+CONFIG_GENERIC_IRQ_SHOW=y
+CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
+CONFIG_IRQ_DOMAIN=y
+CONFIG_GENERIC_MSI_IRQ=y
+CONFIG_IRQ_FORCED_THREADING=y
+CONFIG_SPARSE_IRQ=y
+CONFIG_GENERIC_TIME_VSYSCALL_OLD=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+CONFIG_ARCH_HAS_TICK_BROADCAST=y
+CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+
+#
+# Timers subsystem
+#
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ_COMMON=y
+# CONFIG_HZ_PERIODIC is not set
+CONFIG_NO_HZ_IDLE=y
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+
+#
+# CPU/Task time and stats accounting
+#
+CONFIG_TICK_CPU_ACCOUNTING=y
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_PREEMPT_RCU=y
+CONFIG_SRCU=y
+# CONFIG_TASKS_RCU is not set
+CONFIG_RCU_STALL_COMMON=y
+CONFIG_RCU_FANOUT=32
+CONFIG_RCU_FANOUT_LEAF=16
+# CONFIG_RCU_FANOUT_EXACT is not set
+# CONFIG_RCU_FAST_NO_HZ is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_RCU_BOOST is not set
+CONFIG_RCU_KTHREAD_PRIO=0
+# CONFIG_RCU_NOCB_CPU is not set
+CONFIG_BUILD_BIN2C=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_LOG_CPU_MAX_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+# CONFIG_CHECKPOINT_RESTORE is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_SCHED_AUTOGROUP is not set
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_SYSCTL_EXCEPTION_TRACE=y
+CONFIG_BPF=y
+CONFIG_EXPERT=y
+CONFIG_SGETMASK_SYSCALL=y
+CONFIG_SYSFS_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+# CONFIG_BPF_SYSCALL is not set
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+CONFIG_ADVISE_SYSCALLS=y
+CONFIG_PCI_QUIRKS=y
+CONFIG_EMBEDDED=y
+CONFIG_HAVE_PERF_EVENTS=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_PERF_EVENTS is not set
+CONFIG_VM_EVENT_COUNTERS=y
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+CONFIG_SLUB_CPU_PARTIAL=y
+# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_JUMP_LABEL=y
+# CONFIG_UPROBES is not set
+# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
+CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
+CONFIG_ARCH_USE_BUILTIN_BSWAP=y
+CONFIG_HAVE_IOREMAP_PROT=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_ARCH_TRACEHOOK=y
+CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_GENERIC_SMP_IDLE_THREAD=y
+CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
+CONFIG_HAVE_DMA_API_DEBUG=y
+CONFIG_HAVE_ARCH_JUMP_LABEL=y
+CONFIG_HAVE_RCU_TABLE_FREE=y
+CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
+CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
+# CONFIG_CC_STACKPROTECTOR is not set
+CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
+CONFIG_MODULES_USE_ELF_RELA=y
+CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
+CONFIG_CLONE_BACKWARDS=y
+CONFIG_OLD_SIGSUSPEND=y
+CONFIG_OLD_SIGACTION=y
+
+#
+# GCOV-based kernel profiling
+#
+CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+# CONFIG_MODULE_SIG is not set
+# CONFIG_MODULE_COMPRESS is not set
+CONFIG_STOP_MACHINE=y
+CONFIG_BLOCK=y
+CONFIG_LBDAF=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_BSGLIB is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+# CONFIG_BLK_CMDLINE_PARSER is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_AIX_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+CONFIG_MAC_PARTITION=y
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
+# CONFIG_CMDLINE_PARTITION is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_DEFAULT_DEADLINE=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="deadline"
+CONFIG_UNINLINE_SPIN_UNLOCK=y
+CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
+CONFIG_MUTEX_SPIN_ON_OWNER=y
+CONFIG_RWSEM_SPIN_ON_OWNER=y
+CONFIG_LOCK_SPIN_ON_OWNER=y
+CONFIG_FREEZER=y
+CONFIG_PPC_MSI_BITMAP=y
+# CONFIG_PPC_XICS is not set
+# CONFIG_PPC_ICP_NATIVE is not set
+# CONFIG_PPC_ICP_HV is not set
+# CONFIG_PPC_ICS_RTAS is not set
+# CONFIG_GE_FPGA is not set
+
+#
+# Platform support
+#
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PQ2ADS is not set
+CONFIG_FSL_SOC_BOOKE=y
+# CONFIG_BSC9131_RDB is not set
+# CONFIG_C293_PCIE is not set
+# CONFIG_BSC9132_QDS is not set
+# CONFIG_MPC8540_ADS is not set
+# CONFIG_MPC8560_ADS is not set
+# CONFIG_MPC85xx_CDS is not set
+# CONFIG_MPC85xx_MDS is not set
+# CONFIG_MPC8536_DS is not set
+# CONFIG_MPC85xx_DS is not set
+# CONFIG_MPC85xx_RDB is not set
+# CONFIG_P1010_RDB is not set
+# CONFIG_P1022_DS is not set
+# CONFIG_P1022_RDK is not set
+# CONFIG_P1023_RDB is not set
+# CONFIG_TWR_P102x is not set
+# CONFIG_SOCRATES is not set
+# CONFIG_KSI8560 is not set
+# CONFIG_XES_MPC85xx is not set
+# CONFIG_STX_GP3 is not set
+# CONFIG_TQM8540 is not set
+# CONFIG_TQM8541 is not set
+# CONFIG_TQM8548 is not set
+# CONFIG_TQM8555 is not set
+# CONFIG_TQM8560 is not set
+# CONFIG_SBC8548 is not set
+# CONFIG_PPA8548 is not set
+# CONFIG_GE_IMP3A is not set
+CONFIG_UCP1020_SOM=y
+# CONFIG_MVME2500 is not set
+# CONFIG_PPC_QEMU_E500 is not set
+# CONFIG_CORENET_GENERIC is not set
+# CONFIG_KVM_GUEST is not set
+# CONFIG_EPAPR_PARAVIRT is not set
+CONFIG_PPC_SMP_MUXED_IPI=y
+# CONFIG_IPIC is not set
+CONFIG_MPIC=y
+# CONFIG_MPIC_TIMER is not set
+# CONFIG_PPC_EPAPR_HV_PIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_MPIC_MSGR is not set
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_MPIC_U3_HT_IRQS is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_P7_NAP is not set
+
+#
+# CPU Frequency scaling
+#
+# CONFIG_CPU_FREQ is not set
+
+#
+# CPUIdle driver
+#
+
+#
+# CPU Idle
+#
+# CONFIG_CPU_IDLE is not set
+# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
+# CONFIG_QUICC_ENGINE is not set
+# CONFIG_CPM2 is not set
+# CONFIG_FSL_ULI1575 is not set
+# CONFIG_SIMPLE_GPIO is not set
+
+#
+# Kernel options
+#
+CONFIG_HIGHMEM=y
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+# CONFIG_SCHED_HRTICK is not set
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=y
+CONFIG_PREEMPT_COUNT=y
+CONFIG_BINFMT_ELF=y
+CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_BINFMT_SCRIPT=y
+# CONFIG_HAVE_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
+CONFIG_COREDUMP=y
+CONFIG_MATH_EMULATION=y
+CONFIG_MATH_EMULATION_FULL=y
+# CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED is not set
+CONFIG_IOMMU_HELPER=y
+CONFIG_SWIOTLB=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_ARCH_CPU_PROBE_RELEASE=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_HAS_WALK_MEMORY=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
+# CONFIG_KEXEC is not set
+# CONFIG_CRASH_DUMP is not set
+# CONFIG_IRQ_ALL_CPUS is not set
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_HAVE_MEMBLOCK=y
+CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
+CONFIG_HAVE_GENERIC_RCU_GUP=y
+CONFIG_NO_BOOTMEM=y
+# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_COMPACTION is not set
+CONFIG_MIGRATION=y
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+# CONFIG_CLEANCACHE is not set
+# CONFIG_CMA is not set
+# CONFIG_ZPOOL is not set
+# CONFIG_ZBUD is not set
+# CONFIG_ZSMALLOC is not set
+CONFIG_PPC_4K_PAGES=y
+CONFIG_FORCE_MAX_ZONEORDER=11
+# CONFIG_PPC_COPRO_BASE is not set
+# CONFIG_CMDLINE_BOOL is not set
+CONFIG_EXTRA_TARGETS=""
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+CONFIG_PM_SLEEP=y
+CONFIG_PM_SLEEP_SMP=y
+# CONFIG_PM_AUTOSLEEP is not set
+# CONFIG_PM_WAKELOCKS is not set
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+# CONFIG_NEED_DMA_MAP_STATE is not set
+CONFIG_NEED_SG_DMA_LENGTH=y
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_FSL_SOC=y
+CONFIG_FSL_PCI=y
+CONFIG_FSL_PMC=y
+CONFIG_FSL_LBC=y
+CONFIG_PPC_PCI_CHOICE=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+CONFIG_PCIEPORTBUS=y
+# CONFIG_PCIEAER is not set
+# CONFIG_PCIEASPM is not set
+CONFIG_PCIE_PME=y
+CONFIG_PCI_MSI=y
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
+# CONFIG_PCI_PRI is not set
+# CONFIG_PCI_PASID is not set
+
+#
+# PCI host controller drivers
+#
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
+# CONFIG_HAS_RAPIDIO is not set
+# CONFIG_RAPIDIO is not set
+# CONFIG_NONSTATIC_KERNEL is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_LOWMEM_CAM_NUM=3
+CONFIG_PAGE_OFFSET=0xc0000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_PHYSICAL_START=0x00000000
+CONFIG_PHYSICAL_ALIGN=0x04000000
+CONFIG_TASK_SIZE=0xc0000000
+# CONFIG_ARCH_RANDOM is not set
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_DIAG is not set
+CONFIG_UNIX=y
+# CONFIG_UNIX_DIAG is not set
+CONFIG_XFRM=y
+CONFIG_XFRM_ALGO=y
+CONFIG_XFRM_USER=y
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+CONFIG_NET_KEY=y
+# CONFIG_NET_KEY_MIGRATE is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE_DEMUX is not set
+# CONFIG_NET_IP_TUNNEL is not set
+# CONFIG_IP_MROUTE is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_NET_UDP_TUNNEL is not set
+# CONFIG_NET_FOU is not set
+# CONFIG_GENEVE is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_UDP_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+CONFIG_NET_PTP_CLASSIFY=y
+# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+CONFIG_NETFILTER_ADVANCED=y
+CONFIG_BRIDGE_NETFILTER=y
+
+#
+# Core Netfilter Configuration
+#
+# CONFIG_NETFILTER_NETLINK_ACCT is not set
+# CONFIG_NETFILTER_NETLINK_QUEUE is not set
+# CONFIG_NETFILTER_NETLINK_LOG is not set
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NF_CONNTRACK_PROCFS=y
+# CONFIG_NF_CONNTRACK_EVENTS is not set
+# CONFIG_NF_CONNTRACK_TIMEOUT is not set
+# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
+# CONFIG_NF_CT_PROTO_DCCP is not set
+# CONFIG_NF_CT_PROTO_SCTP is not set
+# CONFIG_NF_CT_PROTO_UDPLITE is not set
+# CONFIG_NF_CONNTRACK_AMANDA is not set
+CONFIG_NF_CONNTRACK_FTP=y
+# CONFIG_NF_CONNTRACK_H323 is not set
+# CONFIG_NF_CONNTRACK_IRC is not set
+# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
+# CONFIG_NF_CONNTRACK_SNMP is not set
+# CONFIG_NF_CONNTRACK_PPTP is not set
+# CONFIG_NF_CONNTRACK_SANE is not set
+# CONFIG_NF_CONNTRACK_SIP is not set
+# CONFIG_NF_CONNTRACK_TFTP is not set
+# CONFIG_NF_CT_NETLINK is not set
+# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
+CONFIG_NF_NAT=y
+CONFIG_NF_NAT_NEEDED=y
+# CONFIG_NF_NAT_AMANDA is not set
+CONFIG_NF_NAT_FTP=y
+# CONFIG_NF_NAT_IRC is not set
+# CONFIG_NF_NAT_SIP is not set
+# CONFIG_NF_NAT_TFTP is not set
+CONFIG_NF_NAT_REDIRECT=y
+# CONFIG_NF_TABLES is not set
+CONFIG_NETFILTER_XTABLES=y
+
+#
+# Xtables combined modules
+#
+CONFIG_NETFILTER_XT_MARK=y
+CONFIG_NETFILTER_XT_CONNMARK=y
+
+#
+# Xtables targets
+#
+# CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
+# CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set
+# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
+CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
+# CONFIG_NETFILTER_XT_TARGET_DSCP is not set
+# CONFIG_NETFILTER_XT_TARGET_HL is not set
+# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
+# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
+# CONFIG_NETFILTER_XT_TARGET_LOG is not set
+CONFIG_NETFILTER_XT_TARGET_MARK=y
+CONFIG_NETFILTER_XT_NAT=y
+CONFIG_NETFILTER_XT_TARGET_NETMAP=y
+# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
+# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
+# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
+CONFIG_NETFILTER_XT_TARGET_REDIRECT=y
+# CONFIG_NETFILTER_XT_TARGET_TEE is not set
+# CONFIG_NETFILTER_XT_TARGET_TPROXY is not set
+# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
+# CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set
+
+#
+# Xtables matches
+#
+# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
+# CONFIG_NETFILTER_XT_MATCH_BPF is not set
+# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
+CONFIG_NETFILTER_XT_MATCH_COMMENT=y
+# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
+# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
+# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
+CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
+# CONFIG_NETFILTER_XT_MATCH_CPU is not set
+# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
+# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
+# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
+# CONFIG_NETFILTER_XT_MATCH_ECN is not set
+# CONFIG_NETFILTER_XT_MATCH_ESP is not set
+# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
+CONFIG_NETFILTER_XT_MATCH_HELPER=y
+# CONFIG_NETFILTER_XT_MATCH_HL is not set
+# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
+# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
+# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
+# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
+# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
+# CONFIG_NETFILTER_XT_MATCH_MAC is not set
+CONFIG_NETFILTER_XT_MATCH_MARK=y
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
+# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
+# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
+# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
+# CONFIG_NETFILTER_XT_MATCH_PHYSDEV is not set
+# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
+# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
+# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
+# CONFIG_NETFILTER_XT_MATCH_REALM is not set
+# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
+# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
+# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
+CONFIG_NETFILTER_XT_MATCH_STATE=y
+# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
+# CONFIG_NETFILTER_XT_MATCH_STRING is not set
+# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
+# CONFIG_NETFILTER_XT_MATCH_TIME is not set
+# CONFIG_NETFILTER_XT_MATCH_U32 is not set
+# CONFIG_IP_SET is not set
+# CONFIG_IP_VS is not set
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_NF_DEFRAG_IPV4=y
+CONFIG_NF_CONNTRACK_IPV4=y
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
+# CONFIG_NF_LOG_ARP is not set
+# CONFIG_NF_LOG_IPV4 is not set
+CONFIG_NF_REJECT_IPV4=y
+CONFIG_NF_NAT_IPV4=y
+CONFIG_NF_NAT_MASQUERADE_IPV4=y
+# CONFIG_NF_NAT_PPTP is not set
+# CONFIG_NF_NAT_H323 is not set
+CONFIG_IP_NF_IPTABLES=y
+# CONFIG_IP_NF_MATCH_AH is not set
+# CONFIG_IP_NF_MATCH_ECN is not set
+# CONFIG_IP_NF_MATCH_RPFILTER is not set
+# CONFIG_IP_NF_MATCH_TTL is not set
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_TARGET_REJECT=y
+# CONFIG_IP_NF_TARGET_SYNPROXY is not set
+CONFIG_IP_NF_NAT=y
+CONFIG_IP_NF_TARGET_MASQUERADE=y
+CONFIG_IP_NF_TARGET_NETMAP=y
+CONFIG_IP_NF_TARGET_REDIRECT=y
+CONFIG_IP_NF_MANGLE=y
+# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
+# CONFIG_IP_NF_TARGET_ECN is not set
+# CONFIG_IP_NF_TARGET_TTL is not set
+# CONFIG_IP_NF_RAW is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+# CONFIG_BRIDGE_NF_EBTABLES is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_L2TP is not set
+CONFIG_STP=y
+CONFIG_BRIDGE=y
+CONFIG_BRIDGE_IGMP_SNOOPING=y
+# CONFIG_BRIDGE_VLAN_FILTERING is not set
+CONFIG_HAVE_NET_DSA=y
+CONFIG_VLAN_8021Q=y
+# CONFIG_VLAN_8021Q_GVRP is not set
+# CONFIG_VLAN_8021Q_MVRP is not set
+# CONFIG_DECNET is not set
+CONFIG_LLC=y
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
+CONFIG_NET_SCHED=y
+
+#
+# Queueing/Scheduling
+#
+# CONFIG_NET_SCH_CBQ is not set
+CONFIG_NET_SCH_HTB=y
+# CONFIG_NET_SCH_HFSC is not set
+# CONFIG_NET_SCH_PRIO is not set
+# CONFIG_NET_SCH_MULTIQ is not set
+# CONFIG_NET_SCH_RED is not set
+# CONFIG_NET_SCH_SFB is not set
+# CONFIG_NET_SCH_SFQ is not set
+# CONFIG_NET_SCH_TEQL is not set
+# CONFIG_NET_SCH_TBF is not set
+# CONFIG_NET_SCH_GRED is not set
+# CONFIG_NET_SCH_DSMARK is not set
+# CONFIG_NET_SCH_NETEM is not set
+# CONFIG_NET_SCH_DRR is not set
+# CONFIG_NET_SCH_MQPRIO is not set
+# CONFIG_NET_SCH_CHOKE is not set
+# CONFIG_NET_SCH_QFQ is not set
+# CONFIG_NET_SCH_CODEL is not set
+# CONFIG_NET_SCH_FQ_CODEL is not set
+# CONFIG_NET_SCH_FQ is not set
+# CONFIG_NET_SCH_HHF is not set
+# CONFIG_NET_SCH_PIE is not set
+# CONFIG_NET_SCH_PLUG is not set
+
+#
+# Classification
+#
+# CONFIG_NET_CLS_BASIC is not set
+# CONFIG_NET_CLS_TCINDEX is not set
+# CONFIG_NET_CLS_ROUTE4 is not set
+# CONFIG_NET_CLS_FW is not set
+# CONFIG_NET_CLS_U32 is not set
+# CONFIG_NET_CLS_RSVP is not set
+# CONFIG_NET_CLS_RSVP6 is not set
+# CONFIG_NET_CLS_FLOW is not set
+# CONFIG_NET_CLS_BPF is not set
+# CONFIG_NET_EMATCH is not set
+# CONFIG_NET_CLS_ACT is not set
+CONFIG_NET_SCH_FIFO=y
+# CONFIG_DCB is not set
+CONFIG_DNS_RESOLVER=y
+# CONFIG_BATMAN_ADV is not set
+# CONFIG_OPENVSWITCH is not set
+# CONFIG_VSOCKETS is not set
+# CONFIG_NETLINK_MMAP is not set
+# CONFIG_NETLINK_DIAG is not set
+# CONFIG_NET_MPLS_GSO is not set
+# CONFIG_HSR is not set
+# CONFIG_NET_SWITCHDEV is not set
+CONFIG_RPS=y
+CONFIG_RFS_ACCEL=y
+CONFIG_XPS=y
+CONFIG_NET_RX_BUSY_POLL=y
+CONFIG_BQL=y
+CONFIG_NET_FLOW_LIMIT=y
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+CONFIG_WIRELESS=y
+CONFIG_CFG80211=y
+# CONFIG_NL80211_TESTMODE is not set
+# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
+# CONFIG_CFG80211_REG_DEBUG is not set
+# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
+# CONFIG_CFG80211_DEFAULT_PS is not set
+# CONFIG_CFG80211_INTERNAL_REGDB is not set
+# CONFIG_CFG80211_WEXT is not set
+# CONFIG_LIB80211 is not set
+CONFIG_MAC80211=y
+# CONFIG_MAC80211_RC_MINSTREL is not set
+CONFIG_MAC80211_RC_DEFAULT=""
+
+#
+# Some wireless drivers require a rate control algorithm
+#
+# CONFIG_MAC80211_MESH is not set
+# CONFIG_MAC80211_MESSAGE_TRACING is not set
+# CONFIG_MAC80211_DEBUG_MENU is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
+# CONFIG_CEPH_LIB is not set
+# CONFIG_NFC is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER=y
+CONFIG_UEVENT_HELPER_PATH="/bin/hotplug"
+# CONFIG_DEVTMPFS is not set
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+CONFIG_FW_LOADER_USER_HELPER=y
+CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
+CONFIG_ALLOW_DEV_COREDUMP=y
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_GENERIC_CPU_DEVICES is not set
+# CONFIG_DMA_SHARED_BUFFER is not set
+
+#
+# Bus devices
+#
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_OF_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_FTL=y
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_SM_FTL is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+CONFIG_MTD_MODULE_ONLY=m
+CONFIG_MTD_PART_SINGLE=m
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_DATAFLASH is not set
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_SST25L=y
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOCG3 is not set
+CONFIG_MTD_NAND_ECC=y
+# CONFIG_MTD_NAND_ECC_SMC is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_ECC_BCH is not set
+# CONFIG_MTD_SM_COMMON is not set
+# CONFIG_MTD_NAND_DENALI is not set
+# CONFIG_MTD_NAND_GPIO is not set
+# CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_RICOH is not set
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_DOCG4 is not set
+# CONFIG_MTD_NAND_CAFE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+CONFIG_MTD_NAND_PLATFORM=y
+CONFIG_MTD_NAND_FSL_ELBC=y
+# CONFIG_MTD_NAND_FSL_IFC is not set
+CONFIG_MTD_NAND_FSL_UPM=y
+# CONFIG_MTD_NAND_HISI504 is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR & LPDDR2 PCM memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+CONFIG_MTD_SPI_NOR=y
+CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
+# CONFIG_MTD_UBI is not set
+CONFIG_DTC=y
+CONFIG_OF=y
+
+#
+# Device Tree and Open Firmware support
+#
+# CONFIG_OF_UNITTEST is not set
+CONFIG_OF_FLATTREE=y
+CONFIG_OF_EARLY_FLATTREE=y
+CONFIG_OF_ADDRESS=y
+CONFIG_OF_ADDRESS_PCI=y
+CONFIG_OF_IRQ=y
+CONFIG_OF_NET=y
+CONFIG_OF_MDIO=y
+CONFIG_OF_PCI=y
+CONFIG_OF_PCI_IRQ=y
+CONFIG_OF_MTD=y
+CONFIG_OF_RESERVED_MEM=y
+# CONFIG_OF_OVERLAY is not set
+CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_NULL_BLK is not set
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_DRBD is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_NVME is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=131072
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
+# CONFIG_BLK_DEV_RBD is not set
+# CONFIG_BLK_DEV_RSXX is not set
+
+#
+# Misc devices
+#
+# CONFIG_SENSORS_LIS3LV02D is not set
+# CONFIG_AD525X_DPOT is not set
+# CONFIG_DUMMY_IRQ is not set
+# CONFIG_PHANTOM is not set
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+# CONFIG_ICS932S401 is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_HP_ILO is not set
+# CONFIG_APDS9802ALS is not set
+# CONFIG_ISL29003 is not set
+# CONFIG_ISL29020 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_SENSORS_BH1780 is not set
+# CONFIG_SENSORS_BH1770 is not set
+# CONFIG_SENSORS_APDS990X is not set
+# CONFIG_HMC6352 is not set
+# CONFIG_DS1682 is not set
+# CONFIG_TI_DAC7512 is not set
+# CONFIG_BMP085_I2C is not set
+# CONFIG_BMP085_SPI is not set
+# CONFIG_USB_SWITCH_FSA9480 is not set
+# CONFIG_LATTICE_ECP3_CONFIG is not set
+# CONFIG_SRAM is not set
+# CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_AT25=y
+# CONFIG_EEPROM_LEGACY is not set
+# CONFIG_EEPROM_MAX6875 is not set
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_EEPROM_93XX46 is not set
+# CONFIG_CB710_CORE is not set
+
+#
+# Texas Instruments shared transport line discipline
+#
+# CONFIG_TI_ST is not set
+# CONFIG_SENSORS_LIS3_SPI is not set
+# CONFIG_SENSORS_LIS3_I2C is not set
+
+#
+# Altera FPGA firmware download module
+#
+# CONFIG_ALTERA_STAPL is not set
+
+#
+# Intel MIC Bus Driver
+#
+
+#
+# Intel MIC Host Driver
+#
+
+#
+# Intel MIC Card Driver
+#
+# CONFIG_ECHO is not set
+# CONFIG_CXL_BASE is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI_MOD=y
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_SCSI_MQ_DEFAULT is not set
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=y
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=y
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+CONFIG_CHR_DEV_SG=y
+# CONFIG_CHR_DEV_SCH is not set
+# CONFIG_SCSI_CONSTANTS is not set
+CONFIG_SCSI_LOGGING=y
+# CONFIG_SCSI_SCAN_ASYNC is not set
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+CONFIG_SCSI_LOWLEVEL=y
+# CONFIG_ISCSI_TCP is not set
+# CONFIG_ISCSI_BOOT_SYSFS is not set
+# CONFIG_SCSI_CXGB3_ISCSI is not set
+# CONFIG_SCSI_CXGB4_ISCSI is not set
+# CONFIG_SCSI_BNX2_ISCSI is not set
+# CONFIG_BE2ISCSI is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_HPSA is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_3W_SAS is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_MVSAS is not set
+# CONFIG_SCSI_MVUMI is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ADVANSYS is not set
+# CONFIG_SCSI_ARCMSR is not set
+# CONFIG_SCSI_ESAS2R is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_MPT2SAS is not set
+# CONFIG_SCSI_MPT3SAS is not set
+# CONFIG_SCSI_UFSHCD is not set
+# CONFIG_SCSI_HPTIOP is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_AM53C974 is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_WD719X is not set
+# CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_PMCRAID is not set
+# CONFIG_SCSI_PM8001 is not set
+# CONFIG_SCSI_DH is not set
+# CONFIG_SCSI_OSD_INITIATOR is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+# CONFIG_TARGET_CORE is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_FIREWIRE_NOSY is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=y
+CONFIG_NET_CORE=y
+# CONFIG_BONDING is not set
+# CONFIG_DUMMY is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_NET_FC is not set
+# CONFIG_NET_TEAM is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_VXLAN is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_NLMON is not set
+# CONFIG_ARCNET is not set
+
+#
+# CAIF transport drivers
+#
+
+#
+# Distributed Switch Architecture drivers
+#
+# CONFIG_NET_DSA_MV88E6XXX is not set
+# CONFIG_NET_DSA_MV88E6060 is not set
+# CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set
+# CONFIG_NET_DSA_MV88E6131 is not set
+# CONFIG_NET_DSA_MV88E6123_61_65 is not set
+# CONFIG_NET_DSA_MV88E6171 is not set
+# CONFIG_NET_DSA_MV88E6352 is not set
+# CONFIG_NET_DSA_BCM_SF2 is not set
+CONFIG_ETHERNET=y
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_ADAPTEC is not set
+# CONFIG_NET_VENDOR_AGERE is not set
+# CONFIG_NET_VENDOR_ALTEON is not set
+# CONFIG_ALTERA_TSE is not set
+# CONFIG_NET_VENDOR_AMD is not set
+# CONFIG_NET_XGENE is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_ATHEROS is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_BROCADE is not set
+# CONFIG_NET_VENDOR_CHELSIO is not set
+# CONFIG_NET_VENDOR_CISCO is not set
+# CONFIG_DNET is not set
+# CONFIG_NET_VENDOR_DEC is not set
+# CONFIG_NET_VENDOR_DLINK is not set
+# CONFIG_NET_VENDOR_EMULEX is not set
+# CONFIG_NET_VENDOR_EXAR is not set
+CONFIG_NET_VENDOR_FREESCALE=y
+CONFIG_FSL_PQ_MDIO=y
+# CONFIG_FSL_XGMAC_MDIO is not set
+CONFIG_GIANFAR=y
+# CONFIG_NET_VENDOR_HP is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_IP1000 is not set
+# CONFIG_JME is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MELLANOX is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_MYRI is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NVIDIA is not set
+# CONFIG_NET_VENDOR_OKI is not set
+# CONFIG_ETHOC is not set
+# CONFIG_NET_PACKET_ENGINE is not set
+# CONFIG_NET_VENDOR_QLOGIC is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
+# CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SILAN is not set
+# CONFIG_NET_VENDOR_SIS is not set
+# CONFIG_SFC is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_SUN is not set
+# CONFIG_NET_VENDOR_TEHUTI is not set
+# CONFIG_NET_VENDOR_TI is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_NET_VENDOR_XILINX is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_AT803X_PHY is not set
+# CONFIG_AMD_PHY is not set
+# CONFIG_AMD_XGBE_PHY is not set
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_BCM7XXX_PHY is not set
+# CONFIG_BCM87XX_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_NATIONAL_PHY is not set
+# CONFIG_STE10XP is not set
+# CONFIG_LSI_ET1011C_PHY is not set
+CONFIG_MICREL_PHY=y
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+# CONFIG_MDIO_BUS_MUX_GPIO is not set
+# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
+# CONFIG_MDIO_BCM_UNIMAC is not set
+# CONFIG_MICREL_KS8995MA is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+CONFIG_USB_NET_DRIVERS=y
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_RTL8152 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_USB_IPHETH is not set
+CONFIG_WLAN=y
+# CONFIG_LIBERTAS_THINFIRM is not set
+# CONFIG_AIRO is not set
+# CONFIG_ATMEL is not set
+# CONFIG_AT76C50X_USB is not set
+# CONFIG_PRISM54 is not set
+# CONFIG_USB_ZD1201 is not set
+# CONFIG_USB_NET_RNDIS_WLAN is not set
+# CONFIG_RTL8180 is not set
+# CONFIG_RTL8187 is not set
+# CONFIG_ADM8211 is not set
+# CONFIG_MAC80211_HWSIM is not set
+# CONFIG_MWL8K is not set
+# CONFIG_ATH_CARDS is not set
+# CONFIG_B43 is not set
+# CONFIG_B43LEGACY is not set
+# CONFIG_BRCMSMAC is not set
+# CONFIG_BRCMFMAC is not set
+# CONFIG_HOSTAP is not set
+# CONFIG_IPW2100 is not set
+# CONFIG_IPW2200 is not set
+CONFIG_IWLWIFI=y
+CONFIG_IWLDVM=y
+# CONFIG_IWLMVM is not set
+
+#
+# Debugging Options
+#
+# CONFIG_IWLWIFI_DEBUG is not set
+# CONFIG_IWL4965 is not set
+# CONFIG_IWL3945 is not set
+# CONFIG_LIBERTAS is not set
+# CONFIG_HERMES is not set
+# CONFIG_P54_COMMON is not set
+# CONFIG_RT2X00 is not set
+CONFIG_RTL_CARDS=y
+# CONFIG_RTL8192CE is not set
+# CONFIG_RTL8192SE is not set
+# CONFIG_RTL8192DE is not set
+# CONFIG_RTL8723AE is not set
+# CONFIG_RTL8723BE is not set
+# CONFIG_RTL8188EE is not set
+# CONFIG_RTL8192EE is not set
+# CONFIG_RTL8821AE is not set
+# CONFIG_RTL8192CU is not set
+# CONFIG_WL_TI is not set
+# CONFIG_ZD1211RW is not set
+# CONFIG_MWIFIEX is not set
+# CONFIG_CW1200 is not set
+# CONFIG_RSI_91X is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+# CONFIG_WAN is not set
+# CONFIG_VMXNET3 is not set
+# CONFIG_ISDN is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
+# CONFIG_INPUT_MATRIXKMAP is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO_XILINX_XPS_PS2 is not set
+# CONFIG_SERIO_ALTERA_PS2 is not set
+# CONFIG_SERIO_PS2MULT is not set
+# CONFIG_SERIO_ARC_PS2 is not set
+# CONFIG_SERIO_APBPS2 is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_TTY=y
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_VT_CONSOLE_SLEEP=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=16
+# CONFIG_SERIAL_NONSTANDARD is not set
+CONFIG_NOZOMI=y
+# CONFIG_N_GSM is not set
+# CONFIG_TRACE_SINK is not set
+# CONFIG_PPC_EPAPR_HV_BYTECHAN is not set
+CONFIG_DEVMEM=y
+CONFIG_DEVKMEM=y
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_EARLYCON=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DMA=y
+CONFIG_SERIAL_8250_PCI=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_DETECT_IRQ=y
+CONFIG_SERIAL_8250_RSA=y
+CONFIG_SERIAL_8250_FSL=y
+# CONFIG_SERIAL_8250_DW is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_MAX3100 is not set
+# CONFIG_SERIAL_MAX310X is not set
+# CONFIG_SERIAL_MFD_HSU is not set
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_OF_PLATFORM is not set
+# CONFIG_SERIAL_SCCNXP is not set
+# CONFIG_SERIAL_SC16IS7XX is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
+# CONFIG_SERIAL_IFX6X60 is not set
+# CONFIG_SERIAL_XILINX_PS_UART is not set
+# CONFIG_SERIAL_ARC is not set
+# CONFIG_SERIAL_RP2 is not set
+# CONFIG_SERIAL_FSL_LPUART is not set
+# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
+# CONFIG_TTY_PRINTK is not set
+# CONFIG_HVC_UDBG is not set
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_HW_RANDOM_TIMERIOMEM is not set
+CONFIG_NVRAM=y
+# CONFIG_GEN_RTC is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+# CONFIG_XILLYBUS is not set
+
+#
+# I2C support
+#
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_COMPAT=y
+CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_MUX is not set
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# PC SMBus host controller drivers
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_ISCH is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_CBUS_GPIO is not set
+# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
+# CONFIG_I2C_DESIGNWARE_PCI is not set
+# CONFIG_I2C_GPIO is not set
+CONFIG_I2C_MPC=y
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_PXA_PCI is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_XILINX is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_DIOLAN_U2C is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_TINY_USB is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_SLAVE is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+# CONFIG_SPI_ALTERA is not set
+CONFIG_SPI_BITBANG=y
+# CONFIG_SPI_GPIO is not set
+CONFIG_SPI_FSL_LIB=y
+# CONFIG_SPI_FSL_SPI is not set
+CONFIG_SPI_FSL_ESPI=y
+# CONFIG_SPI_OC_TINY is not set
+# CONFIG_SPI_PXA2XX is not set
+# CONFIG_SPI_PXA2XX_PCI is not set
+# CONFIG_SPI_SC18IS602 is not set
+# CONFIG_SPI_XCOMM is not set
+# CONFIG_SPI_XILINX is not set
+# CONFIG_SPI_DESIGNWARE is not set
+
+#
+# SPI Protocol Masters
+#
+CONFIG_SPI_SPIDEV=y
+# CONFIG_SPI_TLE62X0 is not set
+# CONFIG_SPMI is not set
+# CONFIG_HSI is not set
+
+#
+# PPS support
+#
+CONFIG_PPS=y
+# CONFIG_PPS_DEBUG is not set
+# CONFIG_NTP_PPS is not set
+
+#
+# PPS clients support
+#
+# CONFIG_PPS_CLIENT_KTIMER is not set
+# CONFIG_PPS_CLIENT_LDISC is not set
+# CONFIG_PPS_CLIENT_GPIO is not set
+
+#
+# PPS generators support
+#
+
+#
+# PTP clock support
+#
+CONFIG_PTP_1588_CLOCK=y
+CONFIG_PTP_1588_CLOCK_GIANFAR=y
+
+#
+# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
+#
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_DEVRES=y
+CONFIG_OF_GPIO=y
+# CONFIG_DEBUG_GPIO is not set
+# CONFIG_GPIO_SYSFS is not set
+
+#
+# Memory mapped GPIO drivers:
+#
+# CONFIG_GPIO_74XX_MMIO is not set
+# CONFIG_GPIO_GENERIC_PLATFORM is not set
+CONFIG_GPIO_MPC8XXX=y
+# CONFIG_GPIO_SCH311X is not set
+# CONFIG_GPIO_XILINX is not set
+# CONFIG_GPIO_VX855 is not set
+# CONFIG_GPIO_GRGPIO is not set
+
+#
+# I2C GPIO expanders:
+#
+# CONFIG_GPIO_MAX7300 is not set
+# CONFIG_GPIO_MAX732X is not set
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
+# CONFIG_GPIO_SX150X is not set
+# CONFIG_GPIO_ADP5588 is not set
+# CONFIG_GPIO_ADNP is not set
+
+#
+# PCI GPIO expanders:
+#
+# CONFIG_GPIO_BT8XX is not set
+# CONFIG_GPIO_AMD8111 is not set
+# CONFIG_GPIO_ML_IOH is not set
+# CONFIG_GPIO_RDC321X is not set
+
+#
+# SPI GPIO expanders:
+#
+# CONFIG_GPIO_MAX7301 is not set
+# CONFIG_GPIO_MCP23S08 is not set
+# CONFIG_GPIO_MC33880 is not set
+# CONFIG_GPIO_74X164 is not set
+
+#
+# AC97 GPIO expanders:
+#
+
+#
+# LPC GPIO expanders:
+#
+
+#
+# MODULbus GPIO expanders:
+#
+
+#
+# USB GPIO expanders:
+#
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_POWER_AVS is not set
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Native drivers
+#
+# CONFIG_SENSORS_AD7314 is not set
+# CONFIG_SENSORS_AD7414 is not set
+# CONFIG_SENSORS_AD7418 is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
+# CONFIG_SENSORS_ADT7310 is not set
+# CONFIG_SENSORS_ADT7410 is not set
+# CONFIG_SENSORS_ADT7411 is not set
+# CONFIG_SENSORS_ADT7462 is not set
+# CONFIG_SENSORS_ADT7470 is not set
+# CONFIG_SENSORS_ADT7475 is not set
+# CONFIG_SENSORS_ASC7621 is not set
+# CONFIG_SENSORS_ATXP1 is not set
+# CONFIG_SENSORS_DS620 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_I5K_AMB is not set
+# CONFIG_SENSORS_F75375S is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_G760A is not set
+# CONFIG_SENSORS_G762 is not set
+# CONFIG_SENSORS_GPIO_FAN is not set
+# CONFIG_SENSORS_HIH6130 is not set
+# CONFIG_SENSORS_JC42 is not set
+# CONFIG_SENSORS_POWR1220 is not set
+# CONFIG_SENSORS_LINEAGE is not set
+# CONFIG_SENSORS_LTC2945 is not set
+# CONFIG_SENSORS_LTC4151 is not set
+# CONFIG_SENSORS_LTC4215 is not set
+# CONFIG_SENSORS_LTC4222 is not set
+# CONFIG_SENSORS_LTC4245 is not set
+# CONFIG_SENSORS_LTC4260 is not set
+# CONFIG_SENSORS_LTC4261 is not set
+# CONFIG_SENSORS_MAX1111 is not set
+# CONFIG_SENSORS_MAX16065 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_MAX1668 is not set
+# CONFIG_SENSORS_MAX197 is not set
+# CONFIG_SENSORS_MAX6639 is not set
+# CONFIG_SENSORS_MAX6642 is not set
+# CONFIG_SENSORS_MAX6650 is not set
+# CONFIG_SENSORS_MAX6697 is not set
+# CONFIG_SENSORS_HTU21 is not set
+# CONFIG_SENSORS_MCP3021 is not set
+# CONFIG_SENSORS_ADCXX is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM70 is not set
+# CONFIG_SENSORS_LM73 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+CONFIG_SENSORS_LM90=y
+# CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_LM93 is not set
+# CONFIG_SENSORS_LM95234 is not set
+# CONFIG_SENSORS_LM95241 is not set
+# CONFIG_SENSORS_LM95245 is not set
+# CONFIG_SENSORS_NTC_THERMISTOR is not set
+# CONFIG_SENSORS_NCT7802 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_PMBUS is not set
+# CONFIG_SENSORS_SHT15 is not set
+# CONFIG_SENSORS_SHT21 is not set
+# CONFIG_SENSORS_SHTC1 is not set
+# CONFIG_SENSORS_SIS5595 is not set
+# CONFIG_SENSORS_EMC1403 is not set
+# CONFIG_SENSORS_EMC2103 is not set
+# CONFIG_SENSORS_EMC6W201 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
+# CONFIG_SENSORS_SCH56XX_COMMON is not set
+# CONFIG_SENSORS_SMM665 is not set
+# CONFIG_SENSORS_ADC128D818 is not set
+# CONFIG_SENSORS_ADS1015 is not set
+# CONFIG_SENSORS_ADS7828 is not set
+# CONFIG_SENSORS_ADS7871 is not set
+# CONFIG_SENSORS_AMC6821 is not set
+# CONFIG_SENSORS_INA209 is not set
+# CONFIG_SENSORS_INA2XX is not set
+# CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_TMP102 is not set
+# CONFIG_SENSORS_TMP103 is not set
+# CONFIG_SENSORS_TMP401 is not set
+# CONFIG_SENSORS_TMP421 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_VT8231 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83791D is not set
+# CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83793 is not set
+# CONFIG_SENSORS_W83795 is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83L786NG is not set
+CONFIG_THERMAL=y
+CONFIG_THERMAL_HWMON=y
+CONFIG_THERMAL_OF=y
+CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
+# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
+# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
+# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
+CONFIG_THERMAL_GOV_STEP_WISE=y
+# CONFIG_THERMAL_GOV_BANG_BANG is not set
+# CONFIG_THERMAL_GOV_USER_SPACE is not set
+# CONFIG_THERMAL_EMULATION is not set
+
+#
+# Texas Instruments thermal drivers
+#
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_CORE=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_GPIO_WATCHDOG is not set
+# CONFIG_XILINX_WATCHDOG is not set
+# CONFIG_DW_WATCHDOG is not set
+# CONFIG_ALIM7101_WDT is not set
+# CONFIG_I6300ESB_WDT is not set
+CONFIG_BOOKE_WDT=y
+CONFIG_BOOKE_WDT_DEFAULT_TIMEOUT=36
+# CONFIG_MEN_A21_WDT is not set
+
+#
+# PCI-based Watchdog Cards
+#
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
+
+#
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+CONFIG_BCMA_POSSIBLE=y
+
+#
+# Broadcom specific AMBA
+#
+# CONFIG_BCMA is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_AS3711 is not set
+# CONFIG_MFD_AS3722 is not set
+# CONFIG_PMIC_ADP5520 is not set
+# CONFIG_MFD_AAT2870_CORE is not set
+# CONFIG_MFD_ATMEL_HLCDC is not set
+# CONFIG_MFD_BCM590XX is not set
+# CONFIG_MFD_AXP20X is not set
+# CONFIG_MFD_CROS_EC is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_DA9052_SPI is not set
+# CONFIG_MFD_DA9052_I2C is not set
+# CONFIG_MFD_DA9055 is not set
+# CONFIG_MFD_DA9063 is not set
+# CONFIG_MFD_DA9150 is not set
+# CONFIG_MFD_DLN2 is not set
+# CONFIG_MFD_MC13XXX_SPI is not set
+# CONFIG_MFD_MC13XXX_I2C is not set
+# CONFIG_MFD_HI6421_PMIC is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_HTC_I2CPLD is not set
+# CONFIG_LPC_ICH is not set
+# CONFIG_LPC_SCH is not set
+# CONFIG_INTEL_SOC_PMIC is not set
+# CONFIG_MFD_JANZ_CMODIO is not set
+# CONFIG_MFD_KEMPLD is not set
+# CONFIG_MFD_88PM800 is not set
+# CONFIG_MFD_88PM805 is not set
+# CONFIG_MFD_88PM860X is not set
+# CONFIG_MFD_MAX14577 is not set
+# CONFIG_MFD_MAX77686 is not set
+# CONFIG_MFD_MAX77693 is not set
+# CONFIG_MFD_MAX8907 is not set
+# CONFIG_MFD_MAX8925 is not set
+# CONFIG_MFD_MAX8997 is not set
+# CONFIG_MFD_MAX8998 is not set
+# CONFIG_MFD_MENF21BMC is not set
+# CONFIG_EZX_PCAP is not set
+# CONFIG_MFD_VIPERBOARD is not set
+# CONFIG_MFD_RETU is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_MFD_RDC321X is not set
+# CONFIG_MFD_RTSX_PCI is not set
+# CONFIG_MFD_RT5033 is not set
+# CONFIG_MFD_RTSX_USB is not set
+# CONFIG_MFD_RC5T583 is not set
+# CONFIG_MFD_RK808 is not set
+# CONFIG_MFD_RN5T618 is not set
+# CONFIG_MFD_SEC_CORE is not set
+# CONFIG_MFD_SI476X_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_MFD_SMSC is not set
+# CONFIG_ABX500_CORE is not set
+# CONFIG_MFD_STMPE is not set
+# CONFIG_MFD_SYSCON is not set
+# CONFIG_MFD_TI_AM335X_TSCADC is not set
+# CONFIG_MFD_LP3943 is not set
+# CONFIG_MFD_LP8788 is not set
+# CONFIG_MFD_PALMAS is not set
+# CONFIG_TPS6105X is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_TPS6507X is not set
+# CONFIG_MFD_TPS65090 is not set
+# CONFIG_MFD_TPS65217 is not set
+# CONFIG_MFD_TPS65218 is not set
+# CONFIG_MFD_TPS6586X is not set
+# CONFIG_MFD_TPS65910 is not set
+# CONFIG_MFD_TPS65912 is not set
+# CONFIG_MFD_TPS65912_I2C is not set
+# CONFIG_MFD_TPS65912_SPI is not set
+# CONFIG_MFD_TPS80031 is not set
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_TWL6040_CORE is not set
+# CONFIG_MFD_WL1273_CORE is not set
+# CONFIG_MFD_LM3533 is not set
+# CONFIG_MFD_TC3589X is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_VX855 is not set
+# CONFIG_MFD_ARIZONA_I2C is not set
+# CONFIG_MFD_ARIZONA_SPI is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X_I2C is not set
+# CONFIG_MFD_WM831X_SPI is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_WM8994 is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+# CONFIG_AGP is not set
+CONFIG_VGA_ARB=y
+CONFIG_VGA_ARB_MAX_GPUS=16
+
+#
+# Direct Rendering Manager
+#
+# CONFIG_DRM is not set
+
+#
+# Frame buffer Devices
+#
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+
+#
+# Console display driver support
+#
+CONFIG_VGA_CONSOLE=y
+# CONFIG_VGACON_SOFT_SCROLLBACK is not set
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_DUMMY_CONSOLE_COLUMNS=80
+CONFIG_DUMMY_CONSOLE_ROWS=25
+# CONFIG_SOUND is not set
+
+#
+# HID support
+#
+# CONFIG_HID is not set
+
+#
+# USB HID support
+#
+# CONFIG_USB_HID is not set
+# CONFIG_HID_PID is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+
+#
+# I2C HID support
+#
+# CONFIG_I2C_HID is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_COMMON=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEFAULT_PERSIST=y
+CONFIG_USB_DYNAMIC_MINORS=y
+# CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_OTG_FSM is not set
+CONFIG_USB_MON=y
+# CONFIG_USB_WUSB_CBAF is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_XHCI_HCD is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
+CONFIG_USB_FSL_MPH_DR_OF=y
+CONFIG_USB_EHCI_PCI=y
+# CONFIG_XPS_USB_HCD_XILINX is not set
+CONFIG_USB_EHCI_FSL=y
+CONFIG_USB_EHCI_HCD_PPC_OF=y
+# CONFIG_USB_EHCI_HCD_PLATFORM is not set
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+# CONFIG_USB_FUSBH200_HCD is not set
+# CONFIG_USB_FOTG210_HCD is not set
+# CONFIG_USB_MAX3421_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HCD_TEST_MODE is not set
+
+#
+# USB Device Class drivers
+#
+CONFIG_USB_ACM=y
+# CONFIG_USB_PRINTER is not set
+CONFIG_USB_WDM=y
+CONFIG_USB_TMC=y
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
+#
+
+#
+# also be needed; see USB_STORAGE Help for more info
+#
+CONFIG_USB_STORAGE=y
+CONFIG_USB_STORAGE_DEBUG=y
+# CONFIG_USB_STORAGE_REALTEK is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
+# CONFIG_USB_STORAGE_ENE_UB6250 is not set
+# CONFIG_USB_UAS is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+# CONFIG_USBIP_CORE is not set
+# CONFIG_USB_MUSB_HDRC is not set
+# CONFIG_USB_DWC3 is not set
+# CONFIG_USB_DWC2 is not set
+# CONFIG_USB_CHIPIDEA is not set
+# CONFIG_USB_ISP1760 is not set
+
+#
+# USB port drivers
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_SEVSEG is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_EHSET_TEST_FIXTURE is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_YUREX is not set
+# CONFIG_USB_EZUSB_FX2 is not set
+# CONFIG_USB_HSIC_USB3503 is not set
+# CONFIG_USB_LINK_LAYER_TEST is not set
+
+#
+# USB Physical Layer drivers
+#
+# CONFIG_USB_PHY is not set
+# CONFIG_NOP_USB_XCEIV is not set
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_USB_ISP1301 is not set
+# CONFIG_USB_GADGET is not set
+# CONFIG_UWB is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_CLKGATE is not set
+
+#
+# MMC/SD/SDIO Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_MINORS=8
+CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_SDIO_UART is not set
+# CONFIG_MMC_TEST is not set
+
+#
+# MMC/SD/SDIO Host Controller Drivers
+#
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_IO_ACCESSORS=y
+CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER=y
+# CONFIG_MMC_SDHCI_PCI is not set
+CONFIG_MMC_SDHCI_PLTFM=y
+# CONFIG_MMC_SDHCI_OF_ARASAN is not set
+CONFIG_MMC_SDHCI_OF_ESDHC=y
+# CONFIG_MMC_SDHCI_OF_HLWD is not set
+# CONFIG_MMC_SDHCI_F_SDH30 is not set
+# CONFIG_MMC_WBSD is not set
+# CONFIG_MMC_TIFM_SD is not set
+# CONFIG_MMC_CB710 is not set
+# CONFIG_MMC_VIA_SDMMC is not set
+# CONFIG_MMC_VUB300 is not set
+# CONFIG_MMC_USHC is not set
+# CONFIG_MMC_USDHI6ROL0 is not set
+# CONFIG_MMC_TOSHIBA_PCI is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
+# CONFIG_EDAC is not set
+# CONFIG_RTC_CLASS is not set
+CONFIG_DMADEVICES=y
+# CONFIG_DMADEVICES_DEBUG is not set
+
+#
+# DMA Devices
+#
+CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH=y
+# CONFIG_DW_DMAC_CORE is not set
+# CONFIG_DW_DMAC is not set
+# CONFIG_DW_DMAC_PCI is not set
+CONFIG_FSL_DMA=y
+# CONFIG_FSL_EDMA is not set
+CONFIG_DMA_ENGINE=y
+CONFIG_DMA_OF=y
+
+#
+# DMA Clients
+#
+CONFIG_ASYNC_TX_DMA=y
+# CONFIG_DMATEST is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+# CONFIG_VIRT_DRIVERS is not set
+
+#
+# Virtio drivers
+#
+# CONFIG_VIRTIO_PCI is not set
+# CONFIG_VIRTIO_MMIO is not set
+
+#
+# Microsoft Hyper-V guest support
+#
+# CONFIG_STAGING is not set
+
+#
+# Hardware Spinlock drivers
+#
+
+#
+# Clock Source drivers
+#
+# CONFIG_ATMEL_PIT is not set
+# CONFIG_SH_TIMER_CMT is not set
+# CONFIG_SH_TIMER_MTU2 is not set
+# CONFIG_SH_TIMER_TMU is not set
+# CONFIG_EM_TIMER_STI is not set
+# CONFIG_MAILBOX is not set
+# CONFIG_IOMMU_SUPPORT is not set
+
+#
+# Remoteproc drivers
+#
+# CONFIG_STE_MODEM_RPROC is not set
+
+#
+# Rpmsg drivers
+#
+
+#
+# SOC (System On Chip) specific Drivers
+#
+# CONFIG_SOC_TI is not set
+# CONFIG_PM_DEVFREQ is not set
+# CONFIG_EXTCON is not set
+# CONFIG_MEMORY is not set
+# CONFIG_IIO is not set
+# CONFIG_VME_BUS is not set
+# CONFIG_PWM is not set
+CONFIG_IRQCHIP=y
+# CONFIG_IPACK_BUS is not set
+# CONFIG_RESET_CONTROLLER is not set
+# CONFIG_FMC is not set
+
+#
+# PHY Subsystem
+#
+# CONFIG_GENERIC_PHY is not set
+# CONFIG_BCM_KONA_USB2_PHY is not set
+# CONFIG_POWERCAP is not set
+# CONFIG_MCB is not set
+# CONFIG_THUNDERBOLT is not set
+
+#
+# Android
+#
+# CONFIG_ANDROID is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_EXT4_FS=y
+# CONFIG_EXT4_FS_POSIX_ACL is not set
+# CONFIG_EXT4_FS_SECURITY is not set
+# CONFIG_EXT4_DEBUG is not set
+CONFIG_JBD=y
+CONFIG_JBD2=y
+# CONFIG_JBD2_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_XFS_FS=y
+# CONFIG_XFS_QUOTA is not set
+# CONFIG_XFS_POSIX_ACL is not set
+# CONFIG_XFS_RT is not set
+# CONFIG_XFS_WARN is not set
+# CONFIG_XFS_DEBUG is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+# CONFIG_FS_DAX is not set
+CONFIG_FS_POSIX_ACL=y
+CONFIG_EXPORTFS=y
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_FANOTIFY is not set
+# CONFIG_QUOTA is not set
+# CONFIG_QUOTACTL is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+# CONFIG_OVERLAY_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+CONFIG_NTFS_FS=y
+# CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_KERNFS=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=y
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_ECRYPT_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+CONFIG_JFFS2_FS_WBUF_VERIFY=y
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+CONFIG_JFFS2_FS_POSIX_ACL=y
+CONFIG_JFFS2_FS_SECURITY=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RTIME=y
+CONFIG_JFFS2_RUBIN=y
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=y
+# CONFIG_JFFS2_CMODE_SIZE is not set
+# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
+# CONFIG_LOGFS is not set
+CONFIG_CRAMFS=y
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_QNX6FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_PSTORE is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_F2FS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V2=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+CONFIG_NFS_V4=y
+# CONFIG_NFS_SWAP is not set
+# CONFIG_NFS_V4_1 is not set
+# CONFIG_NFS_USE_LEGACY_DNS is not set
+CONFIG_NFS_USE_KERNEL_DNS=y
+CONFIG_NFSD=y
+# CONFIG_NFSD_V3 is not set
+# CONFIG_NFSD_V4 is not set
+CONFIG_GRACE_PERIOD=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+# CONFIG_SUNRPC_DEBUG is not set
+# CONFIG_CEPH_FS is not set
+CONFIG_CIFS=y
+# CONFIG_CIFS_STATS is not set
+# CONFIG_CIFS_WEAK_PW_HASH is not set
+# CONFIG_CIFS_UPCALL is not set
+# CONFIG_CIFS_XATTR is not set
+CONFIG_CIFS_DEBUG=y
+# CONFIG_CIFS_DEBUG2 is not set
+# CONFIG_CIFS_DFS_UPCALL is not set
+# CONFIG_CIFS_SMB2 is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_MAC_ROMAN is not set
+# CONFIG_NLS_MAC_CELTIC is not set
+# CONFIG_NLS_MAC_CENTEURO is not set
+# CONFIG_NLS_MAC_CROATIAN is not set
+# CONFIG_NLS_MAC_CYRILLIC is not set
+# CONFIG_NLS_MAC_GAELIC is not set
+# CONFIG_NLS_MAC_GREEK is not set
+# CONFIG_NLS_MAC_ICELAND is not set
+# CONFIG_NLS_MAC_INUIT is not set
+# CONFIG_NLS_MAC_ROMANIAN is not set
+# CONFIG_NLS_MAC_TURKISH is not set
+# CONFIG_NLS_UTF8 is not set
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+# CONFIG_HAVE_ARCH_BITREVERSE is not set
+CONFIG_GENERIC_STRNCPY_FROM_USER=y
+CONFIG_GENERIC_STRNLEN_USER=y
+CONFIG_GENERIC_NET_UTILS=y
+CONFIG_GENERIC_PCI_IOMAP=y
+CONFIG_GENERIC_IO=y
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC16=y
+CONFIG_CRC_T10DIF=y
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC32=y
+# CONFIG_CRC32_SELFTEST is not set
+CONFIG_CRC32_SLICEBY8=y
+# CONFIG_CRC32_SLICEBY4 is not set
+# CONFIG_CRC32_SARWATE is not set
+# CONFIG_CRC32_BIT is not set
+# CONFIG_CRC7 is not set
+CONFIG_LIBCRC32C=y
+# CONFIG_CRC8 is not set
+# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
+# CONFIG_RANDOM32_SELFTEST is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+# CONFIG_XZ_DEC is not set
+# CONFIG_XZ_DEC_BCJ is not set
+CONFIG_DECOMPRESS_GZIP=y
+CONFIG_ASSOCIATIVE_ARRAY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT_MAP=y
+CONFIG_HAS_DMA=y
+CONFIG_CPU_RMAP=y
+CONFIG_DQL=y
+CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y
+CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
+CONFIG_AVERAGE=y
+# CONFIG_CORDIC is not set
+# CONFIG_DDR is not set
+CONFIG_LIBFDT=y
+CONFIG_OID_REGISTRY=y
+CONFIG_ARCH_HAS_SG_CHAIN=y
+
+#
+# Kernel hacking
+#
+
+#
+# printk and dmesg options
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
+
+#
+# Compile-time checks and compiler options
+#
+# CONFIG_DEBUG_INFO is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_STRIP_ASM_SYMS is not set
+# CONFIG_READABLE_ASM is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_PAGE_OWNER is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_DEBUG_SECTION_MISMATCH is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_DEBUG_KERNEL=y
+
+#
+# Memory Debugging
+#
+# CONFIG_PAGE_EXTENSION is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_SLUB_STATS is not set
+CONFIG_HAVE_DEBUG_KMEMLEAK=y
+# CONFIG_DEBUG_KMEMLEAK is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_PER_CPU_MAPS is not set
+# CONFIG_DEBUG_HIGHMEM is not set
+CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_SHIRQ is not set
+
+#
+# Debug Lockups and Hangs
+#
+# CONFIG_LOCKUP_DETECTOR is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_PANIC_ON_OOPS is not set
+CONFIG_PANIC_ON_OOPS_VALUE=0
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_SCHED_STACK_END_CHECK is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_PREEMPT is not set
+
+#
+# Lock Debugging (spinlocks, mutexes, etc...)
+#
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
+# CONFIG_DEBUG_ATOMIC_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_LOCK_TORTURE_TEST is not set
+# CONFIG_STACKTRACE is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_PI_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+
+#
+# RCU Debugging
+#
+# CONFIG_SPARSE_RCU_POINTER is not set
+# CONFIG_TORTURE_TEST is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+CONFIG_RCU_CPU_STALL_TIMEOUT=60
+# CONFIG_RCU_CPU_STALL_INFO is not set
+# CONFIG_RCU_TRACE is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_NOTIFIER_ERROR_INJECTION is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_LATENCYTOP is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+
+#
+# Runtime Testing
+#
+# CONFIG_TEST_LIST_SORT is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_RBTREE_TEST is not set
+# CONFIG_INTERVAL_TREE_TEST is not set
+# CONFIG_PERCPU_TEST is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
+# CONFIG_TEST_HEXDUMP is not set
+# CONFIG_TEST_STRING_HELPERS is not set
+# CONFIG_TEST_KSTRTOX is not set
+# CONFIG_TEST_RHASHTABLE is not set
+# CONFIG_DMA_API_DEBUG is not set
+# CONFIG_TEST_LKM is not set
+# CONFIG_TEST_USER_COPY is not set
+# CONFIG_TEST_BPF is not set
+# CONFIG_TEST_FIRMWARE is not set
+# CONFIG_TEST_UDELAY is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+# CONFIG_PPC_DISABLE_WERROR is not set
+CONFIG_PPC_WERROR=y
+CONFIG_PRINT_STACK_DEPTH=64
+# CONFIG_CODE_PATCHING_SELFTEST is not set
+# CONFIG_FTR_FIXUP_SELFTEST is not set
+# CONFIG_MSI_BITMAP_SELFTEST is not set
+# CONFIG_XMON is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+CONFIG_STRICT_DEVMEM=y
+
+#
+# Security options
+#
+CONFIG_KEYS=y
+# CONFIG_PERSISTENT_KEYRINGS is not set
+# CONFIG_BIG_KEYS is not set
+# CONFIG_ENCRYPTED_KEYS is not set
+# CONFIG_SECURITY_DMESG_RESTRICT is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD=y
+CONFIG_CRYPTO_AEAD2=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP2=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
+# CONFIG_CRYPTO_USER is not set
+CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+CONFIG_CRYPTO_GF128MUL=y
+CONFIG_CRYPTO_NULL=y
+# CONFIG_CRYPTO_PCRYPT is not set
+CONFIG_CRYPTO_WORKQUEUE=y
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_MCRYPTD is not set
+CONFIG_CRYPTO_AUTHENC=y
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+CONFIG_CRYPTO_CCM=y
+CONFIG_CRYPTO_GCM=y
+CONFIG_CRYPTO_SEQIV=y
+
+#
+# Block modes
+#
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CTR=y
+# CONFIG_CRYPTO_CTS is not set
+CONFIG_CRYPTO_ECB=y
+# CONFIG_CRYPTO_LRW is not set
+CONFIG_CRYPTO_PCBC=y
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
+CONFIG_CRYPTO_CMAC=y
+CONFIG_CRYPTO_HMAC=y
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
+
+#
+# Digest
+#
+CONFIG_CRYPTO_CRC32C=y
+# CONFIG_CRYPTO_CRC32 is not set
+CONFIG_CRYPTO_CRCT10DIF=y
+CONFIG_CRYPTO_GHASH=y
+CONFIG_CRYPTO_MD4=y
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA1_PPC=y
+CONFIG_CRYPTO_SHA256=y
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
+CONFIG_CRYPTO_AES=y
+# CONFIG_CRYPTO_ANUBIS is not set
+CONFIG_CRYPTO_ARC4=y
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
+CONFIG_CRYPTO_DEFLATE=y
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
+# CONFIG_CRYPTO_LZ4 is not set
+# CONFIG_CRYPTO_LZ4HC is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_DRBG_MENU is not set
+# CONFIG_CRYPTO_USER_API_HASH is not set
+# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
+# CONFIG_CRYPTO_USER_API_RNG is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_DEV_HIFN_795X is not set
+# CONFIG_CRYPTO_DEV_FSL_CAAM is not set
+CONFIG_CRYPTO_DEV_TALITOS=y
+# CONFIG_ASYMMETRIC_KEY_TYPE is not set
+# CONFIG_VIRTUALIZATION is not set
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 2fb4b24..1d7a7df 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -247,6 +247,13 @@ config MVME2500
 	help
 	  This option enables support for the Emerson/Artesyn MVME2500 board.
 
+config UCP1020_SOM
+	bool "Arcturus uCP1020 Rev.1.3 System on Module"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the Arcturus Networks Inc. uCP1020
+	  System on Module.
+
 endif # PPC32
 
 config PPC_QEMU_E500
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 1fe7fb9..2f5fd5e 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_GE_IMP3A)	  += ge_imp3a.o
 obj-$(CONFIG_PPC_QEMU_E500) += qemu_e500.o
 obj-$(CONFIG_SGY_CTS1000) += sgy_cts1000.o
 obj-$(CONFIG_MVME2500)	  += mvme2500.o
+obj-$(CONFIG_UCP1020_SOM) += ucp1020_som.o
diff --git a/arch/powerpc/platforms/85xx/ucp1020_som.c b/arch/powerpc/platforms/85xx/ucp1020_som.c
new file mode 100644
index 0000000..aa98d31
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/ucp1020_som.c
@@ -0,0 +1,100 @@
+/*
+ * Arcturus Networks Inc. uCP1020 system on module Setup
+ *
+ * Copyright 2014-2015 Arcturus Networks Inc.
+ *
+ * by Oleksandr G Zhadan & Michael Durrant (www.ArcturusNetworks.com)
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+#include <asm/fsl_guts.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include "smp.h"
+
+#include "mpc85xx.h"
+
+void __init ucp1020_som_pic_init(void)
+{
+	struct mpic *mpic;
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
+		mpic = mpic_alloc(NULL, 0, MPIC_NO_RESET |
+				  MPIC_BIG_ENDIAN |
+				  MPIC_SINGLE_DEST_CPU, 0, 256, " OpenPIC  ");
+	} else {
+		mpic = mpic_alloc(NULL, 0,
+				  MPIC_BIG_ENDIAN |
+				  MPIC_SINGLE_DEST_CPU, 0, 256, " OpenPIC  ");
+	}
+
+	BUG_ON(mpic == NULL);
+	mpic_init(mpic);
+}
+
+/*
+ * Setup the architecture
+ */
+static void __init ucp1020_som_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("ucp1020_som_setup_arch()", 0);
+
+	mpc85xx_smp_init();
+
+	fsl_pci_assign_primary();
+	pr_info("\n\t%s (http://www.arcturusnetworks.com)\n", ppc_md.name);
+}
+
+machine_arch_initcall(ucp1020, mpc85xx_common_publish_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init ucp1020_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "arcturus,uCP1020"))
+		return 1;
+	return 0;
+}
+
+define_machine(ucp1020)
+{
+	.name = "uCP1020 SoM - Arcturus Networks Inc.",
+	.probe = ucp1020_probe,
+	.setup_arch = ucp1020_som_setup_arch,
+	.init_IRQ = ucp1020_som_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus = fsl_pcibios_fixup_bus,
+#endif
+	.get_irq = mpic_get_irq,
+	.restart = fsl_rstcr_restart,
+	.calibrate_decr = generic_calibrate_decr,
+#ifdef DEBUG
+	.progress = udbg_progress,
+#endif
+};
-- 
2.1.4
