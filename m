Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A5C79B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2012 07:19:20 +1000 (EST)
Message-ID: <1334956749.3197.23.camel@pasglop>
Subject: Re: pci node question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 21 Apr 2012 07:19:09 +1000
In-Reply-To: <4F91B335.4010501@freescale.com>
References: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
 <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
 <4F91B335.4010501@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-04-20 at 14:04 -0500, Scott Wood wrote:

> That's not supposed to be how device tree bindings are determined.

Ugh ? This is nothing to do with Linux, I think Kumar is confused :-)
This has to do with PCI bindings.

If you put the interrupt-map in the parent, then crossing the virtual
p2p will cause a swizzling which is not what you want. As long as the
device has a device number (in devfn) of 0 that's fine but that may not
always be the case.

> It's causing us problems with virtualization device assignment, because
> if we just assign the parent bus we don't get the interrupt map, but if
> we assign the child we need to deal with what it means to assign an
> individual PCI device (e.g. on our internal KVM stuff we get an error on
> that reg property).

I'm not sure what you are doing with device-assignement in KVM, we are
doing something different for server I suppose since the existing
assignment code in qemu-kvm is a dead end... But you should probably
synthetize an interrupt-map for the guest.

> What does this node represent in the first place?  Is there really a
> PCI-to-PCI bridge?  Are all other PCI devices underneath it?

Yes, PCIe 101 :-) It's the root complex, it's "virtual" in that it's a
construct of the host bridge, there's no physical "bridge" in the
system, but yes, PCIe always has a virtual P2P at the top to represent
the root complex.

This was done to fix the long standing problem that there wasn't a
proper way to represent host bridges as parent of their devices in PCI
land.

It allows PCIe to guarantee that a device always has a bridge above
itself, with the corresponding link control registers etc... which is
useful for point to point links :-)

That's also why for example PCIe switches look like stacks of bridges,
for example, a 2 fork switch looks like:

    |
   P2P
   / \
 P2P P2P
  |   |

That way each downstream device gets its own parent P2P with the
corresponding PCIe link control registers etc...
 
> >> Do we really need the error interrupt specified twice?
> > 
> > I put it twice because it has multiple purposes, one has to do with interrupts defined by the PCI spec vs ones defined via FSL controller.
> 
> There are PCI-defined error condition s that cause a host controller
> interrupt.  What does this have to do with the bridge node?
> 
> >> Why is there a zeroed out reg property: reg = <0 0 0 0 0> ??
> > 
> > scratching my head, what happens if you remove it?
> 
> Sigh.

As I said earlier, this is not some black magic, it's a proper reg value
for the root complex virtual bridge. It has bus 0, devfn 0, so the reg
property for the config space has a value of 0.

Without it, the kernel won't properly match it to the corresponding
pci_dev.

Cheers,
Ben.

> -Scott
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
