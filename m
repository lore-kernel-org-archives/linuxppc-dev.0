Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrrz44Dc4zF1YT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 21:14:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>,
 Mark Hairgrove <mhairgrove@nvidia.com>,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH v2] powerpc/npu-dma.c: Fix deadlock in mmio_invalidate
In-Reply-To: <20180228003814.32124-1-alistair@popple.id.au>
References: <20180228003814.32124-1-alistair@popple.id.au>
Date: Wed, 28 Feb 2018 21:14:48 +1100
Message-ID: <877eqx4e07.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alistair Popple <alistair@popple.id.au> writes:

> When sending TLB invalidates to the NPU we need to send extra flushes due
> to a hardware issue. The original implementation would lock the all the
> ATSD MMIO registers sequentially before unlocking and relocking each of
> them sequentially to do the extra flush.
>
> This introduced a deadlock as it is possible for one thread to hold one
> ATSD register whilst waiting for another register to be freed while the
> other thread is holding that register waiting for the one in the first
> thread to be freed.
>
> For example if there are two threads and two ATSD registers:
>
> Thread A	Thread B
> Acquire 1
> Acquire 2
> Release 1	Acquire 1
> Wait 1		Wait 2
>
> Both threads will be stuck waiting to acquire a register resulting in an
> RCU stall warning or soft lockup.
>
> This patch solves the deadlock by refactoring the code to ensure registers
> are not released between flushes and to ensure all registers are either
> acquired or released together and in order.
>
> Fixes: bbd5ff50afff ("powerpc/powernv/npu-dma: Add explicit flush when sending an ATSD")
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
>
> ---
>
> v2: Added memory barriers around ->npdev[] and ATSD register aquisition/release

Apologies to Balbir who was standing nearby when I read this patch this
afternoon and copped a bit of a rant as a result ...

But READ_ONCE/WRITE_ONCE are not memory barriers, they are only compiler
barriers.

So the READ_ONCE/WRITE_ONCE usage in here may be necessary, but it's
probably not sufficient, we probably *also* need actual memory barriers.

But I could be wrong, my main gripe is that the locking/ordering in here
is not very obvious.

> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index 0a253b64ac5f..2fed4b116e19 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -726,7 +749,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>  	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
>  							&nvlink_index)))
>  		return ERR_PTR(-ENODEV);
> -	npu_context->npdev[npu->index][nvlink_index] = npdev;
> +	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], npdev);
  
When you're publishing a struct via a pointer you would typically have a
barrier between the stores that set the fields of the struct, and the
store that publishes the struct. Otherwise the reader can see a
partially setup struct.

I think here the npdev was setup somewhere else, and maybe there has
been an intervening barrier, but it's not clear. A comment at least
would be good.

In general I feel like a spinlock or two could significantly simply the
locking/ordering in this code, and given we're doing MMIOs anyway would
not affect performance.

</rant>

cheers
