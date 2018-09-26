Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KrGn1Qg5zF3Fm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 18:10:41 +1000 (AEST)
Subject: Re: [PATCH v5 18/22] powerpc/mm: Extend pte_fragment functionality to
 nohash/32
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
 <cda95a5508594e2a2ad5f6f214c435d9a1b44c46.1537892499.git.christophe.leroy@c-s.fr>
 <87in2tgeix.fsf@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <156d8a34-c40f-553a-0d4a-98433af1a1a2@c-s.fr>
Date: Wed, 26 Sep 2018 10:10:36 +0200
MIME-Version: 1.0
In-Reply-To: <87in2tgeix.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/09/2018 à 04:48, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> In order to allow the 8xx to handle pte_fragments, this patch
>> extends the use of pte_fragments to nohash/32 platforms.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/mmu_context.h       |  2 +-
>>   arch/powerpc/include/asm/nohash/32/mmu-40x.h |  1 +
>>   arch/powerpc/include/asm/nohash/32/mmu-44x.h |  1 +
>>   arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  1 +
>>   arch/powerpc/include/asm/nohash/32/mmu.h     |  4 ++-
>>   arch/powerpc/include/asm/nohash/32/pgalloc.h | 52 +++++++++++++---------------
>>   arch/powerpc/include/asm/nohash/32/pgtable.h | 11 ++++--
>>   arch/powerpc/include/asm/nohash/mmu-book3e.h |  1 +
>>   arch/powerpc/mm/Makefile                     |  3 ++
>>   arch/powerpc/mm/mmu_context_nohash.c         | 14 ++++++++
>>   10 files changed, 57 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
>> index b2f89b621b15..7f2c37a3f99d 100644
>> --- a/arch/powerpc/include/asm/mmu_context.h
>> +++ b/arch/powerpc/include/asm/mmu_context.h
>> @@ -222,7 +222,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
>>   	return 0;
>>   }
>>   
>> -#ifndef CONFIG_PPC_BOOK3S_64
>> +#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_BOOK3S_32)
>>   static inline void arch_exit_mmap(struct mm_struct *mm)
>>   {
>>   }
> 
> 
> Can we do that with #ifndef arch_exit_mmap? This should handle every
> platform that doesn't use pte_frag right?

Yes we can, that means moving arch_exit_mmap() prototype in platform 
specific mmu headers, and adding there a #define arch_exit_mmap 
arch_exit_mmap

Is that your idea ?

Christophe


> 
> 
>> diff --git a/arch/powerpc/include/asm/nohash/32/mmu-40x.h b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
>> index 74f4edb5916e..7c77ceed71d6 100644
>> --- a/arch/powerpc/include/asm/nohash/32/mmu-40x.h
>> +++ b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
>> @@ -58,6 +58,7 @@ typedef struct {
>>   	unsigned int	id;
>>   	unsigned int	active;
>>   	unsigned long	vdso_base;
> 
> -aneesh
> 
