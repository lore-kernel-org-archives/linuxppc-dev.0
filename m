Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F49F679F0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 May 2005 07:04:05 +1000 (EST)
In-Reply-To: <20050520141244.GD24923@logos.cnet>
References: <20050520141244.GD24923@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e503cf4ab6d2d389b29474561048f2f2@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 20 May 2005 17:03:59 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] allow coherent DMA API to work before main page
	allocator is set up
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 20, 2005, at 10:12 AM, Marcelo Tosatti wrote:

> The following patch changes dma_alloc_coherent() to, in case the
> main page allocator is not yet up and running, use the bootmem
> allocator instead.

I'm concerned about this ...  Why did the drivers change in 2.6
such that they now call dma_alloc_coherent() prior to the VM set up?

> It also adds a new parameter to m8xx_cpm_hostalloc() to send back
> the physical address to its caller.

Anyone calling m8xx_cpm_hostalloc() is likely to be immediately
calling dma_alloc_coherent().  There is some design problem here
if we can't properly use these interfaces and get the mapping we
need.  The TLB pinning option won't work if we can't do this.


>  ..... Special casing such as
> drivers/serial/cpm_uart/cpm_uart_cpm1.c's cpm_uart_allocbuf() can be
> removed:
>
>         if (is_con) {
>                 mem_addr = (u8 *) m8xx_cpm_hostalloc(memsz);
>                 dma_addr = 0;
>         } else
>                 mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
>                                               GFP_KERNEL);

This is bogus and should not be necessary.  The original serial
driver was able to work without doing this, I spent lots of time so
stuff like this wasn't necessary, and it's sad to see us take such
a step backward.

> What is your opinion on this approach?

As you can tell, I don't like it and we shouldn't need it :-)
The first call to m8xx_cpm_hostalloc() should be able to call
dma_consistent_alloc() to get a consistent page.  If this isn't the
case, we have to fix the drivers so they can do this.  The only
change that should be necessary is to return the physical address
from m8xx_cpm_hostalloc(), if for some reason we see some
need to get rid of the immensely useful iopa() function.

Thanks.


	-- Dan
