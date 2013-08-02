Return-Path: <B43644@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0704A2C0087
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Aug 2013 17:31:52 +1000 (EST)
From: Po Liu <Po.Liu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v4 1/3] powerpc/85xx: Add SEC6.0 device tree
Date: Fri, 2 Aug 2013 14:39:09 +0800
Message-ID: <1375425551-821-1-git-send-email-Po.Liu@freescale.com>
In-Reply-To: <1375174163-19246-3-git-send-email-Po.Liu@freescale.com>
References: <1375174163-19246-3-git-send-email-Po.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Mingkai Hu <Mingkai.Hu@freescale.com>,
 afleming@freescale.com, Po Liu <Po.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mingkai Hu <Mingkai.Hu@freescale.com>

Add device tree for SEC 6.0 used on C29x silicon.

Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
Signed-off-by: Po Liu <Po.Liu@freescale.com>
---
Changes for v2:
	- Remove the compatible sec v4.0/v4.4/v5.0;
	- Add the device tree binding file fsl-sec6.txt;
Changes for v3:
	- Change some comments in fsl-sec6.txt
Changes for v4:
	- Change the full example in fsl-sec6.txt

 .../devicetree/bindings/crypto/fsl-sec6.txt        | 157 +++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-sec6.0-0.dtsi      |  56 ++++++++
 2 files changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec6.txt
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec6.0-0.dtsi

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec6.txt b/Documentation/devicetree/bindings/crypto/fsl-sec6.txt
new file mode 100644
index 0000000..c0a20cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec6.txt
@@ -0,0 +1,157 @@
+SEC 6 is as Freescale's Cryptographic Accelerator and Assurance Module (CAAM).
+Currently Freescale powerpc chip C29X is embeded with SEC 6.
+SEC 6 device tree binding include:
+   -SEC 6 Node
+   -Job Ring Node
+   -Full Example
+
+=====================================================================
+SEC 6 Node
+
+Description
+
+    Node defines the base address of the SEC 6 block.
+    This block specifies the address range of all global
+    configuration registers for the SEC 6 block.
+    For example, In C293, we could see three SEC 6 node.
+
+PROPERTIES
+
+   - compatible
+      Usage: required
+      Value type: <string>
+      Definition: Must include "fsl,sec-v6.0".
+
+   - fsl,sec-era
+      Usage: optional
+      Value type: <u32>
+      Definition: A standard property. Define the 'ERA' of the SEC
+          device.
+
+   - #address-cells
+       Usage: required
+       Value type: <u32>
+       Definition: A standard property.  Defines the number of cells
+           for representing physical addresses in child nodes.
+
+   - #size-cells
+       Usage: required
+       Value type: <u32>
+       Definition: A standard property.  Defines the number of cells
+           for representing the size of physical addresses in
+           child nodes.
+
+   - reg
+      Usage: required
+      Value type: <prop-encoded-array>
+      Definition: A standard property.  Specifies the physical
+          address and length of the SEC 6 configuration registers.
+
+   - ranges
+       Usage: required
+       Value type: <prop-encoded-array>
+       Definition: A standard property.  Specifies the physical address
+           range of the SEC 6.0 register space (-SNVS not included).  A
+           triplet that includes the child address, parent address, &
+           length.
+
+   Note: All other standard properties (see the ePAPR) are allowed
+   but are optional.
+
+EXAMPLE
+	crypto@a0000 {
+		compatible = "fsl,sec-v6.0";
+		fsl,sec-era = <6>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xa0000 0x20000>;
+		ranges = <0 0xa0000 0x20000>;
+	};
+
+=====================================================================
+Job Ring (JR) Node
+
+    Child of the crypto node defines data processing interface to SEC 6
+    across the peripheral bus for purposes of processing
+    cryptographic descriptors. The specified address
+    range can be made visible to one (or more) cores.
+    The interrupt defined for this node is controlled within
+    the address range of this node.
+
+  - compatible
+      Usage: required
+      Value type: <string>
+      Definition: Must include "fsl,sec-v6.0-job-ring".
+
+  - reg
+      Usage: required
+      Value type: <prop-encoded-array>
+      Definition: Specifies a two JR parameters:  an offset from
+           the parent physical address and the length the JR registers.
+
+   - interrupts
+      Usage: required
+      Value type: <prop_encoded-array>
+      Definition:  Specifies the interrupts generated by this
+           device.  The value of the interrupts property
+           consists of one interrupt specifier. The format
+           of the specifier is defined by the binding document
+           describing the node's interrupt parent.
+
+EXAMPLE
+	jr@1000 {
+		compatible = "fsl,sec-v6.0-job-ring";
+		reg = <0x1000 0x1000>;
+		interrupts = <49 2 0 0>;
+	};
+
+===================================================================
+Full Example
+
+Since some chips may contain more than one SEC, the dtsi contains
+only the node contents, not the node itself.  A chip using the SEC
+should include the dtsi inside each SEC node.  Example:
+
+In qoriq-sec6.0.dtsi:
+
+	compatible = "fsl,sec-v6.0";
+	fsl,sec-era = <6>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	jr@1000 {
+		compatible = "fsl,sec-v6.0-job-ring",
+			     "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.4-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg	   = <0x1000 0x1000>;
+	};
+
+	jr@2000 {
+		compatible = "fsl,sec-v6.0-job-ring",
+			     "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.4-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg	   = <0x2000 0x1000>;
+	};
+
+In the C293 device tree, we add the include of public property:
+
+	crypto@a0000 {
+		/include/ "qoriq-sec6.0.dtsi"
+	}
+
+	crypto@a0000 {
+		reg = <0xa0000 0x20000>;
+		ranges = <0 0xa0000 0x20000>;
+
+		jr@1000 {
+			interrupts = <49 2 0 0>;
+		};
+
+		jr@2000 {
+			interrupts = <50 2 0 0>;
+		};
+	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec6.0-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec6.0-0.dtsi
new file mode 100644
index 0000000..f75b4f820
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec6.0-0.dtsi
@@ -0,0 +1,56 @@
+/*
+ * QorIQ Sec/Crypto 6.0 device tree stub
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+	compatible = "fsl,sec-v6.0";
+	fsl,sec-era = <6>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	jr@1000 {
+		compatible = "fsl,sec-v6.0-job-ring",
+			     "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.4-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg	   = <0x1000 0x1000>;
+	};
+
+	jr@2000 {
+		compatible = "fsl,sec-v6.0-job-ring",
+			     "fsl,sec-v5.2-job-ring",
+			     "fsl,sec-v5.0-job-ring",
+			     "fsl,sec-v4.4-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg	   = <0x2000 0x1000>;
+	};
-- 
1.8.0
