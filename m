Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdWNF6wbzzDsTW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 15:22:21 +1000 (AEST)
Subject: Re: [PATCH v2 2/3] powerpc: get hugetlbpage handling more generic
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
References: <cover.1474009019.git.christophe.leroy@c-s.fr>
 <dab1fde59f711dd7d3f1996dee72f61c46033f47.1474009019.git.christophe.leroy@c-s.fr>
 <87mvj4xwt6.fsf@linux.vnet.ibm.com>
 <68949cf6-c70b-f616-4586-fa438a7c17cd@c-s.fr>
 <877fa7xq1v.fsf@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0f2ea710-1e14-8b80-7480-cea9ffbe9dfa@c-s.fr>
Date: Tue, 20 Sep 2016 07:22:17 +0200
MIME-Version: 1.0
In-Reply-To: <877fa7xq1v.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 20/09/2016 à 04:28, Aneesh Kumar K.V a écrit :
> christophe leroy <christophe.leroy@c-s.fr> writes:
>
>> Le 19/09/2016 à 07:50, Aneesh Kumar K.V a écrit :
>>>
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>> +#else
>>>> +static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
>>>> +{
>>>> +	BUG();
>>>> +}
>>>> +
>>>>  #endif
>>>
>>>
>>> I was expecting that BUG will get removed in the next patch. But I don't
>>> see it in the next patch. Considering
>>>
>>> @@ -475,11 +453,10 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
>>>         for (i = 0; i < num_hugepd; i++, hpdp++)
>>>                 hpdp->pd = 0;
>>>
>>> -#ifdef CONFIG_PPC_FSL_BOOK3E
>>> -	hugepd_free(tlb, hugepte);
>>> -#else
>>> -	pgtable_free_tlb(tlb, hugepte, pdshift - shift);
>>> -#endif
>>> +	if (shift >= pdshift)
>>> +		hugepd_free(tlb, hugepte);
>>> +	else
>>> +		pgtable_free_tlb(tlb, hugepte, pdshift - shift);
>>>  }
>>>
>>> What is that I am missing ?
>>>
>>
>> Previously, call to hugepd_free() was compiled only when #ifdef
>> CONFIG_PPC_FSL_BOOK3E
>> Now, it is compiled at all time, but it should never be called if not
>> CONFIG_PPC_FSL_BOOK3E because we always have shift < pdshift in that case.
>> Then the function needs to be defined anyway but should never be called.
>> Should I just define it static inline {} ?
>>
>
> For 8M with 4K mode, we have shift >= pdshift right ?
>

Yes, thats the reason why in the following patch we get. That way we get 
a real hugepd_free() also for the 8xx.

@@ -366,7 +373,7 @@ int alloc_bootmem_huge_page(struct hstate *hstate)
  }
  #endif

-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
  #define HUGEPD_FREELIST_SIZE \
  	((PAGE_SIZE - sizeof(struct hugepd_freelist)) / sizeof(pte_t))



Christophe
