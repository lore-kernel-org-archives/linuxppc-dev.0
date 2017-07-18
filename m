Return-Path: <srs0=uhf0=6v=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBMPh3K2lzDrFM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 11:04:24 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xBMPh2ftPz8swj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 11:04:24 +1000 (AEST)
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xBMPg4WHvz9s82
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2017 11:04:22 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id 19so796075qty.1
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2017 18:04:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500015083-23511-1-git-send-email-mpe@ellerman.id.au>
References: <1500015083-23511-1-git-send-email-mpe@ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 18 Jul 2017 11:04:20 +1000
Message-ID: <CAKTCnzmehZcqd=nKLBV7xhbBmt3r2+=fm9A2nSWGoKDezrdn-A@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc/mm/radix: Refactor radix__mark_rodata_ro()
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 14, 2017 at 4:51 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Move the core logic into a helper, so we can use it for changing permissions
> other than _PAGE_WRITE.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 8c13e4282308..336e52ec652c 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -112,10 +112,9 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
>  }
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -void radix__mark_rodata_ro(void)
> +void radix__change_memory_range(unsigned long start, unsigned long end,
> +                               unsigned long clear)
>  {
> -       unsigned long start = (unsigned long)_stext;
> -       unsigned long end = (unsigned long)__init_begin;
>         unsigned long idx;
>         pgd_t *pgdp;
>         pud_t *pudp;
> @@ -125,7 +124,8 @@ void radix__mark_rodata_ro(void)
>         start = ALIGN_DOWN(start, PAGE_SIZE);
>         end = PAGE_ALIGN(end); // aligns up
>
> -       pr_devel("marking ro start %lx, end %lx\n", start, end);
> +       pr_debug("Changing flags on range %lx-%lx removing 0x%lx\n",
> +                start, end, clear);
>
>         for (idx = start; idx < end; idx += PAGE_SIZE) {
>                 pgdp = pgd_offset_k(idx);
> @@ -147,11 +147,21 @@ void radix__mark_rodata_ro(void)
>                 if (!ptep)
>                         continue;
>  update_the_pte:
> -               radix__pte_update(&init_mm, idx, ptep, _PAGE_WRITE, 0, 0);
> +               radix__pte_update(&init_mm, idx, ptep, clear, 0, 0);
>         }
>
>         radix__flush_tlb_kernel_range(start, end);
>  }
> +
> +void radix__mark_rodata_ro(void)
> +{
> +       unsigned long start, end;
> +
> +       start = (unsigned long)_stext;
> +       end = (unsigned long)__init_begin;
> +
> +       radix__change_memory_range(start, end, _PAGE_WRITE);
> +}
>  #endif /* CONFIG_STRICT_KERNEL_RWX */
>

Looks good, I had something similar for the patches to enable
relocation, but that's a
a larger chunk.

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
