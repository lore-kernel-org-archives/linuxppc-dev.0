Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x22a.google.com (mail-ea0-x22a.google.com
 [IPv6:2a00:1450:4013:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E6E2B2C0362
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 05:33:17 +1000 (EST)
Received: by mail-ea0-f170.google.com with SMTP id f15so5756837eak.29
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 12:33:14 -0700 (PDT)
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v5 07/13] ARM: dove: add gigabit ethernet and mvmdio device
 tree nodes
Date: Wed, 29 May 2013 21:32:49 +0200
Message-Id: <1369855975-21489-8-git-send-email-sebastian.hesselbarth@gmail.com>
In-Reply-To: <1369855975-21489-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369855975-21489-1-git-send-email-sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds orion-eth and mvmdio device tree nodes for DT enabled
Dove boards. As there is only one ethernet controller on Dove, a default
phy node is also added with a note to set its reg property on a per-board
basis.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Changelog:
v3->v4:
- convert to new device tree binding

Cc: David Miller <davem@davemloft.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/dove-cubox.dts |    7 +++++++
 arch/arm/boot/dts/dove.dtsi      |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 7e3065a..02618fa 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -49,6 +49,13 @@
 &uart0 { status = "okay"; };
 &sata0 { status = "okay"; };
 &i2c0 { status = "okay"; };
+&mdio { status = "okay"; };
+&eth { status = "okay"; };
+
+&ethphy {
+	compatible = "marvell,88e1310";
+	reg = <1>;
+};
 
 &sdio0 {
 	status = "okay";
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 6cab468..8612658 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -258,5 +258,40 @@
 				dmacap,xor;
 			};
 		};
+
+		mdio: mdio-bus@72004 {
+			compatible = "marvell,orion-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x72004 0x84>;
+			interrupts = <30>;
+			clocks = <&gate_clk 2>;
+			status = "disabled";
+
+			ethphy: ethernet-phy {
+				device-type = "ethernet-phy";
+				/* set phy address in board file */
+			};
+		};
+
+		eth: ethernet-controller@72000 {
+			compatible = "marvell,orion-eth";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x72000 0x4000>;
+			clocks = <&gate_clk 2>;
+			marvell,tx-checksum-limit = <1600>;
+			status = "disabled";
+
+			ethernet-port@0 {
+				device_type = "network";
+				compatible = "marvell,orion-eth-port";
+				reg = <0>;
+				interrupts = <29>;
+				/* overwrite MAC address in bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				phy-handle = <&ethphy>;
+			};
+		};
 	};
 };
-- 
1.7.10.4
