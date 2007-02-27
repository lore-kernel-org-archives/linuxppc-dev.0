Return-Path: <b08248@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 0B8F5DDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 09:23:26 +1100 (EST)
Date: Tue, 27 Feb 2007 16:23:20 -0600
From: Stuart Yoder <b08248@freescale.com>
Message-Id: <200702272223.l1RMNKcF030373@ld0164-tx32.am.freescale.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: update interrupt info in booting-without-of.txt
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Create a new section describing how interrupts are represented
in the device tree.  Added more detail clarified some things.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |  134 ++++++++++++++++++-------
 1 files changed, 96 insertions(+), 38 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index eaa0c32..0238a64 100644
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
@@ -1728,10 +1693,103 @@ platforms are moved over to use the flat
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
+The device tree represents the busses and
+devices of a hardware system in a form similar to the
+physical bus topology of the hardware.
+
+In addition, a logical 'interrupt tree' exists which 
+represents the hierarchy and routing of interrupts
+in the hardware.
+
+Devices that generate interrupts have an 'interrupt parent' in
+the interrupt tree.  An interrupt parent can be explicitly
+defined through the interrupt-parent property. For nodes with
+no interrupt-parent, the interrupt parent is assumed to be
+the node's  _device tree_ parent.
+
+Links between nodes in the interrupt tree are from child nodes
+upwards to their parents and towards the root of the interrupt
+tree.
+
+The interrupt tree model is fully described in the
+document "Open Firmware Recommended Practice: Interrupt
+Mapping Version 0.9".  The document is available at:
+<http://playground.sun.com/1275/practice>.
+
+1) interrupt property
+---------------------
+
+Devices that generate interrupts to a single interrupt controller
+should use the conventional OF representation described in the
+OF interrupt mapping documentation.
+
+Each device which generates interrupts must have an 'interrupt'
+property.  The interrupt property value is an arbitrary number of
+of 'interrupt specifier' values which describe the interrupt or
+interrupts for the device.
+
+The encoding of an interrupt specifier is determined by the
+domain (or nexus) in the interrupt tree.  The interrupt parent
+of an interrupt domain specifies in its #interrupt-cells property
+the number of 32-bit cells required to encode an interrupt specifier.
+
+For example, the binding for the OpenPIC interrupt controller 
+specifies  an #interrupt-cells value of 2 to encode the interrupt
+number and level/sense information. All interrupt children in an
+OpenPIC interrupt domain use 2 cells per interrupt in their interrupts
+property.
+
+The PCI bus binding specifies a #interrupt-cell value of 1 to encode
+which interrupt line (INTA,INTB,INTC,INTD) is used.
+
+2) interrupt-parent property
+----------------------------
+
+The interrupt-parent property is specified to define an explicit
+link between a device node and its interrupt parent in
+the interrupt tree.  The value of interrupt-parent is the
+phandle to the parent node.
+
+If the interrupt-parent property is not defined for a node, it's
+interrupt parent is assumed to be it's device tree_ parent.
+
+3) OpenPIC Interrupt Controllers
+--------------------------------
+
+OpenPIC interrupt controllers required 2 cells to encode
+interrupt information.  The first cell defines the interrupt
+number.  The second cell defines the sense and level 
+information.
+
+Sense and level information should be encoded as follows:
+
+	0 = low to high edge sensitive type enabled
+	1 = active low level sensitive type enabled
+	2 = active high level sensitive type enabled
+	3 = high to low edge sensitive type enabled
+
+4) ISA Interrupt Controllers
+----------------------------
+
+ISA PIC interrupt controllers required 2 cells to encode
+interrupt information.  The first cell defines the interrupt
+number.  The second cell defines the sense and level 
+information.
+
+ISA PIC interrupt controllers should adhere to the ISA PIC
+encodings listed below:
+
+	0 =  active low level sensitive type enabled
+	1 =  active high level sensitive type enabled
+	2 =  high to low edge sensitive type enabled
+	3 =  low to high edge sensitive type enabled
+
 
 Appendix A - Sample SOC node for MPC8540
 ========================================
-- 
1.4.4
