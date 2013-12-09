Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 84D712C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2013 19:42:04 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 9 Dec 2013 18:42:02 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5DE763578050
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2013 19:42:00 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB98fmiF786726
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Dec 2013 19:41:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB98fx7e028308
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Dec 2013 19:42:00 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Hong H. Pham" <hong.pham@windriver.com>
Subject: Re: [PATCH v3] powerpc: Fix PTE page address mismatch in pgtable
 ctor/dtor
In-Reply-To: <1386448079.21910.105.camel@pasglop>
References: <874n6muuw4.fsf@linux.vnet.ibm.com>
 <1386425193-24015-1-git-send-email-hong.pham@windriver.com>
 <1386448079.21910.105.camel@pasglop>
Date: Mon, 09 Dec 2013 14:11:56 +0530
Message-ID: <87vbyybeln.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-rt-users <linux-rt-users@vger.kernel.org>,
 linux-stable <stable@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sat, 2013-12-07 at 09:06 -0500, Hong H. Pham wrote:
>
>> diff --git a/arch/powerpc/include/asm/pgalloc-32.h b/arch/powerpc/include/asm/pgalloc-32.h
>> index 27b2386..842846c 100644
>> --- a/arch/powerpc/include/asm/pgalloc-32.h
>> +++ b/arch/powerpc/include/asm/pgalloc-32.h
>> @@ -84,10 +84,8 @@ static inline void pgtable_free_tlb(struct mmu_gather *tlb,
>>  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>>  				  unsigned long address)
>>  {
>> -	struct page *page = page_address(table);
>> -
>>  	tlb_flush_pgtable(tlb, address);
>> -	pgtable_page_dtor(page);
>> -	pgtable_free_tlb(tlb, page, 0);
>> +	pgtable_page_dtor(table);
>> +	pgtable_free_tlb(tlb, page_address(table), 0);
>>  }
>
> Ok so your description of the problem confused me a bit, but I see that
> in the !64K page, pgtable_t is already a struct page so yes, the
> page_address() call here is bogus.
>
> However, I also noticed that in the 64k page case, we don't call the dto
> at all. Is that a problem ?
>
> Also, Aneesh, shouldn't we just fix the disconnect here and have
> pgtable_t always be the same type ? The way this is now is confusing
> and error prone...

With pte page fragments that may not be possible right ?. With PTE fragments,
we share the page allocated with multiple pmd entries 

5c1f6ee9a31cbdac90bbb8ae1ba4475031ac74b4 should have more details

>
>>  #endif /* _ASM_POWERPC_PGALLOC_32_H */
>> diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
>> index f65e27b..256d6f8 100644
>> --- a/arch/powerpc/include/asm/pgalloc-64.h
>> +++ b/arch/powerpc/include/asm/pgalloc-64.h
>> @@ -144,11 +144,9 @@ static inline void pgtable_free_tlb(struct mmu_gather *tlb,
>>  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>>  				  unsigned long address)
>>  {
>> -	struct page *page = page_address(table);
>> -
>>  	tlb_flush_pgtable(tlb, address);
>> -	pgtable_page_dtor(page);
>> -	pgtable_free_tlb(tlb, page, 0);
>> +	pgtable_page_dtor(table);
>> +	pgtable_free_tlb(tlb, page_address(table), 0);
>>  }
>>  
>>  #else /* if CONFIG_PPC_64K_PAGES */
>
> Ben.

-aneesh
