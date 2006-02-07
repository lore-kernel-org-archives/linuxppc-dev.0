Return-Path: <bgill@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id ED1A2689F9
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 06:44:13 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k17JxtHl000157
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 12:59:55 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k17JrTRU019152
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 13:53:29 -0600 (CST)
Received: from cde-tx32-ldt329.sps.mot.com (cde-tx32-ldt329 [10.82.19.206])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	k17Jeo1v015377
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 13:40:51 -0600 (CST)
Received: from cde-tx32-ldt329.sps.mot.com (localhost [127.0.0.1])
	by cde-tx32-ldt329.sps.mot.com (Postfix) with ESMTP id ADE96C2DD7
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2006 13:44:09 -0600 (CST)
Received: from localhost (bgill@localhost)
	by cde-tx32-ldt329.sps.mot.com (8.12.11/8.12.11/Submit) with ESMTP id
	k17Ji9CI027853
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 13:44:09 -0600
Date: Tue, 7 Feb 2006 13:44:08 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add FSL USB node to documentation
Message-ID: <Pine.LNX.4.61.0602071342210.27842@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Documentation: Added FSL SOC USB node definition

Updated the documentation to include the definition of the USB device
node format for Freescale SOC devices.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 22970a5d9a7dd57512442e5f33c7fce708911bf9
tree 4bb85465dd12ecaf0213a985bd94e6c5546fb5d2
parent 3441bf59c7e1dc3823f9be57838a2536c78f6f8f
author Becky Bruce <becky.bruce@freescale.com> Mon, 06 Feb 2006 14:19:07 -0600
committer Becky Bruce <becky.bruce@freescale.com> Mon, 06 Feb 2006 14:19:07 -0600

 Documentation/powerpc/booting-without-of.txt |   60 ++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 54e5f9b..81a0507 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -44,7 +44,6 @@
                            compiler and the textural representation of
                            the tree that can be "compiled" by dtc.
 
-
    November 21, 2005: Rev 0.5
 			 - Additions/generalizations for 32-bit
 			 - Changed to reflect the new arch/powerpc
@@ -1307,6 +1306,65 @@ platforms are moved over to use the flat
 	};
 
 
+   f) Freescale SOC USB controllers
+
+   The device node for a USB controller that is part of a Freescale
+   SOC is as described in the document "Open Firmware Recommended
+   Practice : Universal Serial Bus" with the following modifications
+   and additions :  
+
+   Required properties :
+    - compatible : Should be "fsl-usb2-mph" for multi port host usb
+      controllers, or "fsl-usb2-dr" for dual role usb controllers
+    - phy_type : For multi port host usb controllers, should be one of
+      "ulpi", or "serial". For dual role usb controllers, should be
+      one of "ulpi", "utmi", "utmi_wide", or "serial".
+    - reg : Offset and length of the register set for the device
+    - port0 : boolean; if defined, indicates port0 is connected for
+      fsl-usb2-mph compatible controllers.  Either this property or
+      "port1" (or both) must be defined for "fsl-usb2-mph" compatible 
+      controllers.
+    - port1 : boolean; if defined, indicates port1 is connected for
+      fsl-usb2-mph compatible controllers.  Either this property or
+      "port0" (or both) must be defined for "fsl-usb2-mph" compatible 
+      controllers.
+
+   Recommended properties :
+    - interrupts : <a b> where a is the interrupt number and b is a
+      field that represents an encoding of the sense and level
+      information for the interrupt.  This should be encoded based on
+      the information in section 2) depending on the type of interrupt
+      controller you have.
+    - interrupt-parent : the phandle for the interrupt controller that
+      services interrupts for this device.
+
+   Example multi port host usb controller device node : 
+	usb@22000 {
+	        device_type = "usb";
+		compatible = "fsl-usb2-mph";
+		reg = <22000 1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupt-parent = <700>;
+		interrupts = <27 1>;
+		phy_type = "ulpi";
+		port0;
+		port1;
+	};
+
+   Example dual role usb controller device node : 
+	usb@23000 {
+		device_type = "usb";
+		compatible = "fsl-usb2-dr";
+		reg = <23000 1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupt-parent = <700>;
+		interrupts = <26 1>;
+		phy = "ulpi";
+	};
+
+
    More devices will be defined as this spec matures.
 
 
