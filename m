Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rzl94Cb1zF1F0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 16:20:19 +1000 (AEST)
Subject: Re: [PATCH v3] powerpc: Implement csum_ipv6_magic in assembly
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
References: <20180522065701.9DE696CCB4@po14934vm.idsi0.si.c-s.fr>
 <20180523183447.GV17342@gate.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3848a4ad-2c0e-691f-e98f-347cfe3484e8@c-s.fr>
Date: Thu, 24 May 2018 08:20:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180523183447.GV17342@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 23/05/2018 à 20:34, Segher Boessenkool a écrit :
> On Tue, May 22, 2018 at 08:57:01AM +0200, Christophe Leroy wrote:
>> The generic csum_ipv6_magic() generates a pretty bad result
> 
> <snip>
> 
> Please try with a more recent compiler, what you used is pretty ancient.
> It's not like recent compilers do great on this either, but it's not
> *that* bad anymore ;-)
> 
>> --- a/arch/powerpc/lib/checksum_32.S
>> +++ b/arch/powerpc/lib/checksum_32.S
>> @@ -293,3 +293,36 @@ dst_error:
>>   	EX_TABLE(51b, dst_error);
>>   
>>   EXPORT_SYMBOL(csum_partial_copy_generic)
>> +
>> +/*
>> + * static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>> + *				      const struct in6_addr *daddr,
>> + *				      __u32 len, __u8 proto, __wsum sum)
>> + */
>> +
>> +_GLOBAL(csum_ipv6_magic)
>> +	lwz	r8, 0(r3)
>> +	lwz	r9, 4(r3)
>> +	lwz	r10, 8(r3)
>> +	lwz	r11, 12(r3)
>> +	addc	r0, r5, r6
>> +	adde	r0, r0, r7
>> +	adde	r0, r0, r8
>> +	adde	r0, r0, r9
>> +	adde	r0, r0, r10
>> +	adde	r0, r0, r11
>> +	lwz	r8, 0(r4)
>> +	lwz	r9, 4(r4)
>> +	lwz	r10, 8(r4)
>> +	lwz	r11, 12(r4)
>> +	adde	r0, r0, r8
>> +	adde	r0, r0, r9
>> +	adde	r0, r0, r10
>> +	adde	r0, r0, r11
>> +	addze	r0, r0
>> +	rotlwi	r3, r0, 16
>> +	add	r3, r0, r3
>> +	not	r3, r3
>> +	rlwinm	r3, r3, 16, 16, 31
>> +	blr
>> +EXPORT_SYMBOL(csum_ipv6_magic)
> 
> Clustering the loads and carry insns together is pretty much the worst you
> can do on most 32-bit CPUs.

Oh, really ? __csum_partial is written that way too.

Right, now I tried interleaving the lwz and adde. I get no improvment at 
all on a 885, but I get a 15% improvment on a 8321.

Christophe

> 
> 
> Segher
> 
