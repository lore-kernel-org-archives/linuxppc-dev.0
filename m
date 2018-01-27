Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zT9fq18ZKzF0Q1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 20:37:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] powerpc/32: Fix hugepage allocation on 8xx at hint
 address
In-Reply-To: <87shb2z22l.fsf@linux.vnet.ibm.com>
References: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
 <ed0e31af563aa34045b43a20d0668650e8a7bb7a.1516179904.git.christophe.leroy@c-s.fr>
 <87shb2z22l.fsf@linux.vnet.ibm.com>
Date: Sat, 27 Jan 2018 20:37:35 +1100
Message-ID: <87inbn3an4.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> On the 8xx, the page size is set in the PMD entry and applies to
>> all pages of the page table pointed by the said PMD entry.
>>
...
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index a9b9083c5e49..79e1378ee303 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -553,9 +553,11 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>>  	struct hstate *hstate = hstate_file(file);
>>  	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));
>>  
>> +#ifdef CONFIG_PPC_RADIX_MMU
>>  	if (radix_enabled())
>>  		return radix__hugetlb_get_unmapped_area(file, addr, len,
>>  						       pgoff, flags);
>> +#endif
>
> if (0) didn't remove the following radix__hugetlb_get_unmapped_area for
> you? 

It will remove the call, but you still need at least a prototype, or an
empty static inline.

cheers
