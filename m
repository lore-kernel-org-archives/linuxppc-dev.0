Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Dec 2007 19:00:19 +1100
Subject: [PATCH 20/25] powerpc: Wire up 440EP USB controlle support to Bamboo
	board
In-Reply-To: <1196927999.714593.205329520306.qpush@grosgo>
Message-Id: <20071206080130.CCFD7DE0DA@ozlabs.org>
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

Index: linux-work/arch/powerpc/boot/dts/bamboo.dts
===================================================================
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
