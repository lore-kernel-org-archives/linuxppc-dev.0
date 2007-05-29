Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B407FDE086
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:29:01 +1000 (EST)
In-Reply-To: <OF23D1348F.B2E0AE28-ON862572EA.004C17B2-862572EA.004CF843@us.ibm.com>
References: <OF23D1348F.B2E0AE28-ON862572EA.004C17B2-862572EA.004CF843@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <afb950fb0cf97eaf574535bc1fb7a8a7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 16:28:44 +0200
To: Steve Munroe <sjmunroe@us.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> - how can an application know that it can use 64 bit registers and
>>>> call
>>>>   the optimized routines?
>>>
>>> I'd say use the 32 bits ABI, AT_HWCAP will tell you if you are 
>>> running
>>> on a 64 bits capable machine. You can then either use hand tuned code
>>> at
>>> runtime, or I think ld.so can load alternate libs based on the bits 
>>> in
>>> there.
>>
>> Or you can simply only install 64-bit binaries on 64-bit
>> machines.
>>
> Yes exactly why make an incompatible ABI change to the powerp32 ABI, 
> when
> you can just use the existing 64-bit ABI.

I meant programs using 64-bit insns while running in the
32-bit personality when I said "64-bit binaries".  No ABI
change is necessary, except very few applications might
want to look at saved registers.

Plain 64-bit programs using 32 bits of address space only
is a much nicer idea indeed.  And it doesn't even need
an ABI change!  Just a new kernel personality (or an ELF
header flag or whatever).

> Especially as you can only run what is proposed on 64-bit hardware!
>
> We don't need another ABI change to powerpc32 (still recovering from 
> the
> -msecure-plt ABI change) and WE DONT NEED a 3rd ABI.
>
> ABI changes ripple everywhere (not just GCC/GLIBC) including all 
> debuggers
> and performance tools. Believe me you really don't want this.

I've had to deal with exactly this on Darwin before, and
although that was as a simple user only, I can confirm:
I really do not want it.  Unless it magically would be
100% stable at once of course :-)


Segher
