Subject: Re: multiple separate pci bridges ...
From: Marcus Barrow <mbarrow@sangate.com>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Date: 06 Jan 2004 16:09:03 -0500
Message-Id: <1073423344.5358.160.camel@boat.sangate.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


oops, sorry i sent wrong note previously...

        I enabled the debugging option in drivers/pci.c and rebooted.
        Here is the pertinent output. As you can see, the two pci busses
        have different bus numbers (in dev->bus->number ).

        We use a modified version of the Marvell eval. board code. It
        doesn't seem to have been changed for some time now. Perhaps you
        need to look at your "agp ops"? Is this helpfull?

PCI: Probing PCI hardware
Scanning bus 00
Found 00:60 [8086/1008] 000200 00
Fixups for bus 00
Bus scan for 00 returning with max=00
Scanning bus 01
Found 01:38 [1077/2312] 000c04 00
Found 01:39 [1077/2312] 000c04 00
Fixups for bus 01
Bus scan for 01 returning with max=01

Ben writes>
           >Argh ????? They don't appear on PCI ? What piece of SHIT is
           >this bridge ?

           >Really totally insane.


        Would you care to rethink those comments?

        It seems unfair to call a chip shit, when you don't have
        a manual for it and appear to lack any knowledge of it's
        internals. Do the math for 3 GigE ports running line speed with
        64 byte packets, and full bandwidth on 2 PCI busses...

SVEN writes>

        >Well, the Discovery II use a internal crossbar switch, and the
        >ethernet are on the same level as the pci buses. This makes for
        >very efficient networking i guess, but has problems. In fact,
        >each of these ones has the same priority as each pci bus.

        Each of the ports of the crossbar has a programmable arbiter.
        (at least on Discovery, which is what we use.)

On Thu, 2004-01-01 at 13:11, Sven Luther wrote:
>
> I am currently trying to port linux to the Pegasos 2, which uses the
> Marvell Discovery 2 chip, and has two independent pci controllers,
> of which one is faked as an agp bus. This is with a modified 2.4.23
> kernel from the linuxppc_2_4 branch.
>
> Anyway, these two independent controllers both have one bus 0 on them:
>
> PCI bus 0 controlled by pci at 80000000
> PCI bus 0 controlled by pci at c0000000
>
> (This coming from chrp_find_bridges).
>
> For the pci bus, at 80000000, a simple indirect access can be used,
> and i setup a specialized io ops for the faked agp bus since it needs
> special care.
>
> Later, in pcibios_init, there is a problem in the pci_scan_bus. The
> first bus has no problems :
>
> Scanning bus 00
> Found 00:00 [11ab/6460] 000600 00
> Found 00:08 [1106/3044] 000c00 00
> Found 00:28 [1000/0001] 000100 00
> Found 00:60 [1106/8231] 000601 00
> Found 00:61 [1106/0571] 000101 00
> Found 00:62 [1106/3038] 000c03 00
> Found 00:63 [1106/3038] 000c03 00
> Found 00:64 [1106/8235] 000000 00
> Found 00:65 [1106/3058] 000401 00
> Found 00:66 [1106/3068] 000780 00
> Found 00:68 [1106/3065] 000200 00
> Fixups for bus 00
> Bus scan for 00 returning with max=00
>
> But the second fails with :
>
> PCI: Bus 00 already known
>
> Which comes because in drivers/pci/pci.c:pci_bus_exists does handle
> only buses, and thus know nothing of separate pci bridges with the
> same bus number, and thus the kernel dies when accessing bus->xxx
> something in pcibios_init.
>
> Now, i know that the powermacs in particular, and maybe others, also
> have this case of different same numbered pci buses with different
> base addresses, and that this kind of situation has already been
> solved.
>
> So, what is the workaround here, and where does it get set.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
