Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A4419B70C5
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Oct 2011 18:24:34 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 1/2] powerpc/85xx: create dts components to build up an
 SoC
Date: Thu, 20 Oct 2011 02:24:25 -0500
Message-Id: <1319095467-6229-1-git-send-email-galak@kernel.crashing.org>
Cc: devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce some common components that we can utilize to build up the
various PQ3/85xx device trees.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi    |   32 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi  |    8 ++++++
 arch/powerpc/boot/dts/fsl/pq3-duart-1.dtsi  |    8 ++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi |   32 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi |   32 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi |   32 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi    |    9 +++++++
 arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi    |    9 +++++++
 8 files changed, 162 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-duart-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi
new file mode 100644
index 0000000..60aa877
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi
@@ -0,0 +1,32 @@
+&dma0 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,eloplus-dma";
+	reg = <0x21300 0x4>;
+	ranges = <0x0 0x21100 0x200>;
+	cell-index = <0>;
+	dma-channel@0 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x0 0x80>;
+		cell-index = <0>;
+		interrupts = <20 2 0 0>;
+	};
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		cell-index = <1>;
+		interrupts = <21 2 0 0>;
+	};
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		cell-index = <2>;
+		interrupts = <22 2 0 0>;
+	};
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		cell-index = <3>;
+		interrupts = <23 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
new file mode 100644
index 0000000..bac1f0d
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
@@ -0,0 +1,8 @@
+&serial0 {
+	cell-index = <0>;
+	device_type = "serial";
+	compatible = "ns16550";
+	reg = <0x4500 0x100>;
+	clock-frequency = <0>;
+	interrupts = <42 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-duart-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-duart-1.dtsi
new file mode 100644
index 0000000..97bbacb
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-duart-1.dtsi
@@ -0,0 +1,8 @@
+&serial1 {
+	cell-index = <1>;
+	device_type = "serial";
+	compatible = "ns16550";
+	reg = <0x4600 0x100>;
+	clock-frequency = <0>;
+	interrupts = <42 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
new file mode 100644
index 0000000..73fff36
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
@@ -0,0 +1,32 @@
+&mdio0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,etsec2-mdio";
+	reg = <0x24000 0x1000 0xb0030 0x4>;
+};
+
+&enet0 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "network";
+	model = "eTSEC";
+	compatible = "fsl,etsec2";
+	fsl,num_rx_queues = <0x8>;
+	fsl,num_tx_queues = <0x8>;
+	fsl,magic-packet;
+	local-mac-address = [ 00 00 00 00 00 00 ];
+
+	queue-group@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb0000 0x1000>;
+		interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
+	};
+
+	queue-group@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb4000 0x1000>;
+		interrupts = <17 2 0 0 18 2 0 0 24 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
new file mode 100644
index 0000000..7ec73c4
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
@@ -0,0 +1,32 @@
+&mdio1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,etsec2-tbi";
+	reg = <0x25000 0x1000 0xb1030 0x4>;
+};
+
+&enet1 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "network";
+	model = "eTSEC";
+	compatible = "fsl,etsec2";
+	fsl,num_rx_queues = <0x8>;
+	fsl,num_tx_queues = <0x8>;
+	fsl,magic-packet;
+	local-mac-address = [ 00 00 00 00 00 00 ];
+
+	queue-group@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb1000 0x1000>;
+		interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
+	};
+
+	queue-group@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb5000 0x1000>;
+		interrupts = <51 2 0 0 52 2 0 0 67 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
new file mode 100644
index 0000000..50a078a
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
@@ -0,0 +1,32 @@
+&mdio2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,etsec2-tbi";
+	reg = <0x26000 0x1000 0xb1030 0x4>;
+};
+
+&enet2 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "network";
+	model = "eTSEC";
+	compatible = "fsl,etsec2";
+	fsl,num_rx_queues = <0x8>;
+	fsl,num_tx_queues = <0x8>;
+	fsl,magic-packet;
+	local-mac-address = [ 00 00 00 00 00 00 ];
+
+	queue-group@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb2000 0x1000>;
+		interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
+	};
+
+	queue-group@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb6000 0x1000>;
+		interrupts = <25 2 0 0 26 2 0 0 27 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi
new file mode 100644
index 0000000..ef75cca
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi
@@ -0,0 +1,9 @@
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cell-index = <0>;
+	compatible = "fsl-i2c";
+	reg = <0x3000 0x100>;
+	interrupts = <43 2 0 0>;
+	dfsrr;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi
new file mode 100644
index 0000000..e24043a
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi
@@ -0,0 +1,9 @@
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cell-index = <1>;
+	compatible = "fsl-i2c";
+	reg = <0x3100 0x100>;
+	interrupts = <43 2 0 0>;
+	dfsrr;
+};
-- 
1.7.3.4
