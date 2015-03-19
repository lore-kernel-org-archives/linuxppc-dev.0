Return-Path: <david@fromorbit.com>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [150.101.137.131])
 by lists.ozlabs.org (Postfix) with ESMTP id 43F5D1A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 10:30:57 +1100 (AEDT)
Date: Fri, 20 Mar 2015 10:23:26 +1100
From: Dave Chinner <david@fromorbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] mm: numa: Slow PTE scan rate if migration failures
 occur
Message-ID: <20150319232326.GM10105@dastard>
References: <20150317070655.GB10105@dastard>
 <CA+55aFzdLnFdku-gnm3mGbeS=QauYBNkFQKYXJAGkrMd2jKXhw@mail.gmail.com>
 <20150317205104.GA28621@dastard>
 <CA+55aFzSPcNgxw4GC7aAV1r0P5LniyVVC66COz=3cgMcx73Nag@mail.gmail.com>
 <20150317220840.GC28621@dastard>
 <CA+55aFwne-fe_Gg-_GTUo+iOAbbNpLBa264JqSFkH79EULyAqw@mail.gmail.com>
 <CA+55aFy-Mw74rAdLMMMUgnsG3ZttMWVNGz7CXZJY7q9fqyRYfg@mail.gmail.com>
 <CA+55aFyxA9u2cVzV+S7TSY9ZvRXCX=z22YAbi9mdPVBKmqgR5g@mail.gmail.com>
 <20150319224143.GI10105@dastard>
 <CA+55aFy5UeNnFUTi619cs3b9Up2NQ1wbuyvcCS614+o3=z=wBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFy5UeNnFUTi619cs3b9Up2NQ1wbuyvcCS614+o3=z=wBQ@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>,
 Mel Gorman <mgorman@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 19, 2015 at 04:05:46PM -0700, Linus Torvalds wrote:
> On Thu, Mar 19, 2015 at 3:41 PM, Dave Chinner <david@fromorbit.com> wrote:
> >
> > My recollection wasn't faulty - I pulled it from an earlier email.
> > That said, the original measurement might have been faulty. I ran
> > the numbers again on the 3.19 kernel I saved away from the original
> > testing. That came up at 235k, which is pretty much the same as
> > yesterday's test. The runtime,however, is unchanged from my original
> > measurements of 4m54s (pte_hack came in at 5m20s).
> 
> Ok. Good. So the "more than an order of magnitude difference" was
> really about measurement differences, not quite as real. Looks like
> more a "factor of two" than a factor of 20.
> 
> Did you do the profiles the same way? Because that would explain the
> differences in the TLB flush percentages too (the "1.4% from
> tlb_invalidate_range()" vs "pretty much everything from migration").

No, the profiles all came from steady state. The profiles from the
initial startup phase hammer the mmap_sem because of page fault vs
mprotect contention (glibc runs mprotect() on every chunk of
memory it allocates). It's not until the cache reaches "full" and it
starts recycling old buffers rather than allocating new ones that
the tlb flush problem dominates the profiles.

> The runtime variation does show that there's some *big* subtle
> difference for the numa balancing in the exact TNF_NO_GROUP details.
> It must be *very* unstable for it to make that big of a difference.
> But I feel at least a *bit* better about "unstable algorithm changes a
> small varioation into a factor-of-two" vs that crazy factor-of-20.
> 
> Can you try Mel's change to make it use
> 
>         if (!(vma->vm_flags & VM_WRITE))
> 
> instead of the pte details? Again, on otherwise plain 3.19, just so
> that we have a baseline. I'd be *so* much happer with checking the vma
> details over per-pte details, especially ones that change over the
> lifetime of the pte entry, and the NUMA code explicitly mucks with.

Yup, will do. might take an hour or two before I get to it, though...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
