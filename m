Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mszf14P9zF27L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 23:46:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/lib: Remove .balign inside string functions for
 PPC32
In-Reply-To: <20180517231938.4b1b8172@roar.ozlabs.ibm.com>
References: <20180517100413.856096F938@po14934vm.idsi0.si.c-s.fr>
 <20180517231938.4b1b8172@roar.ozlabs.ibm.com>
Date: Thu, 17 May 2018 23:46:52 +1000
Message-ID: <87wow2mm2b.fsf@concordia.ellerman.id.au>
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

> On Thu, 17 May 2018 12:04:13 +0200 (CEST)
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>
>> commit 87a156fb18fe1 ("Align hot loops of some string functions")
>> degraded the performance of string functions by adding useless
>> nops
>> 
>> A simple benchmark on an 8xx calling 100000x a memchr() that
>> matches the first byte runs in 41668 TB ticks before this patch
>> and in 35986 TB ticks after this patch. So this gives an
>> improvement of approx 10%
>> 
>> Another benchmark doing the same with a memchr() matching the 128th
>> byte runs in 1011365 TB ticks before this patch and 1005682 TB ticks
>> after this patch, so regardless on the number of loops, removing
>> those useless nops improves the test by 5683 TB ticks.
>> 
>> Fixes: 87a156fb18fe1 ("Align hot loops of some string functions")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  Was sent already as part of a serie optimising string functions.
>>  Resending on itself as it is independent of the other changes in the
>> serie
>> 
>>  arch/powerpc/lib/string.S | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
>> index a787776822d8..a026d8fa8a99 100644
>> --- a/arch/powerpc/lib/string.S
>> +++ b/arch/powerpc/lib/string.S
>> @@ -23,7 +23,9 @@ _GLOBAL(strncpy)
>>  	mtctr	r5
>>  	addi	r6,r3,-1
>>  	addi	r4,r4,-1
>> +#ifdef CONFIG_PPC64
>>  	.balign 16
>> +#endif
>>  1:	lbzu	r0,1(r4)
>>  	cmpwi	0,r0,0
>>  	stbu	r0,1(r6)
>
> The ifdefs are a bit ugly, but you can't argue with the numbers. These
> alignments should be IFETCH_ALIGN_BYTES, which is intended to optimise
> the ifetch performance when you have such a loop (although there is
> always a tradeoff for a single iteration).
>
> Would it make sense to define that for 32-bit as well, and you could use
> it here instead of the ifdefs? Small CPUs could just use 0.

Can we do it with a macro in the header, eg. like:

#ifdef CONFIG_PPC64
#define IFETCH_BALIGN	.balign IFETCH_ALIGN_BYTES
#endif

...

  	addi	r4,r4,-1
  	IFETCH_BALIGN
  1:	lbzu	r0,1(r4)


cheers
