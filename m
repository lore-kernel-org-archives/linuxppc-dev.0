Return-Path: <vbuzov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 90368DDF73
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 20:41:09 +1000 (EST)
Message-ID: <4684E1C2.5060409@ru.mvista.com>
Date: Fri, 29 Jun 2007 14:41:06 +0400
From: Vladislav Buzov <vbuzov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<468010C0.20701@ru.mvista.com>
	<20928a2e8680e3d9214f1eb24ea87abd@kernel.crashing.org>
In-Reply-To: <20928a2e8680e3d9214f1eb24ea87abd@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

>>>> First, I'm looking for a help and advice why the current _set_L2CR()
>>>> implementation may not work for MPC7450 (namely 7448 with 1Mb L2 cache
>>>> installed). Is it a bug in _set_L2CR()  or a hardware problem.
>>>
>>>
>>> I think that if anyone here could answer this straight
>>> away, the source code would have been fixed already ;-)
>>
>>
>> I think I can try to answer this question. Please, look through my 
>> thoughts below and correct me if I'm somewhere wrong.
>
>
> You forgot step 0: the goal of flushing the caches here
> is to make sure there is no data at all in there after it
> has finished.
>
>> The current scheme of flushing the caches is based on a number of 
>> consecutive lwz/dcbf instructions. A contiguous memory region 
>> (started from zero) is read by series of lwz commands and then cache 
>> is flushed using a sequence of dcbf instructions with addresses from 
>> this memory range. If I understand correctly, to get this approach 
>> working it is required to guarantee that after reading the memory 
>> region, each line in a cache should be used and keep data from this 
>> region. Otherwise, if some cache lines keep data from another address 
>> range they will not be flushed by the dcbf instructions sequence.
>
>
> Yes, you need to ensure there is nothing interfering (SMP
> agents, DMA agents, prefetch engines...), and you need to
> know the line replacement policy, to make this work;
> furthermore, you need to be quite careful in your code to
> make sure the intended L2 stores are the _only_ L2 traffic
> you generate.
>
>> Further, how cache lines are utilized is dictated by a cache lines 
>> replacement policy. I didn't go in to details deeply, but on MPC7450 
>> L1 cache lines replacement policy seems to  satisfy the requirement 
>> above. At least the MPC7450 reference manual describes L1 cache 
>> flushing algorithm based on a sequence of lwz/dcbf instructions.
>>
>> But regarding to L2/L3 caches, the manual describes two different 
>> cache line replacement policies. And the both are pseudo-random
>
>
> At least on is the "standard" PowerPC pseudo-LRU tree, no?
> That one flushes fine using this strategy.

The PLRU is implemented in the the L1 cache only, And yes, it does allow 
to flush the cache using the lwz/dcbf sequence.

The L2/L3 caches use two different pseudo-random number generators based 
on CPU clocks. The first one is just 3-bit modulo 8 counter incremented 
on every clock cycle. On each cache miss it is used to choice a cache 
line in a set. The second is more complicated and consists of 16 latches 
clocked on every clock cycle with 3 XOR functions. And L2/L3 take 
"random" numbers from 3 latches of 16.

>
>> and differ by implementation of random number generator. It means 
>> that a cache line in a set is chosen randomly, and that, in turn, 
>> means that there is a probability that some cache lines are not used 
>> during reading of the contiguous memory region and not flushed by the 
>> dcbf instruction sequence.
>
>
> Knowing that there is no "outside" interference, and knowing
> the "random" algorithm, can give plenty guarantees.

Agree. In case of cache flushing there is no interference and all the 
instructions use known numbers of clock cycles, so it is possible (at 
least in theory) to predict all the "random" numbers and to say whether 
all the cache lines will be used or not in each particular case.  But 
the nature of the algorithms does not guarantee the preferable result in 
general.

>
>> For example, on MPC7448 there is a eight-way set-associative 1Mb L2 
>> cache that consist of 2048 sets x 8 ways per set. And even if a set N 
>> has been accessed M times (M > 8) there is a chance that some cache 
>> line is set N has never been used, but another line has been used 
>> twice or more. Of course, the probability of such situation decreases 
>> with increasing of N.
>
Opps, misprint.. I meant M in last sentence :-)

Thank you,
Vlad.

>
> You can make sure, too.  Just trying to statistically get
> to the point where you are sure the whole cache is flushed
> is not going to work *at all*, you need to use deeper knowledge
> of how the cache works.
>
>> Current _set_L2CR() implementation reads first 4Mb of memory to flush 
>> the L2 cache. I have increased this size up to 16 Mb and now things 
>> work fine. But I don't think that is a right way to fix the problem 
>> because there is no any way to define the upper limit of memory size 
>> to guarantee flushing of each cache line. 16Mb is too large though. 
>> It seems more reasonable to use a stable and guaranteed way to flush 
>> the cache implemented in hardware.
>
>
> Yes, use the hardware flush mechanism.  Please :-)
>
> [I think the erratum is about insn fetches to L2 that you
> have no way too stop.  <handwaving>Something like that,
> anyway.</handwaving>]
>
>
> Segher
>
