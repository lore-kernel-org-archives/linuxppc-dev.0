Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D5957DDFA2
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 00:46:31 +1000 (EST)
Date: Thu, 17 May 2007 09:38:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Message-ID: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Document the use of device trees to describe devices on an I2C bus, which
will be used with David Brownell's "new style" I2C binding patches.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   34 ++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index b49ce16..67026ad 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1257,6 +1257,8 @@ platforms are moved over to use the flattened-device-tree model.
 
    e) I2C
 
+   e1) I2C Controller
+
    Required properties :
 
     - device_type : Should be "i2c"
@@ -1277,6 +1279,10 @@ platforms are moved over to use the flattened-device-tree model.
       a digital filter sampling rate register
     - fsl5200-clocking : boolean; if defined, indicated that this device
       uses the FSL 5200 clocking mechanism.
+    - #address-cells : should exist and be 1 if I2C devices are declared
+      in the device tree.
+    - #size-cells : should exist and be 0 if I2C devices are declared
+      in the device tree.
 
    Example :
 
@@ -1289,6 +1295,34 @@ platforms are moved over to use the flattened-device-tree model.
 		dfsrr;
 	};
 
+   e2) I2C Devices
+
+   Required properties :
+
+    - reg : Unshifted 7-bit I2C address for the device
+
+   Recommended properties :
+
+    - compatible : The name of the Linux device driver that
+      handles this device.  If unspecified, the name of the
+      node will be used.
+    - interrupts : <a b> where a is the interrupt number and b is a
+      field that represents an encoding of the sense and level
+      information for the interrupt.  This should be encoded based on
+      the information in section 2) depending on the type of interrupt
+      controller you have.
+    - interrupt-parent : the phandle for the interrupt controller that
+      services interrupts for this device.
+
+   Example :
+
+	rtc@68 {
+		device_type = "rtc";
+		compatible = "ds1374";
+		reg = <68>;
+		interrupts = <13 8>;
+		interrupt-parent = <700>;
+	};
 
    f) Freescale SOC USB controllers
 
-- 
1.5.0.3
