Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ5yJ72ywzDqJ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 14:18:32 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v183DvlU060634
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 22:18:30 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28fmtf5j40-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 22:18:30 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 13:18:28 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C9CE33578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 14:18:25 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v183IHlM33554646
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 14:18:25 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v183HrcH014460
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 14:17:53 +1100
Date: Wed, 8 Feb 2017 14:17:28 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc/mm: Fix typo in set_pte_at()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1486340396-24609-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <87tw88gi96.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87tw88gi96.fsf@skywalker.in.ibm.com>
Message-Id: <20170208031728.GA20879@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 06, 2017 at 08:03:57AM +0530, Aneesh Kumar K.V wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> This fixes the typo about the _PAGE_PTE in set_pte_at() by changing
>> "tryint" to "trying to".
>>
>> Fixes: 6a119eae942 ("powerpc/mm: Add a _PAGE_PTE bit")
>
>I guess this is not needed. We add that when we want to hint whether the
>patch needs backporting. 
>

I just sent v2 to remove the "Fixes" tag.

Thanks,
Gavin

>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/pgtable.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
>> index cb39c8b..a03ff3d 100644
>> --- a/arch/powerpc/mm/pgtable.c
>> +++ b/arch/powerpc/mm/pgtable.c
>> @@ -193,9 +193,7 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>>  	 */
>>  	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
>>
>> -	/*
>> -	 * Add the pte bit when tryint set a pte
>> -	 */
>> +	/* Add the pte bit when trying to set a pte */
>>  	pte = __pte(pte_val(pte) | _PAGE_PTE);
>>
>>  	/* Note: mm->context.id might not yet have been assigned as
>> -- 
>> 2.7.4
