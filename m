Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BB0ADDFBB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 02:37:57 +1000 (EST)
Date: Wed, 24 Oct 2007 20:35:29 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] PowerPC: Update USB OHCI DTS entires for new bindings
Message-ID: <20071024163529.GA17869@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071024162223.GA17649@ru.mvista.com>
Cc: tnt@246tNt.com, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adjust mpc52xx DTS entries to support reworked ohci-ppc-of driver.
Use compatible "usb-ohci" and an empty big-endian property for 
USB_OHCI_BIG_ENDIAN_DESC and USB_OHCI_BIG_ENDIAN_MMIO support.
This also adds OHCI DTS entry for Sequoia PowerPC 440EPx board.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/dts/lite5200.dts  |    5 +++--
 arch/powerpc/boot/dts/lite5200b.dts |    5 +++--
 arch/powerpc/boot/dts/sequoia.dts   |    8 ++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff -pruN linux-2.6.orig/arch/powerpc/boot/dts/lite5200b.dts linux-2.6/arch/powerpc/boot/dts/lite5200b.dts
--- linux-2.6.orig/arch/powerpc/boot/dts/lite5200b.dts	2007-10-24 18:44:00.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/dts/lite5200b.dts	2007-10-24 19:20:31.000000000 +0400
@@ -183,8 +183,9 @@
 		};
 
 		usb@1000 {
-			device_type = "usb-ohci-be";
-			compatible = "mpc5200b-ohci","mpc5200-ohci","ohci-be";
+			device_type = "usb-ohci";
+			compatible = "mpc5200b-usb-ohci","mpc5200-usb-ohci","usb-ohci";
+			big-endian;
 			reg = <1000 ff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
diff -pruN linux-2.6.orig/arch/powerpc/boot/dts/lite5200.dts linux-2.6/arch/powerpc/boot/dts/lite5200.dts
--- linux-2.6.orig/arch/powerpc/boot/dts/lite5200.dts	2007-10-24 18:44:00.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/dts/lite5200.dts	2007-10-24 19:21:57.000000000 +0400
@@ -183,8 +183,9 @@
 		};
 
 		usb@1000 {
-			device_type = "usb-ohci-be";
-			compatible = "mpc5200-ohci","ohci-be";
+			device_type = "usb-ohci";
+			compatible = "mpc5200-usb-ohci","usb-ohci";
+			big-endian;
 			reg = <1000 ff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
diff -pruN linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts linux-2.6/arch/powerpc/boot/dts/sequoia.dts
--- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	2007-10-24 18:44:00.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/dts/sequoia.dts	2007-10-24 19:30:36.000000000 +0400
@@ -122,6 +122,14 @@
 			interrupt-map-mask = <ffffffff>;
 		};
 
+		USB1: usb@e0000400 {
+			compatible = "usb-ohci-440epx", "usb-ohci";
+			reg = <0 e0000400 60>;
+			big-endian;
+			interrupt-parent = <&UIC0>;
+			interrupts = <15 8>;
+		};
+
 		POB0: opb {
 		  	compatible = "ibm,opb-440epx", "ibm,opb";
 			#address-cells = <1>;
