Mime-Version: 1.0
Message-Id: <p04330100b650e03a5dcb@[192.168.0.1]>
In-Reply-To: <Pine.GSO.4.10.10012032140410.7958-100000@rose.sonytel.be>
References: <Pine.GSO.4.10.10012032140410.7958-100000@rose.sonytel.be>
Date: Mon, 4 Dec 2000 01:09:49 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: arguing IRQ (was Re: dual IRQ 23)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[I apologize in advance to Geert, Michel, and Ben if I have
misrepresented their previous statements below - I'm trying to figure
this out still]


Geert said:

>Shared interrupts are allowed by PCI. If it doesn't work, it means one of the
>drivers (or both) can't cope with shared interrupts. The solution is
>to fix the driver(s).

However, another consensus seems to be available, as per Michel Lanners:

>01:0c.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00cd
>(rev 01) (prog-if 10 [OHCI])
>[snip]
>  Interrupt: pin A routed to IRQ 1
>This is most certainly wrong -> ^
>
>01:0d.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
>[snip]
>  Interrupt: pin A routed to IRQ 23
>                  and this too ->^^
>
>Bot of these devices should get IRQ25. Why? Because on Macs, all four
>IRQ lines of a PCI slot are OR'ed together on the bridge chip.
>Therefore, there is one single fixed IRQ per PCI slot. So, the devices
>behind the PCI-to-PCI bridge in slot 00:0f should all have the same IRQ,
>which should be, following the obvious logic, IRQ 25.
>
>Either a problem with the P2P bridge code in Linux, or with detecting
>the IRQ's out of OF, as Ben suggested.

It seems to me that both should have the same interrupt, as Michel
states - after all, they are on the same PCI card; however, the
larger issue is whether neither should be 23, because 23 is already
assigned:

>00:0d.0 SCSI storage controller: Adaptec AIC-7881U
>[snip]
>  Interrupt: pin A routed to IRQ 23


Indeed, Ben has said along these lines:

>Ok, I found the problem, I think, with the interrupt. I'm still
>investigating, but what it looks like is that the OF tree puts the
>AAPL,interrupt property in the pci-bridge node, not in the sub-nodes.
>So we must make sure the routine that gets interrupts from the tree
>on oldworld iterates to parent devices when it can't find the
>AAPL,interrupt property.


Which again indicates that the problem is in the PCI (?) code.

So, is Geert right (PCI ok at least in this aspect, drivers are
buggy)? Or are Ben/Michel right (drivers OK, PCI/IRQ buggy)?



Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
