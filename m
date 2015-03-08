Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com
 [IPv6:2a00:1450:400c:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41D761A0408
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Mar 2015 21:02:33 +1100 (AEDT)
Received: by wghk14 with SMTP id k14so18163162wgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Mar 2015 03:02:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 8 Mar 2015 11:02:23 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] mm: numa: Slow PTE scan rate if migration failures
 occur
Message-ID: <20150308100223.GC15487@gmail.com>
References: <1425741651-29152-1-git-send-email-mgorman@suse.de>
 <1425741651-29152-5-git-send-email-mgorman@suse.de>
 <20150307163657.GA9702@gmail.com>
 <CA+55aFwDuzpL-k8LsV3touhNLh+TFSLKP8+-nPwMXkWXDYPhrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFwDuzpL-k8LsV3touhNLh+TFSLKP8+-nPwMXkWXDYPhrg@mail.gmail.com>
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


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Mar 7, 2015 at 8:36 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > And the patch Dave bisected to is a relatively simple patch. Why 
> > not simply revert it to see whether that cures much of the 
> > problem?
> 
> So the problem with that is that "pmd_set_numa()" and friends simply 
> no longer exist. So we can't just revert that one patch, it's the 
> whole series, and the whole point of the series.

Yeah.

> What confuses me is that the only real change that I can see in that 
> patch is the change to "change_huge_pmd()". Everything else is 
> pretty much a 100% equivalent transformation, afaik. Of course, I 
> may be wrong about that, and missing something silly.

Well, there's a difference in what we write to the pte:

 #define _PAGE_BIT_NUMA          (_PAGE_BIT_GLOBAL+1)
 #define _PAGE_BIT_PROTNONE      _PAGE_BIT_GLOBAL

and our expectation was that the two should be equivalent methods from 
the POV of the NUMA balancing code, right?

> And the changes to "change_huge_pmd()" were basically re-done
> differently by subsequent patches anyway.
> 
> The *only* change I see remaining is that change_huge_pmd() now does
> 
>    entry = pmdp_get_and_clear_notify(mm, addr, pmd);
>    entry = pmd_modify(entry, newprot);
>    set_pmd_at(mm, addr, pmd, entry);
> 
> for all changes. It used to do that "pmdp_set_numa()" for the
> prot_numa case, which did just
> 
>    pmd_t pmd = *pmdp;
>    pmd = pmd_mknuma(pmd);
>    set_pmd_at(mm, addr, pmdp, pmd);
> 
> instead.
> 
> I don't like the old pmdp_set_numa() because it can drop dirty bits,
> so I think the old code was actively buggy.

Could we, as a silly testing hack not to be applied, write a 
hack-patch that re-introduces the racy way of setting the NUMA bit, to 
confirm that it is indeed this difference that changes pte visibility 
across CPUs enough to create so many more faults?

Because if the answer is 'yes', then we can safely say: 'we regressed 
performance because correctness [not dropping dirty bits] comes before 
performance'.

If the answer is 'no', then we still have a mystery (and a regression) 
to track down.

As a second hack (not to be applied), could we change:

 #define _PAGE_BIT_PROTNONE      _PAGE_BIT_GLOBAL

to:

 #define _PAGE_BIT_PROTNONE      (_PAGE_BIT_GLOBAL+1)

to double check that the position of the bit does not matter?

I don't think we've exhaused all avenues of analysis here.

Thanks,

	Ingo
