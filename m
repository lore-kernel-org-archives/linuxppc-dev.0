Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9F4A1A1716
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 16:30:27 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 May 2015 12:00:26 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7CE57125804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 12:02:33 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4B6UNJW59637980
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 12:00:23 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4B6ULLU013348
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 12:00:22 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V2 2/2] powerpc/thp: Serialize pmd clear against a linux
 page table walk.
In-Reply-To: <20150508152149.7fd52bb4b7c2a0911c33be00@linux-foundation.org>
References: <1430983408-24924-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1430983408-24924-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20150508152149.7fd52bb4b7c2a0911c33be00@linux-foundation.org>
Date: Mon, 11 May 2015 12:00:18 +0530
Message-ID: <87zj5b4oed.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu,  7 May 2015 12:53:28 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Serialize against find_linux_pte_or_hugepte which does lock-less
>> lookup in page tables with local interrupts disabled. For huge pages
>> it casts pmd_t to pte_t. Since format of pte_t is different from
>> pmd_t we want to prevent transit from pmd pointing to page table
>> to pmd pointing to huge page (and back) while interrupts are disabled.
>> We clear pmd to possibly replace it with page table pointer in
>> different code paths. So make sure we wait for the parallel
>> find_linux_pte_or_hugepage to finish.
>
> I'm not seeing here any description of the problem which is being
> fixed.  Does the patch make the machine faster?  Does the machine
> crash?

I sent v3 with updated commit message. Adding that below.

    powerpc/thp: Serialize pmd clear against a linux page table walk.
    
    Serialize against find_linux_pte_or_hugepte which does lock-less
    lookup in page tables with local interrupts disabled. For huge pages
    it casts pmd_t to pte_t. Since format of pte_t is different from
    pmd_t we want to prevent transit from pmd pointing to page table
    to pmd pointing to huge page (and back) while interrupts are disabled.
    We clear pmd to possibly replace it with page table pointer in
    different code paths. So make sure we wait for the parallel
    find_linux_pte_or_hugepage to finish.
    
    Without this patch, a find_linux_pte_or_hugepte running in parallel to
    __split_huge_zero_page_pmd or do_huge_pmd_wp_page_fallback or zap_huge_pmd
    can run into the above issue. With __split_huge_zero_page_pmd and
    do_huge_pmd_wp_page_fallback we clear the hugepage pte before inserting
    the pmd entry with a regular pgtable address. Such a clear need to
    wait for the parallel find_linux_pte_or_hugepte to finish.
    
    With zap_huge_pmd, we can run into issues, with a hugepage pte
    getting zapped due to a MADV_DONTNEED while other cpu fault it
    in as small pages.

-aneesh
