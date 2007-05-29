Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D7755DE006
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 23:12:30 +1000 (EST)
In-Reply-To: <1180431850.19517.146.camel@localhost.localdomain>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>
	<1180425900.19517.136.camel@localhost.localdomain>
	<20070529092658.GA32228@iram.es>
	<1180431850.19517.146.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <710cb04ed3b82b11192cf54aa08c0230@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 15:12:24 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Steve Munroe <sjmunroe@us.ibm.com>,
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

>> - how can an application know that it can use 64 bit registers and 
>> call
>>   the optimized routines?
>
> I'd say use the 32 bits ABI, AT_HWCAP will tell you if you are running
> on a 64 bits capable machine. You can then either use hand tuned code 
> at
> runtime, or I think ld.so can load alternate libs based on the bits in
> there.

Or you can simply only install 64-bit binaries on 64-bit
machines.

>> Finally, I've not seen a compiler (well, GCC, but I don't have 4.2 or
>> 4.3 installed yet) that allows you to tell the compiler to use 32 bit
>> addresses but assume that integer registers are 64 bit wide. As long
>> as such an option does not exist, the usefulness of this feature is
>> somewhat limited. In other words, GCC for now has support for ILP32 
>> and
>> LP64 modes, but it would be better to also have support for IP32L64.
>
> Depends... If such binaries are actual 64 bits binaries from a kernel
> POV, then no change is necessary.

The kernel (and some libraries that do explicit mmap()s)
will have to make sure that all pointers stay within the
32-bit address space.  This is most easily done by only
allowing mappings in the low 32-bit, and some initial
memory layout work is needed I guess.  Seems quite easy
actually, certainly from the kernel perspective.  And the
gain is higher than that of -m32 -mpowerpc64 over -m32.

If you want to do the 32-bit ABI in 64-bit ELF binaries,
more work is involved.  Might very well be even better
though.


Segher
