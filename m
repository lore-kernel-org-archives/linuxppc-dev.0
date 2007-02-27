Return-Path: <b08248@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 29D53DDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 09:54:56 +1100 (EST)
Date: Tue, 27 Feb 2007 16:54:45 -0600
From: Stuart Yoder <b08248@freescale.com>
Message-Id: <200702272254.l1RMsjt2030709@ld0164-tx32.am.freescale.net>
To: paulus@samba.org
Subject: [RFC] powerpc: Document new property called interrupt-parents 
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Document new property called interrupt-parents which can
be used to represent interrupts for devices that route
interrupts to more than one interrupt controller.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---

 This is based on the discussions on the list last week and
 this week.  I realize there are still differences of opinion
 on interrupts-array vs interrupt-parents but I think the
 differences between the two options are not that significant.

 Note: this patch depends on the patch updating the interrupt info
 in booting-without-of.txt

 Documentation/powerpc/booting-without-of.txt |   65 +++++++++++++++++++++++++-
 1 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 0238a64..89e1c4a 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1759,7 +1759,68 @@ phandle to the parent node.
 If the interrupt-parent property is not defined for a node, it's
 interrupt parent is assumed to be it's device tree_ parent.
 
-3) OpenPIC Interrupt Controllers
+3) interrupt-parents property
+-----------------------------
+
+For devices that generate interrupts to multiple interrupt
+controllers, the  interrupt-parent representation
+is not sufficient because it only describes a single
+interrupt parent. The 'interrupt-parents' property should be used
+to represent this (note the plural in the property name).
+
+The interrupt-parents property consists of one or more 
+interrupt parent phandle values each representing the interrupt
+parent for the corresponding interrupt specifier in the interrupts
+property:
+
+  interrupt-parents = <parent-phandle0 parent-phandle1 ... parent-phandleN>
+  interrupts = <int-specifier0 int-specifier1 ... int-specifierN>
+
+It is required that the number of interrupts encoded in the interrupt-parents
+property exacly match the number of interrupt specifiers in the interrupts
+property.
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
+       model = "fsl,TSEC";
+       compatible = "gianfar";
+       reg = <25000 1000>;
+       mac-address = [ 00 E0 0C 00 73 01 ];
+       interrupt-parents = <&pic0 &pic0 &pic1>;
+       interrupts = <13 3 14 3 18 3>;
+       phy-handle = <2452001>;
+   };
+
+In the example, the interrupts property and the interrupt-parents
+property defines three interrupts-- interrupt 0x13 and 0x14 go to
+the pic0 interrupt controller and interrupt 0x18 goes to pic1.
+
+Note: each interrupt parent in the interrupt-parents array can
+potentially specify a different value for #interrupt-cells.  The number
+of #interrupt-cells for each parent must be determined to correctly
+parser the interrupts property.
+
+4) OpenPIC Interrupt Controllers
 --------------------------------
 
 OpenPIC interrupt controllers required 2 cells to encode
@@ -1774,7 +1835,7 @@ Sense and level information should be en
 	2 = active high level sensitive type enabled
 	3 = high to low edge sensitive type enabled
 
-4) ISA Interrupt Controllers
+5) ISA Interrupt Controllers
 ----------------------------
 
 ISA PIC interrupt controllers required 2 cells to encode
-- 
1.4.4
