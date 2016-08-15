Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCWm25g8VzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 20:23:14 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7FAE66v022590
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 06:23:12 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24tgpctbad-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 06:23:11 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 15 Aug 2016 04:23:11 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: christophe leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] powerpc: port 64 bits pgtable_cache to 32 bits
In-Reply-To: <df8b5a70-e705-e282-c33c-0c0b93d6b72e@c-s.fr>
References: <cover.1471020646.git.christophe.leroy@c-s.fr>
 <794b4abd8caaad32edf4180ac485a2eb914fba49.1471020647.git.christophe.leroy@c-s.fr>
 <878tvza0zg.fsf@skywalker.in.ibm.com>
 <df8b5a70-e705-e282-c33c-0c0b93d6b72e@c-s.fr>
Date: Mon, 15 Aug 2016 15:53:03 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87fuq649h4.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

christophe leroy <christophe.leroy@c-s.fr> writes:

> Le 14/08/2016 =C3=A0 16:17, Aneesh Kumar K.V a =C3=A9crit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> Today powerpc64 uses a set of pgtable_caches while powerpc32 uses
>>> standard pages when using 4k pages and a single pgtable_cache
>>> if using other size pages. In addition powerpc32 uses another cache
>>> when handling huge pages.
>>>
>>> In preparation of implementing huge pages on the 8xx, this patch
>>> replaces the specific powerpc32 handling by the 64 bits approach.
>>
>> Why is this needed ? Can you also summarize the page size used and the
>> hugepage format you are planning to use ? . What are the page sizes
>> supported by 8xx ? Also is the new code copy of existing powerpc64 4k
>> page size code ?
>
> 8xx supports two huge page sizes: 8M and 512k.
> As PGD entries points on 4M page tables, it means we are in an=20
> eterogenous situation:
> 1/ when using 8M huge pages, we are in the same situation as what is=20
> done for the BOOK3S (which supports 16M, 256M and 1G), that is several=20
> PDG entries pointing to a single PTE entry.

what is done for FSL BOOK3E ?


> 2/ when using 512k huge pages, we are in the same situation as whan is=20
> done for the BOOK3E: a PGD entry points to the hugepage table that=20
> handles several huge pages (in our case 8 huge pages)
>

what is done for Book3s with 4K linux page size. ?


So the idea here is to allocate different hugepte table based on
hugepage size requested and hence the need to switch from hugpte-cache
to a more generic PGT_CACHE ?

> The code from init_64 have been moved to a new file named init-common in=
=20
> order to be used by init_32 too.
> The code from the 64 bits .h has been copied into the 32 bits .h (indeed=
=20
> it's been copied twice as the .h are now duplicated into nohash and=20
> book3s versions)


That explanation made it a lot easy to follow the patch. Can we capture
that in commit message too. Also Do we support hugepage with both 4k and
16K linux page size ?. I guess we do because 8xx only do a two level
linux page table ?=20

>
> [...]
>
>>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpag=
e.c
>>> index 7372ee1..9164a77 100644
>>> --- a/arch/powerpc/mm/hugetlbpage.c
>>> +++ b/arch/powerpc/mm/hugetlbpage.c
>>> @@ -68,7 +68,7 @@ static int __hugepte_alloc(struct mm_struct *mm, huge=
pd_t *hpdp,
>>>  #ifdef CONFIG_PPC_FSL_BOOK3E
>>>  	int i;
>>>  	int num_hugepd =3D 1 << (pshift - pdshift);
>>> -	cachep =3D hugepte_cache;
>>> +	cachep =3D PGT_CACHE(1);
>>>  #else
>>>  	cachep =3D PGT_CACHE(pdshift - pshift);
>>>  #endif
>>
>> Can you explain the usage of PGT_CACHE(1) ?
>
> [...]
>
>>
>> I still didn't quiet follow why we are replacing
>>
>>  -	hugepte_cache =3D  kmem_cache_create("hugepte-cache", sizeof(pte_t),
>>  -					   HUGEPD_SHIFT_MASK + 1, 0, NULL);
>>  +	pgtable_cache_add(1, NULL);
>>
>
> Euh ... Indeed I wanted something to replace hugepte_cache. But it looks=
=20
> like it should be something like PGT_CACHE(0) for 32 bits targets having=
=20
> 32 bits PTEs and PGT_CACHE(1) for 32 bits targets having 64 bits PTEs.=20
> But PGT_CACHE(0) doesn't exist (yet).
>
> Looking once more, that might not really be needed I think. I'll rework=20
> it and see what I can achieve.
>

Thanks
-aneesh
