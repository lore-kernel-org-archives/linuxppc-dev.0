Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD87BDDF19
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:50:57 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 09/25] [POWERPC] Add basic PCI node for mpc8568mds board
Date: Mon, 23 Jul 2007 15:49:56 -0500
Message-Id: <11852238253550-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238241475-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
Cc: Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8568mds.dts |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 6bb18f2..54cde68 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -170,6 +170,35 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		pci@8000 {
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x12 AD18 */
+				9000 0 0 1 &mpic 5 1
+				9000 0 0 2 &mpic 6 1
+				9000 0 0 3 &mpic 7 1
+				9000 0 0 4 &mpic 4 1
+
+				/* IDSEL 0x13 AD19 */
+				9800 0 0 1 &mpic 6 1
+				9800 0 0 2 &mpic 7 1
+				9800 0 0 3 &mpic 4 1
+				9800 0 0 4 &mpic 5 1>;
+
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 e2000000 0 00800000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+			compatible = "fsl,mpc8540-pci";
+			device_type = "pci";
+		};
+
 		serial@4600 {
 			device_type = "serial";
 			compatible = "ns16550";
-- 
1.5.2.2
