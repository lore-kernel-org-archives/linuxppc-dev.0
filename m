Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQ6YM6YbHzDvwx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 18:05:59 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAP742Du125127
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 02:05:57 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26xdbcsu40-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 02:05:57 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 25 Nov 2016 00:05:56 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 1/7] powerpc/mm: update ptep_set_access_flag to not do
 full mm tlb flush
In-Reply-To: <87fumgjimq.fsf@linux.vnet.ibm.com>
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161125024843.GA24925@fergus.ozlabs.ibm.com>
 <87fumgjimq.fsf@linux.vnet.ibm.com>
Date: Fri, 25 Nov 2016 12:35:49 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d1hkjaya.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Paul Mackerras <paulus@ozlabs.org> writes:
>

>>
>>  #define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
>>  #define _PAGE_PRESENT		(1ul << 63)	/* pte contains a translation */
>> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
>> index f4f437c..7ff0289 100644
>> --- a/arch/powerpc/mm/pgtable-book3s64.c
>> +++ b/arch/powerpc/mm/pgtable-book3s64.c
>> @@ -86,7 +86,7 @@ pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
>>  {
>>  	unsigned long pmdv;
>>
>> -	pmdv = (pfn << PAGE_SHIFT) & PTE_RPN_MASK;
>> +	pmdv = ((pfn << PAGE_SHIFT) & PTE_RPN_MASK) | _PAGE_LARGE;
>>  	return pmd_set_protbits(__pmd(pmdv), pgprot);
>>  }
>>
>
> I will look at this and see if can make the patch simpler. But do we
> really want to use the pte bit for this ? Aren't we low on free pte bits


Ok this will work, provided we are ok to take up two pte bits for this
So we can use make_huge_pte() to fixup the pte entry for hugetlb and
pmd_mkhuge() to fixup the THP.

Now the question will be how will we support _PAGE_DEVMAP (for nvidmm).
We don't have free software pte bits after we make the above change.

NOTE: We do have 3 reserved bits(ppc bit 4-6 ) can we use that ?

-aneesh
