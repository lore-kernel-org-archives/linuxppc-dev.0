In-Reply-To: <200003221024.LAA10024@mcp.cpu.lu>
Date: Wed, 22 Mar 2000 14:18:23 +0100
To: Michel Lanners <mlan@mcp.cpu.lu>, geert@linux-m68k.org,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LongTrail PCI resource assignment
Message-Id: <20000322141823.026614@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 22, 2000, Michel Lanners <mlan@mcp.cpu.lu> wrote:


>Can't we replace this with a seed to the resource tree, defined per host
>bridge
>in arch-specific code? On PowerMacs, there's a function that scans for known
>host bridges; that code could (either dynamically or based on hardcoded
>knowledge) put the available IO window into some resource of the host bridge
>pci_dev struct. The tree of IO resources could then be built from there.

Note that in the Uni-N case, all 3 sub-busses have the same bus number
(0). There's apparenty no dev_fn conflicts between the devices on the
various nodes (but each sub node does _not_ have a specific range of
dev_fn, they are somewhat mixed).

For config accesses, we can still rely on my current hack which does a
reverse lookup of the PCI device in the OF device-tree, walks up the tree
to find on which Uni-N entry it is attached, and use the proper config
access registers (all not-found devices are routed to the external PCI,
just in case).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
