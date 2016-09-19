Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdF3V1kTDzDsd9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 04:36:54 +1000 (AEST)
Subject: Re: [PATCH v2 2/3] powerpc: get hugetlbpage handling more generic
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
References: <cover.1474009019.git.christophe.leroy@c-s.fr>
 <dab1fde59f711dd7d3f1996dee72f61c46033f47.1474009019.git.christophe.leroy@c-s.fr>
 <87mvj4xwt6.fsf@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <68949cf6-c70b-f616-4586-fa438a7c17cd@c-s.fr>
Date: Mon, 19 Sep 2016 20:36:47 +0200
MIME-Version: 1.0
In-Reply-To: <87mvj4xwt6.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/09/2016 à 07:50, Aneesh Kumar K.V a écrit :
>
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> +#else
>> +static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
>> +{
>> +	BUG();
>> +}
>> +
>>  #endif
>
>
> I was expecting that BUG will get removed in the next patch. But I don't
> see it in the next patch. Considering
>
> @@ -475,11 +453,10 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
>         for (i = 0; i < num_hugepd; i++, hpdp++)
>                 hpdp->pd = 0;
>
> -#ifdef CONFIG_PPC_FSL_BOOK3E
> -	hugepd_free(tlb, hugepte);
> -#else
> -	pgtable_free_tlb(tlb, hugepte, pdshift - shift);
> -#endif
> +	if (shift >= pdshift)
> +		hugepd_free(tlb, hugepte);
> +	else
> +		pgtable_free_tlb(tlb, hugepte, pdshift - shift);
>  }
>
> What is that I am missing ?
>

Previously, call to hugepd_free() was compiled only when #ifdef 
CONFIG_PPC_FSL_BOOK3E
Now, it is compiled at all time, but it should never be called if not 
CONFIG_PPC_FSL_BOOK3E because we always have shift < pdshift in that case.
Then the function needs to be defined anyway but should never be called. 
Should I just define it static inline {} ?

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
