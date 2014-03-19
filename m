Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-ve0-x235.google.com (mail-ve0-x235.google.com
 [IPv6:2607:f8b0:400c:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 129BF2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 00:26:51 +1100 (EST)
Received: by mail-ve0-f181.google.com with SMTP id oy12so8965760veb.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Mar 2014 06:26:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1394790471.28803.247.camel@smile.fi.intel.com>
References: <1394624875-24411-1-git-send-email-a13xp0p0v88@gmail.com>
 <1394624875-24411-3-git-send-email-a13xp0p0v88@gmail.com>
 <1394790471.28803.247.camel@smile.fi.intel.com>
Date: Wed, 19 Mar 2014 17:26:47 +0400
Message-ID: <CAF0T0X5egegHc3pheSbPRPuZaVaktMtdUiGPOLhcWZevH=pD=A@mail.gmail.com>
Subject: Re: [PATCH RFC v9 2/6] dma: mpc512x: add support for peripheral
 transfers
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 Alexander Popov <a13xp0p0v88@gmail.com>, dmaengine@vger.kernel.org,
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

Hello Andy

2014-03-14 13:47 GMT+04:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> On Wed, 2014-03-12 at 15:47 +0400, Alexander Popov wrote:
>> +     case DMA_SLAVE_CONFIG:
>> +             /* Constraints:
>> +              *  - only transfers between a peripheral device and
>> +              *     memory are supported;
>> +              *  - minimal transfer chunk is 4 bytes and consequently
>> +              *     source and destination addresses must be 4-byte aligned
>> +              *     and transfer size must be aligned on (4 * maxburst)
>> +              *     boundary;
>> +              *  - during the transfer RAM address is being incremented by
>> +              *     the size of minimal transfer chunk;
>> +              *  - peripheral port's address is constant during the transfer.
>> +              */
>> +
>> +             cfg = (void *)arg;
>> +
>> +             if (!is_slave_direction(cfg->direction))
>> +                     return -EINVAL;
>
> As far as I understand the intention you have not to use direction field
> in the dma_slave_config. It will be removed once.
>
>> +
>> +             if (cfg->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES &&
>> +                     cfg->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
>> +                     return -EINVAL;
>> +
>> +             spin_lock_irqsave(&mchan->lock, flags);
>> +
>> +             if (cfg->direction == DMA_DEV_TO_MEM) {
>> +                     mchan->per_paddr = cfg->src_addr;
>> +                     mchan->tcd_nunits = cfg->src_maxburst;
>> +             } else {
>> +                     mchan->per_paddr = cfg->dst_addr;
>> +                     mchan->tcd_nunits = cfg->dst_maxburst;
>> +             }
>
> Ditto.

Excuse me, I don't understand this point.
I have to use cfg->direction because in case of DMA_DEV_TO_MEM
I use cfg->SRC_addr and cfg->SRC_maxburst and in case of
DMA_MEM_TO_DEV I use cfg->DST_addr and cfg->DST_maxburst.
Is it correct?

Best regards,
Alexander
