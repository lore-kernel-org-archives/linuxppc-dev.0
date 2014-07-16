Return-Path: <Shruti@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 663161A0241
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 06:17:22 +1000 (EST)
From: Shruti Kanetkar <Shruti@Freescale.com>
To: <scottwood@Freescale.com>
Subject: [PATCH v2 5/7] powerpc/corenet: Add MDIO bus muxing support to the
 board device tree(s)
Date: Wed, 16 Jul 2014 15:17:09 -0500
Message-ID: <1405541831-1277-5-git-send-email-Shruti@Freescale.com>
In-Reply-To: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shruti Kanetkar <Shruti@Freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Based on prior work by Andy Fleming <afleming@gmail.com>

Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
---
 arch/powerpc/boot/dts/b4860qds.dts |  56 +++++++
 arch/powerpc/boot/dts/b4qds.dtsi   |  45 ++++++
 arch/powerpc/boot/dts/p1023rdb.dts |  19 +++
 arch/powerpc/boot/dts/p2041rdb.dts |  87 +++++++++++
 arch/powerpc/boot/dts/p3041ds.dts  | 138 +++++++++++++++++
 arch/powerpc/boot/dts/p4080ds.dts  | 178 ++++++++++++++++++++++
 arch/powerpc/boot/dts/p5020ds.dts  | 138 +++++++++++++++++
 arch/powerpc/boot/dts/p5040ds.dts  | 232 ++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/t4240qds.dts | 305 +++++++++++++++++++++++++++++++++++++
 9 files changed, 1198 insertions(+)

diff --git a/arch/powerpc/boot/dts/b4860qds.dts b/arch/powerpc/boot/dts/b4860qds.dts
index 6bb3707..d7daf44 100644
--- a/arch/powerpc/boot/dts/b4860qds.dts
+++ b/arch/powerpc/boot/dts/b4860qds.dts
@@ -39,12 +39,68 @@
 	model = "fsl,B4860QDS";
 	compatible = "fsl,B4860QDS";
 
+	aliases {
+		phy_sgmii_1e = &phy_sgmii_1e;
+		phy_sgmii_1f = &phy_sgmii_1f;
+		phy_xaui_slot1 = &phy_xaui_slot1;
+		phy_xaui_slot2 = &phy_xaui_slot2;
+	};
+
 	ifc: localbus@ffe124000 {
 		board-control@3,0 {
 			compatible = "fsl,b4860qds-fpga", "fsl,fpga-qixis";
 		};
 	};
 
+	soc@ffe000000 {
+		fman@400000 {
+			ethernet@e8000 {
+				phy-handle = <&phy_sgmii_1e>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@ea000 {
+				phy-handle = <&phy_sgmii_1f>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@f0000 { /* FM1@TGEC2 */
+				phy-handle = <&phy_xaui_slot1>;
+				phy-connection-type = "xgmii";
+			};
+
+			ethernet@f2000 { /* FM1@TGEC1 */
+				phy-handle = <&phy_xaui_slot2>;
+				phy-connection-type = "xgmii";
+			};
+
+			mdio@fc000 {
+				phy_sgmii_1e: ethernet-phy@1e {
+						status = "disabled";
+						reg = <0x1e>;
+				};
+				phy_sgmii_1f: ethernet-phy@1f {
+					status = "disabled";
+					reg = <0x1f>;
+				};
+			};
+
+			mdio@fd000 {
+				/* For 10g interfaces */
+				phy_xaui_slot1: xaui-phy@slot1 {
+					status = "disabled";
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x7>; /* default switch setting on slot1 of AMC2PEX */
+				};
+				phy_xaui_slot2: xaui-phy@slot2 {
+					status = "disabled";
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x6>; /* default switch setting on slot1 of AMC2PEX */
+				};
+			};
+		};
+	};
+
 	rio: rapidio@ffe0c0000 {
 		reg = <0xf 0xfe0c0000 0 0x11000>;
 
diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
index 8b47edc..6188583 100644
--- a/arch/powerpc/boot/dts/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/b4qds.dtsi
@@ -39,6 +39,13 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	aliases {
+		phy_sgmii_10 = &phy_sgmii_10;
+		phy_sgmii_11 = &phy_sgmii_11;
+		phy_sgmii_1c = &phy_sgmii_1c;
+		phy_sgmii_1d = &phy_sgmii_1d;
+	};
+
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
@@ -160,6 +167,44 @@
 			phy_type = "ulpi";
 		};
 
+		fman@400000 {
+			ethernet@e0000 {
+				phy-handle = <&phy_sgmii_10>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e2000 {
+				phy-handle = <&phy_sgmii_11>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e4000 {
+				phy-handle = <&phy_sgmii_1c>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e6000 {
+				phy-handle = <&phy_sgmii_1d>;
+				phy-connection-type = "sgmii";
+			};
+
+			mdio@fc000 {
+				phy_sgmii_10: ethernet-phy@10 {
+					reg = <0x10>;
+				};
+				phy_sgmii_11: ethernet-phy@11 {
+					reg = <0x11>;
+				};
+				phy_sgmii_1c: ethernet-phy@1c {
+					status = "disabled";
+					reg = <0x1c>;
+				};
+				phy_sgmii_1d: ethernet-phy@1d {
+					status = "disabled";
+					reg = <0x1d>;
+				};
+			};
+		};
 	};
 
 	pci0: pcie@ffe200000 {
diff --git a/arch/powerpc/boot/dts/p1023rdb.dts b/arch/powerpc/boot/dts/p1023rdb.dts
index 0a06a88..d121bda 100644
--- a/arch/powerpc/boot/dts/p1023rdb.dts
+++ b/arch/powerpc/boot/dts/p1023rdb.dts
@@ -66,6 +66,25 @@
 			dr_mode = "host";
 			phy_type = "ulpi";
 		};
+
+		fman@100000 {
+			ethernet@e0000 {
+				phy-handle = <&phy0>;
+				phy-connection-type = "rgmii";
+			};
+			ethernet@e2000 {
+				phy-handle = <&phy1>;
+				phy-connection-type = "rgmii";
+			};
+			mdio@e1120 {
+				phy0: ethernet-phy@1 {
+					reg = <0x01>;
+				};
+				phy1: ethernet-phy@2 {
+					reg = <0x02>;
+				};
+			};
+		};
 	};
 
 	lbc: localbus@ff605000 {
diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/p2041rdb.dts
index d97ad74..1060716 100644
--- a/arch/powerpc/boot/dts/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/p2041rdb.dts
@@ -41,6 +41,19 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	aliases {
+		phy_rgmii_0 = &phy_rgmii_0;
+		phy_rgmii_1 = &phy_rgmii_1;
+		phy_sgmii_2 = &phy_sgmii_2;
+		phy_sgmii_3 = &phy_sgmii_3;
+		phy_sgmii_4 = &phy_sgmii_4;
+		phy_sgmii_1c = &phy_sgmii_1c;
+		phy_sgmii_1d = &phy_sgmii_1d;
+		phy_sgmii_1e = &phy_sgmii_1e;
+		phy_sgmii_1f = &phy_sgmii_1f;
+		phy_xgmii_2 = &phy_xgmii_2;
+	};
+
 	memory {
 		device_type = "memory";
 	};
@@ -110,6 +123,80 @@
 		usb1: usb@211000 {
 			dr_mode = "host";
 		};
+
+		fman@400000{
+			ethernet@e0000 {
+				phy-handle = <&phy_sgmii_2>;
+				phy-connection-type = "sgmii";
+			};
+
+			mdio@e1120 {
+				phy_rgmii_0: ethernet-phy@0 {
+					reg = <0x0>;
+				};
+				phy_rgmii_1: ethernet-phy@1 {
+					reg = <0x1>;
+				};
+				phy_sgmii_2: ethernet-phy@2 {
+					reg = <0x2>;
+				};
+				phy_sgmii_3: ethernet-phy@3 {
+					reg = <0x3>;
+				};
+				phy_sgmii_4: ethernet-phy@4 {
+					reg = <0x4>;
+				};
+				phy_sgmii_1c: ethernet-phy@1c {
+					reg = <0x1c>;
+				};
+				phy_sgmii_1d: ethernet-phy@1d {
+					reg = <0x1d>;
+				};
+				phy_sgmii_1e: ethernet-phy@1e {
+					reg = <0x1e>;
+				};
+				phy_sgmii_1f: ethernet-phy@1f {
+					reg = <0x1f>;
+				};
+			};
+
+			ethernet@e2000 {
+				phy-handle = <&phy_sgmii_3>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e4000 {
+				phy-handle = <&phy_sgmii_4>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e6000 {
+				phy-handle = <&phy_rgmii_1>;
+				phy-connection-type = "rgmii";
+			};
+
+			ethernet@e8000 {
+				phy-handle = <&phy_rgmii_0>;
+				phy-connection-type = "rgmii";
+			};
+
+			ethernet@f0000 {
+				/*
+				 * phy-handle will be updated by U-Boot to
+				 * reflect the actual slot the XAUI card is in.
+				 */
+				phy-handle = <&phy_xgmii_2>;
+				phy-connection-type = "xgmii";
+			};
+
+			mdio@f1000 {
+				/* XAUI card in slot 2 */
+				phy_xgmii_2: ethernet-phy@0 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x0>;
+				};
+			};
+		};
 	};
 
 	rio: rapidio@ffe0c0000 {
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index 2fed3bc..23670ea 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -49,6 +49,20 @@
 		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
 	};
 
+	aliases{
+		phy_rgmii_0 = &phy_rgmii_0;
+		phy_rgmii_1 = &phy_rgmii_1;
+		phy_sgmii_1c = &phy_sgmii_1c;
+		phy_sgmii_1d = &phy_sgmii_1d;
+		phy_sgmii_1e = &phy_sgmii_1e;
+		phy_sgmii_1f = &phy_sgmii_1f;
+		phy_xgmii_1 = &phy_xgmii_1;
+		phy_xgmii_2 = &phy_xgmii_2;
+		emi1_rgmii = &hydra_mdio_rgmii;
+		emi1_sgmii = &hydra_mdio_sgmii;
+		emi2_xgmii = &hydra_mdio_xgmii;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
@@ -103,6 +117,69 @@
 				reg = <0x4c>;
 			};
 		};
+
+		fman@400000{
+			ethernet@e0000 {
+				phy-handle = <&phy_sgmii_1c>;
+				phy-connection-type = "sgmii";
+			};
+
+			mdio0: mdio@e1120 {
+			};
+
+			ethernet@e2000 {
+				phy-handle = <&phy_sgmii_1d>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e4000 {
+				phy-handle = <&phy_sgmii_1e>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e6000 {
+				phy-handle = <&phy_sgmii_1f>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e8000 {
+				phy-handle = <&phy_rgmii_1>;
+				phy-connection-type = "rgmii";
+			};
+
+			ethernet@f0000 {
+				/*
+				* phy-handle will be updated by U-Boot to
+				* reflect the actual slot the XAUI card is in.
+				*/
+				phy-handle = <&phy_xgmii_1>;
+				phy-connection-type = "xgmii";
+			};
+
+			/*
+			 * We only support one XAUI card, so the MDIO muxing
+			 * is set by U-Boot, and Linux never touches it.
+			 * Therefore, we don't need a virtual MDIO node.
+			 * However, the phy address depends on the slot, so
+			 * only one of the ethernet-phy nodes below will be
+			 * used.
+			 */
+			hydra_mdio_xgmii: mdio@f1000 {
+				status = "disabled";
+
+				/* XAUI card in slot 1 */
+				phy_xgmii_1: ethernet-phy@4 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x4>;
+				};
+
+				/* XAUI card in slot 2 */
+				phy_xgmii_2: ethernet-phy@0 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x0>;
+				};
+			};
+		};
 	};
 
 	rio: rapidio@ffe0c0000 {
@@ -168,8 +245,69 @@
 		};
 
 		board-control@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			compatible = "fsl,p3041ds-fpga", "fsl,fpga-ngpixis";
 			reg = <3 0 0x30>;
+			ranges = <0 3 0 0x30>;
+
+			mdio-mux-emi1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "mdio-mux-mmioreg", "mdio-mux";
+				mdio-parent-bus = <&mdio0>;
+				/* BRDCFG1 */
+				reg = <9 1>;
+				/* EMI1 */
+				mux-mask = <0x78>;
+
+				/*
+				 * Virtual MDIO for the two on-board RGMII
+				 * ports.  The reg property is already correct.
+				 */
+				hydra_mdio_rgmii: rgmii-mdio@8 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					status = "disabled";
+					reg = <8>; /* EMI1_EN | 0 */
+
+					phy_rgmii_0: ethernet-phy@0 {
+						reg = <0x0>;
+					};
+					phy_rgmii_1: ethernet-phy@1 {
+						reg = <0x1>;
+					};
+				};
+
+				/*
+				 * Virtual MDIO for the four-port SGMII card.
+				 * The reg property will be fixed-up
+				 * by U-Boot based on the slot that
+				 * the SGMII card is in.
+				 *
+				 * Note: we do not support DTSEC5 connected to
+				 * SGMII, so this is the only SGMII node.
+				 */
+				hydra_mdio_sgmii: sgmii-mdio@28 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x28>; /* EMI1_EN | 0x20 */
+					status = "disabled";
+
+					phy_sgmii_1c: ethernet-phy@1c {
+						reg = <0x1c>;
+					};
+					phy_sgmii_1d: ethernet-phy@1d {
+						reg = <0x1d>;
+					};
+					phy_sgmii_1e: ethernet-phy@1e {
+						reg = <0x1e>;
+					};
+					phy_sgmii_1f: ethernet-phy@1f {
+						reg = <0x1f>;
+					};
+				};
+			};
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 1cf6148..84256cd 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -41,6 +41,20 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	aliases {
+		phy_rgmii = &phyrgmii;
+		phy5_slot3 = &phy5slot3;
+		phy6_slot3 = &phy6slot3;
+		phy7_slot3 = &phy7slot3;
+		phy8_slot3 = &phy8slot3;
+		emi1_slot3 = &p4080mdio2;
+		emi1_slot4 = &p4080mdio1;
+		emi1_slot5 = &p4080mdio3;
+		emi1_rgmii = &p4080mdio0;
+		emi2_slot4 = &p4080xmdio1;
+		emi2_slot5 = &p4080xmdio3;
+	};
+
 	memory {
 		device_type = "memory";
 	};
@@ -110,6 +124,65 @@
 			dr_mode = "host";
 			phy_type = "ulpi";
 		};
+
+		fman@400000 {
+			ethernet@e0000 {
+				phy-handle = <&phy0>;
+				phy-connection-type = "sgmii";
+			};
+
+			mdio0: mdio@e1120 {
+			};
+
+			ethernet@e2000 {
+				phy-handle = <&phy1>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e4000 {
+				phy-handle = <&phy2>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e6000 {
+				phy-handle = <&phy3>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@f0000 {
+				phy-handle = <&phy10>;
+				phy-connection-type = "xgmii";
+			};
+			xmdio0: mdio@f1000 {
+			};
+		};
+
+		fman@500000 {
+			ethernet@e0000 {
+				phy-handle = <&phy5>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e2000 {
+				phy-handle = <&phy6>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e4000 {
+				phy-handle = <&phy7>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e6000 {
+				phy-handle = <&phy8>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@f0000 {
+				phy-handle = <&phy11>;
+				phy-connection-type = "xgmii";
+			};
+		};
 	};
 
 	rio: rapidio@ffe0c0000 {
@@ -186,6 +259,111 @@
 		};
 	};
 
+	mdio-mux-emi1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "mdio-mux-gpio";
+		gpios = <&gpio0 1 0>, <&gpio0 0 0>;
+		mdio-parent-bus = <&mdio0>;
+
+		p4080mdio0: mdio@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			phyrgmii: ethernet-phy@0 {
+				reg = <0x0>;
+			};
+		};
+
+		p4080mdio1: mdio@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			phy5: ethernet-phy@1c {
+				reg = <0x1c>;
+			};
+			phy6: ethernet-phy@1d {
+				reg = <0x1d>;
+			};
+			phy7: ethernet-phy@1e {
+				reg = <0x1e>;
+			};
+			phy8: ethernet-phy@1f {
+				reg = <0x1f>;
+			};
+		};
+
+		p4080mdio2: mdio@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "disabled";
+
+			phy5slot3: ethernet-phy@1c {
+				reg = <0x1c>;
+			};
+			phy6slot3: ethernet-phy@1d {
+				reg = <0x1d>;
+			};
+			phy7slot3: ethernet-phy@1e {
+				reg = <0x1e>;
+			};
+			phy8slot3: ethernet-phy@1f {
+				reg = <0x1f>;
+			};
+		};
+
+		p4080mdio3: mdio@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			phy0: ethernet-phy@1c {
+				reg = <0x1c>;
+			};
+			phy1: ethernet-phy@1d {
+				reg = <0x1d>;
+			};
+			phy2: ethernet-phy@1e {
+				reg = <0x1e>;
+			};
+			phy3: ethernet-phy@1f {
+				reg = <0x1f>;
+			};
+		};
+	};
+
+	mdio-mux-emi2 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "mdio-mux-gpio";
+		gpios = <&gpio0 3 0>, <&gpio0 2 0>;
+		mdio-parent-bus = <&xmdio0>;
+
+		p4080xmdio1: mdio@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			phy11: ethernet-phy@0 {
+				compatible = "ethernet-phy-ieee802.3-c45";
+				reg = <0x0>;
+			};
+		};
+
+		p4080xmdio3: mdio@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			phy10: ethernet-phy@4 {
+				compatible = "ethernet-phy-ieee802.3-c45";
+				reg = <0x4>;
+			};
+		};
+	};
 };
 
 /include/ "fsl/p4080si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index 2869fea..97590d8 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/p5020ds.dts
@@ -41,6 +41,20 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	aliases {
+		phy_rgmii_0 = &phy_rgmii_0;
+		phy_rgmii_1 = &phy_rgmii_1;
+		phy_sgmii_1c = &phy_sgmii_1c;
+		phy_sgmii_1d = &phy_sgmii_1d;
+		phy_sgmii_1e = &phy_sgmii_1e;
+		phy_sgmii_1f = &phy_sgmii_1f;
+		phy_xgmii_1 = &phy_xgmii_1;
+		phy_xgmii_2 = &phy_xgmii_2;
+		emi1_rgmii = &hydra_mdio_rgmii;
+		emi1_sgmii = &hydra_mdio_sgmii;
+		emi2_xgmii = &hydra_mdio_xgmii;
+	};
+
 	memory {
 		device_type = "memory";
 	};
@@ -103,6 +117,69 @@
 				reg = <0x4c>;
 			};
 		};
+
+		fman@400000 {
+			ethernet@e0000 {
+				phy-handle = <&phy_sgmii_1c>;
+				phy-connection-type = "sgmii";
+			};
+
+			mdio0: mdio@e1120 {
+			};
+
+			ethernet@e2000 {
+				phy-handle = <&phy_sgmii_1d>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e4000 {
+				phy-handle = <&phy_sgmii_1e>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e6000 {
+				phy-handle = <&phy_sgmii_1f>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e8000 {
+				phy-handle = <&phy_rgmii_1>;
+				phy-connection-type = "rgmii";
+			};
+
+			ethernet@f0000 {
+				/*
+				 * phy-handle will be updated by U-Boot to
+				 * reflect the actual slot the XAUI card is in.
+				 */
+				phy-handle = <&phy_xgmii_1>;
+				phy-connection-type = "xgmii";
+			};
+
+			/*
+			 * We only support one XAUI card, so the MDIO muxing
+			 * is set by U-Boot, and Linux never touches it.
+			 * Therefore, we don't need a virtual MDIO node.
+			 * However, the phy address depends on the slot, so
+			 * only one of the ethernet-phy nodes below will be
+			 * used.
+			 */
+			hydra_mdio_xgmii: mdio@f1000 {
+				status = "disabled";
+
+				/* XAUI card in slot 1 */
+				phy_xgmii_1: ethernet-phy@4 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x4>;
+				};
+
+				/* XAUI card in slot 2 */
+				phy_xgmii_2: ethernet-phy@0 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x0>;
+				};
+			};
+		};
 	};
 
 	rio: rapidio@ffe0c0000 {
@@ -168,8 +245,69 @@
 		};
 
 		board-control@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			compatible = "fsl,p5020ds-fpga", "fsl,fpga-ngpixis";
 			reg = <3 0 0x30>;
+			ranges = <0 3 0 0x30>;
+
+			mdio-mux-emi1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "mdio-mux-mmioreg", "mdio-mux";
+				mdio-parent-bus = <&mdio0>;
+				/* BRDCFG1 */
+				reg = <9 1>;
+				/* EMI1 */
+				mux-mask = <0x78>;
+
+				/*
+				 * Virtual MDIO for the two on-board RGMII
+				 * ports.  The reg property is already correct
+				 */
+				hydra_mdio_rgmii: rgmii-mdio@8 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					status = "disabled";
+					reg = <8>; /* EMI1_EN | 0 */
+
+					phy_rgmii_0: ethernet-phy@0 {
+						reg = <0x0>;
+					};
+					phy_rgmii_1: ethernet-phy@1 {
+						reg = <0x1>;
+					};
+				};
+
+				/*
+				 * Virtual MDIO for the four-port SGMII card.
+				 * The reg property will be fixed-up
+				 * by U-Boot based on the slot that
+				 * the SGMII card is in.
+				 *
+				 * Note: we do not support DTSEC5 connected to
+				 * SGMII, so this is the only SGMII node.
+				 */
+				hydra_mdio_sgmii: sgmii-mdio@28 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x28>; /* EMI1_EN | 0x20 */
+					status = "disabled";
+
+					phy_sgmii_1c: ethernet-phy@1c {
+						reg = <0x1c>;
+					};
+					phy_sgmii_1d: ethernet-phy@1d {
+						reg = <0x1d>;
+					};
+					phy_sgmii_1e: ethernet-phy@1e {
+						reg = <0x1e>;
+					};
+					phy_sgmii_1f: ethernet-phy@1f {
+						reg = <0x1f>;
+					};
+				};
+			};
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/p5040ds.dts
index 860b5cc..0c8c817 100644
--- a/arch/powerpc/boot/dts/p5040ds.dts
+++ b/arch/powerpc/boot/dts/p5040ds.dts
@@ -45,6 +45,34 @@
 		device_type = "memory";
 	};
 
+	aliases{
+		phy_sgmii_slot2_1c = &phy_sgmii_slot2_1c;
+		phy_sgmii_slot2_1d = &phy_sgmii_slot2_1d;
+		phy_sgmii_slot2_1e = &phy_sgmii_slot2_1e;
+		phy_sgmii_slot2_1f = &phy_sgmii_slot2_1f;
+		phy_sgmii_slot3_1c = &phy_sgmii_slot3_1c;
+		phy_sgmii_slot3_1d = &phy_sgmii_slot3_1d;
+		phy_sgmii_slot3_1e = &phy_sgmii_slot3_1e;
+		phy_sgmii_slot3_1f = &phy_sgmii_slot3_1f;
+		phy_sgmii_slot5_1c = &phy_sgmii_slot5_1c;
+		phy_sgmii_slot5_1d = &phy_sgmii_slot5_1d;
+		phy_sgmii_slot5_1e = &phy_sgmii_slot5_1e;
+		phy_sgmii_slot5_1f = &phy_sgmii_slot5_1f;
+		phy_sgmii_slot6_1c = &phy_sgmii_slot6_1c;
+		phy_sgmii_slot6_1d = &phy_sgmii_slot6_1d;
+		phy_sgmii_slot6_1e = &phy_sgmii_slot6_1e;
+		phy_sgmii_slot6_1f = &phy_sgmii_slot6_1f;
+		phy_xgmii_slot_1 = &phy_xgmii_slot_1;
+		phy_xgmii_slot_2 = &phy_xgmii_slot_2;
+		hydra_rg = &hydra_rg;
+		hydra_sg_slot2 = &hydra_sg_slot2;
+		hydra_sg_slot3 = &hydra_sg_slot3;
+		hydra_sg_slot5 = &hydra_sg_slot5;
+		hydra_sg_slot6 = &hydra_sg_slot6;
+		hydra_xg_slot1 = &hydra_xg_slot1;
+		hydra_xg_slot2 = &hydra_xg_slot2;
+	};
+
 	dcsr: dcsr@f00000000 {
 		ranges = <0x00000000 0xf 0x00000000 0x01008000>;
 	};
@@ -100,6 +128,68 @@
 				reg = <0x4c>;
 			};
 		};
+
+		fman@400000 {
+			ethernet@e0000 {
+				phy-connection-type = "sgmii";
+			};
+
+			mdio0: mdio@e1120 {
+			};
+
+			ethernet@e2000 {
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e4000 {
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e6000 {
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e8000 {
+				phy-handle = <&phy_rgmii_0>;
+				phy-connection-type = "rgmii";
+			};
+
+			ethernet@f0000 {
+				phy-handle = <&phy_xgmii_slot_2>;
+				phy-connection-type = "xgmii";
+			};
+
+			xmdio0: mdio@f1000 {
+			};
+		};
+
+		fman@500000 {
+			ethernet@e0000 {
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e2000 {
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e4000 {
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e6000 {
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e8000 {
+				phy-handle = <&phy_rgmii_1>;
+				phy-connection-type = "rgmii";
+			};
+
+			ethernet@f0000 {
+				phy-handle = <&phy_xgmii_slot_1>;
+				phy-connection-type = "xgmii";
+			};
+		};
 	};
 
 	lbc: localbus@ffe124000 {
@@ -153,8 +243,150 @@
 		};
 
 		board-control@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			compatible = "fsl,p5040ds-fpga", "fsl,fpga-ngpixis";
 			reg = <3 0 0x40>;
+			ranges = <0 3 0 0x40>;
+
+			mdio-mux-emi1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "mdio-mux-mmioreg", "mdio-mux";
+				mdio-parent-bus = <&mdio0>;
+				/* BRDCFG1 */
+				reg = <9 1>;
+				/* EMI1 */
+				mux-mask = <0x78>;
+				/*
+				 * Virtual MDIO for the two on-board RGMII
+				 * ports.  The reg property is already correct
+				 */
+				hydra_rg:rgmii-mdio@8 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					status = "disabled";
+					reg = <8>; /* EMI1_EN | 0 */
+
+					phy_rgmii_0: ethernet-phy@0 {
+						reg = <0x0>;
+					};
+					phy_rgmii_1: ethernet-phy@1 {
+						reg = <0x1>;
+					};
+				};
+				/* Virtual MDIO for the four-port SGMII cards */
+				hydra_sg_slot2: sgmii-mdio@28 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x28>; /* EMI1_EN | 0x20 */
+					status = "disabled";
+
+					phy_sgmii_slot2_1c: ethernet-phy@1c {
+						reg = <0x1c>;
+					};
+					phy_sgmii_slot2_1d: ethernet-phy@1d {
+						reg = <0x1d>;
+					};
+					phy_sgmii_slot2_1e: ethernet-phy@1e {
+						reg = <0x1e>;
+					};
+					phy_sgmii_slot2_1f: ethernet-phy@1f {
+						reg = <0x1f>;
+					};
+				};
+				hydra_sg_slot3: sgmii-mdio@68 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x68>; /* EMI1_EN | 0x60 */
+					status = "disabled";
+
+					phy_sgmii_slot3_1c: ethernet-phy@1c {
+						reg = <0x1c>;
+					};
+					phy_sgmii_slot3_1d: ethernet-phy@1d {
+						reg = <0x1d>;
+					};
+					phy_sgmii_slot3_1e: ethernet-phy@1e {
+						reg = <0x1e>;
+					};
+					phy_sgmii_slot3_1f: ethernet-phy@1f {
+						reg = <0x1f>;
+					};
+				};
+				hydra_sg_slot5: sgmii-mdio@38 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x38>; /* EMI1_EN | 0x30 */
+					status = "disabled";
+
+					phy_sgmii_slot5_1c: ethernet-phy@1c {
+						reg = <0x1c>;
+					};
+					phy_sgmii_slot5_1d: ethernet-phy@1d {
+						reg = <0x1d>;
+					};
+					phy_sgmii_slot5_1e: ethernet-phy@1e {
+						reg = <0x1e>;
+					};
+					phy_sgmii_slot5_1f: ethernet-phy@1f {
+						reg = <0x1f>;
+					};
+				};
+				hydra_sg_slot6: sgmii-mdio@48 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x48>; /* EMI1_EN | 0x40 */
+					status = "disabled";
+
+					phy_sgmii_slot6_1c: ethernet-phy@1c {
+						reg = <0x1c>;
+					};
+					phy_sgmii_slot6_1d: ethernet-phy@1d {
+						reg = <0x1d>;
+					};
+					phy_sgmii_slot6_1e: ethernet-phy@1e {
+						reg = <0x1e>;
+					};
+					phy_sgmii_slot6_1f: ethernet-phy@1f {
+						reg = <0x1f>;
+					};
+				};
+			};
+
+			mdio-mux-emi2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "mdio-mux-mmioreg", "mdio-mux";
+				mdio-parent-bus = <&xmdio0>;
+				reg = <9 1>; /* BRDCFG1 */
+				mux-mask = <0x06>; /* EMI2 */
+
+				/* FM2 10GEC1 is always on slot 1 */
+				hydra_xg_slot1: hydra-xg-slot1@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+					status = "disabled";
+
+					phy_xgmii_slot_1: ethernet-phy@0 {
+						compatible = "ethernet-phy-ieee802.3-c45";
+						reg = <4>;
+					};
+				};
+
+				/* FM1 10GEC1 is always on slot 2 */
+				hydra_xg_slot2: hydra-xg-slot2@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+
+					phy_xgmii_slot_2: ethernet-phy@4 {
+						compatible = "ethernet-phy-ieee802.3-c45";
+						reg = <0>;
+					};
+				};
+			};
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/t4240qds.dts
index 97683f6..dd9d25b 100644
--- a/arch/powerpc/boot/dts/t4240qds.dts
+++ b/arch/powerpc/boot/dts/t4240qds.dts
@@ -41,6 +41,36 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	aliases{
+		phy_rgmii1 = &phyrgmii1;
+		phy_rgmii2 = &phyrgmii2;
+		phy_sgmii3 = &phy3;
+		phy_sgmii4 = &phy4;
+		phy_sgmii11 = &phy11;
+		phy_sgmii12 = &phy12;
+		sgmii_phy11 = &sgmiiphy11;
+		sgmii_phy12 = &sgmiiphy12;
+		sgmii_phy13 = &sgmiiphy13;
+		sgmii_phy14 = &sgmiiphy14;
+		sgmii_phy21 = &sgmiiphy21;
+		sgmii_phy22 = &sgmiiphy22;
+		sgmii_phy23 = &sgmiiphy23;
+		sgmii_phy24 = &sgmiiphy24;
+		sgmii_phy31 = &sgmiiphy31;
+		sgmii_phy32 = &sgmiiphy32;
+		sgmii_phy33 = &sgmiiphy33;
+		sgmii_phy34 = &sgmiiphy34;
+		sgmii_phy41 = &sgmiiphy41;
+		sgmii_phy42 = &sgmiiphy42;
+		sgmii_phy43 = &sgmiiphy43;
+		sgmii_phy44 = &sgmiiphy44;
+		emi1_rgmii = &t4240mdio0;
+		emi1_slot1 = &t4240mdio1;
+		emi1_slot2 = &t4240mdio2;
+		emi1_slot3 = &t4240mdio3;
+		emi1_slot4 = &t4240mdio4;
+	};
+
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
@@ -91,8 +121,166 @@
 		};
 
 		board-control@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			compatible = "fsl,t4240qds-fpga", "fsl,fpga-qixis";
 			reg = <3 0 0x300>;
+			ranges = <0 3 0 0x300>;
+
+			mdio-mux-emi1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "mdio-mux-mmioreg", "mdio-mux";
+				mdio-parent-bus = <&mdio0>;
+				reg = <0x54 1>; /* BRDCFG1 */
+				mux-mask = <0xe0>; /* EMI1 */
+
+				/* Onboard PHYs */
+				t4240mdio0: mdio@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					phyrgmii1: ethernet-phy@1 { /* FM2.5 */
+						reg = <0x1>;
+					};
+					phyrgmii2: ethernet-phy@2 { /* FM1.5 */
+						reg = <0x2>;
+					};
+				};
+
+				/* Slot 1 */
+				t4240mdio1: mdio@20 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x20>;
+					status = "disabled";
+
+					phy1: ethernet-phy@0 {
+						reg = <0x0>;
+					};
+					phy2: ethernet-phy@1 {
+						reg = <0x1>;
+					};
+					phy3: ethernet-phy@2 {
+						reg = <0x2>;
+					};
+					phy4: ethernet-phy@3 {
+						reg = <0x3>;
+					};
+					sgmiiphy11: ethernet-phy@1c {
+						reg = <0x1c>;
+					};
+					sgmiiphy12: ethernet-phy@1d {
+						reg = <0x1d>;
+					};
+					sgmiiphy13: ethernet-phy@1e {
+						reg = <0x1e>;
+					};
+					sgmiiphy14: ethernet-phy@1f {
+						reg = <0x1f>;
+					};
+				};
+
+				/* Slot 2 */
+				t4240mdio2: mdio@40 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x40>;
+					status = "disabled";
+
+					phy5: ethernet-phy@4 {
+						reg = <0x4>;
+					};
+					phy6: ethernet-phy@5 {
+						reg = <0x5>;
+					};
+					phy7: ethernet-phy@6 {
+						reg = <0x6>;
+					};
+					phy8: ethernet-phy@7 {
+						reg = <0x7>;
+					};
+					sgmiiphy21: ethernet-phy@1c {
+						reg = <0x1c>;
+					};
+					sgmiiphy22: ethernet-phy@1d {
+						reg = <0x1d>;
+					};
+					sgmiiphy23: ethernet-phy@1e {
+						reg = <0x1e>;
+					};
+					sgmiiphy24: ethernet-phy@1f {
+						reg = <0x1f>;
+					};
+				};
+
+				/* Slot 3 */
+				t4240mdio3: mdio@60 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x60>;
+					status = "disabled";
+
+					phy9: ethernet-phy@8 {
+						reg = <0x8>;
+					};
+					phy10: ethernet-phy@9 {
+						reg = <0x9>;
+					};
+					phy11: ethernet-phy@a {
+						reg = <0xa>;
+					};
+					phy12: ethernet-phy@b {
+						reg = <0xb>;
+					};
+					sgmiiphy31: ethernet-phy@1c {
+						reg = <0x1c>;
+					};
+					sgmiiphy32: ethernet-phy@1d {
+						reg = <0x1d>;
+					};
+					sgmiiphy33: ethernet-phy@1e {
+						reg = <0x1e>;
+					};
+					sgmiiphy34: ethernet-phy@1f {
+						reg = <0x1f>;
+					};
+				};
+
+				/* Slot 4 */
+				t4240mdio4: mdio@80 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x80>;
+					status = "disabled";
+
+					phy13: ethernet-phy@c {
+						reg = <0xc>;
+					};
+					phy14: ethernet-phy@d {
+						reg = <0xd>;
+					};
+					phy15: ethernet-phy@e {
+						reg = <0xe>;
+					};
+					phy16: ethernet-phy@f {
+						reg = <0xf>;
+					};
+					sgmiiphy41: ethernet-phy@1c {
+						reg = <0x1c>;
+					};
+					sgmiiphy42: ethernet-phy@1d {
+						reg = <0x1d>;
+					};
+					sgmiiphy43: ethernet-phy@1e {
+						reg = <0x1e>;
+					};
+					sgmiiphy44: ethernet-phy@1f {
+						reg = <0x1f>;
+					};
+				};
+			};
 		};
 	};
 
@@ -207,6 +395,123 @@
 		sdhc@114000 {
 			voltage-ranges = <1800 1800 3300 3300>;
 		};
+
+		fman@400000 {
+			ethernet@e0000 {
+				phy-handle = <&phy5>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e2000 {
+				phy-handle = <&phy6>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e4000 {
+				phy-handle = <&phy7>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e6000 {
+				phy-handle = <&phy8>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e8000 {
+				phy-handle = <&phyrgmii2>;
+				phy-connection-type = "rgmii";
+			};
+
+			ethernet@ea000 {
+				phy-handle = <&phy2>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@f0000 { /* FM1@TSEC9/FM1@TGEC1 */
+				phy-handle = <&xauiphy1>;
+				phy-connection-type = "xgmii";
+			};
+
+			ethernet@f2000 { /* FM1@TSEC10/FM1@TGEC2 */
+				phy-handle = <&xauiphy2>;
+				phy-connection-type = "xgmii";
+			};
+
+			mdio@fc000 {
+				status = "disabled";
+			};
+
+			mdio@fd000 {
+				status = "disabled";
+			};
+		};
+
+		fman@500000 {
+			ethernet@e0000 {
+				phy-handle = <&phy13>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e2000 {
+				phy-handle = <&phy14>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e4000 {
+				phy-handle = <&phy15>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e6000 {
+				phy-handle = <&phy16>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e8000 {
+				phy-handle = <&phyrgmii1>;
+				phy-connection-type = "rgmii";
+			};
+
+			ethernet@ea000 {
+				phy-handle = <&phy10>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@f0000 { /* FM2@TSEC9/FM2@TGEC1 */
+				phy-handle = <&xauiphy3>;
+				phy-connection-type = "xgmii";
+			};
+
+			ethernet@f2000 { /* FM2@TSEC10/FM2@TGEC2 */
+				phy-handle = <&xauiphy4>;
+				phy-connection-type = "xgmii";
+			};
+
+			mdio0: mdio@fc000 {
+			};
+
+			mdio@fd000 {
+				xauiphy1: ethernet-phy@0 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x0>;
+				};
+
+				xauiphy2: ethernet-phy@1 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x1>;
+				};
+
+				xauiphy3: ethernet-phy@2 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x2>;
+				};
+
+				xauiphy4: ethernet-phy@3 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x3>;
+				};
+			};
+		};
 	};
 
 	pci0: pcie@ffe240000 {
-- 
1.8.3.1
