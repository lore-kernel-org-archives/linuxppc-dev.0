Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 695581A0AC3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 15:56:27 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 Jan 2016 10:26:24 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 34651E005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 10:27:38 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0B4uKaw41156762
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 10:26:20 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0B4uEdU031315
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 10:26:19 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH next] powerpc/mm: fix _PAGE_PTE breaking swapoff
In-Reply-To: <alpine.LSU.2.11.1601091643060.9808@eggly.anvils>
References: <alpine.LSU.2.11.1601091643060.9808@eggly.anvils>
Date: Mon, 11 Jan 2016 10:26:10 +0530
Message-ID: <87si24u32t.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hugh Dickins <hughd@google.com> writes:

> Swapoff after swapping hangs on the G5.  That's because the _PAGE_PTE
> bit, added by set_pte_at(), is not expected by swapoff: so swap ptes
> cannot be recognized.
>
> I'm not sure whether a swap pte should or should not have _PAGE_PTE set:
> this patch assumes not, and fixes set_pte_at() to set _PAGE_PTE only on
> present entries.

One of the reason we added _PAGE_PTE is to enable HUGETLB migration. So
we want migratio ptes to have _PAGE_PTE set.

>
> But if that's wrong, a reasonable alternative would be to
> #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) & ~_PAGE_PTE })
> #define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
>

We do clear _PAGE_PTE bits, when converting swp_entry_t to type and
offset. Can you share the stack trace for the hang, which will help me
understand this more ? . 

> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>
>  arch/powerpc/mm/pgtable.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> --- 4.4-next/arch/powerpc/mm/pgtable.c	2016-01-06 11:54:01.477512251 -0800
> +++ linux/arch/powerpc/mm/pgtable.c	2016-01-09 13:51:15.793485717 -0800
> @@ -180,9 +180,10 @@ void set_pte_at(struct mm_struct *mm, un
>  	VM_WARN_ON((pte_val(*ptep) & (_PAGE_PRESENT | _PAGE_USER)) ==
>  		(_PAGE_PRESENT | _PAGE_USER));
>  	/*
> -	 * Add the pte bit when tryint set a pte
> +	 * Add the pte bit when setting a pte (not a swap entry)
>  	 */
> -	pte = __pte(pte_val(pte) | _PAGE_PTE);
> +	if (pte_val(pte) & _PAGE_PRESENT)
> +		pte = __pte(pte_val(pte) | _PAGE_PTE);
>
>  	/* Note: mm->context.id might not yet have been assigned as
>  	 * this context might not have been activated yet when this

-aneesh
