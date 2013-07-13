Return-Path: <gsi@denx.de>
Date: Sat, 13 Jul 2013 16:14:43 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 5/8] dma: mpc512x: use symbolic specifiers for DMA
 channels
Message-ID: <20130713141443.GJ2615@book.gsilab.sittig.org>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <1373642781-32631-6-git-send-email-gsi@denx.de>
 <201307130917.08904.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201307130917.08904.arnd@arndb.de>
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

[ MPC8308 knowledge required, see below ]

On Sat, Jul 13, 2013 at 09:17 +0200, Arnd Bergmann wrote:
> 
> On Friday 12 July 2013, Gerhard Sittig wrote:
> > +++ b/include/dt-bindings/dma/mpc512x-dma.h
> > @@ -0,0 +1,21 @@
> > +/*
> > + * This header file provides symbolic specifiers for DMA channels
> > + * within the MPC512x SoC's DMA controller.  Since requester lines
> > + * directly map to channel numbers and no additional flexibility
> > + * is involved, DMA channels can be considered directly associated
> > + * with individual peripherals.
> > + *
> > + * This header file gets shared among DT bindings which provide
> > + * hardware specs, and driver code which implements supporting logic.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_DMA_MPC512x_DMA_H
> > +#define _DT_BINDINGS_DMA_MPC512x_DMA_H
> > +
> > +#define MPC512x_DMACHAN_SCLPC          26
> > +#define MPC512x_DMACHAN_SDHC           30
> > +#define MPC512x_DMACHAN_MDDRC          32
> > +
> > +#define MPC512x_DMACHAN_MAX            64
> > +
> 
> I think these should not be in the header and should not bve part of the
> binding either. They are specific to an SoC that happens to be using this
> DMA controller but would be completely different for any other SoC with
> the same DMA engine. These belong into the dma descriptors of the slave
> drivers and don't need symbolic names.

Thank you for the feedback.

OK, so not adding the dt-bindings header leads to no change in
the DTS nodes, which in turn collapses 5/8 into something local
to the .c driver source (introduce an enum and replace a few
magic numbers with names), and obsoletes 4/8 as a prerequisite.
This will further reduce the patch set's size.

Your feedback made me re-visit the driver source and notice that
it is shared among the MPC512x as well as the MPC8308 hardware.
The latter only has 16 channels, and appears to _not_ have its
channels dedicated to peripherals.  It's even uncertain to me
whether it can cope with peripherals at all and how so.

I scanned chapter 12 (DMA controller) in the MPC8308 reference
manual (rev 0 as of 2010-04) several times and could not find any
hint about peripherals, request lines, or anything else related
to flow control.  Searching in the whole RM won't give a hint
either.  Does this suggest that the MPC8308 DMA controller's
channels are "free" in their assignment to transfer tasks?  Or
are they "memory transfers only"?  Or do they happily accept any
XLB address (internal and external RAM, IMMR and IP bus space)
but don't apply flow control, i.e. expect either peripherals to
already hold the RX data, or peripherals to keep up with being
fed random amounts of TX data?  I tend to read the doc as the
latter.

Can somebody with MPC8308 knowledge confirm my suspicion that the
MPC8308 DMA channels aren't associated with peripherals, and thus
always need the software initiated start condition (_if_ they are
used for data transfer to/from peripherals)?  Can somebody with
access to an MPC8308 based board test later versions of the
series, to verify we don't break DMA operation on that platform?

Regardless of whether MPC8308 can't handle peripheral access, or
doesn't differ from memory transfers there, the patch series
needs an update.  Part 1/8 in its current form is either wrong or
incomplete, works for MPC512x but not for all hardware that this
driver is responsible for.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
