Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-we0-x22b.google.com (mail-we0-x22b.google.com
 [IPv6:2a00:1450:400c:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0AE782C0337
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 20:15:22 +1000 (EST)
Received: by mail-we0-f171.google.com with SMTP id m46so7873429wev.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 03:15:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130710125811.GB2615@book.gsilab.sittig.org>
References: <1373451651-20029-1-git-send-email-a13xp0p0v88@gmail.com>
 <20130710125811.GB2615@book.gsilab.sittig.org>
Date: Fri, 12 Jul 2013 14:15:16 +0400
Message-ID: <CAF0T0X70wa1DBPtvccr+-cb9_2AAw1tFaqJSt7_7GP-xa1qyVg@mail.gmail.com>
Subject: Re: [V2 1/2] powerpc: mpc512x_dma: add support for data transfers
 between memory and i/o memory
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Alexander Popov <a13xp0p0v88@gmail.com>, Vinod Koul <vinod.koul@intel.com>,
 Dan Williams <djbw@fb.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/7/10 Gerhard Sittig <gsi@denx.de>:
> Disclaimer:  It's been a while since I worked with the MPC512x
> DMA controller, and I only read the RM rev3 back then.

Hello Gerhard.

Thank you for fast and detailed feedback.

>> @@ -256,7 +256,9 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
>>
>>               prev->tcd->dlast_sga = mdesc->tcd_paddr;
>>               prev->tcd->e_sg = 1;
>> -             mdesc->tcd->start = 1;
>> +             /* only start explicitly on MDDRC channel */
>> +             if (cid == 32)
>> +                     mdesc->tcd->start = 1;
>>
>>               prev = mdesc;
>>       }
>> @@ -268,7 +270,15 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
>>
>>       if (first != prev)
>>               mdma->tcd[cid].e_sg = 1;
>> -     out_8(&mdma->regs->dmassrt, cid);
>> +
>> +     switch (cid) {
>> +     case 26:
>> +             out_8(&mdma->regs->dmaserq, cid);
>> +             break;
>> +     case 32:
>> +             out_8(&mdma->regs->dmassrt, cid);
>> +             break;
>> +     }
>>  }
>>
>>  /* Handle interrupt on one half of DMA controller (32 channels) */

> This part of the change looks suspicious to me.  The logic
> changes from always starting the transfer in software to only
> starting from software for memory or having hardware request the
> start for LPB controller requests, while _all_other_ channels
> remain without setup of the start condition.
>
> Either make sure that only the new source (LPB) gets handled
> specially, or

I agree, I'll use this way.

> In addition, try to get rid of the magic numbers.  Use symbolic
> identifiers instead (regardless of whether other floating patches
> used magic numbers as well).

Ok.

>> +             if (!IS_ALIGNED(sg_dma_address(sg), 4))
>> +                     return NULL;
>> +
>> +             if (direction == DMA_DEV_TO_MEM) {
>> +                     tcd->saddr = mchan->per_paddr;
>> +                     tcd->daddr = sg_dma_address(sg);
>> +                     tcd->soff = 0;
>> +                     tcd->doff = 4;
>> +             } else if (direction == DMA_MEM_TO_DEV) {
>> +                     tcd->saddr = sg_dma_address(sg);
>> +                     tcd->daddr = mchan->per_paddr;
>> +                     tcd->soff = 4;
>> +                     tcd->doff = 0;
>> +             } else {
>> +                     return NULL;
>> +             }
>> +             tcd->ssize = MPC_DMA_TSIZE_4;
>> +             tcd->dsize = MPC_DMA_TSIZE_4;

> This hardcodes the address increments and the source and
> destination port sizes to 32bits, right?  This may be an
> acceptable limitation given the current use of the DMA engine,
> but might need a comment as well.

Ok, I'll add it.

>> +             } else {
>> +                     /* citer_linkch contains the high bits of iter */
>> +                     tcd->biter = iter & 0x1ff;
>> +                     tcd->biter_linkch = iter >> 9;
>> +                     tcd->citer = tcd->biter;
>> +                     tcd->citer_linkch = tcd->biter_linkch;
>> +             }

> I cannot tell how these magic numbers here (bit masks, shift
> numbers) are acceptable or shall get replaced by something else.
> Just pointing at potential for improvement. :)

This piece of code may become clearer if I improve the comment.

>> +
>> +             tcd->e_sg = 0;
>> +             tcd->d_req = 1;
>> +
>> +             /* Place descriptor in prepared list */
>> +             spin_lock_irqsave(&mchan->lock, iflags);
>> +             list_add_tail(&mdesc->node, &mchan->prepared);
>> +             spin_unlock_irqrestore(&mchan->lock, iflags);
>> +     }
>> +
>> +     /* Return the last descriptor */
>> +     return &mdesc->desc;
>> +}
>> +

> It's not related to your specific patch, but I guess that the
> current implementation of the MPC512x DMA engine cannot really
> cope with scatter/gather as it should.  Unfortunately the Linux
> DMA API appears to "somehow intermingle" the S/G aspect with
> "peripheral access", while it actually should be orthogonal.

That's why I tried to add my code to mpc_dma_prep_memcpy()
in the first version of this patch.

> To cut it short:  As long as "mdesc" items and "TCD" items can't
> get allocated and chained individually, and as long as the prep
> and submit routines assume that an mdesc is associated with
> exactly one tcd, there should be a comment about this limitation
> or even better an explicit check in the prep slave sg routine to
> reject S/G lists with more than one entry.

I'll fix that and return with the third version.

Best regards,
Alexander
