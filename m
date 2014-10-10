Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0147.outbound.protection.outlook.com [157.56.111.147])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FCC1A02F5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 17:50:39 +1100 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <B07421@freescale.com>
Subject: [PATCH 3/3] ls1021a-twr/qe: add qe node to ls1-twr
Date: Fri, 10 Oct 2014 14:49:58 +0800
Message-ID: <1412923798-9757-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, R63061@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

add qe node to ls1021atwr fdt.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 24 +++++++++++++++
 arch/arm/boot/dts/ls1021a.dtsi    | 64 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a52be7b..415387f 100755
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -164,6 +164,30 @@
 	};
 };
 
+&uqe {
+	tdma: ucc@2000 {
+		compatible = "fsl,ucc-tdm";
+		rx-clock-name = "clk8";
+		tx-clock-name = "clk9";
+		fsl,rx-sync-clock = "rsync_pin";
+		fsl,tx-sync-clock = "tsync_pin";
+		fsl,tx-timeslot = <0xfffffffe>;
+		fsl,rx-timeslot = <0xfffffffe>;
+		fsl,tdm-framer-type = "e1";
+		fsl,tdm-mode = "normal";
+		fsl,tdm-id = <0>;
+		fsl,siram-entry-id = <0>;
+	};
+
+	serial: ucc@2200 {
+		device_type = "serial";
+		compatible = "ucc_uart";
+		port-number = <1>;
+		rx-clock-name = "brg2";
+		tx-clock-name = "brg2";
+	};
+};
+
 &pwm6 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 80747dc..3f2ab89 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -314,6 +314,70 @@
 			status = "disabled";
 		};
 
+		uqe: uqe@2400000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "qe";
+			compatible = "fsl,qe", "simple-bus";
+			ranges = <0x0 0x0 0x2400000 0x40000>;
+			reg = <0x0 0x2400000 0x0 0x480>;
+			brg-frequency = <100000000>;
+			bus-frequency = <200000000>;
+
+			fsl,qe-num-riscs = <1>;
+			fsl,qe-num-snums = <28>;
+
+			qeic: qeic@80 {
+				compatible = "fsl,qe-ic";
+				reg = <0x80 0x80>;
+				#address-cells = <0>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupts = <0 109 0x04 0 109 0x04>;
+			};
+
+			si1: si@700 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,qe-si";
+				reg = <0x700 0x80>;
+			};
+
+			siram1: siram@1000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,qe-siram";
+				reg = <0x1000 0x800>;
+			};
+
+			ucc@2000 {
+				cell-index = <1>;
+				reg = <0x2000 0x200>;
+				interrupts = <32>;
+				interrupt-parent = <&qeic>;
+			};
+
+			ucc@2200 {
+				cell-index = <3>;
+				reg = <0x2200 0x200>;
+				interrupts = <34>;
+				interrupt-parent = <&qeic>;
+			};
+
+			muram@10000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,qe-muram", "fsl,cpm-muram";
+				ranges = <0x0 0x10000 0x6000>;
+
+				data-only@0 {
+					compatible = "fsl,qe-muram-data",
+					"fsl,cpm-muram-data";
+					reg = <0x0 0x6000>;
+				};
+			};
+		};
+
 		lpuart0: serial@2950000 {
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2950000 0x0 0x1000>;
-- 
2.1.0.27.g96db324
