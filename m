Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1DDD8B71EA
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Oct 2011 18:24:34 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 2/2] powerpc/85xx: Introduce a P1020 SoC device tree
Date: Thu, 20 Oct 2011 02:24:26 -0500
Message-Id: <1319095467-6229-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1319095467-6229-1-git-send-email-galak@kernel.crashing.org>
References: <1319095467-6229-1-git-send-email-galak@kernel.crashing.org>
Cc: devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create a P1020 SoC dts stub that can be included by a board that
utilizes the P1020 SoC.  The board can amend any board specific
configuration or paramaters (like locaation of CCSRBAR, PCIe
controllers, I2C components, ethernet PHY information, etc.)

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1020soc.dtsi |  262 +++++++++++++++++++++++++++++++++++
 1 files changed, 262 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1020soc.dtsi

diff --git a/arch/powerpc/boot/dts/p1020soc.dtsi b/arch/powerpc/boot/dts/p1020soc.dtsi
new file mode 100644
index 0000000..0abc015
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020soc.dtsi
@@ -0,0 +1,262 @@
+&lbc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	compatible = "fsl,p1020-elbc", "fsl,elbc", "simple-bus";
+	interrupts = <19 2 0 0>;
+};
+
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
+			0000 0x0 0x0 0x1 &mpic 0x4 0x1
+			0000 0x0 0x0 0x2 &mpic 0x5 0x1
+			0000 0x0 0x0 0x3 &mpic 0x6 0x1
+			0000 0x0 0x0 0x4 &mpic 0x7 0x1
+			>;
+	};
+
+};
+
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
+			0000 0x0 0x0 0x1 &mpic 0x0 0x1
+			0000 0x0 0x0 0x2 &mpic 0x1 0x1
+			0000 0x0 0x0 0x3 &mpic 0x2 0x1
+			0000 0x0 0x0 0x4 &mpic 0x3 0x1
+			>;
+	};
+};
+
+
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
+	i2c0: i2c@3000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cell-index = <0>;
+		compatible = "fsl-i2c";
+		reg = <0x3000 0x100>;
+		interrupts = <43 2 0 0>;
+		dfsrr;
+	};
+
+	i2c1: i2c@3100 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cell-index = <1>;
+		compatible = "fsl-i2c";
+		reg = <0x3100 0x100>;
+		interrupts = <43 2 0 0>;
+		dfsrr;
+	};
+
+	serial0: serial@4500 {
+	};
+
+	serial1: serial@4600 {
+	};
+
+	spi@7000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,p1020-espi", "fsl,mpc8536-espi";
+		reg = <0x7000 0x1000>;
+		interrupts = <59 0x2 0 0>;
+		fsl,espi-num-chipselects = <4>;
+	};
+
+	gpio: gpio-controller@f000 {
+		#gpio-cells = <2>;
+		compatible = "fsl,mpc8572-gpio";
+		reg = <0xf000 0x100>;
+		interrupts = <47 0x2 0 0>;
+		gpio-controller;
+	};
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,p1020-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x40000>; // L2,256K
+		interrupts = <16 2 0 0>;
+	};
+
+	dma0: dma@21300 {
+	};
+
+	mdio0: mdio@24000 {
+	};
+
+	mdio1: mdio@25000 {
+	};
+
+	mdio2: mdio@26000 {
+	};
+
+	enet0: ethernet@b0000 {
+	};
+
+	enet1: ethernet@b1000 {
+	};
+
+	enet2: ethernet@b2000 {
+	};
+
+	usb@22000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl-usb2-dr";
+		reg = <0x22000 0x1000>;
+		interrupts = <28 0x2 0 0>;
+	};
+
+	/* USB2 is shared with localbus, so it must be disabled
+	   by default. We can't put 'status = "disabled";' here
+	   since U-Boot doesn't clear the status property when
+	   it enables USB2. OTOH, U-Boot does create a new node
+	   when there isn't any. So, just comment it out.
+	usb@23000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl-usb2-dr";
+		reg = <0x23000 0x1000>;
+		interrupts = <46 0x2 0 0>;
+		phy_type = "ulpi";
+	};
+	*/
+
+	sdhci@2e000 {
+		compatible = "fsl,p1020-esdhc", "fsl,esdhc";
+		reg = <0x2e000 0x1000>;
+		interrupts = <72 0x2 0 0>;
+		/* Filled in by U-Boot */
+		clock-frequency = <0>;
+	};
+
+	crypto@30000 {
+		compatible = "fsl,sec3.3", "fsl,sec3.1", "fsl,sec3.0",
+			     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
+			     "fsl,sec2.0";
+		reg = <0x30000 0x10000>;
+		interrupts = <45 2 0 0 58 2 0 0>;
+		fsl,num-channels = <4>;
+		fsl,channel-fifo-len = <24>;
+		fsl,exec-units-mask = <0x97c>;
+		fsl,descriptor-types-mask = <0x3a30abf>;
+	};
+
+	mpic: pic@40000 {
+		interrupt-controller;
+		#address-cells = <0>;
+		#interrupt-cells = <4>;
+		reg = <0x40000 0x40000>;
+		compatible = "chrp,open-pic";
+		device_type = "open-pic";
+	};
+
+	timer@41100 {
+		compatible = "fsl,mpic-global-timer";
+		reg = <0x41100 0x100 0x41300 4>;
+		interrupts = <0 0 3 0
+			      1 0 3 0
+			      2 0 3 0
+			      3 0 3 0>;
+	};
+
+	timer@42100 {
+		compatible = "fsl,mpic-global-timer";
+		reg = <0x42100 0x100 0x42300 4>;
+		interrupts = <4 0 3 0
+			      5 0 3 0
+			      6 0 3 0
+			      7 0 3 0>;
+	};
+
+	msi@41600 {
+		compatible = "fsl,p1020-msi", "fsl,mpic-msi";
+		reg = <0x41600 0x80>;
+		msi-available-ranges = <0 0x100>;
+		interrupts = <
+			0xe0 0 0 0
+			0xe1 0 0 0
+			0xe2 0 0 0
+			0xe3 0 0 0
+			0xe4 0 0 0
+			0xe5 0 0 0
+			0xe6 0 0 0
+			0xe7 0 0 0>;
+	};
+
+	global-utilities@e0000 {	//global utilities block
+		compatible = "fsl,p1020-guts","fsl,p2020-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+};
+
+/include/ "fsl/pq3-dma-0.dtsi"
+/include/ "fsl/pq3-duart-0.dtsi"
+/include/ "fsl/pq3-duart-1.dtsi"
+/include/ "fsl/pq3-etsec2-0.dtsi"
+/include/ "fsl/pq3-etsec2-1.dtsi"
+/include/ "fsl/pq3-etsec2-2.dtsi"
+/include/ "fsl/pq3-i2c-0.dtsi"
+/include/ "fsl/pq3-i2c-1.dtsi"
-- 
1.7.3.4
