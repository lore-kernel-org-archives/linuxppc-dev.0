Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 7CA09DDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 17:10:13 +1000 (EST)
Date: Mon, 16 Apr 2007 09:10:10 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] mpc5200: lite5200(b) dts fixes
Message-ID: <20070416071010.GI18236@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Three trivial DTS fixes:
Mark Lite5200(b) boards as "mpc5200" compatible. On efika the
firmware already does that.
Fix mscan interrupt.
Fix wakeup GPIO address.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/boot/dts/lite5200.dts  |    5 +++--
 arch/powerpc/boot/dts/lite5200b.dts |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

Index: grant.git/arch/powerpc/boot/dts/lite5200.dts
===================================================================
--- grant.git.orig/arch/powerpc/boot/dts/lite5200.dts
+++ grant.git/arch/powerpc/boot/dts/lite5200.dts
@@ -49,6 +49,7 @@
 
 	soc5200@f0000000 {
 		model = "fsl,mpc5200";
+		compatible = "mpc5200";
 		revision = ""			// from bootloader
 		#interrupt-cells = <3>;
 		device_type = "soc";
@@ -167,7 +168,7 @@
 			device_type = "mscan";
 			compatible = "mpc5200-mscan";
 			cell-index = <1>;
-			interrupts = <1 12 0>;
+			interrupts = <2 12 0>;
 			interrupt-parent = <500>;
 			reg = <980 80>;
 		};
@@ -179,7 +180,7 @@
 			interrupt-parent = <500>;
 		};
 
-		gpio-wkup@b00 {
+		gpio-wkup@c00 {
 			compatible = "mpc5200-gpio-wkup";
 			reg = <c00 40>;
 			interrupts = <1 8 0 0 3 0>;
Index: grant.git/arch/powerpc/boot/dts/lite5200b.dts
===================================================================
--- grant.git.orig/arch/powerpc/boot/dts/lite5200b.dts
+++ grant.git/arch/powerpc/boot/dts/lite5200b.dts
@@ -49,6 +49,7 @@
 
 	soc5200@f0000000 {
 		model = "fsl,mpc5200b";
+		compatible = "mpc5200";
 		revision = "";			// from bootloader
 		#interrupt-cells = <3>;
 		device_type = "soc";
@@ -167,7 +168,7 @@
 			device_type = "mscan";
 			compatible = "mpc5200b-mscan\0mpc5200-mscan";
 			cell-index = <1>;
-			interrupts = <1 12 0>;
+			interrupts = <2 12 0>;
 			interrupt-parent = <500>;
 			reg = <980 80>;
 		};
@@ -179,7 +180,7 @@
 			interrupt-parent = <500>;
 		};
 
-		gpio-wkup@b00 {
+		gpio-wkup@c00 {
 			compatible = "mpc5200b-gpio-wkup\0mpc5200-gpio-wkup";
 			reg = <c00 40>;
 			interrupts = <1 8 0 0 3 0>;
