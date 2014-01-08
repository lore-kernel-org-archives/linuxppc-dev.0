Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EA5AA2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 03:47:27 +1100 (EST)
Date: Wed, 8 Jan 2014 17:47:19 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v6 4/5] dma: mpc512x: register for device tree
 channel lookup
Message-ID: <20140108164719.GO20094@book.gsilab.sittig.org>
References: <1387886789-20249-1-git-send-email-a13xp0p0v88@gmail.com>
 <1387886789-20249-5-git-send-email-a13xp0p0v88@gmail.com>
 <20131226124828.GK8064@book.gsilab.sittig.org>
 <CAF0T0X7wotm60Bq4tfYcRhkDwiCw2hh5R5m2WmVLmLGLZYpQsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF0T0X7wotm60Bq4tfYcRhkDwiCw2hh5R5m2WmVLmLGLZYpQsQ@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ dropping devicetree from the Cc: list ]

[ what is the semantics of DMA_PRIVATE capability flag?
  is documentation available beyond the initial commit message?
  need individual channels be handled instead of controllers? ]

On Sat, Jan 04, 2014 at 00:54 +0400, Alexander Popov wrote:
> 
> Hello Gerhard.
> Thanks for your review.
> 
> 2013/12/26 Gerhard Sittig <gsi@denx.de>:
> > [ dropping devicetree, we're DMA specific here ]
> >
> > On Tue, Dec 24, 2013 at 16:06 +0400, Alexander Popov wrote:
> >>
> >> --- a/drivers/dma/mpc512x_dma.c
> >> +++ b/drivers/dma/mpc512x_dma.c
> >> [ ... ]
> >> @@ -950,6 +951,7 @@ static int mpc_dma_probe(struct platform_device *op)
> >>       INIT_LIST_HEAD(&dma->channels);
> >>       dma_cap_set(DMA_MEMCPY, dma->cap_mask);
> >>       dma_cap_set(DMA_SLAVE, dma->cap_mask);
> >> +     dma_cap_set(DMA_PRIVATE, dma->cap_mask);
> >>
> >>       for (i = 0; i < dma->chancnt; i++) {
> >>               mchan = &mdma->channels[i];
> >
> > What are the implications of this?  Is a comment due?
> 
> I've involved DMA_PRIVATE flag because new of_dma_xlate_by_chan_id()
> uses dma_get_slave_channel() instead of dma_request_channel()
> (PATCH RFC v6 3/5). This flag is implicitly set in dma_request_channel(),
> but is not set in dma_get_slave_channel().
> 
> There are only two places in the mainline kernel, where
> dma_get_slave_channel() is used. I've picked up the idea
> at one of these places. Please look at this patch:
> http://www.spinics.net/lists/arm-kernel/msg268718.html

I agree that the change looks simple, and there is no doubt that
other drivers apply the flag.  None of this I questioned.  Yet
I'm afraid that the implications are rather huge.

Unless I miss something, I'd happily learn where I'm wrong.

> > I haven't found documentation about the DMA_PRIVATE flag, only
> > saw commit 59b5ec21446b9 "dmaengine: introduce
> > dma_request_channel and private channels".
> 
> Unfortunately I didn't find any description of DMA_PRIVATE flag too.
> But the comment at the beginning of drivers/dma/dmaengine.c
> may give a clue. Quotation:
>   * subsystem can get access to a channel by calling dmaengine_get() followed
>   * by dma_find_channel(), or if it has need for an exclusive channel
> it can call
>   * dma_request_channel().  Once a channel is allocated a reference is taken
>   * against its corresponding driver to disable removal.
> 
> DMA_PRIVATE capability flag might indicate that the DMA controller
> can provide exclusive channels to its clients. Please correct me if I'm wrong.
> 
> > Alex, unless I'm
> > missing something this one-line change is quite a change in
> > semantics, and has dramatic influence on the code's behaviour
> > (ignores the DMA controller when looking for channels that can do
> > mem-to-mem transfers)
> 
> Excuse me, Gerhard, I don't see what you mean.
> Could you point to the corresponding code?

You did see `git show 59b5ec21446b9`, didn't you?  The commit
message strongly suggests that DMA_PRIVATE applies to the whole
DMA controller and excludes _all_ of its channels from the
general purpose allocator which mem-to-mem transfers appear to be
using.  It's not just a hint, but an active decision to reject
requests.

Not only checking code references, but doing a text search,
reveals one more comment on the DMA_PRIVATE flag in a crypto
related document, which supports my interpretation:
Documentation/crypto/async-tx-api.txt:203


Can somebody ACK or NAK my interpretation?  Dan, you committed
this change which introduced the DMA_PRIVATE logic.  What was the
motivation for it, or the goal to achieve?  Do other platforms
have several dedicated DMA controllers, some for peripherals and
some for memory transfers?  Should the "private" flag apply to
channels and not whole controllers?  Am I over-estimating the
benefit or importance of DMA supported memory transfers?


Still I see a difference in the lookup approaches:  Yours applies
DMA_PRIVATE globally and in advance, preventing _any_ use of DMA
for memory transfers.  While the __dma_request_channel() routine
only applies it _temporarily_ around a dma_chan_get() operation.
Allowing for use of DMA channels by both individual peripherals
as well as memory transfers.


> > Consider the fact that this driver
> > handles both MPC5121 as well as MPC8308 hardware.
> 
> Ah, yes, sorry. I should certainly fix this, if setting of DMA_PRIVATE flag
> is needed at all.

What I meant here is that implications for all affected platforms
should be considered.  There is one driver source, but the driver
applies to more than one platform (another issue of the driver is
that this is not apparent from the doc nor the compat strings).

MPC512x has one (GP) DMA controller, of which one channel is
dedicated to DDR, and all other channels can get used for memory
transfers as well.  In addition to most channels being connected
to a specific peripheral for flow control.  Which your patch set
introduces initial support for.

MPC8308 has _all_ channels for memory transfers exclusively (or
at least none of its channels supports flow control).

So blocking memory transfers in mpc512x_dma.c is a total breakage
for MPC8308 (removes the only previous feature and adds nothing),
and is a regression for MPC512x (removes the previously supported
memory transfers, while it may add peripheral supports with very
few users).


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
