Message-Id: <200102191915.OAA29416@world.std.com>
To: linuxppc-embedded@lists.linuxppc.org
From: mod+linuxppc-embedded@world-f.std.com
Subject: Re: How does one get physical address for iorempped window?
Date: Mon, 19 Feb 2001 14:15:35 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>virt_to_*/*_to_virt functions _should_ have become
>something more generic, but they are just yet another macro
>name for doing the same thing.  Now, we have gone of and
>created some pci_* mapping functions, which are not at all
>useful for highly integrated processors because their
>integrated features are not PCI devices.  Yet another set
>of functions for integrated processors?  I don't think so.
>
>I think that requiring knowledge of the object attributes
>for a VM or physical space so you can call the proper
>mapping or other management functions is just a poor
>design.  If you know this information and wish to take
>performance enhancement shortcuts, that's fine, but it
>shouldn't be required.


What if you're working on a system with multiple PCI
busses (or even multiple disparate bus types) and it's
not possible to map Host memory at the same address on
all busses?  Being able to refer to something like, say,
the appropriate pci_bus* when invoking virt_to_bus()
could make it possible to accomodate those different
mappings.  I'm certainly not a fan of pointlessly
complex code, but the one-size-fits-all implementation
of virt_to_bus() seen in my 25Jan-vintage kernel sources
(it just lops off the KERNEL_OFFSET bits and adds
pci_dram_offset) won't work in situations such as those
I just described.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
