Message-ID: <3A6CD180.EDFEA254@mvista.com>
Date: Mon, 22 Jan 2001 16:34:08 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: Dan Malek <dan@mvista.com>, Jeff Hartmann <jhartmann@valinux.com>,
        michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <Pine.GSO.4.10.10101222326300.26751-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:
>
> Hi,
>
> On Mon, 22 Jan 2001, Dan Malek wrote:
>
> > > ......  Currently there is no kernel function to do
> > > this explicitly
> >
> > I'm working on that.  The PowerPC port cheated by using BATs and
> > trivial macros, but this doesn't work on some of the newer processors
> > and more complex applications.  Other architectures did the same, and
> > I am surprised there aren't generic kernel functions to track down this
> > information.  In fact, these functions are already present for 4xx and
> > 8xx processors, so don't write anything new.
>
> AFAIK such tricks are used for mapping normal (low) memory and ioremapped
> areas. For normal memory you can use phys_to_virt()/virt_to_phys() and for
> ioremapped memory, you have to store the physical and virtual address
> yourself. What am I missing?
>
> bye, Roman

Take a look at Documentation/DMA-mapping.txt.

I've done something for the 405 that I'm especially wary of, but have been
hoping I can continue to get away with in the future.  I map all of physical
SDRAM to the kernel virtual address space:

  0xc000'0000 through (0xc000'0000 + size of memory - 1)

via large TLB entries (each entry typically covering a range of 8MB).

This means that I can't just change the TLB entry of a 4KB page if I want it
to be mapped uncached.  I instead allocate a new virtual address range and
map that single page as uncachable via the new virtual address.  Thus phys_to_virt()
incorrectly returns the cacheable virtual address instead of the uncacheable virtual
address.

Currently, my biggest user of this method is pci_alloc_consistent().  This use is
because the 405 is not IO cache coherent.  In this case, the "physical" address
is really a bus address, which pci_alloc_consistent calls "dma_handle".
DMA-mapping.txt says drivers should not use bus_to_virt(), which is a close
relative of phys_to_virt().

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
