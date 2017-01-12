Return-Path: <kishon@ti.com>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzjHT6Y9WzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 21:51:31 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 37/37] ARM: dts: DRA7: Add pcie1 dt node for EP mode
Date: Thu, 12 Jan 2017 15:56:26 +0530
Message-ID: <1484216786-17292-38-git-send-email-kishon@ti.com>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add pcie1 dt node in order for the controller to operate in
endpoint mode. However since none of the dra7 based boards have
slots configured to operate in endpoint mode, keep EP mode
disabled.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am572x-idk.dts                |    7 ++++++-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |    7 ++++++-
 arch/arm/boot/dts/dra7-evm.dts                  |    4 ++++
 arch/arm/boot/dts/dra7.dtsi                     |   22 +++++++++++++++++++++-
 arch/arm/boot/dts/dra72-evm-common.dtsi         |    4 ++++
 5 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 1540f7a..2ca2839 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -88,6 +88,11 @@
 	load-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
 };
 
-&pcie1 {
+&pcie1_rc {
+	status = "okay";
+	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+};
+
+&pcie1_ep {
 	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
 };
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 78bee26..079a7e1 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -556,7 +556,12 @@
 	};
 };
 
-&pcie1 {
+&pcie1_rc {
+	status = "ok";
+	gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
+};
+
+&pcie1_ep {
 	gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
 };
 
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 132f2be..fd0aa3a 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -937,3 +937,7 @@
 		status = "okay";
 	};
 };
+
+&pcie1_rc {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index addb753..bf9c668 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -272,7 +272,11 @@
 			#address-cells = <1>;
 			ranges = <0x51000000 0x51000000 0x3000
 				  0x0	     0x20000000 0x10000000>;
-			pcie1: pcie@51000000 {
+			/**
+			 * To enable PCI endpoint mode, disable the pcie1_rc
+			 * node and enable pcie1_ep mode.
+			 */
+			pcie1_rc: pcie@51000000 {
 				compatible = "ti,dra7-pcie";
 				reg = <0x51000000 0x2000>, <0x51002000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
@@ -293,12 +297,28 @@
 						<0 0 0 2 &pcie1_intc 2>,
 						<0 0 0 3 &pcie1_intc 3>,
 						<0 0 0 4 &pcie1_intc 4>;
+				status = "disabled";
 				pcie1_intc: interrupt-controller {
 					interrupt-controller;
 					#address-cells = <0>;
 					#interrupt-cells = <1>;
 				};
 			};
+
+			pcie1_ep: pcie_ep@51000000 {
+				compatible = "ti,dra7-pcie-ep";
+				reg = <0x51000000 0x28>, <0x51002000 0x14c>, <0x51001000 0x28>, <0x1000 0x10000000>;
+				reg-names = "ep_dbics", "ti_conf", "ep_dbics2", "addr_space";
+				interrupts = <0 232 0x4>;
+				num-lanes = <1>;
+				num-ib-windows = <4>;
+				num-ob-windows = <16>;
+				ti,hwmods = "pcie1";
+				phys = <&pcie1_phy>;
+				phy-names = "pcie-phy0";
+				syscon-legacy-mode = <&scm_conf1 0x14 2>;
+				status = "disabled";
+			};
 		};
 
 		axi@1 {
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index e50fbee..5d9762c 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -545,3 +545,7 @@
 		status = "okay";
 	};
 };
+
+&pcie1_rc {
+	status = "okay";
+};
-- 
1.7.9.5
