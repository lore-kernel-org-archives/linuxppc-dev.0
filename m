Message-ID: <38960B24.39C5A8F3@wanadoo.fr>
Date: Mon, 31 Jan 2000 23:22:28 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: "Kevin M. Myer" <kevin_myer@elanco.k12.pa.us>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: devel kernels 2.3.41
References: <Pine.LNX.4.20.0001311609090.2282-100000@marble.elanco.k12.pa.us>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin M. Myer" wrote:
[]
> --- linux/include/asm-ppc/types.h.old   Mon Jan 31 16:07:01 2000
> +++ linux/include/asm-ppc/types.h       Mon Jan 31 16:03:28 2000
> @@ -41,6 +41,10 @@
>
>  #define BITS_PER_LONG 32
>
> +/* Dma addresses are 32-bits wide for now.  */
> +
> +typedef u32 dma_addr_t;
> +
>  #endif /* __KERNEL__ */
>
>  #endif
>
> In init/main.c, it included linux/pci.h, in which the struct pci_dev has a
> new member "dma_mask".  This is of type dma_addr_t, which is defined for
> i386 and sparc64 but no other architectures that I can tell.

Yes, this one is obvious. But if you have IDE enabled, there are later
on a whole bunch of new functions that are undefined, and I think it
must be pretty hard to write them. In drivers/block/ide-dma.c, you get
pci_map_sg, sg_dma_len, sg_dma_address, pci_unmap_sg,
pci_free_consistent, pci_alloc_consistent all undefined.

> That at least got me around the initial compile problem.  I'm working on
> an Apple Network Server with a somewhat less than vanilla 2.3.41 so I'm
> not sure if it compiles and boots fully (seeing as I've goofed up some
> code for the secondary PCI bus on the ANS and it won't compile fully).

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
