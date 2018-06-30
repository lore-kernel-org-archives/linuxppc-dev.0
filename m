Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Hk476KfMzF1fk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 16:23:51 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5U6J9xY088209
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 02:23:49 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jx46n0pd9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 02:23:49 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Sat, 30 Jun 2018 02:23:47 -0400
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Matthew Wilcox <willy@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Jerome Glisse
 <jglisse@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Pekka Enberg <penberg@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
 <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
 <20180629214647.mkgpni6hxj7aore4@kshutemo-mobl1>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Sat, 30 Jun 2018 11:53:32 +0530
MIME-Version: 1.0
In-Reply-To: <20180629214647.mkgpni6hxj7aore4@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c6461a35-c66d-6c62-a255-175917d8881b@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2018 03:16 AM, Kirill A. Shutemov wrote:
> On Fri, Jun 29, 2018 at 02:01:46PM -0700, Linus Torvalds wrote:
>> On Fri, Jun 29, 2018 at 1:42 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>>
>>> I have more information regarding this BUG. Line 700 of page-flags.h is the
>>> macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually expanded
>>> the macro, and found that the bug line is VM_BUG_ON_PAGE(!PageTable(page), page)
>>> in routine __ClearPageTable(), which is called from pgtable_page_dtor() in
>>> include/linux/mm.h. I also added a printk call to PageTable() that logs
>>> page->page_type. The routine was called twice. The first had page_type of
>>> 0xfffffbff, which would have been expected for a . The second call had
>>> 0xffffffff, which led to the BUG.
>>
>> So it looks to me like the tear-down of the page tables first found a
>> page that is indeed a page table, and cleared the page table bit
>> (well, it set it - the bits are reversed).
>>
>> Then it took an exception (that "interrupt: 700") and that causes
>> do_exit() again, and it tries to free the same page table - and now
>> it's no longer marked as a page table, because it already went through
>> the __ClearPageTable() dance once.
>>
>> So on the second path through, it catches that "the bit already said
>> it wasn't a page table" and does the BUG.
>>
>> But the real question is what the problem was the *first* time around.
> 
> +Aneesh.
> 
> Looks like pgtable_page_dtor() gets called in __pte_free_tlb() path twice.
> Once in __pte_free_tlb() itself and the second time in pgtable_free().
> 
> Would this help?
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
> index 6a6673907e45..e7a2f0e6b695 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
> @@ -137,7 +137,6 @@ static inline void pgtable_free_tlb(struct mmu_gather *tlb,
>   static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>   				  unsigned long address)
>   {
> -	pgtable_page_dtor(table);
>   	pgtable_free_tlb(tlb, page_address(table), 0);
>   }
>   #endif /* _ASM_POWERPC_BOOK3S_32_PGALLOC_H */
> diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
> index 1707781d2f20..30a13b80fd58 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
> @@ -139,7 +139,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>   				  unsigned long address)
>   {
>   	tlb_flush_pgtable(tlb, address);
> -	pgtable_page_dtor(table);
>   	pgtable_free_tlb(tlb, page_address(table), 0);
>   }
>   #endif /* _ASM_POWERPC_PGALLOC_32_H */
> 


https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-June/175015.html

Also part of pull request from Michael Ellerman

-aneesh
