Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4B3BA2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 01:26:10 +1100 (EST)
Date: Thu, 16 Jan 2014 15:26:03 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v6 4/5] dma: mpc512x: register for device tree
 channel lookup
Message-ID: <20140116142603.GW20094@book.gsilab.sittig.org>
References: <1387886789-20249-1-git-send-email-a13xp0p0v88@gmail.com>
 <1387886789-20249-5-git-send-email-a13xp0p0v88@gmail.com>
 <20131226124828.GK8064@book.gsilab.sittig.org>
 <CAF0T0X7wotm60Bq4tfYcRhkDwiCw2hh5R5m2WmVLmLGLZYpQsQ@mail.gmail.com>
 <20140108164719.GO20094@book.gsilab.sittig.org>
 <20140109111957.GE16227@intel.com>
 <CAF0T0X67RVNoJAM+9DyDM=HKw_5P4MExgXWaEj5_asqVd5hvDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF0T0X67RVNoJAM+9DyDM=HKw_5P4MExgXWaEj5_asqVd5hvDQ@mail.gmail.com>
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

On Mon, Jan 13, 2014 at 12:17 +0400, Alexander Popov wrote:
> 
> Thanks for your replies, Gerhard and Vinod.
> 
> 2014/1/9 Vinod Koul <vinod.koul@intel.com>:
> > On Wed, Jan 08, 2014 at 05:47:19PM +0100, Gerhard Sittig wrote:
> >> [ what is the semantics of DMA_PRIVATE capability flag?
> >>   is documentation available beyond the initial commit message?
> >>   need individual channels be handled instead of controllers? ]
> >
> > The DMA_PRIVATE means that your channels are not to be used for global memcpy,
> > as one can do in async cases (this is hwere DMAengine came into existence)
> >
> > If the device has the capablity of doing genric memcpy then it should not set
> > this. For slave dma usage the dam channel can transfer data to a specfic
> > slave device(s), hence we should use this is geric fashion so setting
> > DMA_PRIVATE makes sense in those cases.
> 
> Each DMA channel of MPC512x DMA controller can do _both_
> mem-to-mem transfers and transfers between mem and some slave peripheral
> (only one DMA channel is fully dedicated to DDR).
> All DMA channels of MPC512x DMA controller belong to one dma_device.
> So we _don't_ need setting DMA_PRIVATE flag for this dma_device at all, do we?

I'd phrase it a little stronger.  It's not that we don't _need_
the DMA_PRIVATE flag, it's actually that we _must_not_ use it
(unless I'm being dense, and keep missing something).  With the
DMA_PRIVATE flag set, the generic allocator will refuse to use
any channel of the only DMA controller, which totally eliminates
general use, and only leaves us with explicitly configured uses
(that would be MMC only in mainline, and nothing else).

> >> Still I see a difference in the lookup approaches:  Yours applies
> >> DMA_PRIVATE globally and in advance, preventing _any_ use of DMA
> >> for memory transfers.  While the __dma_request_channel() routine
> >> only applies it _temporarily_ around a dma_chan_get() operation.
> >> Allowing for use of DMA channels by both individual peripherals
> >> as well as memory transfers.
> >>
> > No it doesnt prevent. You can still use it for memcpy once you have the channel.

Vinod, what am I missing here?  Before probe() there is no DMA
controller.  After probe() the DMA_PRIVATE flag is set and thus
general allocation won't happen.  How exactly does one get to
"have the channel" for memory transfers?  Aren't the channel
references acquired upon demand, as the need arises?  While the
DMA controller has no means to know whether "all memory transfer
channel aquisition was done" or whether "all slave peripherals
have their channel" (if at all such a situation exists, given we
have dynamically loadable modules), such that the DMA_PRIVATE
toggle could get thrown one way or another?

This brings me back to a question I raised earlier:  Am I
overestimating the benefit or importance of DMA supported memory
transfers?  Am I wrong assuming that there are users of this
feature which need not get configured explicitly (i.e. they
operate in transparent ways, using whatever they find to be
available), and that the set of these users and their consumption
of DMA resources is something that is dynamic (i.e. driven by
demand, instead of pre-allocated and then probably inappropriate
for the workload they see)?

> Excuse me, I don't completely understand why dma_request_channel()
> needs to set DMA_PRIVATE flag.
> If dma_request_channel() for some dma_device without DMA_PRIVATE
> is called before the first dmaengine_get()
> then no DMA channels of this dma_device will become available for memcpy
> by slab allocator.
> Could you give me a clue?
> 
> >> > > Consider the fact that this driver
> >> > > handles both MPC5121 as well as MPC8308 hardware.
> >> >
> >> > Ah, yes, sorry. I should certainly fix this, if setting of DMA_PRIVATE flag
> >> > is needed at all.
> >>
> >> What I meant here is that implications for all affected platforms
> >> should be considered.  There is one driver source, but the driver
> >> applies to more than one platform (another issue of the driver is
> >> that this is not apparent from the doc nor the compat strings).
> 
> I'll add a comment with information about the supported platforms to
> mpc512x_dma.c
> in RFC PATCH 1/5. Ok?
> 
> >> So blocking memory transfers in mpc512x_dma.c is a total breakage
> >> for MPC8308 (removes the only previous feature and adds nothing),
> >> and is a regression for MPC512x (removes the previously supported
> >> memory transfers, while it may add peripheral supports with very
> >> few users).
> 
> Yes, I see. MPC512x and MPC8308 should be treated differently.

Alexander, are you suggesting to treat 512x and 8308 differently,
and did you decide how to do that?  Previous review feedback
raised the question whether this is needed or appropriate, while
there has not been an answer yet AFAICT.  I would not jump to
conclusions here, especially when you cannot test what you
change.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
