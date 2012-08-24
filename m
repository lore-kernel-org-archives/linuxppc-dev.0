Return-Path: <agust@denx.de>
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] dt/misc: add bindings documentation for ifm camera sensor
 interface
Date: Fri, 24 Aug 2012 17:39:39 +0200
Message-Id: <1345822779-32020-2-git-send-email-agust@denx.de>
In-Reply-To: <1345822779-32020-1-git-send-email-agust@denx.de>
References: <1345822779-32020-1-git-send-email-agust@denx.de>
Cc: devicetree-discuss@lists.ozlabs.org, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IFM O2D cameras use special sensor bus interface glue-logic to
connect camera sensors to mpc5200 LocalPlus bus. Add device tree
bindings documentation for it.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 Documentation/devicetree/bindings/misc/ifm-csi.txt |   41 ++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/ifm-csi.txt

diff --git a/Documentation/devicetree/bindings/misc/ifm-csi.txt b/Documentation/devicetree/bindings/misc/ifm-csi.txt
new file mode 100644
index 0000000..5bdfffb
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/ifm-csi.txt
@@ -0,0 +1,41 @@
+IFM camera sensor interface on mpc5200 LocalPlus bus
+
+Required properties:
+- compatible: "ifm,o2d-csi"
+- reg: specifies sensor chip select number and associated address range
+- interrupts: external interrupt line number and interrupt sense mode
+  of the interrupt line signaling frame valid events
+- gpios: three gpio-specifiers for "capture", "reset" and "master enable"
+  GPIOs (strictly in this order).
+- ifm,csi-clk-handle: the phandle to a node in the DT describing the sensor
+  clock generator. This node is usually a general purpose timer controller.
+- ifm,csi-addr-bus-width: address bus width (valid values are 16, 24, 25)
+- ifm,csi-data-bus-width: data bus width (valid values are 8 and 16)
+- ifm,csi-wait-cycles: sensor bus wait cycles
+
+Optional properties:
+- ifm,csi-byte-swap: if this property is present, the byte swapping on
+  the bus will be enabled.
+
+Example:
+
+	csi@3,0 {
+		compatible = "ifm,o2d-csi";
+		reg = <3 0 0x00100000>;		/* CS 3, 1 MiB range */
+		interrupts = <1 1 2>;		/* IRQ1, edge falling */
+
+		ifm,csi-clk-handle = <&timer7>;
+		gpios = <&gpio_simple 23 0	/* image_capture */
+			 &gpio_simple 26 0	/* image_reset */
+			 &gpio_simple 29 0>;	/* image_master_en */
+
+		ifm,csi-addr-bus-width = <24>;
+		ifm,csi-data-bus-width = <8>;
+		ifm,csi-wait-cycles = <0>;
+	};
+
+The base address of the used chip select is specified in the
+ranges property of the parent localbus node, for example:
+
+	ranges = <0 0 0xff000000 0x01000000
+		  3 0 0xe3000000 0x00100000>;
-- 
1.7.1
