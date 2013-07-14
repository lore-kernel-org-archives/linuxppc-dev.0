Return-Path: <gsi@denx.de>
Date: Sun, 14 Jul 2013 13:02:47 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 5/8] dma: mpc512x: use symbolic specifiers for DMA
 channels
Message-ID: <20130714110247.GB7080@book.gsilab.sittig.org>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <201307130917.08904.arnd@arndb.de>
 <20130713141443.GJ2615@book.gsilab.sittig.org>
 <201307141050.05153.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201307141050.05153.arnd@arndb.de>
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

On Sun, Jul 14, 2013 at 10:50 +0200, Arnd Bergmann wrote:
> 
> On Saturday 13 July 2013, Gerhard Sittig wrote:
> > 
> > [ ... ]
> > 
> > Thank you for the feedback.
> > 
> > OK, so not adding the dt-bindings header leads to no change in
> > the DTS nodes, which in turn collapses 5/8 into something local
> > to the .c driver source (introduce an enum and replace a few
> > magic numbers with names), and obsoletes 4/8 as a prerequisite.
> > This will further reduce the patch set's size.
> 
> Actually I think you will need extra changes: The dma-engine driver
> should not require knowledge of any channel-specific settings.
> I did not notice you had them until you mentioned the above, but
> from what I can tell, you need a few flags in the dma-specifier
> to replace code like
> 
>                 /* only start explicitly on MDDRC channel */
> -               if (cid == 32)
> +               if (cid == MPC512x_DMACHAN_MDDRC)
>                         mdesc->tcd->start = 1;
> 
> with
> 
> 		mdesc->tcd->start = dmaspec->explicit_start;
> 
> or something along these lines, where dmaspec is a data structure
> derived from the fields in the DT dma specifier of the child
> node.		

The above change applies to the mpc512x_dma.c file, this is the
very driver source which implements the DMA engine API, and deals
with the specific details of the SoC.  So I consider this the
most appropriate location to handle requirements of specific
channels in the DMA controller's driver, while the generic DMA
engine subsystem just finds the provider's API.

The driver takes care of _one_ DMA controller which has several
channels while these channels in turn might have _different_
characteristics.

Most channels of the MPC512x SoC's DMA controller have request
lines for peripherals to apply flow control, while the 'MDDRC'
channel is dedicated to mem-to-mem transfers and requires a
software initiated start in the absence of an external request
line.

The channels of the MPC8308 SoC's DMA controller appear to not
have any request lines, which makes them perfectly fit for
mem-to-mem transfers and always requires software initiated
start.  Yet this does not absolutely prevent their use for
peripheral access, _provided_ that the peripheral's FIFO is deep
enough or the data volume is appropriately low (or wire speed is
rather high, whatever obsoletes flow control).

I'm in the process of preparing v2 of the series, which keeps
compatibility with the MPC8308 and approaches things slightly
differently than v1 although in the same spirit.


Regarding the device tree binding, I was under the impression
that backwards compatibility is a must.  Reading channel counts
from DT nodes instead of encoding them in the driver would have
been nice upon introduction of OF support, but would break
compatibility these days.


> > I scanned chapter 12 (DMA controller) in the MPC8308 reference
> > manual (rev 0 as of 2010-04) several times and could not find any
> > hint about peripherals, request lines, or anything else related
> > to flow control.  Searching in the whole RM won't give a hint
> > either.  Does this suggest that the MPC8308 DMA controller's
> > channels are "free" in their assignment to transfer tasks?  Or
> > are they "memory transfers only"?  Or do they happily accept any
> > XLB address (internal and external RAM, IMMR and IP bus space)
> > but don't apply flow control, i.e. expect either peripherals to
> > already hold the RX data, or peripherals to keep up with being
> > fed random amounts of TX data?  I tend to read the doc as the
> > latter.
> 
> It sounds to me that they are memory-to-memory only, which means
> you probably want to allow #dma-cells=<0> as a special case to
> describe an instance that has no slave API support.

This would impact the current OF registration, which
unconditionally assumes one-cell specs.  Before changing this to
one-cell for MPC512x and zero-zell for MPC8308, I'd love to learn
whether slave support on MPC8308 is inapplicable or whether it's
doable yet constraints apply (ATM I assume the latter, would not
want to enforce non-availability just to re-introduce it later).


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
