Return-Path: <vbuzov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 82C15DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 05:00:19 +1000 (EST)
Message-ID: <468010C0.20701@ru.mvista.com>
Date: Mon, 25 Jun 2007 23:00:16 +0400
From: Vladislav Buzov <vbuzov@ru.mvista.com>
MIME-Version: 1.0
To: segher@kernel.crashing.org
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
In-Reply-To: <db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
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

>> I read the MPC7450 reference manual and it describes a method to flush
>> the cache using L2 hardware flushing feature. The cache flushing
>> procedure consist of several steps and some of them are dictated by
>> MPC7448 errata (www.freescale.com/files/32bit/doc/errata/MPC7448CE.pdf,
>> Erratum no.3).
>
>
> Are these errata 7448-only?  If not, I wonder what is
> done on PowerMacs?
>
>> First, I'm looking for a help and advice why the current _set_L2CR()
>> implementation may not work for MPC7450 (namely 7448 with 1Mb L2 cache
>> installed). Is it a bug in _set_L2CR()  or a hardware problem.
>
>
> I think that if anyone here could answer this straight
> away, the source code would have been fixed already ;-)

I think I can try to answer this question. Please, look through my 
thoughts below and correct me if I'm somewhere wrong.

The current scheme of flushing the caches is based on a number of 
consecutive lwz/dcbf instructions. A contiguous memory region (started 
from zero) is read by series of lwz commands and then cache is flushed 
using a sequence of dcbf instructions with addresses from this memory 
range. If I understand correctly, to get this approach working it is 
required to guarantee that after reading the memory region, each line in 
a cache should be used and keep data from this region. Otherwise, if 
some cache lines keep data from another address range they will not be 
flushed by the dcbf instructions sequence.

Further, how cache lines are utilized is dictated by a cache lines 
replacement policy. I didn't go in to details deeply, but on MPC7450 L1 
cache lines replacement policy seems to  satisfy the requirement above. 
At least the MPC7450 reference manual describes L1 cache flushing 
algorithm based on a sequence of lwz/dcbf instructions.

But regarding to L2/L3 caches, the manual describes two different cache 
line replacement policies. And the both are pseudo-random and differ by 
implementation of random number generator. It means that a cache line in 
a set is chosen randomly, and that, in turn, means that there is a 
probability that some cache lines are not used during reading of the 
contiguous memory region and not flushed by the dcbf instruction sequence.

For example, on MPC7448 there is a eight-way set-associative 1Mb L2 
cache that consist of 2048 sets x 8 ways per set. And even if a set N 
has been accessed M times (M > 8) there is a chance that some cache line 
is set N has never been used, but another line has been used twice or 
more. Of course, the probability of such situation decreases with 
increasing of N.

Current _set_L2CR() implementation reads first 4Mb of memory to flush 
the L2 cache. I have increased this size up to 16 Mb and now things work 
fine. But I don't think that is a right way to fix the problem because 
there is no any way to define the upper limit of memory size to 
guarantee flushing of each cache line. 16Mb is too large though. It 
seems more reasonable to use a stable and guaranteed way to flush the 
cache implemented in hardware.

Vlad.

>
>> I've
>> mentioned above about MPC7450 hardware bug in L2 hardware flushing
>> mechanism. May it be applicable to common cache flushing procedure based
>> on sequence of lwz/dcbf instructions?
>
>
> Dunno, too lazy to download that PDF, perhaps you can
> quote the relevant part?
>
>> Second, Is this patch acceptable?
>
>
> Looks reasonable enough to me...  if it works (on all
> things considered "7450" by the kernel).
>
>>      /* TODO: use HW flush assist when available */
>
>
> You want to get rid of this old comment though -- and
> perhaps branch over the non-hardware-assisted cache
> flushing code.
>
>
> Segher
>
