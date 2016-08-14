Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sC75P5d4GzDr3N
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 04:51:53 +1000 (AEST)
Subject: Re: [PATCH 1/6] powerpc: port 64 bits pgtable_cache to 32 bits
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
References: <cover.1471020646.git.christophe.leroy@c-s.fr>
 <794b4abd8caaad32edf4180ac485a2eb914fba49.1471020647.git.christophe.leroy@c-s.fr>
 <878tvza0zg.fsf@skywalker.in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <df8b5a70-e705-e282-c33c-0c0b93d6b72e@c-s.fr>
Date: Sun, 14 Aug 2016 20:51:44 +0200
MIME-Version: 1.0
In-Reply-To: <878tvza0zg.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 14/08/2016 à 16:17, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> Today powerpc64 uses a set of pgtable_caches while powerpc32 uses
>> standard pages when using 4k pages and a single pgtable_cache
>> if using other size pages. In addition powerpc32 uses another cache
>> when handling huge pages.
>>
>> In preparation of implementing huge pages on the 8xx, this patch
>> replaces the specific powerpc32 handling by the 64 bits approach.
>
> Why is this needed ? Can you also summarize the page size used and the
> hugepage format you are planning to use ? . What are the page sizes
> supported by 8xx ? Also is the new code copy of existing powerpc64 4k
> page size code ?

8xx supports two huge page sizes: 8M and 512k.
As PGD entries points on 4M page tables, it means we are in an 
eterogenous situation:
1/ when using 8M huge pages, we are in the same situation as what is 
done for the BOOK3S (which supports 16M, 256M and 1G), that is several 
PDG entries pointing to a single PTE entry.
2/ when using 512k huge pages, we are in the same situation as whan is 
done for the BOOK3E: a PGD entry points to the hugepage table that 
handles several huge pages (in our case 8 huge pages)

The code from init_64 have been moved to a new file named init-common in 
order to be used by init_32 too.
The code from the 64 bits .h has been copied into the 32 bits .h (indeed 
it's been copied twice as the .h are now duplicated into nohash and 
book3s versions)

[...]

>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index 7372ee1..9164a77 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -68,7 +68,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
>>  #ifdef CONFIG_PPC_FSL_BOOK3E
>>  	int i;
>>  	int num_hugepd = 1 << (pshift - pdshift);
>> -	cachep = hugepte_cache;
>> +	cachep = PGT_CACHE(1);
>>  #else
>>  	cachep = PGT_CACHE(pdshift - pshift);
>>  #endif
>
> Can you explain the usage of PGT_CACHE(1) ?

[...]

>
> I still didn't quiet follow why we are replacing
>
>  -	hugepte_cache =  kmem_cache_create("hugepte-cache", sizeof(pte_t),
>  -					   HUGEPD_SHIFT_MASK + 1, 0, NULL);
>  +	pgtable_cache_add(1, NULL);
>

Euh ... Indeed I wanted something to replace hugepte_cache. But it looks 
like it should be something like PGT_CACHE(0) for 32 bits targets having 
32 bits PTEs and PGT_CACHE(1) for 32 bits targets having 64 bits PTEs. 
But PGT_CACHE(0) doesn't exist (yet).

Looking once more, that might not really be needed I think. I'll rework 
it and see what I can achieve.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
