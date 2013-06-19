Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24D002C02FD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:22:13 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 16:13:27 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3699B2BB0050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:22:08 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J67QOw36306980
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:07:26 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J6M7bq031669
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:22:07 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Fix bad pmd error with book3E config
In-Reply-To: <25129.1371620895@ale.ozlabs.ibm.com>
References: <1371033004-15864-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <25129.1371620895@ale.ozlabs.ibm.com>
Date: Wed, 19 Jun 2013 11:52:04 +0530
Message-ID: <87wqpqhb77.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> Book3E uses the hugepd at PMD level and don't encode pte directly
>> at the pmd level. So it will find the lower bits of pmd set
>> and the pmd_bad check throws error. Infact the current code
>> will never take the free_hugepd_range call at all because it will
>> clear the pmd if it find a hugepd pointer.
>> 
>
> Please explain what changes you are making.  Currently you are only
> describing what the issue is.

will do

>
> Also include which the SHA1 which caused the regression (ie
> e2b3d202d1dba8f3546ed28224ce485bc50010be "powerpc: Switch 16GB and 16MB
> explicit hugepages to a different page table format")

will add

>
> Mikey
>
>> Reported-by: Scott Wood <scottwood@freescale.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/hugetlbpage.c | 29 ++++++++++++++++++-----------
>>  1 file changed, 18 insertions(+), 11 deletions(-)
>> 
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index f2f01fd..0d3d3ee 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -536,19 +536,26 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
>>  	do {
>>  		pmd = pmd_offset(pud, addr);
>>  		next = pmd_addr_end(addr, end);
>> -		if (pmd_none_or_clear_bad(pmd))
>> -			continue;
>> +		if (!is_hugepd(pmd)) {
>> +			/*
>> +			 * if it is not hugepd pointer, we should already find
>> +			 * it cleared.
>> +			 */
>> +			if (!pmd_none_or_clear_bad(pmd))
>> +				WARN_ON(1);
>
> How often are we going to hit this?    Should this be a warn_on once or
> even a bug_on?

it should never happen. But i was thinking killing the system may a bit
too much, hence WARN_ON

>
> Also just make it: 
>   WARN_ON(!pmd_none_or_clear_bad(pmd))
>

will do

-aneesh
