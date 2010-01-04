Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D73BB6F04
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jan 2010 16:56:09 +1100 (EST)
Subject: Re: PCI-PCI bridge scanning broken on 460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix Radensky <felix@embedded-sol.com>
In-Reply-To: <4B388D9D.7010404@embedded-sol.com>
References: <4B388D9D.7010404@embedded-sol.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Jan 2010 16:55:39 +1100
Message-ID: <1262584539.2173.335.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-12-28 at 12:51 +0200, Felix Radensky wrote:
> Hi,
> 
> I'm running linux-2.6.33-rc2 on Canyonlands board. When PLX 6254 
> transparent PCI-PCI
> bridge is plugged into PCI slot the kernel simply resets the board 
> without printing anything
> to console. Without PLX bridge kernel boots fine.

Sorry for the late reply...

> I've tracked down the problem to the following code in pci_scan_bridge() 
> in drivers/pci/probe.c:
> 
> if (pcibios_assign_all_busses() || broken)
>                 /* Temporarily disable forwarding of the
>                    configuration cycles on all bridges in
>                    this bus segment to avoid possible
>                    conflicts in the second pass between two
>                    bridges programmed with overlapping
>                    bus ranges. */
>                 pci_write_config_dword(dev, PCI_PRIMARY_BUS,
>                                buses & ~0xffffff);
> 
> If test for broken is removed, kernel boots fine, detects the bridge, but
> does not detect the device behind the bridge. The same device plugged
> directly into PCI slot is detected correctly.

So we would have a similar mismatch between the initial setup and the
kernel...  However, I don't quite see yet why the kernel trying to fix
it up breaks things, that will need a bit more debugging here...

Can you give it a quick try with adding something like :

 ppc_pci_add_flags(PPC_PCI_REASSIGN_ALL_BUS);

Near the end of ppc4xx_pci.c ? It looks like another case of reset
not actually resetting bridges (are we not properly doing a fundamental
reset ? Stefan what's your take there ?)

The above will cause busses to be re-assigned which is risky because it
will allow the kernel to assign numbers beyond the limits of what
ppc4xx_pci.c supports (see my comments in the thread you quotes).

The good thing is that we now have a working fixmap infrastructure, so
we could/should just move ppc4xx_pci.c to use that, and just always
re-assign busses.

> To remind you, tests for broken were added by commit 
> a1c19894b786f10c76ac40e93c6b5d70c9b946d2,
> and were intended to solve device detection problem behind PCI-E 
> switches, as discussed in this thread:
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2008-October/063939.html

> PCI: Probing PCI hardware
> pci_bus 0000:00: scanning bus
> pci 0000:00:06.0: found [3388:0020] class 000604 header type 01
> pci 0000:00:06.0: supports D1 D2
> pci 0000:00:06.0: PME# supported from D0 D1 D2 D3hot
> pci 0000:00:06.0: PME# disabled
> pci_bus 0000:00: fixups for bus
> pci 0000:00:06.0: scanning behind bridge, config 000000, pass 0
> pci 0000:00:06.0: bus configuration invalid, reconfiguring

Ok so we hit a P2P bridge whose primary, secondary and subordinate bus
numbers are all 0, which is clearly unconfigured. I think this is the
root complex bridge

> pci 0000:00:06.0: scanning behind bridge, config 000000, pass 1

Now this is when the bus should be reconfigured (pass 1). Sadly the code
doesn't print much debug.

Also from that point, it should renumber things and work... 

> pci_bus 0000:01: scanning bus

Which it does to some extent. It assigned bus number 1 to it afaik so we
now start looking below the RC bridge:

> pci 0000:01:06.0: found [3388:0020] class 000604 header type 01

Hrm... class PCI bridge, vendor 3388 device 0020, is that your PLX ?
It's not the right vendor ID but maybe that's configurable by our OEM or
something...

> pci 0000:01:06.0: supports D1 D2
> pci 0000:01:06.0: PME# supported from D0 D1 D2 D3hot
> pci 0000:01:06.0: PME# disabled
> pci_bus 0000:01: fixups for bus
> pci 0000:00:06.0: PCI bridge to [bus 01-ff]
> pci 0000:00:06.0:   bridge window [io  0x0000-0x0fff]
> pci 0000:00:06.0:   bridge window [mem 0x00000000-0x000fffff]
> pci 0000:00:06.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> pci 0000:01:06.0: scanning behind bridge, config ff0100, pass 0

Allright, that's where it gets interesting. It tries to scan behind the
bridge. It gets something it doesn't like. IE, it gets a secondary bus
number of 1 (what the heck ? I wonder what your firmware does) which
Linux is not happy about and decides to renumber it.

> pci 0000:01:06.0: bus configuration invalid, reconfiguring

Now, that's where Linux should have written 000000 to the register,
which is what you commented out.

> pci 0000:01:06.0: scanning behind bridge, config ff0100, pass 1
> pci_bus 0000:01: bus scan returning with max=01
> pci_bus 0000:00: bus scan returning with max=01

Because of that commenting out, it doesn't see the config as 000000 and
thus doesn't re-assign a bus number in pass 1, so from there you can't
see what's behind the bus.

So we have two things here:

 - It seems like the writing of 000000 to the register in pass 0 is
causing your crash. Can you verify that ? IE. Can you verify that it's
indeed crashing on this specific statement:

pci_write_config_dword(dev, PCI_PRIMARY_BUS,
                               buses & ~0xffffff);

When writing to the bridge, and that this seems to be causing a hard
reboot of the system ?

It might be useful to ask AMCC how that is possible in HW, ie what kind
of signal can be causing that. IE, even if the bridge is causing a PCIe
error, that should not cause a reboot ... right ?

 - You can test a quick hack workaround which consists of changing:

	/* Check if setup is sensible at all */
-	if (!pass &&
-	if (1 &&
	    ((buses & 0xff) != bus->number || ((buses >> 8) & 0xff) <= bus->number)) {
		dev_dbg(&dev->dev, "bus configuration invalid, reconfiguring\n");
		broken = 1;
	}

In -addition- to your commenting out of the broken test. This will cause the
second pass to go through the re-assign code path despite the fact that you
have not written 000000 to the bus numbers.

Cheers,
Ben.
