Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0134.outbound.protection.outlook.com [157.56.110.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFF4B1A0635
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 22:43:00 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 2/4] powerpc/fsl-booke: Add T1023RDB FMan device tree
Date: Wed, 20 May 2015 15:41:38 +0300
Message-ID: <1432125700-7024-3-git-send-email-madalin.bucur@freescale.com>
In-Reply-To: <1432125700-7024-2-git-send-email-madalin.bucur@freescale.com>
References: <1432125700-7024-1-git-send-email-madalin.bucur@freescale.com>
 <1432125700-7024-2-git-send-email-madalin.bucur@freescale.com>
Reply-To: <madalin.bucur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Igal.Liberman@freescale.com, roy.pledge@freescale.com,
 Madalin Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi | 94 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi   | 27 ++++++++
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi    |  6 ++
 arch/powerpc/boot/dts/t1023rdb.dts            | 40 ++++++++++++
 4 files changed, 167 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
new file mode 100644
index 0000000..8e9e272
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
@@ -0,0 +1,94 @@
+/*
+ * QorIQ FMan v3 device tree stub [ controller @ offset 0x400000 ]
+ *
+ * Copyright 2012 - 2015 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
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
+fman0: fman@400000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	cell-index = <0>;
+	compatible = "fsl,fman";
+	ranges = <0 0x400000 0x100000>;
+	reg = <0x400000 0x100000>;
+	interrupts = <96 2 0 0>, <16 2 1 1>;
+	clocks = <&fm0clk>;
+	clock-names = "fm0clk";
+	fsl,qman-channel-range = <0x800 0x10>;
+
+	muram@0 {
+		compatible = "fsl,fman-muram";
+		reg = <0x0 0x30000>;
+	};
+
+	fman0_oh_0x2: port@82000 {
+		cell-index = <0x2>;
+		compatible = "fsl,fman-v3-port-oh";
+		reg = <0x82000 0x1000>;
+	};
+
+	fman0_oh_0x3: port@83000 {
+		cell-index = <0x3>;
+		compatible = "fsl,fman-v3-port-oh";
+		reg = <0x83000 0x1000>;
+	};
+
+	fman0_oh_0x4: port@84000 {
+		cell-index = <0x4>;
+		compatible = "fsl,fman-v3-port-oh";
+		reg = <0x84000 0x1000>;
+	};
+
+	fman0_oh_0x5: port@85000 {
+		cell-index = <0x5>;
+		compatible = "fsl,fman-v3-port-oh";
+		reg = <0x85000 0x1000>;
+	};
+
+	mdio0: mdio@fc000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xfc000 0x1000>;
+	};
+
+	xmdio0: mdio@fd000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		reg = <0xfd000 0x1000>;
+	};
+
+	ptp_timer0: ptp-timer@fe000 {
+		compatible = "fsl,fman-ptp-timer";
+		reg = <0xfe000 0x1000>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
index 48c1690..a6eb7ae 100644
--- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -344,6 +344,14 @@
 		reg = <0xe0000 0xe00>;
 		fsl,has-rstcr;
 		fsl,liodn-bits = <12>;
+
+		fm0clk: fm0-clk-mux {
+			#clock-cells = <0>;
+			compatible = "fsl,fman-clk-mux";
+			clocks = <&pll0 1>;
+			clock-names = "pll0-div2";
+			clock-output-names = "fm0-clk";
+		};
 	};
 
 /include/ "qoriq-clockgen2.dtsi"
@@ -436,4 +444,23 @@ sata@220000 {
 /include/ "qoriq-sec5.0-0.dtsi"
 /include/ "qoriq-qman3.dtsi"
 /include/ "qoriq-bman1.dtsi"
+
+/include/ "qoriq-fman3l-0.dtsi"
+/include/ "qoriq-fman3-0-1g-0.dtsi"
+/include/ "qoriq-fman3-0-1g-1.dtsi"
+/include/ "qoriq-fman3-0-1g-2.dtsi"
+/include/ "qoriq-fman3-0-1g-3.dtsi"
+	fman@400000 {
+		enet0: ethernet@e0000 {
+		};
+
+		enet1: ethernet@e2000 {
+		};
+
+		enet2: ethernet@e4000 {
+		};
+
+		enet3: ethernet@e6000 {
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
index 1f1a9f8..3e1528a 100644
--- a/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
@@ -59,6 +59,12 @@
 		sdhc = &sdhc;
 
 		crypto = &crypto;
+
+		fman0 = &fman0;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/t1023rdb.dts b/arch/powerpc/boot/dts/t1023rdb.dts
index 571e070..146d30d 100644
--- a/arch/powerpc/boot/dts/t1023rdb.dts
+++ b/arch/powerpc/boot/dts/t1023rdb.dts
@@ -128,6 +128,46 @@
 		i2c@118100 {
 		};
 
+		fman@400000 {
+			fm1mac1: ethernet@e0000 {
+				phy-handle = <&sgmii_rtk_phy2>;
+				phy-connection-type = "sgmii";
+				sleep = <&rcpm 0x80000000>;
+			};
+
+			fm1mac2: ethernet@e2000 {
+				sleep = <&rcpm 0x40000000>;
+			};
+
+			fm1mac3: ethernet@e4000 {
+				phy-handle = <&sgmii_aqr_phy3>;
+				phy-connection-type = "sgmii-2500";
+				sleep = <&rcpm 0x20000000>;
+			};
+
+			fm1mac4: ethernet@e6000 {
+				phy-handle = <&rgmii_rtk_phy1>;
+				phy-connection-type = "rgmii";
+				sleep = <&rcpm 0x10000000>;
+			};
+
+
+			mdio0: mdio@fc000 {
+				rgmii_rtk_phy1: ethernet-phy@1 {
+					reg = <0x1>;
+				};
+				sgmii_rtk_phy2: ethernet-phy@3 {
+					reg = <0x3>;
+				};
+			};
+
+			xmdio0: mdio@fd000 {
+				sgmii_aqr_phy3: ethernet-phy@2 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x2>;
+				};
+			};
+		};
 	};
 
 	pci0: pcie@ffe240000 {
-- 
1.7.11.7
