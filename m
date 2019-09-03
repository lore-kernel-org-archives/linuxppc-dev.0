Return-Path: <SRS0=+4wI=W6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196ECC3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 11:29:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5647C21897
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 11:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5647C21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46N4Tt0q5DzDqYk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 21:29:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46N4Py6gJ3zDqVr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2019 21:25:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46N4Pw6dvpz9sDB;
 Tue,  3 Sep 2019 21:25:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Subject: Re: [PATCH v2 3/6] powerpc: Convert flush_icache_range & friends to C
In-Reply-To: <44b8223d-52d9-e932-4bb7-b7590ea11a03@c-s.fr>
References: <20190903052407.16638-1-alastair@au1.ibm.com>
 <20190903052407.16638-4-alastair@au1.ibm.com>
 <44b8223d-52d9-e932-4bb7-b7590ea11a03@c-s.fr>
Date: Tue, 03 Sep 2019 21:25:39 +1000
Message-ID: <87muflr58s.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Qian Cai <cai@lca.pw>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 03/09/2019 =C3=A0 07:23, Alastair D'Silva a =C3=A9crit=C2=A0:
>> From: Alastair D'Silva <alastair@d-silva.org>
>>=20
>> Similar to commit 22e9c88d486a
>> ("powerpc/64: reuse PPC32 static inline flush_dcache_range()")
>> this patch converts the following ASM symbols to C:
>>      flush_icache_range()
>>      __flush_dcache_icache()
>>      __flush_dcache_icache_phys()
>>=20
>> This was done as we discovered a long-standing bug where the length of t=
he
>> range was truncated due to using a 32 bit shift instead of a 64 bit one.
>>=20
>> By converting these functions to C, it becomes easier to maintain.
>>=20
>> flush_dcache_icache_phys() retains a critical assembler section as we mu=
st
>> ensure there are no memory accesses while the data MMU is disabled
>> (authored by Christophe Leroy). Since this has no external callers, it h=
as
>> also been made static, allowing the compiler to inline it within
>> flush_dcache_icache_page().
>>=20
>> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/cache.h      |  26 ++---
>>   arch/powerpc/include/asm/cacheflush.h |  24 ++--
>>   arch/powerpc/kernel/misc_32.S         | 117 --------------------
>>   arch/powerpc/kernel/misc_64.S         | 102 -----------------
>>   arch/powerpc/mm/mem.c                 | 152 +++++++++++++++++++++++++-
>>   5 files changed, 173 insertions(+), 248 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm=
/cache.h
>> index f852d5cd746c..91c808c6738b 100644
>> --- a/arch/powerpc/include/asm/cache.h
>> +++ b/arch/powerpc/include/asm/cache.h
>> @@ -98,20 +98,7 @@ static inline u32 l1_icache_bytes(void)
>>   #endif
>>   #endif /* ! __ASSEMBLY__ */
>>=20=20=20
>> -#if defined(__ASSEMBLY__)
>> -/*
>> - * For a snooping icache, we still need a dummy icbi to purge all the
>> - * prefetched instructions from the ifetch buffers. We also need a sync
>> - * before the icbi to order the the actual stores to memory that might
>> - * have modified instructions with the icbi.
>> - */
>> -#define PURGE_PREFETCHED_INS	\
>> -	sync;			\
>> -	icbi	0,r3;		\
>> -	sync;			\
>> -	isync
>> -
>> -#else
>> +#if !defined(__ASSEMBLY__)
>>   #define __read_mostly __attribute__((__section__(".data..read_mostly")=
))
>>=20=20=20
>>   #ifdef CONFIG_PPC_BOOK3S_32
>> @@ -145,6 +132,17 @@ static inline void dcbst(void *addr)
>>   {
>>   	__asm__ __volatile__ ("dcbst %y0" : : "Z"(*(u8 *)addr) : "memory");
>>   }
>> +
>> +static inline void icbi(void *addr)
>> +{
>> +	__asm__ __volatile__ ("icbi 0, %0" : : "r"(addr) : "memory");
>
> I think "__asm__ __volatile__" is deprecated. Use "asm volatile" instead.

Yes please.

>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>> index 9191a66b3bc5..cd540123874d 100644
>> --- a/arch/powerpc/mm/mem.c
>> +++ b/arch/powerpc/mm/mem.c
>> @@ -321,6 +321,105 @@ void free_initmem(void)
>>   	free_initmem_default(POISON_FREE_INITMEM);
>>   }
>>=20=20=20
>> +/*
>> + * Warning: This macro will perform an early return if the CPU has
>> + * a coherent icache. The intent is is call this early in function,
>> + * and handle the non-coherent icache variant afterwards.
>> + *
>> + * For a snooping icache, we still need a dummy icbi to purge all the
>> + * prefetched instructions from the ifetch buffers. We also need a sync
>> + * before the icbi to order the the actual stores to memory that might
>> + * have modified instructions with the icbi.
>> + */
>> +#define flush_coherent_icache_or_return(addr) {			\
>> +	if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {		\
>> +		mb(); /* sync */				\
>> +		icbi(addr);					\
>> +		mb(); /* sync */				\
>> +		isync();					\
>> +		return;						\
>> +	}							\
>> +}
>
> I hate this kind of awful macro which kills code readability.

Yes I agree.

> Please to something like
>
> static bool flush_coherent_icache_or_return(unsigned long addr)
> {
> 	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
> 		return false;
>
> 	mb(); /* sync */
> 	icbi(addr);
> 	mb(); /* sync */
> 	isync();
> 	return true;
> }
>
> then callers will do:
>
> 	if (flush_coherent_icache_or_return(addr))
> 		return;

I don't think it needs the "_or_return" in the name.

eg, it can just be:

 	if (flush_coherent_icache(addr))
		return;


Which reads fine I think, ie. flush the coherent icache, and if that
succeeds return, else continue.

cheers
