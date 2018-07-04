Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LN010cSLzF0ZD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 23:59:28 +1000 (AEST)
Subject: Re: How is this possible - Register r30 contains 0xc2236400 instead
 of 0xc6236400
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <09ae0460-11e7-c893-5a5f-55e55a3ef372@c-s.fr>
 <87k1qbkuw0.fsf@concordia.ellerman.id.au>
 <20180704134515.GI16221@gate.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <35b51701-4869-d729-8c0f-752b461d1d22@c-s.fr>
Date: Wed, 4 Jul 2018 15:59:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180704134515.GI16221@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/07/2018 à 15:45, Segher Boessenkool a écrit :
> On Wed, Jul 04, 2018 at 11:11:59PM +1000, Michael Ellerman wrote:
>> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>>
>>> Kernel Oops at 0xc0334d5c for reading at address 0xc2236450 which
>>> corresponds to r30 + 80
>>>
>>> But r30 should contain what's at r3 + 16 that is at 0xc619ec10 so r30
>>> should be c6236400 as shown below (print_hex_dump(regs->gpr[3]) added at
>>> end of __die() )
>>>
>>> So how can r30 contain 0xc2236400 instead ?
>>
>> The simplest answer is that memory was modified between the time we
>> loaded it into r30 and when you print it.
>>
>> So it did contain 0xc2236400 but has since been modified to now contain
>> 0xc6236400.
>>
>> The thing that makes me less certain, is that c6 would be the correct
>> value (I think?), so it's been modified back to the correct value, which
>> seems lucky.
>>
>> Mysterious.
> 
> That depends.  Is this reproducible at all?  It is a single bit flip.

Yes it is reproductible.

It isn't reproduced if I modify the function in such a way that there is 
an additional (unrelated) instruction before that read.

It isn't reproduced if I move the kernel base address to 0xd0000000 or 
0xb0000000 instead of 0xc0000000

If I force a second read of this address in the function, I get the same 
value (in another register).

If I add a dcbi before the second read I get the correct address.

So it still looks mysterious to me ...

Christophe

> 
> 
> Segher
> 
