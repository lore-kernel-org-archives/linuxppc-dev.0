Date: Tue, 1 Feb 2000 09:18:01 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Martin Costabel <costabel@wanadoo.fr>
cc: "Kevin M. Myer" <kevin_myer@elanco.k12.pa.us>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: devel kernels 2.3.41
In-Reply-To: <38960B24.39C5A8F3@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10002010911080.17707-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 31 Jan 2000, Martin Costabel wrote:
> Yes, this one is obvious. But if you have IDE enabled, there are later
> on a whole bunch of new functions that are undefined, and I think it
> must be pretty hard to write them. In drivers/block/ide-dma.c, you get
> pci_map_sg, sg_dma_len, sg_dma_address, pci_unmap_sg,
> pci_free_consistent, pci_alloc_consistent all undefined.

	these are the new  dynamic DMA mapping stuff, which sparc64
(others?) use.  i386 and us use static so we just 'fake' those functions.
they should be empty functions in <asm/pci.h>.  look at asm-i386/pci.h if
you need help.

	you will also run into problems with the new rw mutuxes, its a
mixture of rw spinlocks and semaphores.  there's a few asm functions which
need to be implemented and I have hack together a few of them.  You can
look at the sparc implementation if you wish.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
