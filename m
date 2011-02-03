Return-Path: <meador_inge@mentor.com>
From: Meador Inge <meador_inge@mentor.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/3] powerpc: document the Open PIC device tree binding
Date: Wed,  2 Feb 2011 19:51:39 -0600
Message-Id: <1296697900-14004-3-git-send-email-meador_inge@mentor.com>
In-Reply-To: <1296697900-14004-1-git-send-email-meador_inge@mentor.com>
References: <1296697900-14004-1-git-send-email-meador_inge@mentor.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This binding documents several properties that have been in use for quite
some time, and adds one new property 'no-reset', which controls whether the
Open PIC should be reset during runtime initialization.

The general formatting and interrupt specifier definition is based off of
Stuart Yoder's FSL MPIC binding.

Signed-off-by: Meador Inge <meador_inge@mentor.com>
CC: Hollis Blanchard <hollis_blanchard@mentor.com>
CC: Stuart Yoder <stuart.yoder@freescale.com>
---
 Documentation/powerpc/dts-bindings/open-pic.txt |  115 +++++++++++++++++++++++
 1 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/open-pic.txt

diff --git a/Documentation/powerpc/dts-bindings/open-pic.txt b/Documentation/powerpc/dts-bindings/open-pic.txt
new file mode 100644
index 0000000..447ef65
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/open-pic.txt
@@ -0,0 +1,115 @@
+* Open PIC Binding
+
+This binding specifies what properties must be available in the device tree
+representation of an Open PIC compliant interrupt controller.  This binding is
+based on the binding defined for Open PIC in [1] and is a superset of that
+binding.
+
+PROPERTIES
+
+  NOTE: Many of these descriptions were paraphrased here from [1] to aid
+        readability.
+
+  - compatible
+      Usage: required
+      Value type: <string>
+      Definition: Specifies the compatibility list for the PIC.  The
+          property value shall include "open-pic".
+
+  - reg
+      Usage: required
+      Value type: <prop-encoded-array>
+      Definition: Specifies the base physical address(s) and size(s) of this
+          PIC's addressable register space.
+
+  - interrupt-controller
+      Usage: required
+      Value type: <empty>
+      Definition: The presence of this property identifies the node
+          as an Open PIC.  No property value should be defined.
+
+  - #interrupt-cells
+      Usage: required
+      Value type: <u32>
+      Definition: Specifies the number of cells needed to encode an
+          interrupt source.  Shall be 2.
+
+  - #address-cells
+      Usage: required
+      Value type: <u32>
+      Definition: Specifies the number of cells needed to encode an
+          address.  The value of this property shall always be 0.
+          As such, 'interrupt-map' nodes do not have to specify a
+          parent unit address.
+
+  - no-reset
+      Usage: optional
+      Value type: <empty>
+      Definition: The presence of this property indicates that the PIC
+          should not be reset during runtime initialization.  The presence of
+          this property also mandates that any initialization related to
+          interrupt sources shall be limited to sources explicitly referenced
+          in the device tree.
+
+INTERRUPT SPECIFIER DEFINITION
+
+  Interrupt specifiers consists of 2 cells encoded as
+  follows:
+
+   <1st-cell>   interrupt-number
+
+                Identifies the interrupt source.
+
+   <2nd-cell>   level-sense information, encoded as follows:
+                    0 = low-to-high edge triggered
+                    1 = active low level-sensitive
+                    2 = active high level-sensitive
+                    3 = high-to-low edge triggered
+
+EXAMPLE 1
+
+    /*
+     * An Open PIC interrupt controller
+     */
+	mpic: pic@40000 {
+        // This is an interrupt controller node.
+		interrupt-controller;
+
+        // No address cells so that 'interrupt-map' nodes which reference
+        // this Open PIC node do not need a parent address specifier.
+		#address-cells = <0>;
+
+        // Two cells to encode interrupt sources.
+		#interrupt-cells = <2>;
+
+        // Offset address of 0x40000 and size of 0x40000.
+		reg = <0x40000 0x40000>;
+
+        // Compatible with Open PIC.
+		compatible = "open-pic";
+
+        // The PIC should not be reset.
+		no-reset;
+	};
+
+EXAMPLE 2
+
+    /*
+     * An interrupt generating device that is wired to an Open PIC.
+     */
+    serial0: serial@4500 {
+        // Interrupt source '42' that is active high level-sensitive.
+        // Note that there are only two cells as specified in the interrupt
+        // parent's '#interrupt-cells' property.
+        interrupts = <42 2>;
+
+        // The interrupt controller that this device is wired to.
+        interrupt-parent = <&mpic>;
+    };
+
+REFERENCES
+
+[1] Power.org (TM) Standard for Embedded Power Architecture (TM) Platform
+    Requirements (ePAPR), Version 1.0, July 2008.
+    (http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf)
+
-- 
1.6.3.3
