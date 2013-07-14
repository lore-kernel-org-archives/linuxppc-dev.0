Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH RFC 5/8] dma: mpc512x: use symbolic specifiers for DMA
 channels
Date: Sun, 14 Jul 2013 10:50:04 +0200
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <201307130917.08904.arnd@arndb.de>
 <20130713141443.GJ2615@book.gsilab.sittig.org>
In-Reply-To: <20130713141443.GJ2615@book.gsilab.sittig.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201307141050.05153.arnd@arndb.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>,
 devicetree-discuss@lists.ozlabs.org, Alexander Popov <a13xp0p0v88@gmail.com>,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 13 July 2013, Gerhard Sittig wrote:
> [ MPC8308 knowledge required, see below ]
> 
> On Sat, Jul 13, 2013 at 09:17 +0200, Arnd Bergmann wrote:
> > 
> > On Friday 12 July 2013, Gerhard Sittig wrote:
> > > +++ b/include/dt-bindings/dma/mpc512x-dma.h
> > > @@ -0,0 +1,21 @@
> > > +/*
> > > + * This header file provides symbolic specifiers for DMA channels
> > > + * within the MPC512x SoC's DMA controller.  Since requester lines
> > > + * directly map to channel numbers and no additional flexibility
> > > + * is involved, DMA channels can be considered directly associated
> > > + * with individual peripherals.
> > > + *
> > > + * This header file gets shared among DT bindings which provide
> > > + * hardware specs, and driver code which implements supporting logic.
> > > + */
> > > +
> > > +#ifndef _DT_BINDINGS_DMA_MPC512x_DMA_H
> > > +#define _DT_BINDINGS_DMA_MPC512x_DMA_H
> > > +
> > > +#define MPC512x_DMACHAN_SCLPC          26
> > > +#define MPC512x_DMACHAN_SDHC           30
> > > +#define MPC512x_DMACHAN_MDDRC          32
> > > +
> > > +#define MPC512x_DMACHAN_MAX            64
> > > +
> > 
> > I think these should not be in the header and should not bve part of the
> > binding either. They are specific to an SoC that happens to be using this
> > DMA controller but would be completely different for any other SoC with
> > the same DMA engine. These belong into the dma descriptors of the slave
> > drivers and don't need symbolic names.
> 
> Thank you for the feedback.
> 
> OK, so not adding the dt-bindings header leads to no change in
> the DTS nodes, which in turn collapses 5/8 into something local
> to the .c driver source (introduce an enum and replace a few
> magic numbers with names), and obsoletes 4/8 as a prerequisite.
> This will further reduce the patch set's size.

Actually I think you will need extra changes: The dma-engine driver
should not require knowledge of any channel-specific settings.
I did not notice you had them until you mentioned the above, but
from what I can tell, you need a few flags in the dma-specifier
to replace code like

                /* only start explicitly on MDDRC channel */
-               if (cid == 32)
+               if (cid == MPC512x_DMACHAN_MDDRC)
                        mdesc->tcd->start = 1;

with

		mdesc->tcd->start = dmaspec->explicit_start;

or something along these lines, where dmaspec is a data structure
derived from the fields in the DT dma specifier of the child
node.		

> I scanned chapter 12 (DMA controller) in the MPC8308 reference
> manual (rev 0 as of 2010-04) several times and could not find any
> hint about peripherals, request lines, or anything else related
> to flow control.  Searching in the whole RM won't give a hint
> either.  Does this suggest that the MPC8308 DMA controller's
> channels are "free" in their assignment to transfer tasks?  Or
> are they "memory transfers only"?  Or do they happily accept any
> XLB address (internal and external RAM, IMMR and IP bus space)
> but don't apply flow control, i.e. expect either peripherals to
> already hold the RX data, or peripherals to keep up with being
> fed random amounts of TX data?  I tend to read the doc as the
> latter.

It sounds to me that they are memory-to-memory only, which means
you probably want to allow #dma-cells=<0> as a special case to
describe an instance that has no slave API support.

	Arnd
