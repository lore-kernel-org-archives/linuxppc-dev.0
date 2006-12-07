Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 7C5C067D0E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 04:38:14 +1100 (EST)
Date: Thu, 7 Dec 2006 11:33:53 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] powerpc: Document device nodes for I2C devices.
Message-ID: <20061207173353.GD22989@ld0162-tx32.am.freescale.net>
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
index 27b457c..092b8f3 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1277,6 +1277,8 @@ platforms are moved over to use the flat
 
    e) I2C
 
+   e1) I2C Controller
+
    Required properties :
 
     - device_type : Should be "i2c"
@@ -1297,6 +1299,10 @@ platforms are moved over to use the flat
       a digital filter sampling rate register
     - fsl5200-clocking : boolean; if defined, indicated that this device
       uses the FSL 5200 clocking mechanism.
+    - #address-cells : should exist and be 1 if I2C devices are declared
+      in the device tree.
+    - #size-cells : should exist and be 0 if I2C devices are declared
+      in the device tree.
 
    Example :
 
@@ -1309,6 +1315,34 @@ platforms are moved over to use the flat
 		dfsrr;
 	};
 
+   e2) I2C Devices
+
+   Required properties :
+
+    - reg : I2C address for the device
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
1.4.2.3
