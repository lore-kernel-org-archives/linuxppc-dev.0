Return-Path: <b08248@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 0E3EADDF4E
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 10:25:16 +1100 (EST)
Date: Wed, 21 Feb 2007 17:25:11 -0600
From: Stuart Yoder <b08248@freescale.com>
Message-Id: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: document new interrupt-array property
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Added description of an interrupt-array property. This
is needed to cleanly describe the interrupt properties
of devices with interrupts routed to multiple 
interrupt controllers.

Created a new section VII to describe interrupt
representation in general and moved Section VI #2 
('Specifiying interrupt information for SOC devices')
to this new section.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---

 This proposal was based on an offline email exchange with
 Ben and David Gibson.


 Documentation/powerpc/booting-without-of.txt |  149 +++++++++++++++++++-------
 1 files changed, 111 insertions(+), 38 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index eaa0c32..d6d4d09 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1108,42 +1108,7 @@ See appendix A for an example partial SO
 MPC8540.
 
 
-2) Specifying interrupt information for SOC devices
----------------------------------------------------
-
-Each device that is part of an SOC and which generates interrupts
-should have the following properties:
-
-	- interrupt-parent : contains the phandle of the interrupt
-          controller which handles interrupts for this device
-	- interrupts : a list of tuples representing the interrupt
-          number and the interrupt sense and level for each interrupt
-          for this device.
-
-This information is used by the kernel to build the interrupt table
-for the interrupt controllers in the system.
-
-Sense and level information should be encoded as follows:
-
-   Devices connected to openPIC-compatible controllers should encode
-   sense and polarity as follows:
-
-	0 = low to high edge sensitive type enabled
-	1 = active low level sensitive type enabled
-	2 = active high level sensitive type enabled
-	3 = high to low edge sensitive type enabled
-
-   ISA PIC interrupt controllers should adhere to the ISA PIC
-   encodings listed below:
-
-	0 =  active low level sensitive type enabled
-	1 =  active high level sensitive type enabled
-	2 =  high to low edge sensitive type enabled
-	3 =  low to high edge sensitive type enabled
-
-
-
-3) Representing devices without a current OF specification
+2) Representing devices without a current OF specification
 ----------------------------------------------------------
 
 Currently, there are many devices on SOCs that do not have a standard
@@ -1728,10 +1693,118 @@ platforms are moved over to use the flat
  		partitions = <00000000 00f80000
  			      00f80000 00080001>;
  		partition-names = "fs\0firmware";
- 	};
-
+ 	}; 
    More devices will be defined as this spec matures.
 
+VII - Specifying interrupt information for devices 
+===================================================
+
+The the device tree represents the busses and
+devices of a hardware system in a form similar to the
+physical bus topology of the hardware.
+
+In addition, a logical 'interrupt tree' exists which 
+represents the interrupt routing and topology of the
+hardware.  Devices that generate interrupts have
+a property with a value which is a phandle to the
+parent node in the interrupt tree.  Links between nodes
+in the interrupt tree are from child nodes 'upwards' to 
+their parents and towards the root of the interrupt tree.
+
+The interrupt tree model is fully described in the the
+document "Open Firmware Recommended Practice: Interrupt
+Mapping Version 0.9".  The document is available at:
+http://playground.sun.com/1275/practice.
+
+1) interrupt and interrupt-parent 
+---------------------------------
+
+Devices that generate interrupts to a single interrupt controller
+should use the conventional OF representation described in the
+OF interrupt mapping documentation.  Each device which generates
+interrupts should have the following properties:
+
+	- interrupt-parent : contains the phandle of the interrupt
+          controller which handles interrupts for this device
+          (Note: if interrupt-parent is not specified the interrupt
+           parent is assumed to be the device tree parent)
+	- interrupts : a list of tuples representing the interrupt
+          number and the interrupt sense and level for each interrupt
+          for this device.
+
+This information is used by the kernel to build the interrupt table
+for the interrupt controllers in the system.
+
+Sense and level information should be encoded as follows:
+
+   Devices connected to openPIC-compatible controllers should encode
+   sense and polarity as follows:
+
+	0 = low to high edge sensitive type enabled
+	1 = active low level sensitive type enabled
+	2 = active high level sensitive type enabled
+	3 = high to low edge sensitive type enabled
+
+   ISA PIC interrupt controllers should adhere to the ISA PIC
+   encodings listed below:
+
+	0 =  active low level sensitive type enabled
+	1 =  active high level sensitive type enabled
+	2 =  high to low edge sensitive type enabled
+	3 =  low to high edge sensitive type enabled
+
+2) interrupt-array
+------------------
+
+For devices that generate interrupts to multiple interrupt
+controllers, the interrupts and interrupt-parent representation
+is not sufficient. The interrupt-array property should be used
+to represent this.
+
+The interrupt-array property consists of an arbitrary number
+of 2-tuples consisting of a interrupt parent phandle and
+an interrupt specifier.
+
+  interrupt-array = <parent-phandle0 interrupt-specifier0 ... parent-phandleN interrupt-specifierN>
+
+See the example below:
+
+   pic0: pic@700 {
+       interrupt-controller;
+       #address-cells = <0>;
+       #interrupt-cells = <2>;
+       reg = <700 100>;
+       device_type = "open-pic";
+   };
+
+   pic1: pic@800 {
+       interrupt-controller;
+       #address-cells = <0>;
+       #interrupt-cells = <2>;
+       reg = <800 100>;
+       device_type = "open-pic";
+   };
+
+   ethernet@25000 {
+       #address-cells = <1>;
+       #size-cells = <0>;
+       device_type = "network";
+       model = "TSEC";
+       compatible = "gianfar";
+       reg = <25000 1000>;
+       mac-address = [ 00 E0 0C 00 73 01 ];
+       interrupt-array = <&pic0 13 3 &pic0 14 3 &pic1 18 3>;
+       phy-handle = <2452001>;
+   };
+
+In the example, the interrupt-array defines three
+interrupts-- interrupt 0x13 and 0x14 go to the pic0 interrupt
+controller and interrupt 18 goes to pic1.
+
+Note: the number of cells needed to represent the
+interrupt-specifier is determined by the #interrupt-cells
+property of the interrupt parent.
+
 
 Appendix A - Sample SOC node for MPC8540
 ========================================
-- 
1.4.4
