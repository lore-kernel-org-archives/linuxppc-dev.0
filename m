Message-ID: <3BB39D2E.7C9A3339@mvista.com>
Date: Thu, 27 Sep 2001 14:42:06 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: danieltaylor@acm.org
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Adding 'bus_offset' to pci_controller
References: <200109271310.JAA20256@missioncriticallinux.com> <3BB38008.39A3F149@we.mediaone.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Taylor wrote:

> The bus number refers to the segment of PCI between bridges (host
> PCI-PCI, or other) or attached to a single bridge; multiple host
> bridges are referenced although I have never tried it.  So, from
> your host bridge, for example the embedded MPC107 in an '8240, there
> are four Ethernet devices, an IDE interface, and a PCI-PCI bridge,
> and then there are two Fibre Channel devices attached to the PCI-
> PCI bridge.  There will be two pci_bus structures, one for the PCI
> bus from the host bridge to the PCI-PCI bridge, which should be bus
> number 0, and another for the PCI bus on the "other" side of the
> PCI-PCI bridge, which should be number 1.  All the Ethernet devices'
> AND the PCI-PCI bridge's pci_dev structures will point to the
> HOST BRIDGE pci_bus structure; the Fibre Channel devices will point
> to a pci_bus structure associated with the PCI-PCI bridge.

All of this is correct but it doesn't address the actual issue.

Background:
When generating a config addr on a PCI bus, you encode the bus number of the
target bus.  If the encoded bus number  matches the pci bus immediately below
the bridge, a Type 0 cycle is generated on that PCI bus; if not the same, a
Type 1 cycle is generated and should be claimed by the appropriate bridge on
that pci bus.  So, if you want to talk to a device on the PCI bus directly
below the host bridge, you must have the same bus number encoded in the config
addr that the bridge thinks that bus is (make sense?).

Up until now, host bridges with 2 pci buses (that's 2 "hoses" in linuxppc
nomenclature) hanging off them have allowed the s/w to set the bus number of
the second hose.  This lets us set up the second hose to "think" its pci bus
is the same bus number as we use up in linuxppc-land so linuxppc pci bus
number matches the physical bus numbering of the hoses.

With the gt64260, BOTH hoses are considered PCI bus 0 so when generating the
config addr that gets passed to the bridge for the second hose, you have to
subtract out the number of buses on the first hose.  That's the problem being
solved here.

Now that I've said all that, I think I've just found a way to set the bus
number of the second hose so, if it works, all of this becomes moot.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
