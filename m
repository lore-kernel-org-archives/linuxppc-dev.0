Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x22c.google.com (mail-ea0-x22c.google.com
 [IPv6:2a00:1450:4013:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 662A42C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 02:42:22 +1000 (EST)
Received: by mail-ea0-f172.google.com with SMTP id d10so537167eaj.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 09:42:18 -0700 (PDT)
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v4 08/12] ARM: orion5x: add gigabit ethernet and mvmdio device
 tree nodes
Date: Tue, 21 May 2013 18:41:46 +0200
Message-Id: <1369154510-4927-9-git-send-email-sebastian.hesselbarth@gmail.com>
In-Reply-To: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
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

This patch adds mv643xx_eth and mvmdio device tree nodes for DT enabled
Orion5x boards. Phy nodes are also added with reg property set on a
per-board basis.

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
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |   17 ++++++++++++
 arch/arm/boot/dts/orion5x.dtsi                     |   29 ++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
index 0077fc8..c7e2efd 100644
--- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -53,3 +53,20 @@
 		};
 	};
 };
+
+&mdio {
+	status = "okay";
+
+	&ethphy: ethernet-phy {
+		device-type = "ethernet-phy";
+		reg = <8>;
+	};
+};
+
+&eth {
+	status = "okay";
+
+	ethernet-port@0 {
+		phy-handle = <&ethphy>;
+	};
+};
diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 892c64e..6fe45d5 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -132,5 +132,34 @@
 			interrupts = <28>;
 			status = "okay";
 		};
+
+		mdio: mdio-bus@72004 {
+			compatible = "marvell,orion-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x72004 0x84>;
+			interrupts = <22>;
+			status = "disabled";
+
+			/* add phy nodes in board file */
+		};
+
+		eth: ethernet-controller@72000 {
+			compatible = "marvell,orion-eth";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x72000 0x4000>;
+			marvell,tx-checksum-limit = <1600>;
+			status = "disabled";
+
+			ethernet-port@0 {
+				device_type = "network";
+				compatible = "marvell,orion-eth-port";
+				reg = <0>;
+				/* overwrite MAC address in bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				/* set phy-handle property in board file */
+			};
+		};
 	};
 };
-- 
1.7.10.4
