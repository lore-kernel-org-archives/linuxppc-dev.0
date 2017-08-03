Return-Path: <bsingharora@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNM2f0bNdzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 17:22:34 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id d136so501110qkg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Aug 2017 00:22:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170802202930.5616-3-fbarrat@linux.vnet.ibm.com>
References: <20170802202930.5616-1-fbarrat@linux.vnet.ibm.com>
 <20170802202930.5616-3-fbarrat@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 3 Aug 2017 17:22:31 +1000
Message-ID: <CAKTCnz=f-Z4vg-1V2bsx-JGHPmnPdu_DGDNoSjsB17id=F57gQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] cxl: Mark context requiring global TLBIs
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, clombard@linux.vnet.ibm.com,
 Alistair Popple <alistair@popple.id.au>, vaibhav@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 3, 2017 at 6:29 AM, Frederic Barrat
<fbarrat@linux.vnet.ibm.com> wrote:
> The PSL and XSL need to see all TLBIs pertinent to the memory contexts
> used on the adapter. For the hash memory model, it is done by making
> all TLBIs global as soon as the cxl driver is in use. For radix, we
> need something similar, but we can refine and only convert to global
> the invalidations for contexts actually used by the device.
>
> So mark the contexts being attached to the cxl adapter as requiring
> global TLBIs.
>

Looking at these bits, I'm wondering the previous code should check
for CONFIG_CXL in mm_is_invalidation_local? That would pretty much cover
BOOK3S_64

> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/api.c    | 12 ++++++++++--
>  drivers/misc/cxl/cxllib.c |  7 +++++++
>  drivers/misc/cxl/file.c   | 12 ++++++++++--
>  3 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index 1a138c83f877..d3f3fdede755 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -332,8 +332,17 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
>                 cxl_context_mm_count_get(ctx);
>
>                 /* decrement the use count */
> -               if (ctx->mm)
> +               if (ctx->mm) {
>                         mmput(ctx->mm);
> +#ifdef CONFIG_PPC_BOOK3S_64
> +                       mm_context_set_global_tlbi(&ctx->mm->context);

Do we have CXL for non PPC_BOOK3S_64?

> +                       /*
> +                        * Barrier guarantees that the device will
> +                        * receive all TLBIs from that point on
> +                        */
> +                       wmb();

smp_wmb();

> +#endif
> +               }
>         }

The other comments are the same as this (in the snip'd code)

Balbir
