Date: Fri, 2 Jan 2004 08:40:49 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040102074049.GA2032@iliana>
References: <20040101181145.GA27294@iliana> <1073016223.1502.179.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1073016223.1502.179.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Happy new year to you.

On Fri, Jan 02, 2004 at 03:03:43PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2004-01-02 at 05:11, Sven Luther wrote:
> >
> > I am currently trying to port linux to the Pegasos 2, which uses the
> > Marvell Discovery 2 chip, and has two independent pci controllers,
> > of which one is faked as an agp bus. This is with a modified 2.4.23
> > kernel from the linuxppc_2_4 branch.
>
> Why "faked" ? It's actually fairly sane to have the AGP bus be a
> separate PCI host controller... That's how it's done on pmacs.

There is some extra magic that needs to be done. In particular
interrupts need to be disabled before being able to write to the config
space of the agp bridge.

> > Anyway, these two independent controllers both have one bus 0 on
> > them :
> >
> > PCI bus 0 controlled by pci at 80000000
> > PCI bus 0 controlled by pci at c0000000
> >
> > (This coming from chrp_find_bridges).
>
> Typical junk, Apple does the same. You want PCI domains or bus
> renumbering. No PCI domains in 2.4 though, so you want bus
> renumbering.

Yeah.

> Look at what pmac_pci.c does for uninorth which has 3 root busses
> whose firmware bus numbers all start at 0

Ok, thanks.

> > For the pci bus, at 80000000, a simple indirect access can be used,
> > and i setup a specialized io ops for the faked agp bus since it
> > needs special care.
>
> What do you mean ? config ops ? You can have different ops per host,
> again, look at what pmac_pci.c does

Yep, that i did already. And that is what i did, i used the indirect pci
ops for the first bus, but specialized stuff for the second bus, due to
the above mentioned stuff.

> > Later, in pcibios_init, there is a problem in the pci_scan_bus. The
> > first bus has no problems :
> >
> > Scanning bus 00
> > Found 00:00 [11ab/6460] 000600 00
> > Found 00:08 [1106/3044] 000c00 00
> > Found 00:28 [1000/0001] 000100 00
> > Found 00:60 [1106/8231] 000601 00
> > Found 00:61 [1106/0571] 000101 00
> > Found 00:62 [1106/3038] 000c03 00
> > Found 00:63 [1106/3038] 000c03 00
> > Found 00:64 [1106/8235] 000000 00
> > Found 00:65 [1106/3058] 000401 00
> > Found 00:66 [1106/3068] 000780 00
> > Found 00:68 [1106/3065] 000200 00
> > Fixups for bus 00
> > Bus scan for 00 returning with max=00
> >
> > But the second fails with :
> >
> > PCI: Bus 00 already known
> >
> > Which comes because in drivers/pci/pci.c:pci_bus_exists does handle
> > only buses, and thus know nothing of separate pci bridges with the
> > same bus number, and thus the kernel dies when accessing bus->xxx
> > something in pcibios_init.
>
> Yes, in 2.4, you need to do some renumbering.

Ok.

> > Now, i know that the powermacs in particular, and maybe others, also
> > have this case of different same numbered pci buses with different
> > base addresses, and that this kind of situation has already been
> > solved.
> >
> > So, what is the workaround here, and where does it get set.
>
> Basically, you do the bus numbering yourself. You never care about the
> number of the "root" bus since you basically just send type 0 config
> cycles to it, but you do care about bus numbers in PCI<->PCI bridges.

Mmm, since these are two CPU<->PCI bridges, i don't care about that,
right. PCI<->PCI bridges are ones which stand behind a PCI<->PCI bridge,
right ?

> You trigger the proper renumbering code by setting
> pci_assign_all_busses to 1.

Ok. This must have been the magic bit i was searching for.

> So basically, what we do is, we keep a "next_busno" variable which is
> 0 at first. When probing a host, we assign it that bus number (0 for
> the first host typically). Then, we call pci_scan_bus(). This one will
> do the renumbering for P2P bridges when pci_assign_all_busses is true.
> It will also tell us what was the "last" bus number found on the host.
> We use that+1 to get the new next_busno and start again for the next
> host.

Ok. Need to look again though to find the place where the arch specific
place is to modify this. As i remember, pci_scan_bus is called from
drivers/pci/pci.c, and i shouldn't need to modify this.

> On your side, you don't have much else to do that set
> pci_assign_all_busses to 1, and create 2 pci_controller structures
> with different config cycle ops.

Yep. I guess the pci_assign_all_busses can be set in chrp_find_bridges,
in the pegasos2 special case. The rest i have already handled.

> Note that in 2.4, there is a small risk when doing bus renumbering
> with PCI-PCI bridges that you can get temporarily overlapping bus
> numbers during the probe, thus screwing it up. this typically happens
> on

Not a problem in this case though, right ? There is only one bus for
each controller, and the controller are sitting directly after the CPU.

> Xserves. The problem is when scanning a given segment with P2P
> bridges, when old & new numbers overlap, a not-yet scanned bridge
> may be set to the same number as one we are currently scanning after
> having renumbered

Ok, do we need to detect this, or will it just fail or something ?

> it, thus screwing things up. I think 2.6 is protected against this
> problem. For 2.4, what I do is hack to force a 0x10 bus number offset
> between hosts.

Mmm. Will look into that.

Anyway, i will not be able to implement it until sunday at the earliest.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
