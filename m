From: Benjamin Herrenschmidt <bh40@calva.net>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Cc: <paulus@linuxcare.com.au>, <cort@fsmlabs.com>, <tom_gall@vnet.ibm.com>
Subject: PPC PCI changes
Date: Sun, 24 Sep 2000 18:02:45 +0200
Message-Id: <19340819093429.2535@192.168.1.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've pushed some PPC PCI changes to the linuxppc_2_5 bitkeeper tree.
(This tree also contains my IRQ changes and my SMP changes).

I'd like those changes to be validated now since I'd like to see them in
2.4 as soon as possible.

I've tested on a couple of UniNorth-based PowerMacs. I need more tests on
other machines. I've tried not to break CHRP, PReP and Gemini, but I
couldn't test on them.

The IRQ & SMP changes should not cause any special trouble to other
machines and should not need any special change other than a few irq
controller stuffs that I hope I fixed correctly already.

The PCI changes are meant to better support several host bridges (and
eventually several different bridges on pmac), cleanup & fix various OF<-
>PCI relationchip & fixups, allow bus renumbering for bad firmware setup
(like pmac with UniNorth), and other cleanups.
I've not yet split the OF & boot text stuffs out of prom.c, this is for
later 2_5.

Note: This is only the first step. Next may be to change the IO base
mecanism (if we want to do that), and to have per-host resource
structures. But I want this version to be validated before going further.

 - xxx_setup_pci_ptrs() are gone. Each machine is supposed, at the
beginning of it's xxx_setup_arch(), to setup the host bridges, usually by
calling an xxx_find_bridges() function implemented in xxx_pci.c

 - This function should call pcibios_alloc_controller() to get a
controller structure for each of the host bridges. In this structure, the
important fields are:

   * ops : (a pointer to the config access routines for this host)
   * arch_data : for OF machines, this should be the OF node of the host
     bridge. (Important for PCI<->OF matching)
   * first_busno, last_busno : Range of bus numbers handled by this host
     bridge. If you set pci_assign_all_busses variable to 1, then you don't
     need to fill them.

The two fields below could be omitted, preventing the pci_bus_io_base(),
pci_bus_mem_base() functions and the sys_pciconfig_iobase() syscall from
working.

   * io_base_phys,io_base_virt : The IO bus of this host
   * mem_base : the physical memory offset for PCI memory space

The remainig fields may or may not be used depending on what you have in
your "ops".

The common PCI will scan all busses of all controllers.

I've adapted the UniNorth code to declare 3 controllers (tested) and the
Bandit to declare 2 (chaos is also implemented as an empty stub for now).
I did some quick fixes to gemini, chrp and prep for them to compile (and
eventually work if I didn't mess things up) but they probably would
benefit of some cleanup in the host bridge probe code. (see how I did it
on pmac).

You can set pci_assign_all_busses to 1 in your bridge probe routine. This
will tell the PCI layer to assign (or re-assign) all bus numbers. Useful
if you have a weird firmware.

A side effect is that the bus numbers in Linux will no longer match the
bus numbers in OF if this feature is used.
To work around this, the PCI layer builds a map of PCI to OF bus numbers
after the bus probe in the pci_to_OF_bus_map variable. This map is also
exported to userland via an additional property at the root of /proc/
device-tree.
The new pci_device_from_OF_node() and pci_device_to_OF_node() functions
will use this map, so they still work.
However, the RTAS PCI config code was not updated since it's used
_before_ the map is built. Fortunately, it's used on machines where
pci_assign_all_busses is not set.

Some CHRP have several host bridges. I didn't update that specific code
to create additional pci_controler structures. This should be done by
moving the code out of the bus fixups to the chrp_find_bridges() routine.
IBM have been working on doing that recently using the old bridge-data
structure. Adapting their work to the new code should be easy.

If you want to issue PCI config cycles before the PCI layer is inited,
you can use pci_bus_to_hose() to get the hose and access directly it's
ops, provided that bus numbers are ok.
If they are not (UniNorth and it's 3 bus 0), and you know the OF node of
the device you want to access, then you can use
pci_find_hose_for_OF_device() which will try to find the hose by walking
the OF tree.

Ok, that's all, waiting for feedback now ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
