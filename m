Date: Tue, 7 Mar 2000 14:40:58 -0600
From: Grant Erickson <grant@borg.umn.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Grabbing an Interrupt for a Brain-dead PCI Device
In-Reply-To: <Pine.GSO.4.10.10003061202100.23760-100000@dandelion.sonytel.be>
Message-ID: <Pine.SGI.4.21.0003071435240.45384-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


So, unfortunately, I didn't do the design for this "dumb" PCI device and
neither can I fix its shortcomings in these regards.

Below, we've acknowledged and discovered how to sort of work-around the
problem of the invalid vendor ID and the base address. Now, I've yet
another problem.

The device has an interrupt at INTA#. Unfortunately, the device being dumb
as it is, doesn't utilize the interrupt pin register to advertise that it
does in fact have an interrupt there. So, I assume that once again, the
PROM doesn't give it one.

Is there a way, in Linux, for me to programmatically and manually assign
an interrupt to this device as might have been done in the PROM? I'm
guessing I have to twiddle some registers in the North Bridge, correct?

Thanks,

Grant


On Mon, 6 Mar 2000, Geert Uytterhoeven wrote:
> On Sun, 5 Mar 2000, Grant Erickson wrote:
> > After modifying the Linux kernel to accept PCI devices with the invalid
> > vendor/device ID combination of 0xffff/0x0000, I noticed something odd
> > about the way the system PROM (and to a lesser extent Linux) configured
> > the chip's base addresses. Looking at a number of other devices in the
> > system:
> >
> >         grant@marathon% cat /proc/iomem
> >         81800000-8180001f : PCI device 1022:2000 AMD Lance Ethernet
> >         81900000-819fffff : PCI device 1022:2000 AMD Lance Ethernet
> >         82000000-82ffffff : PCI device 1002:4754 ATI Mach 128
> >         f3000000-f307ffff : PCI device 106b:0010 Apple Heathrow I/O
> >         fffc0000-ffffffff : PCI device ffff:0000 ???
> >
> > Clue 1: The address range programmed for the chip looks suspiciously like
> > the state it might be left in after determining how much address space it
> > needs.
>
> Yes.
>
> > Before Linux does this address space sizing, it saves the base address.
> > In the case of my chip, it would have read "0x0" since nothing was
> > programmed there previously. If Linux does find 0x0, it just leaves the
> > result of the address sizing there and moves on.
> >
> > So, that led me to wonder where the addresses in the other devices were
> > coming from...
> >
> > I found that even before Linux executes a single line of code, all the
> > other devices above have valid addresses programmed into their base
> > address registers. Who's doing this?
> >
> > I believe that the Open Firmware PROM in the PowerPC system probes all
> > PCI devices in the system at power up. It then assigns valid base
> > addresses to those devices with VALID vendor and device IDs.
>
> OF (should) assign addresses. On my box (CHRP), it does so for _recognized_
> devices only.
>
> > Because my chip uses an invalid vendor ID of 0xFFFF, Open Firmware must
> > just ignore it and never programs in a valid base address! Therefore,
> > when we go and try to access the chip at 0xFFFC0000 (which is outside the
> > valid PCI address space on PReP/CHRP/PowerMac systems?) we're off probing
> > never-never land. The PCI controller never assumes the transaction!
>
> How difficult is it to make the PCI chip use a valid vendor/device ID? I don't
> think you can assume any boot ROM will try to assign a region to it. There's no
> way to distinguish a device with an invalid vendor/device ID from a device
> that's not even present.
>
> Go read the PCI spec and use valid IDs.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
