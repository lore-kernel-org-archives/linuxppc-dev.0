Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QKQ86kjwzF1RD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 19:17:04 +1000 (AEST)
Received: by mail-ua0-x241.google.com with SMTP id d3so11667490uae.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 02:17:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417091129.23069-1-alistair@popple.id.au>
References: <20180417091129.23069-1-alistair@popple.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 17 Apr 2018 19:17:00 +1000
Message-ID: <CAKTCnz=nMDksZq_1pWXGqKFTQ8x5pO=Ojw=TQdPkT+ZqBwEGwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powernv/npu: Do a PID GPU TLB flush when invalidating
 a large address range
To: Alistair Popple <alistair@popple.id.au>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mark Hairgrove <mhairgrove@nvidia.com>, arbab@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 17, 2018 at 7:11 PM, Alistair Popple <alistair@popple.id.au> wrote:
> The NPU has a limited number of address translation shootdown (ATSD)
> registers and the GPU has limited bandwidth to process ATSDs. This can
> result in contention of ATSD registers leading to soft lockups on some
> threads, particularly when invalidating a large address range in
> pnv_npu2_mn_invalidate_range().
>
> At some threshold it becomes more efficient to flush the entire GPU TLB for
> the given MM context (PID) than individually flushing each address in the
> range. This patch will result in ranges greater than 2MB being converted
> from 32+ ATSDs into a single ATSD which will flush the TLB for the given
> PID on each GPU.
>
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index 94801d8e7894..dc34662e9df9 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -40,6 +40,13 @@
>  DEFINE_SPINLOCK(npu_context_lock);
>
>  /*
> + * When an address shootdown range exceeds this threshold we invalidate the
> + * entire TLB on the GPU for the given PID rather than each specific address in
> + * the range.
> + */
> +#define ATSD_THRESHOLD (2*1024*1024)
> +
> +/*
>   * Other types of TCE cache invalidation are not functional in the
>   * hardware.
>   */
> @@ -675,11 +682,19 @@ static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
>         struct npu_context *npu_context = mn_to_npu_context(mn);
>         unsigned long address;
>
> -       for (address = start; address < end; address += PAGE_SIZE)
> -               mmio_invalidate(npu_context, 1, address, false);
> +       if (end - start > ATSD_THRESHOLD) {

I'm nitpicking, but (end - start) > ATSD_THRESHOLD is clearer

> +               /*
> +                * Just invalidate the entire PID if the address range is too
> +                * large.
> +                */
> +               mmio_invalidate(npu_context, 0, 0, true);
> +       } else {
> +               for (address = start; address < end; address += PAGE_SIZE)
> +                       mmio_invalidate(npu_context, 1, address, false);
>
> -       /* Do the flush only on the final addess == end */
> -       mmio_invalidate(npu_context, 1, address, true);
> +               /* Do the flush only on the final addess == end */
> +               mmio_invalidate(npu_context, 1, address, true);
> +       }
>  }
>

Acked-by: Balbir Singh <bsingharora@gmail.com>
