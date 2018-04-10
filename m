Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LCgN08tvzF2QL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 02:44:15 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3AGgBcW074930
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 12:44:13 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h8w8evtuc-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 12:44:12 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 10 Apr 2018 17:44:10 +0100
Subject: Re: [PATCH v2 2/2] mm: remove odd HAVE_PTE_SPECIAL
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 mhocko@kernel.org, aneesh.kumar@linux.vnet.ibm.com,
 akpm@linux-foundation.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org,
 Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>,
 Albert Ou <albert@sifive.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 David Rientjes <rientjes@google.com>
References: <1523373951-10981-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523373951-10981-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <3f20ac8b-20b8-f052-bc44-dcc0316354ca@arm.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 18:44:00 +0200
MIME-Version: 1.0
In-Reply-To: <3f20ac8b-20b8-f052-bc44-dcc0316354ca@arm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1521dc0e-e9f8-d10f-e213-1b1552eb03fa@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/04/2018 17:58, Robin Murphy wrote:
> On 10/04/18 16:25, Laurent Dufour wrote:
>> Remove the additional define HAVE_PTE_SPECIAL and rely directly on
>> CONFIG_ARCH_HAS_PTE_SPECIAL.
>>
>> There is no functional change introduced by this patch
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>   mm/memory.c | 23 ++++++++++-------------
>>   1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 96910c625daa..53b6344a90d2 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -817,19 +817,13 @@ static void print_bad_pte(struct vm_area_struct *vma,
>> unsigned long addr,
>>    * PFNMAP mappings in order to support COWable mappings.
>>    *
>>    */
>> -#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>> -# define HAVE_PTE_SPECIAL 1
>> -#else
>> -# define HAVE_PTE_SPECIAL 0
>> -#endif
>>   struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>>                    pte_t pte, bool with_public_device)
>>   {
>>       unsigned long pfn = pte_pfn(pte);
>>   -    if (HAVE_PTE_SPECIAL) {
>> -        if (likely(!pte_special(pte)))
>> -            goto check_pfn;
>> +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
> 
> Nit: Couldn't you use IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) within the
> existing code structure to avoid having to add these #ifdefs?

I agree, that would be better. I didn't thought about this option..
Thanks for reporting this.
