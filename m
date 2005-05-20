Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06F3F679FA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 May 2005 09:13:47 +1000 (EST)
Date: Fri, 20 May 2005 14:51:52 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050520175152.GB26221@logos.cnet>
References: <20050520141244.GD24923@logos.cnet>
	<e503cf4ab6d2d389b29474561048f2f2@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e503cf4ab6d2d389b29474561048f2f2@embeddededge.com>
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

On Fri, May 20, 2005 at 05:03:59PM -0400, Dan Malek wrote:
> 
> On May 20, 2005, at 10:12 AM, Marcelo Tosatti wrote:
> 
> >The following patch changes dma_alloc_coherent() to, in case the
> >main page allocator is not yet up and running, use the bootmem
> >allocator instead.
> 
> I'm concerned about this ...  Why did the drivers change in 2.6
> such that they now call dma_alloc_coherent() prior to the VM set up?

Well, as far as I can see, it is expected that console_init() gets called
before the main page allocator.

The startup sequence, on both v2.4 and v2.6, is:

setup_arch()
...
	console_init()
		console_8xx_init()
			register_console()
				release_console_sem() 
...
	mem_init()

register_console calls the driver ->setup method, and release_console_sem() 
is going to ->write pending data from the log buffer to the device.

As you well know, ->setup calls m8xx_cpm_hostalloc(). 

I must be missing something very obvious here, can you explain how 
did you arrange things in v2.4 such that the console's ->setup 
method is called _after_ mem_init() ? 

> >It also adds a new parameter to m8xx_cpm_hostalloc() to send back
> >the physical address to its caller.
> 
> Anyone calling m8xx_cpm_hostalloc() is likely to be immediately
> calling dma_alloc_coherent().  There is some design problem here
> if we can't properly use these interfaces and get the mapping we
> need.  The TLB pinning option won't work if we can't do this.
> 
> 
> > ..... Special casing such as
> >drivers/serial/cpm_uart/cpm_uart_cpm1.c's cpm_uart_allocbuf() can be
> >removed:
> >
> >        if (is_con) {
> >                mem_addr = (u8 *) m8xx_cpm_hostalloc(memsz);
> >                dma_addr = 0;
> >        } else
> >                mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
> >                                              GFP_KERNEL);
> 
> This is bogus and should not be necessary.  The original serial
> driver was able to work without doing this, I spent lots of time so
> stuff like this wasn't necessary, and it's sad to see us take such
> a step backward. 

Well, if you got this right in v2.4 then it must be possible to get 
it right in v2.6 too...

Thanks!
