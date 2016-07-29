Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s16K00cYbzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 21:42:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 10/21] powerpc/mm: Define radix_enabled() in one place
 & use static inline
In-Reply-To: <20160728174611.1ec99066@roar.ozlabs.ibm.com>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-10-git-send-email-mpe@ellerman.id.au>
 <20160728174611.1ec99066@roar.ozlabs.ibm.com>
Date: Fri, 29 Jul 2016 21:42:11 +1000
Message-ID: <87d1lwllgs.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Thu, 28 Jul 2016 00:18:06 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> diff --git a/arch/powerpc/include/asm/mmu.h
>> b/arch/powerpc/include/asm/mmu.h index eb942a446969..f413b3213a3b
>> 100644 --- a/arch/powerpc/include/asm/mmu.h
>> +++ b/arch/powerpc/include/asm/mmu.h
>> @@ -163,6 +163,18 @@ static inline void assert_pte_locked(struct
>> mm_struct *mm, unsigned long addr) }
>>  #endif /* !CONFIG_DEBUG_VM */
>>  
>> +#ifdef CONFIG_PPC_RADIX_MMU
>> +static inline bool radix_enabled(void)
>> +{
>> +	return mmu_has_feature(MMU_FTR_TYPE_RADIX);
>> +}
>> +#else
>> +static inline bool radix_enabled(void)
>> +{
>> +	return false;
>> +}
>> +#endif
>
> Won't MMU_FTRS_POSSIBLE just do the right thing when
> !CONFIG_PPC_RADIX_MMU?

Yes it should.

I'll have to work out why Aneesh thought he needed to do it explicitly
and whether that is needed or not.

cheers
