Date: Tue, 30 Oct 2001 19:08:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: small cleanup
Message-ID: <20011030190809.F16202@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.LNX.4.33.0110310209390.30087-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0110310209390.30087-100000@serv>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 31, 2001 at 02:44:47AM +0100, Roman Zippel wrote:

> Below is a patch from the APUS tree (more to follow :) ). It does some
> small cleanups and one important change to get APUS working:

Yay!

> - introducing PPC_MEMSTART/PPC_MEMOFFSET, for non-APUS machines these are
> constants otherwise variables. I added with this support for memory
> starting != 0.
> - ram_phys_base became ppc_memstart
> - removed end_of_DRAM, it's equivalent to high_memory

Sounds OK.

> - pcibios_make_OF_bus_map depends on CONFIG_ALL_PPC

This should just be a warning, since gcc will optmize it out (it'll
always be false on !CONFIG_ALL_PPC.  It'd almost be preferable to do
something like:
#define pcibios_make_OF_bus_map do { } while(0)

Someplace...

> - removed duplicate definition of isa_io_base/isa_mem_base/pci_dram_offset
> (note: these variables are protected with CONFIG_PCI in ppc_ksyms.c, but
> not in the include files, so there are unconditional now)

This will break 4xx I think...  Can you try doing a
walnut+CONFIG_405_DMA=y compile (in _devel..)

> - removed nested __KERNEL__ ifdefs in io.h, one even outside of the
> recursive protection (bad style).

Correct, but it's usually
#ifdef __KERNEL__
#ifndef __FILE_H__
#define __FILE_H__
...
#endif
#endif

Or so.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
