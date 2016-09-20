Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdRv55mndzDsTW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 12:45:21 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8K2ciLN099255
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 22:45:19 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25jua7jva1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 22:45:18 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 20:45:18 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: christophe leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] powerpc: get hugetlbpage handling more generic
In-Reply-To: <2c8682d7-78ce-0aaf-79bd-85a85849e227@c-s.fr>
References: <cover.1474009019.git.christophe.leroy@c-s.fr>
 <dab1fde59f711dd7d3f1996dee72f61c46033f47.1474009019.git.christophe.leroy@c-s.fr>
 <87poo0xx13.fsf@linux.vnet.ibm.com>
 <2c8682d7-78ce-0aaf-79bd-85a85849e227@c-s.fr>
Date: Tue, 20 Sep 2016 08:15:09 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874m5bxpai.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

christophe leroy <christophe.leroy@c-s.fr> writes:

>>
>>
>>>  	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
>>>  		unsigned shift;
>>>  		unsigned pdshift;
>>> @@ -860,16 +807,31 @@ static int __init hugetlbpage_init(void)
>>>  		 * if we have pdshift and shift value same, we don't
>>>  		 * use pgt cache for hugepd.
>>>  		 */
>>> -		if (pdshift != shift) {
>>> +		if (pdshift > shift) {
>>>  			pgtable_cache_add(pdshift - shift, NULL);
>>>  			if (!PGT_CACHE(pdshift - shift))
>>>  				panic("hugetlbpage_init(): could not create "
>>>  				      "pgtable cache for %d bit pagesize\n", shift);
>>> +		} else if (!hugepte_cache) {
>>> +			/*
>>> +			 * Create a kmem cache for hugeptes.  The bottom bits in
>>> +			 * the pte have size information encoded in them, so
>>> +			 * align them to allow this
>>> +			 */
>>> +			hugepte_cache = kmem_cache_create("hugepte-cache",
>>> +							  sizeof(pte_t),
>>> +							  HUGEPD_SHIFT_MASK + 1,
>>> +							  0, NULL);
>>> +			if (hugepte_cache == NULL)
>>> +				panic("%s: Unable to create kmem cache "
>>> +				      "for hugeptes\n", __func__);
>>> +
>>
>>
>> We don't need hugepte_cache for book3s 64K. I guess we will endup
>> creating one here ?
>
> Should not, because on book3s 64k, we will have pdshift > shift
> won't we ?
>

on 64k book3s, we have pdshift == shift and we don't need to create 
hugepd cache on book3s 64k.

-aneesh
