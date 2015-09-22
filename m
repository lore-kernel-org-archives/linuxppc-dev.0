Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 409081A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 06:57:53 +1000 (AEST)
Subject: Re: [PATCH v2 22/25] powerpc32: move xxxxx_dcache_range() functions
 inline
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
 "scottwood@freescale.com" <scottwood@freescale.com>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <c1c88096cb3f6ee71048dbab44ffb9ac260b07a3.1442939410.git.christophe.leroy@c-s.fr>
 <1442945547.29498.50.camel@transmode.se>
 <1442948339.19102.270.camel@freescale.com>
 <1442950473.29498.54.camel@transmode.se>
 <1442950926.19102.280.camel@freescale.com>
 <1442951752.29498.58.camel@transmode.se>
 <1442952852.19102.281.camel@freescale.com>
 <1442953971.29498.76.camel@transmode.se>
 <1442954101.19102.286.camel@freescale.com>
 <1442954285.29498.79.camel@transmode.se>
Cc: "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5601C0CC.6090503@c-s.fr>
Date: Tue, 22 Sep 2015 22:57:48 +0200
MIME-Version: 1.0
In-Reply-To: <1442954285.29498.79.camel@transmode.se>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/09/2015 22:38, Joakim Tjernlund a écrit :
> On Tue, 2015-09-22 at 15:35 -0500, Scott Wood wrote:
>> On Tue, 2015-09-22 at 20:32 +0000, Joakim Tjernlund wrote:
>>> On Tue, 2015-09-22 at 15:14 -0500, Scott Wood wrote:
>>>> On Tue, 2015-09-22 at 19:55 +0000, Joakim Tjernlund wrote:
>>>>> On Tue, 2015-09-22 at 14:42 -0500, Scott Wood wrote:
>>>>>> On Tue, 2015-09-22 at 19:34 +0000, Joakim Tjernlund wrote:
>>>>>>> On Tue, 2015-09-22 at 13:58 -0500, Scott Wood wrote:
>>>>>>>> On Tue, 2015-09-22 at 18:12 +0000, Joakim Tjernlund wrote:
>>>>>>>>> On Tue, 2015-09-22 at 18:51 +0200, Christophe Leroy wrote:
>>>>>>>>>> flush/clean/invalidate _dcache_range() functions are all very
>>>>>>>>>> similar and are quite short. They are mainly used in
>>>>>>>>>> __dma_sync()
>>>>>>>>>> perf_event locate them in the top 3 consumming functions
>>>>>>>>>> during
>>>>>>>>>> heavy ethernet activity
>>>>>>>>>>
>>>>>>>>>> They are good candidate for inlining, as __dma_sync() does
>>>>>>>>>> almost nothing but calling them
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>>>>>>> ---
>>>>>>>>>> New in v2
>>>>>>>>>>
>>>>>>>>>>   arch/powerpc/include/asm/cacheflush.h | 55
>>>>>>>>>> +++++++++++++++++++++++++++--
>>>>>>>>>>   arch/powerpc/kernel/misc_32.S         | 65 ------------------
>>>>>>>>>> ----
>>>>>>>>>> ----
>>>>>>>>>> ----
>>>>>>>>>> -----
>>>>>>>>>>   arch/powerpc/kernel/ppc_ksyms.c       |  2 ++
>>>>>>>>>>   3 files changed, 54 insertions(+), 68 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/powerpc/include/asm/cacheflush.h
>>>>>>>>>> b/arch/powerpc/include/asm/cacheflush.h
>>>>>>>>>> index 6229e6b..6169604 100644
>>>>>>>>>> --- a/arch/powerpc/include/asm/cacheflush.h
>>>>>>>>>> +++ b/arch/powerpc/include/asm/cacheflush.h
>>>>>>>>>> @@ -47,12 +47,61 @@ static inline void
>>>>>>>>>> __flush_dcache_icache_phys(unsigned long physaddr)
>>>>>>>>>>   }
>>>>>>>>>>   #endif
>>>>>>>>>>   
>>>>>>>>>> -extern void flush_dcache_range(unsigned long start, unsigned
>>>>>>>>>> long
>>>>>>>>>> stop);
>>>>>>>>>>   #ifdef CONFIG_PPC32
>>>>>>>>>> -extern void clean_dcache_range(unsigned long start, unsigned
>>>>>>>>>> long
>>>>>>>>>> stop);
>>>>>>>>>> -extern void invalidate_dcache_range(unsigned long start,
>>>>>>>>>> unsigned
>>>>>>>>>> long
>>>>>>>>>> stop);
>>>>>>>>>> +/*
>>>>>>>>>> + * Write any modified data cache blocks out to memory and
>>>>>>>>>> invalidate
>>>>>>>>>> them.
>>>>>>>>>> + * Does not invalidate the corresponding instruction cache
>>>>>>>>>> blocks.
>>>>>>>>>> + */
>>>>>>>>>> +static inline void flush_dcache_range(unsigned long start,
>>>>>>>>>> unsigned
>>>>>>>>>> long
>>>>>>>>>> stop)
>>>>>>>>>> +{
>>>>>>>>>> +   void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
>>>>>>>>>> +   unsigned int size = stop - (unsigned long)addr +
>>>>>>>>>> (L1_CACHE_BYTES -
>>>>>>>>>> 1);
>>>>>>>>>> +   unsigned int i;
>>>>>>>>>> +
>>>>>>>>>> +   for (i = 0; i < size >> L1_CACHE_SHIFT; i++, addr +=
>>>>>>>>>> L1_CACHE_BYTES)
>>>>>>>>>> +           dcbf(addr);
>>>>>>>>>> +   if (i)
>>>>>>>>>> +           mb();   /* sync */
>>>>>>>>>> +}
>>>>>>>>> This feels optimized for the uncommon case when there is no
>>>>>>>>> invalidation.
>>>>>>>> If you mean the "if (i)", yes, that looks odd.
>>>>>>> Yes.
>>>>>>>
>>>>>>>>> I THINK it would be better to bail early
>>>>>>>> Bail under what conditions?
>>>>>>> test for "i = 0" and return.
>>>>>> Why bother?
>>>>> I usally find it better to dela with special cases upfront så the rest
>>>>> doesn't need to
>>>>> bother. i=0 is a NOP and it is clearer to show that upfront.
>>>> No, I mean why bother special casing this at all?
>>> I just said why?
>>> You to found the if(i) mb() a bit odd and it took a little time to see why
>>> it was there.
>>> Ahh, you mean just skip the if(i) and have mb() unconditionally?
>> Yes.
>>
>>> That changes the semantics a little from the ASM version but perhaps that
>>> doesn't matter?
>> Adding more barriers than strictly necessary is a performance concern, not a
>> semantic change.
> Semantics :)
>
>>    How often are we really calling this function over an empty
>> range?
> Never hopefully, it does not make much sense.
>
>> Not that it matters much one way or another...
> probably not.
>

Here is what I get in asm. First one is with "if (i) mb();". We see gcc 
puts a beqlr. This is the form that is closest to what we had in the 
former misc_32.S
Second one if with "mb()". Here we get a branch to sync for a useless sync

c000e0ac <my_flush_dcache_range1>:
c000e0ac:       54 63 00 36     rlwinm  r3,r3,0,0,27
c000e0b0:       38 84 00 0f     addi    r4,r4,15
c000e0b4:       7d 23 20 50     subf    r9,r3,r4
c000e0b8:       55 29 e1 3f     rlwinm. r9,r9,28,4,31
c000e0bc:       4d 82 00 20     beqlr
c000e0c0:       7d 29 03 a6     mtctr   r9
c000e0c4:       7c 00 18 6c     dcbst   0,r3
c000e0c8:       38 63 00 10     addi    r3,r3,16
c000e0cc:       42 00 ff f8     bdnz    c000e0c4 
<my_flush_dcache_range1+0x18>
c000e0d0:       7c 00 04 ac     sync
c000e0d4:       4e 80 00 20     blr

c000e0d8 <my_flush_dcache_range2>:
c000e0d8:       54 63 00 36     rlwinm  r3,r3,0,0,27
c000e0dc:       38 84 00 0f     addi    r4,r4,15
c000e0e0:       7d 23 20 50     subf    r9,r3,r4
c000e0e4:       55 29 e1 3f     rlwinm. r9,r9,28,4,31
c000e0e8:       41 82 00 14     beq     c000e0fc 
<my_flush_dcache_range2+0x24>
c000e0ec:       7d 29 03 a6     mtctr   r9
c000e0f0:       7c 00 18 6c     dcbst   0,r3
c000e0f4:       38 63 00 10     addi    r3,r3,16
c000e0f8:       42 00 ff f8     bdnz    c000e0f0 
<my_flush_dcache_range2+0x18>
c000e0fc:       7c 00 04 ac     sync
c000e100:       4e 80 00 20     blr

Christophe
