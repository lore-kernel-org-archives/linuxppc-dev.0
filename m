Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E09091400EA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Apr 2014 17:38:33 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Apr 2014 13:08:29 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5B043E003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Apr 2014 13:12:37 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s377cWBP9044254
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Apr 2014 13:08:32 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s377cQhv025475
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Apr 2014 13:08:26 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: numa pte should be handled via slow path in
 get_user_pages_fast
In-Reply-To: <1396828173.3671.22.camel@pasglop>
References: <1396454859-5274-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1396828173.3671.22.camel@pasglop>
Date: Mon, 07 Apr 2014 13:08:25 +0530
Message-ID: <87eh19si6m.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2014-04-02 at 21:37 +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> We need to handle numa pte via the slow path
>
> Is this -stable material ? If yes how far back ?

I am not sure we really need to backport this. We got numa faulting bits
in 3.14. Currently there are two out-standing patches. One is this and
the other. http://mid.gmane.org/1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com

powernv: kvm: make _PAGE_NUMA take effect

I would not consider them critical enough to impact the general user of
3.14 kernel.

-aneesh

>
> Cheers,
> Ben.
>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/gup.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> 
>> diff --git a/arch/powerpc/mm/gup.c b/arch/powerpc/mm/gup.c
>> index c5f734e20b0f..d8746684f606 100644
>> --- a/arch/powerpc/mm/gup.c
>> +++ b/arch/powerpc/mm/gup.c
>> @@ -36,6 +36,11 @@ static noinline int gup_pte_range(pmd_t pmd, unsigned long addr,
>>  	do {
>>  		pte_t pte = ACCESS_ONCE(*ptep);
>>  		struct page *page;
>> +		/*
>> +		 * Similar to the PMD case, NUMA hinting must take slow path
>> +		 */
>> +		if (pte_numa(pte))
>> +			return 0;
>>  
>>  		if ((pte_val(pte) & mask) != result)
>>  			return 0;
>> @@ -75,6 +80,14 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
>>  		if (pmd_none(pmd) || pmd_trans_splitting(pmd))
>>  			return 0;
>>  		if (pmd_huge(pmd) || pmd_large(pmd)) {
>> +			/*
>> +			 * NUMA hinting faults need to be handled in the GUP
>> +			 * slowpath for accounting purposes and so that they
>> +			 * can be serialised against THP migration.
>> +			 */
>> +			if (pmd_numa(pmd))
>> +				return 0;
>> +
>>  			if (!gup_hugepte((pte_t *)pmdp, PMD_SIZE, addr, next,
>>  					 write, pages, nr))
>>  				return 0;
