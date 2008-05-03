Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 398A6DDEFA
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 10:07:02 +1000 (EST)
In-Reply-To: <20080502.163855.96423898.davem@davemloft.net>
References: <3B083683-CB6E-4F1D-87EF-BBFA7D491271@kernel.crashing.org>
	<20080502.144009.147804001.davem@davemloft.net>
	<1209770875.26383.14.camel@pasglop>
	<20080502.163855.96423898.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f35f5840a7aaee04c051ba6312a02ec3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Date: Sat, 3 May 2008 02:06:51 +0200
To: David Miller <davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> That is, it would be fairly non-sensical for module code to go through
>> the trampoline to call those stubs in the kernel (and having to
>> EXPORT_SYMBOL them).

You can link every module to libgcc separately.  Probably it can also
be set up so that some libgcc routines get linked into the kernel,
and exported, and the rest is linked into every module that wants
them.  We can also blacklist some symbols altogether (__udivdi3...)

> Oh, I forgot about how far function calls are done on powerpc.
> Yes, that will suck.
>
> Is there some way to map all of the modules in the low 32-bits and
> thus aovid the trampolines?  The powerpc call instruction can cover
> 4GB like on sparc right?

A direct call reaches +-32MB, either relative or absolute; an indirect
call can go anywhere.

> Actually, I remember there is some linkage register that has
> to be setup on powerpc with the code model you guys use, is
> that the problem?

I think the problem is just that the compiler generates "near" calls
(the 32MB thing) because of the code model used, but things don't
necessarily end up this close by at run time.


Segher
