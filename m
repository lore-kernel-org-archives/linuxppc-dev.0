Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdwTY2DW4zDq6C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 01:12:49 +1000 (AEST)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 4 Apr 2016 20:30:40 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u34F0b0a7864786
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Apr 2016 20:30:37 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u34F0Xfg032259
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Apr 2016 20:30:35 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/65] powerpc/mm: Use pte_user instead of opencoding
In-Reply-To: <56FC814F.5090102@gmail.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56FC814F.5090102@gmail.com>
Date: Mon, 04 Apr 2016 20:30:29 +0530
Message-ID: <87lh4txvua.fsf@linux.vnet.ibm.com>
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

Balbir Singh <bsingharora@gmail.com> writes:

> [ text/plain ]
>
>
> On 27/03/16 19:23, Aneesh Kumar K.V wrote:
>> We have common declaration in pte-common.h Add book3s specific one
>> and switch to pte_user. In the later patch we will be switching
>> _PAGE_USER to _PAGE_PRIVILEGED
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/pgtable.h | 5 +++++
>>  arch/powerpc/perf/callchain.c                | 2 +-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index 77d3ce05798e..4ac6221802ad 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -185,6 +185,11 @@ extern struct page *pgd_page(pgd_t pgd);
>>  #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~_PAGE_PTE })
>>  #define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
>>  
>> +static inline bool pte_user(pte_t pte)
>> +{
>> +	return (pte_val(pte) & _PAGE_USER);
>> +}
> Ideally this should be
>     return !!(pte_val(pte) & _PAGE_USER)
> for consistency with page_present() and the fact that it returns a bool

Fixed. I missed that because later patch convert this to

!(pte_val(pte) & _PAGE_PRIVILEGED). 


-aneesh
