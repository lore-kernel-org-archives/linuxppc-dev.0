Return-Path: <hughd@google.com>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF79E1A2C4D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 17:09:15 +1100 (AEDT)
Received: by mail-pf0-x22f.google.com with SMTP id e65so39861175pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 22:09:15 -0800 (PST)
Date: Sun, 10 Jan 2016 22:09:04 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Subject: Re: [PATCH next] powerpc/mm: fix _PAGE_PTE breaking swapoff
In-Reply-To: <87k2ngu0b4.fsf@linux.vnet.ibm.com>
Message-ID: <alpine.LSU.2.11.1601102208040.1701@eggly.anvils>
References: <alpine.LSU.2.11.1601091643060.9808@eggly.anvils>
 <87si24u32t.fsf@linux.vnet.ibm.com> <87k2ngu0b4.fsf@linux.vnet.ibm.com>
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
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> > Hugh Dickins <hughd@google.com> writes:
> >
> >> Swapoff after swapping hangs on the G5.  That's because the _PAGE_PTE
> >> bit, added by set_pte_at(), is not expected by swapoff: so swap ptes
> >> cannot be recognized.
> >>
> >> I'm not sure whether a swap pte should or should not have _PAGE_PTE set:
> >> this patch assumes not, and fixes set_pte_at() to set _PAGE_PTE only on
> >> present entries.
> >
> > One of the reason we added _PAGE_PTE is to enable HUGETLB migration. So
> > we want migratio ptes to have _PAGE_PTE set.
> >
> >>
> >> But if that's wrong, a reasonable alternative would be to
> >> #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) & ~_PAGE_PTE })
> >> #define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
> >>
> 
> You other email w.r.t soft dirty bits explained this. What I missed was
> the fact that core kernel expect swp_entry_t to be of an arch neutral
> format.  The confusing part was "arch_entry"
> 
> static inline pte_t swp_entry_to_pte(swp_entry_t entry)
> {
> 	swp_entry_t arch_entry;
> .....
> }
> 	
> IMHO we should use the alternative you suggested above. I can write a
> patch with additional comments around that if you want me to do that.

Sure, please go ahead - thanks.

Hugh
