Return-Path: <meador_inge@mentor.com>
Message-ID: <4D34E448.8000902@mentor.com>
Date: Mon, 17 Jan 2011 18:52:24 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: document the MPIC device tree binding
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: minge <meador_inge@mentor.com>, devicetree-discuss@lists.ozlabs.org,
	"Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This binding documents several properties that have been in use for 
quite some time, and adds one new property 'no-reset', which controls 
whether the MPIC should be reset during runtime initialization.

Signed-off-by: Meador Inge <meador_inge@mentor.com>
CC: Hollis Blanchard <hollis_blanchard@mentor.com>
---
  Documentation/powerpc/dts-bindings/mpic.txt |   78 
+++++++++++++++++++++++++++
  1 files changed, 78 insertions(+), 0 deletions(-)
  create mode 100644 Documentation/powerpc/dts-bindings/mpic.txt

diff --git a/Documentation/powerpc/dts-bindings/mpic.txt 
b/Documentation/powerpc/dts-bindings/mpic.txt
new file mode 100644
index 0000000..3a67919
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/mpic.txt
@@ -0,0 +1,78 @@
+* MPIC Binding
+
+This binding specifies what properties and child nodes must be available on
+the device tree representation of the "MPIC" interrupt controller.  This
+binding is based on the binding defined for Open PIC in [1] and is a 
superset
+of that binding.
+
+** Required properties:
+
+   NOTE: Many of these descriptions were paraphrased from [1] to aid
+         readability.
+
+   - name : Specifies the name of the MPIC.
+   - device_type : Specifies the device type of this MPIC.  The value 
of this
+                   property shall be "open-pic".
+   - reg : Specifies the base physical address(s) and size(s) of this 
MPIC's
+           addressable register space.
+   - compatible : Specifies the compatibility list for the MPIC.  The 
property
+                  value shall include "chrp,open-pic".
+   - interrupt-controller : The presence of this property identifies 
the node
+                            as a MPIC.  No property value should be 
defined.
+   - #address-cells : Specifies the number of cells needed to encode an
+                      address.  The value of this property shall always 
be 0
+                      so that 'interrupt-map' nodes do not have to 
specify a
+                      parent unit address.
+   - #interrupt-cells : Specifies the number of cells needed to encode an
+                        interrupt source.
+
+** Optional properties:
+
+   - no-reset : The presence of this property indicates that the MPIC
+                should not be reset during runtime initialization.
+   - protected-sources : Specifies a list of interrupt sources that are 
not
+                         available for use and whose corresponding vectors
+                         should not be initialized.  A typical use case for
+                         this property is in AMP systems where multiple
+                         independent operating systems need to share 
the MPIC
+                         without clobbering each other.
+
+** Example:
+
+	mpic: pic@40000 {
+        // This is an interrupt controller node.
+		interrupt-controller;
+
+        // No address cells so that 'interrupt-map' nodes which reference
+        // this MPIC node do not need a parent address specifier.
+		#address-cells = <0>;
+
+        // Two cell to encode interrupt sources.
+		#interrupt-cells = <2>;
+
+        // Offset address of 0x40000 and size of 0x40000.
+		reg = <0x40000 0x40000>;
+
+        // Compatible with Open PIC.
+		compatible = "chrp,open-pic";
+
+        // An Open PIC device.
+		device_type = "open-pic";
+
+        // The sources 0xb1 and 0xb2 are off limits for use and should 
not be
+        // initialized by the OS.
+		protected-sources = <0xb1 0xb2>;
+
+        // The MPIC should not be reset.
+		no-reset;
+	};
+
+* References
+
+[1] PowerPC Microprocessor Common Hardware Reference Platform (CHRP) 
Binding,
+    Version 1.8, 1998. Published by the Open Firmware Working Group.
+    (http://playground.sun.com/1275/bindings/chrp/chrp1_8a.ps)
+[2] Open Firmware Recommended Practice: Interrupt Mapping, Version 0.9. 
1996.
+    Published by the Open Firmware Working Group.
+    (http://playground.sun.com/1275/practice/imap/imap0_9d.pdf)
+
-- 1.6.3.3
