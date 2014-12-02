Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9AC71A0166
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 07:13:29 +1100 (AEDT)
Message-ID: <1417551190.27448.8.camel@kernel.crashing.org>
Subject: Re: [PATCH 03/10] mm: Convert p[te|md]_numa users to
 p[te|md]_protnone_numa
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 03 Dec 2014 07:13:10 +1100
In-Reply-To: <87h9xeh5im.fsf@linux.vnet.ibm.com>
References: <1416578268-19597-1-git-send-email-mgorman@suse.de>
 <1416578268-19597-4-git-send-email-mgorman@suse.de>
 <1417473849.7182.9.camel@kernel.crashing.org>
 <87h9xeh5im.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Rik van Riel <riel@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Mel Gorman <mgorman@suse.de>,
 Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-02 at 13:01 +0530, Aneesh Kumar K.V wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Fri, 2014-11-21 at 13:57 +0000, Mel Gorman wrote:
> >> void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> >>                 pte_t pte)
> >>  {
> >> -#ifdef CONFIG_DEBUG_VM
> >> -       WARN_ON(pte_val(*ptep) & _PAGE_PRESENT);
> >> -#endif
> >> +       /*
> >> +        * When handling numa faults, we already have the pte marked
> >> +        * _PAGE_PRESENT, but we can be sure that it is not in hpte.
> >> +        * Hence we can use set_pte_at for them.
> >> +        */
> >> +       VM_WARN_ON((pte_val(*ptep) & (_PAGE_PRESENT | _PAGE_USER)) ==
> >> +               (_PAGE_PRESENT | _PAGE_USER));
> >> +
> >
> > His is that going to fare with set_pte_at() called for kernel pages ?
> >
> 
> Yes, we won't capture those errors now. But is there any other debug
> check i could use to capture the wrong usage of set_pte_at ?

Actually the above is fine, for some reason I mis-read the test as
blowing on kernel pages, it doesn't.

We probably do need to make sure however that protnone isn't used for
kernel pages.

Cheers,
Ben.

> -aneesh
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
