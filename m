Date: Wed, 29 Mar 2000 22:05:49 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>, Gabriel Paubert <paubert@iram.es>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.GSO.4.10.10003271235360.11532-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.05.10003292157410.28211-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


FYI, I played some more with PCI resources on the MIPS (to be applied to my
LongTrail in the near future :-)

You can specify from which region resources are allocated by doing this

  - create a `pci mem' resource with start and end corresponding to the PCI
    memory space region that is provided by your host bridge
  - call request_resource(&iomem_resource, &my_pci_mem_resource);
  - change bus->resource[1] = &my_pci_mem_resource in your machine specific
    pcibios_fixup_bus()

After this, all resources will be allocated from the `parent' PCI mem resource,
which is my_pci_mem_resource now (by default (drivers/pci/pci.c),
bus->resource[1] points to iomem_resource).

Result for the MIPS, where _all_ resources must be assigned by calling
pci_assign_unassigned_resources() afterwards:

    root # cat /proc/iomem
 *  00000000-03ffffff : RAM
 *  04000000-043fffff : Flash ROM
 *  06000000-060fffff : Nile4 ISA I/O
 *  06100000-07ffffff : Nile4 PCI I/O
 *  08000000-08ffffff : Nile4 ISA mem
 *  09000000-0fffffff : Nile4 PCI mem
      09000000-0900007f : Digital Equipment Corporation DECchip 21140 [Fa
      09001000-09001fff : Acer Laboratories Inc. [ALi] M5237 USB
      09040000-0907ffff : Digital Equipment Corporation DECchip 21140 [Fa
 *  1fa00000-1fbfffff : Nile4 ctrl
 *  1fc00000-1fffffff : Boot ROM
    root #

All resources marked with `*' were manually requested before calling
pci_scan_bus(), but only `Nile4 PCI mem' matters here.

The example considers PCI memory space only. PCI I/O space is left as an
exercise for the reader :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
