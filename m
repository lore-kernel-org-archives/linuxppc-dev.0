Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zlBTD0grNzDrhT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 16:02:55 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, Javier Cabezas <jcabezas@nvidia.com>
Subject: Re: [PATCH] powerpc/npu-dma.c: Fix deadlock in mmio_invalidate
Date: Mon, 19 Feb 2018 16:02:52 +1100
Message-ID: <1563550.Ytkt8OtJkB@new-mexico>
In-Reply-To: <20180219135704.3bd0cfb9@balbir.ozlabs.ibm.com>
References: <20180213031734.19831-1-alistair@popple.id.au>
 <alpine.DEB.2.00.1802151910400.10245@mdh-linux64-2.nvidia.com>
 <20180219135704.3bd0cfb9@balbir.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Shouldn't that be enforced with READ_ONCE() then?

Yep, I can add that.

> Good point, although I think the acquire_* function itself may be called
> from a higher layer with the mmap_sem always held. I wonder if we need
> barriers around get and put mmio_atsd_reg.

test_and_set_bit() should imply a memory barrier so I don't think we need one
there (and looking at the implementation there is one). clear_bit() might need
one though. For that I guess I could use clear_bit_unlock()? There is also a
matching test_and_set_bit_lock() so I will submit a v2 which uses those instead
given we are using these like a lock.

> > > I don't think we can as the invalidate_range() function is called under the ptl
> > > spin-lock and is not allowed to sleep (at least according to
> > > include/linux/mmu_notifier.h).
> 
> I double checked, It's the reverse
> 
> 	 /*
>           * If both of these callbacks cannot block, mmu_notifier_ops.flags
>           * should have MMU_INVALIDATE_DOES_NOT_BLOCK set.
>           */

Argh, that must have been merged during the current window. Thanks for pointing
out - I will submit a seperate patch to update the mmu_notifier_ops.flags to set
MMU_INVALIDATE_DOES_NOT_BLOCK.

- Alistair

>          void (*invalidate_range_start)(struct mmu_notifier *mn,
>                                         struct mm_struct *mm,
>                                         unsigned long start, unsigned long end);
>          void (*invalidate_range_end)(struct mmu_notifier *mn,
>                                       struct mm_struct *mm,
>                                       unsigned long start, unsigned long end);
> > > 
> > > - Alistair
> > >   
> > > > Balbir
> > > >   
> > > 
> > > 
> > >   
> 
> I think it looks good to me otherwise,
> 
> Balbir Singh.
> 
