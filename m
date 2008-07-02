Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DDDA1DDEFE
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 06:26:08 +1000 (EST)
Date: Wed, 2 Jul 2008 15:25:18 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 1/5] Document Freescale power management nodes, and the
	sleep property.
Message-ID: <20080702202518.GA15304@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |  207 ++++++++++++++++++++-----
 1 files changed, 165 insertions(+), 42 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index f6394b5..b058b6e 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -62,6 +62,7 @@ Table of Contents
       s) Freescale on board FPGA
       t) Freescael MSI interrupt controller
       u) Freescale General-purpose Timers Module
+      v) Freescale Power Management Controller
 
   VII - Marvell Discovery mv64[345]6x System Controller chips
     1) The /system-controller node
@@ -92,10 +93,12 @@ Table of Contents
     3) OpenPIC Interrupt Controllers
     4) ISA Interrupt Controllers
 
-  VIII - Specifying GPIO information for devices
+  IX - Specifying GPIO information for devices
     1) gpios property
     2) gpio-controller nodes
 
+  X - Specifying device power management information (sleep property)
+
   Appendix A - Sample SOC node for MPC8540
 
 
@@ -3009,6 +3012,70 @@ platforms are moved over to use the flattened-device-tree model.
 	clock-frequency = <0>;
     };
 
+    v) Freescale Power Management Controller
+
+    Properties:
+    - compatible: "fsl,<chip>-pmc".
+
+      "fsl,mpc8349-pmc" should be listed for any chip whose PMC is
+      compatible.  "fsl,mpc8313-pmc" should also be listed for any chip
+      whose PMC is compatible, and implies deep-sleep capability.
+
+      "fsl,mpc8548-pmc" should be listed for any chip whose PMC is
+      compatible.  "fsl,mpc8536-pmc" should also be listed for any chip
+      whose PMC is compatible, and implies deep-sleep capability.
+
+      "fsl,mpc8641d-pmc" should be listed for any chip whose PMC is
+      compatible; all statements below that apply to "fsl,mpc8548-pmc" also
+      apply to "fsl,mpc8641d-pmc".
+
+      Compatibility does not include bit assigments in SCCR/PMCDR/DEVDISR;
+      these bit assigments are indicated via the sleep specifier in each
+      device's sleep property.
+
+    - reg: For devices compatible with "fsl,mpc8349-pmc", the first resource
+      is the PMC block, and the second resource is the Clock Configuration
+      block.
+
+      For devices compatible with "fsl,mpc8548-pmc", the first resource
+      is a 32-byte block beginning with DEVDISR.
+
+    - interrupts: For "fsl,mpc8349-pmc"-compatible devices, the first
+      resource is the PMC block interrupt.
+
+    - fsl,mpc8313-wakeup-timer: For "fsl,mpc8313-pmc"-compatible devices,
+      this is a phandle to an "fsl,gtm" node on which timer 4 can be used as
+      a wakeup source from deep sleep.
+
+    Sleep specifiers:
+
+      fsl,mpc8349-pmc: Sleep specifiers consist of one cell.  For each bit
+      that is set in the cell, the corresponding bit in SCCR will be saved
+      and cleared on suspend, and restored on resume.  This sleep controller
+      supports disabling and resuming devices at any time.
+
+      fsl,mpc8536-pmc: Sleep specifiers consist of three cells, the third of
+      which will be ORed into PMCDR upon suspend, and cleared from PMCDR
+      upon resume.  The first two cells are as described for fsl,mpc8578-pmc.
+      This sleep controller only supports disabling devices during system
+      sleep, or permanently.
+
+      fsl,mpc8548-pmc: Sleep specifiers consist of one or two cells, the
+      first of which will be ORed into DEVDISR (and the second into
+      DEVDISR2, if present -- this cell should be zero or absent if the
+      hardware does not have DEVDISR2) upon a request for permanent device
+      disabling.  This sleep controller does not support configuring devices
+      to disable during system sleep (unless supported by another compatible
+      match), or dynamically.
+
+    Example:
+
+	power@b00 {
+		compatible = "fsl,mpc8313-pmc", "fsl,mpc8349-pmc";
+		reg = <0xb00 0x100 0xa00 0x100>;
+		interrupts = <80 8>;
+	};
+
 VII - Marvell Discovery mv64[345]6x System Controller chips
 ===========================================================
 
@@ -3616,8 +3683,8 @@ encodings listed below:
 	2 =  high to low edge sensitive type enabled
 	3 =  low to high edge sensitive type enabled
 
-VIII - Specifying GPIO information for devices
-==============================================
+IX - Specifying GPIO information for devices
+============================================
 
 1) gpios property
 -----------------
@@ -3665,6 +3732,37 @@ Example of two SOC GPIO banks defined as gpio-controller nodes:
 		gpio-controller;
 	};
 
+X - Specifying Device Power Management Information (sleep property)
+===================================================================
+
+Devices on SOCs often have mechanisms for placing devices into low-power
+states that are decoupled from the devices' own register blocks.  Sometimes,
+this information is more complicated than a cell-index property can
+reasonably describe.  Thus, each device controlled in such a manner
+may contain a "sleep" property which describes these connections.
+
+The sleep property consists of one or more sleep resources, each of
+which consists of a phandle to a sleep controller, followed by a
+controller-specific sleep specifier of zero or more cells.
+
+The semantics of what type of low power modes are possible are defined
+by the sleep controller.  Some examples of the types of low power modes
+that may be supported are:
+
+ - Dynamic: The device may be disabled or enabled at any time.
+ - System Suspend: The device may request to be disabled or remain
+   awake during system suspend, but will not be disabled until then.
+ - Permanent: The device is disabled permanently (until the next hard
+   reset).
+
+Some devices may share a clock domain with each other, such that they should
+only be suspended when none of the devices are in use.  Where reasonable,
+such nodes should be placed on a virtual bus, where the bus has the sleep
+property.  If the clock domain is shared among devices that cannot be
+reasonably grouped in this manner, then create a virtual sleep controller
+(similar to an interrupt nexus, except that defining a standardized
+sleep-map should wait until its necessity is demonstrated).
+
 Appendix A - Sample SOC node for MPC8540
 ========================================
 
@@ -3681,47 +3779,48 @@ not necessary as they are usually the same as the root node.
 		reg = <e0000000 00003000>;
 		bus-frequency = <0>;
 
-		mdio@24520 {
-			reg = <24520 20>;
-			device_type = "mdio";
-			compatible = "gianfar";
-
-			ethernet-phy@0 {
-				linux,phandle = <2452000>
-				interrupt-parent = <40000>;
-				interrupts = <35 1>;
-				reg = <0>;
-				device_type = "ethernet-phy";
-			};
-
-			ethernet-phy@1 {
-				linux,phandle = <2452001>
-				interrupt-parent = <40000>;
-				interrupts = <35 1>;
-				reg = <1>;
-				device_type = "ethernet-phy";
-			};
-
-			ethernet-phy@3 {
-				linux,phandle = <2452002>
-				interrupt-parent = <40000>;
-				interrupts = <35 1>;
-				reg = <3>;
-				device_type = "ethernet-phy";
-			};
-
-		};
-
 		ethernet@24000 {
-			#size-cells = <0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 			device_type = "network";
 			model = "TSEC";
-			compatible = "gianfar";
+			compatible = "gianfar", "simple-bus";
 			reg = <24000 1000>;
 			mac-address = [ 00 E0 0C 00 73 00 ];
 			interrupts = <d 3 e 3 12 3>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452000>;
+			sleep = <&pmc 00000080>;
+			ranges;
+			
+			mdio@24520 {
+				reg = <24520 20>;
+				compatible = "fsl,gianfar-mdio";
+
+				ethernet-phy@0 {
+					linux,phandle = <2452000>
+					interrupt-parent = <40000>;
+					interrupts = <35 1>;
+					reg = <0>;
+					device_type = "ethernet-phy";
+				};
+
+				ethernet-phy@1 {
+					linux,phandle = <2452001>
+					interrupt-parent = <40000>;
+					interrupts = <35 1>;
+					reg = <1>;
+					device_type = "ethernet-phy";
+				};
+
+				ethernet-phy@3 {
+					linux,phandle = <2452002>
+					interrupt-parent = <40000>;
+					interrupts = <35 1>;
+					reg = <3>;
+					device_type = "ethernet-phy";
+				};
+			};
 		};
 
 		ethernet@25000 {
@@ -3735,6 +3834,7 @@ not necessary as they are usually the same as the root node.
 			interrupts = <13 3 14 3 18 3>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452001>;
+			sleep = <&pmc 00000040>;
 		};
 
 		ethernet@26000 {
@@ -3748,15 +3848,33 @@ not necessary as they are usually the same as the root node.
 			interrupts = <19 3>;
 			interrupt-parent = <40000>;
 			phy-handle = <2452002>;
+			sleep = <&pmc 00000020>;
 		};
 
 		serial@4500 {
-			device_type = "serial";
-			compatible = "ns16550";
-			reg = <4500 100>;
-			clock-frequency = <0>;
-			interrupts = <1a 3>;
-			interrupt-parent = <40000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8540-duart", "simple-bus";
+			sleep = <&pmc 00000002>;
+			ranges;
+
+			serial@4500 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <4500 100>;
+				clock-frequency = <0>;
+				interrupts = <1a 3>;
+				interrupt-parent = <40000>;
+			};
+
+			serial@4600 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <4600 100>;
+				clock-frequency = <0>;
+				interrupts = <1a 3>;
+				interrupt-parent = <40000>;
+			};
 		};
 
 		pic@40000 {
@@ -3775,6 +3893,11 @@ not necessary as they are usually the same as the root node.
 			device_type = "i2c";
 			compatible  = "fsl-i2c";
 			dfsrr;
+			sleep = <&pmc 00000004>;
 		};
 
+		pmc: power@e0070 {
+			compatible = "fsl,mpc8540-pmc", "fsl,mpc8548-pmc";
+			reg = <e0070 20>;
+		};
 	};
-- 
1.5.6
