Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6841DDEE3
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 01:53:37 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6AFrXp9002203
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 08:53:33 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6AFrVVp011506
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:53:32 -0500 (CDT)
Subject: [patch 6/6] Add basic PCI node for mpc8568mds board
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1184082799.20129.195.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 10 Jul 2007 23:53:19 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Add basic PCI node for mpc8568mds board.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 6bb18f2..c6cd1d6 100644
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
+			compatible = "fsl,mpc85xx-pci","85xx";
+			device_type = "pci";
+		};
+
 		serial@4600 {
 			device_type = "serial";
 			compatible = "ns16550";
-- 
1.5.1
