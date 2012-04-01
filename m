Return-Path: <B38951@freescale.com>
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [RFC] powerpc/fsl-pci: Document the "fsl,
 has-isa" property for Freescale PCI
Date: Sun, 1 Apr 2012 14:56:36 +0800
Message-ID: <1333263396-23932-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree-discuss@lists.ozlabs.org, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If PCI is primary bus we should set isa_io/mem_base when parsing PCI bridge
resources from device tree. The previous way to check the primary bus based
on a hard-coded address named primary_phb_addr. Now we add a property named
"fsl,has-isa" into device tree. In kernel we use this property to find out
the bus is primary or not. This way is more flexible.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/pci.txt        |   36 ++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/pci.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pci.txt b/Documentation/devicetree/bindings/powerpc/fsl/pci.txt
new file mode 100644
index 0000000..7b18090
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/pci.txt
@@ -0,0 +1,36 @@
+* Freescale PCI
+
+Freescale PCI specific property:
+- fsl,has-isa : If PCI is primary bus we should set isa_io/mem_base when
+                parsing PCI bridge resources. This property is an indicator
+                to inform kernel the PCI is primary.
+
+Example (MPC8572DS)
+	&pci0 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		bus-range = <0 255>;
+		clock-frequency = <33333333>;
+		interrupts = <24 2 0 0>;
+		fsl,has-isa;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+			device_type = "pci";
+			interrupts = <24 2 0 0>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0x0 0x0 0x1 &mpic 0x8 0x1 0x0 0x0
+				0000 0x0 0x0 0x2 &mpic 0x9 0x1 0x0 0x0
+				0000 0x0 0x0 0x3 &mpic 0xa 0x1 0x0 0x0
+				0000 0x0 0x0 0x4 &mpic 0xb 0x1 0x0 0x0
+				>;
+		};
+	};
-- 
1.7.5.1
