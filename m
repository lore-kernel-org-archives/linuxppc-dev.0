Return-Path: <linus971@gmail.com>
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com
 [IPv6:2607:f8b0:4001:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACB8C1A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 10:05:49 +1100 (AEDT)
Received: by igcqo1 with SMTP id qo1so3781990igc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 16:05:46 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20150319224143.GI10105@dastard>
References: <CA+55aFx=81BGnQFNhnAGu6CetL7yifPsnD-+v7Y6QRqwgH47gQ@mail.gmail.com>
 <20150312184925.GH3406@suse.de> <20150317070655.GB10105@dastard>
 <CA+55aFzdLnFdku-gnm3mGbeS=QauYBNkFQKYXJAGkrMd2jKXhw@mail.gmail.com>
 <20150317205104.GA28621@dastard>
 <CA+55aFzSPcNgxw4GC7aAV1r0P5LniyVVC66COz=3cgMcx73Nag@mail.gmail.com>
 <20150317220840.GC28621@dastard>
 <CA+55aFwne-fe_Gg-_GTUo+iOAbbNpLBa264JqSFkH79EULyAqw@mail.gmail.com>
 <CA+55aFy-Mw74rAdLMMMUgnsG3ZttMWVNGz7CXZJY7q9fqyRYfg@mail.gmail.com>
 <CA+55aFyxA9u2cVzV+S7TSY9ZvRXCX=z22YAbi9mdPVBKmqgR5g@mail.gmail.com>
 <20150319224143.GI10105@dastard>
Date: Thu, 19 Mar 2015 16:05:46 -0700
Message-ID: <CA+55aFy5UeNnFUTi619cs3b9Up2NQ1wbuyvcCS614+o3=z=wBQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: numa: Slow PTE scan rate if migration failures
 occur
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset=UTF-8
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

On Thu, Mar 19, 2015 at 3:41 PM, Dave Chinner <david@fromorbit.com> wrote:
>
> My recollection wasn't faulty - I pulled it from an earlier email.
> That said, the original measurement might have been faulty. I ran
> the numbers again on the 3.19 kernel I saved away from the original
> testing. That came up at 235k, which is pretty much the same as
> yesterday's test. The runtime,however, is unchanged from my original
> measurements of 4m54s (pte_hack came in at 5m20s).

Ok. Good. So the "more than an order of magnitude difference" was
really about measurement differences, not quite as real. Looks like
more a "factor of two" than a factor of 20.

Did you do the profiles the same way? Because that would explain the
differences in the TLB flush percentages too (the "1.4% from
tlb_invalidate_range()" vs "pretty much everything from migration").

The runtime variation does show that there's some *big* subtle
difference for the numa balancing in the exact TNF_NO_GROUP details.
It must be *very* unstable for it to make that big of a difference.
But I feel at least a *bit* better about "unstable algorithm changes a
small varioation into a factor-of-two" vs that crazy factor-of-20.

Can you try Mel's change to make it use

        if (!(vma->vm_flags & VM_WRITE))

instead of the pte details? Again, on otherwise plain 3.19, just so
that we have a baseline. I'd be *so* much happer with checking the vma
details over per-pte details, especially ones that change over the
lifetime of the pte entry, and the NUMA code explicitly mucks with.

                           Linus
