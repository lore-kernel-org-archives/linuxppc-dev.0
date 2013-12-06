Return-Path: <lars@metafoo.de>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.informatik.uni-hamburg.de",
 Issuer "UHH CA - G02" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A9942C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 07:34:00 +1100 (EST)
Message-ID: <52A234F5.9030300@metafoo.de>
Date: Fri, 06 Dec 2013 21:35:01 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v4 2/5] dma: mpc512x: add support for peripheral
 transfers
References: <1380809202-16192-1-git-send-email-a13xp0p0v88@gmail.com>
 <20131006111038.GN14747@book.gsilab.sittig.org>
 <CAF0T0X6XhHk5qhwk=Kzu_YvMNduZaMqNxGWRyyeNP8LWzDJziw@mail.gmail.com>
In-Reply-To: <CAF0T0X6XhHk5qhwk=Kzu_YvMNduZaMqNxGWRyyeNP8LWzDJziw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/06/2013 09:27 PM, Alexander Popov wrote:
> 2013/10/6 Gerhard Sittig <gsi@denx.de>:
>> On Thu, Oct 03, 2013 at 18:06 +0400, Alexander Popov wrote:
>>> +
>>> +             spin_lock_irqsave(&mchan->lock, flags);
>>> +
>>> +             if (cfg->direction == DMA_DEV_TO_MEM) {
>>
>> Note that cfg->direction is of a different type than
>> DMA_DEV_TO_MEM (of different type than the 'direction' parameter
>> in the preparation routine) -- it's mere coincidence that the
>> numeric values happen to match at the moment.
>
> Gerhard, it seems to me that this code is correct.
> Cite from dmaengine.h:
>
>    * struct dma_slave_config - dma slave channel runtime config
>    * @direction: whether the data shall go in or out on this slave
>    * channel, right now. DMA_TO_DEVICE and DMA_FROM_DEVICE are
>    * legal values, DMA_BIDIRECTIONAL is not acceptable since we
>    * need to differentiate source and target addresses.
>    ...
>    struct dma_slave_config {
>            enum dma_transfer_direction direction;
>            ...
>    };
>
> The comment above the definition is obsolete, isn't it?

Yes, the comment seems to be out of date. Care to send a patch fixing it?

- Lars
