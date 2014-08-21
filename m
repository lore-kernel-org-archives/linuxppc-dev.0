Return-Path: <nikhil.badola@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F09A81A003C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 19:19:31 +1000 (EST)
From: Nikhil Badola <nikhil.badola@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Documentation: dts: fsl-usb: Document USB node compatible
 string for IP version
Date: Thu, 21 Aug 2014 14:48:47 +0530
Message-ID: <1408612727-6774-1-git-send-email-nikhil.badola@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Nikhil Badola <nikhil.badola@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Document compatible string containing IP version in USB device tree node

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
---
 Documentation/devicetree/bindings/usb/fsl-usb.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/fsl-usb.txt b/Documentation/devicetree/bindings/usb/fsl-usb.txt
index 4779c02..5a3a0a8 100644
--- a/Documentation/devicetree/bindings/usb/fsl-usb.txt
+++ b/Documentation/devicetree/bindings/usb/fsl-usb.txt
@@ -10,7 +10,10 @@ Required properties :
    controllers, or "fsl-usb2-dr" for dual role USB controllers
    or "fsl,mpc5121-usb2-dr" for dual role USB controllers of MPC5121.
    Wherever applicable, the IP version of the USB controller should
-   also be mentioned (for eg. fsl-usb2-dr-v2.2 for bsc9132).
+   also be mentioned in another string.
+   For multi port host USB controller with IP version <IP_Ver>, it should be
+   "fsl-usb2-mph-<IP_Ver>". For dual role USB controller with IP version
+   <IP_Ver>, it should be "fsl-usb2-dr-<IP_Ver>".
  - phy_type : For multi port host USB controllers, should be one of
    "ulpi", or "serial". For dual role USB controllers, should be
    one of "ulpi", "utmi", "utmi_wide", or "serial".
@@ -42,9 +45,9 @@ Optional properties :
  - fsl,invert-pwr-fault : boolean; for MPC5121 USB0 only. Indicates
    the PWR_FAULT signal polarity is inverted.
 
-Example multi port host USB controller device node :
+Example multi port host USB controller version 2.5 device node :
 	usb@22000 {
-		compatible = "fsl-usb2-mph";
+		compatible = "fsl-usb2-mph-v2.5", "fsl-usb2-mph";
 		reg = <22000 1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -55,9 +58,9 @@ Example multi port host USB controller device node :
 		port1;
 	};
 
-Example dual role USB controller device node :
+Example dual role USB controller version 2.5 device node :
 	usb@23000 {
-		compatible = "fsl-usb2-dr";
+		compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
 		reg = <23000 1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.7.11.7
