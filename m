Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sf8TS63nXzDsgf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 16:14:04 +1000 (AEST)
Subject: Re: [PATCH v2 2/3] powerpc: get hugetlbpage handling more generic
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
References: <cover.1474009019.git.christophe.leroy@c-s.fr>
 <dab1fde59f711dd7d3f1996dee72f61c46033f47.1474009019.git.christophe.leroy@c-s.fr>
 <87poo0xx13.fsf@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f475bfc1-ff00-46cb-7c5b-85e8d51e34e0@c-s.fr>
Date: Wed, 21 Sep 2016 08:13:56 +0200
MIME-Version: 1.0
In-Reply-To: <87poo0xx13.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/09/2016 à 07:45, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> Today there are two implementations of hugetlbpages which are managed
>> by exclusive #ifdefs:
>> * FSL_BOOKE: several directory entries points to the same single hugepage
>> * BOOK3S: one upper level directory entry points to a table of hugepages
>>
>> In preparation of implementation of hugepage support on the 8xx, we
>> need a mix of the two above solutions, because the 8xx needs both cases
>> depending on the size of pages:
>> * In 4k page size mode, each PGD entry covers a 4M bytes area. It means
>> that 2 PGD entries will be necessary to cover an 8M hugepage while a
>> single PGD entry will cover 8x 512k hugepages.
>> * In 16 page size mode, each PGD entry covers a 64M bytes area. It means
>> that 8x 8M hugepages will be covered by one PGD entry and 64x 512k
>> hugepages will be covers by one PGD entry.
>>
>> This patch:
>> * removes #ifdefs in favor of if/else based on the range sizes
>> * merges the two huge_pte_alloc() functions as they are pretty similar
>> * merges the two hugetlbpage_init() functions as they are pretty similar
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> v2: This part is new and results from a split of last patch of v1 serie in
>> two parts
>>
>>  arch/powerpc/mm/hugetlbpage.c | 189 +++++++++++++++++-------------------------
>>  1 file changed, 77 insertions(+), 112 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index 8a512b1..2119f00 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -64,14 +64,16 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
>>  {
>>  	struct kmem_cache *cachep;
>>  	pte_t *new;
>> -
>> -#ifdef CONFIG_PPC_FSL_BOOK3E
>>  	int i;
>> -	int num_hugepd = 1 << (pshift - pdshift);
>> -	cachep = hugepte_cache;
>> -#else
>> -	cachep = PGT_CACHE(pdshift - pshift);
>> -#endif
>> +	int num_hugepd;
>> +
>> +	if (pshift >= pdshift) {
>> +		cachep = hugepte_cache;
>> +		num_hugepd = 1 << (pshift - pdshift);
>> +	} else {
>> +		cachep = PGT_CACHE(pdshift - pshift);
>> +		num_hugepd = 1;
>> +	}
>
> Is there a way to hint likely/unlikely branch based on the page size
> selected at build time ?

Is that really worth it, won't it be negligeable compared to  other 
actions in that function (like for instance kmem_cache_zalloc()) ?
Can't we just trust GCC on that one ?

Christophe
