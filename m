Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wg0-x236.google.com (mail-wg0-x236.google.com
 [IPv6:2a00:1450:400c:c00::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 907B62C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jan 2014 07:54:44 +1100 (EST)
Received: by mail-wg0-f54.google.com with SMTP id n12so13684622wgh.33
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jan 2014 12:54:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131226124828.GK8064@book.gsilab.sittig.org>
References: <1387886789-20249-1-git-send-email-a13xp0p0v88@gmail.com>
 <1387886789-20249-5-git-send-email-a13xp0p0v88@gmail.com>
 <20131226124828.GK8064@book.gsilab.sittig.org>
Date: Sat, 4 Jan 2014 00:54:38 +0400
Message-ID: <CAF0T0X7wotm60Bq4tfYcRhkDwiCw2hh5R5m2WmVLmLGLZYpQsQ@mail.gmail.com>
Subject: Re: [PATCH RFC v6 4/5] dma: mpc512x: register for device tree channel
 lookup
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Anatolij Gustschin <agust@denx.de>, Alexander Popov <a13xp0p0v88@gmail.com>,
 linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Gerhard.
Thanks for your review.

2013/12/26 Gerhard Sittig <gsi@denx.de>:
> [ dropping devicetree, we're DMA specific here ]
>
> On Tue, Dec 24, 2013 at 16:06 +0400, Alexander Popov wrote:
>>
>> --- a/drivers/dma/mpc512x_dma.c
>> +++ b/drivers/dma/mpc512x_dma.c
>> [ ... ]
>> @@ -950,6 +951,7 @@ static int mpc_dma_probe(struct platform_device *op)
>>       INIT_LIST_HEAD(&dma->channels);
>>       dma_cap_set(DMA_MEMCPY, dma->cap_mask);
>>       dma_cap_set(DMA_SLAVE, dma->cap_mask);
>> +     dma_cap_set(DMA_PRIVATE, dma->cap_mask);
>>
>>       for (i = 0; i < dma->chancnt; i++) {
>>               mchan = &mdma->channels[i];
>
> What are the implications of this?  Is a comment due?

I've involved DMA_PRIVATE flag because new of_dma_xlate_by_chan_id()
uses dma_get_slave_channel() instead of dma_request_channel()
(PATCH RFC v6 3/5). This flag is implicitly set in dma_request_channel(),
but is not set in dma_get_slave_channel().

There are only two places in the mainline kernel, where
dma_get_slave_channel() is used. I've picked up the idea
at one of these places. Please look at this patch:
http://www.spinics.net/lists/arm-kernel/msg268718.html

> I haven't found documentation about the DMA_PRIVATE flag, only
> saw commit 59b5ec21446b9 "dmaengine: introduce
> dma_request_channel and private channels".

Unfortunately I didn't find any description of DMA_PRIVATE flag too.
But the comment at the beginning of drivers/dma/dmaengine.c
may give a clue. Quotation:
  * subsystem can get access to a channel by calling dmaengine_get() followed
  * by dma_find_channel(), or if it has need for an exclusive channel
it can call
  * dma_request_channel().  Once a channel is allocated a reference is taken
  * against its corresponding driver to disable removal.

DMA_PRIVATE capability flag might indicate that the DMA controller
can provide exclusive channels to its clients. Please correct me if I'm wrong.

> Alex, unless I'm
> missing something this one-line change is quite a change in
> semantics, and has dramatic influence on the code's behaviour
> (ignores the DMA controller when looking for channels that can do
> mem-to-mem transfers)

Excuse me, Gerhard, I don't see what you mean.
Could you point to the corresponding code?

> Consider the fact that this driver
> handles both MPC5121 as well as MPC8308 hardware.

Ah, yes, sorry. I should certainly fix this, if setting of DMA_PRIVATE flag
is needed at all.

Thanks!

Best regards,
Alexander
