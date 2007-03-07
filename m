Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id DE8F1DDEF4
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 04:47:45 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l27Hlgq7004096
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 10:47:42 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l27HlguB023166
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 11:47:42 -0600 (CST)
Subject: [PATCH] Added 2nd PCI-Ex controller support for MPC8641.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1173289661.23776.115.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 07 Mar 2007 11:47:41 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Zhang Wei <wei.zhang@freescale.com>

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 8a4995a..19121ea 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -300,6 +300,30 @@
 			};
 
 		};
+
+		pci@9000 {
+			compatible = "86xx";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <9000 1000>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 a0000000 a0000000 0 20000000
+				  01000000 0 00000000 e3000000 0 00100000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <19 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 44 1
+				0000 0 0 2 &mpic 45 1
+				0000 0 0 3 &mpic 46 1
+				0000 0 0 4 &mpic 47 1
+				>;
+		};
+
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
-- 
1.5.0.1.213.g509b
