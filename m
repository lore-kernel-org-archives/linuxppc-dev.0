Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D2C31A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 18:54:21 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 May 2015 14:24:18 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 104B21258056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:26:26 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4B8sGCb39518396
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:24:16 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4B8sFJn032747
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:24:15 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH V3] powerpc/thp: Serialize pmd clear against a linux page
 table walk.
In-Reply-To: <20150511074631.GA10974@node.dhcp.inet.fi>
References: <1431325561-21396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20150511074631.GA10974@node.dhcp.inet.fi>
Date: Mon, 11 May 2015 14:24:14 +0530
Message-ID: <87twvj4hqh.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> On Mon, May 11, 2015 at 11:56:01AM +0530, Aneesh Kumar K.V wrote:
>> Serialize against find_linux_pte_or_hugepte which does lock-less
>> lookup in page tables with local interrupts disabled. For huge pages
>> it casts pmd_t to pte_t. Since format of pte_t is different from
>> pmd_t we want to prevent transit from pmd pointing to page table
>> to pmd pointing to huge page (and back) while interrupts are disabled.
>> We clear pmd to possibly replace it with page table pointer in
>> different code paths. So make sure we wait for the parallel
>> find_linux_pte_or_hugepage to finish.
>> 
>> Without this patch, a find_linux_pte_or_hugepte running in parallel to
>> __split_huge_zero_page_pmd or do_huge_pmd_wp_page_fallback or zap_huge_pmd
>> can run into the above issue. With __split_huge_zero_page_pmd and
>> do_huge_pmd_wp_page_fallback we clear the hugepage pte before inserting
>> the pmd entry with a regular pgtable address. Such a clear need to
>> wait for the parallel find_linux_pte_or_hugepte to finish.
>> 
>> With zap_huge_pmd, we can run into issues, with a hugepage pte
>> getting zapped due to a MADV_DONTNEED while other cpu fault it
>> in as small pages.
>> 
>> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
> CC: stable@ ?

Yes, We also need to pick,


dac5657067919161eb3273ca787d8ae9814801e7
691e95fd7396905a38d98919e9c150dbc3ea21a3
7d6e7f7ffaba4e013c7a0589140431799bc17985


But that may need me to a backport, because we have dependencies in kvm
and a cherry-pick may not work.

Will work with Michael Ellerman to find out what needs to be done.

-aneesh
