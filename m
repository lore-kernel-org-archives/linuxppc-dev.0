Date: Thu, 29 Nov 01 11:00:09 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111291900.AA00593@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_init_hwif_ports
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On the IDE issue, unfortunately the world is not perfect and I'm afraid we do
need some of the ugliness we have for IDE. One critter for which you need this
ugliness is the VT82C686B south bridge. It has two IDE interfaces like all
those PeeCee south bridges and from the PCI side shows up as one PCI IDE
device. For a number of good reasons I've made StarMON put it in PCI native
mode and map the IDE ports to floating PCI addresses.

The trouble begins with interrupts. Anybody who has used the VT82C686B in a
non-PeeCee design knows that its interrupt handling is wacky. The component has
one IDSEL pin, but puts a whopping 7 functions on it. Function 0 is the actual
south bridge, and all other functions are regular PCI devices "included for
free". Those regular PCI functions are supposed to signal regular PCI
interrupts. If they were separate components they would have INTA#, etc.
outputs. But remember that the VT82C686B was designed with the idea that it
would be *fielding* the INTA-D# interrupts, not generating them. It has these 4
pins as *inputs*, but non-PeeCee designs like ours simply don't use them (we
have our own interrupt controller for all regular PCI interrupts). But what do
the internal PCI functions do with their "PCI" interrupts? They do something
very novel. They took PCI config space register 3C (Interrupt Line) and gave it
a whole new meaning. While by the spec this register is for BIOS use only and
should have no effect on any hardware, the PCI functions inside the VT82C686B
use the contents of this register to route their interrupts to one of 16 IRQs
on the internal 8259 pair. Interrresting...

It gets even worse in function 1, PCI IDE. While the other internal PCI
functions (USB and audio) generate their interrupts themselves and then route
them in a novel way, the IDE function doesn't even generate its interrupts. The
IDE interrupts come straight from the IDE port connectors. And the kicker is,
the VT82C686B component does not have dedicated pins for the interrupts coming
from the IDE connectors! Instead they tell board designers to tie these lines
to IRQ 14 and IRQ 15 using the VT82C686B IRQ pins, the same ones that would go
to ISA slot connectors. This is what the Adirondack does, and the result is
that no matter what you do in the PCI domain, the primary IDE interrupt will
always come in as IRQ 14 and the secondary IDE interrupt will always come in as
IRQ 15.

How does this trouble Linux? Linux sees a PCI device with a PCI IDE class code
in PCI native mode. It assumes that it will signal a PCI interrupt, one for
both channels. It asks the PPC PCI interrupt routing code what that interrupt
is. But whatever number I return there, it will be wrong. If I return 14, the
primary channel will work, but not the secondary channel. Bummer.

I couldn't find any way to tell the PCI IDE code that a certain PCI IDE device
is to be treated specially in that it has different IRQs for the two channels.
The only way I could find is to have my setup_arch or some other early code
read the VT82C686B function 1 BARs to find out the on-board IDE addresses
(remember, StarMON puts it in PCI native mode and maps them to floating PCI
addresses), have ppc_ide_md.default_io_base report these addresses as standard
ports 0 and 1, and have ppc_ide_md.ide_init_hwif know about these two magic
addresses and their associated IRQs. So I'm afraid we'll have to keep this
ugliness.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
