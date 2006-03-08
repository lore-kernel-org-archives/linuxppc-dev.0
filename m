Return-Path: <philn@avalon.com.au>
Received: from ash25e.internode.on.net (ash25e.internode.on.net
	[203.16.214.182]) by ozlabs.org (Postfix) with ESMTP id 037AC679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Mar 2006 01:02:37 +1100 (EST)
Sender: philn@avalon.com.au
To: linuxppc-embedded@ozlabs.org
Subject: Re: linux DMA capabilities in MV64460
References: <kw3bkovcup.fsf@lamorak.int.avalon.com.au>
	<20051220010136.GA31165@mag.az.mvista.com>
	<kwlkvomcxp.fsf@lamorak.int.avalon.com.au>
	<200603060821.29220.brian@waitefamily.us>
From: Phil Nitschke <phil@avalon.com.au>
Date: 09 Mar 2006 00:32:32 +1030
Message-ID: <wqhd69f30n.fsf@toby.int.avalon.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Waite <bwaite@irobot.com>
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "BW" == Brian Waite <brian@waitefamily.us> writes:

  >> I'm now looking seriously (and reluctantly!) at writing a DMA
  >> Controller Driver to supplement these functions, and I've started
  >> the process of getting an NDA from Marvell, so I can get their
  >> User Manual (and errata!).

  BW> You won't get very far without the user manual, then I think you
  BW> will find it pretty easy to write the driver with the frameworks
  BW> already in the kernel.

  >> Can someone point me in the right direction to get me started?  I
  >> need to come up the learning curve to find out where to start.
  >> 
  >> How is a DMA controlled (from a device driver writer's
  >> perspective) when a third-party (i.e. in the bridge) DMA
  >> controller needs to do the work to get the data from a PCI Target
  >> into main memory?
  >> 
  >> What kernel API should be provided by the DMA Controller Driver?

  BW> My first guess would be to follow something like
  BW> Documentation/DMA-API.txt and Documentation/DMA-mapping.txt

I can't see how trying to match those DMA functions would work.  

The dma_map_xxx() functions and friends appear to be invoked from
driver interrupt handlers, which are either responding to an interrupt
from a PCI Target which wants to commence a bus-mastered DMA to/from
main memory, or responding to a second interrupt to say the interrupt
is complete.

In my case, my driver receives one interrupt from a PCI Target which
cannot perform a DMA, and I presumably have to use an alternative API
(i.e. my "new" set of ("DMA Controller") driver functions) to get the
platform DMA controller to fetch the data and wake (interrupt) me once
complete.  Right?

  >> Any documentation, examples, similar device drivers, etc, would
  >> be appreciated.  TIA,

  BW> You could look to followup that by groking
  BW> arch/ppc/kernel/dma-mapping.c

OK.

  BW> Finally, arch/ppc/syslib ppc4xx_dma.c seems to show an example
  BW> of a low level driver.  

OK, so suppose I write a bunch of functions, like this:

    mv64x60_disable_dma();
    mv64x60_disable_dma_interrupt();
    mv64x60_enable_dma();
    mv64x60_enable_dma_interrupt();
    mv64x60_get_dma_status();
    mv64x60_init_dma_channel();
    ... etc,

then how do these get called; directly from my other driver?  

(I could not see any place that the ppc4xx_ dma functions were being
called, i.e. they don't seem to dovetail into some higher level kernel
API...?)

  BW> I didn't notice any platform dma controllers like MAG
  BW> reccommended, but that should be a better way to go.

Perhaps Mark was talking about ppc4xx_dma.c and ppc4xx_sgdma.c ?

Sorry if I'm too slow on the uptake.  Thanks for your input,

-- 
Phil
