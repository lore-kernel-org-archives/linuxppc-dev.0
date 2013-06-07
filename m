Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 409C72C013D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jun 2013 08:10:06 +1000 (EST)
Message-ID: <1370642994.3766.421.camel@pasglop>
Subject: Re: FSL 64-bit DMA window question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 08 Jun 2013 08:09:54 +1000
In-Reply-To: <1370642540.6813.16@snotra>
References: <1370606960.3766.381.camel@pasglop> <1370642488.6813.15@snotra>
 <1370642540.6813.16@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>, Timur Tabi <timur@tabi.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-07 at 17:02 -0500, Scott Wood wrote:
> O
> > I thought the device tree was for describing the hardware, rather  
> > than configuration? :-)

A bit of both really. See things like /chosen etc...

Also to what extent a MAC address is HW vs. configuration ? :-)

The HW configuration for a given boards (ie, internal address map,
location of the various bridge windows etc...) is a fairly common thing
to put in a device-tree.

If the PCI outbound windows are there (and they are), why not the
inbound ones ? IE, it's not far fetched. 

> > A kernel command line option might be more appropriate, unless you  
> > just mean describing the difference between e6500 (which supports 40  
> > bit addresses) and previous chips (which support 36 bits), rather  
> > than an ability to move it earlier even on e6500.

Well, so we could indeed locate it at 36 on e5500 and that would clear
the current use case and break again on e6500... or we can make it
depend on the overall address map of the board, which is described
in the device-tree. IE, if you don't "locate" anything above 39-bit
in our address map, then using 39 for the window is ok. IE. It's a
choice. A server board setup that doesn't need gfx but want address
space for some other things wouldn't care.

A board wanting to use gfx (either desktop style, or some of the
military applications I've seen using FSL chips and radeons) would chose
the address map differently to allow the radeons to work.

> > That said, the current code looks broken -- it checks whether a card  
> > can do 40-bit DMA, and if it can, it sets the DMA offset to (1ULL <<  
> > 40), thus requiring 41-bit DMA.  It should be > instead of >= in  
> > fsl_pci_dma_set_mask.

Yes, this was broken for a while, I remember mentioning it a while back
but never actually sending a patch to fix it ... oops ;-)

> > Maybe we could by default use the size of actual RAM, rather than the  
> > physical address space.  Then only odd scenarios such as DMA to  
> > non-kernel-owned RAM would need manual adjustment (MSIs would still  
> > go through the special window below 4G).

You also need to account for other on-chip MMIOs no ? Or do you never
intend to let PCI devices hit them ?

If not, then top of RAM aligned to the next power of two sounds like a
great plan.

Also, those radeons are *also* broken for 64-bit MSIs (they advertize
support but are limited to 40-bit of address). We have added hacks to
deal with that in pseries that I was thinking of generalizing.

Cheers,
Ben.
