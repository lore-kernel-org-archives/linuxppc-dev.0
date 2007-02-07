Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 28874DDE45
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 16:49:57 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l175nt7V014964
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 22:49:55 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l175nqoj028531
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 23:49:54 -0600 (CST)
Message-ID: <45C968CD.300@freescale.com>
Date: Wed, 07 Feb 2007 13:51:09 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH 3/3] DTS updates for 8349emds USB peripheral support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add new dr_mode property to USB node, and update default
dts for 8439emds.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |    4 ++++
 arch/powerpc/boot/dts/mpc8349emds.dts        |    6 ++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 3399427..3b51467 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1334,6 +1334,9 @@ platforms are moved over to use the flattened-device-tree model.
       fsl-usb2-mph compatible controllers.  Either this property or
       "port0" (or both) must be defined for "fsl-usb2-mph" compatible 
       controllers.
+    - dr_mode : indicates the working mode for "fsl-usb2-dr" compatible
+      controllers.  Can be "host", "peripheral", or "otg".  Default to
+      "host" if not defined for backward compatibility.
 
    Recommended properties :
     - interrupts : <a b> where a is the interrupt number and b is a
@@ -1367,6 +1370,7 @@ platforms are moved over to use the flattened-device-tree model.
 		#size-cells = <0>;
 		interrupt-parent = <700>;
 		interrupts = <26 1>;
+		dr_mode = "otg";
 		phy = "ulpi";
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/boot/dts/mpc8349emds.dts
index efceb34..dc121b3 100644
--- a/arch/powerpc/boot/dts/mpc8349emds.dts
+++ b/arch/powerpc/boot/dts/mpc8349emds.dts
@@ -39,6 +39,11 @@
 		reg = <00000000 10000000>;	// 256MB at 0
 	};
 
+	bcsr@e2400000 {
+		device_type = "board-control";
+		reg = <e2400000 8000>;
+	};
+
 	soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -103,6 +108,7 @@
 			#size-cells = <0>;
 			interrupt-parent = <700>;
 			interrupts = <26 2>;
+			dr_mode = "otg";
 			phy_type = "ulpi";
 		};
 
