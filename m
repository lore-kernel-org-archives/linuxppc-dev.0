Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28C7F1A001B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 15:29:04 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 23 Oct 2014 09:59:01 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B9F8E394004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 09:58:59 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9N4SlWE60096568
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 09:58:47 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9N4SwHp018700
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 09:58:59 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V2 1/2] mm: Update generic gup implementation to handle
 hugepage directory
In-Reply-To: <20141022160224.9c2268795e55d5a2eff5b94d@linux-foundation.org>
References: <1413520687-31729-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20141022160224.9c2268795e55d5a2eff5b94d@linux-foundation.org>
Date: Thu, 23 Oct 2014 09:58:58 +0530
Message-ID: <87tx2vh0j9.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org,
 Steve Capper <steve.capper@linaro.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri, 17 Oct 2014 10:08:06 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Update generic gup implementation with powerpc specific details.
>> On powerpc at pmd level we can have hugepte, normal pmd pointer
>> or a pointer to the hugepage directory.
>> 
>> ...
>>
>> --- a/arch/arm/include/asm/pgtable.h
>> +++ b/arch/arm/include/asm/pgtable.h
>> @@ -181,6 +181,8 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>>  /* to find an entry in a kernel page-table-directory */
>>  #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
>>  
>> +#define pgd_huge(pgd)		(0)
>> +
>>  #define pmd_none(pmd)		(!pmd_val(pmd))
>>  #define pmd_present(pmd)	(pmd_val(pmd))
>>  
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index cefd3e825612..ed8f42497ac4 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -464,6 +464,8 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>>  extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
>>  
>> +#define pgd_huge(pgd)		(0)
>> +
>
> So only arm, arm64 and powerpc implement CONFIG_HAVE_GENERIC_RCU_GUP
> and only powerpc impements pgd_huge().
>
> Could we get a bit of documentation in place for pgd_huge() so that
> people who aren't familiar with powerpc can understand what's going
> on?

Will update

>
>>  /*
>>   * Encode and decode a swap entry:
>>   *	bits 0-1:	present (must be zero)
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 02d11ee7f19d..f97732412cb4 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1219,6 +1219,32 @@ long get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>>  		    struct vm_area_struct **vmas);
>>  int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>>  			struct page **pages);
>> +
>> +#ifdef CONFIG_HAVE_GENERIC_RCU_GUP
>> +#ifndef is_hugepd
>
> And is_hugepd is a bit of a mystery.  Let's get some description in
> place for this as well?  Why it exists, what its role is.  Also,
> specifically which arch header file is responsible for defining it.
>
> It takes a hugepd_t argument, but hugepd_t is defined later in this
> header file.  This is weird because any preceding implementation of
> is_hugepd() can't actually be implemented because it hasn't seen the
> hugepd_t definition yet!  So any is_hugepd() implementation is forced
> to be a simple macro which punts to a C function which *has* seen the
> hugepd_t definition.  What a twisty maze.

arch can definitely do

#defne is_hugepd is_hugepd
typedef struct { unsigned long pd; } hugepd_t;
static inline int is_hugepd(hugepd_t hpd)
{

}

I wanted to make sure arch can have their own definition of hugepd_t . 

>
> It all seems messy, confusing and poorly documented.  Can we clean this
> up?
>
>> +/*
>> + * Some architectures support hugepage directory format that is
>> + * required to support different hugetlbfs sizes.
>> + */
>> +typedef struct { unsigned long pd; } hugepd_t;
>> +#define is_hugepd(hugepd) (0)
>> +#define __hugepd(x) ((hugepd_t) { (x) })
>
> What's this.

macro that is used to convert value to type hugepd_t. We use that style
already for __pte() etc.

>
>> +static inline int gup_hugepd(hugepd_t hugepd, unsigned long addr,
>> +			     unsigned pdshift, unsigned long end,
>> +			     int write, struct page **pages, int *nr)
>> +{
>> +	return 0;
>> +}
>> +#else
>> +extern int gup_hugepd(hugepd_t hugepd, unsigned long addr,
>> +		      unsigned pdshift, unsigned long end,
>> +		      int write, struct page **pages, int *nr);
>> +#endif
>> +extern int gup_huge_pte(pte_t orig, pte_t *ptep, unsigned long addr,
>> +			unsigned long sz, unsigned long end, int write,
>> +			struct page **pages, int *nr);
>> +#endif

-aneesh
