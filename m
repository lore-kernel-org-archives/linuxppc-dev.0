Return-Path: <linus971@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4157wc3cHxzDqsx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 11:10:40 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id f1-v6so1625543ioh.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 18:10:40 -0700 (PDT)
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
In-Reply-To: <20180613101241.004fd64e@roar.ozlabs.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Jun 2018 18:10:26 -0700
Message-ID: <CA+55aFzJRknbQD6Mv3OSOvUVozQ4H8ni8jPP7UEEi9wKXmVhQA@mail.gmail.com>
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

On Tue, Jun 12, 2018 at 5:12 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > And in _theory_, maybe you could have just used "invalpg" with a
> > targeted address instead. In fact, I think a single invlpg invalidates
> > _all_ caches for the associated MM, but don't quote me on that.

Confirmed. The SDK says

 "INVLPG also invalidates all entries in all paging-structure caches
  associated with the current PCID, regardless of the linear addresses
  to which they correspond"

so if x86 wants to do this "separate invalidation for page directory
entryes", then it would want to

 (a) remove the __tlb_adjust_range() operation entirely from
pud_free_tlb() and friends

 (b) instead just have a single field for "invalidate_tlb_caches",
which could be a boolean, or could just be one of the addresses

and then the logic would be that IFF no other tlb invalidate is done
due to an actual page range, then we look at that
invalidate_tlb_caches field, and do a single INVLPG instead.

I still am not sure if this would actually make a difference in
practice, but I guess it does mean that x86 could at least participate
in some kind of scheme where we have architecture-specific actions for
those page directory entries.

And we could make the default behavior - if no architecture-specific
tlb page directory invalidation function exists - be the current
"__tlb_adjust_range()" case. So the default would be to not change
behavior, and architectures could opt in to something like this.

            Linus
