Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wh6PV4Dc5zDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 17:48:14 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v557hlEJ090751
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 03:48:12 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2avxsdsvpj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 03:48:12 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 5 Jun 2017 17:48:09 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v557lx1o66257134
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 17:48:07 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v557lYm0026601
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 17:47:35 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: christophe leroy <christophe.leroy@c-s.fr>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Scott Wood <oss@buserror.net>
Subject: Re: [PATCH v2 2/2] powerpc/mm/hugetlb: Add support for reserving
 gigantic huge pages via kernel command line
In-Reply-To: <b785b7b4-d6ee-3884-c140-74499171518c@c-s.fr>
References: <1496327441-7368-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1496327441-7368-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <b785b7b4-d6ee-3884-c140-74499171518c@c-s.fr>
Date: Mon, 05 Jun 2017 13:17:08 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87bmq23mgz.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

christophe leroy <christophe.leroy@c-s.fr> writes:

> Le 01/06/2017 =C3=A0 16:30, Aneesh Kumar K.V a =C3=A9crit :
>> With commit aa888a74977a8 ("hugetlb: support larger than MAX_ORDER") we =
added
>> support for allocating gigantic hugepages via kernel command line. Switch
>> ppc64 arch specific code to use that.
>
> Is it only ppc64 ? Your patch removes things defined for the 8xx and=20
> modifies stuff in init_32.c
>
> On the 8xx, as far as I remember, 8M pages on 4k pages mode are above=20
> default MAX_ORDER, I solved it by increasing MAX_ORDER. Is that wrong ?


I was hoping every platform can switch to generic code. Obviously I
didn't test the changes on anything other than ppc64. Can you try with
this patchset and pass hugepagesz=3D<size> hugepages=3D<number> kernel arg
and see if hugepage allocation works for you ?

>
>>
>> W.r.t FSL support, we now limit our allocation range using BOOTMEM_ALLOC=
_ACCESSIBLE.
>>
>> We use the kernel command line to do reservation of hugetlb pages on pow=
ernv
>> platforms. On pseries hash mmu mode the supported gigantic huge page siz=
e is
>> 16GB and that can only be allocated with hypervisor assist. For pseries =
the
>> command line option doesn't do the allocation. Instead pseries does giga=
ntic
>> hugepage allocation based on hypervisor hint that is specified via
>> "ibm,expected#pages" property of the memory node.
>>
>> Cc: Scott Wood <oss@buserror.net>
>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |   2 +-
>>  arch/powerpc/include/asm/hugetlb.h            |  14 --
>>  arch/powerpc/kernel/setup-common.c            |   7 -
>>  arch/powerpc/mm/hash_utils_64.c               |   2 +-
>>  arch/powerpc/mm/hugetlbpage.c                 | 177 +++----------------=
-------
>>  arch/powerpc/mm/init_32.c                     |   2 -
>>  6 files changed, 22 insertions(+), 182 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerp=
c/include/asm/book3s/64/mmu-hash.h
>> index 6981a52b3887..67766e60a6b6 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> @@ -468,7 +468,7 @@ extern int htab_bolt_mapping(unsigned long vstart, u=
nsigned long vend,
>>  			     int psize, int ssize);
>>  int htab_remove_mapping(unsigned long vstart, unsigned long vend,
>>  			int psize, int ssize);
>> -extern void add_gpage(u64 addr, u64 page_size, unsigned long number_of_=
pages);
>> +extern void pSeries_add_gpage(u64 addr, u64 page_size, unsigned long nu=
mber_of_pages);
>
> Linux kernel coding style says 'mixed-case names are frowned upon'

Agreed, but that is how we named all the pseries related functions in
platforms/pseries/*.c files. Hence i kept the same naming style.

-aneesh
