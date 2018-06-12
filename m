Return-Path: <linus971@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414ynF0MvMzF4lq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 04:18:40 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id y127-v6so14865544itd.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 11:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180612071621.26775-1-npiggin@gmail.com>
 <20180612071621.26775-4-npiggin@gmail.com>
In-Reply-To: <20180612071621.26775-4-npiggin@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Jun 2018 11:18:27 -0700
Message-ID: <CA+55aFzKBieD0Y3sgFQzt+x5esqb9vT6SEQ28xyCz5UWegfFVg@mail.gmail.com>
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

On Tue, Jun 12, 2018 at 12:16 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> This brings the number of tlbiel instructions required by a kernel
> compile from 33M to 25M, most avoided from exec->shift_arg_pages.

And this shows that "page_start/end" is purely for powerpc and used
nowhere else.

The previous patch should have been to purely powerpc page table
walking and not touch asm-generic/tlb.h

I think you should make those changes to
arch/powerpc/include/asm/tlb.h. If that means you can't use the
generic header, then so be it.

Or maybe you can embed the generic case in some ppc-specific
structures, and use 90% of the generic code just with your added
wrappers for that radix invalidation on top.

But don't make other architectures do pointless work that doesn't
matter - or make sense - for them.

               Linus
