Date: Wed, 31 Oct 2001 11:22:20 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: small cleanup
In-Reply-To: <20011030190809.F16202@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0110311113100.31795-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Tue, 30 Oct 2001, Tom Rini wrote:

> > - pcibios_make_OF_bus_map depends on CONFIG_ALL_PPC
>
> This should just be a warning, since gcc will optmize it out (it'll
> always be false on !CONFIG_ALL_PPC.  It'd almost be preferable to do
> something like:
> #define pcibios_make_OF_bus_map do { } while(0)
>
> Someplace...

That function is in the same file...

> > - removed duplicate definition of isa_io_base/isa_mem_base/pci_dram_offset
> > (note: these variables are protected with CONFIG_PCI in ppc_ksyms.c, but
> > not in the include files, so there are unconditional now)
>
> This will break 4xx I think...  Can you try doing a
> walnut+CONFIG_405_DMA=y compile (in _devel..)

I can try it (when I get home).

> > - removed nested __KERNEL__ ifdefs in io.h, one even outside of the
> > recursive protection (bad style).
>
> Correct, but it's usually
> #ifdef __KERNEL__
> #ifndef __FILE_H__
> #define __FILE_H__
> ...
> #endif
> #endif
>
> Or so.

I would do it the other way around. gcc looks for a ifndef/define/endif
sequence to decide whether it needs to rescan that file next time, but I'm
not sure if gcc finds it in this case.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
