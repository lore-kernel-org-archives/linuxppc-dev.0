Return-Path: <linus971@gmail.com>
Received: from mail-ig0-x231.google.com (mail-ig0-x231.google.com
 [IPv6:2607:f8b0:4001:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF7791A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 11:53:11 +1100 (AEDT)
Received: by igjz20 with SMTP id z20so69837igj.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2015 16:53:09 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1425599692-32445-3-git-send-email-mgorman@suse.de>
References: <1425599692-32445-1-git-send-email-mgorman@suse.de>
 <1425599692-32445-3-git-send-email-mgorman@suse.de>
Date: Thu, 5 Mar 2015 16:53:09 -0800
Message-ID: <CA+55aFzdWE3dO8z6jUScft7=cLmE3x7G8Ak5dizfL=_z7puzaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: numa: Do not clear PTEs or PMDs for NUMA hinting
 faults
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

On Thu, Mar 5, 2015 at 3:54 PM, Mel Gorman <mgorman@suse.de> wrote:
>                 if (!prot_numa || !pmd_protnone(*pmd)) {
> -                       entry = pmdp_get_and_clear_notify(mm, addr, pmd);
> -                       entry = pmd_modify(entry, newprot);
> +                       /*
> +                        * NUMA hinting update can avoid a clear and defer the
> +                        * flush as it is not a functional correctness issue if
> +                        * access occurs after the update and this avoids
> +                        * spurious faults.
> +                        */
> +                       if (prot_numa) {
> +                               entry = *pmd;
> +                               entry = pmd_mkprotnone(entry);
> +                       } else {
> +                               entry = pmdp_get_and_clear_notify(mm, addr,
> +                                                                 pmd);
> +                               entry = pmd_modify(entry, newprot);
> +                               BUG_ON(pmd_write(entry));
> +                       }
> +
>                         ret = HPAGE_PMD_NR;
>                         set_pmd_at(mm, addr, pmd, entry);
> -                       BUG_ON(pmd_write(entry));

So I don't think this is right, nor is the new pte code.

You cannot just read the old pte entry, change it, and write it back.
That's fundamentally racy, and can drop any concurrent dirty or
accessed bit setting. And there are no locks you can use to protect
against that, since the accessed and dirty bit are set by hardware.

Now, losing the accessed bit doesn't matter - it's a small race, and
not a correctness issue. But potentially losing dirty bits is a data
loss problem.

Did the old prot_numa code do this too? Because if it did, it sounds
like it was just buggy.

                                            Linus
