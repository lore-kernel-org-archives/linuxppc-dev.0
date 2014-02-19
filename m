Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com
 [IPv6:2a00:1450:400c:c00::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A0EFC2C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 01:45:24 +1100 (EST)
Received: by mail-wg0-f46.google.com with SMTP id x13so402940wgg.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 06:45:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140213000743.GI4524@book.gsilab.sittig.org>
References: <1392211508-23615-1-git-send-email-a13xp0p0v88@gmail.com>
 <1392211508-23615-3-git-send-email-a13xp0p0v88@gmail.com>
 <20140213000743.GI4524@book.gsilab.sittig.org>
Date: Wed, 19 Feb 2014 18:45:17 +0400
Message-ID: <CAF0T0X4CSVqRN79tcnNFZWCtT2ighEt5QvOjVOvzHSRgtwQuoQ@mail.gmail.com>
Subject: Re: [PATCH RFC v7 2/6] dma: mpc512x: add support for peripheral
 transfers
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
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

[ adding dmaengine ML to Cc: ]

Thanks for your feedback, Gerhard

2014-02-13 4:07 GMT+04:00 Gerhard Sittig <gsi@denx.de>:
> On Wed, Feb 12, 2014 at 17:25 +0400, Alexander Popov wrote:
>>  /*
>> - * This is initial version of MPC5121 DMA driver. Only memory to memory
>> - * transfers are supported (tested using dmatest module).
>> + * MPC512x and MPC8308 DMA driver. It supports
>> + * memory to memory data transfers (tested using dmatest module) and
>> + * data transfers between memory and peripheral I/O memory
>> + * by means of slave s/g with these limitations:
>> + * - chunked transfers (transfers with more than one part) are refused
>> + * as long as proper support for scatter/gather is missing;
>> + * - transfers on MPC8308 always start from software as this SoC appears
>> + * not to have external request lines for peripheral flow control;
>> + * - minimal memory <-> I/O memory transfer size is 4 bytes.
>>   */
>
> Often I assume people would notice themselves, and apparently I'm
> wrong. :)  Can you adjust the formatting such (here and
> elsewhere) that the bullet list is clearly visible as such?
> Flowing text like above obfuscates the fact that the content may
> have a structure ...
Ok, thanks :)

> There are known limitations which are not listed here, "minimal
> transfer size" is incomplete.  It appears that you assume
> constraints on start addresses as well as sizes/lengths.  Can you
> update the documentation to match the implementation?
Ok, I see. How about that?
* - minimal memory <-> I/O memory transfer chunk is 4 bytes and consequently
*     source and destination addresses must be 4-byte aligned
*     and transfer size must be aligned on (4 * maxburst) boundary;

>> +             /* Grab either several mem-to-mem transfer descriptors
>> +              * or one peripheral transfer descriptor,
>> +              * don't mix mem-to-mem and peripheral transfer descriptors
>> +              * within the same 'active' list. */
>> +             if (mdesc->will_access_peripheral) {
>> +                     if (list_empty(&mchan->active))
>> +                             list_move_tail(&mdesc->node, &mchan->active);
>> +                     break;
>> +             } else
>> +                     list_move_tail(&mdesc->node, &mchan->active);
>> +     }
> There are style issues.  Both in multi line comments, and in the
> braces of the if/else block.
Ah, thanks! I'll fix that.

>> +     struct mpc_dma *mdma = dma_chan_to_mpc_dma(chan);
>> +     struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(chan);
>> +     struct mpc_dma_desc *mdesc = NULL;
>> +     dma_addr_t per_paddr;
>> +     u32 tcd_nunits;
>> +     struct mpc_dma_tcd *tcd;
>> +     unsigned long iflags;
>> +     struct scatterlist *sg;
>> +     size_t len;
>> +     int iter, i;
> Personally I much dislike this style of mixing declarations and
> instructions.  But others may disagree, and strongly so.
Excuse me, I would like to keep it similar to other parts of this driver
and not to change that style.

>> +             mdesc = list_first_entry(&mchan->free, struct mpc_dma_desc,
>> +                                                                     node);
> style (continuation and indentation)
Thanks! I'll fix that.

>
>> +             if (!mdesc) {
>> +                     spin_unlock_irqrestore(&mchan->lock, iflags);
>> +                     /* try to free completed descriptors */
>> +                     mpc_dma_process_completed(mdma);
>> +                     return NULL;
>> +             }
>> +
>> +             list_del(&mdesc->node);
>> +
>> +             per_paddr = mchan->per_paddr;
>> +             tcd_nunits = mchan->tcd_nunits;
>> +
>> +             spin_unlock_irqrestore(&mchan->lock, iflags);
>> +
>> +             if (per_paddr == 0 || tcd_nunits == 0)
>> +                     goto err_prep;
>> +
>> +             mdesc->error = 0;
>> +             mdesc->will_access_peripheral = 1;
>> +             tcd = mdesc->tcd;
>> +
>> +             /* Prepare Transfer Control Descriptor for this transaction */
>> +
>> +             memset(tcd, 0, sizeof(struct mpc_dma_tcd));
>> +
>> +             if (!IS_ALIGNED(sg_dma_address(sg), 4))
>> +                     goto err_prep;
>
> You found multiple ways of encoding the "4 byte alignment", using
> both the fixed number as well as (several) symbolic identifiers.
> Can you look into making them use the same condition if the same
> motivation is behind the test?
Gerhard, I don't see checks which can be kind of "merged"
since they have different motivation behind:
1) src_addr_width and dst_addr_width have type "enum dma_slave_buswidth"
and are compared with DMA_SLAVE_BUSWIDTH_4_BYTES which has
the same type;
2) source and destination addresses are checked to be 4-byte aligned;
3) transfer size is checked to be aligned on nbytes boundary
which is (4 * maxburst).

I think the code provides good readability. What do you think?

Thank you!

Best regards,
Alexander
