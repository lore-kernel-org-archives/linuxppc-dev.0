Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC8C22C020C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 19:57:46 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/sgmii: Add phy nodes in SGMII mode
Date: Thu, 12 Jul 2012 17:36:16 +0800
Message-ID: <1342085776-13289-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In SGMII riser card different PHY chip are used with different external
IRQ from eTSEC. To support PHY link state auto detect in SGMII mode we
should add another group of PHY nodes for SGMII mode.

For MPC8572DS IRQ6 is used for PHY0~PHY1, IRQ7 is used for PHY2~PHY3.
For MPC8544DS and MPC8536DS IRQ6 is used for PHY0~PHY1.
For P2020DS IRQ5 is used for PHY1~PHY2.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
---
 arch/powerpc/boot/dts/mpc8536ds.dtsi |    8 ++++++++
 arch/powerpc/boot/dts/mpc8544ds.dtsi |    9 +++++++++
 arch/powerpc/boot/dts/mpc8572ds.dtsi |   17 +++++++++++++++++
 arch/powerpc/boot/dts/p2020ds.dtsi   |   10 ++++++++++
 4 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8536ds.dtsi b/arch/powerpc/boot/dts/mpc8536ds.dtsi
index cc46dbd..d304a2d 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dtsi
+++ b/arch/powerpc/boot/dts/mpc8536ds.dtsi
@@ -203,6 +203,14 @@
 			reg = <1>;
 			device_type = "ethernet-phy";
 		};
+		sgmii_phy0: sgmii-phy@0 {
+			interrupts = <6 1 0 0>;
+			reg = <0x1d>;
+		};
+		sgmii_phy1: sgmii-phy@1 {
+			interrupts = <6 1 0 0>;
+			reg = <0x1c>;
+		};
 		tbi0: tbi-phy@11 {
 			reg = <0x11>;
 			device_type = "tbi-phy";
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dtsi b/arch/powerpc/boot/dts/mpc8544ds.dtsi
index 270f64b..77ebc9f 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dtsi
+++ b/arch/powerpc/boot/dts/mpc8544ds.dtsi
@@ -51,6 +51,15 @@
 			device_type = "ethernet-phy";
 		};
 
+		sgmii_phy0: sgmii-phy@0 {
+			interrupts = <6 1 0 0>;
+			reg = <0x1c>;
+		};
+		sgmii_phy1: sgmii-phy@1 {
+			interrupts = <6 1 0 0>;
+			reg = <0x1d>;
+		};
+
 		tbi0: tbi-phy@11 {
 			reg = <0x11>;
 			device_type = "tbi-phy";
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dtsi b/arch/powerpc/boot/dts/mpc8572ds.dtsi
index 1417894..357490b 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dtsi
+++ b/arch/powerpc/boot/dts/mpc8572ds.dtsi
@@ -169,6 +169,23 @@
 			reg = <0x3>;
 		};
 
+		sgmii_phy0: sgmii-phy@0 {
+			interrupts = <6 1 0 0>;
+			reg = <0x1c>;
+		};
+		sgmii_phy1: sgmii-phy@1 {
+			interrupts = <6 1 0 0>;
+			reg = <0x1d>;
+		};
+		sgmii_phy2: sgmii-phy@2 {
+			interrupts = <7 1 0 0>;
+			reg = <0x1e>;
+		};
+		sgmii_phy3: sgmii-phy@3 {
+			interrupts = <7 1 0 0>;
+			reg = <0x1f>;
+		};
+
 		tbi0: tbi-phy@11 {
 			reg = <0x11>;
 			device_type = "tbi-phy";
diff --git a/arch/powerpc/boot/dts/p2020ds.dtsi b/arch/powerpc/boot/dts/p2020ds.dtsi
index d3b939c..e699cf9 100644
--- a/arch/powerpc/boot/dts/p2020ds.dtsi
+++ b/arch/powerpc/boot/dts/p2020ds.dtsi
@@ -150,6 +150,16 @@
 			interrupts = <3 1 0 0>;
 			reg = <0x2>;
 		};
+
+		sgmii_phy1: sgmii-phy@1 {
+			interrupts = <5 1 0 0>;
+			reg = <0x1c>;
+		};
+		sgmii_phy2: sgmii-phy@2 {
+			interrupts = <5 1 0 0>;
+			reg = <0x1d>;
+		};
+
 		tbi0: tbi-phy@11 {
 			reg = <0x11>;
 			device_type = "tbi-phy";
-- 
1.7.5.1
