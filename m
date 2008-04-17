Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13913DEFEB
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 05:40:39 +1000 (EST)
Date: Thu, 17 Apr 2008 23:37:44 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC 44x: Add NOR flash entry to Canyonlands DTS.
Message-ID: <20080417193744.GA17524@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds NOR flash entry to the PowerPC 460EX Canyonlands DTS.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/dts/canyonlands.dts |   36 ++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+)

diff -pruN powerpc/arch/powerpc/boot/dts/canyonlands.dts powerpc.new/arch/powerpc/boot/dts/canyonlands.dts
--- powerpc/arch/powerpc/boot/dts/canyonlands.dts	2008-04-14 22:07:26.000000000 +0400
+++ powerpc.new/arch/powerpc/boot/dts/canyonlands.dts	2008-04-17 23:07:39.000000000 +0400
@@ -144,6 +144,42 @@
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				interrupts = <6 4>;
 				interrupt-parent = <&UIC1>;
+
+				nor_flash@0,0 {
+					compatible = "amd,s29gl512n", "cfi-flash";
+					bank-width = <2>;
+					reg = <0 000000 4000000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					partition@0 {
+						label = "unavailable";
+						reg = <0 3000000>;
+					};
+					partition@3000000 {
+						label = "kernel";
+						reg = <3000000 1e0000>;
+					};
+					partition@31e0000 {
+						label = "fdt";
+						reg = <31e0000 20000>;
+					};
+					partition@3200000 {
+						label = "ramdisk";
+						reg = <3200000 700000>;
+					};
+					partition@3900000 {
+						label = "unused";
+						reg = <3900000 660000>;
+					};
+					partition@3f60000 {
+						label = "env";
+						reg = <3f60000 40000>;
+					};
+					partition@3fa0000 {
+						label = "u-boot";
+						reg = <3fa0000 60000>;
+					};
+				};				
 			};
 
 			UART0: serial@ef600300 {
