Return-Path: <linus971@gmail.com>
Received: from mail-ig0-x22c.google.com (mail-ig0-x22c.google.com
 [IPv6:2607:f8b0:4001:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0ED2A1A0133
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Mar 2015 05:33:47 +1100 (AEDT)
Received: by igqa13 with SMTP id a13so11621471igq.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2015 10:33:44 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1425741651-29152-4-git-send-email-mgorman@suse.de>
References: <1425741651-29152-1-git-send-email-mgorman@suse.de>
 <1425741651-29152-4-git-send-email-mgorman@suse.de>
Date: Sat, 7 Mar 2015 10:33:43 -0800
Message-ID: <CA+55aFwSQgrYqfXPr6RPvQ+8OJfexXJRY_GVEKg5QtB2t38cWA@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: numa: Mark huge PTEs young when clearing NUMA
 hinting faults
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
>         pmd = pmd_modify(pmd, vma->vm_page_prot);
> +       pmd = pmd_mkyoung(pmd);

Hmm. I *thought* this should be unnecessary. vm_page_prot alreadty has
the accessed bit set, and we kind of depend on the initial page table
setup and mk_pte() and friends (ie all new pages are installed
"young").

But it looks like I am wrong - the way we use _[H]PAGE_CHG_MASK means
that we always take the accessed and dirty bits from the old entry,
ignoring the bit in vm_page_prot.

I wonder if we should just make pte/pmd_modify() work the way I
*thought* they worked (remove the masking of vm_page_prot bits).

So the patch isn't wrong. It's just that we *migth* instead just do
something like this:

    arch/x86/include/asm/pgtable.h | 4 ++--
    1 file changed, 2 insertions(+), 2 deletions(-)

   diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
   index a0c35bf6cb92..79b898bb9e18 100644
   --- a/arch/x86/include/asm/pgtable.h
   +++ b/arch/x86/include/asm/pgtable.h
   @@ -355,7 +355,7 @@ static inline pte_t pte_modify(pte_t pte,
pgprot_t newprot)
            * the newprot (if present):
            */
           val &= _PAGE_CHG_MASK;
   -       val |= massage_pgprot(newprot) & ~_PAGE_CHG_MASK;
   +       val |= massage_pgprot(newprot);

           return __pte(val);
    }
   @@ -365,7 +365,7 @@ static inline pmd_t pmd_modify(pmd_t pmd,
pgprot_t newprot)
           pmdval_t val = pmd_val(pmd);

           val &= _HPAGE_CHG_MASK;
   -       val |= massage_pgprot(newprot) & ~_HPAGE_CHG_MASK;
   +       val |= massage_pgprot(newprot);

           return __pmd(val);
    }

instead, and remove the mkyoung. Completely untested, but that "just
or in the new protection bits" is what pnf_pte() does just a few lines
above this.

                        Linus
