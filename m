Return-Path: <vbuzov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id ACAB8DDF12
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 03:12:14 +1000 (EST)
Message-ID: <467176EB.7060404@ru.mvista.com>
Date: Thu, 14 Jun 2007 21:12:11 +0400
From: Vladislav Buzov <vbuzov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
In-Reply-To: <db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
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


This is a errata for 7448 only. I've looked through errata for other 
7450 processors (7450, 7457) and they contain the same erratum for L2 
cache: "L2 hardware flush may not flush every line from the L2 cache" 
The workaround for this problem is: "Set the IONLY and DONLY bits in the 
L2CR prior to the L2 hardware flush", and the projected solution is: 
"The workaround has been documented in the MPC7450 RISC Microprocessor 
Family User’s Manual as the correct way to flush the L2 cache"

I have tried to apply the same workaround for a common 
non-hardware-assistant _set_L2CR() implementation. I tried to completely 
lock the cache before a whole flushing procedure, tried to set the L2DO 
before filling the cache, fill it and then set the L2IO and issue a 
number of dcbf's. But nothing helped.

>
>> First, I'm looking for a help and advice why the current _set_L2CR()
>> implementation may not work for MPC7450 (namely 7448 with 1Mb L2 cache
>> installed). Is it a bug in _set_L2CR()  or a hardware problem.
>
>
> I think that if anyone here could answer this straight
> away, the source code would have been fixed already ;-)

Yeah, I guess I'm a first person who encountered this problem.

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

I've double checked this. All processors considered 7450 in the kernel 
are covered by MPC7450 RISC Microprocessor Family Reference Manual where 
hardware cache flushing procedure is described.

>
>>      /* TODO: use HW flush assist when available */
>
>
> You want to get rid of this old comment though -- and
> perhaps branch over the non-hardware-assisted cache
> flushing code.

Ok, I agree that the comment is obsolete now. Would you please explain 
why the branch over non-hardware-assisted code should be removed as 
well. Technically the cache is flushed and there is no need to use extra 
commands to fill and then re-flush the cache.

Thank you,
Vlad.

>
>
> Segher
>
