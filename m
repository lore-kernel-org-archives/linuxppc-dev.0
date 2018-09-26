Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KsWK241RzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 19:06:37 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8Q90WsL126164
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 05:06:34 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mr60tuqns-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 05:06:32 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 26 Sep 2018 05:01:30 -0400
Subject: Re: [PATCH v5 18/22] powerpc/mm: Extend pte_fragment functionality to
 nohash/32
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
 <cda95a5508594e2a2ad5f6f214c435d9a1b44c46.1537892499.git.christophe.leroy@c-s.fr>
 <87in2tgeix.fsf@linux.ibm.com> <156d8a34-c40f-553a-0d4a-98433af1a1a2@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 26 Sep 2018 14:31:22 +0530
MIME-Version: 1.0
In-Reply-To: <156d8a34-c40f-553a-0d4a-98433af1a1a2@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <12bb6cf8-b3e5-c54b-a5a4-d36f30bd28ea@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/26/18 1:40 PM, Christophe LEROY wrote:
> 
> 
> Le 26/09/2018 à 04:48, Aneesh Kumar K.V a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> In order to allow the 8xx to handle pte_fragments, this patch
>>> extends the use of pte_fragments to nohash/32 platforms.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/include/asm/mmu_context.h       |  2 +-
>>>   arch/powerpc/include/asm/nohash/32/mmu-40x.h |  1 +
>>>   arch/powerpc/include/asm/nohash/32/mmu-44x.h |  1 +
>>>   arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  1 +
>>>   arch/powerpc/include/asm/nohash/32/mmu.h     |  4 ++-
>>>   arch/powerpc/include/asm/nohash/32/pgalloc.h | 52 
>>> +++++++++++++---------------
>>>   arch/powerpc/include/asm/nohash/32/pgtable.h | 11 ++++--
>>>   arch/powerpc/include/asm/nohash/mmu-book3e.h |  1 +
>>>   arch/powerpc/mm/Makefile                     |  3 ++
>>>   arch/powerpc/mm/mmu_context_nohash.c         | 14 ++++++++
>>>   10 files changed, 57 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/mmu_context.h 
>>> b/arch/powerpc/include/asm/mmu_context.h
>>> index b2f89b621b15..7f2c37a3f99d 100644
>>> --- a/arch/powerpc/include/asm/mmu_context.h
>>> +++ b/arch/powerpc/include/asm/mmu_context.h
>>> @@ -222,7 +222,7 @@ static inline int arch_dup_mmap(struct mm_struct 
>>> *oldmm,
>>>       return 0;
>>>   }
>>> -#ifndef CONFIG_PPC_BOOK3S_64
>>> +#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_BOOK3S_32)
>>>   static inline void arch_exit_mmap(struct mm_struct *mm)
>>>   {
>>>   }
>>
>>
>> Can we do that with #ifndef arch_exit_mmap? This should handle every
>> platform that doesn't use pte_frag right?
> 
> Yes we can, that means moving arch_exit_mmap() prototype in platform 
> specific mmu headers, and adding there a #define arch_exit_mmap 
> arch_exit_mmap
> 
> Is that your idea ?
> 

yes. that way it is easy to find out which platforms really want that to 
be a different.

-aneesh
