Return-Path: <linus971@gmail.com>
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com
 [IPv6:2607:f8b0:4001:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1A531A03B9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Mar 2015 07:31:06 +1100 (AEDT)
Received: by iebtr6 with SMTP id tr6so20760331ieb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2015 12:31:03 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1425741651-29152-2-git-send-email-mgorman@suse.de>
References: <1425741651-29152-1-git-send-email-mgorman@suse.de>
 <1425741651-29152-2-git-send-email-mgorman@suse.de>
Date: Sat, 7 Mar 2015 12:31:03 -0800
Message-ID: <CA+55aFyCgzNGU-VAaKvwTYFhtJc_ugLK6hRzZBCxMYdAt5TVuA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: thp: Return the correct value for change_huge_pmd
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Dave Chinner <david@fromorbit.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 7, 2015 at 7:20 AM, Mel Gorman <mgorman@suse.de> wrote:
>
>                 if (!prot_numa || !pmd_protnone(*pmd)) {
> -                       ret = 1;
>                         entry = pmdp_get_and_clear_notify(mm, addr, pmd);
>                         entry = pmd_modify(entry, newprot);
>                         ret = HPAGE_PMD_NR;

Hmm. I know I acked this already, but the return value - which correct
- is still potentially something we could improve upon.

In particular, we don't need to flush the TLB's if the old entry was
not present. Sadly, we don't have a helper function for that.

But the code *could* do something like

    entry = pmdp_get_and_clear_notify(mm, addr, pmd);
    ret = pmd_tlb_cacheable(entry) ? HPAGE_PMD_NR : 1;
    entry = pmd_modify(entry, newprot);

where pmd_tlb_cacheable() on x86 would test if _PAGE_PRESENT (bit #0) is set.

In particular, that would mean that as we change *from* a protnone
(whether NUMA or really protnone) we wouldn't need to flush the TLB.

In fact, we could make it even more aggressive: it's not just an old
non-present TLB entry that doesn't need flushing - we can avoid the
flushing whenever we strictly increase the access rigths. So we could
have something that takes the old entry _and_ the new protections into
account, and avoids the TLB flush if the new entry is strictly more
permissive.

This doesn't explain the extra TLB flushes Dave sees, though, because
the old code didn't make those kinds of optimizations either. But
maybe something like this is worth doing.

                            Linus
