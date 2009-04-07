Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH 2/4 v2] mtd/powerpc: Factor out MTD physmap bindings into
	mtd-physmap.txt
Date: Tue,  7 Apr 2009 10:39:28 +0200
Message-Id: <1239093568-12094-1-git-send-email-sr@denx.de>
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roese <sr@denx.de>
CC: Grant Likely <grant.likely@secretlab.ca>
---
 Documentation/powerpc/booting-without-of.txt       |   89 +++-----------------
 Documentation/powerpc/dts-bindings/mtd-physmap.txt |   63 ++++++++++++++
 2 files changed, 75 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/mtd-physmap.txt

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 0ab0230..d16b7a1 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -43,12 +43,11 @@ Table of Contents
     2) Representing devices without a current OF specification
       a) PHY nodes
       b) Interrupt controllers
-      c) CFI or JEDEC memory-mapped NOR flash
-      d) 4xx/Axon EMAC ethernet nodes
-      e) Xilinx IP cores
-      f) USB EHCI controllers
-      g) MDIO on GPIOs
-      h) SPI busses
+      c) 4xx/Axon EMAC ethernet nodes
+      d) Xilinx IP cores
+      e) USB EHCI controllers
+      f) MDIO on GPIOs
+      g) SPI busses
 
   VII - Marvell Discovery mv64[345]6x System Controller chips
     1) The /system-controller node
@@ -999,7 +998,7 @@ compatibility.
       translation of SOC addresses for memory mapped SOC registers.
     - bus-frequency: Contains the bus frequency for the SOC node.
       Typically, the value of this field is filled in by the boot
-      loader. 
+      loader.
 
 
   Recommended properties:
@@ -1287,71 +1286,7 @@ platforms are moved over to use the flattened-device-tree model.
 		device_type = "open-pic";
 	};
 
-   c) CFI or JEDEC memory-mapped NOR flash
-
-    Flash chips (Memory Technology Devices) are often used for solid state
-    file systems on embedded devices.
-
-     - compatible : should contain the specific model of flash chip(s)
-       used, if known, followed by either "cfi-flash" or "jedec-flash"
-     - reg : Address range of the flash chip
-     - bank-width : Width (in bytes) of the flash bank.  Equal to the
-       device width times the number of interleaved chips.
-     - device-width : (optional) Width of a single flash chip.  If
-       omitted, assumed to be equal to 'bank-width'.
-     - #address-cells, #size-cells : Must be present if the flash has
-       sub-nodes representing partitions (see below).  In this case
-       both #address-cells and #size-cells must be equal to 1.
-
-    For JEDEC compatible devices, the following additional properties
-    are defined:
-
-     - vendor-id : Contains the flash chip's vendor id (1 byte).
-     - device-id : Contains the flash chip's device id (1 byte).
-
-    In addition to the information on the flash bank itself, the
-    device tree may optionally contain additional information
-    describing partitions of the flash address space.  This can be
-    used on platforms which have strong conventions about which
-    portions of the flash are used for what purposes, but which don't
-    use an on-flash partition table such as RedBoot.
-
-    Each partition is represented as a sub-node of the flash device.
-    Each node's name represents the name of the corresponding
-    partition of the flash device.
-
-    Flash partitions
-     - reg : The partition's offset and size within the flash bank.
-     - label : (optional) The label / name for this flash partition.
-       If omitted, the label is taken from the node name (excluding
-       the unit address).
-     - read-only : (optional) This parameter, if present, is a hint to
-       Linux that this flash partition should only be mounted
-       read-only.  This is usually used for flash partitions
-       containing early-boot firmware images or data which should not
-       be clobbered.
-
-    Example:
-
-	flash@ff000000 {
-		compatible = "amd,am29lv128ml", "cfi-flash";
-		reg = <ff000000 01000000>;
-		bank-width = <4>;
-		device-width = <1>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		fs@0 {
-			label = "fs";
-			reg = <0 f80000>;
-		};
-		firmware@f80000 {
-			label ="firmware";
-			reg = <f80000 80000>;
-			read-only;
-		};
-	};
-
-    d) 4xx/Axon EMAC ethernet nodes
+    c) 4xx/Axon EMAC ethernet nodes
 
     The EMAC ethernet controller in IBM and AMCC 4xx chips, and also
     the Axon bridge.  To operate this needs to interact with a ths
@@ -1499,7 +1434,7 @@ platforms are moved over to use the flattened-device-tree model.
 			   available.
 			   For Axon: 0x0000012a
 
-   e) Xilinx IP cores
+   d) Xilinx IP cores
 
    The Xilinx EDK toolchain ships with a set of IP cores (devices) for use
    in Xilinx Spartan and Virtex FPGAs.  The devices cover the whole range
@@ -1761,7 +1696,7 @@ platforms are moved over to use the flattened-device-tree model.
       listed above, nodes for these devices should include a phy-handle
       property, and may include other common network device properties
       like local-mac-address.
-      
+
       iv) Xilinx Uartlite
 
       Xilinx uartlite devices are simple fixed speed serial ports.
@@ -1793,7 +1728,7 @@ platforms are moved over to use the flattened-device-tree model.
        - reg-offset : A value of 3 is required
        - reg-shift : A value of 2 is required
 
-    f) USB EHCI controllers
+    e) USB EHCI controllers
 
     Required properties:
       - compatible : should be "usb-ehci".
@@ -1819,7 +1754,7 @@ platforms are moved over to use the flattened-device-tree model.
 		   big-endian;
 	   };
 
-   g) MDIO on GPIOs
+   f) MDIO on GPIOs
 
    Currently defined compatibles:
    - virtual,gpio-mdio
@@ -1839,7 +1774,7 @@ platforms are moved over to use the flattened-device-tree model.
 			 &qe_pio_c 6>;
 	};
 
-    h) SPI (Serial Peripheral Interface) busses
+    g) SPI (Serial Peripheral Interface) busses
 
     SPI busses can be described with a node for the SPI master device
     and a set of child nodes for each SPI slave on the bus.  For this
diff --git a/Documentation/powerpc/dts-bindings/mtd-physmap.txt b/Documentation/powerpc/dts-bindings/mtd-physmap.txt
new file mode 100644
index 0000000..cd474f9
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/mtd-physmap.txt
@@ -0,0 +1,63 @@
+CFI or JEDEC memory-mapped NOR flash
+
+Flash chips (Memory Technology Devices) are often used for solid state
+file systems on embedded devices.
+
+ - compatible : should contain the specific model of flash chip(s)
+   used, if known, followed by either "cfi-flash" or "jedec-flash"
+ - reg : Address range of the flash chip
+ - bank-width : Width (in bytes) of the flash bank.  Equal to the
+   device width times the number of interleaved chips.
+ - device-width : (optional) Width of a single flash chip.  If
+   omitted, assumed to be equal to 'bank-width'.
+ - #address-cells, #size-cells : Must be present if the flash has
+   sub-nodes representing partitions (see below).  In this case
+   both #address-cells and #size-cells must be equal to 1.
+
+For JEDEC compatible devices, the following additional properties
+are defined:
+
+ - vendor-id : Contains the flash chip's vendor id (1 byte).
+ - device-id : Contains the flash chip's device id (1 byte).
+
+In addition to the information on the flash bank itself, the
+device tree may optionally contain additional information
+describing partitions of the flash address space.  This can be
+used on platforms which have strong conventions about which
+portions of the flash are used for what purposes, but which don't
+use an on-flash partition table such as RedBoot.
+
+Each partition is represented as a sub-node of the flash device.
+Each node's name represents the name of the corresponding
+partition of the flash device.
+
+Flash partitions
+ - reg : The partition's offset and size within the flash bank.
+ - label : (optional) The label / name for this flash partition.
+   If omitted, the label is taken from the node name (excluding
+   the unit address).
+ - read-only : (optional) This parameter, if present, is a hint to
+   Linux that this flash partition should only be mounted
+   read-only.  This is usually used for flash partitions
+   containing early-boot firmware images or data which should not
+   be clobbered.
+
+Example:
+
+	flash@ff000000 {
+		compatible = "amd,am29lv128ml", "cfi-flash";
+		reg = <ff000000 01000000>;
+		bank-width = <4>;
+		device-width = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		fs@0 {
+			label = "fs";
+			reg = <0 f80000>;
+		};
+		firmware@f80000 {
+			label ="firmware";
+			reg = <f80000 80000>;
+			read-only;
+		};
+	};
-- 
1.6.2.2
