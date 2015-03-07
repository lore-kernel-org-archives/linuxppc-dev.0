Return-Path: <linus971@gmail.com>
Received: from mail-ig0-x229.google.com (mail-ig0-x229.google.com
 [IPv6:2607:f8b0:4001:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0F4B1A0196
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Mar 2015 06:12:53 +1100 (AEDT)
Received: by igdh15 with SMTP id h15so11862448igd.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2015 11:12:50 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20150307163657.GA9702@gmail.com>
References: <1425741651-29152-1-git-send-email-mgorman@suse.de>
 <1425741651-29152-5-git-send-email-mgorman@suse.de>
 <20150307163657.GA9702@gmail.com>
Date: Sat, 7 Mar 2015 11:12:50 -0800
Message-ID: <CA+55aFwDuzpL-k8LsV3touhNLh+TFSLKP8+-nPwMXkWXDYPhrg@mail.gmail.com>
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

On Sat, Mar 7, 2015 at 8:36 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> And the patch Dave bisected to is a relatively simple patch.
> Why not simply revert it to see whether that cures much of the
> problem?

So the problem with that is that "pmd_set_numa()" and friends simply
no longer exist. So we can't just revert that one patch, it's the
whole series, and the whole point of the series.

What confuses me is that the only real change that I can see in that
patch is the change to "change_huge_pmd()". Everything else is pretty
much a 100% equivalent transformation, afaik. Of course, I may be
wrong about that, and missing something silly.

And the changes to "change_huge_pmd()" were basically re-done
differently by subsequent patches anyway.

The *only* change I see remaining is that change_huge_pmd() now does

   entry = pmdp_get_and_clear_notify(mm, addr, pmd);
   entry = pmd_modify(entry, newprot);
   set_pmd_at(mm, addr, pmd, entry);

for all changes. It used to do that "pmdp_set_numa()" for the
prot_numa case, which did just

   pmd_t pmd = *pmdp;
   pmd = pmd_mknuma(pmd);
   set_pmd_at(mm, addr, pmdp, pmd);

instead.

I don't like the old pmdp_set_numa() because it can drop dirty bits,
so I think the old code was actively buggy.

But I do *not* see why the new code would cause more migrations to happen.

There's probably something really stupid I'm missing.

                           Linus
