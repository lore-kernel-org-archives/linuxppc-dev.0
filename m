Return-Path: <gerickson@nuovations.com>
Received: from relay02.pair.com (relay02.pair.com [209.68.5.16])
	by ozlabs.org (Postfix) with SMTP id C5838DDF0A
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 09:12:27 +1100 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4] powerpc/4xx: DTS: Add Add'l SDRAM0 Compatible and
	Interrupt Info
Date: Thu, 18 Dec 2008 14:12:24 -0800
Message-Id: <1229638344-650-1-git-send-email-gerickson@nuovations.com>
Cc: bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added additional information for type and compatibility strings and
interrupt information to the SDRAM0 memory-controller device tree
nodes for AMCC PowerPC 405EX[r]-based boards to facilitate binding
with the new "ibm,sdram-4xx-ddr2" EDAC memory controller adapter driver.

Signed-off-by: Grant Erickson <gerickson@nuovations.com>
---
As support in the associated EDAC adapter driver is added over time,
similar changes will/should be made to the DTS files for boards
leveraging realizations of this "ibm,sdram-4xx-ddr2" controller,
including the 440SP, 440SPe, 460EX, 460GT and 460SX.

Patch v2, based on review from David Gibson, removes the 'device_type'
field because it is only used for legacy OpenFirmware method
interfaces and no such compatibility is warranted here. In addition,
removed address- and size-cells as this node has no children.

Patch v3, based on review from Josh Boyer and Stefan Roese, simplifies
the interrupt specification because both the SEC and DED interrupts
are mapped to the same interrupt parent.

Patch v4 corrects a typo: 'interrupt-map' should be 'interrupts'.

 arch/powerpc/boot/dts/haleakala.dts |    5 ++++-
 arch/powerpc/boot/dts/kilauea.dts   |    5 ++++-
 arch/powerpc/boot/dts/makalu.dts    |    5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/haleakala.dts b/arch/powerpc/boot/dts/haleakala.dts
index 513bc43..9384da6 100644
--- a/arch/powerpc/boot/dts/haleakala.dts
+++ b/arch/powerpc/boot/dts/haleakala.dts
@@ -89,8 +89,11 @@
 		clock-frequency = <0>; /* Filled in by U-Boot */
 
 		SDRAM0: memory-controller {
-			compatible = "ibm,sdram-405exr";
+			compatible = "ibm,sdram-405ex", "ibm,sdram-4xx-ddr2";
 			dcr-reg = <0x010 0x002>;
+			interrupt-parent = <&UIC2>;
+			interrupts = <0x5 0x4	/* ECC DED Error */ 
+				      0x6 0x4>;	/* ECC SEC Error */ 
 		};
 
 		MAL0: mcmal {
diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index dececc4..2804444 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -90,8 +90,11 @@
 		clock-frequency = <0>; /* Filled in by U-Boot */
 
 		SDRAM0: memory-controller {
-			compatible = "ibm,sdram-405ex";
+			compatible = "ibm,sdram-405ex", "ibm,sdram-4xx-ddr2";
 			dcr-reg = <0x010 0x002>;
+			interrupt-parent = <&UIC2>;
+			interrupts = <0x5 0x4	/* ECC DED Error */ 
+				      0x6 0x4>;	/* ECC SEC Error */ 
 		};
 
 		MAL0: mcmal {
diff --git a/arch/powerpc/boot/dts/makalu.dts b/arch/powerpc/boot/dts/makalu.dts
index 945508c..b2e0bf6 100644
--- a/arch/powerpc/boot/dts/makalu.dts
+++ b/arch/powerpc/boot/dts/makalu.dts
@@ -90,9 +90,11 @@
 		clock-frequency = <0>; /* Filled in by U-Boot */
 
 		SDRAM0: memory-controller {
-			compatible = "ibm,sdram-405ex";
+			compatible = "ibm,sdram-405ex", "ibm,sdram-4xx-ddr2";
 			dcr-reg = <0x010 0x002>;
+			interrupt-parent = <&UIC2>;
+			interrupts = <0x5 0x4	/* ECC DED Error */ 
+				      0x6 0x4>;	/* ECC SEC Error */ 
 		};
 
 		MAL0: mcmal {
--
1.6.0.5
