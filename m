Message-ID: <3A578631.5335A560@mvista.com>
Date: Sat, 06 Jan 2001 15:55:13 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Dan Winkler <dwinkler@virtual-ink.com>
CC: "'linuxppc-embedded@lists.linuxppc.org '"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: driver memory management
References: <64AFC0D37B2ED411BAB300508B6D90A019AB09@mail.virtual-ink.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Winkler wrote:
>
> I am having some difficulties allocating memory larger than the memory
> available in cpm_host_alloc, cpm_host_alloc seems to use part of a
> predesignated 4K buffer of memory.


I don't quite understand this collection of words, but I will try
to explain some of this.  The cpm_host_alloc() is intended to be
used only by those devices that require small amounts of memory,
significantly less a page size or so.  Like the UART FIFOs and
things like that.  If you notice other drivers (Ethernet for example)
it allocates its own memory and associates it with the BDs.

> pBuff = kmalloc(TRANSMIT_SIZE, GFP_KERNEL|GFP_DMA);
>
> the only problem with this is when I go to copy data to this location it
> fails i.e.

Yeah, you probably get a big time kernel crash due to a bus fault.

> memcpy(__va(pBuff), pSrc, size)
>
> Any Suggestions as to what might be going on.

Yeah, pBuff is a kernel virtual address from kmalloc.  You don't
use the __va() operation on this type of address.  I don't know why
you need to copy this, but you should simply use:

	memcpy(pBuff, pSrc, size)

and then put __pa(pBuff) in the BD.  Of course, the "right" thing
to do is simply track down the physical pages to pSrc and stuff those
into the BDs without allocating or copying any memory (or preallocate
the buffer using kmalloc and tell the data provider to use that).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
