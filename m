From: Benjamin Herrenschmidt <bh40@calva.net>
To: <linuxppc-dev@lists.linuxppc.org>,
        Geert Uytterhoeven
 <geert@linux-m68k.org>,
        Paul Mackerras <paulus@linuxcare.com.au>, <cort@hq.fsmlabs.com>
Subject: PCI rework & CHRP question
Date: Sun, 24 Sep 2000 00:57:30 +0200
Message-Id: <19340818162914.6020@192.168.1.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm working on a rework of our arch/pci.c (to properly handle multiple
host bridges, and various other cleanups).

In the chrp_pci.c code, I found this code:

        if ( !strncmp("MOT",
                      get_property(find_path_device("/"), "model", NULL),3) )
        {
                pci_dram_offset = 0;
                isa_mem_base = 0xf7000000;
                isa_io_base = 0xfe000000;
                set_config_access_method(grackle);
        }

However, I found no way in the Grackle documentation to have isa_mem_base
at 0xf7000000. AFAIK, it's at 0xfd000000

Also, the grackle access method expect a PCI bridge structure configured
with the ioremap'ed config space registers, which is not the case on
chrp. (They are defined only in pmac_pci.c).

I'm fixing those along with my changes. I suppose Grackle on CHRP uses
memory map B ?

Note (tell me if it's a problem), that I'm removing the various
xxx_setup_pci_ptrs(). Each host bridge has a pci_controler structure (the
old bridge_data) that contains also the function pointers to the access
methods. Archs now call whatever xxx_find_bridges from their
xxx_setup_arch() function and all host-bridge dependent setup is done there.

I will push those changes in the new linuxppc_2_5 bk tree as soon as I'm
happy with them.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
