From: Michel Lanners <mlan@mcp.cpu.lu>
Message-Id: <200003031001.LAA20181@mcp.cpu.lu>
Subject: Re: Need reports about PCI I/O conflicts
To: tas@mindspring.com (Timothy A. Seufert)
Date: Fri, 03 Mar 2000 11:01:44 MET
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04220800b4e5212c2027@[10.0.0.42]>; from "Timothy A. Seufert" at Mar 3, 100 12:39 (midnight)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

[snip]
> >It does this by writing 0 in the io space register, but
> >doesn't disable IO accesses to the card in the PCI config header (or
> >maybe they get re-enabled by the kernel fixup code).
>
> I think the fixup code is re-enabling it if it can:
>
>    PCI: setting IRQ 24 on device 01:18.
>    PCI: Correcting IOaddress 0 on device 01:18, now fe000001.
>    PCI: Enabling I/O for device 01:18
>    PCI: setting IRQ 25 on device 01:20.
>    PCI: Correcting IOaddress 0 on device 01:20, now fe000001.
>    PCI: Correcting IOaddress 0 on device 01:21, now fe000001.

Clearly, this is not the right way to proceed, I guess that all IO
regions above were set at 0 (which means disabled, right?), so they
get set all on the same translation.

> I remember looking at the code which enables I/O for a device, but it
> wasn't clear to me at that time how it decided whether to enable I/O.

At this time, simply by looking whether a BAR is marked as IO space (bit
0 set, IIRC). Obviously, there should be other sanity checks, the first
of which being to see whether the configured address falls within the
expected range (0 < BAR < [io-space size]).

If anyone wants to add that, please go ahead; but keep in mind that the
io-space size depends on the parent bridge.

> By the way, Doug, can you comment on whether the 39160 should get one
> or two IRQs?  I/O and memory base registers are clearly not shared
> between the channels, but according to these boot messages, only one
> channel gets assigned an IRQ.  (I've confirmed this with lspci.)

On Macs (at least all those I could read doc of), all PCI IRQs are or'ed
together per physical slot. Therefore, multiple devices or functions on
a single card will all get the same IRQ. Whether the PCI code really gets
this right is a different matter.

Michel
__________________________________-
.sig at home

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
