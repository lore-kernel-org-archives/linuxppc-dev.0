Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s5Fh4cJwzF1PF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 20:28:40 +1000 (AEST)
Subject: Re: [PATCH v3] powerpc: Implement csum_ipv6_magic in assembly
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180522065701.9DE696CCB4@po14934vm.idsi0.si.c-s.fr>
 <20180523183447.GV17342@gate.crashing.org>
 <3848a4ad-2c0e-691f-e98f-347cfe3484e8@c-s.fr>
Message-ID: <1dac2356-5d8a-2892-109e-6e1b26c2bd8c@c-s.fr>
Date: Thu, 24 May 2018 10:18:44 +0000
MIME-Version: 1.0
In-Reply-To: <3848a4ad-2c0e-691f-e98f-347cfe3484e8@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/24/2018 06:20 AM, Christophe LEROY wrote:
> 
> 
> Le 23/05/2018 à 20:34, Segher Boessenkool a écrit :
>> On Tue, May 22, 2018 at 08:57:01AM +0200, Christophe Leroy wrote:
>>> The generic csum_ipv6_magic() generates a pretty bad result
>>
>> <snip>
>>
>> Please try with a more recent compiler, what you used is pretty ancient.
>> It's not like recent compilers do great on this either, but it's not
>> *that* bad anymore ;-)


Here is what I get with GCC 8.1
It doesn't look much better, does it ?


net/ipv6/ip6_checksum.o:     file format elf32-powerpc


Disassembly of section .text:

00000000 <csum_ipv6_magic>:
    0:	94 21 ff f0 	stwu    r1,-16(r1)
    4:	80 04 00 00 	lwz     r0,0(r4)
    8:	81 64 00 04 	lwz     r11,4(r4)
    c:	81 04 00 08 	lwz     r8,8(r4)
   10:	93 e1 00 0c 	stw     r31,12(r1)
   14:	81 43 00 00 	lwz     r10,0(r3)
   18:	83 e3 00 04 	lwz     r31,4(r3)
   1c:	81 23 00 08 	lwz     r9,8(r3)
   20:	81 83 00 0c 	lwz     r12,12(r3)
   24:	7c ea 3a 14 	add     r7,r10,r7
   28:	7d 4a 38 10 	subfc   r10,r10,r7
   2c:	7c ff 3a 14 	add     r7,r31,r7
   30:	81 44 00 0c 	lwz     r10,12(r4)
   34:	7c 63 19 10 	subfe   r3,r3,r3
   38:	7c 63 38 50 	subf    r3,r3,r7
   3c:	7f ff 18 10 	subfc   r31,r31,r3
   40:	7c e9 1a 14 	add     r7,r9,r3
   44:	83 e1 00 0c 	lwz     r31,12(r1)
   48:	7c 63 19 10 	subfe   r3,r3,r3
   4c:	38 21 00 10 	addi    r1,r1,16
   50:	7c 63 38 50 	subf    r3,r3,r7
   54:	7d 29 18 10 	subfc   r9,r9,r3
   58:	7d 2c 1a 14 	add     r9,r12,r3
   5c:	7c 63 19 10 	subfe   r3,r3,r3
   60:	7c 63 48 50 	subf    r3,r3,r9
   64:	7d 8c 18 10 	subfc   r12,r12,r3
   68:	7d 20 1a 14 	add     r9,r0,r3
   6c:	7c 63 19 10 	subfe   r3,r3,r3
   70:	7c 63 48 50 	subf    r3,r3,r9
   74:	7c 00 18 10 	subfc   r0,r0,r3
   78:	7d 2b 1a 14 	add     r9,r11,r3
   7c:	7c 63 19 10 	subfe   r3,r3,r3
   80:	7c 63 48 50 	subf    r3,r3,r9
   84:	7d 6b 18 10 	subfc   r11,r11,r3
   88:	7d 28 1a 14 	add     r9,r8,r3
   8c:	7c 63 19 10 	subfe   r3,r3,r3
   90:	7c 63 48 50 	subf    r3,r3,r9
   94:	7d 08 18 10 	subfc   r8,r8,r3
   98:	7d 2a 1a 14 	add     r9,r10,r3
   9c:	7c 63 19 10 	subfe   r3,r3,r3
   a0:	7c 63 48 50 	subf    r3,r3,r9
   a4:	7d 4a 18 10 	subfc   r10,r10,r3
   a8:	7d 23 2a 14 	add     r9,r3,r5
   ac:	7c 63 19 10 	subfe   r3,r3,r3
   b0:	7c 63 48 50 	subf    r3,r3,r9
   b4:	7c a5 18 10 	subfc   r5,r5,r3
   b8:	7c 63 32 14 	add     r3,r3,r6
   bc:	7d 29 49 10 	subfe   r9,r9,r9
   c0:	7d 29 18 50 	subf    r9,r9,r3
   c4:	7c c6 48 10 	subfc   r6,r6,r9
   c8:	7c 63 19 10 	subfe   r3,r3,r3
   cc:	7c 63 48 50 	subf    r3,r3,r9
   d0:	54 69 80 3e 	rotlwi  r9,r3,16
   d4:	7c 63 4a 14 	add     r3,r3,r9
   d8:	7c 63 18 f8 	not     r3,r3
   dc:	54 63 84 3e 	rlwinm  r3,r3,16,16,31
   e0:	4e 80 00 20 	blr

net/ipv6/ip6_checksum.o:     file format elf64-powerpc


Disassembly of section .text:

0000000000000000 <.csum_ipv6_magic>:
    0:	fb e1 ff f8 	std     r31,-8(r1)
    4:	81 43 00 00 	lwz     r10,0(r3)
    8:	81 83 00 04 	lwz     r12,4(r3)
    c:	81 23 00 08 	lwz     r9,8(r3)
   10:	80 03 00 0c 	lwz     r0,12(r3)
   14:	7c e7 52 14 	add     r7,r7,r10
   18:	80 64 00 08 	lwz     r3,8(r4)
   1c:	81 04 00 00 	lwz     r8,0(r4)
   20:	78 ff 00 20 	clrldi  r31,r7,32
   24:	7c ec 3a 14 	add     r7,r12,r7
   28:	81 64 00 04 	lwz     r11,4(r4)
   2c:	7f ea f8 50 	subf    r31,r10,r31
   30:	81 44 00 0c 	lwz     r10,12(r4)
   34:	7b ff 0f e0 	rldicl  r31,r31,1,63
   38:	7c ff 3a 14 	add     r7,r31,r7
   3c:	eb e1 ff f8 	ld      r31,-8(r1)
   40:	78 e4 00 20 	clrldi  r4,r7,32
   44:	7c e9 3a 14 	add     r7,r9,r7
   48:	7d 8c 20 50 	subf    r12,r12,r4
   4c:	79 8c 0f e0 	rldicl  r12,r12,1,63
   50:	7d 8c 3a 14 	add     r12,r12,r7
   54:	79 87 00 20 	clrldi  r7,r12,32
   58:	7d 80 62 14 	add     r12,r0,r12
   5c:	7d 29 38 50 	subf    r9,r9,r7
   60:	79 29 0f e0 	rldicl  r9,r9,1,63
   64:	7d 29 62 14 	add     r9,r9,r12
   68:	79 27 00 20 	clrldi  r7,r9,32
   6c:	7d 28 4a 14 	add     r9,r8,r9
   70:	7c 00 38 50 	subf    r0,r0,r7
   74:	78 00 0f e0 	rldicl  r0,r0,1,63
   78:	7c 00 4a 14 	add     r0,r0,r9
   7c:	78 09 00 20 	clrldi  r9,r0,32
   80:	7c 0b 02 14 	add     r0,r11,r0
   84:	7d 08 48 50 	subf    r8,r8,r9
   88:	79 08 0f e0 	rldicl  r8,r8,1,63
   8c:	7d 08 02 14 	add     r8,r8,r0
   90:	79 09 00 20 	clrldi  r9,r8,32
   94:	7d 03 42 14 	add     r8,r3,r8
   98:	7d 2b 48 50 	subf    r9,r11,r9
   9c:	79 29 0f e0 	rldicl  r9,r9,1,63
   a0:	7d 29 42 14 	add     r9,r9,r8
   a4:	79 28 00 20 	clrldi  r8,r9,32
   a8:	7d 2a 4a 14 	add     r9,r10,r9
   ac:	7d 03 40 50 	subf    r8,r3,r8
   b0:	79 08 0f e0 	rldicl  r8,r8,1,63
   b4:	7d 08 4a 14 	add     r8,r8,r9
   b8:	79 09 00 20 	clrldi  r9,r8,32
   bc:	7d 08 2a 14 	add     r8,r8,r5
   c0:	7d 2a 48 50 	subf    r9,r10,r9
   c4:	79 29 0f e0 	rldicl  r9,r9,1,63
   c8:	7d 29 42 14 	add     r9,r9,r8
   cc:	79 2a 00 20 	clrldi  r10,r9,32
   d0:	7d 29 32 14 	add     r9,r9,r6
   d4:	7c a5 50 50 	subf    r5,r5,r10
   d8:	78 a5 0f e0 	rldicl  r5,r5,1,63
   dc:	7d 25 4a 14 	add     r9,r5,r9
   e0:	79 2a 00 20 	clrldi  r10,r9,32
   e4:	7c c6 50 50 	subf    r6,r6,r10
   e8:	78 c6 0f e0 	rldicl  r6,r6,1,63
   ec:	7c c6 4a 14 	add     r6,r6,r9
   f0:	54 c3 80 3e 	rotlwi  r3,r6,16
   f4:	7c c6 1a 14 	add     r6,r6,r3
   f8:	7c c3 30 f8 	not     r3,r6
   fc:	78 63 84 22 	rldicl  r3,r3,48,48
  100:	4e 80 00 20 	blr

Christophe

>>
>>> --- a/arch/powerpc/lib/checksum_32.S
>>> +++ b/arch/powerpc/lib/checksum_32.S
>>> @@ -293,3 +293,36 @@ dst_error:
>>>       EX_TABLE(51b, dst_error);
>>>   EXPORT_SYMBOL(csum_partial_copy_generic)
>>> +
>>> +/*
>>> + * static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>>> + *                      const struct in6_addr *daddr,
>>> + *                      __u32 len, __u8 proto, __wsum sum)
>>> + */
>>> +
>>> +_GLOBAL(csum_ipv6_magic)
>>> +    lwz    r8, 0(r3)
>>> +    lwz    r9, 4(r3)
>>> +    lwz    r10, 8(r3)
>>> +    lwz    r11, 12(r3)
>>> +    addc    r0, r5, r6
>>> +    adde    r0, r0, r7
>>> +    adde    r0, r0, r8
>>> +    adde    r0, r0, r9
>>> +    adde    r0, r0, r10
>>> +    adde    r0, r0, r11
>>> +    lwz    r8, 0(r4)
>>> +    lwz    r9, 4(r4)
>>> +    lwz    r10, 8(r4)
>>> +    lwz    r11, 12(r4)
>>> +    adde    r0, r0, r8
>>> +    adde    r0, r0, r9
>>> +    adde    r0, r0, r10
>>> +    adde    r0, r0, r11
>>> +    addze    r0, r0
>>> +    rotlwi    r3, r0, 16
>>> +    add    r3, r0, r3
>>> +    not    r3, r3
>>> +    rlwinm    r3, r3, 16, 16, 31
>>> +    blr
>>> +EXPORT_SYMBOL(csum_ipv6_magic)
>>
>> Clustering the loads and carry insns together is pretty much the worst 
>> you
>> can do on most 32-bit CPUs.
> 
> Oh, really ? __csum_partial is written that way too.
> 
> Right, now I tried interleaving the lwz and adde. I get no improvment at 
> all on a 885, but I get a 15% improvment on a 8321.
> 
> Christophe
> 
>>
>>
>> Segher
>>
