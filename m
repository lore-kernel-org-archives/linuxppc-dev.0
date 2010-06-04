Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DAE2B7D61
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jun 2010 18:30:14 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/44x: Fix UART2/3 interrupt assignment in PPC460EX/GT
	dts files
Date: Fri,  4 Jun 2010 10:29:59 +0200
Message-Id: <1275640199-32680-1-git-send-email-sr@denx.de>
Cc: Fabien Proriol <Fabien.Proriol@jdsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

UART2 and UART3 on 460EX/GT have incorrect interrupt mappings right now.
UART2 should be 28 (0x1c) and UART3 29 (0x1d). This patch fixes this and
switches to using decimal number instead of hex, since the AppliedMicro
(AMCC) users manuals describe their inerrupt numbers in decimal.

Thanks to Fabien Proriol for pointing this out.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Fabien Proriol <Fabien.Proriol@jdsu.com>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/canyonlands.dts |    4 ++--
 arch/powerpc/boot/dts/glacier.dts     |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index cd56bb5..5806ef0 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -270,7 +270,7 @@
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>; /* Filled in by U-Boot */
 				interrupt-parent = <&UIC1>;
-				interrupts = <0x1d 0x4>;
+				interrupts = <28 0x4>;
 			};
 
 			UART3: serial@ef600600 {
@@ -281,7 +281,7 @@
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>; /* Filled in by U-Boot */
 				interrupt-parent = <&UIC1>;
-				interrupts = <0x1e 0x4>;
+				interrupts = <29 0x4>;
 			};
 
 			IIC0: i2c@ef600700 {
diff --git a/arch/powerpc/boot/dts/glacier.dts b/arch/powerpc/boot/dts/glacier.dts
index d62a4fb..e618fc4 100644
--- a/arch/powerpc/boot/dts/glacier.dts
+++ b/arch/powerpc/boot/dts/glacier.dts
@@ -259,7 +259,7 @@
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>; /* Filled in by U-Boot */
 				interrupt-parent = <&UIC1>;
-				interrupts = <0x1d 0x4>;
+				interrupts = <28 0x4>;
 			};
 
 			UART3: serial@ef600600 {
@@ -270,7 +270,7 @@
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>; /* Filled in by U-Boot */
 				interrupt-parent = <&UIC1>;
-				interrupts = <0x1e 0x4>;
+				interrupts = <29 0x4>;
 			};
 
 			IIC0: i2c@ef600700 {
-- 
1.7.1
