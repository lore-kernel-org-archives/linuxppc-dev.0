Return-Path: <linus971@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415tfV0m9FzDrpC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 16:16:01 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id 16-v6so6825289itl.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 23:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180612071621.26775-1-npiggin@gmail.com>
 <20180612071621.26775-4-npiggin@gmail.com>
 <CA+55aFzKBieD0Y3sgFQzt+x5esqb9vT6SEQ28xyCz5UWegfFVg@mail.gmail.com>
 <20180613083131.139a3c34@roar.ozlabs.ibm.com>
 <CA+55aFyk9VBLUk8VYhfEUR55x0TXY9_QX1dE4wE0A_ias9tMNQ@mail.gmail.com>
 <20180613090950.50566245@roar.ozlabs.ibm.com>
 <CA+55aFxd97-29qi-JMxyPPoZMxw=eObQHB5XXGiLj7SNV8B-oQ@mail.gmail.com>
 <CA+55aFzbYBXUDcAGaP_HoCxjTvOgkixc0+7nJqMea0yKjLSnhw@mail.gmail.com>
 <20180613101241.004fd64e@roar.ozlabs.ibm.com>
 <CA+55aFzJRknbQD6Mv3OSOvUVozQ4H8ni8jPP7UEEi9wKXmVhQA@mail.gmail.com>
 <20180614124931.703e5b54@roar.ozlabs.ibm.com>
In-Reply-To: <20180614124931.703e5b54@roar.ozlabs.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Jun 2018 15:15:47 +0900
Message-ID: <CA+55aFwP-6QZ0u2ZYCjTebP6OmkeTpbUHyLT0ih-57TbvJBPxg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] powerpc/64s/radix: optimise TLB flush with
 precise TLB ranges in mmu_gather
To: Nick Piggin <npiggin@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>,
 Minchan Kim <minchan@kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>, Nadav Amit <nadav.amit@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 14, 2018 at 11:49 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> +#ifndef pte_free_tlb
>  #define pte_free_tlb(tlb, ptep, address)                       \
>         do {                                                    \
>                 __tlb_adjust_range(tlb, address, PAGE_SIZE);    \
>                 __pte_free_tlb(tlb, ptep, address);             \
>         } while (0)
> +#endif

Do you really want to / need to take over the whole pte_free_tlb macro?

I was hoping that you'd just replace the __tlv_adjust_range() instead.

Something like

 - replace the

        __tlb_adjust_range(tlb, address, PAGE_SIZE);

   with a "page directory" version:

        __tlb_free_directory(tlb, address, size);

 - have the default implementation for that be the old code:

        #ifndef __tlb_free_directory
          #define __tlb_free_directory(tlb,addr,size)
__tlb_adjust_range(tlb, addr, PAGE_SIZE)
        #endif

and that way architectures can now just hook into that
"__tlb_free_directory()" thing.

Hmm?

             Linus
