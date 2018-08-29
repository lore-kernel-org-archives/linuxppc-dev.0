Return-Path: <linus971@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420qcv1dp2zF325
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 01:42:22 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id j81-v6so8329629ite.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 08:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180828112034.30875-1-npiggin@gmail.com>
 <20180828112034.30875-3-npiggin@gmail.com>
In-Reply-To: <20180828112034.30875-3-npiggin@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Aug 2018 08:42:09 -0700
Message-ID: <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/cow: optimise pte dirty/accessed bits handling in
 fork
To: Nick Piggin <npiggin@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On Tue, Aug 28, 2018 at 4:20 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> fork clears dirty/accessed bits from new ptes in the child. This logic
> has existed since mapped page reclaim was done by scanning ptes when
> it may have been quite important. Today with physical based pte
> scanning, there is less reason to clear these bits.

Can you humor me, and make the dirty/accessed bit patches separate?

There is actually a difference wrt the dirty bit: if we unmap an area
with dirty pages, we have to do the special synchronous flush.

So a clean page in the virtual mapping is _literally_ cheaper to have.

> This eliminates a major source of faults powerpc/radix requires to set
> dirty/accessed bits in ptes, speeding up a fork/exit microbenchmark by
> about 5% on POWER9 (16600 -> 17500 fork/execs per second).

I don't think the dirty bit matters.

The accessed bit I think may be worth keeping, so by all means remove the mkold.

                  Linus
