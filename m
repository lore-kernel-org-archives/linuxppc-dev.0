Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail2-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 35C59DE205
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 06:35:25 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	simekm2@fel.cvut.cz, jwilliams@itee.uq.edu.au
Subject: [PATCH 5/7] [POWERPC] Xilinx: Update booting-without-of.
Date: Tue,  8 Jan 2008 11:35:07 -0800
In-Reply-To: <1199820909-32341-5-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1199820909-32341-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-5-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20080108193519.F350E9807A@mail2-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This now better describes what the UBoot device tree generator
actually does.  In particular:

1) Nodes have a label derived from the device name, and a node name
derived from a generic version of the device type, e.g. 'ethernet',
'serial', etc.

2) Usage of compound nodes (representing more than one device in the
same IP) which actually works.  This requires having a valid
compatible node, and all the other things that a bus normally has.
I've chosen 'xlnx,compound' as the bus name to describe these compound
nodes.

In addition, I've clarified some of the language relating to how mhs
nodes should be represent in the device tree.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 Documentation/powerpc/booting-without-of.txt |   56 +++++++++++++++-----------
 1 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index e9a3cb1..d14e45d 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2276,7 +2276,7 @@ platforms are moved over to use the flattened-device-tree model.
    properties of the device node.  In general, device nodes for IP-cores
    will take the following form:
 
-	(name)@(base-address) {
+	(name): (generic-name)@(base-address) {
 		compatible = "xlnx,(ip-core-name)-(HW_VER)"
 			     [, (list of compatible devices), ...];
 		reg = <(baseaddr) (size)>;
@@ -2286,6 +2286,9 @@ platforms are moved over to use the flattened-device-tree model.
 		xlnx,(parameter2) = <(int-value)>;
 	};
 
+	(generic-name):   an open firmware-style name that describes the
+			generic class of device.  Preferably, this is one word, such
+			as 'serial' or 'ethernet'.
 	(ip-core-name):	the name of the ip block (given after the BEGIN
 			directive in system.mhs).  Should be in lowercase
 			and all underscores '_' converted to dashes '-'.
@@ -2294,9 +2297,9 @@ platforms are moved over to use the flattened-device-tree model.
 			dropped from the parameter name, the name is converted
 			to lowercase and all underscore '_' characters are
 			converted to dashes '-'.
-	(baseaddr):	the C_BASEADDR parameter.
+	(baseaddr):	the baseaddr parameter value (often named C_BASEADDR).
 	(HW_VER):	from the HW_VER parameter.
-	(size):		equals C_HIGHADDR - C_BASEADDR + 1
+	(size):		the address range size (often C_HIGHADDR - C_BASEADDR + 1).
 
    Typically, the compatible list will include the exact IP core version
    followed by an older IP core version which implements the same
@@ -2326,11 +2329,11 @@ platforms are moved over to use the flattened-device-tree model.
 
    becomes the following device tree node:
 
-	opb-uartlite-0@ec100000 {
+	opb_uartlite_0: serial@ec100000 {
 		device_type = "serial";
 		compatible = "xlnx,opb-uartlite-1.00.b";
 		reg = <ec100000 10000>;
-		interrupt-parent = <&opb-intc>;
+		interrupt-parent = <&opb_intc_0>;
 		interrupts = <1 0>; // got this from the opb_intc parameters
 		current-speed = <d#115200>;	// standard serial device prop
 		clock-frequency = <d#50000000>;	// standard serial device prop
@@ -2339,16 +2342,19 @@ platforms are moved over to use the flattened-device-tree model.
 		xlnx,use-parity = <0>;
 	};
 
-   Some IP cores actually implement 2 or more logical devices.  In this case,
-   the device should still describe the whole IP core with a single node
-   and add a child node for each logical device.  The ranges property can
-   be used to translate from parent IP-core to the registers of each device.
-   (Note: this makes the assumption that both logical devices have the same
-   bus binding.  If this is not true, then separate nodes should be used for
-   each logical device).  The 'cell-index' property can be used to enumerate
-   logical devices within an IP core.  For example, the following is the
-   system.mhs entry for the dual ps2 controller found on the ml403 reference
-   design.
+   Some IP cores actually implement 2 or more logical devices.  In
+   this case, the device should still describe the whole IP core with
+   a single node and add a child node for each logical device.  The
+   ranges property can be used to translate from parent IP-core to the
+   registers of each device.  In addition, the parent node should be
+   compatible with the bus type 'xlnx,compound', and should contain
+   #address-cells and #size-cells, as with any other bus.  (Note: this
+   makes the assumption that both logical devices have the same bus
+   binding.  If this is not true, then separate nodes should be used
+   for each logical device).  The 'cell-index' property can be used to
+   enumerate logical devices within an IP core.  For example, the
+   following is the system.mhs entry for the dual ps2 controller found
+   on the ml403 reference design.
 
 	BEGIN opb_ps2_dual_ref
 		PARAMETER INSTANCE = opb_ps2_dual_ref_0
@@ -2370,21 +2376,24 @@ platforms are moved over to use the flattened-device-tree model.
 
    It would result in the following device tree nodes:
 
-	opb_ps2_dual_ref_0@a9000000 {
+	opb_ps2_dual_ref_0: opb-ps2-dual-ref@a9000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "xlnx,compound";
 		ranges = <0 a9000000 2000>;
 		// If this device had extra parameters, then they would
 		// go here.
 		ps2@0 {
 			compatible = "xlnx,opb-ps2-dual-ref-1.00.a";
 			reg = <0 40>;
-			interrupt-parent = <&opb-intc>;
+			interrupt-parent = <&opb_intc_0>;
 			interrupts = <3 0>;
 			cell-index = <0>;
 		};
 		ps2@1000 {
 			compatible = "xlnx,opb-ps2-dual-ref-1.00.a";
 			reg = <1000 40>;
-			interrupt-parent = <&opb-intc>;
+			interrupt-parent = <&opb_intc_0>;
 			interrupts = <3 0>;
 			cell-index = <0>;
 		};
@@ -2447,17 +2456,18 @@ platforms are moved over to use the flattened-device-tree model.
 
    Gives this device tree (some properties removed for clarity):
 
-	plb-v34-0 {
+	plb@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
+		compatible = "xlnx,plb-v34-1.02.a";
 		device_type = "ibm,plb";
 		ranges; // 1:1 translation
 
-		plb-bram-if-cntrl-0@ffff0000 {
+		plb_bram_if_cntrl_0: bram@ffff0000 {
 			reg = <ffff0000 10000>;
 		}
 
-		opb-v20-0 {
+		opb@20000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <20000000 20000000 20000000
@@ -2465,11 +2475,11 @@ platforms are moved over to use the flattened-device-tree model.
 				  80000000 80000000 40000000
 				  c0000000 c0000000 20000000>;
 
-			opb-uart16550-0@a0000000 {
+			opb_uart16550_0: serial@a0000000 {
 				reg = <a00000000 2000>;
 			};
 
-			opb-intc-0@d1000fc0 {
+			opb_intc_0: interrupt-controller@d1000fc0 {
 				reg = <d1000fc0 20>;
 			};
 		};
-- 
1.5.3.4-dirty
