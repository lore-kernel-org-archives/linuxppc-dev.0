Message-ID: <3A9179AB.17D56F36@mvista.com>
Date: Mon, 19 Feb 2001 14:53:15 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: mod+linuxppc-embedded@world-f.std.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How does one get physical address for iorempped window?
References: <200102191915.OAA29416@world.std.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


mod+linuxppc-embedded@world-f.std.com wrote:

> .....  Being able to refer to something like, say,
> the appropriate pci_bus* when invoking virt_to_bus()

Right, you have to provide enough information to get the
job done correctly, but this could be more generic.  Adding
pci_bus* to virt_to_bus is the right concept, but the wrong
implementation as I certainly want to use virt_to_bus() (or
whatever) for devices that are not on a PCI bus.

> ...  I'm certainly not a fan of pointlessly
> complex code, but the one-size-fits-all implementation
> of virt_to_bus()....

That's not a one-size-fits-all implementation :-).  It (and
virt_to_phys()) worked differently on at least three different
PowerPC implementations.  Mainly to eliminate a bunch of nested
#ifdefs and duplicated code, I now use the same implementation
on all PowerPCs, but it is just the first small step to doing
something better.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
