Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 69BB5DDDB6
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jun 2009 02:22:57 +1000 (EST)
Date: Thu, 4 Jun 2009 09:22:53 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Li Yang-R58472 <LeoLi@freescale.com>
Subject: Re: [RFC PATCH] fsldma: Add DMA_SLAVE support
Message-ID: <20090604162253.GA19639@ovro.caltech.edu>
References: <20090515225659.GD858@ovro.caltech.edu>
	<20090603181038.GC7292@ovro.caltech.edu>
	<3A45394FD742FA419B760BB8D398F9ED48368B@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED48368B@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 04, 2009 at 07:20:26PM +0800, Li Yang-R58472 wrote:
> 
> >> This is a request for comments on this patch. I hunch it is 
> >not quite 
> >> ready for inclusion, though it is certainly ready for 
> >review. Correct 
> >> functioning of this patch depends on the patches submitted earlier.
> >> 
> >> As suggested by Dan Williams, I implemented DMA_SLAVE 
> >support for the 
> >> fsldma controller to allow me to use the hardware to 
> >transfer to/from 
> >> a scatterlist to a list of hardware address/length pairs.
> >> 
> >> I implemented support for the extra features available in the DMA 
> >> controller, such as external pause and external start. I have not 
> >> tested the features yet. I am willing to drop the support if 
> >> everything else looks good.
> >> 
> >> I have implemented helper functions for creating the list of 
> >hardware 
> >> address/length pairs as static inline functions in the 
> >linux/fsldma.h 
> >> header. Should I incorporate these into the driver itself and use 
> >> EXPORT_SYMBOL()? I've never done this before :)
> >> 
> >
> >Any comments on this patch?
> >
> 
> No comment for now.  Didn't get the time to study the DMA_SLAVE thing.
> :(
> 

No problem, I just wanted to make sure that it had been noticed.

The DMA_SLAVE thing is pretty simple: it uses chan->private to pass in
arbitrary parameters to the device_prep_slave_sg() routine. The
device_prep_slave_sg() routine takes a scatterlist and a DMA direction,
then uses the private data to setup the transfer.

When you're ready, submit the transfer and go, just like a normal memcpy
operation. It is basically a way to have a device-specific function in
the generic API.

> >I've tested the external start feature, and it works great. I 
> 
> Good.  Is it working with your custom board?  Can I verify this with my
> reference board?
> 

Yes, I only tested it on my custom board. We use the external DMA
control as part of the programming sequence for some FPGA's on the
board.

If I'm reading the eval board's schematic correctly, the pins for
external DMA control aren't hooked to anything useful at the moment.

If you really want to test it, you'll have to do some modifications to
your board. On page 9 of the schematic (upper right corner) you'll see
that the DMA pins are connected to the GPIO controller on the processor.
You could solder some wires between the first and second three GPIO
pins. Then you can configure SICRL so the first 3 pins are configured
for GPIO, and the second 3 pins are configured for external DMA control.
It is a bit of work, but not too bad.

> >had to set the DMA Request Count (in the mode register) after 
> >the driver was in control. There is no interface for doing 
> >this in the existing driver. I just ioremap()ed the registers 
> >and added the value from my driver after claiming the channel 
> >with dma_request_channel().
> >
> >There are ways to get the DMA controller into a state where 
> >the CB bit stays set no matter what you do. I have only seen 
> >this during an externally controlled transfer, when the 
> >external master does weird things. I would fix this state in 
> >terminate_all(), but I have been unsuccessful in getting the 
> >DMA controller working again after it has been messed up.
> 
> What's the frequency for this to happen?  Is the problem reproducable?

I can only cause it to totally lock up when there is an error, and my
FPGA programmer stops toggling the external DMA control pins in the
middle of a transfer. Nothing I can do will get the DMASR[CB] bit to
zero.

I tried causing the problem with a memory-to-memory transfer, and was
able to cause a similar problem. I programmed to the controller to read
32 bytes from 0xc0000000, which isn't part of the memory map.

The DMA never completes, and the controller has the following bits set:
DMAMR[CS]==1
DMASR[TE]==1
DMASR[CB]==1

The fsldma driver doesn't seem to detect the error at this point.

I was able to re-start the DMA controller with the following sequence:
DMAMR[CS]=0
DMASR[TE]=1 DMASR[CB]=1				(write 1's to set bits)
DMACDAR=0 DMASAR=0 DMADAR=0 DMABCR=0 DMANDAR=0	(zero all registers)
DMAMR[CS]=1

Now the fsldma driver tells me "transfer error!". The DMA channel is now
in working order, and I can use it again.

So, I can get something similar by doing a "bad" memory-to-memory
transfer, but I cannot completely lock up the DMA controller.

Thanks,
Ira
