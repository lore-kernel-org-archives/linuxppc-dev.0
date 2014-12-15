Return-Path: <stripath@apm.com>
Received: from denmail01.apm.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 7604E1A0198
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 04:16:56 +1100 (AEDT)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de
Subject: [PATCH 2/2] arm64: dts: Add  APM X-Gene SDHCI DTS node.
Date: Mon, 15 Dec 2014 22:31:07 +0530
Message-Id: <1418662867-9210-3-git-send-email-stripathi@apm.com>
In-Reply-To: <1418662867-9210-1-git-send-email-stripathi@apm.com>
References: <1418662867-9210-1-git-send-email-stripathi@apm.com>
Cc: devicetree@vger.kernel.org, Suman Tripathi <stripathi@apm.com>,
 jcm@redhat.com, linux-mmc@vger.kernel.org, patches@apm.com, ddutile@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the ahbclk and sdhciclk clock nodes and
the sdhci device tree nodes of APM X-Gene SDHCI controller.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index c0aceef..18e291b 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -144,6 +144,40 @@
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
@@ -397,6 +431,15 @@
 			clocks = <&rtcclk 0>;
 		};

+		sdhc0: sdhc@1c000000 {
+			device_type = "sdhc";
+			compatible = "arasan,sdhci-8.9a";
+			reg = <0x0 0x1c000000 0x0 0x100>;
+			interrupts = <0x0 0x49 0x4>;
+			clock-names = "clk_xin", "clk_ahb";
+			clocks = <&sdioclk 0>, <&ahbclk 0>;
+		};
+
 		menet: ethernet@17020000 {
 			compatible = "apm,xgene-enet";
 			status = "disabled";
--
1.8.2.1
