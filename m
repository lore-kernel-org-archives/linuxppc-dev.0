Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 8D9CC67A70
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 09:52:44 +1000 (EST)
Date: Tue, 23 May 2006 16:54:49 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Phil Nitschke <Phil.Nitschke@avalon.com.au>
Subject: Re: pmppc7448/mv64x60 DMA from PCI to memory
Message-ID: <20060523235449.GB1536@mag.az.mvista.com>
References: <1148395804.21475.53.camel@toby.int.avalon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148395804.21475.53.camel@toby.int.avalon.com.au>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Phil,

On Wed, May 24, 2006 at 12:20:04AM +0930, Phil Nitschke wrote:
> I've written a collection of simple routines to program the Marvell IDMA
> controller, for example:
>     mv64x6x_init_dma_channel();
>     mv64x6x_set_dma_mode();
>     mv64x6x_set_src_addr();
>     mv64x6x_set_dst_addr();
>     mv64x6x_set_dma_count();
>     mv64x6x_enable_dma();
> or rather more simply:
>     mv64x6x_memcpy_dma(dst_handle, src_handle, size);

Listing routine names but no code doesn't really help.

> This works OK for copying from a memory to memory, where the buffers are
> allocated using:
>     src = dma_alloc_noncoherent(NULL, BUF_SZ, &src_handle, GFP_KERNEL);
> The src_handle is passed directly to mv64x6x_set_src_addr();
> 
> But when the src address is the FIFO on the PCI bus, I don't know how to

Do you really mean a FIFO?  If so, that would explain a lot...

> get the IDMA controller to play nicely.  The FIFO sits in the middle of
> the PCI device's I/O mem range 0x9fe00000 - 0x9fffffff.  I've programmed
> and enabled a 5th address window in the IDMA controller which
> encompasses the 0x200000 bytes of the PCI memory range, and I'm not
> seeing any address violation or address miss errors.  The PCI->memory
> DMA "completes" without any traffic every touching the PCI bus, so
> obviously I need to do something else/differently.

You say that you don't see any PCI traffic.  Does that mean you
have a PCI analyzer and that you are sure that its set up correctly?
If so, then you have something botched in your IDMA->PCI window setup
or in the pgming of the DMA itself (e.g., in your descriptor(s)).

Also, set the SrcHold bit [3] of the channel control reg (low).
If its really a FIFO, you are--or will be once you get your windows
and descriptors set up correctly--reading the FIFO once then
incrementing past it.

> For this scenario, can anyone tell me:
>         * Should I be using the same src address as that reported via
>         the 'lspci' command - this _is_ the PCI bus address, isn't it?

"man lspci" (read up on the '-b' option)

>         * Do I have to do anything special to tell the IDMA controller
>         to source data from the PCI bus and shift it into memory?

You're talking to a *FIFO* which means you read all the data from one
address and write all the data to one, probably different, address.
Its not normal PCI memory, you don't increment through it.  Its a
register of a FIFO that's in PCI memory space.  That's why you need
to tell the IDMA ctlr to "hold" and read/write to the same address
each time.

>         * Looking through mv64x60.c in the 2.6.16 kernel, I note that 4
>         of the 8 possible IDMA address windows are configured (for each
>         of the 512 MB DRAM on our processor card).

No they aren't.  They're configured (or not) according to the setup info
that you pass in.

> Do I need to add
>         tests to my source and destination regions, to determine if they
>         cross one of the 512 MB regions, and hence will require a
>         different CSx line (and thus the DMA will need to be broken into
>         two transactions), or does kernel already take care to ensure
>         allocated regions will not cross these boundaries?

No.  You need to do what's appropriate for the hardware that you are
essentially writing a driver for.  YOU are supposed to know what the
limitations of your hardware are.  Even if you don't have a manual... ;)

Mark
