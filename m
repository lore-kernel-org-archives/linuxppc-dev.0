Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sb8W6H7SzF1fW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 15:55:55 +1000 (AEST)
Subject: Re: [PATCH v4 3/3] powerpc/lib: optimise PPC32 memcmp
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1527004752.git.christophe.leroy@c-s.fr>
 <05bd657afedaf4a0de5abab0c5db2e88fa73bdfe.1527004752.git.christophe.leroy@c-s.fr>
 <bb7ef10a-4777-7635-3e54-830dd3eeb8bb@c-s.fr>
 <20180524172458.GA17342@gate.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7a77175e-c0c4-4a38-d972-d98ac76cf70a@c-s.fr>
Date: Fri, 25 May 2018 07:55:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180524172458.GA17342@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/05/2018 à 19:24, Segher Boessenkool a écrit :
> On Wed, May 23, 2018 at 09:47:32AM +0200, Christophe Leroy wrote:
>> At the time being, memcmp() compares two chunks of memory
>> byte per byte.
>>
>> This patch optimises the comparison by comparing word by word.
>>
>> A small benchmark performed on an 8xx comparing two chuncks
>> of 512 bytes performed 100000 times gives:
>>
>> Before : 5852274 TB ticks
>> After:   1488638 TB ticks
> 
>> diff --git a/arch/powerpc/lib/string_32.S b/arch/powerpc/lib/string_32.S
>> index 40a576d56ac7..542e6cecbcaf 100644
>> --- a/arch/powerpc/lib/string_32.S
>> +++ b/arch/powerpc/lib/string_32.S
>> @@ -16,17 +16,45 @@
>>   	.text
>>
>>   _GLOBAL(memcmp)
>> -	cmpwi	cr0, r5, 0
>> -	beq-	2f
>> -	mtctr	r5
>> -	addi	r6,r3,-1
>> -	addi	r4,r4,-1
>> -1:	lbzu	r3,1(r6)
>> -	lbzu	r0,1(r4)
>> -	subf.	r3,r0,r3
>> -	bdnzt	2,1b
>> +	srawi.	r7, r5, 2		/* Divide len by 4 */
>> +	mr	r6, r3
>> +	beq-	3f
>> +	mtctr	r7
>> +	li	r7, 0
>> +1:
>> +#ifdef __LITTLE_ENDIAN__
>> +	lwbrx	r3, r6, r7
>> +	lwbrx	r0, r4, r7
>> +#else
>> +	lwzx	r3, r6, r7
>> +	lwzx	r0, r4, r7
>> +#endif
> 
> You don't test whether the pointers are word-aligned.  Does that work?

copy_tofrom_user() word-aligns the store address and doesn't take care 
of the load address, so I believe it works.

Now, I just read in the MPC885 Ref Manual that unaligned access 
generates alignment exception when the processor is running in LE mode.

Ref. made to the discussion on patch "powerpc/32be: use stmw/lmw for 
registers save/restore in asm" 
(https://patchwork.ozlabs.org/patch/899465/), I will drop the handling 
for LE mode.

Christophe

> Say, when a load is crossing a page boundary, or segment boundary.
> 
> 
> Segher
> 
