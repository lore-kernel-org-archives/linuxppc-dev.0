Return-Path: <linus971@gmail.com>
Received: from mail-ie0-x235.google.com (mail-ie0-x235.google.com
 [IPv6:2607:f8b0:4001:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 847ED1A04C0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 05:36:01 +1100 (AEDT)
Received: by iecrl12 with SMTP id rl12so14900009iec.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Mar 2015 11:35:59 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20150308100223.GC15487@gmail.com>
References: <1425741651-29152-1-git-send-email-mgorman@suse.de>
 <1425741651-29152-5-git-send-email-mgorman@suse.de>
 <20150307163657.GA9702@gmail.com>
 <CA+55aFwDuzpL-k8LsV3touhNLh+TFSLKP8+-nPwMXkWXDYPhrg@mail.gmail.com>
 <20150308100223.GC15487@gmail.com>
Date: Sun, 8 Mar 2015 11:35:59 -0700
Message-ID: <CA+55aFyQyZXu2fi7X9bWdSX0utk8=sccfBwFaSoToROXoE_PLA@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: numa: Slow PTE scan rate if migration failures
 occur
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: Dave Chinner <david@fromorbit.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 8, 2015 at 3:02 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> Well, there's a difference in what we write to the pte:
>
>  #define _PAGE_BIT_NUMA          (_PAGE_BIT_GLOBAL+1)
>  #define _PAGE_BIT_PROTNONE      _PAGE_BIT_GLOBAL
>
> and our expectation was that the two should be equivalent methods from
> the POV of the NUMA balancing code, right?

Right.

But yes, we might have screwed something up. In particular, there
might be something that thinks it cares about the global bit, but
doesn't notice that the present bit isn't set, so it considers the
protnone mappings to be global and causes lots more tlb flushes etc.

>> I don't like the old pmdp_set_numa() because it can drop dirty bits,
>> so I think the old code was actively buggy.
>
> Could we, as a silly testing hack not to be applied, write a
> hack-patch that re-introduces the racy way of setting the NUMA bit, to
> confirm that it is indeed this difference that changes pte visibility
> across CPUs enough to create so many more faults?

So one of Mel's patches did that, but I don't know if Dave tested it.

And thinking about it, it *may* be safe for huge-pages, if they always
already have the dirty bit set to begin with. And I don't see how we
could have a clean hugepage (apart from the special case of the
zeropage, which is read-only, so races on teh dirty bit aren't an
issue).

So it might actually be that the non-atomic version is safe for
hpages. And we could possibly get rid of the "atomic read-and-clear"
even for the non-numa case.

I'd rather do it for both cases than for just one of them.

But:

> As a second hack (not to be applied), could we change:
>
>  #define _PAGE_BIT_PROTNONE      _PAGE_BIT_GLOBAL
>
> to:
>
>  #define _PAGE_BIT_PROTNONE      (_PAGE_BIT_GLOBAL+1)
>
> to double check that the position of the bit does not matter?

Agreed. We should definitely try that.

Dave?

Also, is there some sane way for me to actually see this behavior on a
regular machine with just a single socket? Dave is apparently running
in some fake-numa setup, I'm wondering if this is easy enough to
reproduce that I could see it myself.

                          Linus
