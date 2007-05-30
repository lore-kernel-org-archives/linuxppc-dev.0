Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4767ADDF93
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:55:03 +1000 (EST)
In-Reply-To: <465C9F04.4070202@elitedvb.net>
References: <1180423456.19517.124.camel@localhost.localdomain>	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>	<1180425900.19517.136.camel@localhost.localdomain>	<20070529092658.GA32228@iram.es>	<08b3997ab86a819c63b5cb0afcdc0c9e@kernel.crashing.org>
	<1180474079.19517.188.camel@localhost.localdomain>
	<465C9F04.4070202@elitedvb.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6468abfee21ce75c5d86676350b09c88@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Wed, 30 May 2007 13:54:52 +0200
To: Felix Domke <tmbinc@elitedvb.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Just call them and trap the SEGV ;-)  You can check the
>>> aux vector of course, or ask glibc -- but the SEGV way
>>> is the only really portable way.  Strange world :-)
>> SIGILL you mean ? :-)
> Anyway, please don't. It is *not* portable.

It is simple and *quite* portable.  "Real" applications
of course should just ask the C library about this,
somewhere deep inside a maze of #ifdefs for all the OSes
supported.  A job for autoxxxx I guess.

> Or can you guarantee that no CPU ever will implement a.) only a 64bit
> subset or b.) other instructions using the same encoding as the 64bit
> insn you will use for testing?

I don't understand a); and no CPU _should_ do b), but we
all know that bad things happen sometimes.

> I still remember the pain of trying to tell that ffmpeg that my CPU
> can't do real altivec, even when it implements some parts of it without
> SIGILLing (which ffmpeg used for testing).

To be fair, ffmpeg has had this test since before there
were proper ways to detect AltiVec on Linux/glibc.

> And: What will happen if you manage to run your code under an operating
> system which doesn't even save the upper bits at all on interrupts? You
> can't check for that with SIGILL.

Sure you can, do some loop with a data-dependent branch
in there that detects corruption of that high half reg.
If you really want a SIGILL you can just generate one ;-)
A test like this is never 100% of course.

> And i'd still like to see some decent ILP32LL64 support.

GCC has supported this for a long time now, it seems the
last few pieces needed from the kernel and userland support
are falling into place now.  Hurray!

>  Maybe even with
> a new "native 64bit" datatype (how ugly), in order to not break the 
> ABI.
> I just want to call my hand-optimized 64bit assembler code with 64bit
> arguments.
> How does OS X handle this? Don't they have the same problem there?

AFAIK Darwin saves full 64-bit GPRs on a 64-bit CPU always.

An application can ask for 64-bit signal frames by giving
the SA_64REGSET flag in sa_flags to sigaction().


Segher
