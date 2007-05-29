Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76243DDF58
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 19:44:35 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20070529092658.GA32228@iram.es>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>
	<1180425900.19517.136.camel@localhost.localdomain>
	<20070529092658.GA32228@iram.es>
Content-Type: text/plain
Date: Tue, 29 May 2007 19:44:10 +1000
Message-Id: <1180431850.19517.146.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Steve Munroe <sjmunroe@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> - do you use the standard 32 bit ABI, in which case the caller of libraries
>   does not care and the libraries can be put in the standard places, or are
>   there cases where the ability to pass 64 bit values in a single
>   register would improve performance to the point that it is worth
>   having an incompatible library (where to put it and how to name it)? 
>   
>   I'd rather lean towards the first solution but I don't have enough
>   data to judge. 
> 
> - how can an application know that it can use 64 bit registers and call
>   the optimized routines?

I'd say use the 32 bits ABI, AT_HWCAP will tell you if you are running
on a 64 bits capable machine. You can then either use hand tuned code at
runtime, or I think ld.so can load alternate libs based on the bits in
there.

> Finally, I've not seen a compiler (well, GCC, but I don't have 4.2 or 
> 4.3 installed yet) that allows you to tell the compiler to use 32 bit
> addresses but assume that integer registers are 64 bit wide. As long
> as such an option does not exist, the usefulness of this feature is
> somewhat limited. In other words, GCC for now has support for ILP32 and
> LP64 modes, but it would be better to also have support for IP32L64.

Depends... If such binaries are actual 64 bits binaries from a kernel
POV, then no change is necessary.

> Have you considered the case of a mixed (IP32L64) mode calling a pure
> 32 bit library (or a user provided callback). The high part of R13-R31
> will also be clobbered. Therefore the caller has to save and restore 
> all registers that are live around the call, which results in
> significant code bloat and needs compiler support.

Yes. The high parts are call clobbered. Either you use C code and you'll
need some new gcc options to use this mode, or, as it's mostly the
request for now, you use hand tuned asm code and you know what you are
doing.

> All of this of course unless all people who write mixed mode code
> are masochistic enough to limit themselves to 100% pure assembly... 

:-)

Ben.
