Return-Path: <sr@denx.de>
Received: from mo-p05-ob6.rzone.de (mo-p05-ob6.rzone.de
	[IPv6:2a01:238:20a:202:53f5::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC5BAB6F18
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2011 00:02:49 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/44x: Add NOR flash device to Yosemite dts
Date: Mon, 18 Jul 2011 15:49:14 +0200
Message-Id: <1310996954-25246-1-git-send-email-sr@denx.de>
Cc: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/yosemite.dts |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/yosemite.dts b/arch/powerpc/boot/dts/yosemite.dts
index 6492324..30bb475 100644
--- a/arch/powerpc/boot/dts/yosemite.dts
+++ b/arch/powerpc/boot/dts/yosemite.dts
@@ -138,6 +138,42 @@
 				clock-frequency = <0>; /* Filled in by zImage */
 				interrupts = <0x5 0x1>;
 				interrupt-parent = <&UIC1>;
+
+				nor_flash@0,0 {
+					compatible = "amd,s29gl256n", "cfi-flash";
+					bank-width = <2>;
+					reg = <0x00000000 0x00000000 0x04000000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					partition@0 {
+						label = "kernel";
+						reg = <0x00000000 0x001e0000>;
+					};
+					partition@1e0000 {
+						label = "dtb";
+						reg = <0x001e0000 0x00020000>;
+					};
+					partition@200000 {
+						label = "ramdisk";
+						reg = <0x00200000 0x01400000>;
+					};
+					partition@1600000 {
+						label = "jffs2";
+						reg = <0x01600000 0x00400000>;
+					};
+					partition@1a00000 {
+						label = "user";
+						reg = <0x01a00000 0x02540000>;
+					};
+					partition@3f40000 {
+						label = "env";
+						reg = <0x03f40000 0x00040000>;
+					};
+					partition@3f80000 {
+						label = "u-boot";
+						reg = <0x03f80000 0x00080000>;
+					};
+				};
 			};
 
 			UART0: serial@ef600300 {
-- 
1.7.6
