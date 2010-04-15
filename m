Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 56D94B6F11
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 04:43:13 +1000 (EST)
Date: Thu, 15 Apr 2010 22:36:31 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Add eTSEC 2.0 support for P1020RDB boards
Message-ID: <20100415183631.GA25923@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>,
	Sandeep Gopalpet <sandeep.kumar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for eTSEC 2.0 as found in P1020.
The changes include introduction of the group nodes for
the etsec nodes.

Signed-off-by: Sandeep Gopalpet <sandeep.kumar@freescale.com>
Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---

This is based on
http://www.bitshrine.org/gpp/kernel-2.6.32-rc3-P1020RDB-DTS-Support-for-eTSEC-2.0-v0.patch
but revamped for the mainline's OF bindings.

 arch/powerpc/boot/dts/p1020rdb.dts |  119 ++++++++++++++++++++++++++++++++++++
 1 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/p1020rdb.dts
index df52690..49848c5 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dts
+++ b/arch/powerpc/boot/dts/p1020rdb.dts
@@ -19,6 +19,9 @@
 	aliases {
 		serial0 = &serial0;
 		serial1 = &serial1;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
 		pci0 = &pci0;
 		pci1 = &pci1;
 	};
@@ -346,6 +349,122 @@
 			};
 		};
 
+		mdio@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,etsec2-mdio";
+			reg = <0x24000 0x1000 0xb0030 0x4>;
+
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <3 1>;
+				reg = <0x0>;
+			};
+
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <2 1>;
+				reg = <0x1>;
+			};
+		};
+
+		mdio@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,etsec2-tbi";
+			reg = <0x25000 0x1000 0xb1030 0x4>;
+
+			tbi0: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		enet0: ethernet@b0000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,num_rx_queues = <0x8>;
+			fsl,num_tx_queues = <0x8>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = <&mpic>;
+			fixed-link = <1 1 1000 0 0>;
+			phy-connection-type = "rgmii-id";
+
+			queue-group@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb0000 0x1000>;
+				interrupts = <29 2 30 2 34 2>;
+			};
+
+			queue-group@1 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb4000 0x1000>;
+				interrupts = <17 2 18 2 24 2>;
+			};
+		};
+
+		enet1: ethernet@b1000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,num_rx_queues = <0x8>;
+			fsl,num_tx_queues = <0x8>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+			tbi-handle = <&tbi0>;
+			phy-connection-type = "sgmii";
+
+			queue-group@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb1000 0x1000>;
+				interrupts = <35 2 36 2 40 2>;
+			};
+
+			queue-group@1 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb5000 0x1000>;
+				interrupts = <51 2 52 2 67 2>;
+			};
+		};
+
+		enet2: ethernet@b2000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "fsl,etsec2";
+			fsl,num_rx_queues = <0x8>;
+			fsl,num_tx_queues = <0x8>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
+
+			queue-group@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb2000 0x1000>;
+				interrupts = <31 2 32 2 33 2>;
+			};
+
+			queue-group@1 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xb6000 0x1000>;
+				interrupts = <25 2 26 2 27 2>;
+			};
+		};
+
 		usb@22000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.7.0.3
