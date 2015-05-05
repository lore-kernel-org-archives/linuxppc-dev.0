Return-Path: <stripath@apm.com>
Received: from denmail01.amcc.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 1B9EE1A066D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 19:18:12 +1000 (AEST)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Subject: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
Date: Tue,  5 May 2015 14:47:06 +0530
Message-Id: <1430817426-5241-2-git-send-email-stripathi@apm.com>
In-Reply-To: <1430817426-5241-1-git-send-email-stripathi@apm.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com,
 Suman Tripathi <stripathi@apm.com>, jcm@redhat.com, linux-mmc@vger.kernel.org,
 patches@apm.com, ddutile@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the arasan sdhc nodes to reuse the of-arasan
driver for APM X-Gene SoC.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
 arch/arm64/boot/dts/apm/apm-storm.dtsi  | 44 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
index 83578e7..4cc5d07 100644
--- a/arch/arm64/boot/dts/apm/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
@@ -52,3 +52,7 @@
 &xgenet {
 	status = "ok";
 };
+
+&sdhc0 {
+	status = "ok";
+};
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index c8d3e0e..240c793 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -145,6 +145,40 @@
 				clock-output-names = "socplldiv2";
 			};

+			ahbclk: ahbclk@1f2ac000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				reg = <0x0 0x1f2ac000 0x0 0x1000
+					0x0 0x17000000 0x0 0x2000>;
+				reg-names = "csr-reg", "div-reg";
+				csr-offset = <0x0>;
+				csr-mask = <0x1>;
+				enable-offset = <0x8>;
+				enable-mask = <0x1>;
+				divider-offset = <0x164>;
+				divider-width = <0x5>;
+				divider-shift = <0x0>;
+				clock-output-names = "ahbclk";
+			};
+
+			sdioclk: sdioclk@1f2ac000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				reg = <0x0 0x1f2ac000 0x0 0x1000
+					0x0 0x17000000 0x0 0x2000>;
+				reg-names = "csr-reg", "div-reg";
+				csr-offset = <0x0>;
+				csr-mask = <0x2>;
+				enable-offset = <0x8>;
+				enable-mask = <0x2>;
+				divider-offset = <0x178>;
+				divider-width = <0x8>;
+				divider-shift = <0x0>;
+				clock-output-names = "sdioclk";
+			};
+
 			qmlclk: qmlclk {
 				compatible = "apm,xgene-device-clock";
 				#clock-cells = <1>;
@@ -533,6 +567,16 @@
 			interrupts = <0x0 0x4f 0x4>;
 		};

+		sdhc0: sdhc@1c000000 {
+			device_type = "sdhc";
+			compatible = "arasan,sdhci-4.9a";
+			reg = <0x0 0x1c000000 0x0 0x100>;
+			interrupts = <0x0 0x49 0x4>;
+			dma-coherent;
+			clock-names = "clk_xin", "clk_ahb";
+			clocks = <&sdioclk 0>, <&ahbclk 0>;
+		};
+
 		phy1: phy@1f21a000 {
 			compatible = "apm,xgene-phy";
 			reg = <0x0 0x1f21a000 0x0 0x100>;
--
1.8.2.1
