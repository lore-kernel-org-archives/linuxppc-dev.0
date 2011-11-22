Return-Path: <tinamdar@amcc.com>
Received: from denmail01.apm.com (unknown [192.195.68.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 623E9B70B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 19:07:10 +1100 (EST)
From: Tanmay Inamdar <tinamdar@apm.com>
To: benh@kernel.crashing.org
Subject: powerpc: dts: Fix canyonlands EMAC interrupt map
Date: Tue, 22 Nov 2011 12:41:17 +0530
Message-Id: <1321945877-22802-1-git-send-email-tinamdar@apm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Tanmay Inamdar <tinamdar@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixing interrupt mapping of EMAC for canyonlands

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 arch/powerpc/boot/dts/canyonlands.dts |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 3dc75de..c76bbcd 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -360,13 +360,11 @@
 			EMAC0: ethernet@ef600e00 {
 				device_type = "network";
 				compatible = "ibm,emac-460ex", "ibm,emac4sync";
-				interrupt-parent = <&EMAC0>;
-				interrupts = <0x0 0x1>;
-				#interrupt-cells = <1>;
+				interrupt-parent = <&UIC2>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0x0 &UIC2 0x10 0x4
-						 /*Wake*/   0x1 &UIC2 0x14 0x4>;
+				interrupts = </*Status*/0x10 0x4
+						/*Wake*/0x14 0x4>;
 				reg = <0xef600e00 0x000000c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
@@ -390,13 +388,11 @@
 			EMAC1: ethernet@ef600f00 {
 				device_type = "network";
 				compatible = "ibm,emac-460ex", "ibm,emac4sync";
-				interrupt-parent = <&EMAC1>;
-				interrupts = <0x0 0x1>;
-				#interrupt-cells = <1>;
+				interrupt-parent = <&UIC2>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0x0 &UIC2 0x11 0x4
-						 /*Wake*/   0x1 &UIC2 0x15 0x4>;
+				interrupts = </*Status*/0x11 0x4
+						/*Wake*/0x15 0x4>;
 				reg = <0xef600f00 0x000000c4>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
-- 
1.6.1.rc3
