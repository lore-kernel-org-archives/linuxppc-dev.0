Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1AD20DDEE5
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Dec 2006 13:30:25 +1100 (EST)
In-Reply-To: <Pine.LNX.4.60.0612272135470.13342@poirot.grange>
References: <Pine.LNX.4.60.0612252053410.3424@poirot.grange>
	<1167176934.3522.15.camel@localhost.localdomain>
	<Pine.LNX.4.60.0612272135470.13342@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f548f02517e8a0a9aeb09776946ec0c0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Chenging 2 bits in MSR in ppc6xx_idle() with 1 command?
Date: Thu, 28 Dec 2006 03:30:47 +0100
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Whereas MPC8245's user manual says, that when setting the MSR_POW 
>>> bit in
>>> the MSR one may not set any other bit in it with the same 
>>> instruction.
>>> Does this mean that the above does not actually work on those (and
>>> similar) CPUs or does it work because of the loop?
>>
>> That doc bit looks a bit strange. The kernel pretty much relies on
>> setting MSR:EE and MSR:POW atomicaly.
>
> Hm, wouldn't it just work? In ppc6xx_idle() the _TLF_NAPPING bit is 
> set.
> If as a result of mtmsr only the EE bit is set and we get an interrupt,

But what if only the POW flag gets set, and EE doesn't?
That's one CPU that won't wake up anymore :-/

It sounds like changing the sequence to first set EE, sync,
isync, and only then set POW as well will work safely on all
hardware?


Segher
