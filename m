Return-Path: <B32736@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A529E2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 20:59:33 +1100 (EST)
From: Zhicheng Fan <B32736@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/dts: Add qe support for 36bit
Date: Thu, 21 Mar 2013 17:26:01 +0800
Message-ID: <1363857961-23296-1-git-send-email-B32736@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhicheng Fan <B32736@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fixed the following errors:
	Error: arch/powerpc/boot/dts/p1025rdb.dtsi:326.2-3 label or path, 'qe', not found
	Error: arch/powerpc/boot/dts/fsl/p1021si-post.dtsi:242.2-3 label or path, 'qe', not found
	FATAL ERROR: Syntax error parsing input tree

Signed-off-by: Zhicheng Fan <B32736@freescale.com>
---
 arch/powerpc/boot/dts/p1025rdb_36b.dts |   48 ++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1025rdb_36b.dts b/arch/powerpc/boot/dts/p1025rdb_36b.dts
index 4ce4bfa..c74c39b 100644
--- a/arch/powerpc/boot/dts/p1025rdb_36b.dts
+++ b/arch/powerpc/boot/dts/p1025rdb_36b.dts
@@ -82,6 +82,54 @@
 				  0x0 0x100000>;
 		};
 	};
+
+	qe: qe@fffe80000 {
+		ranges = <0x0 0xf 0xffe80000 0x40000>;
+		reg = <0xf 0xffe80000 0 0x480>;
+		brg-frequency = <0>;
+		bus-frequency = <0>;
+		status = "disabled"; /* no firmware loaded */
+
+		enet3: ucc@2000 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			rx-clock-name = "clk12";
+			tx-clock-name = "clk9";
+			pio-handle = <&pio1>;
+			phy-handle = <&qe_phy0>;
+			phy-connection-type = "mii";
+		};
+
+		mdio@2120 {
+			qe_phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <4 1 0 0>;
+				reg = <0x6>;
+				device_type = "ethernet-phy";
+			};
+			qe_phy1: ethernet-phy@03 {
+				interrupt-parent = <&mpic>;
+				interrupts = <5 1 0 0>;
+				reg = <0x3>;
+				device_type = "ethernet-phy";
+			};
+			tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		enet4: ucc@2400 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			rx-clock-name = "none";
+			tx-clock-name = "clk13";
+			pio-handle = <&pio2>;
+			phy-handle = <&qe_phy1>;
+			phy-connection-type = "rmii";
+		};
+	};
+
 };
 
 /include/ "p1025rdb.dtsi"
-- 
1.7.0.4
