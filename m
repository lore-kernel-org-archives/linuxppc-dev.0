Return-Path: <linus971@gmail.com>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4155cm1L7FzF4vM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 09:26:47 +1000 (AEST)
Received: by mail-io0-x244.google.com with SMTP id t6-v6so1389898iob.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 16:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180612071621.26775-1-npiggin@gmail.com>
 <20180612071621.26775-4-npiggin@gmail.com>
 <CA+55aFzKBieD0Y3sgFQzt+x5esqb9vT6SEQ28xyCz5UWegfFVg@mail.gmail.com>
 <20180613083131.139a3c34@roar.ozlabs.ibm.com>
 <CA+55aFyk9VBLUk8VYhfEUR55x0TXY9_QX1dE4wE0A_ias9tMNQ@mail.gmail.com>
 <20180613090950.50566245@roar.ozlabs.ibm.com>
In-Reply-To: <20180613090950.50566245@roar.ozlabs.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Jun 2018 16:26:33 -0700
Message-ID: <CA+55aFxd97-29qi-JMxyPPoZMxw=eObQHB5XXGiLj7SNV8B-oQ@mail.gmail.com>
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

On Tue, Jun 12, 2018 at 4:09 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Sorry I mean Intel needs the existing behaviour of range flush expanded
> to cover page table pages.... right?

Right.  Intel depends on the current thing, ie if a page table
*itself* is freed, we will will need to do a flush, but it's the exact
same flush as if there had been a regular page there.

That's already handled by (for example) pud_free_tlb() doing the
__tlb_adjust_range().

Again, I may be missing entirely what you're talking about, because it
feels like we're talking across each other.

My argument is that your new patches in (2-3 in the series - patch #1
looks ok) seem to be fundamentally specific to things that have a
*different* tlb invalidation for the directory entries than for the
leaf entries.

But that's not what at least x86 has, and not what the generic code has done.

I think it might be fine to introduce a few new helpers that end up
being no-ops for the traditional cases.

I just don't think it makes sense to maintain a set of range values
that then aren't actually used in the general case.

              Linus
