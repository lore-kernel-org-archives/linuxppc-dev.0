Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwRkG4jN9zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 16:29:10 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 28 Apr 2016 11:59:08 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 1A9C1394007B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 11:58:52 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3S6SoEN24903782
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 11:58:51 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3S6SnJb004704
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 11:58:50 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [V2,
 66/68] powerpc/mm/radix: Add THP support for 4k linux page size
In-Reply-To: <3qwPgg104tz9t50@ozlabs.org>
References: <3qwPgg104tz9t50@ozlabs.org>
Date: Thu, 28 Apr 2016 11:58:47 +0530
Message-ID: <87lh3ytffk.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Sat, 2016-09-04 at 06:14:02 UTC, "Aneesh Kumar K.V" wrote:
>
> Missing change log.

This add THP support for 4K linux page size config with Radix. We still
don't do THP with 4K linux page size and hash page table. Hash page
table needs a 16MB hugepage and we can't do THP with 16MM hugepage and
4K linux page size.

We add missing functions to 4k hash config to get it build and
hl_has_transparent_hugepage() make sure we don't enable THP for 4K hash
config. To catch wrong usage of THP related with 4K config, we add BUG()
in those dummpy functions we added to get it compile.


>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> index bb3d8539bb1b..d915788d5074 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> @@ -50,6 +50,65 @@ static inline int hl_hugepd_ok(hugepd_t hpd)
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +
>> +static inline char *get_hpte_slot_array(pmd_t *pmdp)
>> +{
>> +	BUG();
>> +	return NULL;
>> +}
>
> ...
>
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
>> index 53299182dba9..ad9c77399aab 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -72,7 +72,7 @@ config PPC_BOOK3S_64
>>  	select PPC_FPU
>>  	select PPC_HAVE_PMU_SUPPORT
>>  	select SYS_SUPPORTS_HUGETLBFS
>> -	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if PPC_64K_PAGES
>> +	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>
>
> How is this meant to work?
>
> It appears to allow me to build a 4K kernel with THP which will then BUG() as
> soon as I run it on hash?
>
> I assume you'll tell me there's some mechanism somewhere that prevents that from
> happening, but what is it?
>

This one.

int hl_has_transparent_hugepage(void)
{

	if (!mmu_has_feature(MMU_FTR_16M_PAGE))
		return 0;
	/*
	 * We support THP only if PMD_SIZE is 16MB.
	 */
	if (mmu_psize_defs[MMU_PAGE_16M].shift != PMD_SHIFT)
		return 0;
	/*
	 * We need to make sure that we support 16MB hugepage in a segement
	 * with base page size 64K or 4K. We only enable THP with a PAGE_SIZE
	 * of 64K.
	 */
	/*
	 * If we have 64K HPTE, we will be using that by default
	 */
	if (mmu_psize_defs[MMU_PAGE_64K].shift &&
	    (mmu_psize_defs[MMU_PAGE_64K].penc[MMU_PAGE_16M] == -1))
		return 0;
	/*
	 * Ok we only have 4K HPTE
	 */
	if (mmu_psize_defs[MMU_PAGE_4K].penc[MMU_PAGE_16M] == -1)
		return 0;

	return 1;
}

So we will enable THP on a platform only if has_transparent_hugepage()
return 1.

-aneesh
