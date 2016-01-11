Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E5051A1AF6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 16:57:02 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 Jan 2016 15:57:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4C4303578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 16:56:59 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0B5ur0534930700
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 16:57:01 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0B5uPkf028998
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 16:56:26 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH next] powerpc/mm: fix _PAGE_PTE breaking swapoff
In-Reply-To: <87si24u32t.fsf@linux.vnet.ibm.com>
References: <alpine.LSU.2.11.1601091643060.9808@eggly.anvils>
 <87si24u32t.fsf@linux.vnet.ibm.com>
Date: Mon, 11 Jan 2016 11:25:59 +0530
Message-ID: <87k2ngu0b4.fsf@linux.vnet.ibm.com>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Hugh Dickins <hughd@google.com> writes:
>
>> Swapoff after swapping hangs on the G5.  That's because the _PAGE_PTE
>> bit, added by set_pte_at(), is not expected by swapoff: so swap ptes
>> cannot be recognized.
>>
>> I'm not sure whether a swap pte should or should not have _PAGE_PTE set:
>> this patch assumes not, and fixes set_pte_at() to set _PAGE_PTE only on
>> present entries.
>
> One of the reason we added _PAGE_PTE is to enable HUGETLB migration. So
> we want migratio ptes to have _PAGE_PTE set.
>
>>
>> But if that's wrong, a reasonable alternative would be to
>> #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) & ~_PAGE_PTE })
>> #define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
>>

You other email w.r.t soft dirty bits explained this. What I missed was
the fact that core kernel expect swp_entry_t to be of an arch neutral
format.  The confusing part was "arch_entry"

static inline pte_t swp_entry_to_pte(swp_entry_t entry)
{
	swp_entry_t arch_entry;
.....
}
	
IMHO we should use the alternative you suggested above. I can write a
patch with additional comments around that if you want me to do that.

-aneesh
