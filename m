Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42AA014007D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 19:49:25 +1000 (EST)
Received: by mail-wg0-f42.google.com with SMTP id y10so2195068wgg.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 May 2014 02:49:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140502170333.GJ32284@intel.com>
References: <1398261209-5578-1-git-send-email-a13xp0p0v88@gmail.com>
 <1398261209-5578-4-git-send-email-a13xp0p0v88@gmail.com>
 <20140502170333.GJ32284@intel.com>
Date: Thu, 8 May 2014 13:49:20 +0400
Message-ID: <CAF0T0X6XBe-xcgXJ3M0QhxeHuK7H+H_neAWn_ChFxU6pr-QqXQ@mail.gmail.com>
Subject: Re: [PATCH RFC v12 3/7] dma: mpc512x: add support for peripheral
 transfers
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Vinod Koul <vinod.koul@intel.com>
Content-Type: text/plain; charset=UTF-8
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Gerhard Sittig <gsi@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.jf.intel.com>,
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

Hello, Vinod.
Thanks for your feedback.

2014-05-02 21:03 GMT+04:00 Vinod Koul <vinod.koul@intel.com>:
> On Wed, Apr 23, 2014 at 05:53:25PM +0400, Alexander Popov wrote:
>> +static struct dma_async_tx_descriptor *
>> +mpc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>> +             unsigned int sg_len, enum dma_transfer_direction direction,
>> +             unsigned long flags, void *context)
>> +{
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
>> +
>> +     /* Currently there is no proper support for scatter/gather */
> Why? Is this HW or SW limitation?
This is the software limitation.

As Gerhard noticed, unfortunately the Linux DMA API combines
peripheral access with scatter/gather function.

But the original MPC512x DMA driver already uses scatter/gather feature
of the hardware for chaining together individual mpc_dma_desc's
in mpc_dma_execute() while mpc_dma_desc itself cannot use
scatter/gather feature, because each mpc_dma_desc is associated
with exactly one mpc_dma_tcd.

>> +             if (direction == DMA_DEV_TO_MEM) {
>> +                     tcd->saddr = per_paddr;
>> +                     tcd->daddr = sg_dma_address(sg);
>> +                     tcd->soff = 0;
>> +                     tcd->doff = 4;
> what are these?
SOFF is source address signed offset. It is applied to the current
source address to form the next-state value as each source read is completed.
DOFF is destination address signed offset.

>> +     case DMA_TERMINATE_ALL:
>> +             /* Disable channel requests */
>> +             mdma = dma_chan_to_mpc_dma(chan);
>> +
>> +             spin_lock_irqsave(&mchan->lock, flags);
>> +
>> +             out_8(&mdma->regs->dmacerq, chan->chan_id);
>> +             list_splice_tail_init(&mchan->prepared, &mchan->free);
>> +             list_splice_tail_init(&mchan->queued, &mchan->free);
>> +             list_splice_tail_init(&mchan->active, &mchan->free);
>> +
>> +             spin_unlock_irqrestore(&mchan->lock, flags);
>> +
>> +             return 0;
> empty line after this pls
ok

>> +     case DMA_SLAVE_CONFIG:
>> +             /*
>> +              * Constraints:
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
>> +             if (cfg->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES ||
>> +                 cfg->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES ||
> and why this limtation, doesnt seem covered above?
I created this limitation because FIFO registers of LPC and SDHC
support _only_ 4-byte access.

I tried to cover this limitation in the statement "minimal transfer chunk
is 4 bytes". Should I make it more explicit?

>> +                 !IS_ALIGNED(cfg->src_addr, 4) ||
>> +                 !IS_ALIGNED(cfg->dst_addr, 4)) {
>> +                     return -EINVAL;
>> +             }
>> +
>> +             spin_lock_irqsave(&mchan->lock, flags);
>> +
>> +             mchan->src_per_paddr = cfg->src_addr;
>> +             mchan->src_tcd_nunits = cfg->src_maxburst;
>> +             mchan->dst_per_paddr = cfg->dst_addr;
>> +             mchan->dst_tcd_nunits = cfg->dst_maxburst;
>> +
>> +             /* Apply defaults */
>> +             if (mchan->src_tcd_nunits == 0)
>> +                     mchan->src_tcd_nunits = 1;
>> +             if (mchan->dst_tcd_nunits == 0)
>> +                     mchan->dst_tcd_nunits = 1;
>> +
>> +             spin_unlock_irqrestore(&mchan->lock, flags);
>> +
>> +             return 0;
> empty line here too
ok

Best regards,
Alexander
