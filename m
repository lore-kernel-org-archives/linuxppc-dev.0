Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-embedded@ozlabs.org,
	u-boot-users <u-boot-users@lists.sourceforge.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc64-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 01 Jun 2005 18:26:30 +1000
Message-Id: <1117614390.19020.24.camel@gaston>
Mime-Version: 1.0
Subject: Booting the linux-ppc64 kernel & flattened device tree v0.4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

DO NOT REPLY TO ALL LISTS PLEASE ! (and CC me on replies).

Here's the fourth version of my document along with new kernel patches
for the new improved flattened format, and the first release of the
device-tree "compiler" tool. The patches will be posted as a reply to
this email. The compiler, dtc, can be downloaded, the URL is in the
document.

---

           Booting the Linux/ppc64 kernel without Open Firmware
           ----------------------------------------------------


(c) 2005 Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.

   May 18, 2005: Rev 0.1 - Initial draft, no chapter III yet.

   May 19, 2005: Rev 0.2 - Add chapter III and bits & pieces here or
                           clarifies the fact that a lot of things are
                           optional, the kernel only requires a very
                           small device tree, though it is encouraged
                           to provide an as complete one as possible.
 
   May 24, 2005: Rev 0.3 - Precise that DT block has to be in RAM
			 - Misc fixes
			 - Define version 3 and new format version 16
			   for the DT block (version 16 needs kernel
			   patches, will be fwd separately).
			   String block now has a size, and full path
			   is replaced by unit name for more
			   compactness.
			   linux,phandle is made optional, only nodes
			   that are referenced by other nodes need it.
			   "name" property is now automatically
			   deduced from the unit name

   June 1, 2005: Rev 0.4 - Correct confusion between OF_DT_END and
                           OF_DT_END_NODE in structure definition.
                         - Change version 16 format to always align
                           property data to 4 bytes. Since tokens are
                           already aligned, that means no specific
                           required alignement between property size
                           and property data. The old style variable
                           alignment would make it impossible to do
                           "simple" insertion of properties using
                           memove (thanks Milton for
                           noticing). Updated kernel patch as well
			 - Correct a few more alignement constraints
			 - Add a chapter about the device-tree
                           compiler and the textural representation of
                           the tree that can be "compiled" by dtc.


 ToDo:

	- Add some definitions of interrupt tree (simple/complex)
	- Add some definitions for pci host bridges


I- Introduction
===============


During the recent developpements of the Linux/ppc64 kernel, and more
specifically, the addition of new platform types outside of the old
IBM pSeries/iSeries pair, it was decided to enforce some strict rules
regarding the kernel entry and bootloader <-> kernel interfaces, in
order to avoid the degeneration that has become the ppc32 kernel entry
point and the way a new platform should be added to the kernel. The
legacy iSeries platform breaks those rules as it predates this scheme,
but no new board support will be accepted in the main tree that
doesn't follows them properly.

The main requirement that will be defined in more details below is
the presence of a device-tree whose format is defined after Open
Firmware specification. However, in order to make life easier
to embedded board vendors, the kernel doesn't require the device-tree
to represent every device in the system and only requires some nodes
and properties to be present. This will be described in details in
section III, but, for example, the kernel does not require you to
create a node for every PCI device in the system. It is a requirement
to have a node for PCI host bridges in order to provide interrupt
routing informations and memory/IO ranges, among others. It is also
recommended to define nodes for on chip devices and other busses that
doesn't specifically fit in an existing OF specification, like on chip
devices, this creates a great flexibility in the way the kernel can
them probe those and match drivers to device, without having to hard
code all sorts of tables. It also makes it more flexible for board
vendors to do minor hardware upgrades without impacting significantly
the kernel code or cluttering it with special cases.
 

1) Entry point
--------------

   There is one and one single entry point to the kernel, at the start
   of the kernel image. That entry point support two calling
   conventions:

        a) Boot from Open Firmware. If your firmware is compatible
        with Open Firmware (IEEE 1275) or provides an OF compatible
        client interface API (support for "interpret" callback of
        forth words isn't required), you can enter the kernel with:

              r5 : OF callback pointer as defined by IEEE 1275
              bindings to powerpc. Only the 32 bits client interface
              is currently supported

              r3, r4 : address & lenght of an initrd if any or 0

              MMU is either on or off, the kernel will run the
              trampoline located in arch/ppc64/kernel/prom_init.c to
              extract the device-tree and other informations from open
              firmware and build a flattened device-tree as described
              in b). prom_init() will then re-enter the kernel using
              the second method. This trampoline code runs in the
              context of the firmware, which is supposed to handle all
              exceptions during that time.

        b) Direct entry with a flattened device-tree block. This entry
        point is called by a) after the OF trampoline and can also be
        called directly by a bootloader that does not support the Open
        Firmware client interface. It is also used by "kexec" to
        implement "hot" booting of a new kernel from a previous
        running one. This method is what I will describe in more
        details in this document, as method a) is simply standard Open
        Firmware, and thus should be implemented according to the
        various standard documents defining it and it's binding to the
        PowerPC platform. The entry point definition then becomes:

                r3 : physical pointer to the device-tree block
                (defined in chapter II) in RAM

                r4 : physical pointer to the kernel itself. This is
                used by the assembly code to properly disable the MMU
                in case you are entering the kernel with MMU enabled
                and a non-1:1 mapping.

                r5 : NULL (as to differenciate with method a)

        Note about SMP entry: Either your firmware puts your other
        CPUs in some sleep loop or spin loop in ROM where you can get
        them out via a soft reset or some other mean, in which case
        you don't need to care, or you'll have to enter the kernel
        with all CPUs. The way to do that with method b) will be
        described in a later revision of this document.


2) Board support
----------------

   Board supports (platforms) are not exclusive config options. An
   arbitrary set of board supports can be built in a single kernel
   image. The kernel will "known" what set of functions to use for a
   given platform based on the content of the device-tree. Thus, you
   should:

        a) add your platform support as a _boolean_ option in
        arch/ppc64/Kconfig, following the example of PPC_PSERIES,
        PPC_PMAC and PPC_MAPLE. The later is probably a good
        example of a board support to start from.

        b) create your main platform file as
        "arch/ppc64/kernel/myboard_setup.c" and add it to the Makefile
        under the condition of your CONFIG_ option. This file will
        define a structure of type "ppc_md" containing the various
        callbacks that the generic code will use to get to your
        platform specific code

        c) Add a reference to your "ppc_md" structure in the
        "machines" table in arch/ppc64/kernel/setup.c

        d) request and get assigned a platform number (see PLATFORM_*
        constants in include/asm-ppc64/processor.h

   I will describe later the boot process and various callbacks that
   your platform should implement.


II - The DT block format
===========================


This chapter defines the actual format of the flattened device-tree
passed to the kernel. The actual content of it and kernel requirements
are described later. You can find example of code manipulating that
format in various places, including arch/ppc64/kernel/prom_init.c
which will generate a flattened device-tree from the Open Firmware
representation, or the fs2dt utility which is part of the kexec tools
which will generate one from a filesystem representation. It is
expected that a bootloader like uboot provides a bit more support,
that will be discussed later as well.

Note: The block has to be in main memory. It has to be accessible in
both real mode and virtual mode with no other mapping than main
memory. If you are writing a simple flash bootloader, it should copy
the block to RAM before passing it to the kernel.


1) Header
---------

   The kernel is entered with r3 pointing to an area of memory that is
   roughtly described in include/asm-ppc64/prom.h by the structure
   boot_param_header:

struct boot_param_header
{
        u32     magic;                  /* magic word OF_DT_HEADER */
        u32     totalsize;              /* total size of DT block */
        u32     off_dt_struct;          /* offset to structure */
        u32     off_dt_strings;         /* offset to strings */
        u32     off_mem_rsvmap;         /* offset to memory reserve map */
        u32     version;                /* format version */
        u32     last_comp_version;      /* last compatible version */
        /* version 2 fields below */
        u32     boot_cpuid_phys;        /* Which physical CPU id we're
                                           booting on */
        /* version 3 fields below */
        u32     size_dt_strings;        /* size of the strings block */
};

   Along with the constants:

/* Definitions used by the flattened device tree */
#define OF_DT_HEADER            0xd00dfeed      /* 4: version, 4: total size */
#define OF_DT_BEGIN_NODE        0x1             /* Start node: full name */
#define OF_DT_END_NODE          0x2             /* End node */
#define OF_DT_PROP              0x3             /* Property: name off,
                                                   size, content */
#define OF_DT_END               0x9

   All values in this header are in big endian format, the various
   fields in this header are defined more precisely below. All
   "offsets" values are in bytes from the start of the header, that is
   from r3 value.

   - magic

     This is a magic value that "marks" the beginning of the
     device-tree block header. It contains the value 0xd00dfeed and is
     defined by the constant OF_DT_HEADER

   - totalsize

     This is the total size of the DT block including the header. The
     "DT" block should enclose all data structures defined in this
     chapter (who are pointed to by offsets in this header). That is,
     the device-tree structure, strings, and the memory reserve map.

   - off_dt_struct

     This is an offset from the beginning of the header to the start
     of the "structure" part the device tree. (see 2) device tree)

   - off_dt_strings

     This is an offset from the beginning of the header to the start
     of the "strings" part of the device-tree

   - off_mem_rsvmap

     This is an offset from the beginning of the header to the start
     of the reserved memory map. This map is a list of pairs of 64
     bits integers. Each pair is a physical address and a size. The
     list is terminated by an entry of size 0. This map provides the
     kernel with a list of physical memory areas that are "reserved"
     and thus not to be used for memory allocations, especially during
     early initialisation. The kernel needs to allocate memory during
     boot for things like un-flattening the device-tree, allocating an
     MMU hash table, etc... Those allocations must be done in such a
     way to avoid overriding critical things like, on Open Firmware
     capable machines, the RTAS instance, or on some pSeries, the TCE
     tables used for the iommu. Typically, the reserve map should
     contain _at least_ this DT block itself (header,total_size). If
     you are passing an initrd to the kernel, you should reserve it as
     well. You do not need to reserve the kernel image itself. The map
     should be 64 bits aligned. 

   - version

     This is the version of this structure. Version 1 stops
     here. Version 2 adds an additional field boot_cpuid_phys.
     Version 3 adds the size of the strings block, allowing the kernel
     to reallocate it easily at boot and free up the unused flattened
     structure after expansion.
     Version 16 introduces a new more "compact" format for the tree
     itself that is however not backward compatible.
     You should always generate a structure of the highest version defined
     at the time of your implementation. Currently that is version 16,
     unless you explicitely aim at being backward compatible

   - last_comp_version

     Last compatible version. This indicates down to what version of
     the DT block you are backward compatible with. For example,
     version 2 is backward compatible with version 1 (that is, a
     kernel build for version 1 will be able to boot with a version 2
     format). You should put a 1 in this field if you generate a
     device tree of version 1 to 3, or 0x10 if you generate a tree of
     version 0x10 using the new unit name format. 

   - boot_cpuid_phys

     This field only exist on version 2 headers. It indicate which
     physical CPU ID is calling the kernel entry point. This is used,
     among others, by kexec. If you are on an SMP system, this value
     should match the content of the "reg" property of the CPU node in
     the device-tree corresponding to the CPU calling the kernel entry
     point (see further chapters for more informations on the required
     device-tree contents)


   So the typical layout of a DT block (though the various parts don't
   need to be in that order) looks like (addresses go from top to bottom):


             ------------------------------    
       r3 -> |  struct boot_param_header  | 
             ------------------------------
             |      (alignment gap) (*)   |
             ------------------------------
             |      memory reserve map    |
             ------------------------------
             |      (alignment gap)       |
             ------------------------------
             |                            |
             |    device-tree structure   |
             |                            |
             ------------------------------
             |      (alignment gap)       |
             ------------------------------
             |                            |
             |     device-tree strings    |
             |                            |
      -----> ------------------------------
      |    
      |
      --- (r3 + totalsize)

  (*) The alignment gaps are not necessarily present, their presence
      and size are dependent on the various alignment requirements of
      the individual data blocks.


2) Device tree generalities
---------------------------

This device-tree itself is separated in two different blocks, a
structure block and a strings block. Both need to be aligned to a 4
bytes boundary.

First, let's quickly describe the device-tree concept before detailing
the storage format. This chapter does _not_ describe the detail of the
required types of nodes & properties for the kernel, this is done
later in chapter III.

The device-tree layout is strongly inherited from the definition of
the Open Firmware IEEE 1275 device-tree. It's basically a tree of
nodes, each node having two or more named properties. A property can
have a value or not.

It is a tree, so each node has one and only one parent except for the
root node who has no parent.

A node has 2 names. The actual node name is generally contained in a
property of type "name" in the node property list whose value is a
zero terminated string and is mandatory for version 1 to 3 of the
format definition (as it is in Open Firmware). Version 0x10 makes it
optional as it can generate it from the unit name defined below.

There is also a "unit name" that is used to differenciate nodes with
the same name at the same level, it is usually made of the node
name's, the "@" sign, and a "unit address", which definition is
specific to the bus type the node sits on.

The unit name doesn't exist as a property per-se but is included in the
device-tree structure. It is typically used to represent "path" in the
device-tree. More details about the actual format of these will be
below.

The kernel ppc64 generic code does not make any formal use of the unit
address (though some board support code may do) so the only real
requirement here for the unit address is to ensure uniqueness of
the node unit name at a given level of the tree. Nodes with no notion
of address and no possible sibling of the same name (like /memory or
/cpus) may ommit the unit address in the context of this
specification, or use the "@0" default unit address.
The unit name is used to define a node "full path", which is the
concatenation of all parent nodes unit names separated with "/".

The root node doesn't have a defined name, and isn't required to have
a name property either if you are using version 3 or earlier of the
format. It also has no unit address (no @ symbol followed by a unit
address). The root node unit name is thus an empty string. The full
path to the root node is "/"

Every node who actually represents an actual device (that is who isn't
only a virtual "container" for more nodes, like "/cpus" is) is also
required to have a "device_type" property indicating the type of node

Finally, every node that can be referrenced from a property in another
node is required to have a "linux,phandle" property. Real open
firmware implementations do provide a unique "phandle" value for every
node that the "prom_init()" trampoline code turns into
"linux,phandle" properties. However, this is made optional if the
flattened is used directly. An example of a node referencing another
node via "phandle" is when laying out the interrupt tree which will be
described in a further version of this document.

This propery is a 32 bits value that uniquely identify a node. You are
free to use whatever values or system of values, internal pointers, or
whatever to generate these, the only requirement is that every node
for which you provide that property has a unique value for it.

Here is an example of a simple device-tree. In this example, a "o"
designates a node followed by the node unit name. Properties are
presented with their name followed by their content. "content"
represent an ASCII string (zero terminated) value, while <content>
represent a 32 bits hexadecimal value. The various nodes in this
example will be discusse in a later chapter. At this point, it is
only meant to give you a idea of what a device-tree looks like. I have
on purpose kept the "name" and "linux,phandle" properties which aren't
necessary in order to give you a better idea of what the tree looks
like in practice.

  / o device-tree
      |- name = "device-tree"
      |- model = "MyBoardName"
      |- compatible = "MyBoardFamilyName"
      |- #address-cells = <2>
      |- #size-cells = <2>
      |- linux,phandle = <0>
      |
      o cpus
      | | - name = "cpus"
      | | - linux,phandle = <1>
      | | - #address-cells = <1>
      | | - #size-cells = <0>
      | |
      | o PowerPC,970@0
      |   |- name = "PowerPC,970"
      |   |- device_type = "cpu"
      |   |- reg = <0>
      |   |- clock-frequency = <5f5e1000>
      |   |- linux,boot-cpu
      |   |- linux,phandle = <2>
      |
      o memory@0
      | |- name = "memory"
      | |- device_type = "memory"
      | |- reg = <00000000 00000000 00000000 20000000>
      | |- linux,phandle = <3>
      |
      o chosen
        |- name = "chosen"
        |- bootargs = "root=/dev/sda2"
        |- linux,platform = <00000600>
        |- linux,phandle = <4>

This tree is almost a minimal tree. It pretty much contains the
minimal set of required nodes and properties to boot a linux kernel,
that is some basic model informations at the root, the CPUs, the
physical memory layout, and misc informations passed through /chosen
like in this example, the platform type (mandatory) and the kernel
command line arguments (optional).

The /cpus/PowerPC,970@0/linux,boot-cpu property is an example of a
property without a value. All other properties have a value. The
signification of the #address-cells and #size-cells properties will be
explained in chapter IV which defines precisely the required nodes and
properties and their content.


3) Device tree "structure" block

The structure of the device tree is a linearized tree structure. The
"OF_DT_BEGIN_NODE" token starts a new node, and the "OF_DT_END_NODE" ends
that node definition. Child nodes are simply defined before
"OF_DT_END_NODE" (that is nodes within the node). A 'token' is a 32
bits value. The tree has to be "finished" with a OF_DT_END token

Here's the basic structure of a single node:

     * token OF_DT_BEGIN_NODE (that is 0x00000001)
     * for version 1 to 3, this is the node full path as a zero
       terminated string, starting with "/". For version 16 and later,
       this is the node unit name only (or an empty string for the
       root node)
     * [align gap to next 4 bytes boundary]
     * for each property:
        * token OF_DT_PROP (that is 0x00000003)
        * 32 bits value of property value size in bytes (or 0 of no value)
        * 32 bits value of offset in string block of property name
        * property value data if any
        * [align gap to next 4 bytes boundary]
     * [child nodes if any]
     * token OF_DT_END_NODE (that is 0x00000002)

So the node content can be summmarised as a start token, a full path, a list of
properties, a list of child node and an end token. Every child node is
a full node structure itself as defined above

4) Device tree 'strings" block

In order to save space, property names, which are generally redundant,
are stored separately in the "strings" block. This block is simply the
whole bunch of zero terminated strings for all property names
concatenated together. The device-tree property definitions in the
structure block will contain offset values from the beginning of the
strings block.


III - Required content of the device tree
=========================================

WARNING: All "linux,*" properties defined in this document apply only
to a flattened device-tree. If your platform uses a real
implementation of Open Firmware or an implementation compatible with
the Open Firmware client interface, those properties will be created
by the trampoline code in the kernel's prom_init() file. For example,
that's where you'll have to add code to detect your board model and
set the platform number. However, when using the flatenned device-tree
entry point, there is no prom_init() pass, and thus you have to
provide those properties yourself.


1) Note about cells and address representation
----------------------------------------------

The general rule is documented in the various Open Firmware
documentations. If you chose to describe a bus with the device-tree
and there exist an OF bus binding, then you should follow the
specification. However, the kernel does not require every single
device or bus to be described by the device tree.

In general, the format of an address for a device is defined by the
parent bus type, based on the #address-cells and #size-cells property. In
absence of such a property, the parent's parent values are used,
etc... The kernel requires the root node to have those properties
defining addresses format for devices directly mapped on the processor
bus.

Those 2 properties define 'cells' for representing an address and a
size. A "cell" is a 32 bits number. For example, if both contain 2
like the example tree given above, then an address and a size are both
composed of 2 cells, that is a 64 bits number (cells are concatenated
and expected to be in big endian format). Another example is the way
Apple firmware define them, that is 2 cells for an address and one
cell for a size.

A device IO or MMIO areas on the bus are defined in the "reg"
property. The format of this property depends on the bus the device is
sitting on. Standard bus types define their "reg" properties format in
the various OF bindings for those bus types, you are free to define
your own "reg" format for proprietary busses or virtual busses
enclosing on-chip devices, though it is recommended that the parts of
the "reg" property containing addresses and sizes do respect the
defined #address-cells and #size-cells when those make sense.

Later, I will define more precisely some common address formats.

For a new ppc64 board, I recommend to use either the 2/2 format or
Apple's 2/1 format which is slightly more compact since sizes usually
fit in a single 32 bits word. 


2) Note about "compatible" properties
-------------------------------------

Those properties are optional, but recommended in devices and the root
node. The format of a "compatible" property is a list of concatenated
zero terminated strings. They allow a device to express it's
compatibility with a family of similar devices, in some cases,
allowing a single driver to match against several devices regardless
of their actual names

3) Note about "name" properties
-------------------------------

While earlier users of Open Firmware like OldWorld macintoshes tended
to use the actual device name for the "name" property, it's nowadays
considered a good practice to use a name that is closer to the device
class (often equal to device_type). For example, nowadays, ethernet
controllers are named "ethernet", an additional "model" property
defining precisely the chip type/model, and "compatible" property
defining the family in case a single driver can driver more than one
of these chips. The kernel however doesn't generally put any
restriction on the "name" property, it is simply considered good
practice to folow the standard and it's evolutions as closely as
possible.

Note also that the new format version 16 makes the "name" property
optional. If it's absent for a node, then the node's unit name is then
used to reconstruct the name. That is, the part of the unit name
before the "@" sign is used (or the entire unit name if no "@" sign
is present).

4) Note about node and property names and character set
-------------------------------------------------------

While open firmware provides more flexibe usage of 8859-1, this
specification enforces more strict rules. Nodes and properties should
be comprised only of ASCII characters 'a' to 'z', '0' to
'9', ',', '.', '_', '+', '#', '?', and '-'. Node names additionally
allow uppercase characters 'A' to 'Z' (property names should be
lowercase. The fact that vendors like Apple don't respect this rule is
irrelevant here).
Additionally, node and property names should always begin with a
character in the range 'a' to 'z' (or 'A' to 'Z' for node names).

The maximum number of characters for both nodes and property names
is 31. In the case of node names, this is only the leftmost part of
a unit name (the pure "name" property), it doesn't include the unit
address which can extend beyond that limit. 


5) Required nodes and properties
--------------------------------

  a) The root node

  The root node requires some properties to be present:

    - model : this is your board name/model
    - #address-cells : address representation for "root" devices
    - #size-cells: the size representation for "root" devices

  Additionally, some recommended properties are:

    - compatible : the board "family" generally finds its way here,
      for example, if you have 2 board models with a similar layout,
      that typically get driven by the same platform code in the
      kernel, you would use a different "model" property but put a
      value in "compatible". The kernel doesn't directly use that
      value (see /chosen/linux,platform for how the kernel choses a
      platform type) but it is generally useful.
   
  It's also generally where you add additional properties specific
  to your board like the serial number if any, that sort of thing. it
  is recommended that if you add any "custom" property whose name may
  clash with standard defined ones, you prefix them with your vendor
  name and a comma.
    
  b) The /cpus node

  This node is the parent of all individual CPUs nodes. It doesn't
  have any specific requirements, though it's generally good practice
  to have at least:

               #address-cells = <00000001>
               #size-cells    = <00000000>

  This defines that the "address" for a CPU is a single cell, and has
  no meaningful size. This is not necessary but the kernel will assume
  that format when reading the "reg" properties of a CPU node, see
  below

  c) The /cpus/* nodes

  So under /cpus, you are supposed to create a node for every CPU on
  the machine. There is no specific restriction on the name of the
  CPU, though It's common practice to call it PowerPC,<name>, for
  example, Apple uses PowerPC,G5 while IBM uses PowerPC,970FX.

  Required properties:

    - device_type : has to be "cpu"
    - reg : This is the physical cpu number, it's single 32 bits cell,
      this is also used as-is as the unit number for constructing the
      unit name in the full path, for example, with 2 CPUs, you would
      have the full path:
        /cpus/PowerPC,970FX@0
        /cpus/PowerPC,970FX@1
      (unit addresses do not require to have leading zero's)
    - d-cache-line-size : one cell, L1 data cache line size in bytes
    - i-cache-line-size : one cell, L1 instruction cache line size in bytes
    - d-cache-size : one cell, size of L1 data cache in bytes
    - i-cache-size : one cell, size of L1 instruction cache in bytes

  Recommended properties:

    - timebase-frequency : a cell indicating the frequency of the
      timebase in Hz. This is not directly used by the generic code,
      but you are welcome to copy/paste the pSeries code for setting
      the kernel timebase/decrementer calibration based on this value.      
    - clock-frequency : a cell indicating the CPU core clock frequency
      in Hz. A new property will be defined for 64 bits value, but if
      your frequency is < 4Ghz, one cell is enough. Here as well as
      for the above, the common code doesn't use that property, but
      you are welcome to re-use the pSeries or Maple one. A future
      kernel version might provide a common function for this.

  You are welcome to add any property you find relevant to your board,
  like some informations about mecanism used to soft-reset the CPUs
  for example (Apple puts the GPIO number for CPU soft reset lines in
  there as a "soft-reset" property as they start secondary CPUs by
  soft-resetting them).


  d) the /memory node(s)

  To define the physical memory layout of your board, you should
  create one or more memory node(s). You can either create a single
  node with all memory ranges in it's reg property, or you can create
  several nodes, as you wishes. The unit address (@ part) used for the
  full path is the address of the first range of memory defined by a
  given node. If you use a single memory node, this will typically be
  @0.

  Required properties:

    - device_type : has to be "memory"
    - reg : This property contain all the physical memory ranges of
      your board. It's a list of addresses/sizes concatenated
      together, the number of cell of those beeing defined by the
      #address-cells and #size-cells of the root node. For example,
      with both of these properties beeing 2 like in the example given
      earlier, a 970 based machine with 6Gb of RAM could typically
      have a "reg" property here that looks like:

      00000000 00000000 00000000 80000000
      00000001 00000000 00000001 00000000

      That is a range starting at 0 of 0x80000000 bytes and a range
      starting at 0x100000000 and of 0x100000000 bytes. You can see
      that there is no memory covering the IO hold between 2Gb and
      4Gb. Some vendors prefer splitting those ranges into smaller
      segments, the kernel doesn't care.

  c) The /chosen node

  This node is a bit "special". Normally, that's where open firmware
  puts some variable environment informations, like the arguments, or
  phandle pointers to nodes like the main interrupt controller, or the
  default input/output devices.

  This specification makes a few of these mandatory, but also defines
  some linux specific properties that would be normally constructed by the
  prom_init() trampoline when booting with an OF client interface, but
  that you have to provide yourself when using the flattened format.

  Required properties:

    - linux,platform : This is your platform number as assigned by the
      architecture maintainers
  
  Recommended properties:
  
    - bootargs : This zero terminated string is passed as the kernel
      command line
    - linux,stdout-path : This is the full path to your standard
      console device if any. Typically, if you have serial devices on
      your board, you may want to put the full path to the one set as
      the default console in the firmware here, for the kernel to pick
      it up as it's own default console. If you look at the funciton
      set_preferred_console() in arch/ppc64/kernel/setup.c, you'll see
      that the kernel tries to find out the default console and has
      knowledge of various types like 8250 serial ports. You may want
      to extend this function to add your own.
    - interrupt-controller : This is one cell containing a phandle
      value that matches the "linux,phandle" property of your main
      interrupt controller node. May be used for interrupt routing.



  This is all that is currently required. However, it is strongly
  recommended that you expose PCI host bridges as documented in the
  PCI binding to open firmware, and your interrupt tree as documented
  in OF interrupt tree specification.


IV - "dtc", the device tree compiler
====================================


dtc source code can be found at <http://ozlabs.org/~dgibson/dtc/dtc.tar.gz>

WARNING: This version is still in early developpement stage, the
resulting device-tree "blobs" have not yet been validated with the
kernel. The current generated bloc lacks a useful reserve map (it will
be fixed to generate an empty one, it's up to the bootloader to fill
it up) among others. The error handling needs work, bugs are lurking, etc...

dtc basically takes a device-tree in a given format and outputs a
device-tree in another format. The currently supported formats are:

  Input formats:
  -------------

     - "dtb": "blob" format, that is a flattened device-tree block with
        header all in a binary blob.
     - "dts": "source" format. This is a text file containing a
       "source" for a device-tree. The format is defined later in this
        chapter.
     - "fs" format. This is a representation equivalent to the
        output of /proc/device-tree, that is nodes are directories and
	properties are files

 Output formats:
 ---------------

     - "dtb": "blob" format
     - "dts": "source" format
     - "asm": assembly language file. This is a file that can be
       sourced by gas to generate a device-tree "blob". That file can
       then simply be added to your Makefile. Additionally, the
       assembly file exports some symbols that can be use

 
The syntax of the dtc tool is

    dtc [-I <input-format>] [-O <output-format>]
        [-o output-filename] [-V output_version] input_filename


The "output_version" defines what versio of the "blob" format will be
generated. Supported versions are 1,2,3 and 16. The default is
currently version 3 but that may change in the future to version 16.

Additionally, dtc performs various sanity checks on the tree, like the
uniqueness of linux,phandle properties, validity of strings, etc...

The format of the .dts "source" file is "C" like, supports C and C++
style commments.

/ {
}

The above is the "device-tree" definition. It's the only statement
supported currently at the toplevel.

/ {
  property1 = "string_value";	/* define a property containing a 0
                                 * terminated string
				 */
  
  property2 = <1234abcd>;	/* define a property containing a
                                 * numerical 32 bits value (hexadecimal)
				 */

  property3 = <12345678 12345678 deadbeef>;
                                /* define a property containing 3 numerical
                                 * 32 bits values (cells) in
                                 * hexadecimal
				 */
  property4 = [0a 0b 0c 0d de ea ad be ef];
                                /* define a property whose content is
                                 * an arbitrary array of bytes
                                 */

  childnode@addresss {		/* define a child node named "childnode"
                                 * whose unit name is "childnode@address"
                                 */

    childprop = "hello\n";      /* define a property "childprop" of
                                 * childnode (in this case, a string)
                                 */
  };
};

Nodes can contain other nodes etc... thus defining the hierarchical
structure of the tree.

Strings support common escape sequences from C: "\n", "\t", "\r",
"\(octal value)", "\x(hex value)".

It is also suggested that you pipe your source file through cpp (gcc
preprocessor) so you can use #include's, #define for constants, etc...

Finally, various options are planned but not yet implemented, like
automatic generation of phandles, labels (exported to the asm file so
you can point to a property content and change it easily from whatever
you link the device-tree with), label or path instead of numeric value
in some cells to "point" to a node (replaced by a phandle at compile
time), export of reserve map address to the asm file, ability to
specify reserve map content at compile time, etc...

We may provide a .h include file with common definitions of that
proves useful for some properties (like building PCI properties or
interrupt maps) though it may be better to add a notion of struct
definitions to the compiler...


V - Recommendation for a bootloader
===================================


Here are some various ideas/recommendations that have been proposed
while all this has been defined and implemented.


  - A very The bootloader may want to be able to use the device-tree
    itself and may want to manipulate it (to add/edit some properties,
    like physical memory size or kernel arguments). At this point, 2
    choices can be made. Either the bootloader works directly on the
    flattened format, or the bootloader has it's own internal tree
    representation with pointers (similar to the kernel one) and
    re-flattens the tree when booting the kernel. The former is a bit
    more difficult to edit/modify, the later requires probably a bit
    more code to handle the tree structure. Note that the structure
    format has been designed so it's relatively easy to "insert"
    properties or nodes or delete them by just memmovin'g things
    around. It contains no internal offsets or pointers for this purpose.

  - An example of code for iterating nodes & retreiving properties
    directly from the flattened tree format can be found in the kernel
    file arch/ppc64/kernel/prom.c, look at scan_flat_dt() function,
    it's usage in early_init_devtree(), and the corresponding various
    early_init_dt_scan_*() callbacks. That code can be re-used in a
    GPL bootloader, and as the author of that code, I would be happy
    do discuss possible free licencing to any vendor who wishes to
    integrate all or part of this code into a non-GPL bootloader.
