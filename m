Message-ID: <3AEF2AA5.5CB593C8@mvista.com>
Date: Tue, 01 May 2001 14:29:09 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Denton Gentry <denny@dominetsystems.com>
Cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405gp PCI?
References: <3AEE0E5C.955341B3@dominetsystems.com> <3AEE21DF.6C289B1C@mvista.com> <3AEF2381.755F7581@dominetsystems.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Denton Gentry wrote:
>
> > Hmmm...I know it works with PCI slave devices, but I don't know
> > if it will for masters.  I know the Linux support functions for
> > virt_to_bus and friends will provide the proper addresses.  Sounds
> > like there is some missing 405 register initialization.  Are you
> > doing this on a custom board, or in the Walnut eval board?  I
> > suspect on the Walnut we rely on the boot rom for some of this
> > 405 PCI initialization.
>
>   The addresses returned by virt_to_bus look reasonable. The virtual
> address of the buffer in question is 0xc0261940, and the DMA address
> returned by virt_to_bus is 0x00261940. I assume that the lower few megs
> of physical RAM are pinned memory for the kernel, and that a 1:1 mapping
> of physical pages in this pinned memory is done starting at a kernel
> offset in the virtual address space, so these addresses look reasonable
> to me.
>
>   This is the Walnut eval board. I am using IBM's firmware to tftpboot
> a kernel, which the NFS mounts its root filesystem.

What is the version of the firmware?  (It is reported on the console
when you turn on the power, eg "405GP 1.13 ROM Monitor (4/7/00)".)


>   I'll keep digging into it. Since no-one has piped up to confirm that
> PCI DMA works in PPC 405gp systems, I'll start looking at the PCI
> controller initialization code as well.
>
> > >   Also, though I'm certain that this problem is not caused by
> > > stale data, one of the next things I'll need to tackle is cache
> > > coherency.
> >
> > I have just recently finished the pci_consistent_* functions and
> > software cache mangement functions so they will do the right thing
> > on the IBM4xx and MPC8xx processors.


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
