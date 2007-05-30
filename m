Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF85CDDFD0
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:24:00 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix Domke <tmbinc@elitedvb.net>
In-Reply-To: <465C9F04.4070202@elitedvb.net>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>
	<1180425900.19517.136.camel@localhost.localdomain>
	<20070529092658.GA32228@iram.es>
	<08b3997ab86a819c63b5cb0afcdc0c9e@kernel.crashing.org>
	<1180474079.19517.188.camel@localhost.localdomain>
	<465C9F04.4070202@elitedvb.net>
Content-Type: text/plain
Date: Wed, 30 May 2007 21:23:47 +1000
Message-Id: <1180524227.19517.256.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Anyway, please don't. It is *not* portable.

What are you talking about ? Really, I mean, I'm not sure I understand
what you mean :-)

> Or can you guarantee that no CPU ever will implement a.) only a 64bit
> subset or b.) other instructions using the same encoding as the 64bit
> insn you will use for testing?

Well, the idea is that we do expose via AT_HWCAP that the ppc64 insn set
is supported. I reckon we might just strip that bit for 32 bits
processes if they can't do 64 bits insn, no need to even get another
one.

> I still remember the pain of trying to tell that ffmpeg that my CPU
> can't do real altivec, even when it implements some parts of it without
> SIGILLing (which ffmpeg used for testing).

Yeah well, ffmpeg is crap, news at 11... there are ways to test wether
you have altivec or not (and more than one) but it looks like most
ffmpeg packages around don't care.

> And: What will happen if you manage to run your code under an operating
> system which doesn't even save the upper bits at all on interrupts? You
> can't check for that with SIGILL.

What are you talking about ? (bis) :-)

> Having a decent way (like aux/glibc) would also solve the problem with
> "incompatible CPUs", which you mentioned.

Ugh ?

Ben.
