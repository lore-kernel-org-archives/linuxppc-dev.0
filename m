Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wg0-x229.google.com (mail-wg0-x229.google.com
 [IPv6:2a00:1450:400c:c00::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 72F4B2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2014 19:17:23 +1100 (EST)
Received: by mail-wg0-f41.google.com with SMTP id n12so2449075wgh.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2014 00:17:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140109111957.GE16227@intel.com>
References: <1387886789-20249-1-git-send-email-a13xp0p0v88@gmail.com>
 <1387886789-20249-5-git-send-email-a13xp0p0v88@gmail.com>
 <20131226124828.GK8064@book.gsilab.sittig.org>
 <CAF0T0X7wotm60Bq4tfYcRhkDwiCw2hh5R5m2WmVLmLGLZYpQsQ@mail.gmail.com>
 <20140108164719.GO20094@book.gsilab.sittig.org>
 <20140109111957.GE16227@intel.com>
Date: Mon, 13 Jan 2014 12:17:16 +0400
Message-ID: <CAF0T0X67RVNoJAM+9DyDM=HKw_5P4MExgXWaEj5_asqVd5hvDQ@mail.gmail.com>
Subject: Re: [PATCH RFC v6 4/5] dma: mpc512x: register for device tree channel
 lookup
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Vinod Koul <vinod.koul@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Gerhard Sittig <gsi@denx.de>, Alexander Popov <a13xp0p0v88@gmail.com>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for your replies, Gerhard and Vinod.

2014/1/9 Vinod Koul <vinod.koul@intel.com>:
> On Wed, Jan 08, 2014 at 05:47:19PM +0100, Gerhard Sittig wrote:
>> [ what is the semantics of DMA_PRIVATE capability flag?
>>   is documentation available beyond the initial commit message?
>>   need individual channels be handled instead of controllers? ]
>
> The DMA_PRIVATE means that your channels are not to be used for global memcpy,
> as one can do in async cases (this is hwere DMAengine came into existence)
>
> If the device has the capablity of doing genric memcpy then it should not set
> this. For slave dma usage the dam channel can transfer data to a specfic
> slave device(s), hence we should use this is geric fashion so setting
> DMA_PRIVATE makes sense in those cases.

Each DMA channel of MPC512x DMA controller can do _both_
mem-to-mem transfers and transfers between mem and some slave peripheral
(only one DMA channel is fully dedicated to DDR).
All DMA channels of MPC512x DMA controller belong to one dma_device.
So we _don't_ need setting DMA_PRIVATE flag for this dma_device at all, do we?

>> On Sat, Jan 04, 2014 at 00:54 +0400, Alexander Popov wrote:
>> > I've involved DMA_PRIVATE flag because new of_dma_xlate_by_chan_id()
>> > uses dma_get_slave_channel() instead of dma_request_channel()
>> > (PATCH RFC v6 3/5). This flag is implicitly set in dma_request_channel(),
>> > but is not set in dma_get_slave_channel().
> Which makes me thing you are targetting slave usages. Do you intend to use for
> mempcy too on all controllers you support. in that case you should set it
> selectively.

Vinod, please correct me if I'm wrong.
As I could understand from your comments and the code,
DMA_PRIVATE flag is needed for dma_devices with DMA channels
which _can_ work with slave peripheral but _can't_ do mem-to-mem transfers.
If DMA_PRIVATE flag is set for some dma_device before
dma_async_device_register()
then its DMA channels are not published in tables for kernel slab allocator
(because these channels are simply useless for memcpy).

>> Still I see a difference in the lookup approaches:  Yours applies
>> DMA_PRIVATE globally and in advance, preventing _any_ use of DMA
>> for memory transfers.  While the __dma_request_channel() routine
>> only applies it _temporarily_ around a dma_chan_get() operation.
>> Allowing for use of DMA channels by both individual peripherals
>> as well as memory transfers.
>>
> No it doesnt prevent. You can still use it for memcpy once you have the channel.

Excuse me, I don't completely understand why dma_request_channel()
needs to set DMA_PRIVATE flag.
If dma_request_channel() for some dma_device without DMA_PRIVATE
is called before the first dmaengine_get()
then no DMA channels of this dma_device will become available for memcpy
by slab allocator.
Could you give me a clue?

>> > > Consider the fact that this driver
>> > > handles both MPC5121 as well as MPC8308 hardware.
>> >
>> > Ah, yes, sorry. I should certainly fix this, if setting of DMA_PRIVATE flag
>> > is needed at all.
>>
>> What I meant here is that implications for all affected platforms
>> should be considered.  There is one driver source, but the driver
>> applies to more than one platform (another issue of the driver is
>> that this is not apparent from the doc nor the compat strings).

I'll add a comment with information about the supported platforms to
mpc512x_dma.c
in RFC PATCH 1/5. Ok?

>> So blocking memory transfers in mpc512x_dma.c is a total breakage
>> for MPC8308 (removes the only previous feature and adds nothing),
>> and is a regression for MPC512x (removes the previously supported
>> memory transfers, while it may add peripheral supports with very
>> few users).

Yes, I see. MPC512x and MPC8308 should be treated differently.

Thanks!
Alexander
