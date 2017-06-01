Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdxm03JHxzDqKF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 05:11:44 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51J9BCF018570
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 15:11:36 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2atpfc6hsg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 15:11:36 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 13:11:35 -0600
Subject: Re: [PATCH v2 2/2] powerpc/mm/hugetlb: Add support for reserving
 gigantic huge pages via kernel command line
To: christophe leroy <christophe.leroy@c-s.fr>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1496327441-7368-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1496327441-7368-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <b785b7b4-d6ee-3884-c140-74499171518c@c-s.fr>
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 1 Jun 2017 12:11:29 -0700
MIME-Version: 1.0
In-Reply-To: <b785b7b4-d6ee-3884-c140-74499171518c@c-s.fr>
Content-Type: text/plain; charset=windows-1252
Message-Id: <1fc6f24e-2022-883a-fc90-8d629a181285@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/01/2017 09:42 AM, christophe leroy wrote:
> 
> 
> Le 01/06/2017 à 16:30, Aneesh Kumar K.V a écrit :
>> With commit aa888a74977a8 ("hugetlb: support larger than MAX_ORDER") we added
>> support for allocating gigantic hugepages via kernel command line. Switch
>> ppc64 arch specific code to use that.
> 
> Is it only ppc64 ? Your patch removes things defined for the 8xx and 
> modifies stuff in init_32.c
> 
> On the 8xx, as far as I remember, 8M pages on 4k pages mode are above 
> default MAX_ORDER, I solved it by increasing MAX_ORDER. Is that wrong ?
> 
>>
>> W.r.t FSL support, we now limit our allocation range using BOOTMEM_ALLOC_ACCESSIBLE.
>>
>> We use the kernel command line to do reservation of hugetlb pages on powernv
>> platforms. On pseries hash mmu mode the supported gigantic huge page size is
>> 16GB and that can only be allocated with hypervisor assist. For pseries the
>> command line option doesn't do the allocation. Instead pseries does gigantic
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
>>  arch/powerpc/mm/hugetlbpage.c                 | 177 +++-----------------------
>>  arch/powerpc/mm/init_32.c                     |   2 -
>>  6 files changed, 22 insertions(+), 182 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> index 6981a52b3887..67766e60a6b6 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> @@ -468,7 +468,7 @@ extern int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
>>  			     int psize, int ssize);
>>  int htab_remove_mapping(unsigned long vstart, unsigned long vend,
>>  			int psize, int ssize);
>> -extern void add_gpage(u64 addr, u64 page_size, unsigned long number_of_pages);
>> +extern void pSeries_add_gpage(u64 addr, u64 page_size, unsigned long number_of_pages);
> 
> Linux kernel coding style says 'mixed-case names are frowned upon'

True, but there is precedent within arch/powerpc/platforms/pseries seeing as "pSeries_" is
already used heavily to prefix function names.

-Tyrel

> 
> Christophe
> 
> ---
> L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
> https://www.avast.com/antivirus
> 
