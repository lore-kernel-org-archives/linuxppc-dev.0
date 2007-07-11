Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0B0BDDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 07:46:43 +1000 (EST)
Subject: [PATCH 1/2] Kernel: Move all technical descriptons of the Device
	Tree Complier
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1184190359.25384.129.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 11 Jul 2007 16:45:59 -0500
Cc: Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jon Loeliger <jdl@freescale.com>

and its formats, command lines, descriptions, etc,
over to the Device Tree Compiler repositories now.

A corresponding patch adding these sections to the DTC
repository has been submitted to that repository as well.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |  519 +-------------------------
 1 files changed, 18 insertions(+), 501 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 0c24348..73ba544 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -15,13 +15,7 @@ Table of Contents
     1) Entry point for arch/powerpc
     2) Board support
 
-  II - The DT block format
-    1) Header
-    2) Device tree generalities
-    3) Device tree "structure" block
-    4) Device tree "strings" block
-
-  III - Required content of the device tree
+  II - Required content of the device tree
     1) Note about cells and address representation
     2) Note about "compatible" properties
     3) Note about "name" properties
@@ -34,11 +28,9 @@ Table of Contents
       e) The /chosen node
       f) the /soc<SOCname> node
 
-  IV - "dtc", the device tree compiler
-
-  V - Recommendations for a bootloader
+  III - Recommendations for a bootloader
 
-  VI - System-on-a-chip devices and nodes
+  IV - System-on-a-chip devices and nodes
     1) Defining child nodes of an SOC
     2) Representing devices without a current OF specification
       a) MDIO IO device
@@ -53,7 +45,7 @@ Table of Contents
       j) Flash chip nodes
       k) Global Utilities Block
 
-  VII - Specifying interrupt information for devices
+  V - Specifying interrupt information for devices
     1) interrupts property
     2) interrupt-parent property
     3) OpenPIC Interrupt Controllers
@@ -109,6 +101,13 @@ Revision Information
 			 - Added chapter VI
 
 
+   July 11, 2007: Rev 0.6
+			 - Removed Device Tree Compiler specifications
+			   from this document and relocated them to the
+			   Device Tree Repository instead.
+
+
+
  ToDo:
 	- Add some definitions of interrupt tree (simple/complex)
 	- Add some definitions for PCI host bridges
@@ -279,374 +278,8 @@ point to setup_32.c
    your platform should implement.
 
 
-II - The DT block format
-========================
-
-
-This chapter defines the actual format of the flattened device-tree
-passed to the kernel. The actual content of it and kernel requirements
-are described later. You can find example of code manipulating that
-format in various places, including arch/powerpc/kernel/prom_init.c
-which will generate a flattened device-tree from the Open Firmware
-representation, or the fs2dt utility which is part of the kexec tools
-which will generate one from a filesystem representation. It is
-expected that a bootloader like uboot provides a bit more support,
-that will be discussed later as well.
-
-Note: The block has to be in main memory. It has to be accessible in
-both real mode and virtual mode with no mapping other than main
-memory. If you are writing a simple flash bootloader, it should copy
-the block to RAM before passing it to the kernel.
-
-
-1) Header
----------
-
-   The kernel is entered with r3 pointing to an area of memory that is
-   roughly described in include/asm-powerpc/prom.h by the structure
-   boot_param_header:
-
-struct boot_param_header {
-        u32     magic;                  /* magic word OF_DT_HEADER */
-        u32     totalsize;              /* total size of DT block */
-        u32     off_dt_struct;          /* offset to structure */
-        u32     off_dt_strings;         /* offset to strings */
-        u32     off_mem_rsvmap;         /* offset to memory reserve map
-                                           */
-        u32     version;                /* format version */
-        u32     last_comp_version;      /* last compatible version */
-
-        /* version 2 fields below */
-        u32     boot_cpuid_phys;        /* Which physical CPU id we're
-                                           booting on */
-        /* version 3 fields below */
-        u32     size_dt_strings;        /* size of the strings block */
-
-        /* version 17 fields below */
-        u32	size_dt_struct;		/* size of the DT structure block */
-};
-
-   Along with the constants:
-
-/* Definitions used by the flattened device tree */
-#define OF_DT_HEADER            0xd00dfeed      /* 4: version,
-						   4: total size */
-#define OF_DT_BEGIN_NODE        0x1             /* Start node: full name
-						   */
-#define OF_DT_END_NODE          0x2             /* End node */
-#define OF_DT_PROP              0x3             /* Property: name off,
-                                                   size, content */
-#define OF_DT_END               0x9
-
-   All values in this header are in big endian format, the various
-   fields in this header are defined more precisely below. All
-   "offset" values are in bytes from the start of the header; that is
-   from the value of r3.
-
-   - magic
-
-     This is a magic value that "marks" the beginning of the
-     device-tree block header. It contains the value 0xd00dfeed and is
-     defined by the constant OF_DT_HEADER
-
-   - totalsize
-
-     This is the total size of the DT block including the header. The
-     "DT" block should enclose all data structures defined in this
-     chapter (who are pointed to by offsets in this header). That is,
-     the device-tree structure, strings, and the memory reserve map.
-
-   - off_dt_struct
-
-     This is an offset from the beginning of the header to the start
-     of the "structure" part the device tree. (see 2) device tree)
-
-   - off_dt_strings
-
-     This is an offset from the beginning of the header to the start
-     of the "strings" part of the device-tree
-
-   - off_mem_rsvmap
-
-     This is an offset from the beginning of the header to the start
-     of the reserved memory map. This map is a list of pairs of 64-
-     bit integers. Each pair is a physical address and a size. The
-     list is terminated by an entry of size 0. This map provides the
-     kernel with a list of physical memory areas that are "reserved"
-     and thus not to be used for memory allocations, especially during
-     early initialization. The kernel needs to allocate memory during
-     boot for things like un-flattening the device-tree, allocating an
-     MMU hash table, etc... Those allocations must be done in such a
-     way to avoid overriding critical things like, on Open Firmware
-     capable machines, the RTAS instance, or on some pSeries, the TCE
-     tables used for the iommu. Typically, the reserve map should
-     contain _at least_ this DT block itself (header,total_size). If
-     you are passing an initrd to the kernel, you should reserve it as
-     well. You do not need to reserve the kernel image itself. The map
-     should be 64-bit aligned.
-
-   - version
-
-     This is the version of this structure. Version 1 stops
-     here. Version 2 adds an additional field boot_cpuid_phys.
-     Version 3 adds the size of the strings block, allowing the kernel
-     to reallocate it easily at boot and free up the unused flattened
-     structure after expansion. Version 16 introduces a new more
-     "compact" format for the tree itself that is however not backward
-     compatible. Version 17 adds an additional field, size_dt_struct,
-     allowing it to be reallocated or moved more easily (this is
-     particularly useful for bootloaders which need to make
-     adjustments to a device tree based on probed information). You
-     should always generate a structure of the highest version defined
-     at the time of your implementation. Currently that is version 17,
-     unless you explicitly aim at being backward compatible.
-
-   - last_comp_version
-
-     Last compatible version. This indicates down to what version of
-     the DT block you are backward compatible. For example, version 2
-     is backward compatible with version 1 (that is, a kernel build
-     for version 1 will be able to boot with a version 2 format). You
-     should put a 1 in this field if you generate a device tree of
-     version 1 to 3, or 16 if you generate a tree of version 16 or 17
-     using the new unit name format.
-
-   - boot_cpuid_phys
-
-     This field only exist on version 2 headers. It indicate which
-     physical CPU ID is calling the kernel entry point. This is used,
-     among others, by kexec. If you are on an SMP system, this value
-     should match the content of the "reg" property of the CPU node in
-     the device-tree corresponding to the CPU calling the kernel entry
-     point (see further chapters for more informations on the required
-     device-tree contents)
-
-   - size_dt_strings
-
-     This field only exists on version 3 and later headers.  It
-     gives the size of the "strings" section of the device tree (which
-     starts at the offset given by off_dt_strings).
-
-   - size_dt_struct
-
-     This field only exists on version 17 and later headers.  It gives
-     the size of the "structure" section of the device tree (which
-     starts at the offset given by off_dt_struct).
-
-   So the typical layout of a DT block (though the various parts don't
-   need to be in that order) looks like this (addresses go from top to
-   bottom):
-
-
-             ------------------------------
-       r3 -> |  struct boot_param_header  |
-             ------------------------------
-             |      (alignment gap) (*)   |
-             ------------------------------
-             |      memory reserve map    |
-             ------------------------------
-             |      (alignment gap)       |
-             ------------------------------
-             |                            |
-             |    device-tree structure   |
-             |                            |
-             ------------------------------
-             |      (alignment gap)       |
-             ------------------------------
-             |                            |
-             |     device-tree strings    |
-             |                            |
-      -----> ------------------------------
-      |
-      |
-      --- (r3 + totalsize)
-
-  (*) The alignment gaps are not necessarily present; their presence
-      and size are dependent on the various alignment requirements of
-      the individual data blocks.
-
-
-2) Device tree generalities
----------------------------
-
-This device-tree itself is separated in two different blocks, a
-structure block and a strings block. Both need to be aligned to a 4
-byte boundary.
-
-First, let's quickly describe the device-tree concept before detailing
-the storage format. This chapter does _not_ describe the detail of the
-required types of nodes & properties for the kernel, this is done
-later in chapter III.
-
-The device-tree layout is strongly inherited from the definition of
-the Open Firmware IEEE 1275 device-tree. It's basically a tree of
-nodes, each node having two or more named properties. A property can
-have a value or not.
-
-It is a tree, so each node has one and only one parent except for the
-root node who has no parent.
-
-A node has 2 names. The actual node name is generally contained in a
-property of type "name" in the node property list whose value is a
-zero terminated string and is mandatory for version 1 to 3 of the
-format definition (as it is in Open Firmware). Version 16 makes it
-optional as it can generate it from the unit name defined below.
-
-There is also a "unit name" that is used to differentiate nodes with
-the same name at the same level, it is usually made of the node
-names, the "@" sign, and a "unit address", which definition is
-specific to the bus type the node sits on.
-
-The unit name doesn't exist as a property per-se but is included in
-the device-tree structure. It is typically used to represent "path" in
-the device-tree. More details about the actual format of these will be
-below.
-
-The kernel powerpc generic code does not make any formal use of the
-unit address (though some board support code may do) so the only real
-requirement here for the unit address is to ensure uniqueness of
-the node unit name at a given level of the tree. Nodes with no notion
-of address and no possible sibling of the same name (like /memory or
-/cpus) may omit the unit address in the context of this specification,
-or use the "@0" default unit address. The unit name is used to define
-a node "full path", which is the concatenation of all parent node
-unit names separated with "/".
-
-The root node doesn't have a defined name, and isn't required to have
-a name property either if you are using version 3 or earlier of the
-format. It also has no unit address (no @ symbol followed by a unit
-address). The root node unit name is thus an empty string. The full
-path to the root node is "/".
-
-Every node which actually represents an actual device (that is, a node
-which isn't only a virtual "container" for more nodes, like "/cpus"
-is) is also required to have a "device_type" property indicating the
-type of node .
-
-Finally, every node that can be referenced from a property in another
-node is required to have a "linux,phandle" property. Real open
-firmware implementations provide a unique "phandle" value for every
-node that the "prom_init()" trampoline code turns into
-"linux,phandle" properties. However, this is made optional if the
-flattened device tree is used directly. An example of a node
-referencing another node via "phandle" is when laying out the
-interrupt tree which will be described in a further version of this
-document.
-
-This "linux, phandle" property is a 32-bit value that uniquely
-identifies a node. You are free to use whatever values or system of
-values, internal pointers, or whatever to generate these, the only
-requirement is that every node for which you provide that property has
-a unique value for it.
-
-Here is an example of a simple device-tree. In this example, an "o"
-designates a node followed by the node unit name. Properties are
-presented with their name followed by their content. "content"
-represents an ASCII string (zero terminated) value, while <content>
-represents a 32-bit hexadecimal value. The various nodes in this
-example will be discussed in a later chapter. At this point, it is
-only meant to give you a idea of what a device-tree looks like. I have
-purposefully kept the "name" and "linux,phandle" properties which
-aren't necessary in order to give you a better idea of what the tree
-looks like in practice.
-
-  / o device-tree
-      |- name = "device-tree"
-      |- model = "MyBoardName"
-      |- compatible = "MyBoardFamilyName"
-      |- #address-cells = <2>
-      |- #size-cells = <2>
-      |- linux,phandle = <0>
-      |
-      o cpus
-      | | - name = "cpus"
-      | | - linux,phandle = <1>
-      | | - #address-cells = <1>
-      | | - #size-cells = <0>
-      | |
-      | o PowerPC,970@0
-      |   |- name = "PowerPC,970"
-      |   |- device_type = "cpu"
-      |   |- reg = <0>
-      |   |- clock-frequency = <5f5e1000>
-      |   |- 64-bit
-      |   |- linux,phandle = <2>
-      |
-      o memory@0
-      | |- name = "memory"
-      | |- device_type = "memory"
-      | |- reg = <00000000 00000000 00000000 20000000>
-      | |- linux,phandle = <3>
-      |
-      o chosen
-        |- name = "chosen"
-        |- bootargs = "root=/dev/sda2"
-        |- linux,phandle = <4>
-
-This tree is almost a minimal tree. It pretty much contains the
-minimal set of required nodes and properties to boot a linux kernel;
-that is, some basic model informations at the root, the CPUs, and the
-physical memory layout.  It also includes misc information passed
-through /chosen, like in this example, the platform type (mandatory)
-and the kernel command line arguments (optional).
-
-The /cpus/PowerPC,970@0/64-bit property is an example of a
-property without a value. All other properties have a value. The
-significance of the #address-cells and #size-cells properties will be
-explained in chapter IV which defines precisely the required nodes and
-properties and their content.
-
-
-3) Device tree "structure" block
-
-The structure of the device tree is a linearized tree structure. The
-"OF_DT_BEGIN_NODE" token starts a new node, and the "OF_DT_END_NODE"
-ends that node definition. Child nodes are simply defined before
-"OF_DT_END_NODE" (that is nodes within the node). A 'token' is a 32
-bit value. The tree has to be "finished" with a OF_DT_END token
-
-Here's the basic structure of a single node:
-
-     * token OF_DT_BEGIN_NODE (that is 0x00000001)
-     * for version 1 to 3, this is the node full path as a zero
-       terminated string, starting with "/". For version 16 and later,
-       this is the node unit name only (or an empty string for the
-       root node)
-     * [align gap to next 4 bytes boundary]
-     * for each property:
-        * token OF_DT_PROP (that is 0x00000003)
-        * 32-bit value of property value size in bytes (or 0 if no
-          value)
-        * 32-bit value of offset in string block of property name
-        * property value data if any
-        * [align gap to next 4 bytes boundary]
-     * [child nodes if any]
-     * token OF_DT_END_NODE (that is 0x00000002)
-
-So the node content can be summarized as a start token, a full path,
-a list of properties, a list of child nodes, and an end token. Every
-child node is a full node structure itself as defined above.
-
-NOTE: The above definition requires that all property definitions for
-a particular node MUST precede any subnode definitions for that node.
-Although the structure would not be ambiguous if properties and
-subnodes were intermingled, the kernel parser requires that the
-properties come first (up until at least 2.6.22).  Any tools
-manipulating a flattened tree must take care to preserve this
-constraint.
-
-4) Device tree "strings" block
-
-In order to save space, property names, which are generally redundant,
-are stored separately in the "strings" block. This block is simply the
-whole bunch of zero terminated strings for all property names
-concatenated together. The device-tree property definitions in the
-structure block will contain offset values from the beginning of the
-strings block.
-
-
-III - Required content of the device tree
-=========================================
+II - Required content of the device tree
+========================================
 
 WARNING: All "linux,*" properties defined in this document apply only
 to a flattened device-tree. If your platform uses a real
@@ -1003,124 +636,8 @@ address which can extend beyond that limit.
 
 
 
-IV - "dtc", the device tree compiler
-====================================
-
-
-dtc source code can be found at
-<http://ozlabs.org/~dgibson/dtc/dtc.tar.gz>
-
-WARNING: This version is still in early development stage; the
-resulting device-tree "blobs" have not yet been validated with the
-kernel. The current generated bloc lacks a useful reserve map (it will
-be fixed to generate an empty one, it's up to the bootloader to fill
-it up) among others. The error handling needs work, bugs are lurking,
-etc...
-
-dtc basically takes a device-tree in a given format and outputs a
-device-tree in another format. The currently supported formats are:
-
-  Input formats:
-  -------------
-
-     - "dtb": "blob" format, that is a flattened device-tree block
-       with
-        header all in a binary blob.
-     - "dts": "source" format. This is a text file containing a
-       "source" for a device-tree. The format is defined later in this
-        chapter.
-     - "fs" format. This is a representation equivalent to the
-        output of /proc/device-tree, that is nodes are directories and
-	properties are files
-
- Output formats:
- ---------------
-
-     - "dtb": "blob" format
-     - "dts": "source" format
-     - "asm": assembly language file. This is a file that can be
-       sourced by gas to generate a device-tree "blob". That file can
-       then simply be added to your Makefile. Additionally, the
-       assembly file exports some symbols that can be used.
-
-
-The syntax of the dtc tool is
-
-    dtc [-I <input-format>] [-O <output-format>]
-        [-o output-filename] [-V output_version] input_filename
-
-
-The "output_version" defines what version of the "blob" format will be
-generated. Supported versions are 1,2,3 and 16. The default is
-currently version 3 but that may change in the future to version 16.
-
-Additionally, dtc performs various sanity checks on the tree, like the
-uniqueness of linux, phandle properties, validity of strings, etc...
-
-The format of the .dts "source" file is "C" like, supports C and C++
-style comments.
-
-/ {
-}
-
-The above is the "device-tree" definition. It's the only statement
-supported currently at the toplevel.
-
-/ {
-  property1 = "string_value";	/* define a property containing a 0
-                                 * terminated string
-				 */
-
-  property2 = <1234abcd>;	/* define a property containing a
-                                 * numerical 32-bit value (hexadecimal)
-				 */
-
-  property3 = <12345678 12345678 deadbeef>;
-                                /* define a property containing 3
-                                 * numerical 32-bit values (cells) in
-                                 * hexadecimal
-				 */
-  property4 = [0a 0b 0c 0d de ea ad be ef];
-                                /* define a property whose content is
-                                 * an arbitrary array of bytes
-                                 */
-
-  childnode@addresss {	/* define a child node named "childnode"
-                                 * whose unit name is "childnode at
-				 * address"
-                                 */
-
-    childprop = "hello\n";      /* define a property "childprop" of
-                                 * childnode (in this case, a string)
-                                 */
-  };
-};
-
-Nodes can contain other nodes etc... thus defining the hierarchical
-structure of the tree.
-
-Strings support common escape sequences from C: "\n", "\t", "\r",
-"\(octal value)", "\x(hex value)".
-
-It is also suggested that you pipe your source file through cpp (gcc
-preprocessor) so you can use #include's, #define for constants, etc...
-
-Finally, various options are planned but not yet implemented, like
-automatic generation of phandles, labels (exported to the asm file so
-you can point to a property content and change it easily from whatever
-you link the device-tree with), label or path instead of numeric value
-in some cells to "point" to a node (replaced by a phandle at compile
-time), export of reserve map address to the asm file, ability to
-specify reserve map content at compile time, etc...
-
-We may provide a .h include file with common definitions of that
-proves useful for some properties (like building PCI properties or
-interrupt maps) though it may be better to add a notion of struct
-definitions to the compiler...
-
-
-V - Recommendations for a bootloader
-====================================
+III - Recommendations for a bootloader
+======================================
 
 
 Here are some various ideas/recommendations that have been proposed
@@ -1151,7 +668,7 @@ while all this has been defined and implemented.
 
 
 
-VI - System-on-a-chip devices and nodes
+IV - System-on-a-chip devices and nodes
 =======================================
 
 Many companies are now starting to develop system-on-a-chip
@@ -1820,8 +1337,8 @@ platforms are moved over to use the flattened-device-tree model.
 
    More devices will be defined as this spec matures.
 
-VII - Specifying interrupt information for devices
-===================================================
+V - Specifying interrupt information for devices
+=================================================
 
 The device tree represents the busses and devices of a hardware
 system in a form similar to the physical bus topology of the
-- 
1.5.0.3
