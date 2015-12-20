Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0116.outbound.protection.outlook.com [207.46.100.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 233B31A106E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2015 22:26:51 +1100 (AEDT)
From: <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC: <scottwood@freescale.com>, <madalin.bucur@freescale.com>,
 <shaohui.xie@freescale.com>, Igal Liberman <igal.liberman@freescale.com>
Subject: [PATCH] powerpc/mpc85xx: Add pcsphy nodes to FManV3 device tree
Date: Mon, 21 Dec 2015 01:57:31 +0200
Message-ID: <1450655851-6556-1-git-send-email-igal.liberman@freescale.com>
Reply-To: <igal.liberman@freescale.com>
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

From: Igal Liberman <igal.liberman@freescale.com>

Signed-off-by: Igal Liberman <igal.liberman@freescale.com>

This patch adds pcsphy node to FManV3 device tree.
Based on: https://patchwork.ozlabs.org/patch/503921/
---
 .../dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi   |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi |    5 +++++
 .../dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi   |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi  |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi  |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi  |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi  |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi  |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi  |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi  |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi  |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi  |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi  |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi  |    5 +++++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi  |    5 +++++
 18 files changed, 90 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi
index 2e441fa..e1a961f 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi
@@ -55,6 +55,7 @@ fman@400000 {
 		reg = <0xe0000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x08 &fman0_tx_0x28>;
 		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy0>;
 	};
 
 	mdio@e1000 {
@@ -62,5 +63,9 @@ fman@400000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xe1000 0x1000>;
+
+		pcsphy0: ethernet-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi
index 0b8f87f..c288f3c 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi
@@ -52,6 +52,7 @@ fman@400000 {
 		compatible = "fsl,fman-memac";
 		reg = <0xf0000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x10 &fman0_tx_0x30>;
+		pcsphy-handle = <&pcsphy6>;
 	};
 
 	mdio@f1000 {
@@ -59,5 +60,9 @@ fman@400000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xf1000 0x1000>;
+
+		pcsphy6: ethernet-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi
index ba6f227..94f3e71 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi
@@ -55,6 +55,7 @@ fman@400000 {
 		reg = <0xe2000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x09 &fman0_tx_0x29>;
 		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy1>;
 	};
 
 	mdio@e3000 {
@@ -62,5 +63,9 @@ fman@400000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xe3000 0x1000>;
+
+		pcsphy1: ethernet-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi
index 8860038..94a7698 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi
@@ -52,6 +52,7 @@ fman@400000 {
 		compatible = "fsl,fman-memac";
 		reg = <0xf2000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x11 &fman0_tx_0x31>;
+		pcsphy-handle = <&pcsphy7>;
 	};
 
 	mdio@f3000 {
@@ -59,5 +60,9 @@ fman@400000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xf3000 0x1000>;
+
+		pcsphy7: ethernet-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi
index ace9c13..09ffc2a 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi
@@ -51,6 +51,7 @@ fman@400000 {
 		reg = <0xe0000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x08 &fman0_tx_0x28>;
 		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy0>;
 	};
 
 	mdio@e1000 {
@@ -58,5 +59,9 @@ fman@400000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xe1000 0x1000>;
+
+		pcsphy0: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi
index a4fc286..60c3857 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi
@@ -51,6 +51,7 @@ fman@400000 {
 		reg = <0xe2000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x09 &fman0_tx_0x29>;
 		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy1>;
 	};
 
 	mdio@e3000 {
@@ -58,5 +59,9 @@ fman@400000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xe3000 0x1000>;
+
+		pcsphy1: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi
index 78596fa..f174fab 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi
@@ -51,6 +51,7 @@ fman@400000 {
 		reg = <0xe4000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x0a &fman0_tx_0x2a>;
 		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy2>;
 	};
 
 	mdio@e5000 {
@@ -58,5 +59,9 @@ fman@400000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xe5000 0x1000>;
+
+		pcsphy2: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi
index af93abd..eeea552 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi
@@ -51,6 +51,7 @@ fman@400000 {
 		reg = <0xe6000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x0b &fman0_tx_0x2b>;
 		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy3>;
 	};
 
 	mdio@e7000 {
@@ -58,5 +59,9 @@ fman@400000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xe7000 0x1000>;
+
+		pcsphy3: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi
index 97cffd7..0bf2d16 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi
@@ -51,6 +51,7 @@ fman@400000 {
 		reg = <0xe8000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x0c &fman0_tx_0x2c>;
 		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy4>;
 	};
 
 	mdio@e9000 {
@@ -58,5 +59,9 @@ fman@400000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xe9000 0x1000>;
+
+		pcsphy4: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi
index 232c5c2..fb0cb63 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi
@@ -51,6 +51,7 @@ fman@400000 {
 		reg = <0xea000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x0d &fman0_tx_0x2d>;
 		ptp-timer = <&ptp_timer0>;
+		pcsphy-handle = <&pcsphy5>;
 	};
 
 	mdio@eb000 {
@@ -58,5 +59,9 @@ fman@400000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xeb000 0x1000>;
+
+		pcsphy5: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi
index 89d64ee..29304c9 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi
@@ -52,6 +52,7 @@ fman@500000 {
 		compatible = "fsl,fman-memac";
 		reg = <0xf0000 0x1000>;
 		fsl,fman-ports = <&fman1_rx_0x10 &fman1_tx_0x30>;
+		pcsphy-handle = <&pcsphy14>;
 	};
 
 	mdio@f1000 {
@@ -59,5 +60,9 @@ fman@500000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xf1000 0x1000>;
+
+		pcsphy14: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi
index 7fa9260..8222ff3 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi
@@ -52,6 +52,7 @@ fman@500000 {
 		compatible = "fsl,fman-memac";
 		reg = <0xf2000 0x1000>;
 		fsl,fman-ports = <&fman1_rx_0x11 &fman1_tx_0x31>;
+		pcsphy-handle = <&pcsphy15>;
 	};
 
 	mdio@f3000 {
@@ -59,5 +60,9 @@ fman@500000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xf3000 0x1000>;
+
+		pcsphy15: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi
index 3d23666..303b218 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi
@@ -51,6 +51,7 @@ fman@500000 {
 		reg = <0xe0000 0x1000>;
 		fsl,fman-ports = <&fman1_rx_0x08 &fman1_tx_0x28>;
 		ptp-timer = <&ptp_timer1>;
+		pcsphy-handle = <&pcsphy8>;
 	};
 
 	mdio@e1000 {
@@ -58,5 +59,9 @@ fman@500000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xe1000 0x1000>;
+
+		pcsphy8: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi
index 97dc2ee..efe4845 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi
@@ -51,6 +51,7 @@ fman@500000 {
 		reg = <0xe2000 0x1000>;
 		fsl,fman-ports = <&fman1_rx_0x09 &fman1_tx_0x29>;
 		ptp-timer = <&ptp_timer1>;
+		pcsphy-handle = <&pcsphy9>;
 	};
 
 	mdio@e3000 {
@@ -58,5 +59,9 @@ fman@500000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xe3000 0x1000>;
+
+		pcsphy9: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi
index f084dd2..0a2c337 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi
@@ -51,6 +51,7 @@ fman@500000 {
 		reg = <0xe4000 0x1000>;
 		fsl,fman-ports = <&fman1_rx_0x0a &fman1_tx_0x2a>;
 		ptp-timer = <&ptp_timer1>;
+		pcsphy-handle = <&pcsphy10>;
 	};
 
 	mdio@e5000 {
@@ -58,5 +59,9 @@ fman@500000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xe5000 0x1000>;
+
+		pcsphy10: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi
index bb627b3..c86c20b 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi
@@ -51,6 +51,7 @@ fman@500000 {
 		reg = <0xe6000 0x1000>;
 		fsl,fman-ports = <&fman1_rx_0x0b &fman1_tx_0x2b>;
 		ptp-timer = <&ptp_timer1>;
+		pcsphy-handle = <&pcsphy11>;
 	};
 
 	mdio@e7000 {
@@ -58,5 +59,9 @@ fman@500000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xe7000 0x1000>;
+
+		pcsphy11: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi
index 821ed12..7114471 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi
@@ -51,6 +51,7 @@ fman@500000 {
 		reg = <0xe8000 0x1000>;
 		fsl,fman-ports = <&fman1_rx_0x0c &fman1_tx_0x2c>;
 		ptp-timer = <&ptp_timer1>;
+		pcsphy-handle = <&pcsphy12>;
 	};
 
 	mdio@e9000 {
@@ -58,5 +59,9 @@ fman@500000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xe9000 0x1000>;
+
+		pcsphy12: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi
index e245f1a..d2dabee 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi
@@ -51,6 +51,7 @@ fman@500000 {
 		reg = <0xea000 0x1000>;
 		fsl,fman-ports = <&fman1_rx_0x0d &fman1_tx_0x2d>;
 		ptp-timer = <&ptp_timer1>;
+		pcsphy-handle = <&pcsphy13>;
 	};
 
 	mdio@eb000 {
@@ -58,5 +59,9 @@ fman@500000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xeb000 0x1000>;
+
+		pcsphy13: pcs-phy@0 {
+			reg = <0x0>;
+		};
 	};
 };
-- 
1.7.9.5
