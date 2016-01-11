Return-Path: <hughd@google.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 673F91A0B57
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 16:45:57 +1100 (AEDT)
Received: by mail-pa0-x22c.google.com with SMTP id ho8so55125526pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 21:45:57 -0800 (PST)
Date: Sun, 10 Jan 2016 21:45:45 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Subject: Re: [PATCH next] powerpc/mm: fix _PAGE_PTE breaking swapoff
In-Reply-To: <87si24u32t.fsf@linux.vnet.ibm.com>
Message-ID: <alpine.LSU.2.11.1601102122280.1485@eggly.anvils>
References: <alpine.LSU.2.11.1601091643060.9808@eggly.anvils>
 <87si24u32t.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 11 Jan 2016, Aneesh Kumar K.V wrote:
> Hugh Dickins <hughd@google.com> writes:
> 
> > Swapoff after swapping hangs on the G5.  That's because the _PAGE_PTE
> > bit, added by set_pte_at(), is not expected by swapoff: so swap ptes
> > cannot be recognized.
> >
> > I'm not sure whether a swap pte should or should not have _PAGE_PTE set:
> > this patch assumes not, and fixes set_pte_at() to set _PAGE_PTE only on
> > present entries.
> 
> One of the reason we added _PAGE_PTE is to enable HUGETLB migration. So
> we want migratio ptes to have _PAGE_PTE set.

Okay, I won't pretend to understand the role of _PAGE_PTE in that;
but if it helps you to have _PAGE_PTE set in (swap and) migration entries,
that's very easily done with the alternative I suggested for pgtable.h:

-#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
-#define __swp_entry_to_pte(x)		__pte((x).val)
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) & ~_PAGE_PTE })
+#define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)

I did test that variant (with set_pte_at() restored to how you have it);
but not understanding _PAGE_PTE, I thought it odd to have in a swap entry.

> 
> >
> > But if that's wrong, a reasonable alternative would be to
> > #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) & ~_PAGE_PTE })
> > #define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
> >
> 
> We do clear _PAGE_PTE bits, when converting swp_entry_t to type and
> offset. Can you share the stack trace for the hang, which will help me
> understand this more ? . 

The stack trace can be anywhere below try_to_unuse() in mm/swapfile.c,
since swapoff is circling around and around that function, reading from
each used swap block into a page, then trying to find where that page
belongs, looking at every non-file pte of every mm that ever swapped.

The code to look at is unuse_pte_range(), which at the top does
	pte_t swp_pte = swp_entry_to_pte(entry)
to get the form it hopes to find in the page table; then scans doing
		if (unlikely(maybe_same_pte(*pte, swp_pte))) {
on each pte slot.  Ignoring the MEM_SOFT_DIRTY complication (which
had its own independent bug) maybe_same_pte() just does pte_same().

Hugh
