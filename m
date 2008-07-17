Return-Path: <wg@grandegger.com>
Message-ID: <487F6F1F.9070600@grandegger.com>
Date: Thu, 17 Jul 2008 18:11:11 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: FSL UPM NAND bindings, add read-fetch-delay property
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the binding for the property "read-fetch-delay" to the
sub-nodes of the "fsl,upm-nand" compatible nodes. It will be used by a
patch extending the support of the FSL UPM NAND driver for the TQM8548
modules, which do not have the R/B pin of the NAND chip connected.
Furthermore it documents the missing FLASH partition bindings.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---

As soon as this new binding is accepted, I going to send the patch for
the FSL UPM NAND driver to the MTD mailing list. An old version can be
found here:

  http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057632.html

TIA.

Wolfgang.


 Documentation/powerpc/dts-bindings/fsl/upm-nand.txt |   39 +++++++++++++++++---
 1 file changed, 35 insertions(+), 4 deletions(-)

Index: linux-2.6-galak/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt
===================================================================
--- linux-2.6-galak.orig/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt
+++ linux-2.6-galak/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt
@@ -1,11 +1,34 @@
 Freescale Localbus UPM programmed to work with NAND flash
 
-Required properties:
+Properties:
 - compatible : "fsl,upm-nand".
 - reg : should specify localbus chip select and size used for the chip.
 - fsl,upm-addr-offset : UPM pattern offset for the address latch.
 - fsl,upm-cmd-offset : UPM pattern offset for the command latch.
-- gpios : may specify optional GPIO connected to the Ready-Not-Busy pin.
+- gpios : (optional) may specify GPIO connected to the Ready-Not-Busy 
+  pin.
+
+Each NAND flash is represented as a sub-node of the UPM node. The
+nodes's name represents the name of the corresponding device.
+
+NAND flash properties:
+- compatible : (optional) not yet used.
+- read-fetch-delay : (optional) chip dependent delay for transferring
+  data from array to read regs (tR).
+
+Each partition is represented as a sub-node of the NAND flash device.
+Each node's name represents the name of the corresponding partition
+of the flash device.
+
+NAND flash partition properties:
+- reg : The partition's offset and size within the flash bank.
+- label : (optional) The label / name for this flash partition. If
+  omitted, the label is taken from the node name (excluding the unit
+  address).
+- read-only : (optional) This parameter, if present, is a hint to
+  Linux that this flash partition should only be mounted read-only.
+  This is usually used for flash partitions containing early-boot
+  firmware images or data which should not be clobbered.
 
 Example:
 
@@ -20,9 +43,17 @@ upm@1,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "...";
+		read-fetch-delay = 25
+
+		fs@0 {
+			label = "fs";
+			reg = <0x0 0xf80000>;
+		};
 
-		partition@0 {
-			...
+		firmware@f80000 {
+			label ="firmware";
+			reg = <0xf80000 0x80000>;
+			read-only;
 		};
 	};
 };
