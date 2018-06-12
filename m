Return-Path: <linus971@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414yhM2sZyzF4t6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 04:14:23 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id n7-v6so505837itn.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 11:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180612071621.26775-1-npiggin@gmail.com>
 <20180612071621.26775-3-npiggin@gmail.com>
In-Reply-To: <20180612071621.26775-3-npiggin@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Jun 2018 11:14:10 -0700
Message-ID: <CA+55aFxaVyTZmKdywAGVopmWeDirb1Ou49XD_SfqGQL_ox_65Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] mm: mmu_gather track of invalidated TLB ranges
 explicitly for more precise flushing
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

On Tue, Jun 12, 2018 at 12:16 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> +static inline void __tlb_adjust_page_range(struct mmu_gather *tlb,
> +                                     unsigned long address,
> +                                     unsigned int range_size)
> +{
> +       tlb->page_start = min(tlb->page_start, address);
> +       tlb->page_end = max(tlb->page_end, address + range_size);
> +}

Why add this unnecessary complexity for architectures where it doesn't matter?

This is not "generic". This is some crazy powerpc special case. Why
add it to generic code, and why make everybody else take the cost?

                    Linus
