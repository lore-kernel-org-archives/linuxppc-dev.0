Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3CBC67B45
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jun 2006 12:47:46 +1000 (EST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k5I2ssX9010635
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jun 2006 21:54:55 -0500
Subject: [RFC] Interrupt mapping documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 12:45:31 +1000
Message-Id: <1150598731.23600.146.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

I'm almost finished with a set of patches overhauling the interrupt
management of the powerpc kernel to allow proper and mostly hack-less
remapping of interrupt numbers, proper walking of the interrupt tree in
all cases, and lift the requirement of having all PCI devices have
matching device nodes in order to resolve their interrupts.

Along with this work for which I'll post patches in a couple of days,
I've started updating the documentation booting-without-of.txt. Here's a
draft diff against 2.6.17, please comment asap:

--- linux-2.6/Documentation/powerpc/booting-without-of.txt	2006-04-19 15:04:29.000000000 +1000
+++ booting-without-of.txt	2006-06-18 12:42:49.000000000 +1000
@@ -50,10 +50,15 @@
 			   structure
 			 - Added chapter VI
 
+   June 18, 2006: Rev 0.6
+                         - Define the interrupt tree properties and
+                           requirements
+                         - Initial PCI requirements vs. interrupts
+			 - Remove linux,platform as the kernel no
+			   longer uses them.
+
 
  ToDo:
-	- Add some definitions of interrupt tree (simple/complex)
-	- Add some definitions for pci host bridges
 	- Add some common address format examples
 	- Add definitions for standard properties and "compatible"
 	  names for cells that are not already defined by the existing
@@ -523,6 +528,10 @@
 explained in chapter IV which defines precisely the required nodes and
 properties and their content.
 
+Note that in most cases, you will need at least an interrupt
+controller somewhere in that tree, and possibly one or more PCI host
+bridges if you have PCI, PCI-X, PCI Express or HyperTransport
+devices.
 
 3) Device tree "structure" block
 
@@ -731,9 +740,9 @@
       for example, if you have 2 board models with a similar layout,
       that typically get driven by the same platform code in the
       kernel, you would use a different "model" property but put a
-      value in "compatible". The kernel doesn't directly use that
-      value (see /chosen/linux,platform for how the kernel choses a
-      platform type) but it is generally useful.
+      value in "compatible". Your board support code will use any
+      combination of those properties to uniquely identify your board
+      and decide to "attach" to it.
 
   The root node is also generally where you add additional properties
   specific to your board like the serial number if any, that sort of
@@ -844,8 +853,11 @@
 
   Required properties:
 
-    - linux,platform : This is your platform number as assigned by the
-      architecture maintainers
+    - (OBSOLETE) linux,platform : This is your platform number as assigned by the
+      architecture maintainers. This properly has been obsoleted. As
+      of 2.6.17, the kernel board support code has a probe() function
+      that can access the flat device-tree to decide wether to attach
+      or not. The platform numbers are gone.
 
   Recommended properties:
 
@@ -884,13 +896,13 @@
     - device_type : Should be "soc"
     - ranges : Should be defined as specified in 1) to describe the
       translation of SOC addresses for memory mapped SOC registers.
-    - bus-frequency: Contains the bus frequency for the SOC node.
-      Typically, the value of this field is filled in by the boot
-      loader. 
 
 
   Recommended properties:
 
+    - bus-frequency: Contains the bus frequency for the SOC node.
+      Typically, the value of this field is filled in by the boot
+      loader. 
     - reg : This property defines the address and size of the
       memory-mapped registers that are used for the SOC node itself.
       It does not include the child device registers - these will be
@@ -931,6 +943,26 @@
 	}
 
 
+  g) interrupt controller
+
+  At least one interrupt controller shall be present somewhere in the
+  device-tree. It can be anywhere, it doesn't have to be a dedicated
+  node (could be the /soc node) though it's generally separate. See
+  chapter VII for a description of interrupt mapping and associated
+  properties.
+
+  h) PCI (and PCI-X,PCI-E and HyperTransport) host bridge(s)
+
+  The kernel requires host bridges to be present in the device-tree as
+  "anchors" for the PCI subsystem. The kernel doesn't require nodes
+  for the individual PCI devices, however, before 2.6.18, the standard
+  powerpc PCI code is unable to resolve interrupt mapping unless those
+  are present. As of 2.6.18, the requirement for interrupt mapping has
+  been lifted so that only host bridges (and PCI2PCI bridges that don't
+  follow standard interrupt swizzling) need to have nodes in order to
+  provide appropriate interrupt maps. This is discussed in more
+  details in chapter VII along with the rest of the interrupt mapping.
+
 
 IV - "dtc", the device tree compiler
 ====================================
@@ -1119,6 +1151,11 @@
 2) Specifying interrupt information for SOC devices
 ---------------------------------------------------
 
+[NOTE: This section if historical and will be removed. Complete
+interrupt mapping is described now in Chapter VII which is a superset
+of what is described here. What is described here is still valid
+though, it's just superceeded.]
+
 Each device that is part of an SOC and which generates interrupts
 should have the following properties:
 
@@ -1149,6 +1186,11 @@
 	2 =  high to low edge sensitive type enabled
 	3 =  low to high edge sensitive type enabled
 
+[NOTE: In addition, the interrupt controller (pointed to by the
+interrupt-parent property) _MUST_ have a #interrupt-cells indicating
+the number of cells used to represent an interrupt. If following the
+above recommendation of 2 cells, then this property shall have a value
+of 2]
 
 
 3) Representing devices without a current OF specification
@@ -1263,11 +1305,12 @@
 
    Example :
 
-	pic@40000 {
+	interrupt-controller@40000 {
 		linux,phandle = <40000>;
 		clock-frequency = <0>;
 		interrupt-controller;
 		#address-cells = <0>;
+		#interrupt-cells = <2>;
 		reg = <40000 40000>;
 		built-in;
 		compatible = "chrp,open-pic";
@@ -1445,6 +1488,314 @@
    More devices will be defined as this spec matures.
 
 
+VII - Interrupt mapping
+=======================
+
+Interrupt mapping shall follow the document "Open Firmware,
+Recommended Practice: Interrupt Mapping". In addition, it is described
+in simpler words below.
+
+The interrupts representation in the device-tree form one or several
+trees rooted at the interrupt-controllers. (The interrupt controllers
+themselves can have an interrupt connected to another controller,
+that's the typical case of cascaded controllers, though I
+intentionally disconnect the 2 trees).
+
+For each interrupt controller in the system, the device-tree shall
+contain an interrupt-controller node. This doesn't have to be a
+dedicated node. A device node can also act as an interrupt
+controller. For example, some processors might want to have the /soc
+node also be the interrupt controller.
+
+Devices that can emit interrupts shall have an "interrupts" property
+containing interrupt specifiers. The format for these is specific to a
+given interrupt controller or interrupt nexus (see below).
+
+Some busses might want to define an "interrupt nexus". This is
+essentially a format conversion between child devices interrupt
+specifiers ("interrupts" properties) and parent interrupt controller
+defined interrupt specifiers. A typical example of this is PCI bridges
+who convert PCI devices interrupt specifiers representing their
+interrupts as a PCI interrupt line (INT#A...D) to interrupt sepcifiers
+in the format of the parent controller (generally a source number and
+a sense value). PCI is described in more details as an example later. 
+
+Thus, a given device "interrupts" property is interpreted based on the
+interrupt "parent" of that device which can either be an interrupt
+controller or a nexus. The interrupt "parent" of a given device is, by
+default, the parent node in the tree, unless the device contains an
+explicit "interrupt-parent" property (defined below). In addition, the
+linux kernel will walk up the tree until it finds either a nexus or an
+interrupt controller, jumping up one level when no interrupt-parent is
+to be found or jumping to that node when one is found. Thus, a single
+interrupt-parent property can be used in a /soc node to represent the
+interrupt parent of all child nodes for example.
+
+
+1) Interrupt controllers
+------------------------
+
+An interrupt controller is identified by the presence of an empty
+"interrupt-controller" property in the node. It must also have those
+two required properties:
+
+    - linux,phandle : The normally optional phandle is required for an
+      interrupt controller node as that node will have to be
+      referrenced by phandle by other nodes (childs and nexus).
+    - #interrupt-cells : This property contains one cell indicating
+      the size of the child interrupt specifiers (number of
+      cells). For example, both ISA and OpenPIC standard specifiers
+      are 2 cells long (interrupt source number and trigger type) thus
+      the interrupt-controller node for these shall contain a
+      #interrupt-cells property with the value <2>.
+
+In addition, it needs that optional property if there is ever a nexus
+pointing to that controller:
+
+    - #address-cells : This is generally the value 0 for an interrupt
+      controller, the reason why this property is needed is described
+      in the documentation of an interrupt nexus.
+
+The format of the interrupt specifier is specific to a given interrupt
+controller. Open Firmware (and thus this document) defines the format
+for OpenPIC and ISA controllers. Both of them define a 2 cells
+specifier comprised of the interrupt source number followed by the
+trigger type (also called sense and polarity). The trigger types for
+OpenPIC and ISA are different however:
+
+  - Devices connected to openPIC-compatible controllers should encode
+    sense and polarity as follows:
+
+	0 = high to low edge sensitive type enabled
+	1 = active low level sensitive type enabled
+
+    In addition, common practice defines the following (which is
+    often supported only for OpenPIC interrupt 0, aka cascade):
+
+	2 = low to high edge sensitive type enabled
+
+    For completeness (and to allow for extensions by vendors), we also
+    define the following:
+
+	3 = active high level sensitive type enabled
+
+  - ISA PIC interrupt controllers should adhere to the ISA PIC
+    encodings listed below:
+
+	0 =  active low level sensitive type enabled
+	1 =  active high level sensitive type enabled
+	2 =  high to low edge sensitive type enabled
+	3 =  low to high edge sensitive type enabled
+
+Note: The interrupt source numbers are local to the interrupt
+controller. They don't necessarily match the linux interrupt numbers
+that will be used as interrupt numbers can be virtually offset or
+remapped by the kernel to accomodate several controller interrupt
+spaces in the single linux linear interrupt space. The device-tree
+shall only contain "hardware" source numbers, a given specifier
+containing a source number local to it's interrupt controller (or nexus).
+
+2) Devices
+----------
+
+A device that can emit interrupts is defined to have an "interrupts"
+property that contain one or several interrupt specifiers in the
+format defined by the interrupt parent (controller or nexus) of that
+device. In addition, it can have an optional:
+
+    - interrupt-parent: This property contains a phandle which points
+      to the interrupt controller or nexus that acts as the parent for
+      this node (and thus defines the format of the interrupt
+      specifiers in the "interrupts" property and contains the
+      #interrupt-cells for it). In absence of this property, the
+      device-tree parent is the default interrupt parent for the
+      device. If this parent still doesn't contain a #interrupt-cells
+      property, the linux kernel will continue walking up the tree
+      until it finds one (or an interrupt-parent).
+
+3) Nexus
+--------
+
+An interrupt "nexus" doesn't necessarily represent a physical device
+in the system. It's a node (can be any type of node but is typically
+the bus parent of a given bus type) that contain properties to remap
+the interrupt specifiers of child devices into the format of interrupt
+specifiers of the parent interrupt controller. An interrupt nexus is
+defined by the presence of an "interrupt-map" property.
+
+A typical example is PCI. PCI host and PCI-PCI bridges shall have
+interrupt nexus that convert between the "interrupts" properties of
+PCI devices, which are defined by the PCI bindings to contain a value
+representing the interrupt line used by that device
+(1=INT#A...4=INT#D), to the actual interrupt source line of the parent
+controller where those lines are connected to. In a sense, the
+interrupt nexus represents the wiring of PCI INT# lines to the parent
+controller sources.
+
+Interrupt nexus aren't mandatory for devices that are explicitely
+represented in the device-tree. If a node is in the tree, it can have
+an interrupt-parent pointing directly to the interrupt controller or
+be on a bus that has a common interrupt-parent (like ISA) and in which
+case device "interrupts" properties directly contain an interrupt
+specifier in the format defined by the parent interrupt controller.
+
+However interrupt nexus are useful for busses like PCI which provide
+slots that can be probed and do not require the presence of matching
+device nodes for every devices. It allows a PCI host bridge for
+example to provide the complete mapping of all interrupt lines of all
+slots without having to actually create nodes for those child devices
+or, if they are created anyway, without having to fill them with fully
+resolved interrupt specifiers and interrupt-parent pointers.
+
+
+There are 3 required properties in an interrupt nexus:
+
+      - #interrupt-cells : This property defines the number of cells of
+        interrupt specifiers for child nodes (exactly like for an
+        interrupt-controller).
+      - #address-cells : This property defines the number of cells of
+        an address in the child device "reg" property. it's not
+        specific to interrupt nexus. In fact, when interrupt nexus are
+        also bus bridges (like in the case of PCI bridges), they shall
+        already have such a property. The way this property is used
+        for interrupt resolution is described below
+      - #interrupt-map : This property defines the mapping between
+	child interrupt specifiers and parent interrupts. It's format
+        is fairly complex and described below.
+
+Along with an optional one:
+
+      - interrupt-map-mask : This property defines which part of an
+        interrupt "unit specifier" (see definition below) is taken into
+        account when comparing child devices with entries in the
+        interrupt-map.
+
+Ok, so now, here's how it works:
+
+We define the notion of an "interrupt unit specifier" as being the
+concatenation of a device unit address and its interrupt
+specififer. The unit address is the first cells (how many is defined
+by the #address-cells property) of the device "reg" property. The
+interrupt specifier is the content of the "interrupts" property for a
+given interrupt.
+
+For example, if a bus has a #address-cells of 1 and a #interrupt-cells
+of 2, a device with those properties:
+
+   reg = <0xabcd1234>;
+   interrupts = <0x00000001 0x00000000 0x00000002 0x00000001>
+
+(That is a device with 2 interrupt specifiers in its "interrupts"
+property) would thus have the following interrupt unit
+specifiers for its two interrupts:
+
+	   0xabcd1234 0x00000001 0x00000000
+and
+	   0xabcd1234 0x00000002 0x00000001
+
+Now the "interrupt-map" property is defined as containing a list of:
+
+ [ child interrupt unit specifier ] [ parent ] [ parent interrupt unit
+ specifier ]
+
+That is, a concatenated list of entries containing:
+
+     - an interrupt unit specifier for a child device
+     - a phandle pointing to the interrupt-parent for that interrupt
+     - an interrupt unit specifier in the parent space for that
+       interrupt
+
+In effect, when resolving an interrupt, the system "matches" the
+interrupt unit specifier of the device interrupt to resolve with an
+entry in that list and when a match is found, this specifier is
+"replaced" by the new specifier in the parent space and the resolving
+continues from the new parent.
+
+Note that since the parent interrupt unit specifier represents the new
+unit address and interrupt specifier to be used when resolving in the
+parent's space, their size follows the parent's #address-cells and
+#interrupt-cells. That's also why interrupt-controllers generally need
+a #address-cells property when there is an interrupt-nexus pointing to
+them. In absence of such a property, the kernel will assume a value of
+0. It's usual that the #address-cells of an interrupt controller is
+0. This indicates that the "unit address" part of the "interrupt unit
+specifier" doesn't exist in the interrupt controller space, thus
+turning the interrupt unit specifier into a simple interrupt
+specifier.
+
+Now, it's generally useful to not take into account an entire
+interrupt unit specifier for matching but only part of it (for
+example a PCI unit address contains the PCI bus,device and function
+along with various informations related to PCI BARs, though only the
+PCI device and the interrupt specifier are interesting to the
+interrupt mapping in most cases). That's what the interrupt-map-mask
+property is for. This property has the same size as an interrupt unit
+specifier in the child device space and contains a bitmask of the bits
+of the interrupt unit specifier that are relevant for comparison in
+the interrupt-map.
+
+Example of interrupt-map in the PCI binding section.
+
+
+4) PCI bindings
+---------------
+
+The PCI bindings to open firmware defines a specific format for the
+"interrupts" property of PCI devies and thus that all PCI host and PCI to
+PCI bridges are interrupt nexus. This is not mandatory as per this
+spec. The kernel will be able to resolve interrupts for PCI devices
+that have device node, wether they contain an interrupt-parent
+property pointing directly to the interrupt controller (and thus their
+interrupts property is in the controller format) or wether they have a
+PCI defined interrupts property and use a nexus in the parent bridge.
+
+The format of a PCI device interrupt specifier as per the PCI-OF
+bindings is a single cell (thus PCI bridges contain a #interrupt-cells
+property with the value <1>) containing the interrupt line used by the
+device:
+
+   <1> = INT#A
+   <2> = INT#B
+   <3> = INT#C
+   <4> = INT#D
+
+It's generally obtained from the device/function config space
+interrupt pin register and define which of the 4 interrupt pins a
+given device function uses.
+
+However, if you decide to not provide device-nodes for some PCI
+devices (typically for slots, thus not having to probe those slots
+from the firmware), you shall provide an interrupt nexus in the parent
+bridge containing mappings for all the possible interrupt lines on
+those slots. If those are behind a PCI-PCI bridge, you have the choice
+of either providing a node (and a nexus) for the bridge, or not. If
+the bridge uses standard sizzling, the kernel will be able (from
+2.6.18 and later) to resolve interrupts provided that the host bridge
+contains a nexus with maps for all possible interrupt lines of the
+PCI-PCI bridge itself. If your PCI-PCI bridge doesn't use standard
+swizzling, then you are required to provide a device-node and a nexus
+for it in order to allow the kernel to resolve interrupt for child
+devices of that bridge. 
+
+
+<... INSERT EXAMPLES ...>
+
+
+
+VIII - PCI, PCI-X, PCI-Express and HyperTransport busses
+========================================================
+
+The specification follows exactly the Open Firmware bindings to PCI
+with the exception that nodes for devices are optional provided enough
+interrupt mapping information is provided in the host bridges (see
+chapter VII).
+
+<... TODO ...> add more and define properties for PCI host bridges>
+
+<... TODO ...> add PCI examples
+
+
+
 Appendix A - Sample SOC node for MPC8540
 ========================================
 
@@ -1539,11 +1890,12 @@
 			interrupt-parent = <40000>;
 		};
 
-		pic@40000 {
+		interrupt-controller@40000 {
 			linux,phandle = <40000>;
 			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
+			#interrupt-cells = <2>;
 			reg = <40000 40000>;
 			built-in;
 			compatible = "chrp,open-pic";
 
