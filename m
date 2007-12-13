Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 13 Dec 2007 18:38:40 +1100
Subject: [PATCH 12/20] [POWERPC] Wire up 440EP USB controlle support to Bamboo
	board
Message-Id: <20071213073845.BD2BFDDFD7@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the definition of the on-chip OHCI controller to the
Bamboo board's device-tree. This is enough to get it probed and
working, though a separate patch fixing a bug in the OHCI driver
is needed to make it reliable.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/boot/dts/bamboo.dts |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-work.orig/arch/powerpc/boot/dts/bamboo.dts	2007-11-26 10:11:09.000000000 +1100
+++ linux-work/arch/powerpc/boot/dts/bamboo.dts	2007-11-27 14:37:50.000000000 +1100
@@ -238,6 +238,13 @@
 				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
 			};
+
+			usb@ef601000 {
+				compatible = "ohci-be";
+				reg = <ef601000 80>;
+				interrupts = <8 1 9 1>;
+				interrupt-parent = < &UIC1 >;
+			};
 		};
 
 		PCI0: pci@ec000000 {
