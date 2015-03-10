Return-Path: <linus971@gmail.com>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D72D01A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 10:56:01 +1100 (AEDT)
Received: by iecvj10 with SMTP id vj10so923797iec.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 16:55:59 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20150309191943.GF26657@destitution>
References: <1425741651-29152-1-git-send-email-mgorman@suse.de>
 <1425741651-29152-5-git-send-email-mgorman@suse.de>
 <20150307163657.GA9702@gmail.com>
 <CA+55aFwDuzpL-k8LsV3touhNLh+TFSLKP8+-nPwMXkWXDYPhrg@mail.gmail.com>
 <20150308100223.GC15487@gmail.com>
 <CA+55aFyQyZXu2fi7X9bWdSX0utk8=sccfBwFaSoToROXoE_PLA@mail.gmail.com>
 <20150309112936.GD26657@destitution>
 <CA+55aFywW5JLq=BU_qb2OG5+pJ-b1v9tiS5Ygi-vtEKbEZ_T5Q@mail.gmail.com>
 <20150309191943.GF26657@destitution>
Date: Tue, 10 Mar 2015 16:55:52 -0700
Message-ID: <CA+55aFzFt-vX5Jerci0Ty4Uf7K4_nQ7wyCp8hhU_dB0X4cBpVQ@mail.gmail.com>
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

On Mon, Mar 9, 2015 at 12:19 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Mon, Mar 09, 2015 at 09:52:18AM -0700, Linus Torvalds wrote:
>>
>> What's your virtual environment setup? Kernel config, and
>> virtualization environment to actually get that odd fake NUMA thing
>> happening?
>
> I don't have the exact .config with me (test machines at home
> are shut down because I'm half a world away), but it's pretty much
> this (copied and munged from a similar test vm on my laptop):

[ snip snip ]

Ok, I hate debugging by symptoms anyway, so I didn't do any of this,
and went back to actually *thinking* about the code instead of trying
to reproduce this and figure things out by trial and error.

And I think I figured it out. Of course, since I didn't actually test
anything, what do I know, but I feel good about it, because I think I
can explain why that patch that on the face of it shouldn't change
anything actually did.

So, the old code just did all those manual page table changes,
clearing the present bit and setting the NUMA bit instead.

The new code _ostensibly_ does the same, except it clears the present
bit and sets the PROTNONE bit instead.

However, rather than playing special games with just those two bits,
it uses the normal pte accessor functions, and in particular uses
vma->vm_page_prot to reset the protections back. Which is a nice
cleanup and really makes the code look saner, and does the same thing.

Except it really isn't the same thing at all.

Why?

The protection bits in the page tables are *not* the same as
vma->vm_page_prot. Yes, they start out that way, but they don't stay
that way. And no, I'm not talking about dirty and accessed bits.

The difference? COW. Any private mapping is marked read-only in
vma->vm_page_prot, and then the COW (or the initial write) makes it
read-write.

And so, when we did

-       pte = pte_mknonnuma(pte);
+       /* Make it present again */
+       pte = pte_modify(pte, vma->vm_page_prot);
+       pte = pte_mkyoung(pte);

that isn't equivalent at all - it makes the page read-only, because it
restores it to its original state.

Now, that isn't actually what hurts most, I suspect. Judging by the
profiles, we don't suddenly take a lot of new COW faults. No, what
hurts most is that the NUMA balancing code does this:

        /*
         * Avoid grouping on DSO/COW pages in specific and RO pages
         * in general, RO pages shouldn't hurt as much anyway since
         * they can be in shared cache state.
         */
        if (!pte_write(pte))
                flags |= TNF_NO_GROUP;

and that "!pte_write(pte)" is basically now *always* true for private
mappings (which is 99% of all mappings).

In other words, I think the patch unintentionally made the NUMA code
basically always do the TNF_NO_GROUP case.

I think that a quick hack for testing might be to just replace that
"!pte_write()" with "!pte_dirty()", and seeing how that acts.

Comments?

                      Linus
