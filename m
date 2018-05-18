Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nPkf2Wy5zF29N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 20:37:29 +1000 (AEST)
Subject: Re: [PATCH v2 5/5] powerpc/lib: inline memcmp() for small constant
 sizes
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1526553552.git.christophe.leroy@c-s.fr>
 <8a6f90d882c8b60e5fa0826cd23dd70a92075659.1526553552.git.christophe.leroy@c-s.fr>
 <20180517135551.GT17342@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <7a2c3de9-4223-ec47-b3c0-1336c9cdbeee@c-s.fr>
Date: Fri, 18 May 2018 12:35:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180517135551.GT17342@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/17/2018 03:55 PM, Segher Boessenkool wrote:
> On Thu, May 17, 2018 at 12:49:58PM +0200, Christophe Leroy wrote:
>> In my 8xx configuration, I get 208 calls to memcmp()
>> Within those 208 calls, about half of them have constant sizes,
>> 46 have a size of 8, 17 have a size of 16, only a few have a
>> size over 16. Other fixed sizes are mostly 4, 6 and 10.
>>
>> This patch inlines calls to memcmp() when size
>> is constant and lower than or equal to 16
>>
>> In my 8xx configuration, this reduces the number of calls
>> to memcmp() from 208 to 123
>>
>> The following table shows the number of TB timeticks to perform
>> a constant size memcmp() before and after the patch depending on
>> the size
>>
>> 	Before	After	Improvement
>> 01:	 7577	 5682	25%
>> 02:	41668	 5682	86%
>> 03:	51137	13258	74%
>> 04:	45455	 5682	87%
>> 05:	58713	13258	77%
>> 06:	58712	13258	77%
>> 07:	68183	20834	70%
>> 08:	56819	15153	73%
>> 09:	70077	28411	60%
>> 10:	70077	28411	60%
>> 11:	79546	35986	55%
>> 12:	68182	28411	58%
>> 13:	81440	35986	55%
>> 14:	81440	39774	51%
>> 15:	94697	43562	54%
>> 16:	79546	37881	52%
> 
> Could you show results with a more recent GCC?  What version was this?

It was with the latest GCC version I have available in my environment, 
that is GCC 5.4. Is that too old ?

It seems that version inlines memcmp() when length is 1. All other 
lengths call memcmp()

> 
> What is this really measuring?  I doubt it takes 7577 (or 5682) timebase
> ticks to do a 1-byte memcmp, which is just 3 instructions after all.

Well I looked again in my tests and it seems some results are wrong, can 
remember why, I probably did something wrong when I did the tests.

Anyway, the principle is to call a function tstcmpX() 100000 times from 
a loop, and getting the mftb before and after the loop.
Then we remove from the elapsed time the time spent when calling 
tstcmp0() which is only a blr.
Therefore, we get really the time spent in the comparison only.

Here is the loop:

c06243b0:	7f ac 42 e6 	mftb    r29
c06243b4:	3f 60 00 01 	lis     r27,1
c06243b8:	63 7b 86 a0 	ori     r27,r27,34464
c06243bc:	38 a0 00 02 	li      r5,2
c06243c0:	7f c4 f3 78 	mr      r4,r30
c06243c4:	7f 83 e3 78 	mr      r3,r28
c06243c8:	4b 9e 8c 09 	bl      c000cfd0 <tstcmp2>
c06243cc:	2c 1b 00 01 	cmpwi   r27,1
c06243d0:	3b 7b ff ff 	addi    r27,r27,-1
c06243d4:	40 82 ff e8 	bne     c06243bc <setup_arch+0x294>
c06243d8:	7c ac 42 e6 	mftb    r5
c06243dc:	7c bd 28 50 	subf    r5,r29,r5
c06243e0:	7c bf 28 50 	subf    r5,r31,r5
c06243e4:	38 80 00 02 	li      r4,2
c06243e8:	7f 43 d3 78 	mr      r3,r26
c06243ec:	4b a2 e4 45 	bl      c0052830 <printk>

Before the patch:
c000cfc4 <tstcmp0>:
c000cfc4:	4e 80 00 20 	blr

c000cfc8 <tstcmp1>:
c000cfc8:	38 a0 00 01 	li      r5,1
c000cfcc:	48 00 72 08 	b       c00141d4 <__memcmp>

c000cfd0 <tstcmp2>:
c000cfd0:	38 a0 00 02 	li      r5,2
c000cfd4:	48 00 72 00 	b       c00141d4 <__memcmp>

c000cfd8 <tstcmp3>:
c000cfd8:	38 a0 00 03 	li      r5,3
c000cfdc:	48 00 71 f8 	b       c00141d4 <__memcmp>

After the patch:
c000cfc4 <tstcmp0>:
c000cfc4:	4e 80 00 20 	blr

c000cfd8 <tstcmp1>:
c000cfd8:	88 64 00 00 	lbz     r3,0(r4)
c000cfdc:	89 25 00 00 	lbz     r9,0(r5)
c000cfe0:	7c 69 18 50 	subf    r3,r9,r3
c000cfe4:	4e 80 00 20 	blr

c000cfe8 <tstcmp2>:
c000cfe8:	a0 64 00 00 	lhz     r3,0(r4)
c000cfec:	a1 25 00 00 	lhz     r9,0(r5)
c000cff0:	7c 69 18 50 	subf    r3,r9,r3
c000cff4:	4e 80 00 20 	blr

c000cff8 <tstcmp3>:
c000cff8:	a1 24 00 00 	lhz     r9,0(r4)
c000cffc:	a0 65 00 00 	lhz     r3,0(r5)
c000d000:	7c 63 48 51 	subf.   r3,r3,r9
c000d004:	4c 82 00 20 	bnelr
c000d008:	88 64 00 02 	lbz     r3,2(r4)
c000d00c:	89 25 00 02 	lbz     r9,2(r5)
c000d010:	7c 69 18 50 	subf    r3,r9,r3
c000d014:	4e 80 00 20 	blr

c000d018 <tstcmp4>:
c000d018:	80 64 00 00 	lwz     r3,0(r4)
c000d01c:	81 25 00 00 	lwz     r9,0(r5)
c000d020:	7c 69 18 50 	subf    r3,r9,r3
c000d024:	4e 80 00 20 	blr

c000d028 <tstcmp5>:
c000d028:	81 24 00 00 	lwz     r9,0(r4)
c000d02c:	80 65 00 00 	lwz     r3,0(r5)
c000d030:	7c 63 48 51 	subf.   r3,r3,r9
c000d034:	4c 82 00 20 	bnelr
c000d038:	88 64 00 04 	lbz     r3,4(r4)
c000d03c:	89 25 00 04 	lbz     r9,4(r5)
c000d040:	7c 69 18 50 	subf    r3,r9,r3
c000d044:	4e 80 00 20 	blr

c000d048 <tstcmp6>:
c000d048:	81 24 00 00 	lwz     r9,0(r4)
c000d04c:	80 65 00 00 	lwz     r3,0(r5)
c000d050:	7c 63 48 51 	subf.   r3,r3,r9
c000d054:	4c 82 00 20 	bnelr
c000d058:	a0 64 00 04 	lhz     r3,4(r4)
c000d05c:	a1 25 00 04 	lhz     r9,4(r5)
c000d060:	7c 69 18 50 	subf    r3,r9,r3
c000d064:	4e 80 00 20 	blr

c000d068 <tstcmp7>:
c000d068:	81 24 00 00 	lwz     r9,0(r4)
c000d06c:	80 65 00 00 	lwz     r3,0(r5)
c000d070:	7d 23 48 51 	subf.   r9,r3,r9
c000d074:	40 82 00 20 	bne     c000d094 <tstcmp7+0x2c>
c000d078:	a0 64 00 04 	lhz     r3,4(r4)
c000d07c:	a1 25 00 04 	lhz     r9,4(r5)
c000d080:	7d 29 18 51 	subf.   r9,r9,r3
c000d084:	40 82 00 10 	bne     c000d094 <tstcmp7+0x2c>
c000d088:	88 64 00 06 	lbz     r3,6(r4)
c000d08c:	89 25 00 06 	lbz     r9,6(r5)
c000d090:	7d 29 18 50 	subf    r9,r9,r3
c000d094:	7d 23 4b 78 	mr      r3,r9
c000d098:	4e 80 00 20 	blr

c000d09c <tstcmp8>:
c000d09c:	81 25 00 04 	lwz     r9,4(r5)
c000d0a0:	80 64 00 04 	lwz     r3,4(r4)
c000d0a4:	81 04 00 00 	lwz     r8,0(r4)
c000d0a8:	81 45 00 00 	lwz     r10,0(r5)
c000d0ac:	7c 69 18 10 	subfc   r3,r9,r3
c000d0b0:	7d 2a 41 10 	subfe   r9,r10,r8
c000d0b4:	7d 2a fe 70 	srawi   r10,r9,31
c000d0b8:	7d 48 4b 79 	or.     r8,r10,r9
c000d0bc:	4d a2 00 20 	bclr+   12,eq
c000d0c0:	7d 23 4b 78 	mr      r3,r9
c000d0c4:	4e 80 00 20 	blr

c000d0c8 <tstcmp9>:
c000d0c8:	81 25 00 04 	lwz     r9,4(r5)
c000d0cc:	80 64 00 04 	lwz     r3,4(r4)
c000d0d0:	81 04 00 00 	lwz     r8,0(r4)
c000d0d4:	81 45 00 00 	lwz     r10,0(r5)
c000d0d8:	7c 69 18 10 	subfc   r3,r9,r3
c000d0dc:	7d 2a 41 10 	subfe   r9,r10,r8
c000d0e0:	7d 2a fe 70 	srawi   r10,r9,31
c000d0e4:	7d 48 4b 79 	or.     r8,r10,r9
c000d0e8:	41 82 00 08 	beq     c000d0f0 <tstcmp9+0x28>
c000d0ec:	7d 23 4b 78 	mr      r3,r9
c000d0f0:	2f 83 00 00 	cmpwi   cr7,r3,0
c000d0f4:	4c 9e 00 20 	bnelr   cr7
c000d0f8:	88 64 00 08 	lbz     r3,8(r4)
c000d0fc:	89 25 00 08 	lbz     r9,8(r5)
c000d100:	7c 69 18 50 	subf    r3,r9,r3
c000d104:	4e 80 00 20 	blr

This shows that on PPC32, the 8 bytes comparison is not optimal, I will 
improve it.

We also see in tstcmp7() that GCC is a bit stupid, it should use r3 as 
result of the sub as he does with all previous ones, then do bnelr 
instead of bne+mr+blr

Below are the results of the measurement redone today:

     Before After  Improvment
01  24621   5681  77%
02  24621   5681  77%
03  34091  13257  61%
04  28409   5681  80%
05  41667  13257  68%
06  41668  13257  68%
07  51138  22727  56%
08  39772  15151  62%
09  53031  28409  46%
10  53031  28409  46%
11  62501  35986  42%
12  51137  28410  44%
13  64395  35985  44%
14  68182  39774  42%
15  73865  43560  41%
16  62500  37879  39%

We also see here that 08 is not optimal, it should have given same 
results as 05 and 06. I will keep it as is for PPC64 but will rewrite it 
as two 04 comparisons for PPC32

Christophe



> 
> 
> Segher
> 
