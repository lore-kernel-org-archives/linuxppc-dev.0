Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdRXd6xklzDsTW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 12:29:21 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8K2THBu112358
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 22:29:19 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25jamahtun-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 22:29:17 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 20:28:53 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: christophe leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] powerpc: get hugetlbpage handling more generic
In-Reply-To: <68949cf6-c70b-f616-4586-fa438a7c17cd@c-s.fr>
References: <cover.1474009019.git.christophe.leroy@c-s.fr>
 <dab1fde59f711dd7d3f1996dee72f61c46033f47.1474009019.git.christophe.leroy@c-s.fr>
 <87mvj4xwt6.fsf@linux.vnet.ibm.com>
 <68949cf6-c70b-f616-4586-fa438a7c17cd@c-s.fr>
Date: Tue, 20 Sep 2016 07:58:44 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <877fa7xq1v.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

christophe leroy <christophe.leroy@c-s.fr> writes:

> Le 19/09/2016 =C3=A0 07:50, Aneesh Kumar K.V a =C3=A9crit :
>>
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> +#else
>>> +static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
>>> +{
>>> +	BUG();
>>> +}
>>> +
>>>  #endif
>>
>>
>> I was expecting that BUG will get removed in the next patch. But I don't
>> see it in the next patch. Considering
>>
>> @@ -475,11 +453,10 @@ static void free_hugepd_range(struct mmu_gather *t=
lb, hugepd_t *hpdp, int pdshif
>>         for (i =3D 0; i < num_hugepd; i++, hpdp++)
>>                 hpdp->pd =3D 0;
>>
>> -#ifdef CONFIG_PPC_FSL_BOOK3E
>> -	hugepd_free(tlb, hugepte);
>> -#else
>> -	pgtable_free_tlb(tlb, hugepte, pdshift - shift);
>> -#endif
>> +	if (shift >=3D pdshift)
>> +		hugepd_free(tlb, hugepte);
>> +	else
>> +		pgtable_free_tlb(tlb, hugepte, pdshift - shift);
>>  }
>>
>> What is that I am missing ?
>>
>
> Previously, call to hugepd_free() was compiled only when #ifdef=20
> CONFIG_PPC_FSL_BOOK3E
> Now, it is compiled at all time, but it should never be called if not=20
> CONFIG_PPC_FSL_BOOK3E because we always have shift < pdshift in that case.
> Then the function needs to be defined anyway but should never be called.=
=20
> Should I just define it static inline {} ?
>

For 8M with 4K mode, we have shift >=3D pdshift right ?

-aneesh
