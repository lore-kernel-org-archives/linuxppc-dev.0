Return-Path: <joel.stan@gmail.com>
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DGyG5W2zzDqsy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 16:52:05 +1000 (AEST)
Received: by mail-qk1-x741.google.com with SMTP id g13-v6so8454382qki.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Sep 2018 23:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180914153056.3644-1-npiggin@gmail.com>
 <20180914153056.3644-2-npiggin@gmail.com>
In-Reply-To: <20180914153056.3644-2-npiggin@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 17 Sep 2018 16:21:51 +0930
Message-ID: <CACPK8XcEQdSbUN=bRECfWeV6ZR2Pm9LM5wB83GSmAr63NH1hpg@mail.gmail.com>
Subject: Re: [PATCH 01/12] powerpc/64s/hash: Fix stab_rr off by one
 initialization
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 15 Sep 2018 at 01:03, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> This causes SLB alloation to start 1 beyond the start of the SLB.
> There is no real problem because after it wraps it stats behaving

starts?

> properly, it's just surprisig to see when looking at SLB traces.

surprising

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/mm/slb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 9f574e59d178..2f162c6e52d4 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -355,7 +355,7 @@ void slb_initialize(void)
>  #endif
>         }
>
> -       get_paca()->stab_rr = SLB_NUM_BOLTED;
> +       get_paca()->stab_rr = SLB_NUM_BOLTED - 1;
>
>         lflags = SLB_VSID_KERNEL | linear_llp;
>         vflags = SLB_VSID_KERNEL | vmalloc_llp;
> --
> 2.18.0
>
